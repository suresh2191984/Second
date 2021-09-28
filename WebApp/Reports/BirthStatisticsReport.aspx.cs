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

public partial class Reports_BirthStatisticsReport : BasePage
{
    long returnCode = -1;
    List<Patient> lstDWCR = new List<Patient>();
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

            List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
            List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
            List<DeliveryTypeMaster> lstDeliveryTypeMaster = new List<DeliveryTypeMaster>();

            List<Physician> lstDeliveringObstretician = new List<Physician>();
            List<Physician> lstNeonatologist = new List<Physician>();
            List<FetalPresentations> lstFetalPresentations = new List<FetalPresentations>();

            returnCode = new Neonatal_BL(base.ContextInfo).GetDeliveryNotesData(OrgID, out lstSurgeryType, out lstAnesthesiaType, out lstDeliveryTypeMaster, out lstDeliveringObstretician, out lstNeonatologist, out lstFetalPresentations);

            if (lstDeliveryTypeMaster.Count > 0)
            {
                ddlDeliveryTypeName.DataSource = lstDeliveryTypeMaster;
                ddlDeliveryTypeName.DataTextField = "DeliveryTypeName";
                ddlDeliveryTypeName.DataValueField = "DeliveryTypeID";
                ddlDeliveryTypeName.DataBind();
                ddlDeliveryTypeName.Items.Insert(0, "--- Select ---");
            }

            if (lstSurgeryType.Count > 0)
            {
                ddlProcedureType.DataSource = lstSurgeryType;
                ddlProcedureType.DataTextField = "TypeName";
                ddlProcedureType.DataValueField = "SurgeryTypeID";
                ddlProcedureType.DataBind();
                ddlProcedureType.Items.Insert(0, "--- Select ---");
            }

            if (lstDeliveringObstretician.Count > 0)
            {
                ddlObstretician.DataSource = lstDeliveringObstretician;
                ddlObstretician.DataTextField = "PhysicianName";
                ddlObstretician.DataValueField = "PhysicianID";
                ddlObstretician.DataBind();
                ddlObstretician.Items.Insert(0, "--- Select ---");
            }

            if (Request.QueryString["status"] == "Birth")
            {
                rblReportType.SelectedValue = "1";
                rblSex.SelectedValue = "BOTH";
                btnSubmit_Click(sender, e);
            }
        }
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
           
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<Patient> lstpatient = new List<Patient>();
                Patient RMaster = (Patient)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;
                lstpatient = childItems.ToList();
                DataTable dt = loaddata(lstpatient);
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
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }
    public DataTable loaddata(List<Patient> patient)
    {
        DataTable dt = new DataTable();

        DataColumn dcol1 = new DataColumn("PatientID");
        DataColumn dcol2 = new DataColumn("Name");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("BabyName");
        DataColumn dcol5 = new DataColumn("SEX");
        DataColumn dcol6 = new DataColumn("ProcedureType");
        DataColumn dcol7 = new DataColumn("DeliveryTypeName");
        DataColumn dcol8 = new DataColumn("Obstretrician");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);        
        foreach (Patient item in patient)
        {
            DataRow dr = dt.NewRow();
            dr["PatientID"] = item.PatientID;
            dr["Name"] = item.Name;
            dr["Age"] = item.Age;
            dr["BabyName"] = item.BabyName;
            dr["SEX"] = item.SEX;
            dr["ProcedureType"] = item.ProcedureType;
            dr["DeliveryTypeName"] = item.DeliveryTypeName;
            dr["Obstretrician"] = item.Obstretrician;           
            dt.Rows.Add(dr);
        }        
        return dt;        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sb = new StringBuilder();            
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string pFilter = string.Empty;

            int pProType = (ddlProcedureType.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt32(ddlProcedureType.SelectedValue);
            int pDeliveryType = (ddlDeliveryTypeName.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt32(ddlDeliveryTypeName.SelectedValue);
            long phyID = (ddlObstretician.SelectedValue == "--- Select ---") ? 0 : Convert.ToInt64(ddlObstretician.SelectedValue);

            returnCode = new Report_BL(base.ContextInfo).GetBirthStatisticsReport(fDate, tDate, OrgID, phyID, pProType, pDeliveryType, rblSex.SelectedValue.ToString(), out lstDWCR);
          
            
            var dwcr = (from dw in lstDWCR
                        select new { dw.VisitDate }).Distinct();

            List<Patient> lstBirthStatRept = new List<Patient>();
            int i = 0;
            foreach (var obj in dwcr)
            {
                Patient pdc = new Patient();
                pdc.VisitDate = obj.VisitDate;
                lstBirthStatRept.Add(pdc);
                i = i + 1;
            }
            // Code is written by Sankar
            var dwr = (from dr in lstDWCR
                       group dr by new { dr.TypeName} into info
                       select new
                       {
                           TypeName = info.Key.TypeName,                           
                           count = info.Count()
                       });
            sb.Append("<table border=" + 1 + ">");
            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("<b>");
            sb.Append("Statics");
            sb.Append("</b>");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append("<b>");
            sb.Append("Count");
            sb.Append("</b>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("<b>");
            sb.Append("Total Number of Birth(s):");
            sb.Append("</b>");
            sb.Append("</td>");
            sb.Append("<td>");            
            sb.Append(i);      
            sb.Append("</td>");
            sb.Append("</tr>");

            var drgender = (from dr in lstDWCR
                            group dr by new { dr.SEX } into info
                            select new
                            {
                                SEX = info.Key.SEX,
                                count = info.Count()
                            });

            foreach (var item in drgender)
            {
                sb.Append("<tr>");
                sb.Append("<td align=justify>");
                sb.Append("No. of ");
                sb.Append(item.SEX == "M" ? "Male" : "Female");
                sb.Append(" Births");
                sb.Append(":");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append(item.count);
                sb.Append("<br>");
                sb.Append("</td>");
                sb.Append("</tr>");
            }
            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("<b>");
            sb.Append("Type of Delivery");
            sb.Append("</b>");
            sb.Append("</td>");
            sb.Append("</tr>"); 
            foreach (var item in dwr)
            {                              
                sb.Append("<tr>");
                sb.Append("<td align=justify>"); 
                sb.Append("No. of ");
                sb.Append(item.TypeName);
                sb.Append(":");
                sb.Append("</td>");
                sb.Append("<td>"); 
                sb.Append(item.count);
                sb.Append("</td>");
                sb.Append("<br>");
                sb.Append("</tr>");
            }      
            var drtype = (from dr in lstDWCR
                       group dr by new { dr.ProcedureType} into info
                       select new
                       {                          
                           ProcedureType = info.Key.ProcedureType,                          
                           count = info.Count()
                       });
            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("<b>");
            sb.Append("Elective/Emergency");
            sb.Append("</b>");
            sb.Append("</td>");
            sb.Append("</tr>"); 
            foreach (var item in drtype)
            {
                sb.Append("<tr>");
                sb.Append("<td align=justify>");
                sb.Append("No. of ");
                sb.Append(item.ProcedureType);
                sb.Append(":");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append(item.count);
                sb.Append("</td>");
                sb.Append("<br>");
                sb.Append("</tr>");
            }            
            sb.Append("</table>");
            if (lstDWCR.Count > 0)
            {
                if (rblReportType.SelectedValue == "0")
                {
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    gvIPReport.Visible = false;
                    lblNewtable.Attributes.Add("style","display:block");
                    //tbl.Attributes.Add("Style","Display:none");
                    lblNewtable.Text = sb.ToString();
                }
                else
                {
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;
                    gvIPReport.Visible = true;                    
                    lblNewtable.Attributes.Add("Style", "Display:none");
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "Delivery and Birth Statistics Report";
                    gvIPReport.DataSource = lstBirthStatRept;
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
    protected void btnConverttoXL_Click1(object sender, ImageClickEventArgs e)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "Birth_Statics_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt!=null)
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
            CLogger.LogError("Error while Converting to Excel", ex);
        }
    }
}
