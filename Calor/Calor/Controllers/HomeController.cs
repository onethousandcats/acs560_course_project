using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Calor.Models;

namespace Calor.Controllers
{
    public class HomeController : Controller
    {
        private DB_48226_calorEntities _m = new DB_48226_calorEntities();

        public ActionResult Index()
        {
            HomeWrapper h = new HomeWrapper();

            h.Restaurants = _m.Restaurants;

            return View(h);
        }
    }
}
