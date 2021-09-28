using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
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

public partial class Admin_LabAdminSummaryReportsPrint : BasePage
{
    long returnCode = -1;
    int clientID = -1;
    int collectionCentreID = -1;
    DateTime strBillFromDate;
    int ReferingPhysicianID = -1;
    long HospitalID = -1;
    int InsuranceID = -1;
    DateTime strBillToDate;
    int flag = -1;
    decimal GrandTotal = 0;
    long deptID = -1;
    long userID = 0;
    decimal TotalCashAmount = 0;
    decimal TotalDiscountAmount = 0;
    decimal TotalPaidAmount = 0;
    decimal TotalDuePaidAmount = 0;
    decimal CombinedDeptAmount = 0;
    string concatenateDate = string.Empty;
    List<DailyReport> billSearch = new List<DailyReport>();
    List<BillLineItems> billItems = new List<BillLineItems>();
    List<DailyReport> lstDoctorWiseReport = new List<DailyReport>();
    List<DailyReport> lstDisplayName = new List<DailyReport>();
    List<LabConsumables> lstLabConsumables = new List<LabConsumables>();
    List<DailyReport> lDailyReport = new List<DailyReport>();
    Patient_BL patientBL ;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    TableRow tr = null;
    TableCell tc1 = null;
    TableCell tc2 = null;
    decimal miscellaneousTotal = 0;
    int splitUp = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);

        try
        {
            DateTime.TryParse(Request.QueryString["fromDate"], out strBillFromDate);
            DateTime.TryParse(Request.QueryString["toDate"], out strBillToDate);
            Int32.TryParse(Request.QueryString["refPhyID"], out ReferingPhysicianID);
            Int64.TryParse(Request.QueryString["hpid"], out HospitalID);
            Int32.TryParse(Request.QueryString["cid"], out clientID);
            Int32.TryParse(Request.QueryString["ccid"], out collectionCentreID);
            Int32.TryParse(Request.QueryString["INSid"], out InsuranceID);
            Int32.TryParse(Request.QueryString["flag"], out flag);
            Int64.TryParse(Request.QueryString["deptID"], out deptID);
            Int32.TryParse(Request.QueryString["splitUp"], out splitUp);
            Int64.TryParse(Request.QueryString["userID"], out userID);
            
            if (strBillFromDate.ToString() == strBillToDate.ToString())
            {
                concatenateDate = strBillFromDate.ToString("dd/MM/yyyy");
            }
            else
            {
                concatenateDate = " (" + strBillFromDate.ToString("dd/MM/yyyy") + " - " + strBillToDate.ToString("dd/MM/yyyy") + ")";
            }

            patientVisit_BL.GetLocation(OrgID,LID,0, out lstOrganizationAddress);
            orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
            dateTextForReport.InnerHtml = "Collection Summary for - " + concatenateDate;



            if (deptID.ToString() != "0" && Request.QueryString["RepFmt"] == "DR")
            {
                orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
                dateTextForReport.InnerHtml = "Collection Summary for - " + concatenateDate;
                
                List<DailyReport> lDeptName = new List<DailyReport>();
                patientBL.GetDeptwiseReport(userID, deptID, strBillFromDate, strBillToDate, OrgID, splitUp, out lDailyReport, out lDeptName, out lstLabConsumables, out GrandTotal, out TotalCashAmount, out TotalDiscountAmount, out TotalPaidAmount, out TotalDuePaidAmount, out CombinedDeptAmount);
                if (lDeptName.Count > 0)
                {
                    grdCollection.Visible = true;
                    grdCollection.DataSource = lDeptName;
                    grdCollection.DataBind();
                   
                    lblResult.Text = "";
                  
                    grdResult.Visible = false;
                    lblGrandTotal.InnerText = String.Format("{0:0.00}", (GrandTotal));
                    tblDoctorWisereport.Style.Add("display", "none");
                    gvDoctorWiseReport.Visible = false;
                    grdDoctorsResult.Visible = false;
                    lblName.Text = "";
                    lblDoctorName.Text = "";
                    
                    if (lstLabConsumables.Count > 0)
                    {
                        consumableTab.Visible = true;
                        miscellaneousTotalTab.Visible = true;
                        tr = new TableRow();
                        tc1 = new TableCell();
                        tc1.Width = Unit.Percentage(80);
                        tc1.Text = "Miscellaneous";
                        tc1.Attributes.Add("align", "center");
                        tr.Cells.Add(tc1);
                        tc2 = new TableCell();
                        tc2.Width = Unit.Percentage(20);
                        tc2.Text = "Amount";
                        tc2.Attributes.Add("align", "right");
                        tr.Cells.Add(tc2);
                        tr.Height = 15;
                        tr.BorderWidth = 1;
                       // tr.Style.Add("background-color", "#");
                        tr.Style.Add("color", "#000000");
                        tr.Style.Add("font-weight", "bold");
                        consumableTab.Rows.Add(tr);
                        foreach (LabConsumables objLC in lstLabConsumables)
                        {
                            tr = new TableRow();
                            tc1 = new TableCell();
                            tc1.Width = Unit.Percentage(80);
                            tc1.Text = objLC.ConsumableName;
                            tc1.Attributes.Add("align", "center");
                            tc1.BorderWidth = 1;
                            tr.Cells.Add(tc1);
                            tc2 = new TableCell();
                            tc2.Width = Unit.Percentage(20);
                            tc2.Text = String.Format("{0:0.00}", objLC.Rate);
                            tc2.Attributes.Add("align", "right");
                            tc2.BorderWidth = 1;
                            tr.Cells.Add(tc2);
                            tr.Height = 20;
                            tr.BorderWidth = 1;
                            consumableTab.Rows.Add(tr);
                            miscellaneousTotal += objLC.Rate;
                        }
                        lblMiscellaneousTotal.InnerText = String.Format("{0:0.00}", miscellaneousTotal);
                    }
                    else
                    {
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                    }
                    if (deptID == 1)
                    {
                        combinedDeptCollectionTab.Visible = true;
                        individualDeptCollectionTab.Visible = true;
                        lblIndividualDeptCollection.InnerText = String.Format("{0:0.00}", GrandTotal);
                        lblCombinedDeptCollection.InnerText = String.Format("{0:0.00}", CombinedDeptAmount);
                        lblGrandTotal.InnerText = String.Format("{0:0.00}", (CombinedDeptAmount + GrandTotal + miscellaneousTotal));
                    }
                    else
                    {
                        combinedDeptCollectionTab.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                    }

                    tabGranTotal1.Visible = true;
                    if (deptID == 1)
                    {
                        lblCollectionAmount.InnerText = String.Format("{0:0.00}", TotalCashAmount);
                        lblDiscountAmount.InnerText = String.Format("{0:0.00}", TotalDiscountAmount);
                        lblCashAmount.InnerText = String.Format("{0:0.00}", TotalPaidAmount);
                        lblDuePaidAmount.InnerText = String.Format("{0:0.00}", TotalDuePaidAmount);
                        lblDueAmount.InnerText = String.Format("{0:0.00}", ((TotalCashAmount) - (TotalDiscountAmount + TotalPaidAmount)));
                        lblGrandTotalAmount.InnerText = String.Format("{0:0.00}", (TotalPaidAmount + TotalDuePaidAmount));
                        tabGranTotal2.Visible = true;
                    }
                    else
                    {
                        tabGranTotal2.Visible = false;
                    }

                }
                else
                {
                    tabGranTotal2.Visible = false;
                    tabGranTotal1.Visible = false;
                    individualDeptCollectionTab.Visible = false;
                    combinedDeptCollectionTab.Visible = false;
                    consumableTab.Visible = false;
                    miscellaneousTotalTab.Visible = false;
                    grdCollection.Visible = false;
                    lblResult.Visible = false;
                    lblResult.Text = "";
                    orgHeaderTextForReport.InnerText = "";
                    dateTextForReport.InnerText = "";
                    tblDoctorWisereport.Style.Add("display", "none");
                    gvDoctorWiseReport.Visible = false;
                    grdResult.Visible = false;
                    grdDoctorsResult.Visible = false;
                    lblName.Text = "";
                    lblDoctorName.Text = "";
                }
            }














            if (Request.QueryString["RepFmt"] != "SR" && Request.QueryString["AllDr"] != "Yes")
            {

                returnCode = patientBL.SearchBillByParameter(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, out billSearch, out billItems, out GrandTotal);
                if (returnCode == 0 && billSearch.Count > 0)
                {
                    lblGrandTotal.InnerText = String.Format("{0:0.00}", GrandTotal);
                    tabGranTotal1.Visible = true;
                    grdResult.Visible = true;
                    lblResult.Visible = false;
                    lblResult.Text = "";
                    grdResult.DataSource = billSearch;
                    grdResult.DataBind();
                    tblDoctorWisereport.Style.Add("display", "none");
                }
                else
                {
                    grdResult.Visible = false;
                    lblResult.Visible = false;
                    tblDoctorWisereport.Style.Add("display", "none");
                    lblResult.Text = "No Matching Records Found!";
                }
            }
            else
            {
                if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "No")
                {
                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        grdResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        if (flag == 1)
                        {
                            lblName.Text = "Doctor name : Dr.";
                            lblDoctorName.Text = lstDisplayName[0].ReferingPhysicianName + " " + lstDisplayName[0].Qualification;
                        }
                        if (flag == 2)
                        {
                            lblName.Text = " Hospital Name : ";
                            lblDoctorName.Text = lstDisplayName[0].HospitalName;
                        }

                        if (flag == 3)
                        {
                            lblName.Text = "Client Name : ";
                            lblDoctorName.Text = lstDisplayName[0].ClientName;
                        }
                    }
                    else
                    {
                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        lblResult.Text = "No Matching Records Found!";
                    }
                }


                if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "Yes" && deptID == 1)
                {
                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        grdResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        if (flag == 1)
                        {
                            lblName.Text = "Doctor name : Dr.";
                            lblDoctorName.Text = lstDisplayName[0].ReferingPhysicianName + " " + lstDisplayName[0].Qualification;
                        }
                        if (flag == 2)
                        {
                            lblName.Text = " Hospital Name : ";
                            lblDoctorName.Text = lstDisplayName[0].HospitalName;
                        }

                        if (flag == 3)
                        {
                            lblName.Text = "Client Name : ";
                            lblDoctorName.Text = lstDisplayName[0].ClientName;
                        }
                        if(deptID == 1)
                        {
                            lblName.Text = "All Departments";
                        }
                    }
                    else
                    {
                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        lblResult.Text = "No Matching Records Found!";
                    }
                }


                if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "No" && deptID > 1)
                {
                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        grdResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        lblName.Text = "Department Name : ";
                        lblDoctorName.Text = lstDisplayName[0].DeptName;

                    }
                    else
                    {
                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        lblResult.Text = "No Matching Records Found!";
                    }
                }


                if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "Yes" && deptID == 0)
                {
                    returnCode = patientBL.GetAllDoctorReport(strBillFromDate, strBillToDate, OrgID, flag, out lstDoctorWiseReport, out lstDisplayName);


                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        tblAllDoctorsReport.Style.Add("display", "block");
                        tblDoctorWisereport.Style.Add("display", "none");
                        grdDoctorsResult.DataSource = lstDisplayName;
                        grdDoctorsResult.DataBind();
                    }
                    else
                    {
                        tblAllDoctorsReport.Style.Add("display", "none");
                        lblResult.Visible = false;
                        lblResult.Text = "No Matching Records Found!";
                    }
                }
            }

            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReportsPrint Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void grdResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        DailyReport BMaster = (DailyReport)e.Item.DataItem;


        var childItems = from child in billItems
                         where child.BillID == BMaster.BillID
                         select child;

        Repeater childReapeter = (Repeater)e.Item.FindControl("grdChildResult");
        childReapeter.DataSource = childItems;
        childReapeter.DataBind();

    }
    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        //export to excel
        string attachment = "attachment; filename=Reports.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        resultTab.RenderControl(oHtmlTextWriter);
        //if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "No")
        //{
        //    tblDoctorWisereport.RenderControl(oHtmlTextWriter);
        //}
        //if (Request.QueryString["RepFmt"] == "DR" && Request.QueryString["AllDr"] == "No")
        //{
        //    tabgrdResult.RenderControl(oHtmlTextWriter);
        //}
        //if (Request.QueryString["RepFmt"] == "SR" && Request.QueryString["AllDr"] == "Yes")
        //{
        //    tblAllDoctorsReport.RenderControl(oHtmlTextWriter);

        //}
        Response.Write(oStringWriter.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReportsPrint Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }


    protected void grdDoctorsResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DailyReport ReportId = (DailyReport)e.Row.DataItem;

                var childItems = from child in lstDoctorWiseReport
                                 where child.ID == ReportId.ID
                                 select child;

                GridView ChildGrd = (GridView)e.Row.FindControl("gvChildDoctorsResult");
                ChildGrd.DataSource = childItems;
                ChildGrd.DataBind();
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DoctorsReport Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    protected void grdCollection_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            DailyReport eDailyReport = (DailyReport)e.Row.DataItem;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var item = from child in lDailyReport
                           //                       group child by child.BillDate into grp
                           where child.DeptID == eDailyReport.DeptID
                           select child;
                GridView childGrid = (GridView)e.Row.FindControl("grdCollectionDetail");
                childGrid.DataSource = item.ToList<DailyReport>();
                childGrid.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void grdCollection_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdCollection.PageIndex = e.NewPageIndex;
        }
    }
}
