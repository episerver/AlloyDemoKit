using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Xml.Linq;

using MyProject.Delegate.Models.ViewModels;
using EPiServer.Web.Mvc;
using AlloyDemoKit.Models.Blocks;

namespace MyProject.Tekna.Controllers
{
    public class RssReaderBlockController : BlockController<RssReaderBlock>
    {
        public override ActionResult Index(RssReaderBlock currentBlock)
        {
            var viewModel = new RssReaderBlockViewModel
            {
                RssList = new List<RssReaderBlockViewModel.RssItem>(),
                CurrentBlock = currentBlock
            };

            try
            {
                if ((currentBlock.RssUrl != null) && (!currentBlock.RssUrl.IsEmpty()))
                {
                    var rssDocument = XDocument.Load(Convert.ToString(currentBlock.RssUrl));

                    var posts = from item in rssDocument.Descendants("item").Take(currentBlock.MaxCount)
                                select new RssReaderBlockViewModel.RssItem
                                {
                                    Title = item.Element("title").Value,
                                    Url = item.Element("link").Value,
                                    PublishDate = item.Element("pubDate").Value,
                                };

                    viewModel.RssList = posts.ToList();
                    viewModel.HasHeadingText = HasHeadingText(currentBlock);
                    viewModel.Heading = currentBlock.Heading;
                    viewModel.DescriptiveText = currentBlock.DescriptiveText;
                }
            }
            catch (System.Net.WebException)
            {

            }
            catch (System.IO.FileNotFoundException)
            {

            }


            return PartialView("~/Views/RssReaderBlock/Index.cshtml", viewModel);
        }

        private bool HasHeadingText(RssReaderBlock currentBlock)
        {
            return ((!string.IsNullOrEmpty(currentBlock.Heading)) || ((currentBlock.DescriptiveText != null) && (!currentBlock.DescriptiveText.IsEmpty)));
        }
    }
}
