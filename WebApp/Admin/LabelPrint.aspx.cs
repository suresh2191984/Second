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

public partial class Admin_LabelPrint : BasePage 
{

    string Guid = string.Empty;
    long VisitId = -1;
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
                Int64.TryParse(Request.QueryString["visitId"], out VisitId);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["sampleId"]))
            {
                lstSampleId = Convert.ToString(Request.QueryString["sampleId"]);
            }
            if (!String.IsNullOrEmpty(Request.QueryString["guId"]))
            {
                Guid = Convert.ToString(Request.QueryString["guId"]);
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
            List<Patient> lstPatientDetails = new List<Patient>();
            CategoryCode="LabelPrint";
           // returncode = objBarcodeHelper.GetBarcodeQueryString(OrgId, VisitId, lstSampleId, BillId, CategoryCode, Guid, out lstBarcodeAttributes);
            returncode = objBarcodeHelper.GetLabelPrintDetails(OrgId, VisitId, "LabelPrint", Guid, out lstBarcodeAttributes, out lstPatientDetails);


            if (lstBarcodeAttributes.Count > 0 && lstPatientDetails.Count >0)
          {
                Font Font = new Font("Times New Roman", 10, FontStyle.Bold);
                      
                int HeaderCharLimit = -1;
                int FontHeight = -1;
                int FontSize = -1;
                string FontFamily = "";
                string  VisitDate=string.Empty;
                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                else
                    FontFamily = "Times New Roman";
                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                else
                    FontSize = 20;
                StringBuilder objStrHTML = new StringBuilder();
                string StartTag = " ";
                string EndTag = " ";
                string pageBreak = "<p style=\"page-break-before:always\"></p>";
                int Containerwidth = -1;
                int Containerheight = -1;
                Containerwidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                Containerheight = Convert.ToInt32(lstBarcodeAttributes[0].Height);
                string HeaderFontFamily = FontFamily;
                int HeaderFontSize = FontSize;
                string FooterFontFamily = FontFamily;
                int FooterFontSize = FontSize;
                int BarcodeHeight = -1;
                int CountBreak = 0;
                int ImageWidth = -1;
                int ImageHeight = -1;
                string CreateTable = "<table border='0' cellpadding='0' cellspacing='0' width='" + Containerwidth + "px' height='" + Containerheight + "px'>";
            
                //StartTag = CreateTable;
                objStrHTML.Append(StartTag);
                CountBreak = lstBarcodeAttributes.Count;
                NumOfBarCode = NumOfBarCode == 0 ? -1 : NumOfBarCode;
                int m = 1;
                int NoOfPrint = 1;
                foreach (Patient objBAT in lstPatientDetails)
                {
                   
                    if (NumOfBarCode < 0)
                    {
                        NoOfPrint = 2;
                    }
                    else
                    {
                        NoOfPrint = Convert.ToInt32(lstPatientDetails.Count);
                    }
                    for (m = 1; m < NoOfPrint; m++)
                    {
                        VisitDate="";
                        objStrHTML.Append(CreateTable);
                        VisitDate = objBAT.VisitDate.ToString("dd-MM-yyyy");

                        if (objBAT.DispatchType=="Home")
                        {
                            //colspan='2'
                            //(objBAT.MobileNumber != "" && objBAT.ContactNo != "") ? objBAT.ContactNo objBAT.MobileNumber : objBAT.MobileNumber != ""? objBAT.ContactNo : objBAT.MobileNumber 
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.TitleName + " " + objBAT.Name + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" +  objBAT.Add1 +" "+ objBAT.Add2 +"</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.Add3 +" "+objBAT.City +"  "+objBAT.PostalCode + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Contact No - " + objBAT.MobileNumber + "</td></tr>");     
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit No   - " + objBAT.VersionNo+ "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit Date - " + VisitDate + "</td></tr>");    
                           // objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.Footer.ToUpper() + "</td></tr>");
                        }

                        //if (objBAT.DispatchType == "Doctor")
                        //    {
                        //    objStrHTML.Append("<tr><td  style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.TitleName + " " + objBAT.Name + "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> C/O " + objBAT.SecuredCode  + " " + objBAT.ReferingPhysicianName+ "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.Add1 + " " + objBAT.Add2 + "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.Add3 + " " + objBAT.City + " " + objBAT.PostalCode + "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Contact No - " + objBAT.RelationContactNo + "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit No   - " + objBAT.VersionNo + "</td></tr>");
                        //    objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit Date - " + VisitDate + "</td></tr>");
                        //    // objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.Footer.ToUpper() + "</td></tr>");
                        //   }

                        if (objBAT.DispatchType == "Doctor")
                        {
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.SecuredCode + " " + objBAT.ReferingPhysicianName + "</td></tr>");
                            objStrHTML.Append("<tr><td  style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'>" + objBAT.TitleName + " " + objBAT.Name + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'>" + objBAT.Add1 + " " + objBAT.Add2 + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'>" + objBAT.Add3 + " " + objBAT.City + " " + objBAT.PostalCode + "</td></tr>");
                            //objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'> Contact No - " + objBAT.RelationContactNo + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'> Visit No   - " + objBAT.VersionNo + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:17px;font-weight:normal'> Visit Date - " + VisitDate + "</td></tr>");
                            // objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.Footer.ToUpper() + "</td></tr>");
                        }

                        if (objBAT.DispatchType == "FileLabel")
                        {
                            objStrHTML.Append("<tr><td  style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.TitleName + " " + objBAT.Name + "</td></tr>");
                            //objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> C/O " + objBAT.SecuredCode + " " + objBAT.ReferingPhysicianName + "</td></tr>");
                            //objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.Add1 + " " + objBAT.Add2 + "</td></tr>");
                            //objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'>" + objBAT.Add3 + " " + objBAT.City + " " + objBAT.PostalCode + "</td></tr>");
                            //objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Contact No - " + objBAT.MobileNumber + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit No   - " + objBAT.VersionNo + "</td></tr>");
                            objStrHTML.Append("<tr><td style='font-family:" + HeaderFontFamily + ";font-size:" + HeaderFontSize + "px;font-weight:bold'> Visit Date - " + VisitDate + "</td></tr>");
                            // objStrHTML.Append("<tr><td style='font-family:" + FooterFontFamily + ";font-size:" + FooterFontSize + "px;font-weight:bold'>" + objBAT.BarcodeNumber + "&nbsp;" + objBAT.Footer.ToUpper() + "</td></tr>");
                        }
                      
                        objStrHTML.Append("</table>");
                        if (CountBreak < lstPatientDetails.Count)
                            objStrHTML.Append(pageBreak);
                    }
                }
                objStrHTML.Append(EndTag);
                divPrint.InnerHtml = "";
                divPrint.InnerHtml = objStrHTML.ToString();
                /* -------Code End -------- */
                //if (IsReprint == "Y")
                //{
                //    long returnRes;
                //    GateWay gateWay = new GateWay(base.ContextInfo);
                //    List<Config> lstConfig = new List<Config>();
                //    returnRes = gateWay.GetConfigDetails("AuditReprintBarcode", OrgId, out lstConfig);
                //    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                //    {
                //        ReprintBarcodeAudit();
                //    }
                //}
                ClientScript.RegisterStartupScript(this.GetType(), "Print", "SilentPrint()", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Print", "window.close();", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LabelPrint generator on page_load", ex);
        }
    }

    public void ReprintBarcodeAudit()
    {

        long ReturnCode = -1;
        AuditTransactionDetails obj;
        List<AuditTransactionDetails> ATD = new List<AuditTransactionDetails>();
        try
        {

            obj = new AuditTransactionDetails();
            obj.AttributeID = VisitId;
            obj.AttributeName = AuditManager.AuditAttribute.Visit;
            obj.CreatedBy = Lid;
            ATD.Add(obj);

            obj = new AuditTransactionDetails();
            obj.AttributeID = Convert.ToInt64(lstSampleId);
            obj.AttributeName = AuditManager.AuditAttribute.SampleId;
            obj.CreatedBy = Lid;
            ATD.Add(obj);
            ReturnCode = new AuditManager_BL(base.ContextInfo).InsertAuditTransactions(ATD, AuditManager.AuditCategoryCode.ReprintBarcode, AuditManager.AuditTypeCode.Print, Lid, OrgId, ILocationID);
        }

        catch (Exception s)
        {
            CLogger.LogError("Error while Saving ReprintLabel in  InvestigationReport Page ", s);
        }

    }
}
