using Newtonsoft.Json;
using System.Linq;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using EPiServer;
using EPiServer.Framework.Cache;
using System;

namespace AlloyDemoKit.Business.Parking
{
    public class ParkingGateway
    {

        //private JavaScriptSerializer _serializer;
        private readonly string _feedUrl;
        private const string LocationsCacheKey = "ParkingGarageNames";
        private const string GaragesCacheKey = "ParkingGarages";

        public ParkingGateway()
        {
          //  _serializer = new JavaScriptSerializer();
            _feedUrl = ConfigurationManager.AppSettings["ParkingFeedUrl"];
            Garages = null;
        }


        public IEnumerable<string> GetLocations()
        {
            CacheEvictionPolicy policy = new CacheEvictionPolicy(TimeSpan.FromMinutes(2), CacheTimeoutType.Absolute);


            if (!(CacheManager.Get(LocationsCacheKey) is List<string> items))
            {
                items = LocationsFromService();
                CacheManager.Insert(LocationsCacheKey, items, policy);
            }

            return items;
        }

        private List<string> LocationsFromService()
        {
            List<string> items = new List<string>();

            using (var client = new HttpClient())
            {
                var json = client.GetStringAsync(_feedUrl);
                dynamic results = JsonConvert.DeserializeObject(json.Result);

                foreach (var item in results)
                {
                    items.Add(item.name.Value);
                }
            }

            items.Sort();

            return items;
        }

        private List<ParkingGarage> Garages
        {
            get; set;

        }

        public ParkingGarage GetParkingGarage(string name)
        {
            if (Garages == null)
            {
                RetrieveGarages();
            }

            return Garages.Where(g => string.Compare(g.Name, name, true) == 0)
                          .FirstOrDefault();
        }

        private void RetrieveGarages()
        {
            CacheEvictionPolicy policy = new CacheEvictionPolicy(TimeSpan.FromMinutes(4), CacheTimeoutType.Sliding);


            if (!(CacheManager.Get(LocationsCacheKey) is List<ParkingGarage> allGarages))
            {

                allGarages = new List<ParkingGarage>();

                using (var client = new HttpClient())
                {
                    var json = client.GetStringAsync(_feedUrl);
                    dynamic results = JsonConvert.DeserializeObject(json.Result);


                    foreach (var item in results)
                    {
                        string jsonItem = item.ToString().Replace("\r\n", "");
                        ParkingGarage garage = JsonConvert.DeserializeObject<ParkingGarage>(jsonItem);
                        allGarages.Add(garage);

                    }
                }

                CacheManager.Insert(LocationsCacheKey, allGarages, policy);
            }

            Garages = allGarages;            

        }
    }
}
