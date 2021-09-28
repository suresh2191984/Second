using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;

public partial class Billing_MergeBillPrint : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        long VisitID=-1;
        Int64 .TryParse(Request.QueryString["VID"],out VisitID );

        ucBillPrint.BillPrinting_Merge(VisitID);

    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            //string RedirectPage = GetConfigValue("Navigation", OrgID);
            //if (RedirectPage == "Navigation")
            //{
            //    Response.Redirect(Request.ApplicationPath + "/Billing/HospitalBillSearch.aspx", true);
            //}
            //else
            //{

            if (Request.QueryString["RedirectPage"] == null)
            {
                long returncode = -1;
                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
            else
            {
                string RedirectPage = Request.QueryString["RedirectPage"];
                Response.Redirect(Request.ApplicationPath + RedirectPage, true);
            }


            //}

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
