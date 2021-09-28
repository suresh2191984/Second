using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.IO;


public partial class Patient_PatientViewReport : BasePage
{
    List<Patient> lstPatient = new List<Patient>();
    string StrVal = string.Empty;
    string SearchType = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        long PatientID = 0;
        long ClientID = 0;
        if (!IsPostBack)
        {
            PatientID = Convert.ToInt64(UID);
            if (PatientID > 0)
            {
                SearchType = "";
            }
            ClientID = Convert.ToInt64(CID);
            txtFDate.Text = DateTime.Today.ToString("dd-MM-yyyy h:mmtt");
            txtTDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy h:mmtt");
            ddstatus.SelectedItem.Text = "Approved";

            //************Added by prabakar for config level online portal**25-09-2013****//
            StrVal = GetConfigValue("SummaryPortal", OrgID);
            if (StrVal != "Y")
            {
                grdPatientView.Visible = true;
                //TblSearch.Visible = false;
                grdPatientDetails.Visible = false;

            }
            else
            {
                //TblSearch.Visible= false;
                grdPatientDetails.Visible = true;
                grdPatientView.Visible = false;
            }

            //******End************//
            LoadReportDetails(OrgID, ILocationID, PatientID, ClientID);
        }
    }
    //************Added by prabakar for config level online portal**25-09-2013****//
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
    //******End************//
    public void LoadReportDetails(int OrgID, int OrgAddressID, long PatientiD, long ClientID)
    {
        long returnCode = -1;
        string visitnumber = txtVisitNumber.Text;
        string patientname = txtPatientName.Text;
        string status = ddstatus.SelectedItem.Text;
        if (CID > 0)
        {
            SearchType = "ClientPortal";
        }
        try
        {
            Patient_BL objPatientBL = new Patient_BL();
            returnCode = objPatientBL.GetPatientInvestigationDetails(visitnumber, patientname, status, ClientID, txtFDate.Text, txtTDate.Text, OrgID, OrgAddressID, PatientiD, SearchType, out lstPatient);
            var VisitDate = (from ex in lstPatient
                             group ex by new { ex.VisitDate, ex.PatientVisitID, ex.FileNo, ex.PatientID } into g
                             select new Patient
                             {
                                 PatientID = g.Key.PatientID,
                                 PatientVisitID = g.Key.PatientVisitID,
                                 VisitDate = g.Key.VisitDate,
                                 FileNo = g.Key.FileNo,
                             }).Distinct().ToList();
            if (lstPatient.Count > 0)
            {
                grdPatientView.DataSource = VisitDate;
                grdPatientView.DataBind();
                grdPatientDetails.DataSource = lstPatient;
                grdPatientDetails.DataBind();
            }
            else
            {
                grdPatientView.DataSource = null;
                grdPatientView.DataBind();
                grdPatientDetails.DataSource = null;
                grdPatientDetails.DataBind();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records Found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadReportDetails", ex);
        }
    }

    protected void grdPatientView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient PPD = (Patient)e.Row.DataItem;
                List<Patient> lstChildPatient = new List<Patient>();
                lstChildPatient = (from ex in lstPatient
                                   where ex.PatientVisitID == PPD.PatientVisitID
                                   group ex by new { ex.Name, ex.Status,ex.EMail } into g
                                   select new Patient
                                   {
                                       Name = g.Key.Name,
                                       Status = g.Key.Status,
                                       EMail=g.Key.EMail
                                   }).Distinct().ToList();
                GridView childGrid = (GridView)e.Row.FindControl("grdOrderedinv");
                childGrid.DataSource = lstChildPatient;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Wile binding GetPreviousPhysioVisit ", ex);
        }
    }

    protected void dlChildInvName_ItemDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Patient oPINV = (Patient)e.Row.DataItem;
                    LinkButton lnkShow = (LinkButton)e.Row.FindControl("lnkShow");
                    if (oPINV.EMail != "" && oPINV.EMail != null)
                    {
                        lnkShow.Attributes.Add("ReportUrl", oPINV.EMail);
                        lnkShow.Visible = true;

                    }
                    else
                    { lnkShow.Attributes.Add("class", "show"); }

                }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error packge name ", ex);
        }
    }

    protected void grdPatientView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ShowReport")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                long pVisitID = -1;
                long returnCode = -1;
                long PatientID = -1;
                string dPatientID = string.Empty;
                dPatientID = Convert.ToString(grdPatientView.DataKeys[RowIndex][0]);
                pVisitID = Convert.ToInt64(grdPatientView.DataKeys[RowIndex][1]);
                Int64.TryParse(dPatientID, out PatientID);

                Report_BL objReportBL = new Report_BL();
                string strInvStatus = InvStatus.Approved;
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(strInvStatus);
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                string PDFPath = string.Empty;
                string Status = string.Empty;
                string IsDuePending = string.Empty;
                returnCode = objReportBL.GetCheckDueAmount(PatientID, pVisitID, OrgID, ILocationID, "P", out IsDuePending);
                returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true,"", out lstReportSnapshot);
                //if (IsDuePending == "N")
                //{
                if (lstReportSnapshot.Count > 0)
                {
                    if (IsDuePending == "N")
                    {
                        if (System.IO.File.Exists(lstReportSnapshot[0].ReportPath))
                        {
                            PDFPath = lstReportSnapshot[0].ReportPath;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report cannot be viewed without pending due clearance');", true);
                    }
                }

                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);

                }

                if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
                {
                    if (IsDuePending == "N")
                    {
                        string CurrentOrgID = OrgID.ToString();
                        string filePath = PDFPath;
                        modalPopUp.Show();
                        ifPDF.Attributes["src"] = "ReportPdf.aspx?pdf=" + filePath;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report cannot be viewed without pending due clearance');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);
                }
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('You are having due');", true);
                //}
                //Request.QueryString.Clear();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Getting Report, PDF", ex);
        }
    }

    protected void grdPatientDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ShowReport")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                long pVisitID = -1;
                long returnCode = -1;
                long PatientID = -1;
                string dPatientID = string.Empty;
                string pType = string.Empty;
                dPatientID = Convert.ToString(grdPatientDetails.DataKeys[RowIndex][0]);
                pVisitID = Convert.ToInt64(grdPatientDetails.DataKeys[RowIndex][1]);
                pType = Convert.ToString(grdPatientDetails.DataKeys[RowIndex][2]);
                Int64.TryParse(dPatientID, out PatientID);

                Report_BL objReportBL = new Report_BL();
                string strInvStatus = InvStatus.Approved;
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(strInvStatus);
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                string PDFPath = string.Empty;
                string Status = string.Empty;
                string IsDuePending = string.Empty;
                returnCode = objReportBL.GetCheckDueAmount(PatientID, pVisitID, OrgID, ILocationID, "P", out IsDuePending);
                if (pType.ToLower() == "roundbpdf")
                {
                    returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, false,"", out lstReportSnapshot);
                }
                else
                {
                    returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true,"", out lstReportSnapshot);
                }
                //if (IsDuePending == "N")
                //{
                if (lstReportSnapshot.Count > 0)
                {
                    if (IsDuePending == "N")
                    {
                        if (System.IO.File.Exists(lstReportSnapshot[0].ReportPath))
                        {
                            PDFPath = lstReportSnapshot[0].ReportPath;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report cannot be viewed without pending due clearance');", true);
                    }
                }

                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);

                }

                if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
                {
                    if (IsDuePending == "N")
                    {
                        string CurrentOrgID = OrgID.ToString();
                        string filePath = PDFPath;
                        modalPopUp.Show();
                        ifPDF.Attributes["src"] = "ReportPdf.aspx?pdf=" + filePath;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report cannot be viewed without pending due clearance');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);
                }
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('You are having due');", true);
                //}
              //  Request.QueryString.Clear();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Getting Report, PDF", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        if ((Convert.ToInt64(UID) > 0) || (Convert.ToInt64(CID) > 0))
            LoadReportDetails(OrgID, ILocationID, Convert.ToInt64(UID), Convert.ToInt64(CID));
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            Session.Abandon();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(Convert.ToDateTime(new BasePage().OrgDateTimeZone) - new TimeSpan(1, 0, 0));
            Response.Cache.SetLastModified(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            //************Added by prabakar for config level online portal**25-09-2013****//
            StrVal = GetConfigValue("SummaryPortal", OrgID);
            if (StrVal == "Y")
            {
                Response.Redirect(Request.ApplicationPath + "/Home.aspx", true);
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + "/PatientLogin.aspx", true);
            }
            //*******End****//
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void grdPatientDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient PPD = (Patient)e.Row.DataItem;
                if (PPD.ReportStatus.ToLower() == "report is not ready")
                {
                    ImageButton Image1 = (ImageButton)e.Row.FindControl("Image1");
                    Image1.Attributes.Add("style", "display:none");
                    //e.Row.BackColor = System.Drawing.Color.FromName("#BB8000");

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Wile binding GetPreviousPhysioVisit ", ex);
        }
    }

    protected void grdPatientDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        long PatientID = 0;
        long ClientID = 0;
        PatientID = Convert.ToInt64(UID);
        ClientID = Convert.ToInt64(CID);
        if (e.NewPageIndex != -1)
        { 
            grdPatientDetails.PageIndex = e.NewPageIndex;
            LoadReportDetails(OrgID, ILocationID, PatientID, ClientID);
        }
    }
}
