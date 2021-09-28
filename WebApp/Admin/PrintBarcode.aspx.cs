using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using System.Text;
using System.Drawing;
using Attune.Utilitie.Helper;



public partial class Admin_PrintBarcode : BasePage 
{

   
    string lstVisitId = string.Empty;
    long BillId = -1;
    string lstSampleId = string.Empty;
    int OrgId = 0;
    string CategoryCode = string.Empty;
    long returncode = -1;
    string IsReprint = string.Empty;
    long Lid = -1;
    int ILocationID = 0;
     decimal NumOfBarCode = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           
            if (!String.IsNullOrEmpty(Request.QueryString["orgId"]))
            {
                Int32.TryParse(Request.QueryString["orgId"], out OrgId);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["visitId"]))
            {
                lstVisitId = Convert.ToString(Request.QueryString["visitId"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["sampleId"]))
            {
                lstSampleId = Convert.ToString(Request.QueryString["sampleId"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["billId"]))
            {
                Int64.TryParse(Request.QueryString["billId"], out BillId);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["categoryCode"]))
            {
                CategoryCode = Convert.ToString(Request.QueryString["categoryCode"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["IsReprint"]))
            {
                IsReprint = Convert.ToString(Request.QueryString["IsReprint"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["LID"]))
            {
                Lid = Convert.ToInt64(Request.QueryString["LID"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["ILocationID"]))
            {
                ILocationID = Convert.ToInt32(Request.QueryString["ILocationID"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["NoBCode"]))
            {
                NumOfBarCode = Convert.ToDecimal(Request.QueryString["NoBCode"]);
            }
            List<String> lstQueryString = new List<String>();
            BarcodeHelper objBarcodeHelper = new BarcodeHelper();
            List<BarcodeAttributes> lstBarcodeAttributes = new List<BarcodeAttributes>();
            List<BarcodeAttributes> lstBarcodeAttributesTRF = new List<BarcodeAttributes>();

            returncode = objBarcodeHelper.GetBarcodeQueryString(OrgId, lstVisitId, lstSampleId, BillId, CategoryCode, out lstBarcodeAttributes);
            if (lstBarcodeAttributes.Count > 0)
            /* Comment By GURUNATH S */
            {
                /* Added By GURUNATH S */
                /* Print Declaration Part */
                bool isTRF = false;
                string isTRFPrint = IsReprint == "Y" ? "N" : "Y"; 
                StringBuilder objStrHTML = new StringBuilder();
                string StartTag = " ";
                string EndTag = " ";
                string pageBreak = "<p style=\"page-break-before:always\"></p>";
                int Containerwidth = -1;
                int Containerheight = -1;
                Containerwidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                Containerheight = Convert.ToInt32(lstBarcodeAttributes[0].Height);
                string HeaderFontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                int HeaderFontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                string FooterFontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                int FooterFontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                int BarcodeHeight = -1;
                int CountBreak = 0;
                int ImageWidth = -1;
                int ImageHeight = -1;
                string CreateTable = "<table border='0' cellpadding='0' cellspacing='0' width='" + Containerwidth + "px' height='" + Containerheight + "px'>";
                /* End Declaration */
                objStrHTML.Append(StartTag);
                CountBreak = lstBarcodeAttributes.Count;
                NumOfBarCode = NumOfBarCode == 0 ? -1 : NumOfBarCode;
                int m = 1;
                int NoOfPrint = 1;
                foreach (BarcodeAttributes objBAT in lstBarcodeAttributes)
                {
                    if (NumOfBarCode < 0)
                    {
                        NoOfPrint = 2;
                    }
                    else
                    {
                        NoOfPrint = Convert.ToInt32(lstBarcodeAttributes[0].NoOfPrint);
                    }
                    for (m = 1; m < NoOfPrint; m++)
                    {
                        //---- Size of the Barcode Image 
                        Utilities objUtilities = new Utilities();
                        string KeyValue = string.Empty;
                        objUtilities.GetApplicationValue("BarCodeHeight", out KeyValue);
                        BarcodeHeight = Convert.ToInt32(KeyValue);
                        KeyValue = "";
                        objUtilities.GetApplicationValue("ImageWidth", out KeyValue);
                        ImageWidth = Convert.ToInt32(KeyValue);
                        KeyValue = "";
                        objUtilities.GetApplicationValue("ImageHeight", out KeyValue);
                        ImageHeight = Convert.ToInt32(KeyValue);
                        KeyValue = ""; 
                        //----
                        if (isTRFPrint == "Y" && isTRF == false)
                        {
                            objStrHTML.Append(CreateTable);
                            returncode = objBarcodeHelper.GetBarcodeQueryString(OrgId, lstVisitId, lstSampleId, BillId, "TRF", out lstBarcodeAttributesTRF);

                            foreach (BarcodeAttributes objBATTRF in lstBarcodeAttributesTRF)
                            {
                                if (String.IsNullOrEmpty(objBATTRF.LeftVertical))
                                {
                                    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBATTRF.HeaderLine1.ToUpper() + "</td></tr>");
                                    objStrHTML.Append("<tr><td align='center'>" + "<img style='width:" + ImageWidth.ToString() + "px;height:" + ImageHeight.ToString() + "px' src='../admin/BarcodeHandler.ashx?barcodeno=" + objBATTRF.BarcodeNumber + "&barCodeType=Image&width=" + Containerwidth + "&height=" + BarcodeHeight + "'/>" + "</td></tr>");
                                    objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBATTRF.BarcodeNumber + "&nbsp;" + objBATTRF.FooterLine1.ToUpper() + "</td></tr>");

                                }
                            }
                            objStrHTML.Append("</table>");
                            objStrHTML.Append(pageBreak);
                            isTRF = true;
                        }
                        objStrHTML.Append(CreateTable);

                        if (String.IsNullOrEmpty(objBAT.LeftVertical))
                        {
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.HeaderLine1.ToUpper() + objBAT.HeaderLine2.ToUpper() + "</td></tr>");
                            objStrHTML.Append("<tr><td align='center'>" + "<img style='width:" + ImageWidth.ToString() + "px;height:" + ImageHeight.ToString() + "px' src='../admin/BarcodeHandler.ashx?barcodeno=" + objBAT.BarcodeNumber + "&barCodeType=Image&width=" + Containerwidth + "&height=" + BarcodeHeight + "'/>" + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.FooterLine1.ToUpper() + objBAT.FooterLine2.ToUpper() + "</td></tr>");
                        }
                        else
                        {
                            objStrHTML.Append("<tr><td rowspan='3' align='left' style='width:20px;vertical-align:middle;'>" + "<img  src='../admin/BarcodeHandler.ashx?vertical=true&text=" + objBAT.LeftVertical + "&width=" + 15 + "&height=" + (Containerheight - 5) + "'/>" + "</td><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.HeaderLine1.ToUpper() + objBAT.HeaderLine2.ToUpper() + "</td></tr>");
                            objStrHTML.Append("<tr><td align='center'>" + "<img style='width:" + ImageWidth.ToString() + "px;height:" + ImageHeight.ToString() + "px' src='../admin/BarcodeHandler.ashx?barcodeno=" + objBAT.BarcodeNumber + "&barCodeType=Image&width=" + Containerwidth + "&height=" + BarcodeHeight + "'/>" + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.FooterLine1.ToUpper() + objBAT.FooterLine2.ToUpper() + "</td></tr>");
                        }
                        objStrHTML.Append("</table>");
                        if (CountBreak < lstBarcodeAttributes.Count)
                            objStrHTML.Append(pageBreak);
                    }
                }
                objStrHTML.Append(EndTag);
                divPrint.InnerHtml = "";
                divPrint.InnerHtml = objStrHTML.ToString();
                /* -------Code End -------- */
                if (IsReprint == "Y")
                {
                    long returnRes;
                    GateWay  gateWay = new GateWay(base.ContextInfo);
                    List<Config> lstConfig = new List<Config>();
                    returnRes = gateWay.GetConfigDetails("AuditReprintBarcode", OrgId, out lstConfig);
                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        ReprintBarcodeAudit();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "Print", "SilentPrint()", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Print", "window.close();", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in barcode generator on page_load", ex);
        }
    }      

    public void ReprintBarcodeAudit()
    {

        long ReturnCode = -1;
        AuditTransactionDetails obj;
        List<AuditTransactionDetails> ATD = new List<AuditTransactionDetails>();
        try
        {
            string[] lstVisit = lstVisitId.Split(',');
            foreach (string VisitId in lstVisit)
            {
                obj = new AuditTransactionDetails();
                obj.AttributeID = Convert.ToInt64(VisitId);
                obj.AttributeName = AuditManager.AuditAttribute.Visit;
                obj.CreatedBy = Lid;
                ATD.Add(obj);
            }

            obj = new AuditTransactionDetails();
            obj.AttributeID = Convert.ToInt64(lstSampleId);
            obj.AttributeName = AuditManager.AuditAttribute.SampleId;
            obj.CreatedBy = Lid;
            ATD.Add(obj);
            ReturnCode = new AuditManager_BL(base.ContextInfo).InsertAuditTransactions(ATD, AuditManager.AuditCategoryCode.ReprintBarcode, AuditManager.AuditTypeCode.Print, Lid, OrgId, ILocationID);
        }

        catch (Exception s)
        {
            CLogger.LogError("Error while Saving ReprintBarcode in  Lab_PendingSampleCollection Page ", s);
        }

    }
}
