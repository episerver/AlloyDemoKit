using EPiServer.Data.Dynamic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.Pages.Tags
{
    public class TagRepository
    {
        private static TagRepository _instance;
 
        public TagRepository()
        {
        }
 
        public static TagRepository Instance
        {
            get { return _instance ?? (_instance = new TagRepository()); }
        }
 
        private static DynamicDataStore Store
        {
            get { return typeof(TagItem).GetStore(); }
        }

        public void SaveTags(IEnumerable<TagItem> tags)
        {
            foreach (var item in tags)
            {
                SaveTag(item);
            }

        }
 
        public bool SaveTag(TagItem tag)
        {
            try
            {
                var currentTags = LoadTag(tag);
                if (currentTags == null)
                {
                    currentTags = tag;
                }
                else
                {
                    currentTags.TagName = tag.TagName;
                    currentTags.Count = tag.Count;
                    currentTags.Weight = tag.Weight;
                }



                Store.Save(currentTags);
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        public void IncreaseTagCount(TagItem tag)
        {
            tag.Count++;

            SaveTag(tag);
        }
 
        public IEnumerable<TagItem> LoadTags()
        {
            var list = Store.Items<TagItem>();
            if (list != null)
            {

               var count= list.ToList().Count;

                return list;
            }
            else
            {
                return new List<TagItem>();
            }
        }

        public TagItem LoadTag(TagItem tag)
        {
            return LoadTags().Where(x => x.TagName == tag.TagName).FirstOrDefault();          
        }
    
    }
}