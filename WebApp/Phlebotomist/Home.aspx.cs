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
using System.Linq;

public partial class Phlebotomist_Home : BasePage
{
    public Phlebotomist_Home()
        : base("Phlebotomist_Home_aspx")
    {
    }

    int currentPageNo = 1;

    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    static bool PatientSearch = false;
    long returncode = -1;
    string Visitnumber = string.Empty;
    string Patnumber = string.Empty;
    string InvID = string.Empty;
    string Type = string.Empty;
    long deptID = -1;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string IsTimed = string.Empty;
    long ProtocalGroupId =-1;
    string allocatedtasks = string.Empty;
    string IsNeedNewApproval = string.Empty;
    string IsHospitalLab = string.Empty;

    # region Commented because Abberant Queue Control Created
    //private void LoadSample(string DateType)
    //{
    //    try
    //    {
    //        string FDate = string.Empty;
    //        string Tdate = string.Empty;
    //        if (DateType == "0")
    //        {
    //            FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "1")
    //        {
    //            FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "2")
    //        {
    //            FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "3")
    //        {
    //            FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }

    //        List<CollectedSample> lstInvestigationSamples1 = new List<CollectedSample>();
    //        List<CollectedSample> lstInvestigationSamples2 = new List<CollectedSample>();
    //        List<InvestigationQueue> lstRetestInvestigationQueue = new List<InvestigationQueue>();
    //        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);


    //        invbl.GetQuickInvSamplesStatus(OrgID, FDate, Tdate, 0, ILocationID, out lstInvestigationSamples1, out lstInvestigationSamples2, out lstRetestInvestigationQueue);
    //        // if (lstInvestigationSamples1.Count > 0)
    //        // {         

    //        gvInvSamplesStatus.DataSource = lstInvestigationSamples1;
    //        gvInvSamplesStatus.DataBind();

    //        //}

    //        //if (lstInvestigationSamples2.Count > 0)
    //        // {
    //        gvInvSamplesStatus2.DataSource = lstInvestigationSamples2;
    //        gvInvSamplesStatus2.DataBind();
    //        //}

    //        #region SampleStatus Highlight Color
    //        string CurrentLocationStatus = string.Empty;
    //        string OtherLocationStatus = string.Empty;
    //        if (lstInvestigationSamples1.Count > 0)
    //        {
    //            foreach (CollectedSample lst in lstInvestigationSamples1)
    //            {
    //                CurrentLocationStatus = lst.InvSampleStatusDesc + '~' + CurrentLocationStatus;
    //            }
    //        }
    //        if (lstInvestigationSamples2.Count > 0)
    //        {
    //            foreach (CollectedSample lst1 in lstInvestigationSamples2)
    //            {
    //                OtherLocationStatus = lst1.InvSampleStatusDesc + '~' + OtherLocationStatus;
    //            }
    //        }
    //        hdnCurrentLocationStatus.Value = "";
    //        hdnOtherLocationStatus.Value = "";
    //        hdnCurrentLocationStatus.Value = CurrentLocationStatus;
    //        hdnOtherLocationStatus.Value = OtherLocationStatus;
    //        #endregion

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading sample", ex);
    //    }
    //}
    //protected void gvInvSamplesStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        e.Row.Cells[0].Text = OrgName + " - " + LocationName;
    //    }
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //DropDownList ddldept = (DropDownList)e.Row.FindControl("ddlDept");

    //        //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FAAC58'");
    //        // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#F5D0A9'");
    //        if (hdnCurrentLocationStatus.Value != "0")
    //        {
    //            CollectedSample date = (CollectedSample)e.Row.DataItem;
    //            foreach (string Status in hdnCurrentLocationStatus.Value.Split('~'))
    //            {
    //                string[] PStatus = Status.Split('-');
    //                if (PStatus[0] != "")
    //                {
    //                    string[] CStatus = date.InvSampleStatusDesc.Split('-');
    //                    if (PStatus[1].Trim() == CStatus[1].Trim())
    //                    {
    //                        if (PStatus[0].Trim() != CStatus[0].Trim())
    //                        {
    //                            e.Row.BackColor = System.Drawing.Color.Orange;
    //                            //e.Row.ForeColor  = System.Drawing.Color.LimeGreen;
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }

    //    if (e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        e.Row.Cells[0].Text = "Aberrant Sample Queue: " + OrgName + " - " + LocationName;
    //    }

    //}
    //protected void gvInvSamplesStatus2_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        e.Row.Cells[0].Text = "Other Location";
    //    }
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //e.Row.Attributes.Add("onclick", "this.style.backgroundColor='Orange'");
    //        //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FAAC58'");
    //        //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#F5D0A9'");

    //        if (hdnOtherLocationStatus.Value != "0")
    //        {
    //            CollectedSample date = (CollectedSample)e.Row.DataItem;
    //            foreach (string Status in hdnOtherLocationStatus.Value.Split('~'))
    //            {
    //                string[] PStatus = Status.Split('-');
    //                if (PStatus[0] != "")
    //                {
    //                    string[] CStatus = date.InvSampleStatusDesc.Split('-');
    //                    if (PStatus[1].Trim() == CStatus[1].Trim())
    //                    {
    //                        if (PStatus[0].Trim() != CStatus[0].Trim())
    //                        {
    //                            e.Row.BackColor = System.Drawing.Color.Orange;
    //                            //e.Row.Cells[0].ForeColor = System.Drawing.Color.LimeGreen;
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    if (e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        e.Row.Cells[0].Text = "Aberrant Sample Queue: Other Location";
    //    }
    //}
    //protected void ddlInvSamplesStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string InvSamplesStatusDate = string.Empty;
    //    InvSamplesStatusDate = ddlInvSamplesStatus.SelectedValue;
    //    LoadSample(InvSamplesStatusDate);
    //}
    # endregion

    #region "Initial"
    string strLabNo = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_01 == null ? "Lab Number" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_01;
    string strVisitNo = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_02 == null ? "Visit Number" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_02;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    protected void Page_Load(object sender, EventArgs e)
    {
        //LoadMeatData();
        //Added  By Arivalagan.kk//
        String NeedAberrantQ = GetConfigValue("NeedAberrantQ", OrgID);
        //End Added  By Arivalagan.kk//
        if ((Request.QueryString["TkCnt"] != null) && (Request.QueryString["TkCnt"] != ""))
        {
            currentPageNo = Convert.ToInt32(Request.QueryString["TkCnt"].ToString());
        }
        iframeBarcode.Attributes.Remove("src");
        if (!IsPostBack)
        {
            string IsSampleBarcodePrinted = Session["IsSampleBarcodePrinted"] == null ? string.Empty : (string)Session["IsSampleBarcodePrinted"];
            if (IsSampleBarcodePrinted != "true" && !String.IsNullOrEmpty(Request.QueryString["gUID"]) && !String.IsNullOrEmpty(Request.QueryString["vid"]) && !String.IsNullOrEmpty(Request.QueryString["sampleId"]) && !String.IsNullOrEmpty(Request.QueryString["categoryCode"]))
            {
                if (GetConfigValue("IsHistoPrintEnable",OrgID) == "Y")
                {
                    if (Session["AttuneHisto"] != null && Convert.ToString(Session["AttuneHisto"]) != string.Empty)
                    {
                        string barcode = Convert.ToString(Session["AttuneHisto"]);
                        Session.Remove("AttuneHisto");
                        iframeBarcode.Attributes["src"] = "AttuneHisto:" + barcode;
                    }
                }
                else
                {
                if (Session["BarcodeDetails"] != null && Convert.ToString(Session["BarcodeDetails"]) != string.Empty)
                {
                    string barcode = Convert.ToString(Session["BarcodeDetails"]);
                    Session.Remove("BarcodeDetails");
                    iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                }
                if (Session["HistoBarcodeDetails"] != null && Convert.ToString(Session["HistoBarcodeDetails"]) != string.Empty)
                {
                    string barcode = Convert.ToString(Session["HistoBarcodeDetails"]);
                    Session.Remove("HistoBarcodeDetails");
                    iframeBarcode.Attributes["src"] = "HistoBarcodeDetails:" + barcode;
                }
                }
                string Guid = string.Empty;
                long visitId = -1;
                string categoryCode = string.Empty;
                string lstSampleId = string.Empty;
                Guid = Convert.ToString(Request.QueryString["gUID"]);
                lstSampleId = Convert.ToString(Request.QueryString["sampleId"]);
                Int64.TryParse(Request.QueryString["vid"], out visitId);
                categoryCode = Convert.ToString(Request.QueryString["categoryCode"]);
                //ScriptManager.RegisterStartupScript(this, GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + visitId + "&sampleId=" + lstSampleId + "&guId=" + Guid + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                Session["IsSampleBarcodePrinted"] = "true";
                if (Request.QueryString["INVSRS"] == "Y" && Request.QueryString["INVSRS"] !=null)
                {
                    string sPage = "../Reception/PrintPage.aspx?pid=" + "0"
                                         + "&vid=" + visitId.ToString()
                                         + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y" + "&sampleId=" + lstSampleId;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "Window", "window.open('" + sPage + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint('" + sPage + "');", true);
                }

            }
            if (RoleName == RoleHelper.Phlebotomist || RoleName == RoleHelper.Accession)
            {
                //Added  By Arivalagan.kk//
                if (NeedAberrantQ == "Y")
                {
                    tdAberrant.Style.Add("display", "none");
                }
                else { tdAberrant.Style.Add("display", "table-cell"); }
                //End Added  By Arivalagan.kk//
                // LoadSample("1");
            }
            if (CID > 0)
            {
                tdAberrant.Style.Add("display", "table-row");
            }
            else if (RoleName == RoleHelper.Doctor || RoleName == RoleHelper.JuniorDoctor || RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SeniorDoctor) //
            {
                //tdAberrant.Style.Add("display", "table-row");
                if (NeedAberrantQ == "Y")
                {
                    tdAberrant.Style.Add("display", "none");
                }
                else { tdAberrant.Style.Add("display", "table-cell"); }
                dCapture.Visible = true;
                LoadLocation();
                Loadprotocalgroup();
                if (InventoryLocationID == -1)
                {
                    Department1.LoadLocationUserMap();
                }
                txtDeptNameExtender.ContextKey = OrgID.ToString();
                AutoCompleteExtender1.ContextKey = OrgID.ToString();
                AutoCompleteProduct.ContextKey = "NameOnly";
                AutoCompleteExtenderRefPhy.ContextKey = OrgID.ToString();
                ACEClientName.ContextKey = "0^0";


                txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
                txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
                DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime wkStDt = DateTime.MinValue;
                DateTime wkEndDt = DateTime.MinValue;
                wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
                wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
                hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
                hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");



                DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
                hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
                dateNow = dateNow.AddMonths(1);
                hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day



                hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

                #region lastmonth
                DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
                hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
                dtlm = dtlm.AddMonths(1);
                hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
                #endregion

                #region lastweek
                DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime LwkStDt = DateTime.MinValue;
                DateTime LwkEndDt = DateTime.MinValue;
                hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
                hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

                #endregion

                #region lastYear
                DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                string tempyear = dt2.AddYears(-1).ToString();
                string[] tyear = new string[5];
                tyear = tempyear.Split('/', '-');
                tyear = tyear[2].Split(' ');
                hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
                hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
                #endregion
                if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
                {
                    txtFromDate.Text = hdnTempFrom.Value;
                    txtToDate.Text = hdnTempTo.Value;
                    txtFromDate.Attributes.Add("disabled", "true");
                    txtToDate.Attributes.Add("disabled", "true");
                    divRegDate.Attributes.Add("display", "block");
                }
            }

            GetLocationAndSpeciality();
            if (RoleDescription == "Sr.Doctor" || RoleDescription == "Jr.Doctor")
            {
                td_lblprotocalgroup.Attributes.Add("style", "display:none");
                td_drpProtocal.Attributes.Add("style", "display:none");
            }
            LoadMeatData();
        }
        ImgTick.Visible = false;
        IsTimed = "N";
       
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = strLabNo.Trim();
            txtvisitno.MaxLength = 9;
        }
        else
        {
            defaultText = strVisitNo.Trim();
        }
        txtwatermark();
        loadGridSearch(currentPageNo, PageSize);

    }
    #endregion

    #region "Events"
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Tasks_BL taskBL = new Tasks_BL();
            long retval = -1;
            TaskProfile taskprofile = new TaskProfile();
            taskprofile.LoginID = LID;
            taskprofile.RoleID = RoleID;
            taskprofile.OrgID = OrgID;
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.Type = "Authorization";
            if (ddlprotocalgroup.SelectedValue != "0")
            {
                taskprofile.ProtocalGroupId = Int64.Parse(ddlprotocalgroup.SelectedValue.ToString());
            }
            else
            {
                taskprofile.ProtocalGroupId = 0;
            }
            retval = taskBL.InsertDefault(taskprofile);
        
            IsTimed = "N";
            hdnCurrent.Value = "1";
            loadGridSearch(currentPageNo, PageSize);
            divGridView.Attributes.Add("style", "display:block");
            ImgTick.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while searching", ex);
        }
    }
    protected void btnTimed_Click(object sender, EventArgs e)
    {
        try
        {
            IsTimed = "Y";
            hdnCurrent.Value = "1";
            loadGridSearch(1, PageSize);
            divGridView.Attributes.Add("style", "display:block");
            ImgTick.Visible = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while searching", ex);
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string UID = string.Empty;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            EnterResult PVD = (EnterResult)e.Row.DataItem;
            HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
            //string URLStatus = GridView1.DataKeys[e.Row.RowIndex].Values[5].ToString();
            string labb = e.Row.Cells[2].Text;
            if (labb == "0")
            {
                e.Row.Cells[2].Text = "--";
            }
            IsNeedNewApproval = GetConfigValue("NeedNewApproval", OrgID);
            if (IsNeedNewApproval == "Y")
            {
                //ctr.Style.Value.Replace("~/Investigation/InvestigationApprovel.aspx", "~/Investigation/InvApproval.aspx");
                // ctr.HRef.Replace("~/Investigation/InvestigationApprovel.aspx", "~/Investigation/InvApproval.aspx");
                ctr.HRef = "~/Investigation/InvApproval.aspx?DeptId=" + PVD.DeptID + "&tid=0&pid=" + PVD.PatientID + "&vid=" + PVD.PatientVisitId + "&gUID=" + PVD.UID + "&RNo=" + PVD.Labno;
            }
            #region Commented By sami

            //if (URLStatus == "N")
            //// if (ddlDept.Items.FindByValue("7") != null)   // 7 - Histology Department
            //{
            //    HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
            //    ctr.HRef = "~/Investigation/InvApproval.aspx?DeptId=" + PVD.DeptID + "&tid=0&pid=" + PVD.PatientID + "&vid=" + PVD.PatientVisitId + "&gUID=" + PVD.UID + "&RNo=" + PVD.Labno;
            //}         
            ////List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            ////List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            ////List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            ////List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            ////List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            ////List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            ////List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            ////List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
            ////List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            ////List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();

            //if (PVD.UID != null)
            //{
            //    UID = PVD.UID;
            //}
            //invBL.GetInvestigationSamplesCollect(PVD.PatientVisitId, OrgID, RoleID, UID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

            //if (lstPatientInvestigation.Count > 0)
            //{
            //    string strtemp = GetToolTip(lstPatientInvestigation);
            //    e.Row.Cells[0].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
            //    e.Row.Cells[0].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
            //    e.Row.Cells[0].Style.Add("color", "Blue");            //}

            #endregion
            //HtmlAnchor ctr1 = (HtmlAnchor)e.Row.FindControl("lnklist");
            //ctr1.Attributes.Add("onmouseover", "javascript:ShowStatus('" + PVD.PatientVisitId.ToString() + "');");
            //ctr1.Attributes.Add("onmouseout", "HideStatus()");
            if (PVD.PatientVisitType == Attune.Podium.Common.VisitType.InPatient)
            {
                e.Row.ForeColor = System.Drawing.Color.Brown;

                ctr.Style.Add("color", "Brown");
            }
            if ((PVD.Status == "Reject") || (PVD.Status == "Outsource"))
            {
                e.Row.ForeColor = System.Drawing.Color.Blue;
                //HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
                ctr.Style.Add("color", "blue");
                //e.Row.Style["text-decoration"] = "none";
                //e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Red';");
                //e.Row.Attributes.Add("onmouseout", "this.style.color='Black';");

            }
            //PatientVisitDetails PVD = (PatientVisitDetails)e.Row.DataItem;
            List<OrderedInvestigations> lstPatientInvestigation = new List<OrderedInvestigations>();
            //UID = PVD.UID;
            //if (PVD.Labno == "")
            //{
            //    PVD.Labno = "0";
            //}
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;

            invBL.GetInvestigationshowincollecttasks(PVD.PatientVisitId, OrgID, ILocationID, PVD.Labno, objLoginDetail, out lstPatientInvestigation);
            if (lstPatientInvestigation.Count > 0)
            {
                string strtemp = GetToolTip(lstPatientInvestigation);
                e.Row.Cells[0].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                e.Row.Cells[0].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                e.Row.Cells[0].Style.Add("color", "Blue");
            }
            if (PVD.State == "Y")
            {
                
                e.Row.CssClass="mistyrose";
                //e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("enterresultstatcolor");
            }
            if (PVD.NextReviewDate != null)
            {
                string[] AgeValues;
                string Ageval = string.Empty;
                if (PVD.NextReviewDate != null)
                {
                    AgeValues = PVD.NextReviewDate.Split('.');

                    if (AgeValues != null && AgeValues.Length >= 2 && AgeValues[0] != "0" && AgeValues[1] != "0")
                    {
                        Ageval = (AgeValues[0] + "." + AgeValues[1] + "Year(s)").ToString();
                        e.Row.Cells[1].Text = Ageval;
                    }

                }
            }
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        //if (hdnCurrent.Value != "")
        //{
        //    currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientName.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}

        //else
        //{
        //    currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
        //    hdnCurrent.Value = currentPageNo.ToString();

        //    if (PatientSearch == true && txtPatientName.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}

        if (txtPatientName.Text != hdnPatientName.Value)
        {
            hdnCurrent.Value = "";
            //lblCurrent.Text = "2";
        }

        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }

        loadGridSearch(currentPageNo, PageSize);

        hdnPatientName.Value = txtPatientName.Text.ToString();

    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {

        //if (hdnCurrent.Value != "")
        //{
        //    currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientName.Text != "")
        //    { 
        //        PerformPatientSearch(currentPageNo, PageSize); 
        //    }
        //    else 
        //    { 
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}
        //else
        //{
        //    currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientName.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }
        //}

        if (hdnCurrent.Value != "")
        {

            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }

        if (PatientSearch == true)
        {
            if (txtPatientName.Text != hdnPatientName.Value)
            {
                hdnCurrent.Value = "";
                lblCurrent.Text = "0";
            }
        }


        loadGridSearch(currentPageNo, PageSize);


        hdnPatientName.Value = txtPatientName.Text.ToString();

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {


        //  hdnCurrent.Value = txtpageNo.Text;
        //  int ar = Convert.ToInt32 (txtpageNo.Text);

        //  if (ar != 0)
        //  {
        //      loadGrid(Convert.ToInt32(txtpageNo.Text), PageSize);
        //  }
        //  if (PatientSearch == true && txtPatientName.Text != "")
        //      if (PatientSearch == true)
        //      {
        //          PerformPatientSearch(Convert.ToInt32(txtpageNo.Text), PageSize);
        //      }

        //txtpageNo.Text = "";

        hdnCurrent.Value = txtpageNo.Text;
        int ar = Convert.ToInt32(txtpageNo.Text);




        loadGridSearch(Convert.ToInt32(txtpageNo.Text), PageSize);

        txtpageNo.Text = "";


    }
    #endregion

    #region "Methods"
    public long loadGridSearch(int currentPageNo, int PageSize)
    {
	
        hdnTaskCount.Value = Convert.ToString(currentPageNo);
        hdnOrgID.Value = Convert.ToString(OrgID); 
        LoginDetail objLoginDetail = new LoginDetail();
        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
        List<EnterResult> lstDetails = new List<EnterResult>();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        Visitnumber = string.Empty;
        if (txtvisitno.Text != "" && txtvisitno.Text.Trim() != defaultText.Trim())
        {
            Visitnumber = txtvisitno.Text;
        }
        if (txtpatno.Text != "")
        {
            Patnumber = txtpatno.Text;
        }
        if (txtinvname.Text != "")
        {
            string invid1 = txtinvname.Text.Split(':')[0];
            InvID = invid1;
        }
        if (txtDeptName.Text != "")
        {
            deptID = Convert.ToInt64(hdnDeptID.Value);
        }
        if (hdnTestType.Value != "")
        {
            Type = hdnTestType.Value;
        }
        long PatientId = 0;
        string patientName = string.Empty;
        if (txtPatientName.Text != "")
        {
            patientName = txtPatientName.Text;
        }
        long clientId = -1;
        if (txtClientName.Text != "")
        {
            Int64.TryParse(hdnClientID.Value, out clientId);
        }
        if (ddlRegisterDate.SelectedValue == "4")
        {
            txtFromDate.Text = OrgTimeZone;
            txtToDate.Text = OrgTimeZone;
        }
        else if (ddlRegisterDate.SelectedValue == "3")
        {
            txtFromDate.Text = txtFromPeriod.Text;
            txtToDate.Text = txtToPeriod.Text;
        }
        int pRefPhyID = 0;
        if (txtReferringPhysician.Text != "")
        {
            Int32.TryParse(hdnPhysicianID.Value, out pRefPhyID);
        }
        long pLocationID = 0;
        if (ddlocation.SelectedIndex > 0)
        {
            Int64.TryParse(ddlocation.SelectedValue, out pLocationID);
        }
        if (ddlprotocalgroup.SelectedIndex > 0)
        {
            Int64.TryParse(ddlprotocalgroup.SelectedValue, out ProtocalGroupId);
        }


        callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, patientName, out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                                                 clientId, string.Empty, "-1", InvID,
                                                 txtFromDate.Text, txtToDate.Text, 0, Visitnumber, Patnumber, Type, deptID, "SelectiveAuthorization", pRefPhyID, pLocationID, objLoginDetail, IsTimed, ProtocalGroupId,"", allocatedtasks,"");
        if (lstDetails.Count > 0)
        {
            totalpage = totalRows;
            hdntotrows.Value = totalRows.ToString();
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (IsTimed == "Y")
            {
                lblTimedcount.Text = "(" + totalRows.ToString() + ")";
                divGridView.Attributes.Add("style", "display:block");
                trPagination.Visible = true;
            }
            else
            {
                divGridView.Attributes.Add("style", "display:block");
                trPagination.Visible = true;

                //divGridView.Attributes.Add("style", "display:none");
                //trPagination.Visible = false;
            }
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentPageNo == 1)
            {
                Btn_Previous.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
            foreach (EnterResult lst in lstDetails)
            {
                string str = lst.Age;
                string[] strage = str.Split(' ');
                if (strage.Length > 1)
                {
                    if (strage[1] == "Year(s)")
                    {
                        lst.Age = strage[0] + " " + strYear;
                    }
                    else if (strage[1] == "Month(s)")
                    {
                        lst.Age = strage[0] + " " + strMonth;
                    }
                    else if (strage[1] == "Day(s)")
                    {
                        lst.Age = strage[0] + " " + strDay;
                    }
                    else if (strage[1] == "Week(s)")
                    {
                        lst.Age = strage[0] + " " + strWeek;
                    }
                    else if (strage[1] == "UnKnown")
                    {
                        lst.Age = strage[0] + " " + strUnknownF;
                    }
                    else
                    {
                        lst.Age = strage[0] + " " + strYear;
                    }
                }
                else { lst.Age = strage[0] + " " + strYear; }
            }
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
            divFooterNav.Visible = true;
            if (lstDetails.Count > 0)
            {
                if (IsPostBack)
                {
                    trPagination.Visible = true;
                }
            }
            else
            {
                trPagination.Visible = false;
            }
        }
        else
        {
            string gridmsg = Resources.ClientSideDisplayTexts.Lab_Home_aspx_cs_gridmsg;
            GridView1.DataSource = null;
            GridView1.EmptyDataText = gridmsg;
            GridView1.DataBind();
            divFooterNav.Visible = false;
            trPagination.Visible = false;
            //txtPatientName.Focus();
        }
        return totalRows;
        txtvisitno.Text = string.Empty;
        txtpatno.Text = string.Empty;
        hdnTmedtask.Value = string.Empty;
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    public void txtwatermark()
    {

        if (txtvisitno.Text.Trim() != defaultText.Trim())
        {
            txtvisitno.Attributes.Add("style", "color:black");
        }
        if (txtvisitno.Text == "")
        {
            txtvisitno.Text = defaultText;
            txtvisitno.Attributes.Add("style", "color:gray");
        }
        txtvisitno.Attributes.Add("onblur", "WaterMarktxt(this,event,'" + defaultText + "');");
        txtvisitno.Attributes.Add("onfocus", "WaterMarktxt(this,event,'" + defaultText + "');");
    }
   
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        string RoomData = "";
        TableHead = "<table  border=\"0\" cellpadding=\"0\"cellspacing=\"0\" style=\"background-color:#fff;\" class=\"taskDetailstip\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
        + "<tr style=\"font-weight: bold;\" class=\"tasktipHeader\"><td>" + Resources.ClientSideDisplayTexts.Lab_Home_InvestigationList + "</td><td>" + Resources.ClientSideDisplayTexts.Lab_Home_Status_2 + "</td><td>" + Resources.ClientSideDisplayTexts.Lab_Home_Comment + "</td></tr>";
        foreach (var Item in InvestigationList)
        {

            TableDate += "<tr style=\"font-weight: bold\">  <td>" + Item.InvestigationName + "</td>"
                        + "<td>" + Item.DisplayStatus + "</td>" + "<td>" + Item.RefPhyName + "</td> </tr>";
        }
        if (InvestigationList[0].StudyInstanceUId != "" && InvestigationList[0].StudyInstanceUId != null)
        {
            RoomData = "<tr style=\"font-weight: bold\"><td align=\"center\" colspan=\"2\"><u>" + Resources.ClientSideDisplayTexts.Lab_Home_RoomNo + "</u>" + InvestigationList[0].StudyInstanceUId + "</td></tr>";
        }
        return TableHead + TableDate + RoomData + "</table> ";
    }
   
   
    private void PerformPatientSearch(int CurPageNo, int PagSize)
    {

        PatientSearch = true;
        Int64 PatientId = 0;
        string PatientName = string.Empty;
        if (Int64.TryParse(txtPatientName.Text, out PatientId))
        {
            loadGridSearch(CurPageNo, PagSize);
        }
        else
        {
            PatientName = txtPatientName.Text.ToString();
            loadGridSearch(CurPageNo, PagSize);
        }



    }
    string strSelect = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_03 == null ? "--Select--" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_03;
    private void LoadLocation()
    {
        List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
        long returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
        //lAddress = lAddress.FindAll(p => p.AddressID == ILocationID);
        ddlocation.DataSource = lAddress;
        ddlocation.DataTextField = "City";
        ddlocation.DataValueField = "AddressID";
        ddlocation.DataBind();
        ddlocation.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
        ddlocation.SelectedIndex = 0;
    }
    public void LoadMeatData()
    {
        try
        {
            ddlRegisterDate.Items.Insert(0, strSelect);
            long returncode = -1;
            string domains = "CustomPeriodRange,VisitType";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var CustomPeriodRange = from child in lstmetadataOutput
                                        where child.Domain == "CustomPeriodRange"
                                        select child;
                if (CustomPeriodRange.Count() > 0)
                {
                    ddlRegisterDate.DataSource = CustomPeriodRange;
                    ddlRegisterDate.DataTextField = "DisplayText";
                    ddlRegisterDate.DataValueField = "Code";
                    ddlRegisterDate.DataBind();
                    ddlRegisterDate.SelectedValue = "Year(s)";
                    ddlRegisterDate.Items.Insert(0, strSelect);
                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddlVisitType.DataSource = childItems2;
                ddlVisitType.DataTextField = "DisplayText";
                ddlVisitType.DataValueField = "Code";
                ddlVisitType.DataBind();
                ddlVisitType.SelectedValue = "-1";

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

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
    public void Loadprotocalgroup()
    {
        try
        {
            long returncode = -1;
            string domains = "ProtocalGroup_Based";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ProtocalGroup_Based"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlprotocalgroup.DataSource = childItems;
                    ddlprotocalgroup.DataTextField = "DisplayText";
                    ddlprotocalgroup.DataValueField = "Code";
                    ddlprotocalgroup.DataBind();
                    ddlprotocalgroup.Items.Insert(0, strSelect.Trim());
                    ddlprotocalgroup.Items[0].Value = "0";
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadMetaData() in Test Master", ex);
        }
    }


    private void GetLocationAndSpeciality()
    {

        long retval = -1;
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<TaskActions> lstCategory = new List<TaskActions>();
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        List<ClientMaster> lstClient = new List<ClientMaster>();
        List<MetaData> lstProtocal = new List<MetaData>();
        TaskProfile taskProfile = new TaskProfile();
        taskProfile.Type = "Authorization";

        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID,taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient, out lstProtocal);

        LoadProtocal(lstProtocal, taskProfile);

    }

    private void LoadProtocal(List<MetaData> lstProtocal, TaskProfile taskProfile)
    {
        if (lstProtocal.Count > 0)
        {
            if (lstProtocal[0].Code.ToString() != "")
            {
                ddlprotocalgroup.SelectedValue = lstProtocal[0].Code.ToString();
            }
            else
            {
                ddlprotocalgroup.SelectedValue = "0";

            }
        }

    }
    #endregion
}
