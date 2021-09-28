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
public partial class Reports_ListofPatientsReport : BasePage
{
    long returnCode = -1;
    static  int visitType;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            LoadSpecialityName();
            //LoadPhysicianNames();
            if (Request.QueryString["status"] == "TodaysOP")
            {
                rblVisitType.SelectedValue = "0";
                rblVType.SelectedValue = "0";
                btnSubmit_Click(sender, e);
            }
        }
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
            //if (visitTypeID == 0)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //if (visitTypeID == 1)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //else if (visitTypeID == -1)
            //{
            //    e.Row.Cells[4].Visible = true;
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;



                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        int visitType = Convert.ToInt32(rblVType.SelectedItem.Value);
        if (visitType == 0)
        {
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[10].Visible = false;
        }
        else
        {
            e.Row.Cells[4].Visible = true;
            e.Row.Cells[10].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[1].Text = "";
                e.Row.Cells[4].Text = "";
                e.Row.Cells[5].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        if (visitType == 0)
        {
            DataTable dt = new DataTable();
            DataColumn dcol1 = new DataColumn("PatientNumber");
            DataColumn dcol3 = new DataColumn("PatientName");
            DataColumn dcol4 = new DataColumn("Age");
            //DataColumn dcol2 = new DataColumn("IPNumber");
            DataColumn dcol9 = new DataColumn("ConsultantName");
            DataColumn dcol8 = new DataColumn("SpecialityName");
            //  DataColumn dcol7 = new DataColumn("ADMDiagnosis");
            DataColumn dcol5 = new DataColumn("Address");
            
            DataColumn dcol10 = new DataColumn("VisitDate");
            DataColumn dcol11 = new DataColumn("VisitType");
            DataColumn dcol6 = new DataColumn("ContactNumber");
            dt.Columns.Add(dcol1);
            //dt.Columns.Add(dcol2);
            dt.Columns.Add(dcol3);
            dt.Columns.Add(dcol4);
            dt.Columns.Add(dcol5);
            dt.Columns.Add(dcol6);
            //dt.Columns.Add(dcol7);
            dt.Columns.Add(dcol8);
            dt.Columns.Add(dcol9);
            dt.Columns.Add(dcol10);
            dt.Columns.Add(dcol11);
            foreach (DayWiseCollectionReport item in lstDWCR)
            {
                DataRow dr = dt.NewRow();
                dr["PatientNumber"] = item.PatientNumber;
                dr["PatientName"] = item.PatientName;
                dr["Age"] = item.Age;
                // dr["IPNumber"] = item.IPNumber;
                dr["ConsultantName"] = item.ConsultantName;
                dr["SpecialityName"] = item.SpecialityName;
                //dr["ADMDiagnosis"] = item.ADMDiagnosis;
                dr["Address"] = item.Address.ToString().Trim();
                dr["VisitDate"] = item.VisitDate.ToShortDateString();
                dr["VisitType"] = item.VisitType;
                dr["ContactNumber"] = item.ContactNumber;

                dt.Rows.Add(dr);
            }
            return dt;
        }
        else
        {
            DataTable dt = new DataTable();
            DataColumn dcol1 = new DataColumn("PatientNumber");
            DataColumn dcol3 = new DataColumn("PatientName");
            DataColumn dcol4 = new DataColumn("Age");
            DataColumn dcol2 = new DataColumn("IPNumber");
            DataColumn dcol5 = new DataColumn("ConsultantName");
            DataColumn dcol6 = new DataColumn("SpecialityName");
            //  DataColumn dcol7 = new DataColumn("ADMDiagnosis");
            DataColumn dcol8 = new DataColumn("Address");
            DataColumn dcol9 = new DataColumn("VisitDate");
            DataColumn dcol10 = new DataColumn("VisitType");
            DataColumn dcol11 = new DataColumn("ContactNumber");
            dt.Columns.Add(dcol1);
            dt.Columns.Add(dcol2);
            dt.Columns.Add(dcol3);
            dt.Columns.Add(dcol4);
            dt.Columns.Add(dcol5);
            dt.Columns.Add(dcol6);
            //dt.Columns.Add(dcol7);
            dt.Columns.Add(dcol8);
            dt.Columns.Add(dcol9);
            dt.Columns.Add(dcol10);
            dt.Columns.Add(dcol11);
            foreach (DayWiseCollectionReport item in lstDWCR)
            {
                DataRow dr = dt.NewRow();
                dr["PatientNumber"] = item.PatientNumber;
                dr["PatientName"] = item.PatientName;
                dr["Age"] = item.Age;
                dr["IPNumber"] = item.IPNumber;
                dr["ConsultantName"] = item.ConsultantName;
                dr["SpecialityName"] = item.SpecialityName;
                //dr["ADMDiagnosis"] = item.ADMDiagnosis;
                dr["Address"] = item.Address.ToString().Trim();
                dr["VisitDate"] = item.VisitDate.ToShortDateString();
                dr["VisitType"] = item.VisitType;
                dr["ContactNumber"] = item.ContactNumber;
                dt.Rows.Add(dr);
            }
            return dt;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string requestType = rblVisitType.SelectedItem.Text;
            visitType = Convert.ToInt32(rblVType.SelectedItem.Value);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int specialityID = 0;// (ddlSpeciality.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt32(ddlSpeciality.SelectedValue);
            long phyID = 0; // (ddlConsultingName.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt64(ddlConsultingName.SelectedValue);
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
            List<Physician> lstPhysician = new List<Physician>();

            foreach (ListItem lSpec in cblSpeciality.Items)
            {
                if (lSpec.Selected)
                {
                    DayWiseCollectionReport s = new DayWiseCollectionReport();
                    s.OrgID = Convert.ToInt32(lSpec.Value);
                    lstSpecialityIds.Add(s);
                }
            }
            foreach (ListItem lSpec in cblConsultingName.Items)
            {
                if (lSpec.Selected)
                {
                    DayWiseCollectionReport s = new DayWiseCollectionReport();
                    s.PhysicianID = Convert.ToInt32(lSpec.Value);
                    lstPhyIDs.Add(s);
                }
            }

            divFilter.Attributes.Add("style", "none");
            returnCode = new Report_BL(base.ContextInfo).GetPatientReport(fDate.ToString("dd/MM/yyyy"), tDate.ToString("dd/MM/yyyy"), OrgID, visitType, requestType, specialityID, phyID, lstSpecialityIds, lstPhyIDs, out lstDWCR, out lstPhysician);

            //var dwcr = (from dw in lstDWCR
            //            select new { dw.VisitDate }).Distinct();

            //List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            //foreach (var obj in dwcr)
            //{
            //    DayWiseCollectionReport pdc = new DayWiseCollectionReport();
            //    pdc.VisitDate = obj.VisitDate;
            //    lstDayWiseRept.Add(pdc);
            //}
           
            if (lstDWCR.Count > 0)
            {
               
                lstday = lstDWCR;
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt); 
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                divFilter.Visible = false;//.Attributes.Add("style", "none");

                ddlCity.DataSource = lstDWCR;
                ddlCity.DataTextField = "City";
                ddlCity.DataValueField = "City";
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, "--- Select ---");

                if (requestType == "New Patient")
                {
                    //gvOPReport.Visible = false;
                    gvIPCreditMain.Visible = true;
                    //gvIPCreditMain.Columns[0].HeaderText = "Registration Report";
                    gvIPCreditMain.DataSource = lstDWCR;
                    gvIPCreditMain.DataBind();
                    int k = lstDWCR.Count();
                    if (visitType == 0)
                    {

                        lbltotal.Text = "Total No of New Patient(s) - OP :" +" "+ k.ToString()+" "+"Patients" ;
                    }
                    else
                    {
                        lbltotal.Text = "Total No of New Patient(s) - IP :" + " " + k.ToString() + " " + "Patients";
                    }

                }
                else if (requestType == "Follow Up")
                {
                    gvIPCreditMain.Visible = true;
                    //gvOPReport.Visible = false;
                    //gvIPCreditMain.Columns[0].HeaderText = "Follow up Reports";
                    gvIPCreditMain.DataSource = lstDWCR;
                    gvIPCreditMain.DataBind();
                    int k = lstDWCR.Count();
                    if (visitType == 0)
                    {

                        lbltotal.Text = "Total No of Follow UP Patient(s) - OP :" + " " + k.ToString() + " " + "Patients";
                    }
                    else
                    {
                        lbltotal.Text = "Total No of Follow UP Patient(s) - IP :" + " " + k.ToString() + " " + "Patients";
                    }
                }
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                divFilter.Visible = false;//.Attributes.Add("style", "none");

                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
            if (lstPhysician.Count > 0)
            {
                lblConst.Visible = true;
                cblConsultingName.DataSource = lstPhysician;
                cblConsultingName.DataTextField = "PhysicianName";
                cblConsultingName.DataValueField = "LoginID";
                cblConsultingName.DataBind();
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
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

        //ddlSpeciality.DataSource = lstSpeciality;
        //ddlSpeciality.DataTextField = "SpecialityName";
        //ddlSpeciality.DataValueField = "SpecialityID";
        //ddlSpeciality.DataBind();
        //ddlSpeciality.Items.Insert(0, "--- Select ---");

        cblSpeciality.DataSource = lstSpeciality;
        cblSpeciality.DataTextField = "SpecialityName";
        cblSpeciality.DataValueField = "SpecialityID";
        cblSpeciality.DataBind();
    }
    //protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "speciality", "<script> document.getElementById('divConsultingName').style.display='block' </script>", false);
    //    LoadConsultingName();
    //    //selectedSpeciality(sender, e);
    //}
    //public void LoadPhysicianNames()
    //{
    //    List<Physician> lstPhysician = new List<Physician>();
    //    new PatientVisit_BL(base.ContextInfo).GetDoctorsForLab(OrgID, out lstPhysician);

    //    ddlConsultingName.DataSource = lstPhysician;
    //    ddlConsultingName.DataTextField = "PhysicianName";
    //    ddlConsultingName.DataValueField = "PhysicianID";
    //    ddlConsultingName.DataBind();
    //    ddlConsultingName.Items.Insert(0, "--- Select ---");
    //}
    ////public void LoadConsultingName()
    //{
    //    if (ddlSpeciality.SelectedItem.Text != "--- Select ---")
    //    {
    //        List<Physician> lstPhysician = new List<Physician>();
    //        new PatientVisit_BL(base.ContextInfo).GetConsultingName(Convert.ToInt64(ddlSpeciality.SelectedItem.Value), OrgID, out lstPhysician);

    //        ddlConsultingName.DataSource = lstPhysician;
    //        ddlConsultingName.DataTextField = "PhysicianName";
    //        ddlConsultingName.DataValueField = "PhysicianID";
    //        ddlConsultingName.DataBind();
    //        ddlConsultingName.Items.Insert(0, "--- Select ---");
    //    }
    //    else
    //    {
    //        ddlConsultingName.Items.Clear();
    //        ddlConsultingName.Items.Insert(0, "--- Select ---");
    //    }

    //}

    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "ListofPatients_Report_";
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
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
}
