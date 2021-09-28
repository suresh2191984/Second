using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Data.SqlClient;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.IO;

public partial class ReportsLims_HistopathDetailExaminationreport : BasePage
{
      long returnCode = -1;


      public ReportsLims_HistopathDetailExaminationreport()
          : base("ReportsLims_HistopathDetailExaminationreport")
    {
    }

      protected void page_Init(object sender, EventArgs e)
      {
          base.page_Init(sender, e);
      }
      protected void Page_Load(object sender, EventArgs e)
      {
          DateTime Fdate;
          DateTime TDate;
          txtFDate.Attributes.Add("onchange", "validateFrom('" + txtFDate.ClientID.ToString() + "','" + txtTDate.ClientID.ToString() + "');");
          txtTDate.Attributes.Add("onchange", "ValidDate('" + txtFDate.ClientID.ToString() + "','" + txtTDate.ClientID.ToString() + "','txtFDate',0,0);");
          if (!IsPostBack)
          {

              Fdate = DateTime.Parse(OrgDateTimeZone.ToString());
              TDate = DateTime.Parse(OrgDateTimeZone.ToString());
              txtFDate.Text = Convert.ToString(Fdate.ToString("dd/MM/yyyy"));
              txtTDate.Text = Convert.ToString(TDate.ToString("dd/MM/yyyy"));


          }
      }



      protected void btnSubmit_Click(object sender, EventArgs e)
      {

          LoadGrid();
      }

      public void LoadGrid()
      {

          returnCode = -1;

          try
          {
              string VisitNo = string.Empty;
              string HistoNo = string.Empty;
              string Specimen = string.Empty;
              string IsMalignant = string.Empty;
              string PatientNo = string.Empty;
              string PatientName = string.Empty;
              string Impression = string.Empty;
              string WhoClassification = string.Empty;
              string Staging = string.Empty;
              string Grading = string.Empty;
              long TestID =0;


              Report_BL Invbl = new Report_BL(base.ContextInfo);
              List<HistopathexaminationReport> lsthisto = new List<HistopathexaminationReport>();
              DateTime fromdate = Convert.ToDateTime(txtFDate.Text);
              DateTime todate = Convert.ToDateTime(txtTDate.Text);

              if (txtvisitno.Text != "")
              {
                  VisitNo = txtvisitno.Text;
              }

              if (txtHistono.Text != "")
              {
                  HistoNo = txtHistono.Text;
              }
              if (txtSpecimen.Text != "")
              {
                  Specimen = txtSpecimen.Text;
              }
              if (txtPatientNo.Text != "")
              {
                  PatientNo = txtPatientNo.Text;
              }
              if (txtPName.Text != "")
              {

                  PatientName = txtPName.Text;
              }
              if (txtImpression.Text != "")
              {

                  Impression = txtImpression.Text;
              }
              if (txtStaging.Text != "")
              {

                  Staging = txtStaging.Text;
              }
              if (txtGrading.Text != "")
              {
                  Grading = txtGrading.Text;
              }
              if (txtTestName.Text != "")
              {
                  TestID = Convert.ToInt64(hdnTestID.Value);
              }
              if (txtmalignant.Text != "")
              {
                  IsMalignant = txtmalignant.Text;
              }
              if (txtWHO.Text != "")
              {
                  WhoClassification = txtWHO.Text;
              }

              returnCode = Invbl.GetHistoDetailedReport(fromdate,todate,PatientNo,PatientName,VisitNo,HistoNo,Specimen,TestID,Impression,IsMalignant,WhoClassification,Staging,Grading,out lsthisto);
              if (lsthisto.Count > 0)
              {
                  grdHistoReport.DataSource = lsthisto;
                  grdHistoReport.DataBind();
                  Excel.Attributes.Add("style", "display:Block");
                  pnl.Attributes.Add("style", "display:Block");
                  //txtSpecimen.Text = "";
                  //txtHistono.Text = "";
                  //txtvisitno.Text = "";
                  //txtTestName.Text = "";
                  //txtImpression.Text = "";
                  //txtWHO.Text = "";
                  //txtStaging.Text = "";
                  //txtGrading.Text = "";
                  //hdnspecimenid.Value = "";
                  //hdnspecimenname.Value = "";
                  hdnTestID.Value = "0";
              }
              else
              {
                  grdHistoReport.DataSource = null;
                  grdHistoReport.DataBind();
                  Excel.Attributes.Add("style", "display:none");
                  pnl.Attributes.Add("style", "display:none");
                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('No Matching Records Found!');", true);
                  //txtSpecimen.Text = "";
                  //txtHistono.Text = "";
                  //txtvisitno.Text = "";
                  //txtTestName.Text = "";
                  //txtImpression.Text = "";
                  //txtWHO.Text = "";
                  //txtStaging.Text = "";
                  //txtGrading.Text = "";
                  //hdnspecimenid.Value = "";
                  //hdnspecimenname.Value = "";
                  hdnTestID.Value = "0";
              }

          }
          catch (Exception ex)
          {
              CLogger.LogError("Error while Redirecting to Gird", ex);
          }

      }

      protected void lnkBack_Click(object sender, EventArgs e)
      {
          try
          {
              Response.Redirect("..//Reports//ViewReportList.aspx", true);
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

      protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
      {
          ExportToExcel();
      }

      public void ExportToExcel()
      {
          try
          {
              string str = "Histopathology Examination Detailed Report";
              string FromDate = txtFDate.Text;
              string ToDate = txtTDate.Text;
              string prefix = string.Empty;
              prefix = str + "_";
              string rptDate = prefix + FromDate + " to " + ToDate;
              string attachment = "attachment; filename=" + rptDate + ".xls";
              Response.ClearContent();
              Response.AddHeader("content-disposition", attachment);
              Response.ContentType = "application/ms-excel";
              Response.Charset = "";
              this.EnableViewState = false;
              StringWriter sw = new StringWriter();
              HtmlTextWriter htw = new HtmlTextWriter(sw);
              LoadGrid();
              //  grdResult.AllowPaging = false;
              //   grdResult.DataBind();

              //Applying stlye to gridview header cells
              for (int i = 0; i < grdHistoReport.HeaderRow.Cells.Count; i++)
              {
                  grdHistoReport.HeaderRow.Cells[i].Style.Add("background-color", "#80CCD8");
              }
              int j = 1;
              //This loop is used to apply stlye to cells based on particular row
              foreach (GridViewRow gvrow in grdHistoReport.Rows)
              {
                  gvrow.BackColor = Color.White;
                  gvrow.Attributes.Add("class", "textmode");
                  if (j <= grdHistoReport.Rows.Count)
                  {
                      if (j % 2 != 0)
                      {
                          for (int k = 0; k < gvrow.Cells.Count; k++)
                          {
                              gvrow.Cells[k].Style.Add("background-color", "#FFFFFF");
                          }
                      }
                  }
                  j++;
              }
              htw.WriteLine("<span style='font-size:14.0pt; color:#E54C70;font-weight:500;font-weight: bold;'>" + rptDate + " </span>");
              grdHistoReport.RenderControl(htw);
              string style = @"<style> .textmode { mso-number-format:\@; } </style>";
              Response.Write(style);
              Response.Output.Write(sw.ToString());
              sw.Close();
              htw.Close();
              Response.End();
          }

          catch (Exception ex)
          {
              CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
          }
          finally
          {

          }
      }
      public override void VerifyRenderingInServerForm(Control control)
      {

      }
}
