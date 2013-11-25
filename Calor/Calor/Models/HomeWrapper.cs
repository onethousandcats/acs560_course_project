using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Calor.Models
{
    public class HomeWrapper
    {
        public string RestName { get; set; }
        public string ItemName { get; set; }

        public IEnumerable<Restaurant> Restaurants { get; set; }
        public IEnumerable<Item> Items { get; set; }

    }
}