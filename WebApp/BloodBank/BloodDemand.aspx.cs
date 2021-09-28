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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Linq;

public partial class BloodBank_BloodDemand : BasePage
{
    List<BloodRequistionDetails> lstBloodRequest = new List<BloodRequistionDetails>();
    List<Patient> lstPatient = new List<Patient>();
    List<BloodGroup> lstBloodGroup = new List<BloodGroup>();
    List<BloodComponent> lstBloodComponent = new List<BloodComponent>();
    long returnCode = -1;
    long RequestNo = 0;
    long PatientID = -1;
    long VisitID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMetaData();
        }

    }
    public void LoadMetaData()
    {
        try
        {
            string domains = "BloodGroup,BloodComponent";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
			new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "BloodGroup"
                                  select child;

                chklstBloodGroups.DataSource = childItems2.ToList();
                chklstBloodGroups.DataTextField = "DisplayText";
                chklstBloodGroups.DataValueField = "Code";
                chklstBloodGroups.DataBind();

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "BloodComponent"
                                  select child;

                chklstBloodComponents.DataSource = childItems3.ToList();
                chklstBloodComponents.DataTextField = "DisplayText";
                chklstBloodComponents.DataValueField = "Code";
                chklstBloodComponents.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Search Type  Meta Data like BloodGroup,BloodComponent ... ", ex);

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
            DateTime pFDT;
            DateTime.TryParse(txtFDate.Text.Trim(), out pFDT);
            DateTime pTDT;
            DateTime.TryParse(txtTDate.Text.Trim(), out pTDT);
            returnCode = new BloodBank_BL(base.ContextInfo).GetBloodRequestDetails(PatientID, VisitID, pFDT, pTDT, out RequestNo, out lstBloodRequest, out lstPatient);
            //ViewState["BloodRequest"] = lstBloodRequest;
            //ViewState["Patient"] = lstPatient;
            returnCode = new BloodBank_BL(base.ContextInfo).GetBloodGroupsAndComponents(out lstBloodGroup, out lstBloodComponent);
            DataTable dt = new DataTable();
            DataColumn dc1 = new DataColumn("BloodGroup");
            DataColumn dc2 = new DataColumn("BloodGroupName");
            DataColumn dc3 = new DataColumn("BloodComponent");
            DataColumn dc4 = new DataColumn("BloodComponentName");
            DataColumn dc5 = new DataColumn("Count");
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
            dt.Columns.Add(dc4);
            dt.Columns.Add(dc5);
            DataRow dr;
            foreach (BloodGroup BG in lstBloodGroup)
            {
                foreach (BloodComponent BC in lstBloodComponent)
                {
                    dr = dt.NewRow();
                    dr["BloodGroup"] = BG.BloodGroupID;
                    dr["BloodGroupName"] = BG.BloodGroupName;
                    dr["BloodComponent"] = BC.BloodComponentID;
                    dr["BloodComponentName"] = BC.BloodComponentName;
                    dt.Rows.Add(dr);
                }
            }
            foreach (DataRow dr1 in dt.Rows)
            {
                long cnt = 0;
                for (int i = 0; i < lstBloodRequest.Count; i++)
                {
                    if (lstBloodRequest[i].BloodGroup == Convert.ToInt32(dr1[0].ToString()) && lstBloodRequest[i].BloodComponent == Convert.ToInt32(dr1[2].ToString()))
                    {
                        cnt = cnt + lstBloodRequest[i].NoOfUnits;
                    }
                }
                dr1[4] = cnt;
            }

            if (rdoSummary.Checked)
            {
                gvSummary.Attributes.Add("Style", "display :block");
                gvDetail.Attributes.Add("Style", "display :none");
                divHeading.Attributes.Add("Style", "display:none");
                DataTable dtSummary = new DataTable();
                DataColumn dcSummary0 = new DataColumn("BloodGroupID");
                DataColumn dcSummary1 = new DataColumn("BloodGroupName");
                DataColumn dcSummary2 = new DataColumn("Whole Blood");
                DataColumn dcSummary3 = new DataColumn("Plasma");
                DataColumn dcSummary4 = new DataColumn("Platelet");
                DataColumn dcSummary5 = new DataColumn("Plasma Factors");
                DataColumn dcSummary6 = new DataColumn("Packed Red Cell");
                DataColumn dcSummary7 = new DataColumn("Leukocyte poor red cells");
                DataColumn dcSummary8 = new DataColumn("Fresh Frozen Plasma (FFP)");
                DataColumn dcSummary9 = new DataColumn("Cryoprecipitated anti hemophilic factor");
                DataColumn dcSummary10 = new DataColumn("WBC");
                DataColumn dcSummary11 = new DataColumn("Plasma Protein Fraction");
                DataColumn dcSummary12 = new DataColumn("Albumin");
                dtSummary.Columns.Add(dcSummary0);
                dtSummary.Columns.Add(dcSummary1);
                dtSummary.Columns.Add(dcSummary2);
                dtSummary.Columns.Add(dcSummary3);
                dtSummary.Columns.Add(dcSummary4);
                dtSummary.Columns.Add(dcSummary5);
                dtSummary.Columns.Add(dcSummary6);
                dtSummary.Columns.Add(dcSummary7);
                dtSummary.Columns.Add(dcSummary8);
                dtSummary.Columns.Add(dcSummary9);
                dtSummary.Columns.Add(dcSummary10);
                dtSummary.Columns.Add(dcSummary11);
                dtSummary.Columns.Add(dcSummary12);
                DataRow drSummary;
                foreach (BloodGroup BG in lstBloodGroup)
                {
                    drSummary = dtSummary.NewRow();
                    drSummary["BloodGroupID"] = BG.BloodGroupID;
                    drSummary["BloodGroupName"] = BG.BloodGroupName;

                    foreach (DataRow dr2 in dt.Rows)
                    {
                        if (BG.BloodGroupID == Convert.ToInt32(dr2[0].ToString()))
                        {
                            string name = string.Empty;
                            name = dr2[3].ToString();
                            drSummary[name] = dr2[4].ToString();
                        }
                    }
                    dtSummary.Rows.Add(drSummary);
                }
                gvSummary.DataSource = dtSummary;
                gvSummary.DataBind();
            }
            else if (rdoDetail.Checked)
            {
                if (ChkboxBloodGroups.Checked == true && chkBloodComponents.Checked == true)
                {
                    gvDetail.DataSource = dt;
                    gvDetail.DataBind();
                }
                else if (ChkboxBloodGroups.Checked == false && chkBloodComponents.Checked == false)
                {
                    DataTable dt1 = new DataTable();
                    //DataColumn dc1 = new DataColumn("BloodGroup");
                    //DataColumn dc2 = new DataColumn("BloodGroupName");
                    //DataColumn dc3 = new DataColumn("BloodComponent");
                    //DataColumn dc4 = new DataColumn("BloodComponentName");
                    //DataColumn dc5 = new DataColumn("Count");
                    for (int i = 0; i < chklstBloodComponents.Items.Count; i++)
                    {
                        if (chklstBloodComponents.Items[i].Selected)
                        {
                            foreach (DataRow dr2 in dt.Rows)
                            {

                            }
                        }

                    }
                }
                gvSummary.Attributes.Add("Style", "display :none");
                gvDetail.Attributes.Add("Style", "display :block");
                divHeading.Attributes.Add("Style", "display:block");
            }
    }
    protected void gvDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvDetail.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
    }
    protected void gvDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView gvChild = (GridView)gvDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("gvChildDetail");
        DropDownList ddlAction = (DropDownList)gvDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
        Button btnDetails = (Button)gvDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnViewDetails");
        Button btnAction = (Button)gvDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
        if (e.CommandName == "ViewDetails")
        {
            DateTime pFDT;
            DateTime.TryParse(txtFDate.Text.Trim(), out pFDT);
            DateTime pTDT;
            DateTime.TryParse(txtTDate.Text.Trim(), out pTDT);
            returnCode = new BloodBank_BL(base.ContextInfo).GetBloodRequestDetails(PatientID, VisitID, pFDT, pTDT, out RequestNo, out lstBloodRequest, out lstPatient);
            //lstBloodRequest =(List<BloodRequistionDetails>)ViewState["BloodRequest"];
            //lstPatient = (List<Patient>)ViewState["Patient"];
            DataTable dtDetails = new DataTable();
            DataColumn dcDetails1 = new DataColumn("RequestNo");
            DataColumn dcDetails2 = new DataColumn("PatientNo");
            DataColumn dcDetails3 = new DataColumn("PatientName");
            DataColumn dcDetails4 = new DataColumn("NoOfUnits");
            DataColumn dcDetails5 = new DataColumn("TransfusionDate");
            dtDetails.Columns.Add(dcDetails1);
            dtDetails.Columns.Add(dcDetails2);
            dtDetails.Columns.Add(dcDetails3);
            dtDetails.Columns.Add(dcDetails4);
            dtDetails.Columns.Add(dcDetails5);
            DataRow drDetails;
            foreach (BloodRequistionDetails BR in lstBloodRequest)
            {
                drDetails = dtDetails.NewRow();
                long BloodGrpID = Convert.ToInt32(gvDetail.DataKeys[Convert.ToInt32(e.CommandArgument)].Values[0]);
                long BloodComID = Convert.ToInt32(gvDetail.DataKeys[Convert.ToInt32(e.CommandArgument)].Values[1]);
                if (BR.BloodGroup == BloodGrpID && BR.BloodComponent == BloodComID)
                {
                    drDetails["RequestNo"] = BR.BloodRequisitionDetailsID;
                    drDetails["NoOfUnits"] = BR.NoOfUnits;
                    drDetails["TransfusionDate"] = BR.TransfusionScheduledDate;
                    foreach (Patient Pat in lstPatient)
                    {
                        if (Pat.LoginID == BR.BloodReceiveID)
                        {
                            drDetails["PatientNo"] = Pat.PatientNumber;
                            drDetails["PatientName"] = Pat.Name;
                        }
                    }
                    dtDetails.Rows.Add(drDetails);
                }
            }
            gvChild.DataSource = dtDetails;
            gvChild.DataBind();
            ddlAction.Visible = true;
            btnAction.Visible = true;
            btnDetails.Text = "Hide Details & Actions";
            btnDetails.CommandName = "HideDetails";
            int SearchType = Convert.ToInt32(TaskHelper.SearchType.BloodRequestSearch);
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();
            returnCode = nurseBL.GetActions(RoleID, SearchType, out lstActionMaster);
            ddlAction.DataSource = lstActionMaster;
            ddlAction.DataTextField = "ActionName";
            ddlAction.DataValueField = "PageURL";
            ddlAction.DataBind();
        }
        else if (e.CommandName == "HideDetails")
        {
            gvChild.DataSource = null;
            gvChild.DataBind();
            btnDetails.Text = "View Details & Actions";
            btnDetails.CommandName = "ViewDetails";
            ddlAction.Visible = false;
            btnAction.Visible = false;
        }
    }
}
