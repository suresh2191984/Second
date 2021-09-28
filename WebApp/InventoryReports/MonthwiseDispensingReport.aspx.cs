using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_MonthwiseDispensingReport : Attune_BasePage
{
    List<ProductMonthWise> LstProdUctMonthWise = new List<ProductMonthWise>();
    List<Patient> LstProductPatient = new List<Patient>();
    public InventoryReports_MonthwiseDispensingReport()
        : base("InventoryReports_MonthwiseDispensingReport_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "CLIENT" + "~0~" + "0";
            // AutoCompleteExtender1.ContextKey = "CLI~";
            LoadLocation();
            txtDisFMon.Text = DateTimeUtility.GetServerDate().ToString("MM/yyyy");
            if (Request.QueryString["IsPrintout"] != null)
            {
                trSelect.Visible = false;
                TrSecondRow.Visible = false;
                LoadData(-1);

            }
            else if (Request.QueryString["PID"] != null)
            {
                LoadData(0);
            }

        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        LoadData(0);
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        LoadData(-2);
    }

    public void ExportToExcel()
    {
        try
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=PharmacyDispensingMonthWiseReport.xls");
            Response.ContentType = "application/vnd.ms-excel";
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            trSelect.Visible = false;
            TrSecondRow.Visible = false;
            divcontentdata.RenderControl(oHtmlTextWriter);
            Response.Output.Write(oStringWriter.ToString());
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.Flush();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Pharmacy Month Wise DispensingReport - Export To Excel", ioe);
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblDate = (Label)e.Row.FindControl("lblDate");
                lblDate.Text = DateTimeUtility.GetServerDate().ToString("dd/MM/yyyy");

                Label lblMonth = (Label)e.Row.FindControl("lblMonth");
                DateTime Month;
                Month = Convert.ToDateTime(txtDisFMon.Text);
                lblMonth.Text = Month.ToString("MMM-yyyy");
                HiddenField hdnFinalBillId = (HiddenField)e.Row.FindControl("hdnFinalBillId");
                List<ProductMonthWise> childItems = (from child in LstProdUctMonthWise
                                                     where child.FinalBillID.ToString() == hdnFinalBillId.Value
                                                     select child).ToList();
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Pharmacy Month Wise DispensingReport -Load Data", ioe);
        }
    }

    private void LoadData(int Index)
    {

        try
        {

            DateTime objDate;
            long PatientID = 0, VisitID = 0;
            string VisitState = string.Empty;
            if (Request.QueryString["PID"] != null && Request.QueryString["VID"] != null)
            {
                Int64.TryParse(Request.QueryString["PID"], out PatientID);
                Int64.TryParse(Request.QueryString["VID"], out VisitID);
            }

            if (Index >= 0)
            {
                objDate = Convert.ToDateTime(txtDisFMon.Text);
                gvIPReport.PageIndex = Index;
            }
            else
            {
                gvIPReport.AllowPaging = false;
                if (Request.QueryString["IsMonth"] != null)
                {
                    objDate = Convert.ToDateTime(Request.QueryString["IsMonth"]);
                    txtDisFMon.Text = objDate.ToString("MM/yyyy");
                }
                else
                {
                    objDate = Convert.ToDateTime(txtDisFMon.Text);
                }

                if (Request.QueryString["FromDate"] != null)
                {
                    txtFromDate.Text = Request.QueryString["FromDate"].ToString();
                }
                if (Request.QueryString["ToDate"] != null)
                {
                    txtToDate.Text = Request.QueryString["ToDate"].ToString();
                }
                if (Request.QueryString["PatientNumber"] != null)
                {
                    txtPatientNumber.Text = Request.QueryString["PatientNumber"].ToString();
                }

                if (Request.QueryString["PatientName"] != null)
                {
                    txtPatientName.Text = Request.QueryString["PatientName"].ToString();
                }
                if (Request.QueryString["ClientID"] != null)
                {
                    HdnClientID.Value = Request.QueryString["ClientID"].ToString();
                }
                if (Request.QueryString["LocationID"] != null)
                {
                    ddlLocation.SelectedValue = Request.QueryString["LocationID"].ToString();
                }

            }
            VisitState = ddlStatus.SelectedIndex > 0 ? ddlStatus.SelectedValue : "";
            new InventoryReports_BL(base.ContextInfo).GetMonthWiseProductReport(objDate, Convert.ToInt64(HdnClientID.Value), txtPatientName.Text,
                txtPatientNumber.Text, PatientID, VisitID, Convert.ToInt32(ddlLocation.SelectedValue), txtFromDate.Text, txtToDate.Text, VisitState, out LstProdUctMonthWise, out LstProductPatient);
            gvIPReport.DataSource = LstProductPatient;
            gvIPReport.DataBind();

            if (Index == -2)
                ExportToExcel();

            if (Index == 0)
            {
                Session["Patient"] = LstProductPatient;
                Session["ProdUctMonthWise"] = LstProdUctMonthWise;
            }
            HdnClientID.Value = "0";
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Pharmacy Month Wise DispensingReport -Load Data", ioe);
        }
    }

    protected string NumberConvert(object Col1, object Col2, object Col3, object Col4, object Col5, object Col6, object Col7, object Col8, object Col9, object Col10,
       object Col11, object Col12, object Col13, object Col14, object Col15, object Col16, object Col17, object Col18, object Col19, object Col20,
        object Col21, object Col22, object Col23, object Col24, object Col25, object Col26, object Col27, object Col28, object Col29, object Col30, object Col31
        )
    {
        decimal c = 0;
        c = (decimal)Col1 + (decimal)Col2 + (decimal)Col3 + (decimal)Col4 + (decimal)Col5 + (decimal)Col6 + (decimal)Col7 + (decimal)Col8 + (decimal)Col9 + (decimal)Col10 +
            (decimal)Col11 + (decimal)Col12 + (decimal)Col13 + (decimal)Col14 + (decimal)Col15 + (decimal)Col16 + (decimal)Col17 + (decimal)Col18 + (decimal)Col19 + (decimal)Col20 +
            (decimal)Col21 + (decimal)Col22 + (decimal)Col23 + (decimal)Col24 + (decimal)Col25 + (decimal)Col26 + (decimal)Col27 + (decimal)Col28 + (decimal)Col29 + (decimal)Col30 + (decimal)Col31;

        return c.ToString("0.00");
    }

    private void LoadLocation()
    {
        InventoryCommon_BL InventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<Locations> lstInvLocation = new List<Locations>();
        new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, 0, out lstInvLocation);
        if (lstInvLocation.Count > 0)
        {

            ddlLocation.DataSource = lstInvLocation;
            ddlLocation.DataTextField = "OrgAddressName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
            ddlLocation.Items[0].Value = "0";
        }
    }

    protected void gvIPReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (Session["Patient"] != null)
        {

            LstProductPatient = (List<Patient>)Session["Patient"];
            LstProdUctMonthWise = (List<ProductMonthWise>)Session["ProdUctMonthWise"];

            gvIPReport.DataSource = LstProductPatient;
            gvIPReport.PageIndex = e.NewPageIndex;
            gvIPReport.DataBind();

        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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
}

