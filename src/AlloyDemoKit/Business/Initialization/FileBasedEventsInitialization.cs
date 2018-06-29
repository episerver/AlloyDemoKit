using System;
using System.Linq;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.ServiceLocation;
using EPiServer.Core;
using AlloyDemoKit.Business.Data;
using AlloyDemoKit.Models.Media;

namespace AlloyDemoKit.Business.Initialization
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class FileBasedEventsInitialization : IInitializableModule
    {
        public void Initialize(InitializationEngine context)
        {
            var eventRegistry =
            ServiceLocator.Current.GetInstance<IContentEvents>();

            eventRegistry.CreatingContent += SavingMediaFile;
            eventRegistry.SavingContent += SavingMediaFile;
        }

        private void SavingMediaFile(object sender, EPiServer.ContentEventArgs e)
        {
            if (!(e.Content is MediaData content))
                return;
            var fs = FileReader.GetFileSize(content);

            var mediaFile = content as IFileProperties;
            mediaFile.FileSize = fs;
        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context)
        {
            var eventRegistry =
           ServiceLocator.Current.GetInstance<IContentEvents>();

            eventRegistry.CreatingContent -= SavingMediaFile;
            eventRegistry.SavingContent -= SavingMediaFile;
        }
    }
}