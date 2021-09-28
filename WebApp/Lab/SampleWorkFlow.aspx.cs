using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Data;
using System.Web.UI.HtmlControls;
/* Author: Sathish.E
 Date: 31-Oct-2013
 Description:Showing the Sample WorkFlow
 */
public partial class Lab_SampleWorkFlow : BasePage
{
    string strltHead = Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_01 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_01;
    public Lab_SampleWorkFlow()
        : base("Lab_SampleWorkFlow_aspx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtBarcode.Focus();
            loadSampleType();
        }
    }
    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        string WinAlert = Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_02 == null ? "Alert" : Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_02;
        string UsrMsgWin = Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_03 == null ? "Enter the Valid BarCode" : Resources.Lab_ClientDisplay.Lab_SampleWorkFlow_aspx_03;
        string Barcode = string.Empty;
        int orgid = OrgID;
        int ExtraSampleID = 0;
        if (rbtnManualArchive.Checked == true)
        {
            divmanualArchive.Attributes.Add("style", "display:block");
            if (ddsampletype.SelectedItem.Text != strltHead)
            {
                ExtraSampleID = Convert.ToInt32(ddsampletype.SelectedItem.Value);
            }

        }
        else { divmanualArchive.Attributes.Add("style", "display:none"); }
         if (!string.IsNullOrEmpty(hdnExtraSampleID.Value))
        {
            ExtraSampleID = Convert.ToInt32(hdnExtraSampleID.Value);
        }
         if (ddSampletypelist.SelectedIndex > 0)
        {
            ExtraSampleID = Convert.ToInt32(ddSampletypelist.SelectedItem.Value);
        }

        Investigation_BL InvBL = new Investigation_BL(base.ContextInfo);
        List<SampleWorkFlow> lstSampleWorkFlow = new List<SampleWorkFlow>();
        SampleWorkFlow ObjSampleWorkFlow = new SampleWorkFlow();
        SampleWorkFlow ObjPendingSampleWorkFlow = new SampleWorkFlow();
        List<SampleWorkFlow> lstCompletedSampleWorkFlow = new List<SampleWorkFlow>();
        List<SampleWorkFlow> lstPendingSampleWorkFlow = new List<SampleWorkFlow>();
        List<SampleWorkFlow> lstNextSampleWorkFlow = new List<SampleWorkFlow>();
        List<SampleWorkFlow> lstYettoProcessSampleWorkFlow = new List<SampleWorkFlow>();
        List<SampleWorkFlow> lstArchival = new List<SampleWorkFlow>();
        long returncode = -1;
        try
        {
            Barcode = txtBarcode.Text;
            returncode = InvBL.GetSampleWorkflowDetails(orgid, Barcode, ExtraSampleID, out lstSampleWorkFlow);
            ddSampletypelist.SelectedIndex = -1;

            if (lstSampleWorkFlow.Count > 0)
            {
                lstArchival = (from child in lstSampleWorkFlow
                               where (child.Status != "Archive" && child.Status != "Archived")
                               select child).ToList();
                if (lstArchival.Count > 0)
                {
                    long Visitid = lstArchival[0].PatientVisitID;
                    //= lstSampleWorkFlow[0].PatientVisitID;
                    //Visitid=(from rs in lstSampleWorkFlow where rs.Status!="Archive" && rs.Status!="Archived"
                    //                               select rs.PatientVisitID).Distinct();
                    string UID = lstArchival[0].UID;
                    PatientDetail.LoadPatientDetails(Visitid, orgid, UID);
                    divPatientDetails.Style.Add("display", "block");
                    tblLegends.Style.Add("display", "table");
                }
                lstPendingSampleWorkFlow = (from child in lstSampleWorkFlow
                                            where (child.Status != InvStatus.Completed && child.Status != InvStatus.Approved && child.Status != "Extra Samples")
                                            select child).ToList();

                if (lstPendingSampleWorkFlow.Count > 0)
                {
                    ObjSampleWorkFlow = lstPendingSampleWorkFlow[0];
                    lstYettoProcessSampleWorkFlow.Add(ObjSampleWorkFlow);
                }
                if (lstYettoProcessSampleWorkFlow.Count > 0)
                {
                    grdSampleDeatails.DataSource = lstYettoProcessSampleWorkFlow;
                    grdSampleDeatails.DataBind();
                    if (lstYettoProcessSampleWorkFlow.Count > 0)
                    {




                        if (lstYettoProcessSampleWorkFlow[0].Status == "Archived")
                        {
                            ucSampleArchival.Search();
                            mpexSampleArchival.Show();

                        }
                        else if (ExtraSampleID == 0 && rbtnManualArchive.Checked == false && lstYettoProcessSampleWorkFlow[0].DeptName == "There is No Tray is Available for this Sample" && lstSampleWorkFlow.Count==1)
                        {
                            mpesampleselection.Show();
                        }
                        else if (ExtraSampleID != 0 && rbtnManualArchive.Checked == true)
                        {
                            ucSampleArchival.Search();
                            mpexSampleArchival.Show();
                        }



                    }
                    tblGridSampleDetails.Style.Add("display", "table");
                }
                else
                {
                    grdSampleDeatails.DataSource = null;
                    grdSampleDeatails.DataBind();
                    tblGridSampleDetails.Style.Add("display", "none");
                }

                for (int i = 1; i < lstPendingSampleWorkFlow.Count; i++)
                {
                    ObjPendingSampleWorkFlow = lstPendingSampleWorkFlow[i];
                    lstNextSampleWorkFlow.Add(ObjPendingSampleWorkFlow);
                }

                if (lstNextSampleWorkFlow.Count > 0)
                {
                    GrdPendingSamples.DataSource = lstNextSampleWorkFlow;
                    GrdPendingSamples.DataBind();
                    tblGrdPendingSamples.Style.Add("display", "table");
                }
                else
                {
                    GrdPendingSamples.DataSource = null;
                    GrdPendingSamples.DataBind();
                    tblGrdPendingSamples.Style.Add("display", "none");
                }

                lstCompletedSampleWorkFlow = (from child in lstSampleWorkFlow
                                              where child.Status == InvStatus.Completed || child.Status == InvStatus.Approved
                                              select child).ToList();
                if (lstCompletedSampleWorkFlow.Count > 0)
                {

                    GrdCompletedSamples.DataSource = lstCompletedSampleWorkFlow;
                    GrdCompletedSamples.DataBind();
                    tblGrdCompletedSamples.Style.Add("display", "table");
                }
                else
                {
                    tblGrdCompletedSamples.Style.Add("display", "none");
                    GrdCompletedSamples.DataSource = null;
                    GrdCompletedSamples.DataBind();
                }
            }
            else
            {
                divPatientDetails.Style.Add("display", "none");
                tblLegends.Style.Add("display", "none");
                tblGridSampleDetails.Style.Add("display", "none");
                tblGrdPendingSamples.Style.Add("display", "none");
                tblGrdCompletedSamples.Style.Add("display", "none");
                grdSampleDeatails.DataSource = null;
                grdSampleDeatails.DataBind();
                GrdCompletedSamples.DataSource = null;
                GrdCompletedSamples.DataBind();
                GrdPendingSamples.DataSource = null;
                GrdPendingSamples.DataBind();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
//                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "javascript:alert('Enter the Valid BarCode')", true);
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSearch_OnClick in SampleWorkFlow Page.", ex);
        }
        //hdnExtraSampleID.Value = "";
        //txtBarcode.Text = "";
        txtBarcode.Focus();
    }

    protected void grdSampleDeatails_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SampleWorkFlow ObjSampleWorkFlow = (SampleWorkFlow)e.Row.DataItem;
                e.Row.BackColor = System.Drawing.Color.FromName("#FFFF00");
                if ((ObjSampleWorkFlow.Status == "Archive" || ObjSampleWorkFlow.Status == "Archived") && ObjSampleWorkFlow.DeptName.ToLower().Replace(" ", "") != "thereisnotrayisavailableforthissample")
                {
                    Button btnshow = (Button)e.Row.FindControl("btnShow");
                    btnshow.Style.Add("display", "block");
                    string[] objId = ObjSampleWorkFlow.TrayIDs.Split(',');
                    //string function = "Show('" + objId[0] + "','" + objId[1] + "','" + objId[2] + "','" + objId[3] + "','" + objId[4] + "','" + objId[5] + "','" + objId[6] + "','" + objId[7] + "','" + objId[8] + "','" + objId[9] + "')";
                    //btnshow.Attributes.Add("OnClick", function);


                    HiddenField hdnTryID = (HiddenField)ucSampleArchival.FindControl("hdnTryID");
                    HiddenField hdnBuldID = (HiddenField)ucSampleArchival.FindControl("hdnBuldID");
                    HiddenField hdnFloorID = (HiddenField)ucSampleArchival.FindControl("hdnFloorID");
                    HiddenField hdnStroageID = (HiddenField)ucSampleArchival.FindControl("hdnStroageID");
                    HiddenField hdnStorgeUnit = (HiddenField)ucSampleArchival.FindControl("hdnStorgeUnit");
                    HiddenField hdnNewBarcode = (HiddenField)ucSampleArchival.FindControl("hdnNewBarcode");
                    HiddenField hdnRowNo = (HiddenField)ucSampleArchival.FindControl("hdnRowNo");
                    HiddenField hdnColNo = (HiddenField)ucSampleArchival.FindControl("hdnColNo");

                    hdnTryID.Value = objId[0];
                    hdnBuldID.Value = objId[1];
                    hdnFloorID.Value = objId[2];
                    hdnStroageID.Value = objId[3];
                    hdnStorgeUnit.Value = objId[4];
                    hdnNewBarcode.Value = objId[7];
                    hdnRowNo.Value = objId[8];
                    hdnColNo.Value = objId[9];

                }
                else
                {
                    Button btnshow = (Button)e.Row.FindControl("btnShow");
                    btnshow.Style.Add("display", "none");
                }

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdSampleDeatails_OnRowDataBound in SampleWorkFlow Page.", ex);
        }
    }
    protected void GrdPendingSamples_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.BackColor = System.Drawing.Color.FromName("#A9A9A9");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GrdPendingSamples_OnRowDataBound in SampleWorkFlow Page.", ex);
        }
    }
    protected void GrdCompletedSamples_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.BackColor = System.Drawing.Color.FromName("#90EE90");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GrdCompletedSamples_OnRowDataBound in SampleWorkFlow Page.", ex);
        }
    }
    protected void BtnFinish_Click(object sender, EventArgs e)
    {
        ucSampleArchival.Search();
        mpexSampleArchival.Show();

    }
    protected void grdSampleDeatails_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "show")
        {
            ucSampleArchival.Search();
            mpexSampleArchival.Show();
            //btnSearch_OnClick(sender, e);

        }

    }

    protected void loadSampleType()
    {
        long returncode = -1;
        long pSampleGroupID = 0;
        Investigation_BL InvBL = new Investigation_BL(base.ContextInfo);
        //List<StorageRackMaster> lstTrayname = new List<StorageRackMaster> ();
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        returncode = new Master_BL(base.ContextInfo).GetSampleSubType(OrgID, pSampleGroupID, out  lstInvSampleMaster);
        if (lstInvSampleMaster.Count > 0)
        {
            var lstInvSampleMaster1 = lstInvSampleMaster.OrderBy(x => x.SampleDesc).ToList();
            ddsampletype.DataSource = lstInvSampleMaster1;
            ddsampletype.DataTextField = "SampleDesc";
            ddsampletype.DataValueField = "SampleCode";
            ddsampletype.DataBind();
            ddsampletype.Items.Insert(0, strltHead);
            //ddsampletype.Items.Insert(0, "--Select--");

            ddSampletypelist.DataSource = lstInvSampleMaster1;
            ddSampletypelist.DataTextField = "SampleDesc";
            ddSampletypelist.DataValueField = "SampleCode";
            ddSampletypelist.DataBind();
            //ddSampletypelist.Items.Insert(0, "--Select--");
            ddSampletypelist.Items.Insert(0, strltHead);

        }

    }
}
