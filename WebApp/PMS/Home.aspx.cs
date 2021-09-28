using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PMS_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PMSLoginID"] != null)
        {
            if (!IsPostBack)
            {
                hdnLoginID.Value = Convert.ToString(Session["PMSLoginID"]);
                if (Request.QueryString["FldID"] != null)
                {
                    hdnFolderID.Value = Request.QueryString["FldID"];
                }
                else
                {
                    hdnFolderID.Value = "0";
                }
            }
            else
            {
                if (Request.QueryString["FldID"] != null)
                {
                    hdnFolderID.Value = Request.QueryString["FldID"];
                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
}
