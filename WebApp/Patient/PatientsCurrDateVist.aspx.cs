using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;

public partial class Patient_PatientsCurrDateVist : BasePage
{

    public Patient_PatientsCurrDateVist()
        : base("Patient\\PatientsCurrDateVist.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string pathname = string.Empty;
    long returnCode = -1;
    long patientID = -1;
    long visitID = 0;
    long pvisitID = 0;
    int totalCount = -1;
    long physicainID = -1;
    int OP;
    string roleName = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<PatientVisit> lstPhysicianPV = new List<PatientVisit>();

    PatientVisit_BL pvbl;
    List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>(); 
    IP_BL ipBL;
    List<Organization> lstOrganisation = new List<Organization>();


    // OrgID = 0;
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    string strselectphysician = Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_02 == null ? "Select Physician" : Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_02;
    string Strnomatchingrecod = Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_03 == null ? "No Matching Record Found" : Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_03;
    protected void Page_Load(object sender, EventArgs e)
    {
        pvbl = new PatientVisit_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            hdnselectphysician.Value = strselectphysician;
            long lresult = new Schedule_BL(base.ContextInfo).getOrganizations(out lstOrganisation);
            lstOrganisation = (from lstorg in lstOrganisation
                               where lstorg.OrgID == OrgID
                               select lstorg).ToList();

            if (!IsPostBack)
            {
                LoadLocation();
                AddSearchColumns();
                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                roleName = RoleName;// string roleName = path1.Split('/')[1];

                if ((roleName == "Administrator") || (roleName == "Receptionist"))
                {
                    if (lstOrganisation[0].OrganizationTypeID != 3)
                    {
                        divFilter.Style.Add("display", "block");
                        divPrintBtn.Style.Add("display", "block");
                    }
                    else
                    {
                        divFilter.Style.Add("display", "none");
                        divPrintBtn.Style.Add("display", "block");
                    }

                    PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
                    List<Physician> lstPhysician = new List<Physician>();
                    returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysician);
                    ddlPhysician.DataSource = lstPhysician;
                    ddlPhysician.DataTextField = "PhysicianName";
                    ddlPhysician.DataValueField = "LoginID";
                    ddlPhysician.DataBind();

                    ddlPhysician.Items.Insert(0, new ListItem(strselectphysician.Trim(), "0"));
                }

                OP = Convert.ToInt32(TaskHelper.SearchType.TodaysVisit);
                getTodaysPatientVisit("", 0);

                GateWay gateWay = new GateWay(base.ContextInfo);
                List<Config> lstConfig = new List<Config>();
                returnCode = gateWay.GetConfigDetails("PrintSampleBarcode", OrgID, out lstConfig);               
               


                if (IsTrustedOrg == "Y")
                {
                    returnCode = new Nurse_BL(base.ContextInfo).GetActionsIsTrusterdOrg(RoleID, OP, out lstActionMaster);
                }
                else
                {
                    returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, OP, out lstVisitSearchAction);
                }
                if (lstActionMaster.Count > 0)
                {
                    lstActionsMaster = lstActionMaster.ToList();
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    //ddlVisitActionName.DataValueField = "PageURL";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();
                }
               

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load Patient CurrentDateVisit", ex);
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
        if (e.CommandName == "Admit")
        {

        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblContact = (Label)e.Row.FindControl("lblMobileNumer");
                if (lblContact.Text.StartsWith(",") || lblContact.Text.EndsWith(","))
                {
                    char[] specialChars = new char[] { ',' };
                    lblContact.Text = lblContact.Text.Trim(specialChars);
                }

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    PatientVisit pv = (PatientVisit)e.Row.DataItem;
                    string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.ID + "','" + pv.PatientName + "', '" + pv.OrgID + "');";
                    ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                    ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                    //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    //List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                    //List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                    //List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                    //List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                    //List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                    //List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                    //List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
                    //List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
                    //List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                    List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
                    //List<InvDeptMaster> deptList1 = new List<InvDeptMaster>();


                    ////new Investigation_BL(base.ContextInfo).GetInvestigationSamplesCollect(pv.PatientVisitId, OrgID, Convert.ToInt64(RoleID), out lstPatientInvestigation,
                    ////                                           out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample
                    ////                                             , out deptList1, out lstSampleContainer, out lstorderInv);

                    returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(pv.PatientVisitId, OrgID, ILocationID, out lstorderInv);

                    if (lstorderInv.Count > 0)
                    {
                        GridView grdChild = (GridView)e.Row.Cells[0].FindControl("ChildGrd");
                        grdChild.DataSource = lstorderInv;
                        grdChild.DataBind();

                        //DynamicGridColumns(grdChild);
                    }



                    Button btnAdmit = (Button)e.Row.FindControl("btnAdmit");

                    HiddenField hdnAdmissionSuggested = (HiddenField)e.Row.FindControl("hdnAdmissionSuggested");

                    if (hdnAdmissionSuggested.Value != "Y")
                    {
                        btnAdmit.Visible = false;
                    }
                }
                else
                {
                    ((LinkButton)e.Row.Cells[0].FindControl("lnkPhysicianName")).Attributes.Add("onclick", "return SortTable('grdResult','',4,this)");
                    ((LinkButton)e.Row.Cells[0].FindControl("lnkVisitDate")).Attributes.Add("onclick", "return SortTable('grdResult','',3,this)");
                    ((LinkButton)e.Row.Cells[0].FindControl("lnkUrnNo")).Attributes.Add("onclick", "return SortTable('grdResult','',2,this)");
                    ((LinkButton)e.Row.Cells[0].FindControl("lnkPatientName")).Attributes.Add("onclick", "return SortTable('grdResult','',1,this)");

                    /* List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
                     lstColumn = DynamicColumn();
                     for (int i = 0; i < e.Row.Cells.Count; i++)
                     {
                         var text = lstColumn.Where(y => y.SearchColumnName == e.Row.Cells[i].Text);
                         //string results = lstColumn.Where(s => s.SearchColumnName == e.Row.Cells[i].Text).SearchColumnName.ToString();
                         //string result = (lstColumn.First(s => s.SearchColumnName == e.Row.Cells[i].Text).SearchColumnName.ToString()!=null) ? lstColumn.First(s => s.SearchColumnName == e.Row.Cells[i].Text).SearchColumnName.ToString() : ""; 
                         //string txt= ((System.Web.UI.WebControls.TemplateField)((System.Web.UI.WebControls.DataControlFieldCell)(e.Row.Cells[i]))._containingField).HeaderText;
                         IEnumerator items = (from item in lstColumn
                                              where item.SearchColumnName == (((System.Web.UI.WebControls.DataControlFieldCell)(e.Row.Cells[i]))).ContainingField.HeaderText
                                              select item).GetEnumerator();

                         DynamicColumnMapping dcm = new DynamicColumnMapping();
                         while (items.MoveNext())
                         {
                             if (items.Current != null)
                             {
                                 dcm = (DynamicColumnMapping)items.Current;
                                 if (dcm != null)
                                 {
                                     if (dcm.Visible == "true")
                                         e.Row.Cells[i].Visible = true;
                                     else
                                         e.Row.Cells[i].Visible = false;
                                 }
                             }
                         } 
                         }Commanded By Shajahan  */

                    //string txt = (((System.Web.UI.WebControls.DataControlFieldCell)(e.Row.Cells[i]))).ContainingField.HeaderText;
                    //if (items.Count() != 0)
                    //{
                    //    string result = lstColumn.First(s => s.Visible == "true" && s.SearchColumnName == (((System.Web.UI.WebControls.DataControlFieldCell)(e.Row.Cells[i]))).ContainingField.HeaderText).Visible);
                    //    if (result == "true")
                    //        e.Row.Cells[i].Visible = true;
                    //    else
                    //        e.Row.Cells[i].Visible = false;
                    //}
                    //else
                    //{
                    //    if ((((System.Web.UI.WebControls.DataControlFieldCell)(e.Row.Cells[i]))).ContainingField.Visible != false)
                    //    {
                    //        e.Row.Cells[i].Visible = true;
                    //    }
                    //}

                } 
                
                if (lstOrganisation[0].OrganizationTypeID == 3)
                {
                    e.Row.Cells[9].Visible = false;
                }
                else
                {
                    e.Row.Cells[9].Visible = true;
                }
            }
            
        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
                if (ddlPhysician.SelectedIndex != -1)
                {
                    physicainID = Convert.ToInt64(ddlPhysician.SelectedValue);
                }
                else
                {
                    physicainID = 0;
                }
                //if ((txtname.Text != "") && (physicainID == 0))
                //{
                //    getTodaysPatientVisit(txtname.Text, 0);
                //}
                //else if ((txtname.Text == "") || (physicainID != 0))
                //{
                //    getTodaysPatientVisit("", physicainID);
                //}
                //else
                getTodaysPatientVisit(txtname.Text, physicainID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdResult_PageIndexChanging Today's Patient", ex);
        }

    }

    public void getTodaysPatientVisit(string strName, long phyLID)
    {
        try
        {
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            string ShareType = "Clinical View";
            if (IsTrustedOrg == "Y")
            {
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            }
            else
            {
                TrustedOrgDetails TOD = new TrustedOrgDetails();
                TOD.SharingOrgID = OrgID;
                lstTOD.Add(TOD);
            }

            long LocationID=-1;
            LocationID = Convert.ToInt64(ddlocation.SelectedValue.ToString());
            pvbl.GetCurrentDateVisitDetails(OrgID, lstTOD, LID, Convert.ToInt32(TaskHelper.SearchType.OP), roleName, phyLID, strName, out lstPatientVisit, out totalCount, LocationID);
            //}
            //else
            //{
            //    pvbl.GetCurrentDateVisitsByName(OrgID, lstTOD, LID, Convert.ToInt32(TaskHelper.SearchType.OP), strName, out lstPatientVisit, out lstPhysicianPV, out totalCount);
            //}

            //if ((strName == "") && (phyLID == 0))
            //    pvbl.GetCurrentDateVisitDetails(OrgID, lstTOD, LID, Convert.ToInt32(TaskHelper.SearchType.OP), out lstPatientVisit, out lstPhysicianPV, out totalCount);
            //else if ((strName == "") || (phyLID != 0))
            //{
            //    pvbl.GetCurrentDateVisitDetails(OrgID, lstTOD, phyLID, Convert.ToInt32(TaskHelper.SearchType.OP), out lstPatientVisit, out lstPhysicianPV, out totalCount);
            //}
            //else
            //    pvbl.GetCurrentDateVisitDetails(OrgID, lstTOD, LID, Convert.ToInt32(TaskHelper.SearchType.OP), strName, out lstPatientVisit, out lstPhysicianPV, out totalCount);

            if (lstPatientVisit.Count > 0)
            {
                divPrintBtn.Style.Add("display", "block");
                //ddlPhysician.SelectedIndex = 0;
                lblResult.Text = "";
                trVisitAction.Visible = true;
                grdResult.Visible = true;

                grdResult.DataSource = lstPatientVisit;
                lblNoofPatients.Text = lstPatientVisit.Count.ToString();
                grdResult.DataBind();


            }
            else
            {
                divPrintBtn.Style.Add("display", "none");
                trVisitAction.Visible = false;
                grdResult.Visible = false;
                lblResult.Text = Strnomatchingrecod;
            }

            //if (RoleName == "Physician")
            //{
            //    if (lstPhysicianPV.Count > 0)
            //    {
            //        lblResult.Text = "";
            //        trVisitAction.Visible = true;
            //        grdResult.Visible = true;
            //        grdResult.DataSource = lstPhysicianPV;
            //        lblNoofPatients.Text = lstPhysicianPV.Count.ToString();
            //        grdResult.DataBind();
                  

            //    }
            //    else
            //    {
            //        trVisitAction.Visible = false;
            //        grdResult.Visible = false;
            //        lblResult.Text = "No Matching Records Found";
            //    }
            //}
            //else if (RoleName == "Receptionist" || RoleName == "Cashier" || RoleName == "Administrator" || RoleName == "Nurse")
            //{
            //    if (phyLID != 0)
            //    {
            //        if (lstPhysicianPV.Count > 0)
            //        {
            //            lblResult.Text = "";
            //            divPrintBtn.Style.Add("display", "block");
            //            trVisitAction.Visible = true;
            //            grdResult.Visible = true;
            //            grdResult.DataSource = lstPhysicianPV;
            //            lblNoofPatients.Text = lstPhysicianPV.Count.ToString();
            //            grdResult.DataBind();
                       
            //        }
            //        else
            //        {
            //            divPrintBtn.Style.Add("display", "none");
            //            trVisitAction.Visible = false;
            //            grdResult.Visible = false;
            //            lblResult.Text = "No Matching Records Found";
            //        }
            //    }
            //    else
            //    {
            //        if (lstPatientVisit.Count > 0)
            //        {
            //            divPrintBtn.Style.Add("display", "block");
            //            ddlPhysician.SelectedIndex = 0;
            //            lblResult.Text = "";
            //            trVisitAction.Visible = true;
            //            grdResult.Visible = true;
                      
            //            grdResult.DataSource = lstPatientVisit;
            //            lblNoofPatients.Text = lstPatientVisit.Count.ToString();
            //            grdResult.DataBind();
                     

            //        }
            //        else
            //        {
            //            divPrintBtn.Style.Add("display", "none");
            //            trVisitAction.Visible = false;
            //            grdResult.Visible = false;
            //            lblResult.Text = "No Matching Records Found";
            //        }
            //    }
            //}
            //else
            //{
            //    if (lstPatientVisit.Count > 0)
            //    {
            //        lblResult.Text = "";
            //        trVisitAction.Visible = true;
            //        grdResult.Visible = true;
                  
            //        grdResult.DataSource = lstPatientVisit;
            //        lblNoofPatients.Text = lstPatientVisit.Count.ToString();
            //        grdResult.DataBind();
                 
            //    }
            //    else
            //    {
            //        lblResult.Text = "";
            //        trVisitAction.Visible = false;
            //        grdResult.Visible = false;
            //        lblResult.Text = "No Matching Records Found";
            //    }
            //}

            DynamicGridColumns(grdResult);
            for (int i = 0; i < grdResult.Rows.Count; i++)
            {
                Button btnAdmit = (Button)grdResult.Rows[i].FindControl("btnAdmit");

                HiddenField hdnAdmissionSuggested = (HiddenField)grdResult.Rows[i].FindControl("hdnAdmissionSuggested");
                if (hdnAdmissionSuggested.Value != "")
                {
                    if (hdnAdmissionSuggested.Value == "Y")
                    {
                        btnAdmit.Visible = true;
                    }
                    else
                    {
                        btnAdmit.Visible = false;
                    }
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load Grid", ex);
        }
    }
    private void DynamicGridColumns(GridView Grd)
    {
        try
        {
            if (Grd.Columns.Count != 0)
            {
                List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
                lstColumn = DynamicColumn();


                //foreach (GridViewRow Gr in Grd.he)
                //{

                //    //if (lstColumn.Exists(delegate(DynamicColumnMapping x) { return x.SearchColumnName == Gr.ColumnName; }) || Gr.ColumnName == "Select" || Gr.ColumnName == "Action")
                //    //{

                //    //}

                //}

                for (int j = 0; Grd.Columns.Count > j; j++)
                {
                    string grdHeader = Grd.Columns[j].HeaderText;
                    //string lstHeader = lstColumn[j].SearchColumnName;

                    if (grdHeader != "Select" && grdHeader != "Action")
                    {
                        //Grd.Columns[j].Visible = false;
                        bool captured = false;

                        foreach (DynamicColumnMapping item in lstColumn)
                        {

                            
                            if (grdHeader == item.SearchColumnName && item.Visible == "true")
                            {
                                
                                    Grd.Columns[j].Visible = true;
                                    captured = true;
                            }
                                else
                                {
                                    if (!captured)
                                    {
                                        Grd.Columns[j].Visible = false;
                                    }
                                }
                            
                          
                        }


                    }


                    
                }

                //for (int j = 0; Grd.Columns.Count > j; j++)
                //{
                //    string grdHeader = Grd.Columns[j].HeaderText;
                //    string lstHeader = lstColumn[j].SearchColumnName;

                //    if (lstColumn.Exists(delegate(DynamicColumnMapping x) { return x.SearchColumnName == Grd.Columns[j].HeaderText; }) || Grd.Columns[j].HeaderText == "Select" || Grd.Columns[j].HeaderText == "Action")
                //    {
                         

                //        foreach (DynamicColumnMapping item in lstColumn)
                //        {

                //            if (grdHeader == item.SearchColumnName)
                //            {
                //                if (item.Visible == "true")
                //                {
                //                    Grd.Columns[j].Visible = true;
                //                }
                //                else
                //                {
                //                    Grd.Columns[j].Visible = false;
                //                }
                //            }
                //        }
                //    }
                //    else
                //        if (Grd.Columns[j].Visible != false)
                //            Grd.Columns[j].Visible = false;
                //}
            }
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error in Load Grid", ex);
        }
    }
    public List<DynamicColumnMapping> DynamicColumn()
    {
        long retCode = -1;
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        try
        {
            int SearchType = Convert.ToInt32(TaskHelper.SearchType.TodaysVisit);
            retCode=new Patient_BL(base.ContextInfo).SearchColumns(SearchType, OrgID, out lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SearchColumns", ex);
        }
        return lstColumn;
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string pagename = string.Empty;
        List<Patient> lstPatient = new List<Patient>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<AllPhysicianSchedules> lstPhysicianSchedule = new List<AllPhysicianSchedules>();

        try
        {
            #region HardCode
            //if (hdnVisitDetail.Value != "Collect Consultation Fees")
            //{
            //    if (hdnVisitDetail.Value == "Print Bill")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=BP" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Print CaseSheet")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=CP" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Print Consolidate Report")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=CR" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Print Prescription")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=PP" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Print Print OPD Prescription")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=SPP" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Print OP Card")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=SPP" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Collect Consultation Fees")
            //        pagename = "?vid=" + hdnVID.Value + "&ftype=CON" + "&ProcID=1" + "&SPP=Y" + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Dialysis Case Sheet")
            //        pagename = "?vid=" + hdnVID.Value;
            //    else if (hdnVisitDetail.Value == "Show Report")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=CPL" + "&pid=" + hdnPID.Value;

            //    else if (hdnVisitDetail.Value == "Print Label")
            //    {
            //        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //    }
            //    else if (hdnVisitDetail.Value == "Edit/Capture Case Sheet")
            //    {
            //        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //    }
            //    else if (hdnVisitDetail.Value == "View/Print Case Sheet")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + hdnPID.Value + "','OP');", true);
            //        return;
            //    }
            //    else if (hdnVisitDetail.Value == "Order Investigation")
            //    {
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(Convert.ToInt64(hdnVID.Value), Convert.ToInt64(hdnPID.Value), out lstPatient, out lstSpeciality, out lstPhysicianSchedule);
            //        if (lstPatient.Count > 0)
            //        {
            //            if (lstPatient[0].SecuredCode != "")
            //            {
            //                pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pagetype=OI" + "&SPP=Y";
            //            }
            //            else
            //            {
            //                pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pagetype=OI";
            //            }
            //        }
            //        else
            //        {
            //            pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pagetype=OI";
            //        }
            //    }
            //    else if (hdnVisitDetail.Value == "Order Procedure")
            //    {
            //        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);
            //        long otherID = -1;
            //        for (int i = 0; i < lstProceduremaster.Count; i++)
            //        {
            //            if (lstProceduremaster[i].ProcedureDesc == "Physiotherapy")
            //            {
            //                otherID = lstProceduremaster[i].ProcedureID;
            //            }
            //        }
            //        Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&ProcID=" + otherID + "&type=d");
            //    }
            //    else if (hdnVisitDetail.Value == "Generate New Bill")
            //        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&PNAME=" + hdnPNAME.Value;
            //    else if (hdnVisitDetail.Value == "Collect Payments")
            //        pagename = "?vid=" + hdnVID.Value + "&pagetype=CPay";
            //    else if (hdnVisitDetail.Value == "Refund to Patient")
            //        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Investigation")
            //        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //    else if (hdnVisitDetail.Value == "Edit Diagnosis")
            //    {
            //        visitID = Convert.ToInt64(hdnVID.Value);
            //        pvisitID = Convert.ToInt64(hdnVID.Value);
            //        //Commented By Ramki
            //        //Session["PatientVisitID"] = visitID;
            //        //Session["PatientID"] = hdnPID.Value;
            //        List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            //        if (visitID != null)
            //        {
            //            if (visitID == pvisitID)
            //                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //            else
            //                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //        }
            //        else
            //        {
            //            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //        }
            //        if (lstPatientComplaintDetail.Count > 1)
            //        {
            //            Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
            //        }
            //        else if (lstPatientComplaintDetail.Count == 1)
            //        {
            //            if (lstPatientComplaintDetail[0].ComplaintID != 0 && lstPatientComplaintDetail[0].ComplaintID != -1)
            //            {
            //                ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            //                int specialityid, followUP;
            //                ancBL.GetANCSpecilaityID(visitID, out specialityid, out followUP);

            //                if (specialityid == Convert.ToInt32(TaskHelper.speciality.ANC))
            //                {
            //                    Response.Redirect("../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&mode=eV" + "&VDT=Y", true);
            //                }
            //                else
            //                {
            //                    Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + pvisitID + "&tid=" + "0", true);
            //                }
            //            }
            //            else
            //            {
            //                if (lstPatientComplaintDetail[0].ComplaintID == -1)
            //                {

            //                    Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&id=0" + "", true);
            //                }
            //                else
            //                {
            //                    Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&id=" + "0" + "&pvid=" + pvisitID + "&tid=" + "0", true);
            //                }
            //            }
            //        }
            //        else if (lstPatientComplaintDetail.Count == 0)
            //        {
            //            lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
            //            return;
            //        }
            //    }



            //        //newly added for Edit Diabetes


            //    ////else if (hdnVisitDetail.Value == "EditDiabetesCaseSheet")
            //    ////{
            //    ////    visitID = Convert.ToInt64(hdnVID.Value);
            //    ////    pvisitID = Convert.ToInt64(hdnVID.Value);
            //    ////    List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            //    ////    if (visitID != null)
            //    ////    {
            //    ////        if (visitID == pvisitID)
            //    ////            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    ////        else
            //    ////            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    ////    }
            //    ////    else
            //    ////    {
            //    ////        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    ////    }
            //    ////    if (lstPatientComplaintDetail.Count >= 1)
            //    ////    {
            //    ////        Response.Redirect("../Physician/DiabetesEMR.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
            //    ////    }

            //    ////}

            //        //End 



            //    else if (hdnVisitDetail.Value == "Edit BaseLine History")
            //    {
            //        visitID = Convert.ToInt64(hdnVID.Value);

            //        ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            //        int specialityid, followup;
            //        ancBL.GetANCSpecilaityID(visitID, out specialityid, out followup);

            //        if (specialityid == Convert.ToInt32(TaskHelper.speciality.ANC))
            //        {

            //            Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&mode=e" + "&VDT=Y", true);

            //        }
            //        else
            //        {
            //            hdnSex.Value = "M";
            //        }


            //        //   Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&mode=e" + "&VDT=Y", true);
            //    }
            //    else if (hdnVisitDetail.Value == "Collect Vitals")
            //    {
            //        //  Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + pagename + "?PID=" + hdnPID.Value + "&type=U", true);
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + pagename + "?PID=" + hdnPID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "Add Drugs")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "Generate Bill")
            //    {
            //        pagename = "?pid=" + hdnPID.Value;
            //    }
            //    else if (hdnVisitDetail.Value == "InvestigationReport")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "View Patient Details")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }

            //    else if (hdnVisitDetail.Value == "Add Referral / Certificate")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "Order services")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "Edit Health Package")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value, true);
            //    }
            //    else if (hdnVisitDetail.Value == "Quick Bill")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value + "&pname=" + hdnPNAME.Value + "&vType=OP", true);
            //    }
            //    else if (hdnVisitDetail.Value == "Print Workup Details")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value + "&pname=" + hdnPNAME.Value + "&vType=OP", true);
            //    }
            //    else if (hdnVisitDetail.Value == "View and Edit Workup Details")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + hdnPID.Value + "&vid=" + hdnVID.Value + "&pname=" + hdnPNAME.Value + "&vType=OP", true);
            //    }
            //    if (IsTrustedOrg == "Y")
            //    {
            //        lstOrganisation = (from lstorg in lstOrganisation
            //                           where lstorg.OrgID == OrgID
            //                           select lstorg).ToList();
            //        if (lstOrganisation[0].OrganizationTypeID == 3)
            //        {
            //            Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename, true);
            //        }
            //        else
            //        {
            //            int pcount;
            //            long pageID = Convert.ToInt64(ddlVisitActionName.SelectedValue.Split('~')[1]);
            //            returnCode = new TrustedOrg(base.ContextInfo).CheckPageAccess(pageID, OrgID, Convert.ToInt32(patOrgID.Value), out pcount);
            //            if (pcount == 0)
            //            {
            //                Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename, true);
            //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action Cannot be Performed as Patient belongs to another Organization');", true);
            //            }
            //            else
            //            {
            //                Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename, true);
            //            }
            //        }
            //    }
            //    else
            //    {
            //        if (hdnSex.Value == "M")
            //        {
            //            hdnSex.Value = "";
            //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "aadadfa", "javascript:alert('This action cannot be performed');", true);

            //        }
            //        else
            //        {
            //            Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value.Split('~')[0] + pagename, true);

            //        }

            //    }
            //}
            //else
            //{

            //    try
            //    {
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(Convert.ToInt64(hdnVID.Value), Convert.ToInt64(hdnPID.Value), out lstPatient, out lstSpeciality, out lstPhysicianSchedule);
            //        if (lstPatient.Count > 0)
            //        {
            //            if (lstPatient[0].SecuredCode != "")
            //            {
            //                pagename = "?vid=" + hdnVID.Value + "&ftype=CON" + "&ProcID=1" + "&SPP=Y" + "&pid=" + hdnPID.Value;
            //                Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + pagename, true);
            //            }
            //            else
            //            {
            //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed');", true);
            //            }
            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey22", "javascript:alert('This action cannot be performed');", true);
            //        }
            //    }
            //    catch (System.Threading.ThreadAbortException tae1)
            //    {
            //        string thread1 = tae1.ToString();
            //    }
            //    catch (Exception ex)
            //    {
            //        CLogger.LogError("Error in PatientCurrentDatevist", ex);
            //    }
            //}
            #endregion

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
             
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;

            if (ddlVisitActionName.SelectedValue == "BloodBank_BloodRequest")
            {
                Response.Redirect("../BloodBank/BloodRequestForm.aspx?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&page=" + "Visit" + "&vType=OP", true);
            }



            if (ddlVisitActionName.SelectedValue == "View_Print_Case_Sheet_IPCaseRecordSheet")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + hdnPID.Value + "','OP');", true);
                return;
            }
      

            else if (ddlVisitActionName.SelectedValue == "Edit_Diagnosis_PatientDiagnose")
            {
                visitID = Convert.ToInt64(hdnVID.Value);
                pvisitID = Convert.ToInt64(hdnVID.Value);
                //Commented By Ramki
                //Session["PatientVisitID"] = visitID;
                //Session["PatientID"] = hdnPID.Value;
                List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
                if (visitID != null)
                {
                    if (visitID == pvisitID)
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    else
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                else
                {
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                if (lstPatientComplaintDetail.Count > 1)
                {
                    Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
                }
                else if (lstPatientComplaintDetail.Count == 1)
                {
                    if (lstPatientComplaintDetail[0].ComplaintID != 0 && lstPatientComplaintDetail[0].ComplaintID != -1)
                    {
                        ANC_BL ancBL = new ANC_BL(base.ContextInfo);
                        int specialityid, followUP;
                        ancBL.GetANCSpecilaityID(visitID, out specialityid, out followUP);

                        if (specialityid == Convert.ToInt32(TaskHelper.speciality.ANC))
                        {
                            Response.Redirect("../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&mode=eV" + "&VDT=Y", true);
                        }
                        else
                        {
                            Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + pvisitID + "&tid=" + "0", true);
                        }
                    }
                    else
                    {
                        if (lstPatientComplaintDetail[0].ComplaintID == -1)
                        {

                            Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&id=0" + "", true);
                        }
                        else
                        {
                            Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&id=" + "0" + "&pvid=" + pvisitID + "&tid=" + "0", true);
                        }
                    }
                }
                else if (lstPatientComplaintDetail.Count == 0)
                {
                    lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
                    return;
                }
            }
            if (IsTrustedOrg == "Y")
            {
                lstOrganisation = (from lstorg in lstOrganisation
                                   where lstorg.OrgID == OrgID
                                   select lstorg).ToList();
                if (lstOrganisation[0].OrganizationTypeID != 3)
                {

                    int pcount;
                    returnCode = new TrustedOrg(base.ContextInfo).CheckPageAccess(ddlVisitActionName.SelectedValue, OrgID, Convert.ToInt32(patOrgID.Value), out pcount);
                    if (pcount == 0)
                    {
                        string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_3";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('"+ sPath +"');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action Cannot be Performed as Patient belongs to another Organization');", true);
                    }
                }

            }
            else
            {
                if (hdnSex.Value == "M")
                {
                    hdnSex.Value = "";
                    string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_4";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "aadadfa", "javascript:alert('"+ sPath +"');", true);

                }
            }
            if (ddlVisitActionName.SelectedValue == "Collect_Consultation_Fees_CheckPayment")
            {
                returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(Convert.ToInt64(hdnVID.Value), Convert.ToInt64(hdnPID.Value), out lstPatient, out lstSpeciality, out lstPhysicianSchedule);
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SecuredCode == "")
                    {
                        string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_4";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('"+sPath +"');", true);
                    }
                }
                else
                {
                    string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_4";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey22", "javascript:alert('"+ sPath +"');", true);
                }
            }
            if (lstActionsMaster.Exists(p => p.ActionCode == ddlVisitActionName.SelectedValue))
            {
                QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlVisitActionName.SelectedValue).QueryString;
            }
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = hdnPID.Value;
            objQueryMaster.PatientVisitID = hdnVID.Value;
      
            if (ddlVisitActionName.SelectedValue == "Order_Investigation_InvestigationProfile")
            {
                returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(Convert.ToInt64(hdnVID.Value), Convert.ToInt64(hdnPID.Value), out lstPatient, out lstSpeciality, out lstPhysicianSchedule);
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SecuredCode != "")
                    {
                        objQueryMaster.SecuredCode = "Y";
                    }
                    else
                    {
                        objQueryMaster.SecuredCode = "";
                    }
                }
            }
            else if (ddlVisitActionName.SelectedValue == "Order_Procedure_TreatmentProcedure")
            {
                List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);
                long otherID = -1;
                for (int i = 0; i < lstProceduremaster.Count; i++)
                {
                    if (lstProceduremaster[i].ProcedureDesc == "Physiotherapy")
                    {
                        otherID = lstProceduremaster[i].ProcedureID;
                    }
                }
                objQueryMaster.EmployeeNo = otherID.ToString();
            }
            objQueryMaster.PatientName = hdnPNAME.Value;
            visitID = Convert.ToInt64(hdnVID.Value);
            ANC_BL anc_BL = new ANC_BL(base.ContextInfo);
            int specialityID, followsUP;
            anc_BL.GetANCSpecilaityID(visitID, out specialityID, out followsUP);
            if (specialityID != Convert.ToInt32(TaskHelper.speciality.ANC))
            {
                hdnSex.Value = "M";
            }
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                if (ddlVisitActionName.SelectedValue == "Print_Bill_Print_Page")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintBill('" + RedirectURL + "');", true);
                }
                if (ddlVisitActionName.SelectedValue != "TRF_Upload" && ddlVisitActionName.SelectedValue != "Photo_Upload" && ddlVisitActionName.SelectedValue != "Print_Bill_Print_Page")
                {
                    Response.Redirect(RedirectURL, true);
                }
            }
            else
            {
                if (ddlVisitActionName.SelectedValue != "TRF_Upload" && ddlVisitActionName.SelectedValue != "Photo_Upload")
                {
                    string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_5";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +" ');", true);
                }
            }
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hdnVID.Value = "";
        hdnPID.Value = "";
        hdnPNAME.Value = "";
        hdnVisitDetail.Value = "";
        OP = Convert.ToInt32(TaskHelper.SearchType.TodaysVisit);
        getTodaysPatientVisit(txtname.Text.Trim(), 0);
    }
    protected void ddlPhysician_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            hdnVID.Value = "";
            hdnPID.Value = "";
            hdnPNAME.Value = "";
            hdnVisitDetail.Value = "";
            txtname.Text = string.Empty;
            if (ddlPhysician.SelectedIndex != 0)
            {
                physicainID = Convert.ToInt64(ddlPhysician.SelectedValue);
                getTodaysPatientVisit("", physicainID);
            }
            else
            {
                getTodaysPatientVisit("", 0);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ddlPhysician_SelectedIndexChanged", ex);
        }
    }


    protected void btnAdmit_Click(object sender, EventArgs e)
    {

        Button objAdmitButton = (Button)sender;
        long VisitID = Convert.ToInt64(objAdmitButton.CommandArgument.ToString());
        //foreach (GridViewRow grdRow in grdResult.Rows)
        //{
        //    patientID = Convert.ToInt64(grdResult.DataKeys[grdRow.RowIndex].Values["PatientID"]);            
        //}
        ipBL.GetIPVisitDetails(VisitID, out lstPatientVisit);

        if (lstPatientVisit.Count > 0)
        {
            patientID = lstPatientVisit[0].PatientID;
        }

        if (VisitID > 0 && patientID > 0)
        {

            PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit pVisit = new PatientVisit();



            long phyID = -1;
            int otherID = -1;
            long referOrgID = -1;
            string feeType = String.Empty;
            string otherName = String.Empty;
            string physicianName = String.Empty;
            string referrerName = string.Empty;

            //int ClientID = 0;
            int CorporateID = 0;



            pVisit.VisitPurposeID = 9;
            pVisit.PhysicianID = (int)phyID;
            pVisit.OrgID = OrgID;
            pVisit.PatientID = patientID;
            pVisit.OrgAddressID = ILocationID;
            pVisit.SpecialityID = otherID;
            pVisit.ReferOrgID = referOrgID;
           
            pVisit.CreatedBy = LID;
            
            pVisit.VisitType = 1;
            pVisit.PhysicianName = "";
            pVisit.SecuredCode = "";
            pVisit.ParentVisitId = VisitID;

            visitID = -1;
            long enteredPatientID = patientID;
            int iTokenNo = 0;
            long lScheduleNo = 0;
            long lResourceTemplateNo = 0;
            string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
            DateTime dtFromTime = new DateTime();
            DateTime dtToTime = new DateTime();
            dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            int iRetTokenNumber = 0;
            string needIPNo = string.Empty;
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                needIPNo = lstConfig[0].ConfigValue.Trim();
            List<VisitClientMapping> lst = IPClientTpaInsurance1.GetClientValues(); ;
            returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID,
                                            iTokenNo, lScheduleNo, lResourceTemplateNo,
                                            sPassedTime, out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);
            if (visitID > 0)
            {
                Response.Redirect(@"~\Reception\InPatientRegistration.aspx?pid=" + patientID + "&vid=" + visitID, true);
            }
        }


    }

    private void AddSearchColumns()
    {
        Hashtable searchColumns = new Hashtable();
        DataTable dt = new DataTable();
        DataColumn dcName = new DataColumn("columnname");
        DataColumn dcValue = new DataColumn("columnvalue");
        dt.Columns.Add(dcName);
        dt.Columns.Add(dcValue);
        DataRow dr;
        searchColumns.Add("URNO", "URNO~7"); searchColumns.Add("Refering Physician", "Ref Physician~3");
        searchColumns.Add("Physician Name", "Physician Name~9"); searchColumns.Add("Visit Time", "Visit Time~8");
        searchColumns.Add("Visit Purpose", "Visit Purpose~6"); searchColumns.Add("Patient Name", "Patient Name~1");
        searchColumns.Add("Age", "Age~15"); searchColumns.Add("Patient Number", "Patient Number~18");
        searchColumns.Add("Address", "Address~17"); searchColumns.Add("Contact No", "Contact No~16");
        searchColumns.Add("Status", "Status~14"); searchColumns.Add("WardNo", "WardNo~19");
        searchColumns.Add("Investigation Details","Investigationdetails~10");
        searchColumns.Add("VisitID", "VisitID~20");
        searchColumns.Add("Location", "Location~22");
        searchColumns.Add("VisitNumber", "VisitNumber~23");
        foreach (DictionaryEntry dictE in searchColumns)
        {
            dr = dt.NewRow();
            dr["columnname"] = dictE.Key.ToString();
            dr["columnvalue"] = dictE.Value.ToString();
            dt.Rows.Add(dr);
        }
        ChkLstColumns.DataSource = dt;
        ChkLstColumns.DataTextField = "columnname";
        ChkLstColumns.DataValueField = "columnvalue";
        ChkLstColumns.DataBind();
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        lstColumn = DynamicColumn();
        foreach (DynamicColumnMapping item in lstColumn)
        {
            for (int i = 0; i < ChkLstColumns.Items.Count; i++)
            {
                string chkValueRaw = ChkLstColumns.Items[i].Value.ToString();
                string[] chkValue = chkValueRaw.Split('~');

                if (chkValue[0] == item.SearchColumnName && item.Visible == "true")
                {
                    ChkLstColumns.Items[i].Selected = true;
                }
            }
        }
    }


    protected void btnUpdateFilter_Click(object sender, EventArgs e)
    {
         try
        {

        CollapsiblePanelExtender1.Collapsed = true;
        CollapsiblePanelExtender1.ClientState = "true";
        ArrayList arrayCheckedItem = new ArrayList();

        foreach (ListItem chkitem in ChkLstColumns.Items)
        {
            if (chkitem.Selected == true)
            {
                string chkValueRaw = chkitem.Value.ToString();
                string[] chkValue = chkValueRaw.Split('~');
                arrayCheckedItem.Add(chkValue[0]);
            }
        }
        for (int j = 0; grdResult.Columns.Count > j; j++)
        {
            if (grdResult.Columns[j].HeaderText != "Select" && grdResult.Columns[j].HeaderText != "Action")
            {
                if (arrayCheckedItem.Contains(grdResult.Columns[j].HeaderText))
                {
                    grdResult.Columns[j].Visible = true;
                }
                else
                {
                    grdResult.Columns[j].Visible = false;
                }
            }
        }

        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        lstColumn.Clear();

        foreach (ListItem chkitem in ChkLstColumns.Items)
        {
            if (chkitem.Selected == true)
            {
                string chkValueRaw = chkitem.Value.ToString();
                string[] chkValue = chkValueRaw.Split('~');
                DynamicColumnMapping lstitem = new DynamicColumnMapping();
                lstitem.SearchTypeID = 19;
                lstitem.SearchColumnID =Convert.ToInt32(chkValue[1]);
                lstitem.OrgID = OrgID;
                lstitem.Deleted = "N";
                lstitem.Visible = "true";
                lstColumn.Add(lstitem);
            }

            if (chkitem.Selected == false)
            {
                string chkValueRaw = chkitem.Value.ToString();
                string[] chkValue = chkValueRaw.Split('~');
                DynamicColumnMapping lstitem = new DynamicColumnMapping();
                lstitem.SearchTypeID = 19;
                lstitem.SearchColumnID = Convert.ToInt32(chkValue[1]);
                lstitem.OrgID = OrgID;
                lstitem.Deleted = "N";
                lstitem.Visible = "false";
                lstColumn.Add(lstitem);
            }
        }
        returnCode = new PatientVisit_BL(base.ContextInfo).SaveDynamicColumnMapping(lstColumn);
        }
         catch (Exception ex)
         {
             CLogger.LogError("Error in DynamicColumnMapping", ex);
         }



    }
    protected void TRFImageUpload_Click(object sender, FileCollectionEventArgs e)
    {
        Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
        string VisitID = string.Empty;
        String VisitNumber = String.Empty;

        string PID = hdnPID.Value;
        string VID = hdnVID.Value;
        long returncode = -1;
        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(PID), out VisitID, out VisitNumber);
        DateTime dt = new DateTime();
        dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        int Year = dt.Year;
        int Month = dt.Month;
        int Day = dt.Day;

        //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf

        String Root = String.Empty;
        String RootPath = String.Empty;
        //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
        Root = "UnKnown-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
        Root = Root.Replace("-", "\\\\");
        RootPath = pathname + Root;
        //ENd///

        HttpFileCollection oHttpFileCollection = e.PostedFiles;
        HttpPostedFile oHttpPostedFile = null;
        if (e.HasFiles)
        {
            for (int n = 0; n < e.Count; n++)
            {
                oHttpPostedFile = oHttpFileCollection[n];
                if (oHttpPostedFile.ContentLength <= 0)
                    continue;
                else
                {
                    // oHttpPostedFile.SaveAs(pathname + System.IO.Path.GetFileName(oHttpPostedFile.FileName));


                    string imagePath = pathname;

                    if (!String.IsNullOrEmpty(imagePath) && imagePath.Length > 0)
                    {

                        string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                        string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                        string picNameWithoutExt = PID + '_' + VID + '_' + +OrgID;
                        string pictureName = PID + '_' + VID + '_' + OrgID + '_' + Picture;
                        string NotImageFormat = PID + '_' + VID + '_' + OrgID + '_' + FullName;
                        string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                        string filePath = imagePath + NotImageFormat;
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        Response.OutputStream.Flush();

                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = pictureName + ".jpg";
                            filePath = imagePath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(oHttpPostedFile.InputStream);
                            int srcWidth = image.Width;
                            int srcHeight = image.Height;
                            if (thumbWidth > srcWidth)
                                thumbWidth = srcWidth;
                            if (thumbHeight > srcHeight)
                                thumbHeight = srcHeight;
                            Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                            System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                            System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                            gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            int pno = int.Parse(PID.ToString());
                            int Vid = int.Parse(VID.ToString());
                            returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "UnKnown",Root,LID,dt,"Y",0);
                        }
                        else
                        {
                            oHttpPostedFile.SaveAs(filePath);
                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            int pno = int.Parse(PID.ToString());
                            int Vid = int.Parse(VID.ToString());
                            returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, "UnKnown", Root, LID, dt,"Y",0);

                        }

                        if (returncode == -1)
                        {
                            string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_6";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('"+ sPath + "');", true);
                            divUpload.Style.Add("Display", "none");
                        }
                    }
                    else
                    {
                        string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_7";
                          ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('"+ sPath +"');", true);
                    }
                }

            }
        }
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    public void LoadLocation()
    {
        string strall = Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_01 == null ? "--All--" : Resources.Patient_ClientDisplay.Patient_PatientCurrDateVist_aspx_01;
        long returnCode = -1;
        List<OrganizationAddress> lAllLocation = new List<OrganizationAddress>();
        List<OrganizationAddress> lCurrentOrgLocation = new List<OrganizationAddress>();
        returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAllLocation);
        lCurrentOrgLocation = lAllLocation.FindAll(p => p.OrgID == OrgID);

        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string ShareType = "Clinical View";
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
             ddlocation.DataSource = lAllLocation;
        }
        else
        {
            ddlocation.DataSource = lCurrentOrgLocation;
        }
        ddlocation.DataTextField = "City";
        ddlocation.DataValueField = "AddressID";
        //ddlocation.SelectedValue = ILocationID.ToString();
        ddlocation.DataBind();
        ddlocation.Items.Insert(0, strall.Trim());
        ddlocation.Items[0].Value = "-1";
    }
 
}
