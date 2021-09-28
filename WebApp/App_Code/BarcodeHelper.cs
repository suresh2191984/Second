using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Drawing;

/// <summary>
/// Summary description for BarcodeHelper
/// </summary>
public class BarcodeHelper
{
    public string ISHidePatientDemography = null;
    public BarcodeHelper()
    {
        //
        // TODO: Add constructor logic here
        //
        ISHidePatientDemography = null;
    }

    public long GetBarcodeQueryString(Int32 OrgID, String lstPatientVisitID, String lstSampleId, Int64 BillId, String CategoryCode, out List<String> lstQueryString)
    {
        long returnCode = -1;
        lstQueryString = new List<String>();
        String mainQueryString = string.Empty;
        String subQueryString = string.Empty;
        List<BarcodeAttributes> lstBarcodeAttributes = null;
        List<BarcodePattern> lstBarcodePattern = null;
        string headerText = string.Empty;
        string footerText = string.Empty;
        List<String> lstHeaderText;
        Int32 width = 0;
        try
        {
            //GateWay gateway = new GateWay();
            lstBarcodeAttributes = new List<BarcodeAttributes>();
            lstBarcodePattern = new List<BarcodePattern>();
            returnCode = new GateWay(new BaseClass().ContextInfo).GetBarcodeAttributeNValues(OrgID, lstPatientVisitID, lstSampleId, BillId, CategoryCode, out lstBarcodeAttributes, out lstBarcodePattern);
            /*-----------------Handle VIP Data Start-------------------------*/
            List<BarcodePattern> lsttempDetails = new List<BarcodePattern>();
            lsttempDetails = lstBarcodePattern.FindAll(p => p.PatientStatus == "VIP");
            lstBarcodePattern.RemoveAll(p => p.PatientStatus == "VIP");
            for (int i = 0; i < lsttempDetails.Count; i++)
            {
                /*----Decrypting----------*/
                Utilities objUtilities = new Utilities();
                object inputobj = new object();
                object Decryptedobj = new object();
                inputobj = lsttempDetails[i];
                returnCode = objUtilities.GetDecryptedobj(inputobj, out Decryptedobj);
                lsttempDetails[i] = (BarcodePattern)Decryptedobj;
                /*----------------------*/
                /*-----Masking----------*/
                object inputobj1 = new object();
                object Maskedobj = new object();
                inputobj1 = lsttempDetails[i];
                returnCode = objUtilities.GetMaskedobj(inputobj1, out Maskedobj);
                lsttempDetails[i] = (BarcodePattern)Maskedobj;
                lstBarcodePattern.Add(lsttempDetails[i]);
                /*----------------------*/
            }
            /*-----------------Handle VIP Data End------------------------------*/
            if (lstBarcodeAttributes.Count > 0)
            {
                lstHeaderText = new List<String>();
                BarcodeAttributes objBCAttValues = lstBarcodeAttributes[0];
                width = String.IsNullOrEmpty(objBCAttValues.Width) ? 0 : Convert.ToInt32(objBCAttValues.Width.Replace("{", "").Replace("}", "").Trim());
                subQueryString = "width=" + width;
                subQueryString += "&height=" + (String.IsNullOrEmpty(objBCAttValues.Height) ? "0" : objBCAttValues.Height.Replace("{", "").Replace("}", "").Trim());
                if (!String.IsNullOrEmpty(objBCAttValues.HeaderFontFamily))
                    subQueryString += "&headerff=" + objBCAttValues.HeaderFontFamily;
                if (!String.IsNullOrEmpty(objBCAttValues.HeaderFontSize))
                    subQueryString += "&headerfsize=" + objBCAttValues.HeaderFontSize;
                if (!String.IsNullOrEmpty(objBCAttValues.HeaderFontStyle))
                    subQueryString += "&headerfstyle=" + objBCAttValues.HeaderFontStyle;
                if (!String.IsNullOrEmpty(objBCAttValues.FooterFontFamily))
                    subQueryString += "&footerff=" + objBCAttValues.FooterFontFamily;
                if (!String.IsNullOrEmpty(objBCAttValues.FooterFontSize))
                    subQueryString += "&footerfsize=" + objBCAttValues.FooterFontSize;
                if (!String.IsNullOrEmpty(objBCAttValues.FooterFontStyle))
                    subQueryString += "&footerfstyle=" + objBCAttValues.FooterFontStyle;

                if (CategoryCode == BarcodeCategory.Bill)
                {
                    //GateWay gateWay = new GateWay();
                    List<Config> lstConfig = new List<Config>();
                    returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("PrintBillBarcode", OrgID, out lstConfig);
                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        objBCAttValues.HeaderLine1 = string.Empty;
                        objBCAttValues.HeaderLine2 = string.Empty;
                        objBCAttValues.FooterLine1 = string.Empty;
                        objBCAttValues.FooterLine2 = string.Empty;
                    }
                }

                Font Font = new Font("Times New Roman", 11, FontStyle.Bold);

                foreach (BarcodePattern objBarcodePattern in lstBarcodePattern)
                {
                    if (!String.IsNullOrEmpty(objBarcodePattern.BarcodeNumber) && objBarcodePattern.BarcodeNumber != "0")
                    {
                        mainQueryString = subQueryString + "&barcodeno=" + objBarcodePattern.BarcodeNumber;
                        if (!String.IsNullOrEmpty(objBCAttValues.HeaderLine1))
                        {
                            headerText = ConvertPatternToValue(objBCAttValues.HeaderLine1, objBarcodePattern, "HeaderLine1");
                            lstHeaderText = GetConstrainedTextHeight(Font, headerText, width);
                        }
                        if (!String.IsNullOrEmpty(objBCAttValues.HeaderLine2))
                        {
                            headerText = ConvertPatternToValue(objBCAttValues.HeaderLine2, objBarcodePattern, "HeaderLine2");
                            lstHeaderText = GetConstrainedTextHeight(Font, headerText, width);
                        }
                        if (!String.IsNullOrEmpty(objBCAttValues.FooterLine1))
                        {
                            mainQueryString += "&footerline1=" + ConvertPatternToValue(objBCAttValues.FooterLine1, objBarcodePattern, "FooterLine1");
                        }
                        if (!String.IsNullOrEmpty(objBCAttValues.FooterLine2))
                        {
                            mainQueryString += "&footerline2=" + ConvertPatternToValue(objBCAttValues.FooterLine2, objBarcodePattern, "FooterLine2");
                        }
                        if (!String.IsNullOrEmpty(objBCAttValues.LeftVertical))
                        {
                            mainQueryString += "&leftvertical=" + ConvertPatternToValue(objBCAttValues.LeftVertical, objBarcodePattern, "LeftVertical");
                        }
                        if (lstHeaderText.Count > 0)
                        {
                            foreach (String header in lstHeaderText)
                            {
                                lstQueryString.Add(mainQueryString + "&header=" + header);
                            }
                        }
                        else
                        {
                            lstQueryString.Add(mainQueryString);
                        }
                    }
                }
            }
            else
            {
                throw new Exception("Barcode attributes configure not found");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBarcodeQueryString", ex);
        }
        return returnCode;
    }

    public long GetBarcodeQueryString(Int32 OrgID, String lstPatientVisitID, String lstSampleId, Int64 BillId, String CategoryCode, out List<BarcodeAttributes> lstGetBarcodeAttr)
    {
        long returnCode = -1;
        lstGetBarcodeAttr = new List<BarcodeAttributes>();
        List<BarcodeAttributes> lstBarcodeAttributes = null;
        List<BarcodePattern> lstBarcodePattern = null;
        string headerLine1Text = string.Empty;
        string headerLine2Text = string.Empty;
        string footerLine1Text = string.Empty;
        string footerLine2Text = string.Empty;
        string headerLine3Text = string.Empty;
        string footerLine3Text = string.Empty;
        string headerLine4Text = string.Empty;
        string footerLine4Text = string.Empty;
        int HeaderWrappedCount = 0;
        int FooterWrappedCount = 0;
        List<string> HeaderWrappedText = null;
        List<string> FooterWrappedText = null;
        BarcodeAttributes objBarCodeAttributes = null;
        try
        {
            List<Config> lstConfigvalues = new List<Config>();
            returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("HideVisaPatientName", OrgID, out lstConfigvalues);
            if (lstConfigvalues != null && lstConfigvalues.Count > 0)
            {
                ISHidePatientDemography = lstConfigvalues[0].ConfigValue.ToString();
            }

            // GateWay gateway = new GateWay();
            lstBarcodeAttributes = new List<BarcodeAttributes>();
            lstBarcodePattern = new List<BarcodePattern>();
            returnCode = new GateWay(new BaseClass().ContextInfo).GetBarcodeAttributeNValues(OrgID, lstPatientVisitID, lstSampleId, BillId, CategoryCode, out lstBarcodeAttributes, out lstBarcodePattern);
            /*-----------------Handle VIP Data Start-------------------------*/
            List<BarcodePattern> lsttempDetails = new List<BarcodePattern>();
            lsttempDetails = lstBarcodePattern.FindAll(p => p.PatientStatus == "VIP");
            lstBarcodePattern.RemoveAll(p => p.PatientStatus == "VIP");
            for (int i = 0; i < lsttempDetails.Count; i++)
            {
                /*----Decrypting----------*/
                Utilities objUtilities = new Utilities();
                object inputobj = new object();
                object Decryptedobj = new object();
                inputobj = lsttempDetails[i];
                returnCode = objUtilities.GetDecryptedobj(inputobj, out Decryptedobj);
                lsttempDetails[i] = (BarcodePattern)Decryptedobj;
                /*----------------------*/
                /*-----Masking----------*/
                object inputobj1 = new object();
                object Maskedobj = new object();
                inputobj1 = lsttempDetails[i];
                returnCode = objUtilities.GetMaskedobj(inputobj1, out Maskedobj);
                lsttempDetails[i] = (BarcodePattern)Maskedobj;
                lstBarcodePattern.Add(lsttempDetails[i]);
                /*----------------------*/
            }
            /*-----------------Handle VIP Data End------------------------------*/
            if (lstBarcodeAttributes.Count > 0)
            {
                if (lstBarcodePattern.Count > 0)
                {
                    foreach (BarcodePattern objBarcodePattern in lstBarcodePattern)
                    {
                        BarcodeAttributes objBarCodeValues = lstBarcodeAttributes[0];
                        Font Font = new Font("Times New Roman", 11, FontStyle.Bold);
                        if (!String.IsNullOrEmpty(objBarcodePattern.BarcodeNumber) && objBarcodePattern.BarcodeNumber != "0")
                        {
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine1))
                            {
                                int HeaderLine1CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine1Text = ConvertPatternToValue(objBarCodeValues.HeaderLine1, objBarcodePattern, "HeaderLine1");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine1Text.ToUpper(), ContainerWidth, out HeaderLine1CharLimit, out FontHeight);
                                if (headerLine1Text.Length > HeaderLine1CharLimit)
                                {
                                    headerLine1Text = String.IsNullOrEmpty(headerLine1Text) ? string.Empty : headerLine1Text.Substring(0, HeaderLine1CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine2))
                            {
                                int HeaderLine2CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine2Text = ConvertPatternToValue(objBarCodeValues.HeaderLine2, objBarcodePattern, "HeaderLine2");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine2Text.ToUpper(), ContainerWidth, out HeaderLine2CharLimit, out FontHeight);
                                if (headerLine2Text.Length > HeaderLine2CharLimit)
                                {
                                    headerLine2Text = String.IsNullOrEmpty(headerLine2Text) ? string.Empty : headerLine2Text.Substring(0, HeaderLine2CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine1))
                            {
                                int FooterLine1CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine1Text = ConvertPatternToValue(objBarCodeValues.FooterLine1, objBarcodePattern, "FooterLine1");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine1Text.ToUpper(), ContainerWidth, out FooterLine1CharLimit, out FontHeight);
                                if (footerLine1Text.Length > FooterLine1CharLimit)
                                {
                                    footerLine1Text = String.IsNullOrEmpty(footerLine1Text) ? string.Empty : footerLine1Text.Substring(0, FooterLine1CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine2))
                            {
                                int FooterLine2CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine2Text = ConvertPatternToValue(objBarCodeValues.FooterLine2, objBarcodePattern, "FooterLine2");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine2Text.ToUpper(), ContainerWidth, out FooterLine2CharLimit, out FontHeight);
                                if (footerLine2Text.Length > FooterLine2CharLimit)
                                {
                                    footerLine2Text = String.IsNullOrEmpty(footerLine2Text) ? string.Empty : footerLine2Text.Substring(0, FooterLine2CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine3))
                            {
                                int HeaderLine3CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine3Text = ConvertPatternToValue(objBarCodeValues.HeaderLine3, objBarcodePattern, "HeaderLine3");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine3Text.ToUpper(), ContainerWidth, out HeaderLine3CharLimit, out FontHeight);
                                if (headerLine3Text.Length > HeaderLine3CharLimit)
                                {
                                    headerLine3Text = String.IsNullOrEmpty(headerLine3Text) ? string.Empty : headerLine3Text.Substring(0, HeaderLine3CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine4))
                            {
                                int HeaderLine4CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine4Text = ConvertPatternToValue(objBarCodeValues.HeaderLine4, objBarcodePattern, "HeaderLine4");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine4Text.ToUpper(), ContainerWidth, out HeaderLine4CharLimit, out FontHeight);
                                if (headerLine4Text.Length > HeaderLine4CharLimit)
                                {
                                    headerLine4Text = String.IsNullOrEmpty(headerLine4Text) ? string.Empty : headerLine4Text.Substring(0, HeaderLine4CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine3))
                            {
                                int FooterLine3CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine3Text = ConvertPatternToValue(objBarCodeValues.FooterLine3, objBarcodePattern, "FooterLine3");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine2Text.ToUpper(), ContainerWidth, out FooterLine3CharLimit, out FontHeight);
                                if (footerLine3Text.Length > FooterLine3CharLimit)
                                {
                                    footerLine3Text = String.IsNullOrEmpty(footerLine3Text) ? string.Empty : footerLine3Text.Substring(0, FooterLine3CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine4))
                            {
                                int FooterLine4CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine4Text = ConvertPatternToValue(objBarCodeValues.FooterLine4, objBarcodePattern, "FooterLine4");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine4Text.ToUpper(), ContainerWidth, out FooterLine4CharLimit, out FontHeight);
                                if (footerLine4Text.Length > FooterLine4CharLimit)
                                {
                                    footerLine4Text = String.IsNullOrEmpty(footerLine4Text) ? string.Empty : footerLine4Text.Substring(0, FooterLine4CharLimit);
                                }
                            }
                            //for (int i = 0; i < HeaderWrappedText.Count; i++)
                            //{
                                //if (HeaderWrappedText[i] != "")
                                //{
                                    objBarCodeAttributes = new BarcodeAttributes();
                                    objBarCodeAttributes.Width = String.IsNullOrEmpty(lstBarcodeAttributes[0].Width) ? "0" : lstBarcodeAttributes[0].Width.Replace("{", "").Replace("}", "").Trim();
                                    objBarCodeAttributes.Height = String.IsNullOrEmpty(lstBarcodeAttributes[0].Height) ? "0" : lstBarcodeAttributes[0].Height.Replace("{", "").Replace("}", "").Trim();
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                        objBarCodeAttributes.HeaderFontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                    else
                                        objBarCodeAttributes.HeaderFontFamily = "Times New Roman";
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                        objBarCodeAttributes.HeaderFontSize = lstBarcodeAttributes[0].HeaderFontSize;
                                    else
                                        objBarCodeAttributes.HeaderFontSize = 11.ToString();
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontStyle))
                                        objBarCodeAttributes.HeaderFontStyle = lstBarcodeAttributes[0].HeaderFontStyle;
                                    else
                                        objBarCodeAttributes.HeaderFontStyle = "normal";
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                        objBarCodeAttributes.FooterFontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                    else
                                        objBarCodeAttributes.FooterFontFamily = "Times New Roman";
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                        objBarCodeAttributes.FooterFontSize = lstBarcodeAttributes[0].FooterFontSize;
                                    else
                                        objBarCodeAttributes.FooterFontSize = 11.ToString();
                                    if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontStyle))
                                        objBarCodeAttributes.FooterFontStyle = lstBarcodeAttributes[0].FooterFontStyle;
                                    else
                                        objBarCodeAttributes.FooterFontStyle = "normal";
                                    if (CategoryCode == BarcodeCategory.Bill)
                                    {
                                        // GateWay gateWay = new GateWay();
                                        List<Config> lstConfig = new List<Config>();
                                        returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("PrintBillBarcode", OrgID, out lstConfig);
                                        if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                                        {
                                            objBarCodeAttributes.HeaderLine1 = string.Empty;
                                            objBarCodeAttributes.HeaderLine2 = string.Empty;
                                            objBarCodeAttributes.FooterLine1 = string.Empty;
                                            objBarCodeAttributes.FooterLine2 = string.Empty;
                                            objBarCodeAttributes.HeaderLine3 = string.Empty;
                                            objBarCodeAttributes.HeaderLine4 = string.Empty;
                                            objBarCodeAttributes.FooterLine3 = string.Empty;
                                            objBarCodeAttributes.FooterLine4 = string.Empty;
                                        }
                                    }
                                    if (!String.IsNullOrEmpty(objBarCodeValues.LeftVertical))
                                    {
                                        objBarCodeAttributes.LeftVertical = ConvertPatternToValue(objBarCodeValues.LeftVertical, objBarcodePattern, "LeftVertical");
                                    }
                                    objBarCodeAttributes.VisitID = objBarcodePattern.VisitID;
                                    objBarCodeAttributes.SampleID = objBarcodePattern.SampleID;
                                    objBarCodeAttributes.HeaderLine1 = !String.IsNullOrEmpty(headerLine1Text) ? headerLine1Text : string.Empty;
                                    objBarCodeAttributes.HeaderLine2 = !String.IsNullOrEmpty(headerLine2Text) ? headerLine2Text : string.Empty;
                                    objBarCodeAttributes.BarcodeNumber = objBarcodePattern.BarcodeNumber;
                                    objBarCodeAttributes.FooterLine1 = !String.IsNullOrEmpty(footerLine1Text) ? footerLine1Text : string.Empty;
                                    objBarCodeAttributes.FooterLine2 = !String.IsNullOrEmpty(footerLine2Text) ? footerLine2Text : string.Empty;
                                    objBarCodeAttributes.HeaderLine3 = !String.IsNullOrEmpty(headerLine3Text) ? headerLine3Text : string.Empty;
                                    objBarCodeAttributes.FooterLine3 = !String.IsNullOrEmpty(footerLine3Text) ? footerLine3Text : string.Empty;
                                    objBarCodeAttributes.HeaderLine4 = !String.IsNullOrEmpty(headerLine4Text) ? headerLine4Text : string.Empty;
                                    objBarCodeAttributes.FooterLine4 = !String.IsNullOrEmpty(footerLine4Text) ? footerLine4Text : string.Empty;
                                    objBarCodeAttributes.NoOfPrint = string.IsNullOrEmpty(lstBarcodePattern[0].NoOfprint) ? "1" : lstBarcodePattern[0].NoOfprint;
                                    objBarCodeAttributes.BarcodeCount = objBarcodePattern.BarcodeCount;
                                //}
                                lstGetBarcodeAttr.Add(objBarCodeAttributes);
                            //}
                        }
                    }
                }
            }
            else
            {
                throw new Exception("Barcode attributes configure not found");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBarcodeQueryString", ex);
        }
        return returnCode;
    }

    private List<String> GetConstrainedTextHeight(Font font, string textToParse, Int32 areaWidth)
    {
        List<String> lstResultText = new List<String>();
        try
        {
            string resultText = string.Empty;
            Int32 quoteAreaWidth = areaWidth;

            Bitmap bitmap = new Bitmap(quoteAreaWidth, 100);
            Graphics g = Graphics.FromImage(bitmap);
            SizeF sz = g.MeasureString(textToParse, font);

            if (sz.Width <= quoteAreaWidth)
            {
                resultText = textToParse;
                g.Dispose();
                bitmap.Dispose();
                lstResultText.Add(resultText);
                return lstResultText;
            }

            lstResultText = new List<String>();
            textToParse = textToParse.Trim().Replace(" ", " #").Replace("-", "-#");
            string[] words = textToParse.Split('#');
            string nextLine = string.Empty;
            string word = string.Empty;
            Int32 lineCount = 0;
            for (int i = 0; i < words.Length; i++)
            {
                word = words[i];
                SizeF lineSize = g.MeasureString(nextLine, font);
                SizeF wordSize = g.MeasureString(word, font);

                if (lineSize.Width + wordSize.Width < quoteAreaWidth)
                {
                    nextLine = string.Format("{0}{1}", nextLine, word);
                    if (i == words.Length - 1)
                    {
                        resultText += nextLine;
                        lstResultText.Add(resultText);
                    }
                }
                else
                {
                    lineCount = lineCount + 1;
                    if (lineCount < 2)
                    {
                        resultText += (nextLine + "^^");
                    }
                    else
                    {
                        resultText += nextLine;
                        lstResultText.Add(resultText);
                        resultText = string.Empty;
                    }
                    nextLine = word;
                    if (i == words.Length - 1)
                    {
                        resultText += nextLine;
                        lstResultText.Add(resultText);
                    }
                }
            }

            g.Dispose();
            bitmap.Dispose();
            return lstResultText;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static List<string> To_WordWrap(string text, int maxLength, string DisplayType)
    {
        if (text.Length == 0)
            return new List<string>();
        var words = text.Split(' ');
        var lines = new List<string>();
        var currentLine = "";
        //---- Get How many should be printed in Header
        Utilities objUtilities = new Utilities();
        string KeyValue = string.Empty;
        objUtilities.GetApplicationValue(DisplayType, out KeyValue);
        maxLength = maxLength * (Convert.ToInt32(KeyValue));
        //----
        foreach (var currentWord in words)
        {
            string PresentWord = currentWord + " ";
            if ((currentLine.Length > maxLength) || ((currentLine.Length + PresentWord.Length) > maxLength))
            {
                lines.Add(currentLine);
                currentLine = "";
            }
            if (currentLine.Length > 0)
                currentLine += " " + PresentWord.Trim();
            else
                currentLine += PresentWord.Trim();
        }
        if (currentLine.Length > 0)
            lines.Add(currentLine);
        return lines;
    }

    public void GetTextWidthHeight(string FontFamily, int FontSize, string TexttoParse, int ContainerWidth, out int CharLimit, out int FontHeight)
    {
        CharLimit = -1;
        FontHeight = -1;
        TexttoParse = "A";
        Font font = new Font(FontFamily, FontSize, FontStyle.Bold);
        Bitmap bitmap = new Bitmap(ContainerWidth, 100);
        Graphics g = Graphics.FromImage(bitmap);
        SizeF sz = g.MeasureString(TexttoParse, font);
        FontHeight = Convert.ToInt32(sz.Height);
        //---- Add More text To print in each row
        Utilities objUtilities = new Utilities();
        string KeyValue = string.Empty;
        objUtilities.GetApplicationValue("AddMoreText", out KeyValue);
        //----
        if (ContainerWidth > 0)
        {
            CharLimit = ContainerWidth / Convert.ToInt32(FontSize);
            CharLimit += Convert.ToInt32(KeyValue);
        }
    }

    private string ConvertPatternToValue(string patternText, BarcodePattern objBarcodePattern, String PatternType)
    {
        Utilities objUtilities = new Utilities();
        string dateFormat = string.Empty;
        try
        {
            if (ISHidePatientDemography == "Y" && objBarcodePattern.PatientStatus == "VS")
            {
                if (patternText.Contains("PatientName"))
                    patternText = patternText.Replace("{PatientName}", "XXXX");
            }
            else
            {
                if (patternText.Contains("PatientName"))
                    patternText = patternText.Replace("{PatientName}", objBarcodePattern.PatientName);
            }

            if (patternText.Contains("ExternalVisitID"))
                patternText = patternText.Replace("{ExternalVisitID}", objBarcodePattern.BatchNo); 

            if (patternText.Contains("PatientNumber"))
                patternText = patternText.Replace("{PatientNumber}", objBarcodePattern.PatientNumber);

            if (ISHidePatientDemography == "Y" && objBarcodePattern.PatientStatus == "VS")
            {
                if (patternText.Contains("Age"))
                    patternText = patternText.Replace("{Age}", "YY-Y");
            }
            else
            {
                if (patternText.Contains("Age"))
                    patternText = patternText.Replace("{Age}", objBarcodePattern.Age);

            }

            if (ISHidePatientDemography == "Y" && objBarcodePattern.PatientStatus == "VS")
            {
                if (patternText.Contains("Sex"))
                    patternText = patternText.Replace("{Sex}", "/" + "Z" + "/");
                patternText = patternText.Replace(" /", "/");
            }
            else
            {
                if (patternText.Contains("Sex"))
                    patternText = patternText.Replace("{Sex}", "/" + objBarcodePattern.Sex + "/");
                patternText = patternText.Replace(" /", "/");
            }

            if (patternText.Contains("VisitCount"))
                patternText = patternText.Replace("{VisitCount}",objBarcodePattern.VisitCount);
                patternText = patternText.Replace("/ ", "/");

            if (patternText.Contains("TestCode"))
                patternText = patternText.Replace("{TestCode}", objBarcodePattern.TestCode);



            if (patternText.Contains("CollectedDateTime"))
            {
                dateFormat = string.Empty;
                objUtilities.GetApplicationValue("CollectedDateFormat", out dateFormat);
                dateFormat = String.IsNullOrEmpty(dateFormat) ? "dd/MM/yyyy" : dateFormat;
                patternText = patternText.Replace("{CollectedDateTime}", objBarcodePattern.CollectedDateTime != null ? objBarcodePattern.CollectedDateTime.Value.ToString(dateFormat) : "");
            }

            if (patternText.Contains("VisitType"))
                patternText = patternText.Replace("{VisitType}", objBarcodePattern.VisitType);

            if (patternText.Contains("VisitCategory"))
                patternText = patternText.Replace("{VisitCategory}", objBarcodePattern.VisitCategory);

            if (patternText.Contains("SampleType"))
                patternText = patternText.Replace("{SampleType}", objBarcodePattern.SampleType);

            if (patternText.Contains("Location"))
                patternText = patternText.Replace("{Location}", objBarcodePattern.Location);

            if (patternText.Contains("RegisteredDateTime"))
            {
                dateFormat = string.Empty;
                // objUtilities.GetApplicationValue("RegisteredDateFormat", out dateFormat);
                dateFormat = String.IsNullOrEmpty(dateFormat) ? "dd/MM/yy hh:mmtt" : dateFormat;
                patternText = patternText.Replace("{RegisteredDateTime}", objBarcodePattern.RegisteredDateTime != null ? objBarcodePattern.RegisteredDateTime.Value.ToString(dateFormat) : "");
            }

            if (patternText.Contains("DeptCode"))
                patternText = patternText.Replace("{DeptCode}", objBarcodePattern.DeptCode);

            if (patternText.Contains("BillNumber"))
                patternText = patternText.Replace("{BillNumber}", objBarcodePattern.BillNumber);

            if (patternText.Contains("VisitID"))
            {
                if (PatternType == "LeftVertical")
                {
                    patternText = patternText.Replace("{VisitID}", objBarcodePattern.VisitNumber);
                }
                else
                {
                    patternText = patternText.Replace("{VisitID}", objBarcodePattern.VisitNumber);
                }
            }

            if (patternText.Contains("ProductID"))
                patternText = patternText.Replace("{ProductID}", objBarcodePattern.ProductID);

            if (patternText.Contains("BatchNo"))
                patternText = patternText.Replace("{BatchNo}", objBarcodePattern.BatchNo);

            if (patternText.Contains("ExpDate"))
                patternText = patternText.Replace("{ExpDate}", objBarcodePattern.ExpDate != null ? "Exp " + String.Format("{0:MMM, yyyy}", Convert.ToDateTime(objBarcodePattern.ExpDate)) : "");

            if (patternText.Contains("CreatedDate"))
                patternText = patternText.Replace("{CreatedDate}", objBarcodePattern.CreatedDate != null ? objBarcodePattern.CreatedDate.Value.ToString("dd/MM/yyyy hh:mm tt") : "");

            if (patternText.Contains("AssemblyDate"))
                patternText = patternText.Replace("{AssemblyDate}", objBarcodePattern.AssemblyDate != null ? objBarcodePattern.AssemblyDate.Value.ToString("dd/MM/yyyy hh:mm tt") : "");

            if (patternText.Contains("ProductName"))
                patternText = patternText.Replace("{ProductName}", objBarcodePattern.ProductName);

            if (patternText.Contains("IndentNo"))
                patternText = patternText.Replace("{IndentNo}", objBarcodePattern.IndentNo);

            if (patternText.Contains("IssuedIndentNo"))
                patternText = patternText.Replace("{IssuedIndentNo}", objBarcodePattern.IssuedIndentNo);

            if (patternText.Contains("DespatchDate"))
                patternText = patternText.Replace("{DespatchDate}", objBarcodePattern.DespatchDate != null ? objBarcodePattern.DespatchDate.Value.ToString("dd/MM/yyyy hh:mm tt") : "");

            if (patternText.Contains("LocationName"))
                patternText = patternText.Replace("{LocationName}", objBarcodePattern.LocationName);

            if (patternText.Contains("OrgName"))
                patternText = patternText.Replace("{OrgName}", objBarcodePattern.OrgName);

            if (patternText.Contains("VName"))
                patternText = patternText.Replace("{VName}", objBarcodePattern.VName);

            if (patternText.Contains("ProtoCol"))
                patternText = patternText.Replace("{ProtoCol}", objBarcodePattern.ProtoCol);

            if (patternText.Contains("TestStatus"))
                patternText = patternText.Replace("{TestStatus}", objBarcodePattern.TestStatus);

            if (patternText.Contains("BarcodeNumber"))
                patternText = patternText.Replace("{BarcodeNumber}", objBarcodePattern.BarcodeNumber);

            if (patternText.Contains("IPOPNumber"))
                patternText = patternText.Replace("{IPOPNumber}", objBarcodePattern.IPOPNumber);

            if (patternText.Contains("SampleID"))
                patternText = patternText.Replace("{SampleID}", objBarcodePattern.SampleID.ToString());


            if (patternText.Contains("TestName"))
                patternText = patternText.Replace("{TestName}", objBarcodePattern.TestName);

            if (patternText.Contains("ReceivedDatetime"))
            {
                dateFormat = string.Empty;
                // objUtilities.GetApplicationValue("ReceivedDatetime", out dateFormat);
                dateFormat = String.IsNullOrEmpty(dateFormat) ? "dd/MM/yyyy" : dateFormat;
                patternText = patternText.Replace("{ReceivedDatetime}", objBarcodePattern.ReceivedDatetime != null ? objBarcodePattern.ReceivedDatetime.Value.ToString(dateFormat) : "");
            }
            patternText = patternText.Trim();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ConvertPatternToValue", ex);
        }
        return patternText;
    }

    public long GetLabelPrintDetails(Int32 OrgID, Int64 PatientVisitID, String CategoryCode, String UID, out List<BarcodeAttributes> lstGetBarcodeAttr, out List<Patient> lstPatientDetails)
    {
        long returnCode = -1;
        lstGetBarcodeAttr = new List<BarcodeAttributes>();
        lstPatientDetails = new List<Patient>();

        List<BarcodeAttributes> lstBarcodeAttributes = null;
        List<BarcodePattern> lstBarcodePattern = null;
        //List<Patient> lstPatientDetails = null;
        string headerLine1Text = string.Empty;
        string headerLine2Text = string.Empty;
        string footerLine1Text = string.Empty;
        string footerLine2Text = string.Empty;
        int HeaderWrappedCount = 0;
        int FooterWrappedCount = 0;
        List<string> HeaderWrappedText = null;
        List<string> FooterWrappedText = null;
        BarcodeAttributes objBarCodeAttributes = null;
        try
        {
            // GateWay gateway = new GateWay();
            lstBarcodeAttributes = new List<BarcodeAttributes>();
            lstBarcodePattern = new List<BarcodePattern>();
            lstPatientDetails = new List<Patient>();
            returnCode = new GateWay(new BaseClass().ContextInfo).GetLabelPrintDetails(OrgID, PatientVisitID, CategoryCode, UID, out lstBarcodeAttributes, out lstPatientDetails);
            /*-----------------Handle VIP Data Start-------------------------*/
            List<BarcodePattern> lsttempDetails = new List<BarcodePattern>();
            lsttempDetails = lstBarcodePattern.FindAll(p => p.PatientStatus == "VIP");
            lstBarcodePattern.RemoveAll(p => p.PatientStatus == "VIP");
            for (int i = 0; i < lsttempDetails.Count; i++)
            {
                /*----Decrypting----------*/
                Utilities objUtilities = new Utilities();
                object inputobj = new object();
                object Decryptedobj = new object();
                inputobj = lsttempDetails[i];
                returnCode = objUtilities.GetDecryptedobj(inputobj, out Decryptedobj);
                lsttempDetails[i] = (BarcodePattern)Decryptedobj;
                /*----------------------*/
                /*-----Masking----------*/
                object inputobj1 = new object();
                object Maskedobj = new object();
                inputobj1 = lsttempDetails[i];
                returnCode = objUtilities.GetMaskedobj(inputobj1, out Maskedobj);
                lsttempDetails[i] = (BarcodePattern)Maskedobj;
                lstBarcodePattern.Add(lsttempDetails[i]);
                /*----------------------*/
            }
            /*-----------------Handle VIP Data End------------------------------*/
            if (lstBarcodeAttributes.Count > 0)
            {
                lstGetBarcodeAttr = lstBarcodeAttributes;
                if (lstBarcodePattern.Count > 0)
                {
                    foreach (BarcodePattern objBarcodePattern in lstBarcodePattern)
                    {
                        BarcodeAttributes objBarCodeValues = lstBarcodeAttributes[0];
                        Font Font = new Font("Times New Roman", 10, FontStyle.Bold);
                        if (!String.IsNullOrEmpty(objBarcodePattern.BarcodeNumber) && objBarcodePattern.BarcodeNumber != "0")
                        {
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine1))
                            {
                                int HeaderLine1CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine1Text = ConvertPatternToValue(objBarCodeValues.HeaderLine1, objBarcodePattern, "HeaderLine1");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine1Text.ToUpper(), ContainerWidth, out HeaderLine1CharLimit, out FontHeight);
                                if (headerLine1Text.Length > HeaderLine1CharLimit)
                                {
                                    headerLine1Text = String.IsNullOrEmpty(headerLine1Text) ? string.Empty : headerLine1Text.Substring(0, HeaderLine1CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.HeaderLine2))
                            {
                                int HeaderLine2CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].HeaderFontSize);
                                else
                                    FontSize = 11;
                                headerLine2Text = ConvertPatternToValue(objBarCodeValues.HeaderLine2, objBarcodePattern, "HeaderLine2");
                                GetTextWidthHeight(FontFamily, FontSize, headerLine2Text.ToUpper(), ContainerWidth, out HeaderLine2CharLimit, out FontHeight);
                                if (headerLine2Text.Length > HeaderLine2CharLimit)
                                {
                                    headerLine2Text = String.IsNullOrEmpty(headerLine2Text) ? string.Empty : headerLine2Text.Substring(0, HeaderLine2CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine1))
                            {
                                int FooterLine1CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine1Text = ConvertPatternToValue(objBarCodeValues.FooterLine1, objBarcodePattern, "FooterLine1");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine1Text.ToUpper(), ContainerWidth, out FooterLine1CharLimit, out FontHeight);
                                if (footerLine1Text.Length > FooterLine1CharLimit)
                                {
                                    footerLine1Text = String.IsNullOrEmpty(footerLine1Text) ? string.Empty : footerLine1Text.Substring(0, FooterLine1CharLimit);
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.FooterLine2))
                            {
                                int FooterLine2CharLimit = -1;
                                int FontHeight = -1;
                                int FontSize = -1;
                                string FontFamily = "";
                                int ContainerWidth = Convert.ToInt32(lstBarcodeAttributes[0].Width);
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                    FontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                                else
                                    FontFamily = "Times New Roman";
                                if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                    FontSize = Convert.ToInt32(lstBarcodeAttributes[0].FooterFontSize);
                                else
                                    FontSize = 11;
                                footerLine2Text = ConvertPatternToValue(objBarCodeValues.FooterLine2, objBarcodePattern, "FooterLine2");
                                GetTextWidthHeight(FontFamily, FontSize, footerLine2Text.ToUpper(), ContainerWidth, out FooterLine2CharLimit, out FontHeight);
                                if (footerLine2Text.Length > FooterLine2CharLimit)
                                {
                                    footerLine2Text = String.IsNullOrEmpty(footerLine2Text) ? string.Empty : footerLine2Text.Substring(0, FooterLine2CharLimit);
                                }
                            }
                            //for (int i = 0; i < HeaderWrappedText.Count; i++)
                            //{
                            //if (HeaderWrappedText[i] != "")
                            //{
                            objBarCodeAttributes = new BarcodeAttributes();
                            objBarCodeAttributes.Width = String.IsNullOrEmpty(lstBarcodeAttributes[0].Width) ? "0" : lstBarcodeAttributes[0].Width.Replace("{", "").Replace("}", "").Trim();
                            objBarCodeAttributes.Height = String.IsNullOrEmpty(lstBarcodeAttributes[0].Height) ? "0" : lstBarcodeAttributes[0].Height.Replace("{", "").Replace("}", "").Trim();
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontFamily))
                                objBarCodeAttributes.HeaderFontFamily = lstBarcodeAttributes[0].HeaderFontFamily;
                            else
                                objBarCodeAttributes.HeaderFontFamily = "Times New Roman";
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontSize))
                                objBarCodeAttributes.HeaderFontSize = lstBarcodeAttributes[0].HeaderFontSize;
                            else
                                objBarCodeAttributes.HeaderFontSize = 11.ToString();
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].HeaderFontStyle))
                                objBarCodeAttributes.HeaderFontStyle = lstBarcodeAttributes[0].HeaderFontStyle;
                            else
                                objBarCodeAttributes.HeaderFontStyle = "normal";
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontFamily))
                                objBarCodeAttributes.FooterFontFamily = lstBarcodeAttributes[0].FooterFontFamily;
                            else
                                objBarCodeAttributes.FooterFontFamily = "Times New Roman";
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontSize))
                                objBarCodeAttributes.FooterFontSize = lstBarcodeAttributes[0].FooterFontSize;
                            else
                                objBarCodeAttributes.FooterFontSize = 11.ToString();
                            if (!String.IsNullOrEmpty(lstBarcodeAttributes[0].FooterFontStyle))
                                objBarCodeAttributes.FooterFontStyle = lstBarcodeAttributes[0].FooterFontStyle;
                            else
                                objBarCodeAttributes.FooterFontStyle = "normal";
                            if (CategoryCode == BarcodeCategory.Bill)
                            {
                                // GateWay gateWay = new GateWay();
                                List<Config> lstConfig = new List<Config>();
                                returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("PrintBillBarcode", OrgID, out lstConfig);
                                if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                                {
                                    objBarCodeAttributes.HeaderLine1 = string.Empty;
                                    objBarCodeAttributes.HeaderLine2 = string.Empty;
                                    objBarCodeAttributes.FooterLine1 = string.Empty;
                                    objBarCodeAttributes.FooterLine2 = string.Empty;
                                }
                            }
                            if (!String.IsNullOrEmpty(objBarCodeValues.LeftVertical))
                            {
                                objBarCodeAttributes.LeftVertical = ConvertPatternToValue(objBarCodeValues.LeftVertical, objBarcodePattern, "LeftVertical");
                            }
                            objBarCodeAttributes.VisitID = objBarcodePattern.VisitID;
                            objBarCodeAttributes.SampleID = objBarcodePattern.SampleID;
                            objBarCodeAttributes.HeaderLine1 = !String.IsNullOrEmpty(headerLine1Text) ? headerLine1Text : string.Empty;
                            objBarCodeAttributes.HeaderLine2 = !String.IsNullOrEmpty(headerLine2Text) ? headerLine2Text : string.Empty;
                            objBarCodeAttributes.BarcodeNumber = objBarcodePattern.BarcodeNumber;
                            objBarCodeAttributes.FooterLine1 = !String.IsNullOrEmpty(footerLine1Text) ? footerLine1Text : string.Empty;
                            objBarCodeAttributes.FooterLine2 = !String.IsNullOrEmpty(footerLine2Text) ? footerLine2Text : string.Empty;
                            objBarCodeAttributes.NoOfPrint = string.IsNullOrEmpty(lstBarcodePattern[0].NoOfprint) ? "1" : lstBarcodePattern[0].NoOfprint;
                            //}
                            lstGetBarcodeAttr.Add(objBarCodeAttributes);
                            //}
                        }
                    }
                }
            }
            else
            {
                throw new Exception("Label attributes configure not found");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBarcodeQueryString", ex);
        }
        return returnCode;
    }

    public Byte[] GetBarCodeImage(Int32 Width, Int32 Height, String BarCodeNumber, bool IncludeLabel, bool isVertical)
    {
        Byte[] imageBytes = new byte[0];
        try
        {
            BarcodeLib.Barcode b = new BarcodeLib.Barcode();
            b.IncludeLabel = IncludeLabel;
            b.LabelPosition = BarcodeLib.LabelPositions.BOTTOMCENTER;
            b.ImageFormat = System.Drawing.Imaging.ImageFormat.Png;
            if (isVertical)
            {
                b.RotateFlipType = (RotateFlipType)Enum.Parse(typeof(RotateFlipType), "Rotate90FlipXY", true);
            }
            else
            {
                b.RotateFlipType = (RotateFlipType)Enum.Parse(typeof(RotateFlipType), "RotateNoneFlipNone", true);
            }
            b.Alignment = BarcodeLib.AlignmentPositions.CENTER;
            if (!String.IsNullOrEmpty(BarCodeNumber))
            {
                b.Encode(BarcodeLib.TYPE.CODE128, BarCodeNumber, System.Drawing.Color.Black, System.Drawing.Color.White, Width, Height);
            }
            imageBytes = b.Encoded_Image_Bytes;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return imageBytes;
    }

    public long SaveReportBarcode(long VisitID, int OrgID, string barcodeNumber,string BarcodeType)
    {
        long returncode = -1;
        try
        {
            int width = 100;
            int height = 50;
            bool isVertical=true;
            long returnCode = -1;
            bool IsHorizontal = false;
            List<Config> lstConfig = new List<Config>();
                    returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("ShowReportBarcodeHorizontal", OrgID, out lstConfig);
                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        IsHorizontal = true;
                    }

            if (BarcodeType == "PVN" && IsHorizontal==false)
            {
                isVertical=true;
            }
            else if (BarcodeType == "PVN" && IsHorizontal == true)
            {
                isVertical = false;
            }
            else if (BarcodeType == "HCNO")
            {
                isVertical = false;
            }
            else if (BarcodeType == "WPVN")
            {
                isVertical = false;
            }
            byte[] byteArray = GetBarCodeImage(width, height, barcodeNumber, true, isVertical);

            Report_BL oReportBL = new Report_BL();
            oReportBL.SaveReportBarcodeDetails(VisitID, OrgID, byteArray, BarcodeType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While saving report barcode", ex);

        }
        return returncode;

    }

    public long SaveWatersReportBarcode(string VisitNumber, int OrgID, string barcodeNumber, string BarcodeType)
    {
        long returncode = -1;
        try
        {
            int width = 100;
            int height = 50;
            bool isVertical = true;
            
            if (BarcodeType == "WPVN")
            {
                isVertical = false;
            }
            byte[] byteArray = GetBarCodeImage(width, height, barcodeNumber, true, isVertical);

            Report_BL oReportBL = new Report_BL();
            oReportBL.SaveWatersReportBarcodeDetails(VisitNumber, OrgID, byteArray, BarcodeType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While saving report barcode", ex);

        }
        return returncode;

    }
}
