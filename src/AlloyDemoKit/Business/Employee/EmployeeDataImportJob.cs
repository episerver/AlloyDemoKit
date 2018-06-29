using System;
using EPiServer.Core;
using EPiServer.PlugIn;
using EPiServer.BaseLibrary.Scheduling;
using AlloyDemoKit.Business.Data;
using EPiServer.ServiceLocation;
using System.Configuration;
using AlloyDemoKit.Models.Pages;
using EPiServer;
using System.Web;
using System.IO;
using AlloyDemoKit.Business.DDS;

namespace AlloyDemoKit.Business.Employee
{
    [ScheduledPlugIn(DisplayName = "Employee Data Import", DefaultEnabled = true, Description = "Imports employee data from tab-delimited file")]
    public class EmployeeDataImportJob : EPiServer.Scheduler.ScheduledJobBase
    {
        private bool _stopSignaled;
        private string _employeeDataFile;
        private string _locationDataFile;
        private string _expertiseDataFile;
        private readonly char[] TabDelimiter = new[] {'\t'};

        public EmployeeDataImportJob()
        {
            IsStoppable = true;
        }

        /// <summary>
        /// Called when a user clicks on Stop for a manually started job, or when ASP.NET shuts down.
        /// </summary>
        public override void Stop()
        {
            _stopSignaled = true;
        }

        /// <summary>
        /// Called when a scheduled job executes
        /// </summary>
        /// <returns>A status message to be stored in the database log and visible from admin mode</returns>
        public override string Execute()
        {
            SetFilePaths();
            
            //Call OnStatusChanged to periodically notify progress of job for manually started jobs
            OnStatusChanged(String.Format("Starting execution of {0}", this.GetType()));

            //Add implementation
            IFileDataImporter fileImporter = ServiceLocator.Current.GetInstance<IFileDataImporter>();
            IContentRepository contentRepo = ServiceLocator.Current.GetInstance<IContentRepository>();
            EmployeeContainerLookup lookup = new EmployeeContainerLookup(contentRepo);
           

            if (fileImporter.ImportFileExists(_locationDataFile))
            {
                ImportLocations(fileImporter, contentRepo, lookup);
                OnStatusChanged("Finished importing Locations");
            }

            if (fileImporter.ImportFileExists(_expertiseDataFile) && !_stopSignaled)
            {
                ImportExpertise(fileImporter, contentRepo, lookup);
                OnStatusChanged("Finished importing Expertise");   
            }

            if (fileImporter.ImportFileExists(_employeeDataFile) && !_stopSignaled)
            {
                ImportEmployees(fileImporter, contentRepo, lookup);
                OnStatusChanged("Finished importing Employees");
            }
           
            if (_stopSignaled)
            {
                return "Stop of job was called";
            }

            return "Employee Data Import completed";
        }

        private void SetFilePaths()
        {
            EmployeeSettingsHandler settingsHandler = new EmployeeSettingsHandler();
            var settings = settingsHandler.RetrieveSettings();
            _employeeDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, "App_Data", settings.ImportFileName);
            _locationDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, "App_Data", settings.LocationsFileName);
            _expertiseDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, "App_Data", settings.ExpertiseFileName);
        }

        private void ImportEmployees(IFileDataImporter fileImporter, IContentRepository contentRepo, EmployeeContainerLookup lookup)
        {
            string[] allEmployees = fileImporter.RetrieveAllData(_employeeDataFile);

            foreach (string employeeRow in allEmployees)
            {

                string[] fields = fileImporter.SplitByDelimiter(employeeRow, TabDelimiter);
                if (!string.IsNullOrWhiteSpace(fields[2]))
                {
                    string firstLetter = fields[2].Substring(0, 1).ToUpper();
                    string pageName = string.Format("{0}, {1}", fields[2], fields[1]);

                    int pageReference = lookup.GetIndex(firstLetter);

                    ContentReference startingFolder = new ContentReference(pageReference);

                    EmployeePage page = lookup.GetExistingPage<EmployeePage>(startingFolder, pageName);

                    if (page != null)
                    {
                        page = page.CreateWritableClone() as EmployeePage;
                    }
                    else
                    {
                        page = contentRepo.GetDefault<EmployeePage>(startingFolder);
                    }

                    MapFields(fields, page);
                    page.Name = pageName;
                    

                    contentRepo.Save(page, EPiServer.DataAccess.SaveAction.Publish);
                }
                //For long running jobs periodically check if stop is signaled and if so stop execution
                if (_stopSignaled)
                {
                    break;
                }
            }
        }

        private void ImportLocations(IFileDataImporter fileImporter, IContentRepository contentRepo, EmployeeContainerLookup lookup)
        {
            string[] allLocations = fileImporter.RetrieveAllData(_locationDataFile);
            ContentReference locationRoot = lookup.EmployeeLocationRootPage;
            foreach (string location in allLocations)
            {
                EmployeeLocationPage locationPage = lookup.GetExistingPage<EmployeeLocationPage>(locationRoot, location);
                if (locationPage == null)
                {
                    locationPage = contentRepo.GetDefault<EmployeeLocationPage>(locationRoot);
                    locationPage.Name = location;

                    contentRepo.Save(locationPage, EPiServer.DataAccess.SaveAction.Publish);

                    //For long running jobs periodically check if stop is signaled and if so stop execution
                    if (_stopSignaled)
                    {
                        break;
                    }
                }
            }
        }

        private void ImportExpertise(IFileDataImporter fileImporter, IContentRepository contentRepo, EmployeeContainerLookup lookup)
        {
            string[] allExpertise = fileImporter.RetrieveAllData(_expertiseDataFile);
            ContentReference expertiseRoot = lookup.EmployeeSpecialityRootPage;
            foreach (string expertise in allExpertise)
            {
                EmployeeExpertise expertisePage = lookup.GetExistingPage<EmployeeExpertise>(expertiseRoot, expertise);
                if (expertisePage == null)
                {
                    expertisePage = contentRepo.GetDefault<EmployeeExpertise>(expertiseRoot);
                    expertisePage.Name = expertise;

                    contentRepo.Save(expertisePage, EPiServer.DataAccess.SaveAction.Publish);

                    //For long running jobs periodically check if stop is signaled and if so stop execution
                    if (_stopSignaled)
                    {
                        break;
                    }
                }
            }
        }


        private static void MapFields(string[] fields, EmployeePage page)
        {
            page.EmployeeID = fields[0];
            page.FirstName = fields[1];
            page.LastName = fields[2];
            page.Phone = fields[3];
            page.Email = fields[4];
            page.JobTitle = fields[5];
            page.EmployeeLocation = fields[6];
            page.EmployeeExpertise = fields[7];
            page.Description = new XhtmlString(fields[8]);
            page.ImageUrl = fields[9];
        }
    }
}
