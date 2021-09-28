using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.IO;
using System.Xml.XPath;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class Admin_ManageBulkData : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadInvGrpPkg();


        }
    }
    public void LoadInvGrpPkg()
    {

        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";


    }

    public void LoadDrpValues(object sender, EventArgs e)
    {

        long returnCode = -1;
        string InvName = hdnInvName.Value; ;
        int InvId = Convert.ToInt32(hdnInvID.Value);
        List<InvestigationBulkData> lstInvBulk = new List<InvestigationBulkData>();
        List<InvestigationBulkData> lstInvBulk1 = new List<InvestigationBulkData>();
        returnCode = new Master_BL(new BaseClass().ContextInfo).GetInvNames(InvId, InvName, out lstInvBulk, out lstInvBulk1);
        if ((lstInvBulk.Count > 0) && (lstInvBulk1.Count > 0))
        {

            fieldgrd.Visible = true;
            if (lstInvBulk1.Count > 0)
            {
                GrdInvDetails.DataSource = lstInvBulk1;
                GrdInvDetails.DataBind();
            }
            ddlname.DataSource = lstInvBulk;
            ddlname.DataTextField = "Name";
            ddlname.DataValueField = "InvestigationID";
            ddlname.DataBind();
        }
        else
        {
            fieldgrd.Visible = false;
            GrdInvDetails.DataSource = lstInvBulk1;
            GrdInvDetails.DataBind();
            lbldisplay.Visible = true;
        }


    }
    protected void txtTestName_TextChanged(object sender, EventArgs e)
    {
        hdnInvbulkValue.Value = string.Empty;
        fieldgrd.Visible = false;
        lbldisplay.Visible = false;
        LoadDrpValues(sender, e);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string InvName=string.Empty;
        int InvId = Convert.ToInt32(hdnInvID.Value);
        if (ddlname.SelectedValue.ToString()=="")
        {
            InvName = "Source";
        }
        else
        {
            InvName = ddlname.SelectedItem.ToString();
        }
        string Value = hdnInvbulkValue.Value;
      //  string Aflag = txtAflag.Text;

        List<InvestigationBulkData> lstInvBulkValues = new List<InvestigationBulkData>();
        // returnCode = new Master_BL(new BaseClass().ContextInfo).InsertInvValues(InvId, InvName,Value,Aflag , out lstInvBulkValues);
        
        foreach (string str in hdnInvbulkValue.Value.Split('^'))
        {
            if (str != "")
            {
                InvestigationBulkData obj = new InvestigationBulkData();
                obj.InvestigationID = InvId;
                obj.Name = InvName;
                obj.Value = str.ToString();

                lstInvBulkValues.Add(obj);
            }

        }
           
        
        returnCode = new Master_BL(new BaseClass().ContextInfo).InsertInvValues(lstInvBulkValues, out returnCode);
        LoadDrpValues(sender, e);
        if (returnCode == 0)
        {
            hdnInvbulkValue.Value = "";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Inserted Successfully!');", true);
        }
        else
        {
            hdnInvbulkValue.Value = "";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Not Inserted!');", true);
        }
        hdnInvbulkValue.Value = string.Empty;
    }
    protected void GrdInvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            int InvID = Convert.ToInt32(GrdInvDetails.DataKeys[e.RowIndex].Values[0]);

            string InvName = GrdInvDetails.DataKeys[e.RowIndex].Values[1].ToString();
            string InvValue = GrdInvDetails.DataKeys[e.RowIndex].Values[2].ToString();
            int InvStatus = Convert.ToInt32(GrdInvDetails.DataKeys[e.RowIndex].Values[3]);
            Master_BL objdel = new Master_BL(base.ContextInfo);
            string Commend = "Delete";
            returnCode = objdel.DeleteInvBulkData(InvID, InvName,InvValue ,InvStatus, Commend);
            LoadDrpValues(sender, e);
            if (returnCode >= 0)
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Deleted Successfully!');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete Consumable.aspx", ex);
        }

    }
    //protected void GrdInvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {

    //        if (e.CommandName == "Delete")
    //        {

    //            //  btnSave.Text = "Delete";

    //            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
    //            int InvID = GrdInvDetails.DataKeys[rowIndex]["InvestigationID"] != null ? (int)GrdInvDetails.DataKeys[rowIndex]["InvestigationID"] : 0;
    //            string InvName = GrdInvDetails.DataKeys[rowIndex]["Name"] != null ? (string)GrdInvDetails.DataKeys[rowIndex]["Name"] : string.Empty;
    //            string InvValue = GrdInvDetails.DataKeys[rowIndex]["Value"] != null ? (string)GrdInvDetails.DataKeys[rowIndex]["Value"] : string.Empty;
    //            int InvStatus = GrdInvDetails.DataKeys[rowIndex]["IsStatus"] != null ? (int)GrdInvDetails.DataKeys[rowIndex]["IsStatus"] : 0;

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Loading UpdateConsume()", ex);
    //    }
    //}

    protected void GrdInvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {

            GrdInvDetails.PageIndex = e.NewPageIndex;
        }
        LoadDrpValues(sender, e);

    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtTestName.Text = "";
        txtvalues.Text = "";
        //txtAflag.Text = "";
       // ddlname.SelectedItem.Text = "";
        fieldgrd.Visible = false;
        lbldisplay.Visible = false;
    }

    }
