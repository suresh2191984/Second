using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;
public partial class Investigation_ReportPrinting : BasePage
{
   
    long visitNumber = -1;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtBarcode.Focus();
        }
    }




    //protected void btnProceed_Click(object sender, EventArgs e)
    //{
    //    long returnCode = -1;
    //    try
    //    {
    //        if (txtBarcode.Text != "")
    //        {
    //            visitNumber = Convert.ToInt64(txtBarcode.Text.Trim());



    //            List<ReportPrinting> lstReportPrinting = new List<ReportPrinting>();
    //            reportprintingbl = new ReportPrinting_BL(base.ContextInfo);
    //            returnCode = reportprintingbl.GetPatientDetailsVisitNumber(visitNumber, out lstReportPrinting);
    //            if (lstReportPrinting.Count > 0)
    //            {
    //                foreach (ReportPrinting item in lstReportPrinting)
    //                {
    //                    hdnPatientID.Value = item.PatientID.ToString();
    //                    hdnVisitID.Value = item.PatientVisitID.ToString();
    //                    hdnVisitNumber.Value = item.VisitNumber.ToString();
    //                    hdnOrgID.Value = item.OrganizationID.ToString();
    //                    hdnMobileNo.Value = item.MobileNumber.ToString();
    //                }
    //                divBarcodeNumber.Visible = false;
    //                divMobileNumber.Visible = true;

    //            }
    //            //else
    //            //{
    //            //    txtBarcode.Text = "";
    //            //    string AlertMessg = "Invalid Barcode. Please enter valid details";
    //            //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Report Printing", "alert('" + AlertMessg + "');", true);
    //            //}

    //        }
           
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}
    
    protected void btnContinue_Click(object sender, EventArgs e)
    {
      
            string RedirectURL = string.Empty;
            RedirectURL = "..\\Investigation\\ReportPrintingDetails.aspx?vid=" + hdnVisitID.Value + "&pid=" + hdnPatientID.Value + "&orgid=" + hdnOrgID.Value + "&visitnumber=" + hdnVisitNumber.Value + "&mobno=" + hdnMobileNo.Value + "";
            Response.Redirect(RedirectURL, true);
      
    }
  
}
