using EPiServer.Shell.ObjectEditing.EditorDescriptors;

namespace AlloyDemoKit.Business.EditorDescriptors
{
    [EditorDescriptorRegistration(TargetType = typeof(string), UIHint = UIHint)]
    public class CoordinatesEditorDescriptor : EditorDescriptor
    {
        public const string UIHint = "CoordinatesEditorDescriptor";

        public CoordinatesEditorDescriptor()
        {
            ClientEditingClass = "tedgustaf.googlemaps.Editor";
        }
    }
}
