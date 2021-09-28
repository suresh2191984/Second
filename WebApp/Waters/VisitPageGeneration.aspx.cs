using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.PerformingNextAction;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Net.Mail;
using System.Net;
using System.Web.UI.HtmlControls;
using Attune.Podium.BillingEngine;

public partial class Waters_VisitPageGeneration : BasePage
{
    public Waters_VisitPageGeneration()
        : base("Waters_VisitPageGeneration")
    {
    }
    List<PaymentType> lstPaymentType = new List<PaymentType>();
    protected void Page_Load(object sender, EventArgs e)
    {

        hdnOrgID.Value = OrgID.ToString();
        hdnRoleID.Value = RoleID.ToString();
        hdnPageID.Value =  PageContextDetails.PageID.ToString();


        AutoCompleteCollPerson.ContextKey = OrgID.ToString();
        AutoCompleteExtenderClientName.ContextKey = OrgID.ToString();
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "TempDateandTime1", "TempDateandTime1();", true);
        //string ClienID= hfCustomerId.Value;
        //string PersonID = hfPersonID.Value;

        if(!IsPostBack){

            ddlPaymentMode.Items.Clear();
            BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);
            long retval = -1;
            retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
            if (lstPaymentType.Count > 0)
            {
                ddlPaymentMode.DataSource = lstPaymentType;
                ddlPaymentMode.DataTextField = "PaymentName";
                //ddlPaymentType.DataValueField = "PaymentTypeID";
                ddlPaymentMode.DataValueField = "PTypeIDIsRequired";
                ddlPaymentMode.DataBind();
            }

            ddlPaymentMode.SelectedValue = Convert.ToString(lstPaymentType.Find(p => p.IsDefault == "Y").PTypeIDIsRequired);
            hdfDefaultPaymentMode.Value = ddlPaymentMode.SelectedValue.ToString();
        
        
        }


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
       
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {

      
       
        

    }

    protected void btnSendmail_Click(object sender, EventArgs e)
    {
        long rCode = -1;
        modalpopupsendemail.Show();
        try
        {
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrg = new List<Organization>();
            rCode = objBl.pGetOrgLoction(out lstOrg);
            if (lstOrg.Count > 0)
            {
                lstOrg.RemoveAll(p => p.OrgID != OrgID);
                if (!String.IsNullOrEmpty(lstOrg[0].Email) && lstOrg[0].Email.Length > 0)
                {
                    txtMailAddress.Text = lstOrg[0].Email.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetOrgLoction", ex);
        }

    }

    public class MyPanel : Panel
    {
        //snip

        protected override void Render(HtmlTextWriter output)
        {
            output.Write("<div id=\"{0}\" class=\"{1}\"", this.ID, this.CssClass);
            this.RenderChildren(output);
            output.Write("</div>");
        }

        //snip
    }
}
