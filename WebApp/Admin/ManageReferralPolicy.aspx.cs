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
public partial class Admin_ManageReferralPolicy : BasePage
{
    public string Save_Message = Resources.AppMessages.Save_Message;
    public Admin_ManageReferralPolicy()
        : base("Admin\\ManageReferralPolicy.aspx")
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

                txtCategoryCode.Text = "";
                Loadreferralpolicy();
            }
          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error during Page load", ex);
        }
    }


    private void LoadAllTypes()
    {

        txtPercentage.Text = string.Empty;
        txtFrom.Text = string.Empty;
        txtTo.Text = string.Empty;
        LoadMetaData();
        LoadCoupon();
    }

    private void LoadCoupon()
    {
        long returnCode = -1;
        List<CouponMaster> lstCouponMaster = new List<CouponMaster>();
        List<CouponDetails> lstCouponDetails = new List<CouponDetails>();
        Master_BL objCouponMaster = new Master_BL(base.ContextInfo);
        returnCode = objCouponMaster.GetCoupon(OrgID, out lstCouponMaster, out lstCouponDetails);
        List<CouponMaster> lstCouponCode = new List<CouponMaster>();
        lstCouponCode = lstCouponMaster;
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "Manage Referral Policy";
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
                                 where child.Domain == "Manage Referral Policy" //orderby child .MetaDataID
                                 select child;
                drpRefpolicyType.DataSource = childItems;
                drpRefpolicyType.DataTextField = "DisplayText";
                drpRefpolicyType.DataValueField = "Code";
                drpRefpolicyType.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }

    protected void btnSavePolicy_Click(object sender, EventArgs e)
    {
        try
        {
            using (Master_BL Master_BL = new Master_BL(base.ContextInfo))
            {

                long returncode = -1;
                List<ManageReferralPolicy> lstpolicy = new List<ManageReferralPolicy>();
                ManageReferralPolicy obj1 = new ManageReferralPolicy();
                foreach (string O in hdnRefpolicyDetails.Value.Split('^'))
                {
                    if (O != string.Empty)
                    {
                        if (O.Split('~')[0] != string.Empty)
                        {
                            obj1.CategoryName = Convert.ToString(O.Split('~')[0]);
                        }
                        if (O.Split('~')[1] != string.Empty)
                        {
                            obj1.Fromrange = Convert.ToInt64(O.Split('~')[1]);
                        }
                        if (O.Split('~')[2] != string.Empty)
                        {
                            obj1.Torange = Convert.ToInt64(O.Split('~')[2]);
                        }
                        if (O.Split('~')[3] != string.Empty)
                        {
                            obj1.Payout = Convert.ToInt64(O.Split('~')[3]);
                        }
                        if (O.Split('~')[4] != string.Empty)
                        {
                            string ddlval = Convert.ToString(O.Split('~')[4]);
                            if (ddlval == "Billed Amount")
                            {
                                obj1.Payon = 1;
                            }
                            else
                            {
                                obj1.Payon = 2;
                            }
                        }

                        //obj1.CategoryName = txtCategoryCode.Text.ToUpper();
                        //string ddlval = drpRefpolicyType.SelectedValue.ToString();
                        //if (ddlval == "BilledAmount")
                        //{
                        //    obj1.Payon = 0;
                        //}
                        //else
                        //{
                        //    obj1.Payon = 1;
                        //}
                        obj1.OrgID = OrgID;
                        obj1.Createdby = LID;
                        obj1.Modifiedby = LID;
                        lstpolicy.Add(obj1);
                        obj1 = new ManageReferralPolicy();


                    }
                }
                returncode = Master_BL.SaveReferrealPolicy(OrgID, lstpolicy);
                txtFrom.Text = "";
                txtTo.Text = "";
                txtCategoryCode.Text = "";
                txtPercentage.Text = "";

                drpRefpolicyType.SelectedIndex = 0;
                if (returncode >= 0 && returncode != -1)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:alert('" + Save_Message + "');", true);
                    hdnRefpolicyDetails.Value = "";
                    //tdtblRowCnt.Attributes.Add("style", "none");                   
                    divTurnovrDisc.Attributes.Add("display", "block");
                    Response.Redirect("ManageReferralPolicy.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while execute SaveTurnOverDiscountDetail()", ex);
        }
    }

    private void Loadreferralpolicy()
    {
        long returnCode = -1;
        Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
        List<ManageReferralPolicy> lstManageReferralPolicy = new List<ManageReferralPolicy>();
        try
        {
            string Payon = string.Empty;
            returnCode = objMaster_BL.Getreferralpolicy(out lstManageReferralPolicy);
            int i = 1;
            foreach (ManageReferralPolicy objDiscount in lstManageReferralPolicy)
            {

                switch (objDiscount.Payon)
                {
                    case 1:
                        Payon = "Billed Amount";
                        break;
                    case 2:
                        Payon = "Net Amount";
                          break;
                    default:
                          Payon = "";
                        break;
                }
               
                hdnRefpolicyDetails.Value += objDiscount.CategoryName.ToString() + '~' + objDiscount.Fromrange + '~' + objDiscount.Torange
                    + '~' + objDiscount.Payout + '~' + Payon + '~'+i+'^';
                i++;
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:GenerateTable();", true);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Getreferralpolicy ", ex);
        }




    }
}
