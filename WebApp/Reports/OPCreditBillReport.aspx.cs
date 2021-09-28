using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class Reports_OPCreditBillReport : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindClientTPA();
        }
    }
    public void BindClientTPA()
    {
        List<TPAMaster> lTpaMaster = new List<TPAMaster>();
        new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lTpaMaster);
        ddlTpaName.DataSource = lTpaMaster;

        ddlTpaName.DataTextField = "TPAName";
        ddlTpaName.DataValueField = "TPAID";
        ddlTpaName.DataBind();
        ddlTpaName.Items.Insert(0, new ListItem("All", "-1"));

        List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
        new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
        if (Clientmaster.Count > 0)
        {
            ddlCorporate.DataSource = Clientmaster;
            ddlCorporate.DataTextField = "ClientName";
            ddlCorporate.DataValueField = "ClientID";
            ddlCorporate.DataBind();
            ddlCorporate.Items.Insert(0, "All");
            ddlCorporate.Items[0].Value = "0";
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<BillSearch> lstCreditBills = new List<BillSearch>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        DateTime dtFrom = Convert.ToDateTime(new BasePage().OrgDateTimeZone), dtTo = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string TPAID = "";
        string ClientID = "";
        if (ddlType.SelectedItem.Text == "Any")
        {
            TPAID = "";
            ClientID = "";
        }

        if (ddlType.SelectedItem.Text == "Client")
        {
            if (ddlCorporate.SelectedItem.Text == "All")
            {
                ClientID = "";
                TPAID = "-1";
            }
            else
            {
                ClientID = ddlCorporate.SelectedValue.ToString();
                TPAID = "-1";
            }
        }
        if (ddlType.SelectedItem.Text == "Insurance")
        {
            if (ddlTpaName.SelectedItem.Text == "All")
            {
                ClientID = "-1";
                TPAID = "";
            }
            else
            {
                ClientID = "-1";
                TPAID = ddlTpaName.SelectedValue.ToString();
            }
        }
        dtFrom = ucDateCtrl.GetFromDate();
        dtTo = ucDateCtrl.GetToDate();
        returnCode = patientBL.GETOPCreditBillReport(TPAID, ClientID, dtFrom.ToString("dd/MM/yyyy"), dtTo.ToString("dd/MM/yyyy"), OrgID, out lstCreditBills);
        
        if (returnCode == 0 && lstCreditBills.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lstCreditBills;
            grdResult.DataBind();

        }
        else
        {
            grdResult.Visible = false;
        }
    }
}
