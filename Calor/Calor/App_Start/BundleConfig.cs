using System.Web;
using System.Web.Optimization;

namespace Calor
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/scripts").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/bootstrap.js",
                        "~/Scripts/ajaxchosen.js",
                        "~/Scripts/chosen.js",
                        "~/Scripts/bootstrap-datepicker.js",
                        "~/Scripts/fullcalendar.js",
                        "~/Scripts/main.js",
                        "~/Scripts/amcharts.js",
                        "~/Scripts/pie.js"
                        ));

            bundles.Add(new StyleBundle("~/css").Include(
                        "~/Content/bootstrap.css",
                        "~/Content/chosen.css",
                        "~/Content/bootstrap-datepicker.css",
                        "~/Content/fullcalendar.css",
                        "~/Content/site.css"
                        ));
        }
    }
}