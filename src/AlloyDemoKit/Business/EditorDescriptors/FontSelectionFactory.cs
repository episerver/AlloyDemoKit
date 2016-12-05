using System;
using System.Collections.Generic;
using EPiServer.Shell.ObjectEditing;

namespace AlloyDemoKit.Business.EditorDescriptors
{
    internal class FontSelectionFactory : ISelectionFactory
    {
        public IEnumerable<ISelectItem> GetSelections(ExtendedMetadata metadata)
        {
            return new List<SelectItem>()
            {
                new SelectItem() { Value = "", Text = "None" },
                new SelectItem() { Value = "Acme", Text = "Acme" },
                new SelectItem() { Value = "Basic", Text = "Basic" },
                new SelectItem() { Value = "Cabin", Text = "Cabin" },
                new SelectItem() { Value = "Comfortaa", Text = "Comfortaa" },
                new SelectItem() { Value = "Convergence", Text = "Convergence" },
                new SelectItem() { Value = "Economica", Text = "Economica" },
                new SelectItem() { Value = "Heebo", Text = "Heebo" },
                new SelectItem() { Value = "Jaldi", Text = "Jaldi" },
                new SelectItem() { Value = "Marvel", Text = "Marvel" },
                new SelectItem() { Value = "Maven+Pro", Text = "Maven Pro" },
                new SelectItem() { Value = "PT+Sans", Text = "PT Sans" },
                new SelectItem() { Value = "Quattrocento+Sans", Text = "Quattrocento Sans" },
                new SelectItem() { Value = "Raleway", Text = "Raleway" },
                new SelectItem() { Value = "Ubuntu", Text = "Ubuntu" }
            };
        }
    }
}