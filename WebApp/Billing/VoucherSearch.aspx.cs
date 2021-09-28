using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;

public partial class Billing_VoucherSearch : BasePage
{
    //public Admin_AddBankName()
    //    : base("Admin\\AddBankName.aspx")
    //{
    //}

    //protected void page_Init(object sender, EventArgs e)
    //{
    //    base.page_Init(sender, e);
    //}
    string type;
    long retval = -1;
    long returnCode = -1;
    long visitID = -1;
    long pvisitID = -1;


    protected void Page_Load(object sender, EventArgs e)
    {
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
        if (!IsPostBack)
        {
            //BindDropDownValues();
            if (RoleID == 1)
            {
              //  physicianHeader.Visible = true;
              //  userHeader.Visible = false;
            }
            else
            {
              //  physicianHeader.Visible = false;
              //  userHeader.Visible = true;
            }

        }
    }
    protected void uctrlBillSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctrlBillSearch.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }
    private bool validatePage(long bid)
    {
        bool retval = true;
        string error = "";
        if (bid <= 0)
        {
            retval = false;
            error = "Please Select a Bill";
        }
        //ErrorDisplay1.ShowError = true;
       // ErrorDisplay1.Status = error;
        return retval;
    }


}
