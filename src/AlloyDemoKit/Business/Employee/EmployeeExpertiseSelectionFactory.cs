using System.Collections.Generic;
using System.Linq;
using AlloyDemoKit.Models.Pages;
using EPiServer.Find;
using EPiServer.Find.Cms;
using EPiServer.Find.Framework;
using EPiServer.Shell.ObjectEditing;

namespace AlloyDemoKit.Business.Employee
{
    public class EmployeeExpertiseSelectionFactory : ISelectionFactory
    {
                public IEnumerable<ISelectItem> GetSelections(ExtendedMetadata metadata)
        {
            var results = SearchClient.Instance.Search<EmployeeExpertise>()
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