using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PMS_Header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Remove("PMSLoginID");
        Response.Redirect("Login.aspx");
    }
    protected void cmdLink_Click(object sender, EventArgs e)
    {
        string url = "http://" + Request.Url.Authority +  Request.Url.Segments[0] + Request.Url.Segments[1] + "Admin/Home.aspx";
        Response.Redirect(url);
    }
}
