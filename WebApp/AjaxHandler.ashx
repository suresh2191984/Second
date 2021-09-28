<%@ WebHandler Language="C#" Class="AjaxHandler" %>

using System;
using System.Web;

public class AjaxHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        //if (context != null && context.Request != null && context.Request.QueryString != null && context.Request.QueryString.Count > 0)
        //{
        //string param = Microsoft.Security.Application.Encoder.HtmlEncode(context.Request.QueryString["param"]);
        //string type = Microsoft.Security.Application.Encoder.HtmlEncode(context.Request.QueryString["type"]);
        //string method = Microsoft.Security.Application.Encoder.HtmlEncode(context.Request.QueryString["method"]);
        //string assembly = Microsoft.Security.Application.Encoder.HtmlEncode(context.Request.QueryString["assembly"]);

        //if (!string.IsNullOrEmpty(param))
        //{
        //}
        //if (!string.IsNullOrEmpty(type))
        //{
        //if (!string.IsNullOrEmpty(method))
        //{
        //if (!string.IsNullOrEmpty(assembly))
        //{
        //    try
        //    {
        //        System.Reflection.Assembly asm = System.Reflection.Assembly.Load(assembly);
        //        if (asm != null)
        //        {
        //            Type t = asm.GetType(type);
        //            if (t != null)
        //            {
        //                var methodInfo = t.GetMethod(method);
        //                if (methodInfo != null)
        //                {
        //                    var obj = Activator.CreateInstance(t);
        //                    if (obj != null)
        //                    {
        //                        methodInfo.Invoke(obj, null);
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    catch
        //    {
        //    }
        //}

        //if (method.Equals("logout", StringComparison.OrdinalIgnoreCase))
        //{
        try
        {
            context.Session.Clear();
            context.Session.Abandon();
            context.Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId"));
            context.Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now;
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Cache.SetExpires(DateTime.Now - new TimeSpan(1, 0, 0));
            context.Response.Cache.SetLastModified(DateTime.Now);
            context.Response.Cache.SetAllowResponseInBrowserHistory(false);
            context.Response.Redirect(context.Request.ApplicationPath + "/Home.aspx", true);
            //}
            //}
            //}
            //}
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            string sEx = ex.ToString();
        }
        catch (System.Exception e)
        {
            string sEx = e.ToString();
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}