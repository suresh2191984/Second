using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using Attune.Solution.DAL;

public partial class Lab_ReceiveSampleWithRange : BasePage
{
    List<CollectedSample> lstOrderedSamples = new List<CollectedSample>();
    List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    List<InvReasonMasters> lstInvReasonMaster1 = new List<InvReasonMasters>();
    List<InvSampleStatusmaster> lstInvSampleStatus1 = new List<InvSampleStatusmaster>();
    List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
    long returnCode = -1;
    int MaxRowRange = 25;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(OrgID, "ReceiveSample", out lstInvSampleStatus1);
        lstInvSampleStatus = lstInvSampleStatus1.FindAll(P => P.InvSampleStatusDesc == "Received" || P.InvSampleStatusDesc == "Rejected");
        LoadReasons();
        if (!IsPostBack)
        {
            try
            {
                hdnSampleList.Value = "";
                hdnDefaultSampleStatus.Value = "";
                hdnchangedSampleStatus.Value = "";
                hdnChangedReason.Value = "";
                if (RoleName == "Lab Technician" || RoleName == "Accession")
                {
                    tdAberrant.Style.Add("display", "block");
                }
                List<InvSampleStatusmaster> templstInvSampleStatus = lstInvSampleStatus.FindAll(P => P.InvSampleStatusDesc == "Received");
                if (templstInvSampleStatus.Count > 0)
                {
                    hdnDefaultSampleStatus.Value = templstInvSampleStatus[0].InvSampleStatusID.ToString();
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Exception in Receive Sample Page on Load", ex);
            }
        }
        

    }
    public void LoadReasons()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(OrgID, out lstInvReasonMaster);
        hdnReasonList.Value = "";
        if (lstInvReasonMaster.Count > 0)
        {
            foreach (InvReasonMasters oReasonMaster in lstInvReasonMaster)
            {
                hdnReasonList.Value += oReasonMaster.StatusID + "-" + oReasonMaster.ReasonID + "~" + oReasonMaster.ReasonDesc + "^";
            }
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string SearchNo = string.Empty;
        int SearchType = 0;
        if (txtSearchTxt.Text != "")
        {
            SearchNo = txtSearchTxt.Text.Trim();
        }
        if (ddlSearchType.SelectedValue != "-1")
        {
            SearchType = Convert.ToInt32(ddlSearchType.SelectedValue);
        }
        returnCode = new Investigation_BL(base.ContextInfo).GetSamplesByID(OrgID,RoleID, SearchType, SearchNo, out lstOrderedSamples);

        if (lstOrderedSamples.Count > 0)
        {   
            hdnSampleList.Value +=
            lstOrderedSamples[0].SampleID.ToString() + '~' +
            lstOrderedSamples[0].BarcodeNumber + '~' +
            lstOrderedSamples[0].SampleDesc + '~' +
            lstOrderedSamples[0].InvestigationName + '~' +
            lstOrderedSamples[0].SampleContainerName + '~' +
            lstOrderedSamples[0].gUID + '~' +
            lstOrderedSamples[0].DeptName + '~' +
            lstOrderedSamples[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt")+'~' +
            hdnDefaultSampleStatus.Value+'~'+
            hdnchangedSampleStatus.Value+'~'+
            lstOrderedSamples[0].InvestigationID + '~'+
            lstOrderedSamples[0].PatientVisitID + '~'+
            lstOrderedSamples[0].PatientName + '~'+
            lstOrderedSamples[0].DeptID + '~'+
            hdnChangedReason.Value + '~'+
            hdnReasontxt.Value + '^';
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "BarCodeSearch", "alert('Sample No:"+SearchNo+" Is Not Found');", true);
        }
        createDynamicTable();
        txtSearchTxt.Text = "";
        txtSearchTxt.Focus();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            List<CollectedSample> CollectedSamples = new List<CollectedSample>();
            SampleTracker SampleTracker = null;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            createDynamicTable();
            string[] samplesList = hdnSampleList.Value.Split('^');
            if (samplesList.Length > 1)
            {
                for (int i = 0; i < samplesList.Length - 1; i++)
                {
                    SampleTracker = new SampleTracker();
                    string[] SampleDetail = samplesList[i].Split('~');
                    SampleTracker.SampleID = Convert.ToInt32(SampleDetail[0]);
                    SampleTracker.CreatedBy = Convert.ToInt32(LID);
                    SampleTracker.PatientVisitID = Convert.ToInt64(SampleDetail[11]);
                    SampleTracker.OrgID = OrgID;
                    SampleTracker.CollectedIn = ILocationID;
                    SampleTracker.DeptID = Convert.ToInt32(SampleDetail[13]);
                    SampleTracker.Reason = SampleDetail[15];
                    if (SampleDetail[9] != "")
                    {
                        SampleTracker.InvSampleStatusID = Convert.ToInt32(SampleDetail[9]);
                    }
                    else
                    {
                        SampleTracker.InvSampleStatusID = Convert.ToInt32(SampleDetail[8]);
                    }
                    lstSampleTracker.Add(SampleTracker);
                }
            }
            if (lstSampleTracker.Count > 0)
            {
                returncode = invBL.UpdateSampleStatusDetails(lstSampleTracker);
                if (returncode != 0)
                {
                    lstSampleTracker.Clear();
                    hdnSampleList.Value = "";
                    createDynamicTable();
                    txtSearchTxt.Focus();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "SaveMessage", "alert('Samples are Saved Successfully');", true);
                }
            }
        }

        catch (System.Threading.ThreadAbortException th)
        {
            string exep = th.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSubmit_Click", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        hdnSampleList.Value = "";
        createDynamicTable();
        txtSearchTxt.Focus();
    }
    public void createDynamicTable()
    {
        string[] samplesList = hdnSampleList.Value.Split('^');
        if (samplesList.Length > 1)
        {
            tbBtns.Style.Add("display", "block");
            listTab.Style.Add("display", "block");
            tdRowNum.Style.Add("display", "block");
            lblRowNumber.Text = Convert.ToString(samplesList.Length - 1) + " Out Of " + Convert.ToString(MaxRowRange);
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.TableSection = TableRowSection.TableHeader;
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();
            TableCell cell4 = new TableCell();
            TableCell cell5 = new TableCell();
            TableCell cell6 = new TableCell();
            TableCell cell7 = new TableCell();
            TableCell cell8 = new TableCell();
            TableCell cell9 = new TableCell();
            TableCell cell10 = new TableCell();
            TableCell cell11 = new TableCell();
            TableCell cell12 = new TableCell();
            TableCell cell13 = new TableCell();
            TableCell cell14 = new TableCell();

            HiddenField hdnStatus = new HiddenField();

            cell1.Attributes.Add("align", "left");
            cell1.Text = "<B>Sample ID</B>";
            cell1.BorderWidth = 1;
            cell1.Style.Add("display", "none");
            //cell1.BorderStyle = BorderStyle.Dotted;

            cell2.Attributes.Add("align", "left");
            cell2.Text = "<B>UID</B>";
            cell2.BorderWidth = 1;
            //cell2.BorderStyle = BorderStyle.Dotted;

            cell4.Attributes.Add("align", "left");
            cell4.Text = "<B>Test name</B>";
            cell4.BorderWidth = 1;
            //cell4.BorderStyle = BorderStyle.Dotted;

            cell3.Attributes.Add("align", "left");
            cell3.Text = "<B>Sample Name</B>";
            cell3.BorderWidth = 1;
            //cell3.BorderStyle = BorderStyle.Dotted;

            cell5.Attributes.Add("align", "left");
            cell5.Text = "<B>Sample type / Additive</B>";
            cell5.BorderWidth = 1;
            //cell5.BorderStyle = BorderStyle.Dotted;

            cell6.Attributes.Add("align", "left");
            cell6.Text = "<B>Patient Age / SEX</B>";
            cell6.BorderWidth = 1;
            //cell6.BorderStyle = BorderStyle.Dotted;

            cell7.Attributes.Add("align", "left");
            cell7.Text = "<B>DEPT (Location)</B>";
            cell7.BorderWidth = 1;
            //cell7.BorderStyle = BorderStyle.Dotted;

            cell8.Attributes.Add("align", "left");
            cell8.Text = "<B>Collected DATE TIME</B>";
            cell8.BorderWidth = 1;
            //cell8.BorderStyle = BorderStyle.Dotted;

            cell9.Attributes.Add("align", "left");
            cell9.Text = "<B>Status</B>";
            cell9.BorderWidth = 1;
            //cell9.BorderStyle = BorderStyle.Dotted;

            cell10.Attributes.Add("align", "left");
            cell10.Text = "<B>Reason</B>";
            cell10.BorderWidth = 1;
            //cell10.Style.Add("display", "none");

            cell11.Attributes.Add("align", "left");
            cell11.Text = "<B>VisitId</B>";
            cell11.BorderWidth = 1;
            cell11.Style.Add("display", "none");

            cell12.Attributes.Add("align", "left");
            cell12.Text = "<B>InvestigationID</B>";
            cell12.BorderWidth = 1;
            cell12.Style.Add("display", "none");

            cell13.Attributes.Add("align", "left");
            cell13.Text = "<B>Patient Name</B>";
            cell13.BorderWidth = 1;

            cell14.Attributes.Add("align", "center");
            cell14.Text = "<B>Delete</B>";
            cell14.BorderWidth = 1;

            headerRow.Cells.Add(cell1);
            headerRow.Cells.Add(cell2);
            headerRow.Cells.Add(cell13);
            headerRow.Cells.Add(cell3);
            headerRow.Cells.Add(cell4);
            headerRow.Cells.Add(cell5);
            headerRow.Cells.Add(cell6);
            headerRow.Cells.Add(cell7);
            headerRow.Cells.Add(cell8);
            headerRow.Cells.Add(cell9);
            headerRow.Cells.Add(cell10);
            headerRow.Cells.Add(cell11);
            headerRow.Cells.Add(cell12);
            headerRow.Cells.Add(cell14);

            headerRow.BorderWidth = 1;
            headerRow.Font.Bold = true;
            headerRow.CssClass = "Duecolor";
            listTab.Rows.Add(headerRow);

            headerRow = new TableHeaderRow();
            headerRow.TableSection = TableRowSection.TableHeader;
            cell1 = new TableCell();
            cell1.ColumnSpan = 7;
            //cell1.BorderStyle = BorderStyle.Solid ;
            headerRow.Cells.Add(cell1);
            listTab.Rows.Add(headerRow);

            TableRow bodyRow = null;

            for (int i = 0; i < samplesList.Length - 1; i++)
            {
                string[] SampleDetail = samplesList[i].Split('~');
                DropDownList ddlStatus = new DropDownList();
                ImageButton imgDelet = new ImageButton();
                hdnStatus = new HiddenField();
                hdnStatus.ID = "hdnStatus" + SampleDetail[0].ToString();
                hdnStatus.Value = hdnStatus.Value;
                ddlStatus.ID = "ddlStatus" + SampleDetail[0].ToString();
                ddlStatus.Width = 100;
                ddlStatus.DataSource = lstInvSampleStatus;
                ddlStatus.DataTextField = "InvSampleStatusDesc";
                ddlStatus.DataValueField = "InvSampleStatusID";
                ddlStatus.DataBind();
                DropDownList ddlReason = new DropDownList();
                ddlReason.ID = "ddlReason" + SampleDetail[0].ToString();
                imgDelet.ID = "imgDelet" + SampleDetail[0].ToString();
                imgDelet.ImageUrl = "~/Images/Delete.jpg";
                imgDelet.OnClientClick = "javascript:DeleteSample(this.id);";
                if (SampleDetail[9] != "")
                {
                    ddlStatus.SelectedValue = SampleDetail[9];
                    lstInvReasonMaster1=lstInvReasonMaster.FindAll(P => P.StatusID == Convert.ToInt32(SampleDetail[9]));
                    ddlReason.DataSource = lstInvReasonMaster1;
                    ddlReason.DataTextField = "ReasonDesc";
                    ddlReason.DataValueField = "ReasonID";
                    ddlReason.DataBind();
                    if (SampleDetail[14] != "")
                    {
                        ddlReason.SelectedValue = SampleDetail[14];
                    }
                    else
                    {
                        ddlReason.Items.Insert(0, "-----Select-----");
                    }
                }
                else
                {
                    ddlReason.Items.Insert(0, "-----Select-----");
                }
                bodyRow = new TableRow();
                bodyRow.TableSection = TableRowSection.TableBody;
                cell1 = new TableCell();
                cell2 = new TableCell();
                cell3 = new TableCell();
                cell4 = new TableCell();
                cell5 = new TableCell();
                cell6 = new TableCell();
                cell7 = new TableCell();
                cell8 = new TableCell();
                cell9 = new TableCell();
                cell10 = new TableCell();
                cell11 = new TableCell();
                cell12 = new TableCell();
                cell13 = new TableCell();
                cell14 = new TableCell();


                cell1.Attributes.Add("align", "left");
                cell1.Text = SampleDetail[0].ToString();
                cell2.Attributes.Add("align", "left");
                cell2.Text = SampleDetail[1].ToString();
                cell3.Text = SampleDetail[2].ToString();
                cell4.Text = SampleDetail[3].ToString();
                cell5.Text = SampleDetail[4].ToString();
                cell6.Text = SampleDetail[5].ToString();
                cell7.Text = SampleDetail[6].ToString();
                cell8.Text = SampleDetail[7].ToString();
                cell9.Controls.Add(ddlStatus);
                cell9.Controls.Add(hdnStatus);
                cell10.Controls.Add(ddlReason);                
                cell11.Text = SampleDetail[11].ToString();
                cell12.Text = SampleDetail[10].ToString();
                cell13.Text = SampleDetail[12].ToString();
                cell14.Controls.Add(imgDelet);
                cell14.Attributes.Add("align", "center");

                cell1.Style.Add("display", "none");
               // cell10.Style.Add("display", "none");
                cell11.Style.Add("display", "none");
                cell12.Style.Add("display", "none");

                cell1.BorderWidth = 1;
                cell2.BorderWidth = 1;
                cell3.BorderWidth = 1;
                cell4.BorderWidth = 1;
                cell5.BorderWidth = 1;
                cell6.BorderWidth = 1;
                cell7.BorderWidth = 1;
                cell8.BorderWidth = 1;
                cell9.BorderWidth = 1;
                cell10.BorderWidth = 1;
                cell11.BorderWidth = 1;
                cell12.BorderWidth = 1;
                cell13.BorderWidth = 1;
                cell14.BorderWidth = 1;

                ddlStatus.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlStatus.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                ddlStatus.Attributes.Add("onchange", "javascript:ChangeSampleStatus(this.id," + hdnStatus.ID + ");fnLoadReasons('" + ddlReason.ClientID.ToString() + "','" + ddlStatus.ClientID.ToString() + "');");
                ddlStatus.ToolTip = "Select Sample Status";
                DropDownList ddlStatus1 = (DropDownList)cell9.FindControl("ddlStatus" + SampleDetail[0].ToString());

                ddlReason.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlReason.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                ddlReason.Attributes.Add("onchange", "javascript:ChangeSampleStatusReason(this.id," + hdnStatus.ID + ");");
                ddlReason.ToolTip = "Select Sample Status";

                bodyRow.Cells.Add(cell1);;
                bodyRow.Cells.Add(cell2);
                bodyRow.Cells.Add(cell13);
                bodyRow.Cells.Add(cell3);
                bodyRow.Cells.Add(cell4);
                bodyRow.Cells.Add(cell5);
                bodyRow.Cells.Add(cell6);
                bodyRow.Cells.Add(cell7);
                bodyRow.Cells.Add(cell8);
                bodyRow.Cells.Add(cell9);
                bodyRow.Cells.Add(cell10);
                bodyRow.Cells.Add(cell11);
                bodyRow.Cells.Add(cell12);
                bodyRow.Cells.Add(cell14);

                bodyRow.BorderWidth = Unit.Pixel(1);
                bodyRow.Style.Add("font-size", "12px");
                bodyRow.Font.Bold = false;
                listTab.Rows.Add(bodyRow);
            }
        }
        else
        {
            tbBtns.Style.Add("display", "none");
            listTab.Style.Add("display", "none");
            tdRowNum.Style.Add("display", "none");
        }
    }
    protected void btnDummy_Click(object sender, EventArgs e)
    {
        createDynamicTable();
    }
}
