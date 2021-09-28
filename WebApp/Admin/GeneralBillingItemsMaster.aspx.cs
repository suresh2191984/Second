using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;

public partial class Admin_GeneralBillingItemsMaster : BasePage
{
    //public string Save_Message = Resources.AppMessages.Save_Message;

    public Admin_GeneralBillingItemsMaster()
        : base("Admin_GeneralBillingItemsMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long Returncode = -1;
    //AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
    RateTypeMaster RTM = new RateTypeMaster();

    List<RateTypeMaster> lstRateTypeMaster = new List<RateTypeMaster>();
    List<RateMaster> lstRateMaster = new List<RateMaster>();
    List<GeneralBillingMaster> GBI = new List<GeneralBillingMaster>();

    string Yes = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_0030 == null ? "YES" : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_0030;
    string No = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_0031 == null ? "NO" : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_0031; 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                loadItemRate();
                LoadMeatData();
                // loadRateType();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RateType Page Loading", ex);
        }

    }
    protected void grdResult_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    //public void loadRateType()
    //{
    //    try

    //    {
    //        Master_BL MasterBL = new Master_BL(base.ContextInfo);
    //        Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
    //        ddlRateName.DataSource = lstRateMaster;
    //        ddlRateName.DataTextField = "RateName";
    //        ddlRateName.DataValueField = "RateId";
    //        ddlRateName.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in load data", ex);
    //    }
    //}

   

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            GeneralBillingMaster IOM = (GeneralBillingMaster)e.Row.DataItem;
            string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + IOM.GenBillID + "','" + IOM.GenBillName + "','" + IOM.IsDefaultBilling + "','" + IOM.IsDiscountable + "','" + IOM.IsTaxable + "','" + IOM.IsVariable + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }


    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        loadItemRate();
    }


    protected void btnsave_Click1(object sender, EventArgs e)
    {
        string AlrtWin = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01 == null ? "Information" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_01;
        string UsrAlrt = Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003 == null ? "Save Successfully..!!" : Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_003;
        string UserDispUpdate = Resources.Admin_AppMsg.Admin_Analyzer_aspx_Update == null ? "Update" : Resources.Admin_AppMsg.Admin_Analyzer_aspx_Update;
        try
        {
            long returncode = -1;
            Master_BL GBIBL = new Master_BL(base.ContextInfo);
            GeneralBillingMaster GBM = new GeneralBillingMaster();
           
            GBM.GenBillName = txtItemName.Text;
            GBM.GenBillID = 0;
            GBM.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            GBM.CreatedBy = LID;
            GBM.OrgID = OrgID;
            if (CheckBoxList1.Items[0].Selected)
            {
                GBM.IsDefaultBilling = "Y";
 
            }
            else
            {
                GBM.IsDefaultBilling = "N";
            }


            if (CheckBoxList1.Items[1].Selected)
            {
                GBM.IsDiscountable = "Y";

            }
            else
            {
                GBM.IsDiscountable = "N";
            }
            if (CheckBoxList1.Items[2].Selected)
            {
                GBM.IsTaxable = "Y";


            }
            else
            {
                GBM.IsTaxable = "N";
            }

            if (CheckBoxList1.Items[3].Selected)
            {
                GBM.IsVariable = "Y";
            }
            else
            {
                GBM.IsVariable = "N";
            }
            //GBM.IsDefaultBilling = chkIsDefaultBilling.Checked == true ? "Y" : "N";
            //GBM.IsDiscountable = chkIsDiscountable.Checked == true ? "Y" : "N";
            //GBM.IsTaxable = chkIsTaxable.Checked == true ? "Y" : "N";

            //string isTaxable = chkIsTaxable.Checked == true ? "Y" : "N";
            //string isDiscountable = chkIsDiscountable.Checked == true ? "Y" : "N";
            //string isDefaultBill = chkIsDefaultBilling.Checked == true ? "Y" : "N";
            //GBI.RateID = Convert.ToInt32(ddlRateName.SelectedItem.Value);
            //GBI.IPAmount = Convert.ToDecimal(txtIpAmount.Text);
            if (HdnitemID.Value != "")
            {
                GBM.GenBillID = Convert.ToInt32(HdnitemID.Value);
            }

            returncode = GBIBL.InsertGeneralBillingMaster(GBM);
            //Response.Redirect("GeneralBillingItemsMaster.aspx",true);
            cleare();
            loadItemRate();
            if (hdnbtnsave.Value == UserDispUpdate)//"Update")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrAlrt + "','" + AlrtWin + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('"+Save_Message+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('"+Save_Message+"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrAlrt + "','" + AlrtWin + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            hdnbtnsave.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnsave_Click1", ex);
        }


    }
    private void loadItemRate()
    {
        try
        {
            long returnCode = -1;
            List<GeneralBillingMaster> GBI = new List<GeneralBillingMaster>();
           // List<RateMaster> lstrate = new List<RateMaster>();
            
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returnCode = MasterBL.GetGeneralBillingMaster(OrgID, out GBI);                   
            if (GBI.Count > 0)
            {
                for (int i = 0; i < GBI.Count; i++)
                {
                    string isdef=GBI[i].IsDefaultBilling;
                    string isdis = GBI[i].IsDiscountable;
                    string istax = GBI[i].IsTaxable;
                    string isvar = GBI[i].IsVariable;
                    if (isdef == "Y")
                    {
                        GBI[i].IsDefaultBilling = Yes;
                    }
                    else if (isdef == "N")
                    {
                        GBI[i].IsDefaultBilling = No;
                    }
                    if (isdis == "Y")
                    {
                        GBI[i].IsDiscountable = Yes;
                    }
                    else if (isdis == "N")
                    {
                        GBI[i].IsDiscountable = No;
                    }
                    if (istax == "Y")
                    {
                        GBI[i].IsTaxable = Yes;
                    }
                    else if (istax == "N")
                    {
                        GBI[i].IsTaxable = No;
                    }
                    if (isvar == "Y")
                    {
                        GBI[i].IsVariable = Yes;
                    }
                    else if (isvar == "N")
                    {
                        GBI[i].IsVariable = No;
                    }

                }
            }
            grdResult.DataSource = GBI;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Item Rate", ex);
        }
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        ////txtItemName.Text = string.Empty;
        ////txtRate.Text = string.Empty;
        ////HdnitemID.Value = string.Empty;
        ////HdnrateID.Value = string.Empty;
        ////txtIpAmount.Text = string.Empty;
        ////ddlRateName.Items.Clear();
        Response.Redirect("GeneralBillingItemsMaster.aspx");
        //cleare();

    }

    protected void cleare()
    {
        txtItemName.Text = string.Empty;
        //txtRate.Text = string.Empty;
        HdnitemID.Value = string.Empty;
        HdnrateID.Value = string.Empty;
        
        //txtIpAmount.Text = string.Empty;
        //ddlRateName.Items.Clear();
        foreach (ListItem lstItem in CheckBoxList1.Items)
        {
          lstItem.Selected=false;
        }
    }

    # region Jagatheesh added to Listbox items

    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;

            string domains = "BillItemMasterChk";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs 
                                 where child.Domain == "BillItemMasterChk"  
                                 select child;
                if (childItems.Count() > 0)
                {
                    CheckBoxList1.DataSource = childItems;
                    CheckBoxList1.DataTextField = "DisplayText";
                    CheckBoxList1.DataValueField = "Code";
                    CheckBoxList1.DataBind();

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }





    #endregion
}
