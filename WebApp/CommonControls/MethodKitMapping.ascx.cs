using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Solution.DAL;
public partial class CommonControls_MethodKitMapping : BaseControl
{
    long visitID = -1;
    int deptID = -1;
    string gUID = string.Empty;
    Patient_BL patientBL;
    Investigation_BL investigationBL;
    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    string strSelect = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_02 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] != null)
        {
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            //Int32.TryParse(Request.QueryString["dID"].ToString(), out deptID);
        }
        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
        }
        if (!IsPostBack)
        {
            LoadExistingItems();
            LoadInvestigation();
            LoadMethod();
            LoadKit();
            LoadInstrument();
            LoadPrinciple();
        }
    }
    protected void LoadExistingItems()
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        investigationBL.GetInvMethodKit(visitID, OrgID, deptID,gUID, out lstPatientInvestigation);
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation obj in lstPatientInvestigation)
            {
                if ((obj.Interpretation != "" && obj.Interpretation != null) || (obj.MethodName != "" && obj.MethodName != null) || (obj.KitName != "" && obj.KitName != null) || (obj.InstrumentName != "" && obj.InstrumentName != null) || (obj.PrincipleName != "" && obj.PrincipleName != null) || (obj.QCData != "" && obj.QCData != null))
                {
                if (obj.Interpretation == "" || obj.Interpretation == null)
                {
                    obj.Interpretation = "--";
                }
                if (obj.MethodName == "" || obj.MethodName == null)
                {
                    obj.MethodName = "--";
                }
                if(obj.KitName == "" || obj.KitName == null)
                {
                    obj.KitName = "--";
                }
                if(obj.InstrumentName == "" || obj.InstrumentName == null)
                {
                    obj.InstrumentName = "--";
                }
                if (obj.PrincipleName == "" || obj.PrincipleName == null)
                {
                    obj.PrincipleName = "--";
                }
                if (obj.QCData == "" || obj.QCData == null)
                {
                    obj.QCData = "--";
                }
                hdnMethodKit.Value += obj.InvestigationID + obj.InvestigationMethodID + obj.KitID + obj.InstrumentID + "~" + obj.InvestigationID + "~" + obj.InvestigationMethodID + "~" + obj.KitID + "~" + obj.InstrumentID + "~" + obj.Interpretation + "~" + obj.InvestigationName + "~" + obj.MethodName + "~" + obj.KitName + "~" + obj.InstrumentName +"~" + "INV" + "~"+obj.PrincipleID+"~"+obj.PrincipleName+"~"+obj.QCData+ "^";
                }
            }
        }
    }
    protected void LoadInvestigation()
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        investigationBL.GetGroupAndInvestigationByVisitID(visitID, OrgID, deptID, out lstInvestigationValues);
        if (lstInvestigationValues.Count > 0)
        {
            var groups = (from groups1 in lstInvestigationValues
                          where groups1.GroupID != 0
                          select new { groups1.GroupName, groups1.GroupID }).Distinct();
            if (groups.Count() > 0)
            {
                ddlGroup.DataSource = groups;
                ddlGroup.DataTextField = "GroupName";
                ddlGroup.DataValueField = "GroupID";
                ddlGroup.DataBind();
                trGroup.Style.Add("display", "none");
            }
            else
            {
                trGroup.Style.Add("display", "none");
            }
            ddlGroup.Items.Insert(0, strSelect);
            ddlGroup.Items[0].Value = "0";
            var invs = from invs1 in lstInvestigationValues
                       select invs1;
            if (invs.Count() > 0)
            {
                ddlInvestigation.DataSource = invs;
                ddlInvestigation.DataTextField = "InvestigationName";
                ddlInvestigation.DataValueField = "InvestigationID";
                ddlInvestigation.DataBind();
                trInvestigation.Style.Add("display", "table-row");
            }
            else
            {
                trInvestigation.Style.Add("display", "none");
            }
            ddlInvestigation.Items.Insert(0, strSelect);
            ddlInvestigation.Items[0].Value = "0";
        }
    }
    protected void LoadMethod()
    {
        List<InvestigationMethod> lstInvestigationMethod = new List<InvestigationMethod>();
        patientBL = new Patient_BL(base.ContextInfo);
        patientBL.GetInvestigationMethod(OrgID, "", "", out lstInvestigationMethod);
        if (lstInvestigationMethod.Count > 0)
        {
            ddlMethod.DataSource = lstInvestigationMethod;
            ddlMethod.DataTextField = "MethodName";
            ddlMethod.DataValueField = "MethodID";
            ddlMethod.DataBind();
            ddlMethod.Items.Insert(0, strSelect);
            ddlMethod.Items[0].Value = "0";
        }
    }
    protected void LoadKit()
    {
        List<InvKitMaster> lstInvKit = new List<InvKitMaster>();
        patientBL = new Patient_BL(base.ContextInfo);
        patientBL.GetInvestigationKit(OrgID, "", "", out lstInvKit);
        if (lstInvKit.Count > 0)
        {
            ddlKit.DataSource = lstInvKit;
            ddlKit.DataTextField = "KitName";
            ddlKit.DataValueField = "KitID";
            ddlKit.DataBind();
            ddlKit.Items.Insert(0, strSelect);
            ddlKit.Items[0].Value = "0";
        }
    }
    protected void LoadInstrument()
    {
        List<InvInstrumentMaster> lstInvInstrument = new List<InvInstrumentMaster>();
        patientBL = new Patient_BL(base.ContextInfo);
        patientBL.GetInvestigationInstrument(OrgID, "", "", out lstInvInstrument);
        if (lstInvInstrument.Count > 0)
        {
            ddlInstrument.DataSource = lstInvInstrument;
            ddlInstrument.DataTextField = "InstrumentName";
            ddlInstrument.DataValueField = "InstrumentID";
            ddlInstrument.DataBind();
            ddlInstrument.Items.Insert(0, strSelect);
            ddlInstrument.Items[0].Value = "0";
        }
        foreach(InvInstrumentMaster objInvInsMaster in lstInvInstrument)
        {
            hdnQCData.Value += objInvInsMaster.InstrumentID + "~" + objInvInsMaster.QCData + "^";
        }
    }
    protected void LoadPrinciple()
    {
        List<InvPrincipleMaster> lstInvPrinciple = new List<InvPrincipleMaster>();
        patientBL = new Patient_BL(base.ContextInfo);
        patientBL.GetInvestigationPrinciple(OrgID, "", "", out lstInvPrinciple);
        if (lstInvPrinciple.Count > 0)
        {
            ddlPrinciple.DataSource = lstInvPrinciple;
            ddlPrinciple.DataTextField = "PrincipleName";
            ddlPrinciple.DataValueField = "PrincipleID";
            ddlPrinciple.DataBind();
            ddlPrinciple.Items.Insert(0, strSelect);
            ddlPrinciple.Items[0].Value = "0";
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {

    }
    public string hdnMethodKitValues
    {
        get { return hdnMethodKit.Value; }
    }
}
