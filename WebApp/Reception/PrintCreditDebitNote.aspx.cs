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

public partial class Reception_PrintCreditDebitNote : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string dAmount = "0";
        //if (Request.QueryString["Amount"] != null)
        //{
        //    dAmount = Request.QueryString["Amount"].ToString();
        //}
        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        string ClientName = "";
        long ClientID = 0;
        string CrcptNo = "0";
        string CollectionType = "";
        string DDate = "";
        int Id = 0;
        string Authorized = "";
        string Reason = "";
        string crdrtype = "";
        string ClientType = "";
        Decimal Amount = 0;
        string ReferenceID = "";
        string ddltypeCredit1 = "";
        string CAddress = "";
        string remarks = "";
        string reasoncr = "";
        //int ReceiptNo = 0;


        if (Request.QueryString["rcptno"] != null)
        {
            CrcptNo = Request.QueryString["rcptno"].ToString();
        }
        if (Request.QueryString["ClientID"] != null)
        {
            ClientID = Convert.ToInt32(Request.QueryString["ClientID"].ToString());
        }
        if (Request.QueryString["ClientName"] != null)
        {
            ClientName = Request.QueryString["ClientName"].ToString();
        }       
        if (Request.QueryString["pDate"] != null)
        {
            DDate = Request.QueryString["pDate"].ToString();
        }
        //if (Request.QueryString["Amount"] != null)
        //{
        //    DDate = Request.QueryString["Amount"].ToString();
        //}
        // if (Request.QueryString["ClientType"] != null)
        //{
        //    DDate = Request.QueryString["ClientType"].ToString();
        //}
        if (Request.QueryString["ID"] != null)
        {
            Id = Convert.ToInt32(Request.QueryString["ID"].ToString());
        }
        if (Request.QueryString["CrDrType"] != null)
        {
            crdrtype = Request.QueryString["CrDrType"].ToString();
        }
        if (Request.QueryString["Reason"] != null)
        {
            Reason = Request.QueryString["Reason"].ToString();
        }
        if (Request.QueryString["Authorizedby"] != null)
        {
            Authorized = Request.QueryString["Authorizedby"].ToString();
        }
        if (Request.QueryString["Amount"] != null)
        {
            Amount = Convert.ToDecimal(Request.QueryString["Amount"].ToString());
        }
        if (Request.QueryString["ClientType"] != null)
        {
            ClientType = Request.QueryString["ClientType"].ToString();
        }
        if (Request.QueryString["ReferenceID"] != null)
        {
            ReferenceID = Convert.ToString(Request.QueryString["ReferenceID"].ToString());
        }
        if (Request.QueryString["DddltypeCredit"] != null)
        {
            ddltypeCredit1 = Convert.ToString(Request.QueryString["DddltypeCredit"].ToString());
        }
        if (Request.QueryString["hdnCAddress"] != null)
        {
            CAddress = Convert.ToString(Request.QueryString["hdnCAddress"].ToString());
        }
        if (Request.QueryString["hdnremarks"] != null)
        {
            remarks = Convert.ToString(Request.QueryString["hdnremarks"].ToString());
        }
        if (Request.QueryString["hdnreasoncred"] != null)
        {
            reasoncr = Convert.ToString(Request.QueryString["hdnreasoncred"].ToString());
        }
            tblCrDr.Visible = true;
            UCCreditDebit.Authorizedby = Authorized;
            UCCreditDebit.ClientName = ClientName;
            UCCreditDebit.ClientType = ClientType.Trim();
            UCCreditDebit.Amount = Amount;
            UCCreditDebit.ReferenceID = ReferenceID;
            UCCreditDebit.ReceiptNo = CrcptNo;           
            UCCreditDebit.CrDrType = crdrtype;
            UCCreditDebit.Reason = Reason;
            UCCreditDebit.ddltypeCredit12 = ddltypeCredit1;
            UCCreditDebit.Date = DDate;
            UCCreditDebit.login = LoginName;
            UCCreditDebit.CAddres = CAddress;
            UCCreditDebit.Remarks = remarks;
            UCCreditDebit.ReasonCredit = reasoncr;

            //UCCreditDebit.r

      

    }


}