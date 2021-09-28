using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Home : BasePage
{
    public Admin_Home()
        : base("Admin_Home_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string PMS = GetConfigValue("PMS", OrgID);

        if (PMS == "Y")
        {
            cmdLink.Visible = true;
        }
        else
        {
            cmdLink.Visible = false;
        }
        Session.Add("PMSLoginID", LID);
        phySch.TempOrgID = OrgID;
        phySch.LocationID = ILocationID;
        phySch.PostDifferentPage = "Yes";
        if (!Page.IsPostBack)
        {
            ReminderDisplay1.LoadData();
            ProductReminderDisplay.LoadData();
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }

        }

        if (RoleName == "Clinical Admin")
        {
            phySch.Visible = false;
        }
        else
        {
            phySch.Visible = true;
        }
    }
    protected void cmdLink_Click(object sender, EventArgs e)
    {
      //  string url = "http://" + Request.Url.Authority + ":8082/" + Request.Url.Segments[1] + "pms/Home.aspx?FldID=0";
		//string url = "http://" + Request.Url.Host+":"+Request.Url.Port + Request.Url.Segments[0] + Request.Url.Segments[1] + "pms/Home.aspx?FldID=0";
          string url = "http://" + Request.Url.Host + Request.Url.Segments[0] + Request.Url.Segments[1] + "pms/Home.aspx?FldID=0";
        Response.Redirect(url);
    }
   
}
