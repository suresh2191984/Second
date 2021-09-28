﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using Attune.Podium.BillingEngine;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Web.Script.Serialization;
public partial class Reception_MergeForm : BasePage
{
    public Reception_MergeForm()
        : base("Reception_MergeForm_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoRname.ContextKey = OrgID + "~" + "PHY" + "~" + txtFDate.Text + "~" + txtTDate.Text + "~" + "s" + "~" + "0" + "UNMerged";
            AutoCompleteForUnMergePhysician.ContextKey = OrgID + "~" + "PHY" + "~" + TxtBSm.Text + "~" + TxtBSml.Text + "~" + "s" + "~" + "0" + "Merged";
            //btnMerge.Style.Add("display", "block");
            //btnUnMerge.Style.Add("display", "block");
        }
    }

    protected void btnReferingPhySearch_Click(object sender, EventArgs e)
    {
        string AlrtWinHdr = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02 == null ? "Alert" : Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
        string DispWintxt = Resources.Reception_AppMsg.Reception_MergeForm_aspx_07 == null ? "No Matching Records Found" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_07;

        hdnListcollections.Value = "";
        BillingEngine be = new BillingEngine(base.ContextInfo);
        List<DayWiseCollectionReport> lstCollection = new List<DayWiseCollectionReport>();
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();

        oJavaScriptSerializer.MaxJsonLength = Int32.MaxValue;
        string MergeType = "UnMerged";
        be.GetMergePhysicianPatient(txtRefPhyName.Text, OrgID, "PHY", txtFDate.Text, txtTDate.Text, "", txtRefContact.Text, MergeType, out lstCollection);
        if (lstCollection.Count > 0)
        {
            hdnListcollections.Value = oJavaScriptSerializer.Serialize(lstCollection);
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "call", "javascript:AddButtonClickItem('UnMerged');", true);
            pnlPhysicianResult.Style.Add("display", "block");
            trMerge.Style.Add("display", "block");
            pnlUnMergePhy.Style.Add("display", "none");
            trUnMerge.Style.Add("display", "none");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt,AlrtWinHdr);", true);
           // ScriptManager.RegisterStartupScript(this.Page, GetType(), "call", "javascript:alert('No matching records found');", true);
            pnlPhysicianResult.Style.Add("display", "none");
            trMerge.Style.Add("display", "none");
        }
    }
    protected void btnReferingPhySearchUn_Click(object sender, EventArgs e)
    {
        string AlrtWinHdr = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02 == null ? "Alert" : Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
        string DispWintxt = Resources.Reception_AppMsg.Reception_MergeForm_aspx_07 == null ? "No Matching Records Found" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_07;

        hdnListcollections.Value = "";
        BillingEngine be = new BillingEngine(base.ContextInfo);
        List<DayWiseCollectionReport> lstCollection = new List<DayWiseCollectionReport>();
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        string MergeType = "Merged";
        oJavaScriptSerializer.MaxJsonLength = Int32.MaxValue;
        be.GetMergePhysicianPatient(txtRefPhyName.Text, OrgID, "PHY", TxtBSm.Text, TxtBSml.Text, "", txtRefContact.Text, MergeType, out lstCollection);
        if (lstCollection.Count > 0)
        {
            hdnListcollections.Value = oJavaScriptSerializer.Serialize(lstCollection);
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "call", "javascript:AddButtonClickItem('Merged');", true);
            pnlUnMergePhy.Style.Add("display", "block");
            trUnMerge.Style.Add("display", "block");
            pnlPhysicianResult.Style.Add("display", "none");
            trMerge.Style.Add("display", "none");
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "javascript:DisplayTab('divPatient');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt,AlrtWinHdr);DisplayTab('divPatient');", true);
           
           // ScriptManager.RegisterStartupScript(this.Page, GetType(), "call", "javascript:alert('No matching records found');DisplayTab('divPatient');", true);
            pnlUnMergePhy.Style.Add("display", "none");
            trUnMerge.Style.Add("display", "none");
        }
    }
    protected void rptPhysician_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            RadioButton rb = (RadioButton)e.Item.FindControl("rbParentPhysician");
            string script = "SetUniqueRadioButton('rptPhysician.*rblPhysicianGroup',this)";
            rb.Attributes.Add("onclick", script);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Physician Item Bound in Reception Merge Form", ex);
        }
    }
    protected void btnMerge_Click(object sender, EventArgs e)
    {
        string AlrtWinHdr = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02 == null ? "Alert" : Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
        string DispWintxt = Resources.Reception_AppMsg.Reception_MergeForm_aspx_08 == null ? "Selected physician merged successfully" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_08;
        string DispWintxt1 = Resources.Reception_AppMsg.Reception_MergeForm_aspx_09 == null ? "Error while merging datas" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_09;
        btnMerge.Attributes.Add("display", "none");
        long returnCode = -1;
        List<PatientReferringDetails> lstDatas = new List<PatientReferringDetails>();
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        string strCollections = hdnSelectedPhysicianList.Value;
        string RegType = hdnRegPhysicianType.Value;
        lstDatas = JSserializer.Deserialize<List<PatientReferringDetails>>(strCollections);
        if (Convert.ToInt64(hdnSelectedPhysicianID.Value) != 0)
        {
            returnCode = new BillingEngine(base.ContextInfo).UpdatePatientPhysicianMerge(Convert.ToInt64(hdnSelectedPhysicianID.Value), OrgID, lstDatas, "Merge", LID, RegType);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt,AlrtWinHdr);clearPageControlsValue();", true);
           
                //ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "alert('Selected physician merged successfully');clearPageControlsValue();", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "alert('Error while merging datas');clearPageControlsValue();", true);
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt1,AlrtWinHdr);clearPageControlsValue();", true);
           
            }
        }
        else
        {
            //Do Nothing
        }
    }
    protected void btnUnMerge_Click(object sender, EventArgs e)
    {
        string AlrtWinHdr = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02 == null ? "Alert" : Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
        string DispWintxt = Resources.Reception_AppMsg.Reception_MergeForm_aspx_10 == null ? "Selected physician Un merged successfully" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_10;
        string DispWintxt1 = Resources.Reception_AppMsg.Reception_MergeForm_aspx_09 == null ? "Error while merging datas" : Resources.Reception_AppMsg.Reception_MergeForm_aspx_09;
       
        btnUnMerge.Attributes.Add("display", "none");
        long returnCode = -1;
        List<PatientReferringDetails> lstDatas = new List<PatientReferringDetails>();
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        string strCollections = hdnSelectedUnMergePhysician.Value;
        lstDatas = JSserializer.Deserialize<List<PatientReferringDetails>>(strCollections);
        returnCode = new BillingEngine(base.ContextInfo).UpdatePatientPhysicianMerge(0, OrgID, lstDatas, "UnMerge", LID,"");
        if (returnCode >= 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt,AlrtWinHdr);clearPageControlsValue();", true);
           
            //ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "alert('Selected physician Un merged successfully');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alert", "javascript:ValidationWindow(DispWintxt1,AlrtWinHdr);clearPageControlsValue();", true);
           
           // ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "alert('Error while merging datas');clearPageControlsValue();", true);
        }
    }
}
