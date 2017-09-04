using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Shell.ObjectEditing;

namespace AlloyDemoKit.Business
{
    public class ContentCreateMetadataExtender : IMetadataExtender
    {
        public void ModifyMetadata(ExtendedMetadata metadata, IEnumerable<Attribute> attributes)
        {
            // When content is being created the content link is 0
            if (((EPiServer.Core.PageData)metadata.Model).ContentLink.ID == 0)
            {
                foreach (ExtendedMetadata property in metadata.Properties)
                {
                    // The content is being created, so set required = false
                    if (property.Attributes.OfType<HideOnContentCreateAttribute>().Any())
                    {
                        property.IsRequired = false;
                    }
                }
            }
        }
    }
}