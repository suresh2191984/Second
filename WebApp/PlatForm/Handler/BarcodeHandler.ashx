<%@ WebHandler Language="C#" Class="BarcodeHandler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Xml;
using System.IO;
using System.Drawing;
using System.ComponentModel;
using iTextSharp.text.pdf;
using iTextSharp.text;

public class BarcodeHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (String.IsNullOrEmpty(context.Request.QueryString["vertical"]))
            {
                Byte[] byteArray;
                Byte[] imageCodeArray;
                String barcodeNumber = Convert.ToString(context.Request.QueryString["barcodeno"]);
                String headerText = Convert.ToString(context.Request.QueryString["header"]);
                String footerText = Convert.ToString(context.Request.QueryString["footer"]);
                String barcodeType = Convert.ToString(context.Request.QueryString["barCodeType"]);
                Int32 width = Convert.ToInt32(context.Request.QueryString["width"]);
                Int32 height = Convert.ToInt32(context.Request.QueryString["height"]);
                if (!String.IsNullOrEmpty(barcodeType) && barcodeType == "Image")
                {
                    Byte[] imageCode = GetBarCodeImage(width, height, barcodeNumber);
                    imageCodeArray = imageCode;
                    if (imageCodeArray.Count() > 0)
                    {
                        context.Response.ContentType = "image/jpeg";
                        context.Response.BinaryWrite(imageCodeArray);
                    }
                }
                else
                {
                    System.Drawing.Font headerFont = String.IsNullOrEmpty(headerText) ? null : new System.Drawing.Font(context.Request.QueryString["headerff"] != null ? context.Request.QueryString["headerff"] : "Times New Roman", context.Request.QueryString["headerfsize"] != null ? Convert.ToSingle(context.Request.QueryString["headerfsize"]) : 9, GetFontStyle(Convert.ToString(context.Request.QueryString["headerfstyle"])));
                    System.Drawing.Font footerFont = String.IsNullOrEmpty(footerText) ? null : new System.Drawing.Font(context.Request.QueryString["footerff"] != null ? context.Request.QueryString["footerff"] : "Times New Roman", context.Request.QueryString["footerfsize"] != null ? Convert.ToSingle(context.Request.QueryString["footerfsize"]) : 9, GetFontStyle(Convert.ToString(context.Request.QueryString["footerfstyle"])));
                    System.Drawing.Font barcodeNumberFont = new System.Drawing.Font("Times New Roman", 9, FontStyle.Bold);
                    Byte[] imgBarcode = BarCode(width, height, barcodeNumber, headerText, footerText, headerFont, footerFont, barcodeNumberFont);
                    byteArray = imgBarcode;
                    if (byteArray.Count() > 0)
                    {
                        context.Response.ContentType = "image/jpeg";
                        context.Response.BinaryWrite(byteArray);
                    }
                }
            }
            else
            {
                Int32 width = Convert.ToInt32(context.Request.QueryString["width"]);
                Int32 height = Convert.ToInt32(context.Request.QueryString["height"]);
                String text = Convert.ToString(context.Request.QueryString["text"]);
                System.Drawing.Font font = new System.Drawing.Font("Courier New", 8, FontStyle.Bold);
                Byte[] VerticalImage = GetVerticalTextImage(width, height, text, font);
                if (VerticalImage.Count() > 0)
                {
                    context.Response.ContentType = "image/jpeg";
                    context.Response.BinaryWrite(VerticalImage);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public Byte[] GetBarCodeImage(Int32 width, Int32 Height, String BarCodeNumner)
    {
        Byte[] imageBytes = new byte[0];
        try
        {
            MemoryStream ms = new MemoryStream();
            Barcode128 code128 = new Barcode128();
            code128.CodeType = Barcode.CODE128;
            code128.BarHeight = Height;
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

    public Byte[] GetVerticalTextImage(int width, int height, string text, System.Drawing.Font font)
    {
        Byte[] imageBytes = new byte[0];
        try
        {
            MemoryStream ms = new MemoryStream();
            StringFormat stringFormat = new StringFormat();
            stringFormat.FormatFlags = StringFormatFlags.DirectionVertical;

            System.Drawing.Image imageg = (System.Drawing.Image)new Bitmap(1000, 1000);
            Graphics g = Graphics.FromImage(imageg);
            SizeF size = g.MeasureString(text, font, width, stringFormat);
            imageg.Dispose();

            System.Drawing.Image image = (System.Drawing.Image)new Bitmap((int)size.Width, (int)size.Height);
            g = Graphics.FromImage(image);
            g.FillRectangle(Brushes.White, 0, 0, image.Width, image.Height);
            g.TranslateTransform(image.Width, image.Height);
            
            g.RotateTransform(180.0F);
            g.DrawString(text, font, Brushes.Black, 0, 0, stringFormat);
            
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            imageBytes = ms.GetBuffer();
            g.Dispose();
            image.Dispose();
            ms.Dispose();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return imageBytes;
    }
        
    public Byte[] BarCode(Int32 containerWidth, Int32 containerHeight, String barcodeNumber, String headerText, String footerText, System.Drawing.Font headerFont, System.Drawing.Font footerFont, System.Drawing.Font barcodeNumberFont)
    {
        Byte[] results = new byte[0];
        try
        {
            float textWidth = 0.0F;
            float textHeight = 0.0F;
            MemoryStream ms = new MemoryStream();
            Bitmap bm = new Bitmap(containerWidth, containerHeight);
            Graphics gr = Graphics.FromImage(bm);
            SizeF hSize = new SizeF();
            SizeF fSize = new SizeF();
            SizeF rawDataSize = new SizeF();
            if (!String.IsNullOrEmpty(headerText))
            {
                headerText = headerText.Replace("^^", "\n");
                hSize = gr.MeasureString(headerText, headerFont);
            }
           // if (!String.IsNullOrEmpty(footerText))
             //   fSize = gr.MeasureString(footerText, footerFont);
           // rawDataSize = gr.MeasureString(barcodeNumber, barcodeNumberFont);
            textWidth = hSize.Width + fSize.Width + rawDataSize.Width + 5;
            textHeight = hSize.Height + fSize.Height + rawDataSize.Height + 5;
            Barcode128 code128 = new Barcode128();
            code128.CodeType = Barcode.CODE128;
            code128.BarHeight = (containerHeight - textHeight) < 20 ? 20 : containerHeight - textHeight;
            code128.ChecksumText = true;
            code128.GenerateChecksum = true;
            code128.StartStopText = false;
            code128.Code = barcodeNumber;
            code128.Extended = false;
            System.Drawing.Image image = code128.CreateDrawingImage(System.Drawing.Color.Black, System.Drawing.Color.White);

            Int32 imageWidth = image.Width;
            Int32 imageHeight = image.Height;
            Int32 remainingWidth = containerWidth - 5;
            Int32 thumbWidth = imageWidth > remainingWidth ? remainingWidth : imageWidth;

            gr.Clear(Color.White);
            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
            //if (!String.IsNullOrEmpty(headerText))
            //    gr.DrawString(headerText, headerFont, Brushes.Black, 0, 0, StringFormat.GenericTypographic);
            gr.DrawImage(image, (containerWidth - thumbWidth) / 2, hSize.Height + 5, thumbWidth, imageHeight);
            //gr.DrawString(barcodeNumber, barcodeNumberFont, Brushes.Black, (containerWidth - rawDataSize.Width) / 2, hSize.Height + imageHeight + 5);
            //if (!String.IsNullOrEmpty(footerText))
			// gr.DrawString(footerText, footerFont, Brushes.Black, 0, hSize.Height + imageHeight + rawDataSize.Height + 5);
            bm.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            results = ms.GetBuffer();

            gr.Dispose();
            bm.Dispose();
            image.Dispose();
            ms.Dispose();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return results;
    }

    public FontStyle GetFontStyle(string fontStyle)
    {
        FontStyle style = FontStyle.Regular;
        try
        {
            switch (fontStyle)
            {
                case "Bold":
                    style = FontStyle.Bold;
                    break;
                case "Regular":
                    style = FontStyle.Regular;
                    break;
                case "Italic":
                    style = FontStyle.Italic;
                    break;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return style;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}