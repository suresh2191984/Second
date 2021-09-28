<%@ Application Language="C#" %>

<script runat="server">

    
    void Application_Start(object sender, EventArgs e) 
    {
        foreach (System.Collections.DictionaryEntry entry in HttpContext.Current.Cache)
        {
            HttpContext.Current.Cache.Remove(entry.Key.ToString());
        }
        HttpContext.Current.Application.RemoveAll();

    }
    void Application_Error(object sender, EventArgs e) 
    {
       // string sSource;
       // string sLog;
       // string sEvent;

       // sSource = "Attune_Health";
       // sLog = "AttuneLog"; 
       //sEvent=Server.GetLastError().ToString();

       // if (!System.Diagnostics.EventLog.SourceExists(sSource))
       //     System.Diagnostics.EventLog.CreateEventSource(sSource, sLog);

       // System.Diagnostics.EventLog.WriteEntry(sSource, sEvent);
       Attune.Kernel.PlatForm.Utility.CLogger.LogError("Application Error", Server.GetLastError());
    
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
    void Application_BeginRequest(object sender, EventArgs e)
    {
        //Response.Write(new DateTimeUtility().GetServerDate().ToString());
        HttpCookie cookie = Request.Cookies["CultureInfo"];
        if (cookie != null && !string.IsNullOrEmpty(cookie.Value))
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(cookie.Value);
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(cookie.Value);
        }
        else
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("en-GB");
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");
        }
        if (System.Threading.Thread.CurrentThread.CurrentCulture.ToString() != "en-GB")
        {
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.Calendar = new System.Globalization.GregorianCalendar();
            //System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.Calendar = new System.Globalization.GregorianCalendar(System.Globalization.GregorianCalendarTypes.USEnglish);
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.AMDesignator = "AM";
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.PMDesignator = "PM";
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.DateSeparator = "/";
            System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat.NumberDecimalSeparator = ".";
            System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat.NumberGroupSeparator  = ",";

            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.Calendar = new System.Globalization.GregorianCalendar();
            //System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.Calendar = new System.Globalization.GregorianCalendar(System.Globalization.GregorianCalendarTypes.USEnglish);
            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.AMDesignator = "AM";
            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.PMDesignator = "PM";
            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.DateSeparator = "/";
            System.Threading.Thread.CurrentThread.CurrentUICulture.NumberFormat.NumberDecimalSeparator = ".";
            System.Threading.Thread.CurrentThread.CurrentUICulture.NumberFormat.NumberGroupSeparator = ",";
            //System.Threading.Thread.CurrentThread.CurrentUICulture.DateTimeFormat.NativeCalendarName="Gregorion Calender";
        }

        HttpCookie CSGuid = Request.Cookies["CSGuid"];
        if (CSGuid != null)
        {
            if (!string.IsNullOrEmpty(CSGuid.Value))
            {
                 Response.Headers.Add("CSGuid", CSGuid.Value);
                 Request.Headers.Add("CSGuid", CSGuid.Value);
            }
        }

         


        

    }

    void Application_EndRequest(object sender, EventArgs e)
    {
        //Response.Write(DateTime.Now.ToString());
    } 
       
   

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        try
        {
            Attune.Kernel.PlatForm.BL.GateWay gateWay = new Attune.Kernel.PlatForm.BL.GateWay();
            gateWay.DeleteLoggedInUserBySessionID(Session.SessionID);
            if (HttpContext.Current != null && HttpContext.Current.Request != null)
            {
                if (Request.Cookies["LeftMenu"] != null)
                {
                    Response.Cookies["LeftMenu"].Expires = DateTime.Now.AddDays(-1);
                }
            }
        }
        catch (Exception ex)
        {
            Attune.Kernel.PlatForm.Utility.CLogger.LogError("Error deleting session...Global.asax", ex);
        }

    }

     
    

       
</script>
