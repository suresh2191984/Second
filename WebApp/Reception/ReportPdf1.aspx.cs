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

public partial class Patient_ReportPdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["pdf"] != null)
        {
            MemoryStream memoryStream = new MemoryStream();
            string strPdf = Request.QueryString["pdf"].ToString();
            string type = Request.QueryString["type"];
            FileStream fs = null;
            BinaryReader br = null;
            byte[] data = null;
            try
            {
                if (!string.IsNullOrEmpty(strPdf))
                {
                    if (System.IO.File.Exists(strPdf))
                    {
                        fs = new FileStream(strPdf, FileMode.Open, FileAccess.Read, FileShare.Read);
                        br = new BinaryReader(fs, System.Text.Encoding.Default);
                        data = new byte[Convert.ToInt32(fs.Length)];
                        br.Read(data, 0, data.Length);
                        PdfReader reader = new PdfReader(data);
                        PdfStamper stamper = new PdfStamper(reader, memoryStream);
                        PdfWriter writer = stamper.Writer;
                        if (type == "prtpdf")
                        {
                            PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                            writer.AddJavaScript(jAction);
                        }
                        stamper.Close();
                        reader.Close();
                        Response.Clear();
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.BufferOutput = true;

                        Response.ContentType = "application/pdf";
                        Response.Charset = "";
                        Response.BinaryWrite(memoryStream.ToArray());
                        Response.Flush();
                        Response.End();
                        memoryStream.Dispose();
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
                        data = null;
                    }
                }
            }
        }
        else
        {
            Response.Write("Wrong path");
        }
    }
}
