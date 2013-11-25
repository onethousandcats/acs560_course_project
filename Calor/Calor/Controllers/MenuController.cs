using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Calor.Models;

namespace Calor.Controllers
{
    public class MenuController : ApiController
    {
        private DB_48226_calorEntities _m = new DB_48226_calorEntities();

        public IEnumerable<String> GetMenu(int id)
        {
            var _menu = _m.Items.Where(o => o.RestaurantId == id);

            List<String> _names = new List<string>();

            foreach (Item i in _menu)
            {
                _names.Add(i.Name);
            }

            return _names;
        }

    }
}
