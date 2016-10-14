using EPiServer.Core;
using EPiServer.DataAnnotations;
using EPiServer.Framework.DataAnnotations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.Media
{
    [ContentType(GUID="58341C80-E78F-4F83-AF11-3B48563B41CA")]
    [MediaDescriptor(ExtensionString = "pdf")]
    public class PDFFile : MediaData, IFileProperties
    {
        ///// <summary>
        ///// Gets or sets the description.
        ///// </summary>
        //public virtual String Title { get; set; }

        [Editable(false)]
        public virtual string FileSize { get; set; }
    }

}


