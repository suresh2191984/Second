using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections.Generic;
public partial class Investigation_WorkListFromVisitToVisit : BasePage
{
    public Investigation_WorkListFromVisitToVisit()
        : base("Investigation_WorkListFromVisitToVisit_aspx")
    {
    }
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
   
    int pOrderedCount = -1;
    long vid = 0;
    long returnCode = -1;
    string fromVisit = string.Empty;
    string toVisit = string.Empty;
    long i = 0;
    int vtyp = -1;
    List<WorkOrder> lstWorkList = new List<WorkOrder>();
    Investigation_BL investigationBL ;
    string intHistoryMode = string.Empty;
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
    string strAll = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_20 == null ? "All" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_20;

    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        hdnOrgID.Value = OrgID.ToString();
        if (!IsPostBack)
        {
            List<InvDeptMaster> lDeptmaster = new List<InvDeptMaster>();
            returnCode = investigationBL.GetInvforDept(OrgID, out lDeptmaster);
            LoadInvestigationDepartment(lDeptmaster);
            LoadInvClientMaster();
            LoadLocation();
            LoadPriority();
            txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        }
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string strVisistId = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_14 == null ? "VisitID" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_14;
        string strName = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_15 == null ? "Name" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_15;
        string strDetails = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_16 == null ? "Details" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_16;
        string strRecDate = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_17 == null ? "Rec.Date" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_17;
        string strRefBy = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_18 == null ? "Ref.By" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_18;

        try
        {
            int deptID = 0;
            fromVisit = txtFromVisit.Text == "" ? "0" : txtFromVisit.Text;
            toVisit = txtToVisit.Text == "" ? "0" : txtToVisit.Text;
            int Client = Convert.ToInt32(ddlClients.SelectedValue);
            string gUID = string.Empty;
            string IsIncludevalues = "Y";

            string fromdate = txtFrom.Text;
            string todate = txtTo.Text;

            if (ddlDept.SelectedValue != "0")
            {
                deptID = Convert.ToInt32(ddlDept.SelectedValue);
            }
            if (chkIsIncludevalues.Checked == true)
            {
                IsIncludevalues = "Y";
            }
            else
            {
                IsIncludevalues = "N";
            }

            if ((fromVisit != string.Empty &&  toVisit != string.Empty)||(txtFrom.Text != string.Empty && txtTo.Text != string.Empty))
            {
                //Perfomance issue needs to change(added by venkat)
                //for (i = fromVisit; i <= toVisit; i++)
                //{
                    List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
                    investigationBL.GetInvestigationDetailsForExternalVisitID(fromVisit,toVisit, OrgID, RoleID, "", ILocationID,fromdate,todate, out lstPatientInvestigation);
                    foreach (PatientInvestigation patient in lstPatientInvestigation)
                    {
                        PatientInvestigation objInvest = new PatientInvestigation();
                        objInvest.InvestigationID = patient.InvestigationID;
                        objInvest.InvestigationName = patient.InvestigationName;
                        objInvest.PatientVisitID = patient.PatientVisitID;
                        objInvest.GroupID = patient.GroupID;
                        objInvest.GroupName = patient.GroupName;
                        objInvest.Status = patient.Status;
                        objInvest.CollectedDateTime = patient.CreatedAt;
                        objInvest.CreatedBy = LID;
                        objInvest.Type = patient.Type;
                        objInvest.OrgID = OrgID;
                        objInvest.InvestigationMethodID = 0;
                        objInvest.KitID = 0;
                        objInvest.InstrumentID = 0;
                        objInvest.UID = patient.UID;
                        SaveInvestigation.Add(objInvest);
                    }
                    //if (lstPatientInvestigation.Count > 0)
                    //{
                    //    if (lstPatientInvestigation[0].UID != null)
                    //    {
                    //        gUID = lstPatientInvestigation[0].UID;
                    //    }
                    //}
                    if (SaveInvestigation.Count > 0)
                    {
                        //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigationForWorkList(SaveInvestigation, OrgID, gUID, out pOrderedCount);
                    }
                //}
                    long LocationID = Convert.ToInt64(ddlLocation.SelectedItem.Value);
                    int PriorityID = 0;
                    string InvName = txtInvName.Text;
                    intHistoryMode = ddlMode.SelectedValue;
                    returnCode = investigationBL.GetWorkListFromVisitToVisit(fromVisit.ToString(), toVisit.ToString(), OrgID, deptID,ILocationID
                        , Client, LocationID, txtWardName.Text, InvName, PriorityID, out lstWorkList, Convert.ToInt32(ddlVisitType.SelectedItem.Value),
                        fromdate, todate, Convert.ToInt32(intHistoryMode), "View", LID, IsIncludevalues, ddlPreference.SelectedItem.Value);
                //lstWorkList = lstWorkList.Where(O => O.DeptID ==Convert.ToInt64(ddlDept.SelectedItem.Value)).ToList();

                if (lstWorkList.Count > 0)
                {
                    
                    lbltxtSTR.Visible = false;
                    
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    //TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();
                    TableCell cell7 = new TableCell();

                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<u><B>" + strVisistId.Trim() + "</B></u>";
                    //cell1.BorderStyle = BorderStyle.Dotted;

                    cell2.Attributes.Add("align", "left");
                    cell2.Text = "<u><B>" + strName.Trim() + "</</u>";
                    //cell2.BorderStyle = BorderStyle.Dotted;

                    //cell4.Attributes.Add("align", "left");
                    //cell4.Text = "<u><B>AGE</B></u>";
                    //cell3.BorderStyle = BorderStyle.Dotted;

                    cell3.Attributes.Add("align", "left");
                    cell3.Text = "<u><B>" + strDetails.Trim() + "</B></u>";
                    //cell4.BorderStyle = BorderStyle.Dotted;

                    cell5.Attributes.Add("align", "left");
                    cell5.Text = "<u><B>" + strRecDate.Trim() + "</B></u>";
                    //cell5.BorderStyle = BorderStyle.Dotted;

                    cell6.Attributes.Add("align", "left");
                    cell6.Text = "<u><B>" + strRefBy.Trim() + "</B></u>";
                    //cell6.BorderStyle = BorderStyle.Dotted;

                    //cell7.Attributes.Add("align", "left");
                    //cell7.Text = "<B>Ref.By</B>";
                    //cell7.BorderStyle = BorderStyle.Dotted;

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    //row.Cells.Add(cell4);
                    row.Cells.Add(cell5);
                    row.Cells.Add(cell6);
                    //row.Cells.Add(cell7);
                    listTab.Rows.Add(row);

                    row = new TableRow();
                    cell1 = new TableCell();
                    cell1.ColumnSpan = 7;
                    //cell1.BorderStyle = BorderStyle.Solid ;
                    row.Cells.Add(cell1);
                    listTab.Rows.Add(row);

                    foreach (WorkOrder objWL in lstWorkList)
                    {
                        row = new TableRow();
                        cell1 = new TableCell();
                        cell2 = new TableCell();
                        cell3 = new TableCell();
                        //cell4 = new TableCell();
                        cell5 = new TableCell();
                        cell6 = new TableCell();
                        cell7 = new TableCell();

                        cell1.Attributes.Add("align", "left");
                        cell1.Text = Convert.ToString(objWL.StrVisitID);
                        cell2.Attributes.Add("align", "left");
                        if (objWL.PatientName != null && objWL.Age != null)
                        {
                            cell2.Text = objWL.PatientName + "<br>" + objWL.Age;
                        }
                        else { cell2.Text = ""; }
                        //cell4.Attributes.Add("align", "left");
                        //cell4.Text = objWL.Age;
                        cell3.Attributes.Add("align", "left");
                        if (objWL.Status == "Cancel")
                        {
                            cell3.Text = "**"+ objWL.InvestigationName ;
                            lbltxtSTR.Visible = true;
                        }
                        else if (objWL.Status == "NewlyAdded")
                        {
                            cell3.Text = "*" + objWL.InvestigationName;
                            lbltxtSTR.Visible = true;
                        }
                        else
                        {
                            cell3.Text = objWL.InvestigationName;
                        }
                        // == string.Empty ? "" : objWL.InvestigationName + "_____________________________________________________________________";
                        
                        //cell5.Attributes.Add("align", "left");
                        //cell5.Text = objWL.InvestigationName;
                        //cell5.Attributes.Add("align", "left");
                        //cell5.Text = objWL.ReceivedOn;

                        cell5.Attributes.Add("align", "left");
                        cell5.Text = objWL.ReceivedOn;

                        cell6.Attributes.Add("align", "left");
                        cell6.Text = objWL.ReferingPhysicianName;

                        row.Cells.Add(cell1);
                        row.Cells.Add(cell2);

                        row.Cells.Add(cell3);
                        //row.Cells.Add(cell4);
                        row.Cells.Add(cell5);
                        row.Cells.Add(cell6);
                        //row.BorderWidth = Unit.Pixel(1);
                        row.Style.Add("font-size", "12px");
                        row.Font.Bold = false;
                        listTab.Rows.Add(row);
                    }
                    lblStatus.Visible = false;
                    tabPrintButton.Style.Add("display", "block");
                    hypLnkPrint.NavigateUrl = "PrintWorkListFromVisitToVisit.aspx?fvid=" + fromVisit + "&tvid=" + toVisit + "&deptID=" 
                        + deptID + "&vtyp=" + vtyp + "&clientID="+Client +"&LocationID=" + ddlLocation.SelectedItem.Value +"&WardName="
                        + txtWardName.Text + "&InvName=" + txtInvName.Text + "&PriorityID=0" + "&fDate=" + fromdate + "&tDate=" + todate
                        + "&hMode=" + ddlMode.SelectedItem.Value + "&PageMode=Print" + "&IsIncludevalues=" + IsIncludevalues;
						hypLnkPrint.Text = "Print";
                }
                else
                {
                    tabPrintButton.Style.Add("display", "none");
                    lblStatus.Visible = true;
                    lbltxtSTR.Visible = false;
                }
            }
            else
            {
                tabPrintButton.Style.Add("display", "none");
                lblStatus.Visible = true;
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void LoadLocation()
    {
        try
        {
            long retCode = -1;
            List<OrganizationAddress> lOrgAdr = new List<OrganizationAddress>();
            retCode = new AdminReports_BL(base.ContextInfo).pGetOrganizationLocation(OrgID, ILocationID, 0, out lOrgAdr);
            //var q = from p in lstOrgLocation
            //       where p.OrgID ==Convert.ToInt64(ddlOrglocation.SelectedItem.Value)
            //       select p;
            ddlLocation.DataSource = lOrgAdr;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID"; 
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem(strSelect.Trim(), "-1"));
            //ddlLocation.Items[0].Value = "-1";
          
            ddlLocation.SelectedValue = "-1";
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }
     public void LoadInvClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            retCode = patBL.GetInvClientMaster(OrgID, "Y", out getInvClientMaster);

            ddlClients.DataSource = getInvClientMaster;
            ddlClients.DataTextField = "ClientName";
            ddlClients.DataValueField = "ClientID";
            ddlClients.DataBind();
            ddlClients.Items.Insert(0, strSelect.Trim());
            ddlClients.Items[0].Value = "0";
            ddlClients.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }
    public void LoadInvestigationDepartment(List<InvDeptMaster> lDeptmaster)
    {
        try
        {
            if (lDeptmaster.Count > 0)
            {
                var lstdpt = from lst in lDeptmaster
                             where lst.Display == "Y"
                             select lst;
                ddlDept.DataSource = lstdpt;
                ddlDept.DataTextField = "DeptName";
                ddlDept.DataValueField = "DeptID";
                ddlDept.DataBind();
            }
            ddlDept.Items.Insert(0, strAll.Trim());
            ddlDept.Items[0].Value = "0";
            //ddlDept.Items.Insert(0, "-----Select-----");
            //ddlDept.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Department Details.", ex);
        }
    }
    public void LoadPriority()
    {
        try
        {
            long returncode = -1;
            string domains = "Preference";
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


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {

                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Preference"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlPreference.DataSource = childItems;
                    ddlPreference.DataTextField = "DisplayText";
                    ddlPreference.DataValueField = "Code";
                    ddlPreference.DataBind();
                }

            }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
            //edisp.Visible = true;

        }

    }
}