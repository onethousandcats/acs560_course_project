using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Calor.Models;

namespace Calor.Controllers
{
    public class RestaurantsController : ApiController
    {
        private DB_48226_calorEntities _m = new DB_48226_calorEntities();

        public IEnumerable<String> GetAllRestaurants()
        {
            var _r = _m.Restaurants.Take(10);

            List<String> _names = new List<string>();

            foreach (Restaurant r in _r)
            {
                _names.Add(r.Name);
            }

            return _names;
        }

    }
}
