using EPiServer.Shell.ObjectEditing;
using EPiServer.Shell.ObjectEditing.EditorDescriptors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Business.Employee
{
    [EditorDescriptorRegistration(TargetType = typeof(string), UIHint = UIHintsEmployee.EmployeeLocation)]
    public class EmployeeLocationSelector : EditorDescriptor
    {
        public override void ModifyMetadata(ExtendedMetadata metadata, IEnumerable<Attribute> attributes)
        {
            SelectionFactoryType = typeof(EmployeeLocationSelectionFactory);

            ClientEditingClass = "epi-cms/contentediting/editors/SelectionEditor";

            base.ModifyMetadata(metadata, attributes);
        }
    }

    public static class UIHintsEmployee
    {
        public const string EmployeeLocation = "EmployeeLocation";
    }
}