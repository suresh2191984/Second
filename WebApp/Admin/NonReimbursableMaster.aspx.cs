using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;

public partial class Admin_NonReimbursableMaster : BasePage
{
    public Admin_NonReimbursableMaster()
        : base("Admin\\NonReimbursableMaster.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    long returnCode = -1;
    string vType = string.Empty;
    Report_BL objReport_BL;
    List<NonReimbursableItems> lstNonReimbursableItems;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                vType = "NRI";
                GetFeeType();
                GetClientName();
                GetTpaName();
                GetNonReimbursableForUpdate();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading NonReimbursableMaster Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    private void Save()
    {
        try
        {
            lstNonReimbursableItems = new List<NonReimbursableItems>();
            lstNonReimbursableItems = GetNonReimbursableItems();
            objReport_BL = new Report_BL(base.ContextInfo);
            objReport_BL.SaveNonReimbursableItems(OrgID, LID, lstNonReimbursableItems);
            string sPath = "Admin\\\\NonReimbursableMaster.aspx.cs_7";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('"+sPath+"');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('NonReimbursableItems Added Sucessfully');", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Save Method in NonReimbursableMaster.aspx.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page. Please contact system administrator";

        }

    }

    public List<NonReimbursableItems> GetNonReimbursableItems()
    {
        List<NonReimbursableItems> lstNonReimbursableItemsTemp = new List<NonReimbursableItems>();
        try
        {


            //parseInt(rwNumber) + "~" + NRItem + "~" + FeeType + "~" + FeeId + "~" + TpaType + "~" + TpaID + + "~" + FeeDesc +"^";
            foreach (string NRIItems in hdnNRItems.Value.Split('^'))
            {

                if (NRIItems != "")
                {
                    NonReimbursableItems objNRItems = new NonReimbursableItems();
                    string[] listChildNRI = NRIItems.Split('~');
                    objNRItems.FeeType = listChildNRI[2];
                    objNRItems.FeeID = Convert.ToInt64(listChildNRI[3]);
                    objNRItems.FeeDesc = listChildNRI[1];
                    objNRItems.FeeTypeDesc = listChildNRI[6];
                    objNRItems.ClientID = Convert.ToInt64(listChildNRI[5]);
                    objNRItems.TPAType = listChildNRI[4];
                    lstNonReimbursableItemsTemp.Add(objNRItems);

                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetNonReimbursableItems Method in NonReimbursableMaster.aspx.", ex);


        }

        return lstNonReimbursableItemsTemp;

    }

    private void GetNonReimbursableForUpdate()
    {
        try
        {
            lstNonReimbursableItems = new List<NonReimbursableItems>();
            objReport_BL = new Report_BL(base.ContextInfo);
            objReport_BL.GetNonReimbursableForUpdate(OrgID, 0, "", out lstNonReimbursableItems);

            hdnNRItems.Value = "";
            int i = 110;
            if (lstNonReimbursableItems.Count > 0)
            {
                foreach (NonReimbursableItems objNRI in lstNonReimbursableItems)
                {
                    //parseInt(rwNumber) + "~" + NRItem + "~" + FeeType + "~" + FeeId + "~" 
                    //+ TpaType + "~" + TpaID + + "~" + FeeDesc +"^";

                    hdnNRItems.Value += i + "~" + objNRI.FeeDesc + "~" + objNRI.FeeType + "~" + objNRI.FeeID + "~" + objNRI.TPAType + "~" + objNRI.ClientID + "~" + objNRI.FeeTypeDesc + "^";
                    i += 1;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetNonReimbursableForUpdate Method in NonReimbursableMaster.aspx.", ex);


        }


    }

    protected void GetFeeType()
    {
        try
        {
            List<FeeTypeMaster> lstFTM = new List<FeeTypeMaster>();
            returnCode = new BillingEngine(base.ContextInfo).GetFeeType(OrgID, vType, out lstFTM);
            if (lstFTM.Count > 0)
            {

                rblFeeTypes.DataSource = lstFTM;
                rblFeeTypes.DataTextField = "FeeTypeDesc";
                rblFeeTypes.DataValueField = "FeeType";
                rblFeeTypes.DataBind();
                rblFeeTypes.SelectedIndex = 0;
                hdnFeeType1.Value = rblFeeTypes.SelectedValue.ToString();

                AutoCompleteExtender3.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString();

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetFeeType Method in NonReimbursableMaster.aspx.", ex);


        }
    }

    protected void GetClientName()
    {
        try
        {
            List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
            new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
            if (Clientmaster.Count > 0)
            {
                ddlCorporate.DataSource = Clientmaster;
                ddlCorporate.DataTextField = "ClientName";
                ddlCorporate.DataValueField = "ClientID";
                ddlCorporate.DataBind();

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetClientName Method in NonReimbursableMaster.aspx.", ex);


        }

    }

    protected void GetTpaName()
    {
        try
        {
            List<TPAMaster> lTpaMaster = new List<TPAMaster>();
            new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lTpaMaster);
            ddlTpaName.DataSource = lTpaMaster;

            ddlTpaName.DataTextField = "TPAName";
            ddlTpaName.DataValueField = "TPAID";
            ddlTpaName.DataBind();

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While GetTpaName Method in NonReimbursableMaster.aspx.", ex);


        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Save();
            GetNonReimbursableForUpdate();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadNRItems();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While btnSave_Click  in NonReimbursableMaster.aspx.", ex);

        }
    }
}
