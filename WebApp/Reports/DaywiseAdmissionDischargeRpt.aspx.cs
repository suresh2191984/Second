using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.Collections;
using System.IO;
using System.Text;



public partial class Reports_DaywiseAdmissionDischargeRpt : BasePage 
{

    long returnCode = -1;
    DataSet ds = new DataSet();
    string status ;
    DateTime fDate ;
    DateTime tDate ;
    
    List<DayWiseCollectionReport> lstDWADR = new List<DayWiseCollectionReport>();
    string ViewOption = string.Empty;
    string paymentoption = string.Empty;
    private  enum StaticColumns
    {
        PatientID,
        PatientName,
        VisitState,
        DoAdmission,
        DoDischargeDT,
    };
    protected void Page_Load(object sender, EventArgs e)
    {
        ViewOption = ddlselect.SelectedItem.Text.ToString();
        //rblReportType.Visible = false;
        //chkcash.Visible = false;
        //chkiscredit.Visible = false;
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
      //  ddlselect.Attributes.Add("onchange", "rblhide()");
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        //rblReportType.Visible = true;
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
          //  getReportColumns();
           
            gvOP.Visible = false;
            gvIPCreditMain.Visible = false;
            
        }
        if (IsPostBack)
        {
            if (ViewOption == "OP")
            {
                rblReportType.Visible = false;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hiderdo", "javascript:rblhide();", true);
            }
            else
            {
                rblReportType.Visible = true;
            }
        }
       
     }

    
    protected void btnSubmit_Click(object sender, EventArgs e)
     {
         try
         {

             ViewOption = ddlselect.SelectedItem.Text.ToString();

             // string status = ddlselect.SelectedItem.Text;
             DateTime fDate = Convert.ToDateTime(txtFDate.Text);
             DateTime tDate = Convert.ToDateTime(txtTDate.Text);
             List<DayWiseCollectionReport> lstDWADR = new List<DayWiseCollectionReport>();

             if (ViewOption == "OP")
             {

                 // rblReportType.Visible = false;
                 status = "OP Visit";

                 gvIPCreditMain.Visible = false;
                 //rblReportType.Visible = false;
                 Rbltypeofpatient.Visible = false;
                 //rdocash.Visible = false;
                 //rdocredit.Visible = false;
                 //rdoboth.Visible = false;
                 gvOP.Visible = true;
                 returnCode = new Report_BL(base.ContextInfo).GetDaywiseAdmissionDischargeRpt(fDate, tDate, OrgID, status, out lstDWADR);


                 //DataTable dtop;
                 //Utilities.ConvertFrom(lstDWADR, out dtop);
                 if (lstDWADR.Count > 0)
                 {
                     gvOP.DataSource = lstDWADR;
                     gvOP.DataBind();

                     //  ViewState["report"] = lstDWADR;
                     //hdnXLFlag.Value = "1";

                     // gvOP.Visible = true;

                 }
                 else
                 {
                     gvOP.DataSource = null;
                     gvOP.DataBind();
                     //ViewState.Remove("report");
                     ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                     // hdnXLFlag.Value = "0";
                 }

             }

             else
             {

                 if (ViewOption == "IP")
                 {
                     Rbltypeofpatient.Visible = true;
                     //rdocash.Visible = true;
                     //rdocredit.Visible = true;
                     //rdoboth.Visible = true;
                     gvOP.Visible = false;
                     gvIPCreditMain.Visible = true;
                     //rblReportType.Visible = true;
                     status = " ";

                     //{
                     returnCode = new Report_BL(base.ContextInfo).GetDaywiseAdmissionDischargeRpt(fDate, tDate, OrgID, status, out lstDWADR);

                     //DataTable dtIP;
                     //Utilities.ConvertFrom(lstDWADR, out dtIP);

                     if (lstDWADR.Count > 0)
                     {
                         var temp = lstDWADR;
                            if (rblReportType.SelectedItem.Text == "Admitted")
                            {
                            temp = lstDWADR.FindAll(p => p.VisitState == "Admitted").ToList();
                            }
                            else if (rblReportType.SelectedItem.Text == "Discharged")
                            {
                            temp = lstDWADR.FindAll(p => p.VisitState == "Discharged").ToList();
                            }
                            else if (rblReportType.SelectedItem.Text == "Both")
                            {
                                temp = lstDWADR.FindAll(p => p.VisitState == "Admitted" || p.VisitState =="Discharged" ).ToList();
                            }
                            else
                            {
                            }
                             if (Rbltypeofpatient.SelectedItem.Value == "Creditandcash")
                             {
                                 temp = temp.FindAll(p => p.IsCreditBill == "Y" || p.IsCreditBill == "N").ToList();
                             
                             }


                             else if (Rbltypeofpatient.SelectedItem.Value == "Credit")
                             {

                                 temp = temp.FindAll(p => p.IsCreditBill == "Y").ToList();

                              
                             }

                             else if (Rbltypeofpatient.SelectedItem.Value == "Cash")
                             {

                                 temp = temp.FindAll(p => p.IsCreditBill == "N").ToList();
                               
                             }
                             gvIPCreditMain.DataSource = temp;
                             gvIPCreditMain.DataBind();
                     }


                     else
                     {
                         gvIPCreditMain.DataSource = null;
                         gvIPCreditMain.DataBind();
                         //ViewState.Remove("report");
                         ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                         //hdnXLFlag.Value = "0";
                     }
                 }
             }
         }




         catch (Exception ex)
         {
             CLogger.LogError("Error in Get DaywiseAdmissionDischarge Report, ", ex);
         }

        }

        
    
    protected void rblReportType_SelectedIndexChanged(object sender, EventArgs e)
    {

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
         if (ddlselect.SelectedItem.Text == "OP")
         {
             ExportToExcel(gvOP);
         }
         else
         {
             ExportToExcel(gvIPCreditMain);
         }

     }
     public void ExportToExcel(Control CTRl)
     {
          HttpContext.Current.Response.Clear();
         HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "DaywiseAdmissionDischargereport.xls"));
         HttpContext.Current.Response.ContentType = "application/ms-excel";
         using (StringWriter sw = new StringWriter())
         {
             using (HtmlTextWriter htw = new HtmlTextWriter(sw))
             {
                 CTRl.RenderControl(htw);
                 //gvIPCreditMain.RenderEndTag(htw);
                 HttpContext.Current.Response.Write(sw.ToString());
                 HttpContext.Current.Response.End();

                               
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
                     string chkValue = chkitem.Value.ToString();
                     arrayCheckedItem.Add(chkValue);
                 }
             }

             foreach (ListItem chkitem in ChkLstColumns1.Items)
             {

                 if (chkitem.Selected == true)
                 {
                     string chkValue = chkitem.Value.ToString();
                     arrayCheckedItem.Add(chkValue);
                 }
             }

             foreach (ListItem chkitem in ChkLstColumns2.Items)
             {

                 if (chkitem.Selected == true)
                 {
                     string chkValue = chkitem.Value.ToString();
                     arrayCheckedItem.Add(chkValue);
                 }
             }


             for (int j = 0; gvIPCreditMain.Columns.Count > j; j++)
             {
                 if (gvIPCreditMain.Columns[j].HeaderText != "Patient No" && gvIPCreditMain.Columns[j].HeaderText != "Name" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Age" && gvIPCreditMain.Columns[j].HeaderText != "Bill No" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Bill Date" && gvIPCreditMain.Columns[j].HeaderText != "DOA" &&
                     gvIPCreditMain.Columns[j].HeaderText != "DOD" && gvIPCreditMain.Columns[j].HeaderText != "GrossBill" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Discount" && gvIPCreditMain.Columns[j].HeaderText != "TaxAmount" &&
                     gvIPCreditMain.Columns[j].HeaderText != "ServiceCharge" && gvIPCreditMain.Columns[j].HeaderText != "NetValue" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Received Amount" && gvIPCreditMain.Columns[j].HeaderText != "Advance" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Due" && gvIPCreditMain.Columns[j].HeaderText != "AdvanceInHand" &&
                     gvIPCreditMain.Columns[j].HeaderText != "Refund" && gvIPCreditMain.Columns[j].HeaderText != "IsCreditBill") 
                 {
                     if (arrayCheckedItem.Contains(gvIPCreditMain.Columns[j].HeaderText))
                     {
                         gvIPCreditMain.Columns[j].Visible = true;
                     }
                     else
                     {
                         gvIPCreditMain.Columns[j].Visible = false;
                     }
                 }
             }
           //  btnSubmit_Click(this,e);
           
         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in DynamicColumnMapping", ex);
         }
     }
            
           
     public override void VerifyRenderingInServerForm(Control control)
     {

     }
}
    
    






 