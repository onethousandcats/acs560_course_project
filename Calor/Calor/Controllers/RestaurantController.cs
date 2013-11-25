using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Calor.Controllers
{
    public class RestaurantController : ApiController
    {

        //Add model context
        Models.modelContainer _m = new Models.modelContainer()

        public IEnumerable<string> Get()
        {
            
            return new string[] { "value1", "value2" };
        }

        // GET api/restaurant/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/restaurant
        public void Post([FromBody]string value)
        {
        }

        // PUT api/restaurant/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/restaurant/5
        public void Delete(int id)
        {
        }
    }
}
