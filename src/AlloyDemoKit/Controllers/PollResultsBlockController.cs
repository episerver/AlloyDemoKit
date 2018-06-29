using System;
using System.Web.Mvc;
using EPiServer.Forms.Core;
using EPiServer.Forms.Core.Data;
using EPiServer.Forms.Core.Models;
using EPiServer.Web.Mvc;
using AlloyDemoKit.Models.Blocks;
using AlloyDemoKit.Models.ViewModels;

namespace newforms.Controllers
{
    public class PollResultsBlockController : BlockController<PollResultsBlock>
    {
        private readonly IFormRepository _formRepository;
        private readonly IFormDataRepository _formDataRepository;
        public PollResultsBlockController(IFormRepository formRepository, IFormDataRepository submittedFormsRepository)
        {
            _formRepository = formRepository;
            _formDataRepository = submittedFormsRepository;
        }

        public override ActionResult Index(PollResultsBlock currentBlock)
        {
            var formData =_formDataRepository.GetSubmissionData(
                new FormIdentity(GetFormId(currentBlock.FormField), "en"), 
                DateTime.Now.AddYears(-1),
                DateTime.Now.AddYears(1));

            var model = new PollResultsBlockViewModel();
            foreach (var submission in formData)
            {
                var formValue = submission.Data[GetFieldId(currentBlock.FormField)].ToString();
                if (model.PollResults.ContainsKey(formValue))
                {
                    model.PollResults[formValue]++;
                }
                else
                {
                    model.PollResults.Add(formValue, 1);
                }
            }

            model.Title = currentBlock.PollTitle;

            // ReSharper disable once Mvc.PartialViewNotResolved
            return PartialView(model);
        }

        private Guid GetFormId(string value)
        {
            Guid.TryParse(value.Split(">".ToCharArray())[0].Trim(), out Guid formIdGuid);
            return formIdGuid;
        }

        private string GetFieldId(string value)
        {
            var formField = value.Split(">".ToCharArray());
            if (formField.Length == 2)
            {
                return formField[1].Trim();
            }
            else
            {
                return string.Empty;
            }
        }
    }

      
}