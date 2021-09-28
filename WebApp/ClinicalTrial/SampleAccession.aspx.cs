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
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using System.Text;

public partial class ClinicalTrial_SampleAccession : BasePage
{ 
    ClinicalTrail_BL CT_BL ;
    Investigation_BL invBL ;
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<PatientInvSample> lstPatientInvSample1 = new List<PatientInvSample>();
    List<PatientInvSample> lstPatientInvSample2 = new List<PatientInvSample>();
    List<PatientInvSample> lstCashFlowSummarySubTotal = new List<PatientInvSample>();
    static List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    static List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    static List<InvReasonMasters> lstInvReasonMasterNewList = new List<InvReasonMasters>();
    Investigation_BL Inv_BL ;
    List<MetaData> childItems = new List<MetaData>();
    List<MetaData> lstmetadataInput = new List<MetaData>();
    static List<MetaData> lstmetadataOutput = new List<MetaData>();
    
   
    protected void Page_Load(object sender, EventArgs e)
    {
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        invBL = new Investigation_BL(base.ContextInfo);
        Inv_BL = new Investigation_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            long Eid = -1;
            string Res = string.Empty; 
            SetContext();
            SetDept();
            hdnCollectedDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");
            hdnOrgID.Value = OrgID.ToString();
            hdnCollectedIn.Value = Convert.ToString(ILocationID);
            hdnCreatedBy.Value = Convert.ToString(LID);
            if ((!string.IsNullOrEmpty(Request.QueryString["Res"])))
            {
                Res = Request.QueryString["Res"].ToString();
            }
        }
        GetInvStatus();
        GetInvReason();
        LoadMetaDate();
    }
    public void GetInvStatus()
    {
        try
        {
            long returnCode = -1;
            returnCode = Inv_BL.GetInvStatus(OrgID, "ReceiveSample", out lstInvSampleStatus);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while get sample status", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while get sample status. Please contact system administrator";
        }
    }
    public void GetInvReason()
    {
        try
        {
            long returnCode = -1;
            returnCode = Inv_BL.GetInvReasons(OrgID, out lstInvReasonMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while get sample Reason", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while get sample Reason. Please contact system administrator";
        }
    }
    public void LoadMetaDate()
    {
        long returncode = -1;
        string domains = "SamplesUnits";
        string[] Tempdata = domains.Split(',');
        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);
        }
        returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
    }
    protected void Search_Click(object sender, EventArgs e)
    { 
        

        List<Patient> objPatient = new List<Patient>();
        long SiteID = 0;
        long EpisodeID=-1;
        string ConsignmentNo = string.Empty;
        string AddInfo = string.Empty;
        SiteID = Int64.Parse(hdnClientID.Value);
        EpisodeID=Int64.Parse(hdnEpisodeID.Value);
        ConsignmentNo = hdnConsignmentNo.Value;

        CT_BL.GetPatientDetailsByConsignmentNo(OrgID, ConsignmentNo, EpisodeID, SiteID, "Sample",out lstPatientInvSample);

        lstPatientInvSample1 = lstPatientInvSample;
        if (lstPatientInvSample.Count > 0)
        {

            //var childItems = (from child in lstPatientInvSample select child.PatientVisitID).Distinct();
            //foreach (var list in childItems)
            //{
            //    PatientInvSample obj = new PatientInvSample();
            //    obj.PatientVisitID = list;
            //    lstPatientInvSample2.Add(obj);
            //}

            IEnumerable<PatientInvSample> FilterValue = (from list in lstPatientInvSample
                                                         group list by new
                                                         {
                                                             list.PatientVisitID,
                                                             list.Name,
                                                             list.Age,
                                                             list.SEX,
                                                             list.InvSampleStatusDesc
                                                         } into g1
                                                         select new PatientInvSample
                                                       {
                                                           PatientVisitID = g1.Key.PatientVisitID,
                                                           Name = g1.Key.Name,
                                                           Age = g1.Key.Age,
                                                           SEX = g1.Key.SEX,
                                                           InvSampleStatusDesc = g1.Key.InvSampleStatusDesc
                                                       }).ToList();


            lstPatientInvSample2 = FilterValue.ToList();

            grdResult.DataSource = lstPatientInvSample2;
            grdResult.DataBind();

            TdReceiveSample.Attributes.Add("style", "display:block");
        }
        else
        {
            string AlertMesg = "No Matcing Record Found!";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');", true);
            grdResult.DataSource = lstPatientInvSample;
            grdResult.DataBind();
            TdReceiveSample.Attributes.Add("style", "display:none");
        }
    }

    protected void Save_Click(object sender, EventArgs e)
    {
        try
        {
            long Result1 = -1;
            long Result2 = -1;
            List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
            List<ProductEpisodeVisitMapping> lstPatientVisit =new List<ProductEpisodeVisitMapping>();
            
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            string strLstobjSampleTracker = hdnLstSampleTracker.Value;
            lstSampleTracker = serializer.Deserialize<List<SampleTracker>>(strLstobjSampleTracker);

            string strLstPatientVisit = hdnLstPatientVisit.Value;
            lstPatientVisit = serializer.Deserialize<List<ProductEpisodeVisitMapping>>(strLstPatientVisit);


            //Result=CT_BL.UpdateBulkSampleStatus(lstSampleTracker);
            if (lstSampleTracker != null)
            {
                if (lstSampleTracker.Count > 0)
                {
                    Result1 = invBL.UpdateSampleStatusDetails(lstSampleTracker);
                }
            }
            if (lstPatientVisit != null)
            {
                if (lstPatientVisit.Count > 0)
                {
                    Result2 = CT_BL.UpdatePatientMismatchDataStatus(lstPatientVisit, OrgID, LID);
                }
            }
            if (Result1 != -1 || Result2 != -1)
            {
                string PageUrl = Request.ApplicationPath + @"/ClinicalTrial/SampleAccession.aspx?IsPopup=Y";
                string AlertMesg = "Samples Collected Successfully!";
                //Search_Click(sender, e);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Sample Collection", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in Saving Sample Collection. Please contact system administrator";
        }
    }
    public void SetContext()
    {
        string ClientID = hdnClientID.Value; 
        AutoCompleteExtenderClientCorp.ContextKey = "SIT";
       // AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + "~-1"; 
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientInvSample BMaster = (PatientInvSample)e.Row.DataItem;
                var childItems = from child in lstPatientInvSample1
                                 where child.PatientVisitID == BMaster.PatientVisitID
                                 select child;
                
 
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;

                childGrid.DataBind();
 
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianWiseCollectionReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void grdChildResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientInvSample PatientInvaster = (PatientInvSample)e.Row.DataItem;
                DropDownList ddlSampleStatus = (DropDownList)e.Row.FindControl("ddlSampleStatus");
                DropDownList ddlAddReason = (DropDownList)e.Row.FindControl("ddlAddReason");
                DropDownList ddlvolumeUnits = (DropDownList)e.Row.FindControl("ddlvolumeUnits");
                TextBox txtVolume = (TextBox)e.Row.FindControl("txtVolume");
                ddlAddReason.Attributes.Add("disabled", "true"); 
                ddlSampleStatus.DataSource = lstInvSampleStatus.OrderBy(p=>p.InvSampleStatusDesc);
                ddlSampleStatus.DataTextField = "InvSampleStatusDesc";
                ddlSampleStatus.DataValueField = "InvSampleStatusID";
                ddlSampleStatus.DataBind();
                ddlSampleStatus.Attributes.Add("onchange", "javascript:SampleStatusChange('" + ddlSampleStatus.ClientID + "','" + ddlAddReason.ClientID + "');");
                ddlAddReason.DataSource = lstInvReasonMaster;
                ddlAddReason.DataTextField = "ReasonDesc";
                ddlAddReason.DataValueField = "ReasonID";
                ddlAddReason.DataBind();
                ddlAddReason.Items.Insert(0, new ListItem("--Select--", "0"));
                if (lstmetadataOutput.Count > 0)
                {
                    childItems = (from child in lstmetadataOutput
                                  where child.Domain == "SamplesUnits"
                                  orderby child.MetaDataID ascending
                                  select child).ToList();
                    if (childItems.Count() > 0)
                    {
                        ddlvolumeUnits.DataSource = childItems;
                        ddlvolumeUnits.DataTextField = "DisplayText";
                        ddlvolumeUnits.DataValueField = "Code";
                        ddlvolumeUnits.DataBind();
                        //if (PatientInvaster.SampleUnit == string.Empty)
                        //{
                        //    ddlvolumeUnits.SelectedIndex = 0;
                        //}
                        //else
                        //{
                        //    ddlvolumeUnits.SelectedItem.Text = PatientInvaster.SampleUnit;
                        //}
                    }
                }
                txtVolume.Text = PatientInvaster.SampleVolume.ToString();
                Label isCreditBill = (Label)e.Row.FindControl("isCreditBill");
                PatientInvSample BMaster = (PatientInvSample)e.Row.DataItem;

                TextBox txtReceivedDatetime = (TextBox)e.Row.FindControl("txtReceivedDatetime");
                txtReceivedDatetime.Text = Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
                string ddmmyyyy = "ddmmyyyy";
                string arrow = "arrow";
                string tru = "true";
                string twele = "12";
                string Yes = "Y";
                txtReceivedDatetime.Attributes.Add("onfocus", "javascript:NewCssCal(this.id,'" + ddmmyyyy + "','" + arrow + "','" + tru + "','" + twele + "','" + Yes + "','" + Yes + "');");
                long InvSampleStatID = BMaster.InvSampleStatusID;
                if (InvSampleStatID == 3 || InvSampleStatID == 4)
                {
                    foreach (ListItem item in ddlSampleStatus.Items)
                    {
                        if (item.Value == InvSampleStatID.ToString())
                        {
                            ddlSampleStatus.SelectedValue = InvSampleStatID.ToString();
                        }
                    }
                    if (InvSampleStatID == 4)
                    {
                        foreach (ListItem item in ddlAddReason.Items)
                        {
                            if (item.Text == BMaster.Reason)
                            {
                                ddlAddReason.SelectedItem.Text = BMaster.Reason;
                                lstInvReasonMasterNewList = lstInvReasonMaster.FindAll(p => p.Reason == BMaster.Reason);
                                if (lstInvReasonMasterNewList.Count > 0)
                                {
                                    ddlAddReason.SelectedValue = lstInvReasonMasterNewList[0].ReasonID.ToString();
                                }
                            }
                        }
                    }
                }
                if (InvSampleStatID != 1 && InvSampleStatID != 14)
                {
                    ddlSampleStatus.Enabled = false;
                }


                //var phy = from child in lstCashFlowSummary1
                //          where child.PhysicianName == physician
                //          select child;
                //foreach (var list in phy)
                //{
                //    if (list.IsCreditBill == "Y")
                //    {
                //        isCreditBill.Text = "Credit";
                //    }
                //    else
                //    {
                //        isCreditBill.Text = "Non-Credit";
                //    }

                //}
                //if (BMaster.IsCreditBill == "Y")
                //{
                //    isCreditBill.Text = "Credit";
                //}
                //else
                //{
                //    isCreditBill.Text = "Paid";
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianWiseCollectionReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            Search_Click(sender, e);
        }
    }
    public void SetDept()
    {
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<InvDeptMaster> lstRoleDeptMap = new List<InvDeptMaster>(); 
        new Role_BL(base.ContextInfo).GetRoleLocation(OrgID, RoleID, LID, out lstLocation, out lstRoleDeptMap);
        if (lstRoleDeptMap.Count > 0)
        {
            hdnDeptID.Value = Convert.ToString(lstRoleDeptMap[0].DeptID);
        }
        else
        {
            hdnDeptID.Value = "0";
        }
    }
}
