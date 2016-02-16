using System;
using System.Collections.Generic;
using EPiServer.Shell.ObjectEditing;
using EPiServer.Shell.ObjectEditing.EditorDescriptors;

namespace AlloyDemoKit.Business.EditorDescriptors
{
    /// <summary>
    /// Registers an editor to select a ContactPage for a PageReference property using a dropdown
    /// </summary>
    [EditorDescriptorRegistration(TargetType = typeof(string), UIHint = Global.SiteUIHints.Parking)]
    public class ParkingGarageSelector : EditorDescriptor
    {
        public override void ModifyMetadata(ExtendedMetadata metadata, IEnumerable<Attribute> attributes)
        {
            SelectionFactoryType = typeof(ParkingSelectionFactory);
            
            ClientEditingClass = "epi-cms/contentediting/editors/SelectionEditor";
  
            base.ModifyMetadata(metadata, attributes);
        }
    }
}
