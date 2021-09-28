
using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.IO;
using System.Linq;
using Attune.Podium.PerformingNextAction;

public partial class Reception_EmployeeIntimation : BasePage
{
    public Reception_EmployeeIntimation()
        : base("Reception\\EmployeeIntimation.aspx")
    {
    }
    
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnOrgId.Value = OrgID.ToString();
            CommentDetails();
            Clear();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            long returnCode = -1;
            List<AddressDetails> lstAddressDetails = new List<AddressDetails>();
            string Strnotifyto = ddlnotifyto.SelectedItem.Value == "0" ? "" : ddlnotifyto.SelectedItem.Value;
            if (btnSave.Text == "Update" && !string.IsNullOrEmpty(hdnConfigID.Value.ToString()))
            {
                int ID = Convert.ToInt32(hdnConfigID.Value);
                returnCode = masterbl.InsertEmployeeEmailSms(OrgID, ID, ddlType.SelectedItem.Text, ddlCatagory.SelectedItem.Value, txtValues.Text, LID, Strnotifyto);
                ddlCatagory.Enabled = true;
                ddlType.Enabled = true;
                ddlnotifyto.Enabled = true;
                btnSave.Text = "Save";
                CommentDetails();
            }
            else
            {
                bool errorFlag = false;
                if (grdResult.Rows.Count == 0)
                {
                    int ID = 0;
                    if (!string.IsNullOrEmpty(txtValues.Text))
                    {
                       
                        returnCode = masterbl.InsertEmployeeEmailSms(OrgID, ID, ddlType.SelectedItem.Text, ddlCatagory.SelectedItem.Value, txtValues.Text, LID, Strnotifyto);
                        CommentDetails();
                    }
                    else
                    {
                        ddlCatagory.SelectedIndex = 0;
                        ddlType.SelectedIndex = 0;
                        ddlnotifyto.SelectedIndex = 0;
                    }
                }
                else
                {
                    foreach (GridViewRow row in grdResult.Rows)
                    {
                        string Strnotifyto1 = ((Label)row.FindControl("lblnotifyto")).Text == "" ? "0" : ((Label)row.FindControl("lblnotifyto")).Text;
                        if (((Label)row.FindControl("lblOrgID")).Text == OrgID.ToString() && ((Label)row.FindControl("lblType")).Text == ddlType.SelectedValue.ToString() && Strnotifyto1 == ddlnotifyto.SelectedValue.ToString() && ((Label)row.FindControl("lblCategory")).Text == ddlCatagory.SelectedValue.ToString())//surya changes
                        {
                            errorFlag = false;
                            break;
                        }
                        else
                        {
                            errorFlag = true;
                        }
                    }
                    if (errorFlag)
                    {
                        int ID = 0;
                       
                        returnCode = masterbl.InsertEmployeeEmailSms(OrgID, ID, ddlType.SelectedItem.Text, ddlCatagory.SelectedItem.Value, txtValues.Text, LID, Strnotifyto);
                        CommentDetails();
                    }
                    else {
                           ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Already Exist');", true);
                    }
                }
            }
           //Clear();
            btnSave.Text = "Save";
            ddlnotifyto.SelectedValue = "0";
            ddlType.SelectedValue = "0";
            ddlCatagory.SelectedValue = "0";
            txtValues.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdResult.PageIndex = e.NewPageIndex;
        CommentDetails();
    }

    private void CommentDetails()
    {
        try
        {
            //Clear();
            long returnCode = 0;
            List<AddressDetails> listCommunication = new List<AddressDetails>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
           returnCode = masterbl.GetEmployeeEmailSms(OrgID, out listCommunication);

            if (listCommunication.Count > 0)
            {
                grdResult.DataSource = listCommunication;
                grdResult.DataBind();
            }
            else
            {
                grdResult.DataSource = null;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);

        }

    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Del")
        {
            var comArgs = e.CommandArgument.ToString().Split('^');
            int ID = Convert.ToInt32(comArgs[0]);
            int OrgID = Convert.ToInt32(Session["OrgID"].ToString());
            long LID = Convert.ToInt64(Session["LID"].ToString());

            long returnCode = -1;
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<AddressDetails> lstAddressDetails = new List<AddressDetails>();
            returnCode = masterbl.InsertEmployeeEmailSms(OrgID, ID, comArgs[1].ToString(), "1", comArgs[3].ToString(), LID,comArgs[4].ToString());
            grdResult.EditIndex = -1;
            CommentDetails();

        }
        else
        {
            var comArgs = e.CommandArgument.ToString().Split('^');
            //grdResult.EditIndex = e.NewEditIndex;
            //CommentDetails();
            //hdnConfigID.Value = ((Label)grdResult.Rows[e.].FindControl("lblCommId")).Text;
            //string value = ((Label)grdResult.Rows[e.NewEditIndex].FindControl("lblComments")).Text;
            //var Catagory = ((Label)grdResult.Rows[e.NewEditIndex].FindControl("lblCategory")).Text;
            //var Type = ((Label)grdResult.Rows[e.NewEditIndex].FindControl("lblType")).Text;
            hdnConfigID.Value = comArgs[0].ToString();
            txtValues.Text = comArgs[3].ToString();
            ddlCatagory.SelectedValue = comArgs[1].ToString();
            ddlCatagory.Enabled = false;
            ddlType.SelectedValue = comArgs[2].ToString();
            ddlType.Enabled = false;
            ddlnotifyto.SelectedValue = comArgs[4].ToString() == "" ? "0" : comArgs[4].ToString();
            ddlnotifyto.Enabled = false;
            btnSave.Text = "Update";
        }


    }

    /*AB Code For Communication Details*/
    /*
    protected void grdResult_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {

            GridViewRow row = (GridViewRow)grdResult.Rows[e.RowIndex];
            Label flag = (Label)row.FindControl("lblCommId");
            int ID = Convert.ToInt32(flag.Text);
            TextBox t1 = (TextBox)row.FindControl("grdtxtComments");
            string values = t1.Text.ToString();


            int OrgID = Convert.ToInt32(Session["OrgID"].ToString());
            long LID = Convert.ToInt64(Session["LID"].ToString());
            Label catagory = (Label)row.FindControl("lblCategory");
            Label Types = (Label)row.FindControl("lblType");
            
            long returnCode = -1;
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<AddressDetails> lstAddressDetails = new List<AddressDetails>();
            returnCode = masterbl.InsertEmployeeEmailSms(OrgID, ID, catagory.Text, Types.Text, values, LID);
            grdResult.EditIndex = -1;
            CommentDetails();


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);

        }
    }
    */
    /*AB Code For Communication Details*/
    /*
    protected void grdResult_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        grdResult.EditIndex = -1;
        CommentDetails();

    }
    */
    private void Clear()
    {

        long returncode=-1;
         string domains1 = "AlertNotification";
            string[] Tempdata1 = domains1.Split(',');
            string LangCode1 = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta1;

            for (int i = 0; i < Tempdata1.Length; i++)
            {
                objMeta1 = new MetaData();
                objMeta1.Domain = Tempdata1[i];
                lstmetadataInputs.Add(objMeta1);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode1, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "AlertNotification"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlCatagory.DataSource = childItems;
                    ddlCatagory.DataTextField = "DisplayText";
                    ddlCatagory.DataValueField = "Code";
                    ddlCatagory.DataBind();
                    ddlCatagory.Items.Insert(0, "--Select--");
                    ddlCatagory.Items[0].Value = "0";
                    //ddlCatagory.SelectedValue = "0";
                }
            }


        //ddlCatagory.Items.Clear();
        //ddlType.Items.Clear();
        //ddlCatagory.Items.Add(new ListItem("Critical", "CriticalAlert"));
        //ddlCatagory.Items.Add(new ListItem("Reject", "Reject"));
        //ddlCatagory.Items.Add(new ListItem("Recollect", "Recollect"));
        //ddlCatagory.Items.Add(new ListItem("Reflex", "Reflex"));

            //ddlCatagory.Items.Add(new ListItem("--Select--", "0"));
            //ddlCatagory.SelectedValue = "0";
            ddlType.Items.Add(new ListItem("--Select--", "0"));
            ddlType.SelectedValue = "0";
            ddlType.Items.Add(new ListItem("Email", "Email"));
            ddlType.Items.Add(new ListItem("Sms", "Sms"));
            ddlnotifyto.Items.Add(new ListItem("--Select--", "0"));
            ddlnotifyto.SelectedValue = "0";
            ddlnotifyto.Items.Add(new ListItem("CC", "CC"));
            ddlnotifyto.Items.Add(new ListItem("BCC", "BCC"));
            txtValues.Attributes.Add("onblur", "NumberOnlyTextBox(event)");
        txtValues.Text = "";
    }
    /*
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkEdit = (LinkButton)e.Row.FindControl("btnedit");
            lnkEdit.Text = "Update";
        }
    }
    */

}

