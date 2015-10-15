using AlloyDemoKit.Models.Pages;
using EPiServer;
using EPiServer.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Business.Employee
{
    /// <summary>
    /// Finds the Container index
    /// </summary>
    public class EmployeeContainerLookup
    {
        private IContentRepository _contentRepository;
        private Dictionary<string, int> AlphabeticalLookups { get; set; }

        public EmployeeContainerLookup(IContentRepository repo)
        {
            _contentRepository = repo;

            AlphabeticalLookups = new Dictionary<string, int>(26);
            var allContainers = _contentRepository.GetChildren<ContainerPage>(EmployeeContainerRootPage).ToList();

            for (int i = 1; i <= 26; i++)
            {
                string letter = Convert.ToChar(64 + i).ToString();
                int reference = CreateOrFindFolder(letter, allContainers);
                AlphabeticalLookups.Add(letter, reference);
            }
        }

        private int CreateOrFindFolder(string letter, List<ContainerPage> allContainers)
        {
            int pageReference = -1;
            var existing = allContainers.Where(l => l.Name == letter).FirstOrDefault();
            if (existing != null)
            {
                pageReference = existing.ContentLink.ID;
            }
            else
            {
                pageReference = CreateLetterContainer(letter);
            }

            return pageReference;
        }

        private int CreateLetterContainer(string letter)
        {
            var newPage = _contentRepository.GetDefault<ContainerPage>(EmployeeContainerRootPage);
            newPage.Name = letter;
            _contentRepository.Save(newPage, EPiServer.DataAccess.SaveAction.Publish);

            return newPage.ContentLink.ID;
        }

        


        public int GetIndex(string letter)
        {
            int index = -1;

            if (letter == "Ö")
            {
                letter = "O";
            }

            if (AlphabeticalLookups.ContainsKey(letter))
            {
                index = AlphabeticalLookups[letter];   
            }

            return index;
        }

        
        



        public T GetExistingPage<T>(ContentReference startingFolder, string pageName) where T : IContent
        {
            var childPages = _contentRepository.GetChildren<T>(startingFolder);
            T selectedPage = childPages.Where(x => x.Name == pageName).FirstOrDefault();

            return selectedPage;
        }

        public ContentReference EmployeeContainerRootPage
        {
            get
            {
                ContentReference pageReference = _contentRepository.Get<StartPage>(ContentReference.StartPage).EmployeeContainerPageLink;
                return pageReference;
            }
        }

        public ContentReference EmployeeLocationRootPage
        {
            get
            {
                ContentReference pageReference = _contentRepository.Get<StartPage>(ContentReference.StartPage).EmployeeLocationPageLink;
                return pageReference;
            }
        }

        public ContentReference EmployeeSpecialityRootPage
        {
            get
            {
                ContentReference pageReference = _contentRepository.Get<StartPage>(ContentReference.StartPage).EmployeeExpertiseLink;
                return pageReference;
            }
        }

        
    }
}