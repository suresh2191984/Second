using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data.SqlClient;
using System.Xml;
using System.Web.Script.Serialization;
public partial class Admin_DiscountMaster : BasePage
{
    public string Save_Message = Resources.AppMessages.Save_Message;
    string DispSele = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
    public Admin_DiscountMaster()
        : base("Admin_DiscountMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<MetaValue_Common> lstMetavalue = new List<MetaValue_Common>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                LoadAllTypes();
                LoadInvGrpPkg();
                TODCode.Text = "";
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:DrpInv();", true);
            }
            tdbtnDeleteTax.Style.Add("display", "none");
            ACEdiscountPolicy.ContextKey = "DCP";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error during Page load", ex);
        }
    }
    public void LoadInvGrpPkg()
    {

        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~";

    }

    private void LoadAllTypes()
    {
        txtDiscountName.Text = string.Empty;
        txtDiscountValue.Text = string.Empty;
        txtTaxName.Text = string.Empty;
        txtPercentage.Text = string.Empty;
        txtPercent.Text = string.Empty;
        txtFrom.Text = string.Empty;
        txtTo.Text = string.Empty;
        txtDiscountCode.Text = string.Empty;
        txttaxCode.Text = string.Empty;
        txtDiscountPercentage.Text = string.Empty;
        LoadDiscountMaster();
        LoadTaxmaster();
        LoadMetaData();
        LoadTODCode();
        LoadCoupon();
    }

    private void LoadCoupon()
    {
        long returnCode = -1;
        List<CouponMaster> lstCouponMaster = new List<CouponMaster>();
        List<CouponDetails> lstCouponDetails = new List<CouponDetails>();
        Master_BL objCouponMaster = new Master_BL(base.ContextInfo);
        returnCode = objCouponMaster.GetCoupon(OrgID, out lstCouponMaster, out lstCouponDetails);
        gvwCouponMaster.DataSource = lstCouponMaster;
        gvwCouponMaster.DataBind();

        gvwCouponDetails.DataSource = lstCouponDetails;
        gvwCouponDetails.DataBind();

        List<CouponMaster> lstCouponCode = new List<CouponMaster>();
        lstCouponCode = lstCouponMaster;

        ddlCoupon.DataSource = lstCouponCode;
        ddlCoupon.DataValueField = "CouponID";
        ddlCoupon.DataTextField = "Name";
        ddlCoupon.DataBind();

        ddlCoupon.Items.Insert(0, DispSele);
        ddlCoupon.Items[0].Value = "-1";

        hdnCouponID.Value = "";

    }
    protected void btnSaveCouponMaster_Click(object sender, EventArgs e)
    {
        string UserHeaderText = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;
        try
        {
            long returncode = -1;
            List<CouponMaster> lstCouponMaster = new List<CouponMaster>();
            List<CouponDetails> lstCouponDetails = new List<CouponDetails>();
            CouponMaster objCouponMaster = new CouponMaster();
            CouponDetails objCouponDetails = new CouponDetails();
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            objCouponMaster.Code = txtCouponCode.Text;
            objCouponMaster.Name = txtCouponName.Text;
            if (chkStatus.Checked)
            {
                objCouponMaster.Status = "A";
            }
            else
            {
                objCouponMaster.Status = "D";
            }
            objCouponMaster.CreatedBy = LID;
            objCouponMaster.OrgID = OrgID;

            lstCouponMaster.Add(objCouponMaster);
            lstCouponDetails.Add(objCouponDetails);

            string strInsUpdate = "";
            if (hdnCouponID.Value == "")
            {
                strInsUpdate = "I";
            }
            else
            {
                strInsUpdate = "U";
                objCouponMaster.CouponID = Convert.ToInt64(hdnCouponID.Value);
            }

            string strResult = "";

            returncode = Master_BL.SaveCoupon(OrgID, lstCouponMaster, lstCouponDetails, "M", strInsUpdate, LID, out strResult);

            if (returncode > 0)
            {
                if (strResult == "")
                {
                    LoadCoupon();
                    divTaxmaster.Style.Add("display", "block");                   
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Saved successfully.');", true);
                    //     ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('"+Save_Message+"');", true);
                    string UserDisplayText = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Saved successfully." : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                    txtCouponCode.Text = "";
                    txtCouponName.Text = "";
                    chkStatus.Checked = false;

                    divInv.Style.Add("display", "none");
                    divTaxmaster.Style.Add("display", "none");
                    divTurnovrDisc.Style.Add("display", "none");
                    divCoupon.Style.Add("display", "block");

                    divCouponMaster.Style.Add("display", "block");
                    divCouponDetails.Style.Add("display", "none");

                    ScriptManager.RegisterStartupScript(Page, GetType(), "CouponDetails", "showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponDetails',0);", true);

                }
                else
                {
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('" + strResult + "');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strResult + "','" + UserHeaderText + "');", true);
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('CUP'" + ',' + "'1');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute btnSaveCouponMaster_Click()", ex);
        }
    }

    protected void btnSaveRCD_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<DiscountPolicyMapping> lstDisPolicyMapping = new List<DiscountPolicyMapping>();
            JavaScriptSerializer JSserializer = new JavaScriptSerializer();
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            string strPolicyMapping = hdnRCDdetails.Value;
            string PolicyName = string.Empty;
            string NewPolicyText = Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_02 == null ? "New policy Saved Successfully...!" : Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_02;
            string PolicyUpdateSucc = Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_03 == null ? "Policy updated Successfully ..!" : Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_03;
            PolicyName = txtDiscountPolicy.Text.Trim();
            if (!String.IsNullOrEmpty(PolicyName) && PolicyName.Length > 0)
            {
                lstDisPolicyMapping = JSserializer.Deserialize<List<DiscountPolicyMapping>>(strPolicyMapping);
                if (lstDisPolicyMapping != null)
                {
                    returnCode = objMaster_BL.SaveAndUpdateDiscountPolicy(OrgID, PolicyName, LID, lstDisPolicyMapping);
                    if (returnCode >= 0)
                    {
                        txtDiscountPolicy.Text = "";  
                        ACEdiscountPolicy.ContextKey = "DCP";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ClearTable();", true);                        
                        if (lstDisPolicyMapping[0].PolicyID == 0)
                           // lblResultStatus.Text = "New Policy Saved Successfully..!";
                            lblResultStatus.Text = NewPolicyText;
                        else
                            lblResultStatus.Text = PolicyUpdateSucc;
                        //lblResultStatus.Text = "Policy Updated Successfully..!";
                        txtDiscountPolicy.Focus();
                    }
                }
            }
            else
                
            {
                string strDis = Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_err == null ? "Error in while saving data.!" : Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_err;
                string strDis1 = Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_002 == null ? "Reset" : Resources.Admin_ClientDisplay.Admin_DiscountMaster_aspx_002;
                lblResultStatus.Text = strDis;
                lblResultStatus.ForeColor = System.Drawing.Color.Red;
                btnPolicyClear.Value = strDis1;
                ACEdiscountPolicy.ContextKey = "DCP";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('RCD'" + ',' + "'1');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Discount Policy", ex);
        }
    }

    protected void btnSaveCouponDetails_Click(object sender, EventArgs e)
    {
        string UserDisplayText = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Saved successfully." : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
        string UserHeaderText = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;
        try
        {
            long returncode = -1;
            List<CouponMaster> lstCouponMaster = new List<CouponMaster>();
            List<CouponDetails> lstCouponDetails = new List<CouponDetails>();
            CouponMaster objCouponMaster = new CouponMaster();
            CouponDetails objCouponDetails = new CouponDetails();
            Master_BL Master_BL = new Master_BL(base.ContextInfo);

            objCouponDetails.CouponID = Convert.ToInt64(ddlCoupon.SelectedValue);
            objCouponDetails.StartSerialNo = txtStartSerialNo.Text;
            objCouponDetails.EndSerialNo = txtEndSerialNo.Text;
            objCouponDetails.BatchNo = txtBatchNo.Text;
            objCouponDetails.OrderedUnits = Convert.ToInt64(txtOrderedUnits.Text);
            objCouponDetails.CouponValue = Convert.ToDecimal(txtCouponValue.Text);
            objCouponDetails.ExpiryDate = Convert.ToDateTime(txtExpiryDate.Text);

            lstCouponMaster.Add(objCouponMaster);
            lstCouponDetails.Add(objCouponDetails);

            string strInsUpdate = "";
            if (hdnCouponID.Value == "")
            {
                strInsUpdate = "I";
            }
            else
            {
                strInsUpdate = "U";
                objCouponDetails.CouponDetailID = Convert.ToInt64(hdnCouponID.Value);
            }

            string strResult = "";

            returncode = Master_BL.SaveCoupon(OrgID, lstCouponMaster, lstCouponDetails, "D", strInsUpdate, LID, out strResult);

            if (returncode > 0)
            {
                if (strResult == "")
                {
                    LoadCoupon();
                    divTaxmaster.Style.Add("display", "block");                    
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Saved successfully.');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('"+Save_Message+"');", true);
                    
                     ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                    ddlCoupon.SelectedIndex = -1;
                    txtStartSerialNo.Text = "";
                    txtEndSerialNo.Text = "";
                    txtBatchNo.Text = "";
                    txtOrderedUnits.Text = "";
                    txtCouponValue.Text = "";
                    txtExpiryDate.Text = "";

                    divInv.Style.Add("display", "none");
                    divTaxmaster.Style.Add("display", "none");
                    divTurnovrDisc.Style.Add("display", "none");
                    divCoupon.Style.Add("display", "block");

                    divCouponMaster.Style.Add("display", "none");
                    divCouponDetails.Style.Add("display", "block");

                    ScriptManager.RegisterStartupScript(Page, GetType(), "CouponMaster", "showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponMaster',1);", true);

                }
                else
                {
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('" + strResult + "');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strResult + "','" + UserHeaderText + "');", true);
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:Temp();", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('CUP'" + ',' + "'1');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute btnSaveCouponDetails_Click()", ex);
        }
    }


    protected void gvwCouponMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvwCouponMaster.PageIndex = e.NewPageIndex;
            }
            LoadCoupon();
            //rdoCoupon.Checked = true;


            divInv.Style.Add("display", "none");
            divTaxmaster.Style.Add("display", "none");
            divTurnovrDisc.Style.Add("display", "none");
            divCoupon.Style.Add("display", "block");

            divCouponMaster.Style.Add("display", "block");
            divCouponDetails.Style.Add("display", "none");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('CUP'" + ',' + "'1');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in gvwCouponMaster_PageIndexChanging()", ex);
        }
    }

    protected void gvwCouponDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvwCouponDetails.PageIndex = e.NewPageIndex;
            }
            LoadCoupon();
            //rdoCoupon.Checked = true;

            divInv.Style.Add("display", "none");
            divTaxmaster.Style.Add("display", "none");
            divTurnovrDisc.Style.Add("display", "none");
            divCoupon.Style.Add("display", "block");

            divCouponMaster.Style.Add("display", "none");
            divCouponDetails.Style.Add("display", "block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('CUP'" + ',' + "'1');", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in gvwCouponDetails_PageIndexChanging()", ex);
        }
    }

    public void LoadTODCode()
    {
        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";

    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "TOD,ReferenceType,Rates,TypeDiscount";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TOD" //orderby child .MetaDataID
                                 select child;
                drpTODType.DataSource = childItems;
                drpTODType.DataTextField = "DisplayText";
                drpTODType.DataValueField = "Code";
                drpTODType.DataBind();

                var childItems1 = from child in lstmetadataOutput
                                 where child.Domain == "ReferenceType" //orderby child .MetaDataID
                                 select child;
                List<MetaData> lstReferenceMetaData = new List<MetaData>();
                lstReferenceMetaData = childItems1.ToList();
                if (lstReferenceMetaData.Exists(p => p.Code == "SC"))
                    lstReferenceMetaData = lstReferenceMetaData.FindAll(p => p.Code != "SC");
                drpRefType.DataSource = lstReferenceMetaData;
                drpRefType.DataTextField = "DisplayText";
                drpRefType.DataValueField = "Code";
                drpRefType.DataBind();

                var childItems3 = from child in lstmetadataOutput
                                 where child.Domain == "Rates" //orderby child .MetaDataID
                                 select child;
                ddlFeeType.DataSource = childItems3;
                ddlFeeType.DataTextField = "DisplayText";
                ddlFeeType.DataValueField = "Code";
                ddlFeeType.DataBind();
                ddlFeeType.Items.Insert(0, DispSele);
                ddlFeeType.Items[0].Value = "0";

                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "TypeDiscount" //orderby child .MetaDataID
                                  select child;
                drpDisType.DataSource = childItems4;
                drpDisType.DataTextField = "DisplayText";
                drpDisType.DataValueField = "Code";
                drpDisType.DataBind();
            }
            hdnTestCategory.Value = "";
            hdnGroupCategory.Value = "";
            //returncode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVESTIGATION_GROUP_FEE", out lstMetavalue);
            //string LoadCategory = string.Empty;
             JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            //if (lstMetavalue.Count() > 0)
            //{
            //    hdnGroupCategory.Value = oJavaScriptSerializer.Serialize(lstMetavalue);
            //    //foreach (MetaValue_Common objMVC in lstMetavalue)
            //    //{
            //    //    LoadCategory += objMVC.Description + '~' + objMVC.Value + '~' + objMVC.Code + '^';
            //    //}
            //}
            //if (lstMetavalue.Count() > 0)
            //{
            //    lstMetavalue.Clear();
            //}
            returncode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVESTIGATION_FEE", out lstMetavalue);
            if (lstMetavalue.Count() > 0)
            {
                hdnTestCategory.Value = oJavaScriptSerializer.Serialize(lstMetavalue);
                hdnGroupCategory.Value = oJavaScriptSerializer.Serialize(lstMetavalue);
                //foreach (MetaValue_Common objMVC in lstMetavalue)
                //{
                //    LoadCategory += objMVC.Description + '~' + objMVC.Value + '~' + objMVC.Code + '^';
                //}
            }
            //if (String.IsNullOrEmpty(LoadCategory) && LoadCategory.Length > 0)
            //{
            //    hdnCategory.Value = LoadCategory;
            //    LoadCategory = "";
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }

    private void LoadDiscountMaster()
    {
        long returnCode = -1;
        List<DiscountMaster> lstDiscount = new List<DiscountMaster>();
        Master_BL DiscMaster = new Master_BL(base.ContextInfo);
        returnCode = DiscMaster.GetDiscountMaster(OrgID, out lstDiscount);
        grdResult.DataSource = lstDiscount;
        grdResult.DataBind();

    }
    private void LoadTaxmaster()
    {
        long returnCode = -1;
        List<Taxmaster> lsttaxmaster = new List<Taxmaster>();
        Master_BL taxmas = new Master_BL(base.ContextInfo);
        returnCode = taxmas.GetTaxMaster(OrgID, out lsttaxmaster);
        GrdTaxmaster.DataSource = lsttaxmaster;
        GrdTaxmaster.DataBind();
    }
  

    public void LoadTODDetails()
    {
        try
        {
            long returnCode = -1;
          
          
            List<DiscountPolicy> lstDisCountPolicy = new List<DiscountPolicy>();
            Master_BL objMaster = new Master_BL(base.ContextInfo);       
            string Code = TODCode.Text;
            returnCode = objMaster.GetCustomerTODdetails(OrgID,Code, out lstDisCountPolicy);          
            foreach (DiscountPolicy objDiscount in lstDisCountPolicy)
            {
                //CODE CHAGES BY PREM DISCOUNT POLICY TABLE STRUCTURE CHANGED
                hdnTODdetails.Value += objDiscount.TODID.ToString() +'~'+ objDiscount.RangeFrom + '~' + objDiscount.RangeTo + '~' + objDiscount.Value + '~' + objDiscount.Code.ToString() + '~'+objDiscount.BasedOn.ToString() + '~' +objDiscount.IsActive.ToString() + '~' + objDiscount.FeeID.ToString() +'~' + objDiscount.FeeType.ToString() + '~' + objDiscount.Name +'^';
                hdnInvID.Value = objDiscount.FeeID.ToString();
                hdnInvType.Value = objDiscount.FeeType.ToString();
                if (!String.IsNullOrEmpty(objDiscount.Name) && objDiscount.Name.Length >0)
                {
                    hdnInvName.Value = objDiscount.Name.ToString();
                }
            }
            //END
            if (!String.IsNullOrEmpty(hdnInvID.Value) && hdnInvID.Value != "0")
            {
                drpTODType.SelectedValue = "Vol";
                //TxtInv.Text = hdnInvName.Value;
                lblInvType.Text = hdnInvType.Value;

                TxtInv.Style.Add("display", "block");
                lblInvType.Style.Add("display", "block");
                lblInv.Style.Add("display", "block");
            }
            else
            {
                drpTODType.SelectedValue = "Rev";
                TxtInv.Text = "";
                lblInvType.Text = "";

                TxtInv.Style.Add("display", "none");
                lblInvType.Style.Add("display", "none");
                lblInv.Style.Add("display", "none");

            }
          
            if (hdnTODdetails.Value == "")
            {
               
                if (drpTODType.SelectedValue != "Vol")
                {
                    lblInv.Style.Add("Display", "none");
                    TxtInv.Style.Add("Display", "none");
                }
                else
                {
                    lblInv.Style.Add("Display", "Block");
                    TxtInv.Style.Add("Display", "Block");

                }
            }
            else
            {
                hdnTodID.Value = lstDisCountPolicy[0].TODID.ToString();
               

            }
            if (lstDisCountPolicy.Count != 0)
            {
                drpTODType.Enabled = false;
            }
            else
            {
                drpTODType.Enabled = true;
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:GenerateTable();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetCustomerTODdetails()", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string UserDisplayText = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Saved Successfully." : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
        string UserHeaderText = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;

        try
        {
            long returncode = -1;
            DiscountMaster DisMaster = new DiscountMaster();
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            DisMaster.DiscountName = txtDiscountName.Text;
            DisMaster.Discount = Convert.ToDecimal(txtDiscountValue.Text);
            DisMaster.Code = txtDiscountCode.Text;
            DisMaster.DiscountID = 0;
            DisMaster.DiscountPercentage = txtDiscountValue.Text + "%";
            
            if (HdnID.Value != "")
            {
                DisMaster.DiscountID = Convert.ToInt32(HdnID.Value);
            }
            returncode = Master_BL.InsertDiscountMaster(OrgID, DisMaster);
            if (returncode > 0)
            {
                LoadAllTypes();
                HdnID.Value = "";
                divInv.Attributes.Add("Style", "display:block");
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('"+Save_Message+"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Saved successfully.');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute InsertDiscountMaster()", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        LoadDiscountMaster();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('DIS'" + ',' + "'1');", true);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            returncode = Master_BL.DeleteDiscountMaster(OrgID, Convert.ToInt32(HdnID.Value));
            HdnID.Value = "";
            LoadAllTypes();
            divInv.Attributes.Add("Style", "display:block");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute DeleteDiscountMaster()", ex);
        }
    }
    protected void btnSaveTax_Click(object sender, EventArgs e)
    {
        string UserDisplayText = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Saved Successfully." : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
        string UserHeaderText = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;
        try
        {
            long returncode = -1;
            List<Taxmaster> lstTax = new List<Taxmaster>();
            Taxmaster taxmaster = new Taxmaster();
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            taxmaster.TaxName = txtTaxName.Text;
            taxmaster.TaxPercent = Convert.ToDecimal(txtPercent.Text);
            taxmaster.CreatedBy = LID;
            taxmaster.ModifiedBy = LID;
            taxmaster.Code = txttaxCode.Text;
            taxmaster.ReferenceType = drpRefType.SelectedValue;
            if (hdnTaxID.Value != "")
            {
                taxmaster.TaxID = Convert.ToInt32(hdnTaxID.Value);
            }
            returncode = Master_BL.InsertTaxMaster(OrgID, taxmaster);
            if (returncode > 0)
            {
                LoadAllTypes();
                divTaxmaster.Style.Add("display", "block");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('TAX'" + ',' + "'1');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Saved successfully.');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('"+Save_Message+"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "reset Tax", "javascript:ResetTaxField();", true);
            } 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute InsertTaxMaster()", ex);
        }
    }
    protected void GrdTaxmaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Taxmaster tax = (Taxmaster)e.Row.DataItem;
            string scrpt = "getrowid('" + ((RadioButton)e.Row.FindControl("rdoTaxMaster")).ClientID + "','" + tax.TaxID + "','" + tax.TaxName + "','" + tax.TaxPercent + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdoTaxMaster")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdoTaxMaster")).Attributes.Add("onclick", scrpt);
        }
    }
    protected void btnDeleteTax_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1; 
            Master_BL Master_BL = new Master_BL(base.ContextInfo); 
            returncode = Master_BL.DeleteTaxMaster(OrgID, Convert.ToInt32(hdnTaxID.Value));
            divTaxmaster.Attributes.Add("Style", "display:block");
            LoadAllTypes();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute DeleteTaxMaster()", ex);
        }
    }
    protected void btnSaveTOD_Click(object sender, EventArgs e)
    {
        string UserDisplayText = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Save_Message" : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
        string UserHeaderText = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;
        try
        {
            using (Master_BL Master_BL = new Master_BL(base.ContextInfo))
            {

                long returncode = -1;
                List<DiscountPolicy> lstDisPol = new List<DiscountPolicy>();
                DiscountPolicy obj1 = new DiscountPolicy();
                //CODE CHAGES BY PREM DISCOUNT POLICY TABLE STRUCTURE CHANGED

                foreach (string O in hdnTODdetails.Value.Split('^'))
                {
                    if (O != string.Empty)
                    {
                        

                        if (O.Split('~')[1] != string.Empty)
                        {

                            obj1.RangeFrom =Convert.ToInt64(O.Split('~')[1]);

                        }
                        if (O.Split('~')[2] != string.Empty)
                        {

                            obj1.RangeTo =Convert.ToInt64(O.Split('~')[2]);

                        }
                        if (O.Split('~')[3] != string.Empty)
                        {
                            obj1.Value =Convert.ToDecimal(O.Split('~')[3]);
                        }
                        if (O.Split('~')[6] != string.Empty)
                        {
                            obj1.IsActive = O.Split('~')[6];
                        }

                        if (O.Split('~')[7] != string.Empty && O.Split('~')[7] != "0")
                        {
                           obj1.FeeID =Convert.ToInt64(O.Split('~')[7]);
                        }

                        if (O.Split('~')[8] != string.Empty)
                        {
                            obj1.FeeType = O.Split('~')[8];
                        }

                        if (O.Split('~')[9] != string.Empty)
                        {
                            obj1.Name = O.Split('~')[9];
                        }
                        obj1.Code = TODCode.Text.ToUpper();
                        obj1.BasedOn = drpTODType.SelectedValue.ToString();                                         
                        obj1.TODID = Convert.ToInt32(hdnTodID.Value.ToString());
                        obj1.OrgID = OrgID;
                        obj1.CreatedBy = LID;
                        obj1.ModifiedBy = LID;
                        lstDisPol.Add(obj1);
                        obj1 = new DiscountPolicy();


                    }
                }

                //END
              
                returncode = Master_BL.SaveTurnOverDiscountDetail(OrgID, lstDisPol);
                txtFrom.Text = "";
                txtTo.Text = "";
                TODCode.Text = "";
                txtPercentage.Text = "";
                hdnTodID.Value = "0";
                hdnInvID.Value = "0";
                hdnInvName.Value = "";
                hdnInvType.Value = "";
                hdnSelectedTest.Value = "";
                drpTODType.SelectedIndex = 0;
                if (returncode >= 0 && returncode != -1)
                {
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:alert('"+Save_Message+"');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                    //ScriptManager.RegisterStartupScript(Page,this.GetType(),"alt1","javascript:alert('Saved successfully.');", true);
                    hdnTODdetails.Value = "";
                    hdnTODiscount.Value = "";
                    tdTodTable.Attributes.Add("style", "none");
                    divInv.Attributes.Add("display", "none");
                    divTaxmaster.Attributes.Add("display", "none");
                    divTurnovrDisc.Attributes.Add("display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('TOD'" + ',' + "'1');", true);
                    TODCode.Enabled = true;
                    drpTODType.Enabled = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute SaveTurnOverDiscountDetail()", ex);
        }
    }
     
    protected void TODCode_TextChanged(object sender, EventArgs e)
    {
        divTurnovrDisc.Style.Add("Display", "Block");
        hdnTODiscount.Value = "";
        LoadTODDetails();
        TODCode.Enabled = false;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:DisplayTab('TOD'" + ',' + "'0');", true);
    }
    
}