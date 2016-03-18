using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Forms.Implementation.Elements;

namespace AlloyDemoKit.Models.Blocks.FormElements
{
    [ContentType(DisplayName = "Styled TextBox", GUID = "803fae12-9485-466d-917b-8daa77d1d214", Description = "Provides a Textbox element with additional css styling", GroupName = "Specialised Elements", Order = 100)]
    public class StyledTextBoxElementBlock : TextboxElementBlock
    {
        
        [Display(
            Description = "CSS class for the textbox",
            GroupName = SystemTabNames.Content,
            Order = 100)]
        public virtual String Class { get; set; }
        
    }
}