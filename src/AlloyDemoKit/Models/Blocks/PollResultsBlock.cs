using AlloyDemoKit.Business.Forms;
using EPiServer.DataAbstraction;
using EPiServer.Shell.ObjectEditing;
using System.ComponentModel.DataAnnotations;

namespace AlloyDemoKit.Models.Blocks
{
    /// <summary>
    /// Used to insert a link which is styled as a button
    /// </summary>
    [SiteContentType(GUID = "EE7F2843-BB2C-4148-BC3D-099B2D7FD5CB")]
    [SiteImageUrl]
    public class PollResultsBlock : SiteBlockData
    {
        [Display(Order = 1, GroupName = SystemTabNames.Content)]
        [Required]
        public virtual string PollTitle { get; set; }

        [Display(Order = 2, GroupName = SystemTabNames.Content)]
        [Required]
        [SelectOne(SelectionFactoryType = typeof(FormFieldSelectionFactory))]
        public virtual string FormField { get; set; }
    }
}
