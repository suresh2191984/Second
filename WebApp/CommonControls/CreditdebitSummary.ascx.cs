using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using System.Text;
using Attune.Utilitie.Helper;
public partial class CommonControls_CreditdebitSummary :BaseControl
{
    protected string _Date = "";
    public string Date
    {
        get { return _Date; }
        set { _Date = value; }
    }

    protected string _ClientId = "";
    public string ClientId
    {
        get { return _ClientId; }
        set { _ClientId = value; }
    }
    protected string _ClientName = "";
    public string ClientName
    {
        get { return _ClientName; }
        set { _ClientName = value; }
    }

    protected string _Authorizedby = "";
    public string Authorizedby
    {
        get { return _Authorizedby; }
        set { _Authorizedby = value; }
    }
    protected int _ID = 0;
    public int ID
    {
        get { return _ID; }
        set { _ID = value; }
    }
    protected string _Reason = "";
    public string Reason
    {
        get { return _Reason; }
        set { _Reason = value; }
    }
    protected string _CrDrType = "";
    public string CrDrType
    {
        get { return _CrDrType; }
        set { _CrDrType = value; }
    }
    protected string _ReferenceID = "";
    public string ReferenceID
    {
        get { return _ReferenceID; }
        set { _ReferenceID = value; }
    }   
    protected string _Duplicate = "N";

    public string Duplicate
    {
        get { return _Duplicate; }
        set { _Duplicate = value; }
    }
    protected string _ReceiptNo = "";
    public string ReceiptNo
    {
        get { return _ReceiptNo; }
        set { _ReceiptNo = value; }
    }
    protected string _ClientType = "";
    public string ClientType
    {
        get { return _ClientType; }
        set { _ClientType = value; }
    }
    protected string _ddltypeCredit12 = "";
    public string ddltypeCredit12
    {
        get { return _ddltypeCredit12; }
        set { _ddltypeCredit12 = value; }
    }
    protected string _CAddres = "";
    public string CAddres
    {
        get { return _CAddres; }
        set { _CAddres = value; }
    }
    protected string _login = "";
    public string login
    {
        get { return _login; }
        set { _login = value; }
    }
    protected string _Remarks = "";
    public string Remarks
    {
        get { return _Remarks; }
        set { _Remarks = value; }
    }
    protected string _ReasonCredit = "";
    public string ReasonCredit
    {
        get { return _ReasonCredit; }
        set { _ReasonCredit = value; }
    }
    protected Decimal _Amount = 0;
    public Decimal Amount
    {
        get { return _Amount; }
        set { _Amount = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ddltypeCredit12 == "Client")
        {
            if (ClientType.Trim() != "Credit")
            {

                lblAmountcredit.Text = Convert.ToString(Amount);
                Rs_CreditorDebit.Text = "Debit Note";
                lbl_CreditNoteNumber.Text = " Debit Note Number";
                //Rs_CreditorDebit.Text = ClientType;
                lblClientName.Text = ClientName;
                //lbl_referenceNo.Text = Convert.ToString(ReferenceID);
                lblReferenceID.Text = Convert.ToString(ReferenceID);
                lbl_CreditNoteNumberoutput.Text = ReceiptNo;
                lblClienttype.Text = Reason;
                lblAuthorzeroutput.Text = Authorizedby;
                lbl_Address.Text = CAddres;
                lbl_Billedoutput.Text = login;
                lbl_remarkoutput.Text = Remarks;
                lbl_reasonoutput.Text = ReasonCredit;
                if (Request.QueryString["pDate"].ToString() != null || Request.QueryString["pDate"].ToString() != "")
                {                    
                    DateTime d = Convert.ToDateTime(Request.QueryString["pDate"]);
                    lblDateoutput.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                    lblDateoutputAuth.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                }
                //Lbl_AuthorizedBy.Text = Name;
                //lblclnt.Text = ddltypeCredit12; 
            }
            else
            {
                lblAuthorzeroutput.Text = Authorizedby;
                //lbl_Reason.Text = Reason;
                lblAmountcredit.Text = Convert.ToString(Amount);
                Rs_CreditorDebit.Text = "Credit Note";
                lbl_CreditNoteNumber.Text = " Credit Note Number";
                //Rs_CreditorDebit.Text = ClientType;
                lblClientName.Text = ClientName;
                //lbl_referenceNo.Text = Convert.ToString(ReferenceID);
                lblReferenceID.Text = Convert.ToString(ReferenceID);
                lbl_CreditNoteNumberoutput.Text = ReceiptNo;
                lblClienttype.Text = Reason;
                lblDateoutput.Text = Date;
                lblDateoutputAuth.Text = Date;
                lbl_Address.Text = CAddres;
                lbl_Billedoutput.Text = login;
                lbl_remarkoutput.Text = Remarks;
                lbl_reasonoutput.Text = ReasonCredit;
                if (Request.QueryString["pDate"].ToString() != null || Request.QueryString["pDate"].ToString() != "")
                {
                    DateTime d = Convert.ToDateTime(Request.QueryString["pDate"]);
                    lblDateoutput.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                    lblDateoutputAuth.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                }
                //lblclnt.Text = ddltypeCredit12; 
            }
        }
        else
        {
            if (ClientType != "Credit")
            {
                lblAmountcredit.Text = Convert.ToString(Amount);
                Rs_CreditorDebit.Text = "Debit Note";
                lbl_CreditNoteNumber.Text = " Debit Note Number";
                lblAuthorzeroutput.Text = Authorizedby;
                //Rs_CreditorDebit.Text = ClientType;
                lblClientName.Text = ClientName;
                //lbl_referenceNo.Text = Convert.ToString(ReferenceID);
                lblReferenceID.Text = Convert.ToString(ReferenceID);
                lbl_CreditNoteNumberoutput.Text = ReceiptNo;
                lblClienttype.Text = Reason;
                lblDateoutput.Text = Date;
                lblDateoutputAuth.Text = Date;
                lbl_Address.Text = CAddres;
                lbl_Billedoutput.Text = login;
                lbl_remarkoutput.Text = Remarks;
                lbl_reasonoutput.Text = ReasonCredit;
                if (Request.QueryString["pDate"].ToString() != null || Request.QueryString["pDate"].ToString() != "")
                {
                    DateTime d = Convert.ToDateTime(Request.QueryString["pDate"]);
                    lblDateoutput.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                    lblDateoutputAuth.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                }
                //lblclientpatient.Text = "Patient Name";
                //lblclientpatienttype.Text = "Patient Type";
               
            }
            else
            {
                //lbl_Authorized.Text = Authorizedby;
                //lbl_Reason.Text = Reason;
               
                lblAmountcredit.Text = Convert.ToString(Amount);
                Rs_CreditorDebit.Text = "Credit Note";
                lbl_CreditNoteNumber.Text = " Credit Note Number";
                lblAuthorzeroutput.Text = Authorizedby;
                //Rs_CreditorDebit.Text = ClientType;
                lblClientName.Text = ClientName;
                //lbl_referenceNo.Text = Convert.ToString(ReferenceID);
                lblReferenceID.Text = Convert.ToString(ReferenceID);
                lbl_CreditNoteNumberoutput.Text = ReceiptNo;
                lblClienttype.Text = Reason;
                lblDateoutput.Text = Date;
                lblDateoutputAuth.Text = Date;
                lbl_Address.Text = CAddres;
                lbl_Billedoutput.Text = login;
                lbl_remarkoutput.Text = Remarks;
                lbl_reasonoutput.Text = ReasonCredit;
                if (Request.QueryString["pDate"].ToString() != null || Request.QueryString["pDate"].ToString() != "")
                {
                    DateTime d = Convert.ToDateTime(Request.QueryString["pDate"]);
                    lblDateoutput.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                    lblDateoutputAuth.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                }
                //lblclientpatient.Text = "Patient Name";
                //lblclientpatienttype.Text = "Patient Type";
            }
        }
    }
}
