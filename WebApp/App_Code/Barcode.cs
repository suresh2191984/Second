using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Drawing;
using System.IO;
using System.Configuration;
using System.Drawing.Imaging;
using System.ComponentModel;

///// <summary>
///// Summary description for Barcode
///// </summary>
//[WebService(Namespace = "http://tempuri.org/")]
//[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//// [System.Web.Script.Services.ScriptService]
public class BarCodeGenerator : System.Web.Services.WebService
{


     [WebMethod(EnableSession = true)]
    public byte[] Code39(string code, int barSize, bool showCodeString, string title)
    {

        WSBarCode.Barcodes.Code39 c39 = new WSBarCode.Barcodes.Code39();

        // Create stream....
        MemoryStream ms = new MemoryStream();
        c39.FontFamilyName = ConfigurationSettings.AppSettings["BarCodeFontFamily"];
        // get parent of System folder to have Windows folder
        DirectoryInfo dirWindowsFolder = Directory.GetParent(Environment.GetFolderPath(Environment.SpecialFolder.System));

        // Concatenate Fonts folder onto Windows folder.
        string strFontsFolder = Path.Combine(dirWindowsFolder.FullName, "Fonts");

        // Results in full path e.g. "C:\Windows\Fonts"


        //c39.FontFileName = ConfigurationSettings.AppSettings["BarCodeFontFile"];

        c39.FontFileName = strFontsFolder+"\\FREE3OF9.TTF";
        c39.FontSize = barSize;
        c39.ShowCodeString = showCodeString;
        if (title + "" != "")
        c39.Title = title;
        Bitmap objBitmap = c39.GenerateBarcode(code);
        objBitmap.Save(ms, ImageFormat.Png);

        //return bytes....
        return ms.GetBuffer();
    }
}

