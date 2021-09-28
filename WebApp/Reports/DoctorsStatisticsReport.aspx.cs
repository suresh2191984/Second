#region File Header Comments (to be placed before using block)
//=======================================================================================
// Copyright (C) 2007-2012 Attune Technologies, Adyar, Chennai
//========================================================================================
// Purpose: To get the Doctors' statictics
// Author: <CODER NAME>
// Date Created: <DATE>
//========================================================================================
// File Change History (to be updated everytime this file is modified)
// ---------------------------------------------------------------------------------------
//  Date            Worker                        Work Description
// ---------------------------------------------------------------------------------------
// 18-Nov-2010      Vijay TV                     1. Error handling in Convert.ToInt32
//                                               2. Proper information in logging of errors
//                                               3. Commenting out needless code block
// ---------------------------------------------------------------------------------------
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;

public partial class Reports_DoctorsStatisticsReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            LoadSpecialityName();
            LoadPhysicianNames();

        }
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {           
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;

                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);
                //str = lbl.Text.ToString();
                //dt.TableName = str;
                ds.Tables.Add(dt);  
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
            CLogger.LogError("Error in gvIPReport_RowDataBound - Doctor's Statistics Report", ex); // Wrong report name in log file. Very difficult to debug even if we see this log
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (visitTypeID == 0)
        {
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
        }
        if (visitTypeID == 1)
        {
            e.Row.Cells[5].Visible = true;
            e.Row.Cells[6].Visible = true;
            e.Row.Cells[7].Visible = false;
        }
        else if (visitTypeID == -1)
        {
            e.Row.Cells[5].Visible = true;
            e.Row.Cells[6].Visible = true;
            e.Row.Cells[7].Visible = true;
        }
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
            
        //    if (((DayWiseCollectionReport)e.Row.DataItem).VisitType == "OP")
        //    {
        //        e.Row.Cells[0].Text = "";
        //        e.Row.Cells[2].Text = "";
        //        e.Row.Cells[3].Text = "";

        //        e.Row.Style.Add("font-weight", "bold");
        //        e.Row.Style.Add("color", "Black");
        //    }
        //}

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            //int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            //DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            //DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int visitType;
            Int32.TryParse(rblVisitType.SelectedValue, out visitType);
            DateTime fDate;
            DateTime.TryParse(txtFDate.Text, out fDate);
            DateTime tDate;
            DateTime.TryParse(txtTDate.Text, out tDate);
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends

            int specialityID = 0;// (ddlSpeciality.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt32(ddlSpeciality.SelectedValue);
            long phyID = 0;// (ddlConsultingName.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt64(ddlConsultingName.SelectedValue);

            List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
            List<Physician> lstPhysician = new List<Physician>();

            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // Moved the object creation outside the For loop so that the instance creation is avoided inside the loop
            DayWiseCollectionReport s;
            int nOutput; // variable to check the Int32 conversion; this is used inside TryParse call
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
            foreach (ListItem lSpec in cblSpeciality.Items)
            {
                if (lSpec.Selected)
                {
                    // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                    // DayWiseCollectionReport s = new DayWiseCollectionReport();
                    s = new DayWiseCollectionReport();
                    // s.PhysicianID = Convert.ToInt32(lSpec.Value);
                    Int32.TryParse(lSpec.Value, out nOutput); // to avoid run time exception in case the string doesn't contain valid integer as content
                    s.PhysicianID = nOutput; // this will either contain the Integer equivalent of lSpec.Value or 0
                    // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
                    lstSpecialityIds.Add(s);
                }
            }

            
            foreach (ListItem lSpec in cblConsultingName.Items)
            {
                if (lSpec.Selected)
                {
                    // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                    // DayWiseCollectionReport s = new DayWiseCollectionReport();
                    // No need to declare instance for DayWiseCollectionReport again; 's' is already there and so use it here
                    s = new DayWiseCollectionReport();
                    // s.PhysicianID = Convert.ToInt32(lSpec.Value);
                    Int32.TryParse(lSpec.Value, out nOutput); // to avoid run time exception in case the string doesn't contain valid integer as content
                    s.PhysicianID = nOutput; // this will either contain the Integer equivalent of lSpec.Value or 0
                    // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
                    lstPhyIDs.Add(s);
                }
            }

            returnCode = new Report_BL(base.ContextInfo).GetDoctorsStatisticsReport(fDate, tDate, OrgID, visitType, specialityID, phyID, lstSpecialityIds, lstPhyIDs, out lstDWCR, out lstPhysician);

            var dwcr = (from dw in lstDWCR
                        select new { dw.VisitDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            DayWiseCollectionReport pdc; 
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
            foreach (var obj in dwcr)
            {
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                // DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc = new DayWiseCollectionReport(); // new variable is not created every time inside the loop
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                pdc.VisitDate = obj.VisitDate;
                lstDayWiseRept.Add(pdc);
            }

            if (lstDWCR.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                if (visitType == 0)
                {
                    //gvOPReport.Visible = false;
                    gvIPReport.Visible = true;
                    gvIPReport.Columns[0].HeaderText = "OP Doctor's Statistics";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP Doctor's Statistics";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP / IP Doctor's Statistics";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                }
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
            if (lstPhysician.Count > 0)
            {
                cblConsultingName.DataSource = lstPhysician;
                cblConsultingName.DataTextField = "PhysicianName";
                cblConsultingName.DataValueField = "LoginID";
                cblConsultingName.DataBind();
            }
        }
        catch (Exception ex)
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
            CLogger.LogError("Error in Get Report, Doctor's Statistics", ex); // Wrong report name in Log file ! This cannot afford to be wrong is the last thing to go wrong in the log error
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        // This catch block is not valid. Either it should log or throw the exception. It simple cannot swallow the exception
        //catch (System.Threading.ThreadAbortException tae)
        //{
        //    string exp = tae.ToString();
        //}
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }

    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);

        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        // Loading of this List items is not needed as its visibility is set to False in design
        //ddlSpeciality.DataSource = lstSpeciality;
        //ddlSpeciality.DataTextField = "SpecialityName";
        //ddlSpeciality.DataValueField = "SpecialityID";
        //ddlSpeciality.DataBind();
        //ddlSpeciality.Items.Insert(0, "--- Select ---");
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends

        cblSpeciality.DataSource = lstSpeciality;
        cblSpeciality.DataTextField = "SpecialityName";
        cblSpeciality.DataValueField = "SpecialityID";
        cblSpeciality.DataBind();
        //cblSpeciality.Items.Insert(0, "--- ALL ---");
    }
    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "speciality", "<script> document.getElementById('divConsultingName').style.display='block' </script>", false);
        LoadConsultingName();
        //selectedSpeciality(sender, e);
    }
    public void LoadPhysicianNames()
    {
        List<Physician> lstPhysician = new List<Physician>();
        new PatientVisit_BL(base.ContextInfo).GetDoctorsForLab(OrgID, out lstPhysician);

        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        // Loading of this List items is not needed as its visibility is set to False in design
        //ddlConsultingName.DataSource = lstPhysician;
        //ddlConsultingName.DataTextField = "PhysicianName";
        //ddlConsultingName.DataValueField = "PhysicianID";
        //ddlConsultingName.DataBind();
        //ddlConsultingName.Items.Insert(0, "--- Select ---");
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
    }
     public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("SpecialityName");
        DataColumn dcol5 = new DataColumn("ConsultantName");
        DataColumn dcol6 = new DataColumn("DISDiagnosis");
       
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        DataRow dr;
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // DataRow dr = dt.NewRow();
            dr = dt.NewRow();
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
            dr["PatientNumber"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["SpecialityName"] = item.SpecialityName;
            dr["ConsultantName"] = item.ConsultantName;
            dr["DISDiagnosis"] = item.ADMDiagnosis;
            dt.Rows.Add(dr);           
        }
        return dt;
    }
    public void LoadConsultingName()
    {
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins

        // This code block not needed
        //if (ddlSpeciality.SelectedItem.Text != "--- Select ---")
        //{
        //    List<Physician> lstPhysician = new List<Physician>();
        //    new PatientVisit_BL(base.ContextInfo).GetConsultingName(Convert.ToInt64(ddlSpeciality.SelectedItem.Value), OrgID, out lstPhysician);

        //    ddlConsultingName.DataSource = lstPhysician;
        //    ddlConsultingName.DataTextField = "PhysicianName";
        //    ddlConsultingName.DataValueField = "PhysicianID";
        //    ddlConsultingName.DataBind();
        //    ddlConsultingName.Items.Insert(0, "--- Select ---");
        //}
        //else
        //{
        //    ddlConsultingName.Items.Clear();
        //    ddlConsultingName.Items.Insert(0, "--- Select ---");
        //}
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "Doctor_Statics_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // CLogger.LogError("Error while Converting to Excel", ex);
            CLogger.LogError("Error while Converting to Excel in Doctor Statistics Report", ex); // Should specifically say which report failed to convert
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        }
    }
}
