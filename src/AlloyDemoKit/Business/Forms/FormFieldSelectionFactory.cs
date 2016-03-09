using EPiServer.Forms.Core;
using EPiServer.Forms.Core.Models;
using EPiServer.ServiceLocation;
using EPiServer.Shell.ObjectEditing;
using System.Collections.Generic;

namespace AlloyDemoKit.Business.Forms
{
    public class FormFieldSelectionFactory : ISelectionFactory
    {
        private Injected<IFormRepository> _formRepository;

        public IEnumerable<ISelectItem> GetSelections(ExtendedMetadata metadata)
        {
            List<SelectItem> items = new List<SelectItem>();

            foreach (var form in _formRepository.Service.GetFormsInfo(null))
            {
                var mappings = _formRepository.Service.GetFieldMappings(new FormIdentity(form.FormGuid, "en"));
                foreach (var fieldMapping in mappings)
                {
                    if (!fieldMapping.Name.StartsWith("SYS"))
                    {
                        items.Add(new SelectItem
                        {
                            Text = form.Name + " > " + fieldMapping.FriendlyName,
                            Value = form.FormGuid.ToString() + " > " + fieldMapping.Name
                        });
                    }
                }
            }

            return items;
        }
    }
}
