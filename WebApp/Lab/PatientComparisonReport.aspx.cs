using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


public partial class Investigation_PatientComparisonReport : BasePage
{
    public Investigation_PatientComparisonReport()
        : base("Investigation_PatientComparisonReport_aspx")
    {
    }
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnPageID.Value = Convert.ToString(PageID);
            txtVisitNumber.Focus();
            if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["VisitNumber"];
                //menu.Attributes.Add("style", "display:none");
                //header.Attributes.Add("style", "display:none");
                //TopHeader1.Attributes.Add("style", "display:none");
           
                
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:Click_Search();", true);
            }
        }
    }
}
