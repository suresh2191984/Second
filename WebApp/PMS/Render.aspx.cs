using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PMS_Render : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["PMSLoginID"] != null)
        {
            hdnLoginID.Value = Convert.ToString(Session["PMSLoginID"]);
            if (!IsPostBack)
            {
                if (Request.QueryString["ProcID"] != null)
                {
                    hdnProcedureID.Value = Request.QueryString["ProcID"];
                }
                else
                {
                    hdnProcedureID.Value = "0";
                }
                if (Request.QueryString["Title"] != null)
                {
                    hdnTitleName.Value = Request.QueryString["Title"];
                }
                else
                {
                    hdnTitleName.Value = "";
                }
            }
            else
            {
                if (Request.QueryString["Title"] != null)
                {
                    hdnTitleName.Value = Request.QueryString["Title"];
                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
   
}
