using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;
using EPiServer.Personalization;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.Util.PlugIns;
using System.Web.UI;
using AlloyDemoKit.Business.DDS;
using AlloyDemoKit.Business.Employee;
using System.IO;
using System.Web;

namespace AlloyDemoKit.AdminTools
{
    [GuiPlugIn(DisplayName = "Employee Settings", Description = "Sets Employee Import Files", Area = PlugInArea.AdminConfigMenu, Url = "~/AdminTools/EmployeeSettings.aspx")]
    public partial class EmployeeSettings : System.Web.UI.Page
    {
        private const string AppDataPath = "App_Data";
        EmployeeSettingsHandler _handler = new EmployeeSettingsHandler();
        DataGenerator _dataGenerator = new DataGenerator();

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!Page.IsPostBack)
            {
                BindSettings();
            }  
        }

        private void BindSettings()
        {
            EmployeeSettingsModel model = _handler.RetrieveSettings();
            if (model != null)
            {
                EmployeeFileName.Text = model.ImportFileName;
                LocationsFileName.Text = model.LocationsFileName;
                ExpertiseFileName.Text = model.ExpertiseFileName;
            }
        }
        
        protected void FullRegion_MainRegion_Create_Click(object sender, EventArgs e)
        {
            DataGenerator generator = new DataGenerator();
            string employeeDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, AppDataPath, EmployeeFileName.Text);
            string locationDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, AppDataPath, LocationsFileName.Text);
            string expertiseDataFile = Path.Combine(HttpRuntime.AppDomainAppPath, AppDataPath, ExpertiseFileName.Text);

            generator.GenerateExpertiseFile(expertiseDataFile);
            generator.GenerateLocationsFile(locationDataFile);
            generator.GenerateDataFile(employeeDataFile);

            OutputMessage.Text = "Data files have been generated.";
        }

        protected void FullRegion_MainRegion_Save_Click(object sender, EventArgs e)
        {
           
            EmployeeSettingsModel model = new EmployeeSettingsModel()
            {
                ImportFileName = EmployeeFileName.Text,
                LocationsFileName = LocationsFileName.Text,
                ExpertiseFileName = ExpertiseFileName.Text
            };

            _handler.SaveSettings(model);

            OutputMessage.Text = "Changes have been saved.";
        }
    }
}