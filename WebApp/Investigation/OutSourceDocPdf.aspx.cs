using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Text;


public partial class Patient_OutPdf : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["pdf"] != null)
        {
            long pVisitID = 0;

            MemoryStream memoryStream = new MemoryStream();
            string strPdf = Request.QueryString["pdf"].ToString();
            string type = Request.QueryString["type"];
            FileStream fs = null;
            BinaryReader br = null;
            try
            {
                if (!string.IsNullOrEmpty(strPdf))
                {
                    if (strPdf == "Outsource")
                    {
                        Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                        //MemoryStream memoryStream = new MemoryStream();
                        List<byte[]> lstSourceByte = new List<byte[]>();
                        List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
                        List<TRFfilemanager> lstOutSourceDocs = new List<TRFfilemanager>();
                        long returnCode = -1;
                        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
                        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                        List<Patient> lstPatient = new List<Patient>();
                        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
                        ReportSnapshot objReportSnapshot;
                        string PictureName = string.Empty;
                        StringBuilder rsTemplateID = new StringBuilder();
                        lstReportSnapshot = new List<ReportSnapshot>();
                        lstNewReportSnapshot = new List<ReportSnapshot>();
                        oPatient_BL.GetPatientDetailsPassingVisitID(pVisitID, out lstPatient);
                        if (lstPatient.Count > 0)
                        {
                            string Type = "";


                            returnCode = oPatient_BL.GetTRFimageDetails(Convert.ToInt32(lstPatient[0].PatientID), Convert.ToInt32(pVisitID), lstPatient[0].OrgID, Type, out lstTRF);
                            if (lstTRF.Count > 0)
                            {
                                lstOutSourceDocs = lstTRF.FindAll(P => P.IdentifyingType == "Outsource_Docs");
                            }
                            if (lstOutSourceDocs.Count > 0)
                            {
                                string pathName = GetConfigValues("TRF_UploadPath", lstPatient[0].OrgID);
                                //string PictureName = string.Empty;
                                string fileExtension = string.Empty;
                                string filePath = string.Empty;
                                bool isImageAvailable = false;

                                PdfPTable table = new PdfPTable(1);
                                table.WidthPercentage = 100;
                                table.DefaultCell.BorderWidth = 0;

                                PdfPCell cell;
                                foreach (TRFfilemanager objTRF in lstOutSourceDocs)
                                {
                                    PictureName = objTRF.FileName;
                                    fileExtension = Path.GetExtension(PictureName);
                                    filePath = pathName + PictureName;
                                    if (PictureName != "" && fileExtension != ".pdf")
                                    {

                                        byte[] PDFByteArray = File.ReadAllBytes(filePath.Replace(fileExtension, ".pdf"));

                                        if (lstSourceByte.Count > 1)
                                        {
                                            lstSourceByte.Insert(1, PDFByteArray);
                                        }
                                        else
                                        {
                                            lstSourceByte.Add(PDFByteArray);
                                        }
                                    }
                                    else if (!String.IsNullOrEmpty(PictureName))
                                    {
                                        byte[] PDFByteArray = File.ReadAllBytes(filePath.Replace(fileExtension, ".pdf"));

                                        if (lstSourceByte.Count > 1)
                                        {
                                            lstSourceByte.Insert(1, PDFByteArray);
                                        }
                                        else
                                        {
                                            lstSourceByte.Add(PDFByteArray);
                                        }
                                    }
                                }
                                byte[] destByte;
                                if (lstSourceByte.Count > 1)
                                    destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, true, OrgID);
                                else
                                    destByte = lstSourceByte[0];
                                objReportSnapshot = new ReportSnapshot();
                                objReportSnapshot.TemplateID = rsTemplateID.ToString();
                                objReportSnapshot.Content = destByte;
                                lstReportSnapshot.Add(objReportSnapshot);
                                lstNewReportSnapshot.Add(objReportSnapshot);

                                byte[] Buffer = lstNewReportSnapshot[0].Content;
                                byte[] data = lstNewReportSnapshot[0].Content;
                                PdfReader reader = new PdfReader(data);
                                PdfStamper stamper = new PdfStamper(reader, memoryStream);
                                PdfWriter writer = stamper.Writer;
                                stamper.Close();
                                reader.Close();
                                Response.Clear();
                                Response.ContentType = "application/pdf";
                                Response.Charset = "";
                                Response.BinaryWrite(memoryStream.ToArray());
                                Response.Flush();
                                //Response.End();
                                memoryStream.Dispose();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Getting Report, PDF", ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strPdf))
                {
                    if (System.IO.File.Exists(strPdf))
                    {

                        fs.Close();
                        fs.Dispose();
                        br.Close();
                        //data = null;
                    }
                }
            }
        }
        else
        {
            Response.Write("Wrong path");
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
}
