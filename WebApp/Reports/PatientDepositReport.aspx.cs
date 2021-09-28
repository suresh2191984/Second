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

public partial class Reports_PatientDepositReport : BasePage
{
    List<Patient> lstPatient;
    Report_BL objReport_BL;
    Dictionary<string, decimal> dicpagetotal = new Dictionary<string, decimal>();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
         txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            if (!IsPostBack)
            {
                 string rval = GetConfigValue("IssueSmartCard", OrgID);
                 Hdnsmartcard.Value = rval;
                //BindPatientDepositReport();
                //txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
               // txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            }

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindPatientDepositReport();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientDeposit Report, btnSearch_Click", ex);
        }
    }

    private void BindPatientDepositReport()
    {
         
        try
        {
            string flag = string.Empty;
            string PName = string.Empty;
            string tempfrom = "01/01/2001 00:00:00";
            DateTime fromDate, ToDate;
            if (txtFDate.Text != "" && txtTDate.Text != "")
            {
                fromDate = Convert.ToDateTime(txtFDate.Text);
                ToDate = Convert.ToDateTime(txtTDate.Text);
            }
            else
            {
                fromDate = Convert.ToDateTime(tempfrom);
                ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
            }
            if (txtpatname.Text != "")
            {
                PName = txtpatname.Text;
            }
            if (chkSmart.Checked == true)
            {
                flag = "Y";
            }

            StringBuilder sb = new StringBuilder();
            StringBuilder sbs = new StringBuilder();

            lstPatient = new List<Patient>();
            objReport_BL = new Report_BL(base.ContextInfo);
            objReport_BL.GetPatientDepositDetailsRpt(fromDate,ToDate,OrgID,PName,flag, out lstPatient);



            if (lstPatient.Count > 0)
            {
                tdnotfound.Visible = false;
                divPrint.Attributes.Add("style", "block");
                divPrint.Visible = true;
                gvDepositRpt.DataSource = lstPatient;
                gvDepositRpt.DataBind();
                if (Hdnsmartcard.Value == "N")
                {
                    gvDepositRpt.Columns[3].Visible = false;
                 //gvDepositRpt.HeaderRow.Cells[0].Visible = false;
                 //foreach (GridViewRow gvr in gvDepositRpt.Rows)
                 //   {
                 //    gvr.Cells[0].Visible = false;
                 //   }
                }
                
                gvDepositRpt.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                gvDepositRpt.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                gvDepositRpt.FooterRow.Cells[7].HorizontalAlign = HorizontalAlign.Right;
                gvDepositRpt.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Right;
                gvDepositRpt.FooterRow.Cells[9].HorizontalAlign = HorizontalAlign.Right;

                gvDepositRpt.FooterRow.Cells[1].Font.Bold = true;
                gvDepositRpt.FooterRow.Cells[6].Font.Bold = true;
                gvDepositRpt.FooterRow.Cells[7].Font.Bold = true;
                gvDepositRpt.FooterRow.Cells[8].Font.Bold = true;
                gvDepositRpt.FooterRow.Cells[9].Font.Bold = true;

                gvDepositRpt.FooterRow.Cells[1].Text = string.Concat("Total Patient: ",Convert.ToString(lstPatient.Count));
                gvDepositRpt.FooterRow.Cells[6].Text = lstPatient.FindAll(p => p.TotalDepositAmount != 0).Sum(p => p.TotalDepositAmount).ToString();
                gvDepositRpt.FooterRow.Cells[7].Text = lstPatient.FindAll(p => p.TotalDepositUsed != 0).Sum(p => p.TotalDepositUsed).ToString();
                gvDepositRpt.FooterRow.Cells[8].Text = lstPatient.FindAll(p => p.DepositBalance != 0).Sum(p => p.DepositBalance).ToString();
                gvDepositRpt.FooterRow.Cells[9].Text = lstPatient.FindAll(p => p.AmtRefund != 0).Sum(p => p.AmtRefund).ToString();

                DataTable dt = Loaddata(lstPatient);
                DataSet ds = new DataSet();
                ds.Tables.Add(dt);
                ViewState["report"] = ds;
            }

            else
            {

                tdnotfound.Visible = true;
                divPrint.Attributes.Add("style", "none");
                divPrint.Visible = false;
                gvDepositRpt.DataSource = null;
                gvDepositRpt.DataBind();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BindDuePaidReport", ex);
        }
   
    }

    public DataTable Loaddata(List<Patient> lstPatient)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol2 = new DataColumn("Name");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("SmartCardNumber");        
        DataColumn dcol5 = new DataColumn("ContactNumber");        
        DataColumn dcol6 = new DataColumn("Address");
        DataColumn dcol7 = new DataColumn("TotalDepositAmount");
        DataColumn dcol8 = new DataColumn("TotalDepositUsed");
        DataColumn dcol9 = new DataColumn("DepositBalance");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        if (Hdnsmartcard.Value == "Y")
        {
            dt.Columns.Add(dcol4);
        }
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
 
        foreach (Patient item in lstPatient)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientNumber;
            dr["Name"] = item.Name;
            dr["Age"] = item.Age;
            if (Hdnsmartcard.Value == "Y")
            {
                dr["SmartCardNumber"] = item.SmartCardNumber;
            }
            dr["ContactNumber"] = item.MobileNumber;            
            dr["Address"] = item.Address;            
            dr["TotalDepositAmount"] = item.TotalDepositAmount;
            dr["TotalDepositUsed"] = item.TotalDepositUsed;
            dr["DepositBalance"] = item.DepositBalance;         
            dt.Rows.Add(dr);
        }
        return dt;
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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "PatientDepositDetails_Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First You have to click the Get report');", true);
            }
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, Patient Deposit", ex);
        }
    }
    protected void gvDepositRpt_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvDepositRpt.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvDuepaidReport_PageIndexChanging", ex);
        }
    }
    protected void gvDepositRpt_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient lstPatient = new Patient();
                StockMovementSummary inv = new StockMovementSummary();
                lstPatient = (Patient)e.Row.DataItem;
                HyperLink lbtnName = (HyperLink)e.Row.FindControl("hypName");
                if (lstPatient.PatientID > 0)
                {
                    
                    string PID =Convert.ToString(lstPatient.PatientID);
                    string ORGID = Convert.ToString(lstPatient.OrgID);

                    lbtnName.ToolTip = "Click Here To Print the " + lstPatient.Name + " Deposit Details";
                    lbtnName.NavigateUrl = "PatientWiseDepositReport.aspx?PID=" + PID + "&ORGID=" + OrgID;
                }               
            }
           

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DueReport, gvDepositRpt_RowDataBound", ex);
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
   
}
