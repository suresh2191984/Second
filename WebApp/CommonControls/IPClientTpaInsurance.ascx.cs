using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Linq;

public partial class CommonControls_IPClientTpaInsurance : BaseControl
{
    public CommonControls_IPClientTpaInsurance()
        : base("CommonControls_IPClientTpaInsurance_ascx")
    {
    }


    private string isBilling = "N";
    public string IsBilling
    {
        get { return isBilling; }
        set { isBilling = value; }
    }
    private string isCreditBill = "N";
    public string IsCreditBill
    {
        get { return chkcredit.Checked == true ? "Y" : "N"; }
        set { chkcredit.Checked = value == "Y" ? true : false; }
    }

    private string roomType;
    public string RoomType
    {
        get { return ddlRoomType.SelectedValue; }
        set { ddlRoomType.SelectedValue = value; }
    }

    private string oldClientValue;
    public string OldClientValue
    {
        get { return hdnOldClientValue.Value; }
        set { hdnOldClientValue.Value = value; }
    }

    public string ClientStatus
    {
        get { return hdnValueStatus.Value; }
        set { hdnValueStatus.Value = value; }

    }
    public decimal CliamAmount { get; set; }
    public decimal NonMedicalAmount { get; set; }
    public decimal CoPayment { get; set; }
    public long VisitID { get; set; }

    #region "Common Resource Property"

    string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_01 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_01;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (IsBilling == "Y")
           // {
                loadRateType();
           // }
            loadCopaymentLogin();
            loadRoomType();
            loadClaimAmountType();
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            AutoCompleteExtender1.ContextKey = "CLI";
            loadClient();
            ddlRateType.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
            loadCopaymentType();
            ddlCopaymentType.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "fn_SetVisitdetails('" + Request.QueryString["VID"] + "','IP'," + Request.QueryString["IsCreditPatient"] + "','" + RoomType + "')", true);
        }
    }

    #endregion

    #region "Methods"

    private void loadClient()
    {

        long refhospid = 0;
        List<InvClientMaster> lstInvs = new List<InvClientMaster>();
        new BillingEngine(new BaseClass().ContextInfo).GetRateCardForBilling("", OrgID, "CLI", refhospid, out lstInvs);
        if (lstInvs.Find(p => p.ClientCode == "GENERAL") != null)
        {
            hdnbaseClientValue.Value = lstInvs.Find(p => p.ClientCode == "GENERAL").Value;

        }
    }


  

    private void loadClaimAmountType()
    {
        List<ClaimAmountLogic> lstClaim = new List<ClaimAmountLogic>();
        try
        {
            new AdminReports_BL(base.ContextInfo).pGetClaimAmountLogic(OrgID, out lstClaim);
            //Comented By Arivalagan K this details get from metadata no need this//
            //ddlClaimAmount.DataSource = lstClaim;
            //ddlClaimAmount.DataTextField = "ClaimLogicName";
            //ddlClaimAmount.DataValueField = "ClaimID";
            //ddlClaimAmount.DataBind();
            //ddlClaimAmount.Items.Insert(0, "--Select--");
            //ddlClaimAmount.Items[0].Value = "-1";
            //Comented By Arivalagan K//
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Claim amount data in  Client Insurance", ex);
        }

    }

    private void loadRoomType()
    {
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        try
        {
            new RoomBooking_BL(base.ContextInfo).LoadRoomMasterDetails("ROOM_TYPE", OrgID, ILocationID, 0, out lstRoomDetails);

            ddlRoomType.DataSource = lstRoomDetails;
            ddlRoomType.DataTextField = "Name";
            ddlRoomType.DataValueField = "ID";
            ddlRoomType.DataBind();
            ddlRoomType.Items.Insert(0, strSelect.Trim());
            ddlRoomType.Items[0].Value = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load RoomType", ex);
        }

    }

    private void loadCopaymentLogin()
    {
        try
        {
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            lstmetadataInput.Add(new MetaData { Domain = "CopaymentLogic" });
            new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "CopaymentLogic"
                             select child;
            ddlpaymentLogic.DataSource = childItems;
            ddlpaymentLogic.DataTextField = "DisplayText";
            ddlpaymentLogic.DataValueField = "Code";
            ddlpaymentLogic.DataBind();

            ddlClaimAmount.DataSource = childItems;
            ddlClaimAmount.DataTextField = "DisplayText";
            ddlClaimAmount.DataValueField = "Code";
            ddlClaimAmount.DataBind();

            //ddlpaymentLogic.Items.Insert(0, "--Select--");
            //ddlpaymentLogic.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    private void loadCopaymentType()
    {
        try
        {
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            lstmetadataInput.Add(new MetaData { Domain = "CoPaymentType" });
            new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "CoPaymentType"
                             select child;
            ddlCopaymentType.DataSource = childItems;
            ddlCopaymentType.DataTextField = "DisplayText";
            ddlCopaymentType.DataValueField = "Code";
            ddlCopaymentType.DataBind();
            ////ddlCopaymentType.Items.Insert(0, "--Select--");
            ////ddlCopaymentType.Items[0].Value = "-1";


            ddlPreAuthType.DataSource = childItems;
            ddlPreAuthType.DataTextField = "DisplayText";
            ddlPreAuthType.DataValueField = "Code";
            ddlPreAuthType.DataBind();


        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    private void loadRateType()
    {

        long pRateID = 0;
        List<RateMaster> lstRateMaster = new List<RateMaster>();
        try
        {

            new Master_BL(base.ContextInfo).pGetRateName(OrgID, out lstRateMaster);
            ddlRateType.DataSource = lstRateMaster;
            ddlRateType.DataTextField = "RateName";
            ddlRateType.DataValueField = "RateId";
            ddlRateType.DataBind();
            pRateID = Convert.ToInt64(lstRateMaster.Find(p => p.RateName.ToUpper() == "GENERAL").RateId);
            ddlRateType.SelectedValue = (pRateID.ToString());

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Rate Type Master ", ex);
        }
    }

    public List<VisitClientMapping> GetClientValues()
    {


        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        VisitClientMapping objVisitClientMapping;

        try
        {

            foreach (string listParent in IsBilling == "Y" ? hdnRowEdit.Value.Split('^') : hdnClientvalues.Value.Split('^'))
            {
                if (listParent != "")
                {

                    objVisitClientMapping = new VisitClientMapping();
                    string[] listChild = listParent.Split('~');
                    objVisitClientMapping.ClientID = Convert.ToInt64(listChild[0]);
                    objVisitClientMapping.RateID = Convert.ToInt64(listChild[3]);
                    objVisitClientMapping.PreAuthAmount = Convert.ToDecimal(listChild[10]);
                    objVisitClientMapping.CopaymentPercent = Convert.ToDecimal(listChild[5]);
                    objVisitClientMapping.CoPaymentLogic = Convert.ToInt32(listChild[7]);
                    objVisitClientMapping.PreAuthApprovalNumber = listChild[11];
                    objVisitClientMapping.ClientAttributes = listChild[12];
                    objVisitClientMapping.IsAllMedical = listChild[4].ToUpper() == "TRUE" ? "Y" : "N";
                    objVisitClientMapping.ClaimLogic = Convert.ToInt32(listChild[9]);
                    objVisitClientMapping.ClaimAmount = CliamAmount;
                    objVisitClientMapping.NonMedicalAmount = NonMedicalAmount;
                    objVisitClientMapping.CoPayment = CoPayment;
                    objVisitClientMapping.VisitID = VisitID;
                    objVisitClientMapping.VisitClientMappingID = Convert.ToInt64(listChild[13]); ;
                    objVisitClientMapping.AsCreditBill = chkcredit.Checked == true ? "Y" : "N";
                    objVisitClientMapping.PolicyNo = listChild[15];
                    objVisitClientMapping.PolicyStartDate = listChild[16] == "" ? DateTime.MaxValue : Convert.ToDateTime(listChild[16]);
                    objVisitClientMapping.PolicyEndDate = listChild[17] == "" ? DateTime.MaxValue : Convert.ToDateTime(listChild[17]); 
                    lstVisitClientMapping.Add(objVisitClientMapping);


                }
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while getting   VisitClientMapping  ", ex);
        }


        return lstVisitClientMapping;
    }

    public void LoadClientValue()
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        long returnCode = -1;
        PatientVisit_BL obj = new PatientVisit_BL(new BaseClass().ContextInfo);
        returnCode = obj.GetVisitClientMappingDetails(OrgID, Int64.Parse(Request.QueryString["VID"]), out lstVisitClientMapping);
        hdnClientvalues.Value = "";

        if (lstVisitClientMapping.Count > 0)
        {
            foreach (VisitClientMapping lstVistiClient in lstVisitClientMapping)
            {
                hdnClientvalues.Value += lstVistiClient.Description + "^";
            }
        }
        if (hdnClientvalues.Value != "")
        {
            hdnOldClientValue.Value = hdnClientvalues.Value;
        }

    }

    public List<VisitClientMapping> GetClientValues(string lsoldClientValues)
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        VisitClientMapping objVisitClientMapping;

        try
        {
            long VID;
            Int64.TryParse(Request.QueryString["vid"], out VID);

            foreach (string listParent in lsoldClientValues.Split('^'))
            {
                if (listParent != "")
                {

                    objVisitClientMapping = new VisitClientMapping();
                    string[] listChild = listParent.Split('~');
                    objVisitClientMapping.ClientID = Convert.ToInt64(listChild[0]);
                    objVisitClientMapping.RateID = Convert.ToInt64(listChild[3]);
                    objVisitClientMapping.PreAuthAmount = Convert.ToDecimal(listChild[10]);
                    objVisitClientMapping.CopaymentPercent = Convert.ToDecimal(listChild[5]);
                    objVisitClientMapping.CoPaymentLogic = Convert.ToInt32(listChild[7]);
                    objVisitClientMapping.PreAuthApprovalNumber = listChild[11];
                    objVisitClientMapping.ClientAttributes = listChild[12];
                    objVisitClientMapping.IsAllMedical = listChild[4].ToUpper() == "TRUE" ? "Y" : "N";
                    objVisitClientMapping.ClaimLogic = Convert.ToInt32(listChild[9]);
                    objVisitClientMapping.ClaimAmount = CliamAmount;
                    objVisitClientMapping.NonMedicalAmount = NonMedicalAmount;
                    objVisitClientMapping.CoPayment = CoPayment;
                    objVisitClientMapping.VisitID = VID;
                    objVisitClientMapping.VisitClientMappingID = Convert.ToInt64(listChild[13]); ;
                    objVisitClientMapping.AsCreditBill = chkcredit.Checked == true ? "Y" : "N";
                    lstVisitClientMapping.Add(objVisitClientMapping);

                }
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while getting   VisitClientMapping  ", ex);
        }


        return lstVisitClientMapping;
    }

    #endregion
}