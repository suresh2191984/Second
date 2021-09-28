using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using System.IO;
using iTextSharp.text.pdf;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.StockReceive.BL;
using Attune.Kernel.BusinessEntities;
using System.Text;
using System;

public partial class LabConsumptionInventory_PrintProductBarcode : Attune_BasePage
{
    string strBarcodeImageValue = string.Empty;

    public LabConsumptionInventory_PrintProductBarcode()
        : base("LabConsumptionInventory_PrintProductBarcode_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {



        GenarateProductBarcode();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "ViewBarcode", "HidePatientHeater();", true);
    }

    private void GenarateProductBarcode()
    {
        long PRUN, ProductID, LID, ReturnCode = -1;
        string strIsUniqueBarcode = string.Empty;

        StockReceived_BL objStockReceived_BL = new StockReceived_BL(base.ContextInfo);
        List<StockReceivedBarcodeDetails> lstSRBD = new List<StockReceivedBarcodeDetails>();
        StringBuilder objStrHTML = new StringBuilder();



        try
        {

            PRUN = (string.IsNullOrEmpty(Request.QueryString["PRUN"]) == false) ? long.Parse(Request.QueryString["PRUN"]) : -1;

            ProductID = (string.IsNullOrEmpty(Request.QueryString["ProductID"]) == false) ? long.Parse(Request.QueryString["ProductID"]) : -1;

            LID = (string.IsNullOrEmpty(Request.QueryString["LID"]) == false) ? long.Parse(Request.QueryString["LID"]) : -1;

            strIsUniqueBarcode = (string.IsNullOrEmpty(Request.QueryString["IUB"]) == false) ? Convert.ToString(Request.QueryString["IUB"]) : string.Empty;

            ReturnCode = objStockReceived_BL.PGetProductBarcodeDetails(0, PRUN, ProductID, LID, OrgID, strIsUniqueBarcode, out lstSRBD);

            if (strIsUniqueBarcode == "Y")
            {
                txtNoOfBarcode.Enabled = false;
            }


            var listOfLists = lstSRBD.Select((p, index) => new { p, index })
                                .GroupBy(a => a.index / 3)
                                .Select((grp => grp.Select(g => g.p).ToList()))
                                .ToList();



            objStrHTML.Append("<style>   .rotate {   -webkit-transform: rotate(-90deg);   -moz-transform: rotate(-90deg);   -ms-transform: rotate(-90deg);  -o-transform: rotate(-90deg);   filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);   }   .barcode-label{width:6cm;padding:0px;border:0px solid #ccc;position:relative}   .bl-right{position:absolute;top:32px;right:40px;}   .bl-right p{text-align:center;font-size:.50em}   h1, h2, h3, h4, h5, h5, h6, p{margin:2;}</style>");

            foreach (var ConItems in listOfLists)
            {
                //objStrHTML.Append("<table id='tblBarcode' width='20px' height='65px' border='0'><tbody><tr>");
                foreach (var itemRow in ConItems)
                {
                    objStrHTML.Append("<table id='tblBarcode' width='20px' height='65px' border='0'><tbody>");
                    if (itemRow.StockReceivedBarcodeDetailsID == 0)
                    {
                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td>");
                        objStrHTML.Append("<div class='barcode-label'><div class='bl-left'><h3 style='margin-bottom:0px;margin-top:10px;'>");
                        
                        objStrHTML.Append(itemRow.ProductName);
                        objStrHTML.Append("</h3>");


                        objStrHTML.Append("<img  src='../Platform/Handler/BarcodeHandler.ashx?barcodeno=" + itemRow.ParentBarCode + "&header=&footer=&barCodeType=&width=75&height=30'" + " style='margin-bottom:0px;' height='30' width='110'>");
                       

                        objStrHTML.Append("<h3>");
						objStrHTML.Append(itemRow.ProductCode + @"/" + itemRow.BatchNo + "</h3>" );
						objStrHTML.Append("<h3>");
						
                        objStrHTML.Append("Location: " + itemRow.RakNo + " MRP: " + itemRow.MRP + "</h3>");
                        //objStrHTML.Append(itemRow.BatchNo + " MRP:  " + itemRow.MRP);
                        objStrHTML.Append("</div>");




                        objStrHTML.Append("<div class='bl-right rotate'><p><b>");
                        objStrHTML.Append("Exp:<br/>" + itemRow.ExpiryDate.ToString("MM/yyyy") + "</b></p>");
                      

                        objStrHTML.Append("</div>");


                        objStrHTML.Append("</td></tr>");

                        if (strIsUniqueBarcode == "N")
                        {
                            //hdnBarcodeValue.Value = itemRow.RecUnit + "~#" + itemRow.ParentBarCode + "~#" + strBarcodeImageValue;
                            hdnBarcodeValue.Value = base.ContextInfo.OrgName.ToString() + "~#" + itemRow.ParentBarCode + "~#" + strBarcodeImageValue + "~#" + itemRow.BatchNo + "~#" + itemRow.ExpiryDate.ToString("dd/MM/yyyy") + "~#" + itemRow.MRP;
                        }

                    }
                    else
                    {
                        objStrHTML.Append("<td>");



                        objStrHTML.Append("<div class='barcode-label'><div class='bl-left'><h6 style='margin-bottom:0px;margin-top:10px;'>");
                        
                        objStrHTML.Append(itemRow.ProductName);
                        objStrHTML.Append("</h6>");

                        objStrHTML.Append("<img  src='../Platform/Handler/BarcodeHandler.ashx?barcodeno=" + itemRow.ParentBarCode + "&header=&footer=&barCodeType=&width=75&height=30'" + " style='margin-bottom:0px;' height='30' width='110'>");
                        

                        objStrHTML.Append("<h3>");
                        objStrHTML.Append(itemRow.ProductCode + @"/" + itemRow.BatchNo + "</h3>" );
						//objStrHTML.Append( @" / BatchNo:" + itemRow.BatchNo + "</h3>" );
                        objStrHTML.Append("<h3>");
                        objStrHTML.Append("Location: " + itemRow.RakNo + " MRP: " + itemRow.MRP + "</h3>");
					   // objStrHTML.Append(" MRP: " + itemRow.MRP + "</h3>");

                        objStrHTML.Append("</div>");




                        objStrHTML.Append("<div class='bl-right rotate'><p><b>");
                        objStrHTML.Append("Exp:<br/>" + itemRow.ExpiryDate.ToString("MM/yyyy") + "</b></p>");
                    

                        

                        //objStrHTML.Append("</div>");


                        objStrHTML.Append("</td></tr></tbody></table><br/>");

                        //if (strIsUniqueBarcode == "N")
                        //{
                        //    //hdnBarcodeValue.Value = itemRow.RecUnit + "~#" + itemRow.ParentBarCode + "~#" + strBarcodeImageValue;
                        //    hdnBarcodeValue.Value = base.ContextInfo.OrgName.ToString() + "~#" + itemRow.ParentBarCode + "~#" + strBarcodeImageValue + "~#" + itemRow.BatchNo + "~#" + itemRow.ExpiryDate.ToString("dd/MM/yyyy") + "~#" + itemRow.MRP;
                        //}
                        /*objStrHTML.Append("<td align='left'>");

                        objStrHTML.Append("<table  width='100%'>");


                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>" + base.ContextInfo.OrgName.ToString() + "</td>");
                        objStrHTML.Append("</tr>");

                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>" + "<img  src='" + GetImage(itemRow.BarcodeNo) + "'/>" + "</td>");
                        objStrHTML.Append("</tr>");

                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>" + itemRow.BarcodeNo + "  " + itemRow.BatchNo + "</td>");
                        
                        objStrHTML.Append("</tr>");

                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>" + itemRow.ProductName + "</td>");
                        objStrHTML.Append("</tr>");
                        
                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>Exp. Date:" + itemRow.ExpiryDate.ToString("dd/MM/yyyy") + "</td>");
                        objStrHTML.Append("</tr>");

                        objStrHTML.Append("<tr>");
                        objStrHTML.Append("<td align='left'>"+itemRow.MRP+"</td>");
                        objStrHTML.Append("</tr>");

                        objStrHTML.Append("</table>");


                        objStrHTML.Append("</td>");*/
                        if (strIsUniqueBarcode == "N")
                        {
                            hdnBarcodeValue.Value = base.ContextInfo.OrgName.ToString() + "~#" + itemRow.ParentBarCode + "~#" + strBarcodeImageValue + "~#" + itemRow.BatchNo + "~#" + itemRow.ProductName + "~#" +  itemRow.ExpiryDate.ToString("dd/MM/yyyy") + "~#" + itemRow.MRP;

                        }
                    }

                    //objStrHTML.Append("</tr>");
                    //objStrHTML.Append("</tbody></table>");
                }
               // objStrHTML.Append("</tr>");


            }

            hdnBarcodeValue.Value = objStrHTML.ToString();
            divBarCodePrint.InnerHtml = objStrHTML.ToString();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Loading GenarateProductBarcode in PrintProductBarcode.aspx", ex);
        }
    }

    private string GetImage(string PatientNumber)
    {
        Byte[] imgBarcode = GetBarCodeImage(20, 20, PatientNumber);
        strBarcodeImageValue = "data:image/jpg;base64," + Convert.ToBase64String((byte[])imgBarcode);
        return strBarcodeImageValue;
    }

    private Byte[] GetBarCodeImage(Int32 width, Int32 Height, String BarCodeNumner)
    {
        Byte[] imageBytes = new byte[0];
        try
        {
            MemoryStream ms = new MemoryStream();
            Barcode128 code128 = new Barcode128();
            code128.CodeType = Barcode.CODE128;
            code128.BarHeight = Height;
            code128.Size = 5;
            code128.ChecksumText = true;
            code128.GenerateChecksum = true;
            code128.StartStopText = false;
            code128.Code = BarCodeNumner;
            code128.Extended = false;
            System.Drawing.Image image = code128.CreateDrawingImage(System.Drawing.Color.Black, System.Drawing.Color.White);
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            imageBytes = ms.GetBuffer();
            image.Dispose();
            ms.Dispose();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return imageBytes;
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("StockReceivedItemsBarcode.aspx?ID=" + Request.QueryString["SRDID"] + "");
    }
}
