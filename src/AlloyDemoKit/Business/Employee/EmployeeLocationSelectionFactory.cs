using AlloyDemoKit.Models.Pages;
using EPiServer.Find.Framework;
using EPiServer.Shell.ObjectEditing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Find;
using EPiServer.Find.Framework;
using EPiServer.Find.Cms;

namespace AlloyDemoKit.Business.Employee
{
    public class EmployeeLocationSelectionFactory : ISelectionFactory
    {
        public IEnumerable<ISelectItem> GetSelections(ExtendedMetadata metadata)
        {
            var results = SearchClient.Instance.Search<EmployeeLocationPage>()
                .OrderBy(x => x.Name)
                .Take(1000)
                .GetContentResult();

            List<SelectItem> items = new List<SelectItem>();
            foreach(var result in results)
            {
                items.Add(new SelectItem() { Text = result.Name, Value = result.Name });
            }

            return items;
        }
    }
}