using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AlloyDemoKit.Models.ViewModels
{
    public class ParkingViewModel
    {
        public string Heading { get; set; }
        public string Location { get; set; }
        public string Address { get; set; }
        public int TotalCapacity { get; set; }
        public int AvailableCapacity { get; set; }
        public DateTime LastUpdated { get; set; }
        private bool isOpen;

        public bool IsOpen { 
            get { return isOpen; }
            set
            {
                isOpen = value;
                OpenMessage = value ? "Open" : "Closed";
            }
        }

        public string OpenMessage
        { get; private set; }
    }
}
