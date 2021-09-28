using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.UI;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
    public Helper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static string GetCSSPath()
    {
        return GetAppName() + "/StyleSheets/Style1.css";

    }

    public static string GetAppName()
    {
        //return System.Configuration!System.Configuration.ConfigurationManager.AppSettings.Get("ApplicationName");
        return System.Configuration.ConfigurationManager.AppSettings.Get("ApplicationName");
    }

    public static System.Drawing.Color GetColor(string color)
    {
        switch (color.ToUpper())
        {
            case "RED":
            case "ORANGE":
                return System.Drawing.Color.Orange;
               
            case "GREEN":
                return System.Drawing.Color.Green;
                
            case "YELLOW":
                return System.Drawing.Color.Yellow;
               
            default:
                return System.Drawing.Color.Empty;
        }
    }

    public static void PageRedirect(System.Web.UI.Page obj, string strURL)
    {
        try
        {
            obj.Response.Redirect(strURL, true);
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            string exe = ex.ToString();
        }
    }
}
 
     