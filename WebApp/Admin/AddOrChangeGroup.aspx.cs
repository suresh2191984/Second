using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Globalization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Serialization;
using System.IO;
using Attune.Podium.BillingEngine;
public partial class Admin_AddOrChangeGroup : BasePage
{
    public Admin_AddOrChangeGroup()
        : base("Admin_AddOrChangeGroup_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string IsActive = string.Empty;
    string ValueIsActive = string.Empty;
    string SysLock = string.Empty;
    string strSelect = string.Empty;
    string strAdd = string.Empty;
    string strUpdate = string.Empty;
    string strAlert = string.Empty;
    string strSuccess = string.Empty;
    string strError = string.Empty;
    string strExit = string.Empty;
    string strSaved = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        strSelect = Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_03 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_03;
         strAdd = Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02 == null ? "ADD" : Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02;
          strUpdate = Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02;
           strAlert = Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_Alert;
            strSuccess = Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_10 == null ? "Successfully Updated" : Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_10;
            strError = Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_11 == null ? "Error While Saving Data" : Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_11;
            strExit = Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_12 == null ? "Given Code Already Exist" : Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_12;
            strSaved = Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_13 == null ? "Saved Successfully" : Resources.Admin_AppMsg.Admin_AddOrChangeGroup_aspx_13;

        if (!Page.IsPostBack)
        {
            LoadMeta();
            LoadValue();
            LoadMetaValuename();
            drpMetaTypeName();
            rdogrpvaluemaster.Checked = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "rdocheck();", true);
        }
    }


    public void drpMetaTypeName()
    {
        long ReturnCode = -1;
        Patient_BL PatientBL = new Patient_BL(base.ContextInfo);
        List<MetaType_Common> lstMeta = new List<MetaType_Common>();
        string prefixtext = string.Empty;
        int TypeID = 0;
        ReturnCode = PatientBL.GetMetaName(OrgID, prefixtext, TypeID, out lstMeta);

        if (lstMeta.Count > 0)
        {
            drpGroupType.DataSource = lstMeta;
            drpGroupType.DataTextField = "TypeName";
            drpGroupType.DataValueField = "MetaTypeId";
            drpGroupType.DataBind();
            drpGroupType.Items.Insert(0, strSelect);


        }


    }




    public void LoadMeta()
    {

        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";

    }

    public void LoadMetaValuename()
    {

        AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~";

    }

    public void LoadValue()
    {

        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~";

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblmsg.Visible = false;
        divGrid.Style.Add("display", "none");
        divgroup.Style.Add("display", "block");
        divGroupOrgMap.Style.Add("display", "none");
        divgrpvalue.Style.Add("display", "none");
        long Returncode = -1;
        List<MetaType_Common> lstMeta = new List<MetaType_Common>();
        Patient_BL patient = new Patient_BL(base.ContextInfo);

        if (hdnMetaID.Value == "")
        {
            hdnMetaID.Value = "-1";
        }
        if (hdnMetaID.Value == "0")
        {
            hdnMetaID.Value = "-1";
        }
        string prefixtext = string.Empty;
        Returncode = patient.GetMetaName(OrgID, prefixtext, Convert.ToInt32(hdnMetaID.Value), out lstMeta);
        if (lstMeta.Count > 0)
        {

            txtcode.Text = lstMeta[0].Code;

            txtdescrip.Text = lstMeta[0].Description;
            if (lstMeta[0].IsActive == "Y")
            {
                chkActive.Checked = true;

            }
            else
            {
                chkActive.Checked = false;

            }
            if (lstMeta[0].SystemLevel == "Y")
            {
                txtgroup.Text = lstMeta[0].TypeName;
                txtcode.Enabled = false;
                chkSystem.Checked = true;
                chkSystem.Enabled = true;

            }
            else
            {
                txtgroup.Text = lstMeta[0].TypeName;
                txtcode.Enabled = true;
                chkSystem.Checked = false;
                chkSystem.Enabled = true;

            }
            //btnAdd.Text = "Update";
            btnAdd.Text = strUpdate;


        }
        else
        {
            txtcode.Text = "";
            txtdescrip.Text = "";
            //btnAdd.Text = "ADD";
            btnAdd.Text = strAdd;
            chkSystem.Enabled = true;
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {

        lblmsg1.Visible = false;

        if (chkActive.Checked == true)
        {
            IsActive = "Y";
        }
        else
        {
            IsActive = "N";
        }
        if (chkSystem.Checked == true)
        {
            SysLock = "Y";

        }

        else
        {
            SysLock = "N";
        }


        if (btnAdd.Text == "Update")
        {
            long ReturnCode = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            ReturnCode = patientBL.SaveMetaTypeDetails(OrgID, txtcode.Text.ToUpper(), txtgroup.Text.ToUpper(), Convert.ToInt64(hdnMetaID.Value), txtdescrip.Text.ToUpper(), IsActive, SysLock);


            if (ReturnCode >= 0)
            {
                lblmsg.Visible = true;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Successfully Updated');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strSuccess + "','" + strAlert + "');", true);
                txtcode.Text = "";
                txtdescrip.Text = "";
                txtgroup.Text = "";
               // btnAdd.Text = "ADD";
                btnAdd.Text = strAdd;
                chkSystem.Checked = false;
                chkActive.Checked = true;
                divGrid.Style.Add("display", "none");
                divgroup.Style.Add("display", "block");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "none");

            }
            else
            {
                lblmsg.Visible = true;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Error While Saving Data');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strError + "','" + strAlert + "');", true);
                txtcode.Text = "";
                txtdescrip.Text = "";
                txtgroup.Text = "";
                chkSystem.Checked = false;
                chkActive.Checked = true;

            }
        }
        else
        {
            long Code = -1;
            Patient_BL patient = new Patient_BL(base.ContextInfo);
            string CodeName = "Meta";
            Code = patient.GetCheckMetaValueCode(txtcode.Text.ToUpper(), CodeName);

            if (Code == 0)
            {
                divGrid.Style.Add("display", "none");
                divgroup.Style.Add("display", "block");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "none");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Code Already Exist');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strExit + "','" + strAlert + "');", true);
                txtcode.Text = "";
                txtcode.Focus();
                return;
            }


            long TypeID = 0;
            long ReturnCode = -1;
            Patient_BL patientBAL = new Patient_BL(base.ContextInfo);



            ReturnCode = patientBAL.SaveMetaTypeDetails(OrgID, txtcode.Text.ToUpper(), txtgroup.Text.ToUpper(), TypeID, txtdescrip.Text.ToUpper(), IsActive, SysLock);


            if (ReturnCode >= 0)
            {
                lblmsg.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Saved Successfully');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strSaved + "','" + strAlert + "');", true);
                txtcode.Text = "";
                txtdescrip.Text = "";
                txtgroup.Text = "";
                btnAdd.Text = "ADD";
                chkSystem.Checked = false;
                chkActive.Checked = true;
                divGrid.Style.Add("display", "none");
                divgroup.Style.Add("display", "block");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "none");
                drpMetaTypeName();


            }
            else
            {
                lblmsg.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Error While Saving Data');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strError + "','" + strAlert + "');", true);
                txtcode.Text = "";
                txtdescrip.Text = "";
                txtgroup.Text = "";
                chkSystem.Checked = false;
                chkActive.Checked = true;

            }

        }


    }

    protected void btngvsearch_Click(object sender, EventArgs e)
    {
        lblmsg1.Visible = false;
        divgroup.Style.Add("display", "none");
        divGroupOrgMap.Style.Add("display", "none");
        divgrpvalue.Style.Add("display", "block");
        long Returncode = -1;
        List<MetaValue_Common> lstMeta = new List<MetaValue_Common>();
        Patient_BL patient = new Patient_BL(base.ContextInfo);

        if (hdnMetaValueID.Value == "" && hdnMetaValueID.Value.Length == 0)
        {
            hdnMetaValueID.Value = "0";
        }

        string TypeDetails = "Y";
        string prefixtext = string.Empty;
        long GrpValueId = 0;

        Returncode = patient.GetMetaValuebyName(OrgID, Convert.ToInt64(hdnMetaValueID.Value), GrpValueId, prefixtext, TypeDetails, out lstMeta);
        if (lstMeta.Count > 0)
        {

            divGrid.Style.Add("display", "block");
            grdMetaValue.DataSource = lstMeta;
            grdMetaValue.DataBind();



        }
        else
        {

            divGrid.Style.Add("display", "none");
        }
    }
    protected void btnAdd1_Click(object sender, EventArgs e)
    {

        if (chkvalueActive.Checked == true)
        {
            ValueIsActive = "Y";
        }
        else
        {
            ValueIsActive = "N";
        }

        if (btnAdd1.Text == "Update")
        {

            long ReturnCode = -1;
            Patient_BL patient = new Patient_BL(base.ContextInfo);


            ReturnCode = patient.SaveMetaValueDetails(OrgID, Convert.ToInt32(hdnValueID.Value), txtgvcode.Text.ToUpper(), txtgroupvalue.Text.ToUpper(), Convert.ToInt64(hdnMetaValueID.Value), txtgvdescrip.Text.ToUpper(), ValueIsActive);
            if (ReturnCode >= 0)
            {
                lblmsg.Style.Add("display", "none");
                lblmsg1.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Successfully Updated');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strSuccess + "','" + strAlert + "');", true);
                txtgvName.Text = "";
                txtgvdescrip.Text = "";
                txtgvcode.Text = "";
                txtgroupvalue.Text = "";
                //btnAdd1.Text = "ADD";
                btnAdd1.Text =strAdd;
                txtgvName.Enabled = true;
                divgroup.Style.Add("display", "none");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "block");
                divGrid.Style.Add("display", "block");
                chkvalueActive.Checked = true;
                btngvsearch_Click(sender, e);

            }
            else
            {
                txtgvName.Enabled = true;
                lblmsg.Style.Add("display", "none");
                lblmsg1.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Error While Saving Data');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strError + "','" + strAlert + "');", true);

            }


        }

        else
        {
            long Code = -1;
            Patient_BL patient = new Patient_BL(base.ContextInfo);
            string ValueCodeName = "Value";
            Code = patient.GetCheckMetaValueCode(txtgvcode.Text.ToUpper(), ValueCodeName);

            if (Code == 0)
            {
                divgroup.Style.Add("display", "none");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "block");
                divGrid.Style.Add("display", "none");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Code Already Exist');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strExit + "','" + strAlert + "');", true);
                txtgvcode.Text = "";
                txtgvcode.Focus();
                return;
            }
            int ValueID = 0;
            long ReturnCode = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            ReturnCode = patientBL.SaveMetaValueDetails(OrgID, ValueID, txtgvcode.Text.ToUpper(), txtgroupvalue.Text.ToUpper(), Convert.ToInt64(hdnMetaValueID.Value), txtgvdescrip.Text.ToUpper(), ValueIsActive);

            if (ReturnCode >= 0)
            {
                divGrid.Style.Add("display", "none");
                lblmsg.Style.Add("display", "none");
                lblmsg1.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Saved Successfully');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strSaved + "','" + strAlert + "');", true);
                txtgvName.Text = "";
                txtgvdescrip.Text = "";
                txtgvcode.Text = "";
                txtgroupvalue.Text = "";
                //btnAdd1.Text = "ADD";
                btnAdd1.Text = strAdd;
                txtgvName.Enabled = true;
                divgroup.Style.Add("display", "none");
                divGroupOrgMap.Style.Add("display", "none");
                divgrpvalue.Style.Add("display", "block");
                chkvalueActive.Checked = true;



            }
            else
            {
                txtgvName.Enabled = true;
                lblmsg.Style.Add("display", "none");
                lblmsg1.Style.Add("display", "block");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Error While Saving Data');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strError + "','" + strAlert + "');", true);

            }


        }

    }


    protected void drpGroupType_SelectedIndexChanged(object sender, EventArgs e)
    {

        divgroup.Style.Add("display", "none");
        divGroupOrgMap.Style.Add("display", "block");
        divgrpvalue.Style.Add("display", "none");
        divGrid.Style.Add("display", "none");
        if (drpGroupType.SelectedItem.Text == "Select")
        {
            txtorggroupvalue.Enabled = false;
        }
        else
        {
            txtorggroupvalue.Enabled = true;
            int MetaTypeID = Convert.ToInt32(drpGroupType.SelectedValue.ToString());

            AutoCompleteExtender4.ContextKey = OrgID.ToString() + "~" + MetaTypeID.ToString();
        }
    }


    protected void btnAdd2_Click(object sender, EventArgs e)
    {
        long ReturnCode = -1;
        Patient_BL patient = new Patient_BL(base.ContextInfo);
        ReturnCode = patient.SaveMetaValueMapping(OrgID, Convert.ToInt32(hdnMetaValuebyMetaID.Value), txtorgidtype.Text.ToUpper().ToString(), Convert.ToInt64(hdnIdentifyingValue.Value));
        if (ReturnCode >= 0)
        {
            lblmsg2.Style.Add("display", "block");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Saved Succesfully');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + strSaved + "','" + strAlert + "');", true);
            drpGroupType.SelectedIndex = -1;
            txtorggroupvalue.Text = "";
            txtorgidtype.Text = "";
            txtorgidvalue.Text = "";
            divGroupOrgMap.Style.Add("display", "block");
            divgroup.Style.Add("display", "none");
            divgrpvalue.Style.Add("display", "none");



        }

    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        divgroup.Style.Add("display", "none");
        divGroupOrgMap.Style.Add("display", "none");
        divgrpvalue.Style.Add("display", "block");
        txtgvName.Enabled = true;
        divGrid.Style.Add("display", "none");
        txtgvName.Text = "";
        txtgroupvalue.Text = "";
        txtgvcode.Text = "";
        txtgvdescrip.Text = "";
        chkvalueActive.Checked = true;

    }
    protected void txtgvName_TextChanged(object sender, EventArgs e)
    {
        lblmsg1.Visible = false;
        divgroup.Style.Add("display", "none");
        divGroupOrgMap.Style.Add("display", "none");
        divgrpvalue.Style.Add("display", "block");
        long Returncode = -1;
        Patient_BL PatientBL = new Patient_BL(base.ContextInfo);
        List<MetaType_Common> lstMeta = new List<MetaType_Common>();
        int TypeId = 0;

        Returncode = PatientBL.GetMetaName(OrgID, txtgvName.Text, TypeId, out lstMeta);
        if (lstMeta.Count > 0)
        {
            if (lstMeta[0].SystemLevel == "Y")
            {
                txtgvName.Enabled = false;

            }
            else
            {
                txtgvName.Enabled = true;
            }
        }
    }


    protected void txtorgidtype_TextChanged(object sender, EventArgs e)
    {
        divgroup.Style.Add("display", "none");
        divGroupOrgMap.Style.Add("display", "block");
        divgrpvalue.Style.Add("display", "none");
        divGrid.Style.Add("display", "none");
        AutoCompleteExtender5.ContextKey = OrgID.ToString() + "~" + hdnMetaValueName.Value.ToString();
    }
    protected void btnReset1_Click(object sender, EventArgs e)
    {
        lblmsg.Visible = false;
        divGrid.Style.Add("display", "none");
        divgroup.Style.Add("display", "block");
        divGroupOrgMap.Style.Add("display", "none");
        divgrpvalue.Style.Add("display", "none");
        txtgroup.Text = "";
        txtcode.Text = "";
        txtdescrip.Text = "";
        chkActive.Checked = true;
        chkSystem.Checked = false;
        //btnAdd.Text = "ADD";
        btnAdd.Text = strAdd;
        chkSystem.Enabled = true;
        txtcode.Enabled = true;

    }
    protected void grdMetaValue_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
        Int64 MetaID = Convert.ToInt64(grdMetaValue.DataKeys[rowIndex]["MetaTypeId"]);
        Int64 MetaValueID = Convert.ToInt64(grdMetaValue.DataKeys[rowIndex]["MetaValueID"]);

        if (e.CommandName == "MetaValueEdit")
        {

            BindMetaValues(MetaID, MetaValueID);


        }

        //if (e.CommandName == "GroupValueDelete")
        //{
        //    long ReturnCode = -1;
        //    Patient_BL patient = new Patient_BL(base.ContextInfo);

        //    ReturnCode = patient.SaveGroupValueDetails(OrgID, Convert.ToInt32(GrpValueID), txtgvcode.Text, txtgroupvalue.Text, Convert.ToInt64(GroupID), txtgvdescrip.Text, ValueIsActive);
        //    if (ReturnCode >= 0)
        //    {
        //        lblmsg.Style.Add("display", "none");
        //        lblmsg1.Style.Add("display", "block");
        //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Deleted Succesfully');", true);
        //        txtgvName.Text = "";
        //        txtgvdescrip.Text = "";
        //        txtgvcode.Text = "";
        //        txtgroupvalue.Text = "";
        //        btnAdd1.Text = "ADD";
        //        txtgvName.Enabled = true;
        //        divgroup.Style.Add("display", "none");
        //        divGroupOrgMap.Style.Add("display", "none");
        //        divgrpvalue.Style.Add("display", "block");
        //        divGrid.Style.Add("display", "none");
        //        chkvalueActive.Checked = false;
        //        btngvsearch_Click(sender, e);


        //    }
        //    else
        //    {
        //        txtgvName.Enabled = true;
        //        lblmsg.Style.Add("display", "none");
        //        lblmsg1.Style.Add("display", "block");
        //        lblmsg1.Text = "Caution: Error While Saving Data not Saved Successfully!";

        //    }

        //}


    }

    public void BindMetaValues(long MetaID, long MetaValueID)
    {
        long Returncode = -1;
        //btnAdd1.Text = "Update";
        btnAdd1.Text = strUpdate;
        List<MetaValue_Common> lstMeta = new List<MetaValue_Common>();
        Patient_BL patient = new Patient_BL(base.ContextInfo);
        hdnValueID.Value = Convert.ToString(MetaValueID);

        string TypeDetails = string.Empty;
        string prefixtext = string.Empty;

        Returncode = patient.GetMetaValuebyName(OrgID, MetaID, MetaValueID, prefixtext, TypeDetails, out lstMeta);

        if (lstMeta.Count > 0)
        {
            txtgvName.Text = lstMeta[0].TypeName;
            txtgvName.Enabled = false;
            txtgroupvalue.Text = lstMeta[0].Value;
            txtgvcode.Text = lstMeta[0].Code;
            txtgvdescrip.Text = lstMeta[0].Description;

            if (lstMeta[0].IsActive == "Y")
            {
                chkvalueActive.Checked = true;
            }
            else
            {
                chkvalueActive.Checked = false;
            }

        }


    }

    protected void grdMetaValue_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if ((string)(DataBinder.Eval(e.Row.DataItem, "IsActive")) == "N")
            {

                e.Row.BackColor = System.Drawing.Color.Tomato;

            }
            else
            {
                e.Row.BackColor = System.Drawing.Color.PapayaWhip;
            }

        }

    }
    protected void grdMetaValue_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        btngvsearch_Click(sender, e);
        grdMetaValue.PageIndex = e.NewPageIndex;
        grdMetaValue.DataBind();
    }
}
