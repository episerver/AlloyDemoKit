using EPiServer.Framework.Localization;
using EPiServer.ServiceLocation;
using EPiServer.Web;

namespace AlloyDemoKit.Business.Channels
{
    /// <summary>
    /// Base class for all resolution definitions
    /// </summary>
    public abstract class DisplayResolutionBase : IDisplayResolution
    {
        private Injected<LocalizationService> LocalizationService { get; set; }
        /// <summary>
        /// Initializes a new instance of the <see cref="DisplayResolutionBase"/> class.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="width">The width in pixels.</param>
        /// <param name="height">The height in pixels.</param>
        protected DisplayResolutionBase(string name, int width, int height)
        {
            Id = GetType().FullName;
            Name = Translate(name);
            Width = width;
            Height = height;
        }

        /// <summary>
        /// Gets the unique ID for this resolution
        /// </summary>
        public string Id { get; protected set; }

        /// <summary>
        /// Gets the name of resolution
        /// </summary>
        public string Name { get; protected set; }

        /// <summary>
        /// Gets the resolution width in pixels
        /// </summary>
        public int Width { get; protected set; }

        /// <summary>
        /// Gets the resolution height in pixels
        /// </summary>
        public int Height { get; protected set; }

        private string Translate(string resurceKey)
        {

            if (!LocalizationService.Service.TryGetString(resurceKey, out string value))
            {
                value = resurceKey;
            }

            return value;
        }
    }
}
