using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using System.Drawing;
using System.Configuration;
using System.Text;
using System.Net;

using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;



using System.Reflection;  
using Attune.Kernel.PlatForm.BL;

public partial class StockManagement_StockDetails : Attune_BasePage
{
    public StockManagement_StockDetails()
        : base("StockManagement_StockDetails_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    InventoryCommon_BL inventoryBL;
    Products objProducts = new Products();
    ArrayList alYear = new ArrayList();
    List<InventoryItemsBasket> lstInventoryItemsBasket; 


    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        InitializeComponent();
        if (!IsPostBack)
        {
            ACX2OPPmt.Attributes.Add("class", "hide");
            ACX2minusOPPmt.Attributes.Add("class", "show");
            ACX2responsesOPPmt.Attributes.Add("class", "show");
            if (grdResult.Rows.Count > 0)
            {
                btnprnt.Visible = true;
                imgBtnXL.Visible = true;

            }
        }
    }
    private void InitializeComponent()
    {
        ProductSearch1.OnProductSearch += new InventoryCommon_Controls_ProductSearch.ProductSearchHandler(ProductSearch1_OnProductSearch);
    }

    void ProductSearch1_OnProductSearch(object sender, InventoryCommon_Controls_ProductSearch.ProductSearchList e)
    {
        BindProductList(e.CategoryId,"", e.ProductName);

    }
    private void BindProductList(int CategoryId,string GenericName, string ProductName)
    {
         lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        inventoryBL.GetProductListByCategory(OrgID, ILocationID,InventoryLocationID, CategoryId,GenericName.Trim(), ProductName.Trim(), out lstInventoryItemsBasket);
        grdResult.DataSource = lstInventoryItemsBasket;
        grdResult.DataBind();
        ProductSearch1.LoaderProductList(lstInventoryItemsBasket);
      
        if (grdResult.Rows.Count > 0)
        {
            btnprnt.Visible = true;
            imgBtnXL.Visible = true;
          
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            string productSearchStr = string.Empty;
            int categoryID = -1;
            ProductSearch1.GetSearchParameters(out productSearchStr, out categoryID);
            BindProductList(categoryID,"",productSearchStr);
        }

    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int Rowindex = e.Row.RowIndex;
            if (lstInventoryItemsBasket[Rowindex].ExpiryDate.ToString("dd/MM/yyyy") == "01/01/1753")
                e.Row.Cells[2].Text = "--";
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
          
            grdResult.Columns[1].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[2].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[3].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[4].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[5].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[6].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[7].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            grdResult.Columns[0].HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
    }

   
    static void ReplaceunwantedComma(ref string orig, string find)
    {
        var s2 = orig.Replace(find, ",");
        var orginal = orig;
        orig = s2;
    }
  
    protected string GetUrl(string imagepath)
    {
        string[] splits = Request.Url.AbsoluteUri.Split('/');
        if (splits.Length >= 2)
        {
            string url = splits[0] + "//";
            for (int i = 2; i < splits.Length - 3; i++)
            {
                url += splits[i];
                url += "/";
            }
            return url + imagepath;
        }
        return imagepath;
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        try
        {
            ExportToExcel();
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }
    public void ExportToExcel()
    {
        List<Organization> lstOrganization = new List<Organization>();
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        grdResult.AllowPaging = false;

        string productSearchStr = string.Empty;
        int categoryID = -1;
        ProductSearch1.GetSearchParameters(out productSearchStr, out categoryID);
        BindProductList(categoryID, "", productSearchStr);

        List<Config> lstConfig = new List<Config>();
        String imagepath = "";
        String HospitalName = "";
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        string test = "";
        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            imagepath = lstConfig[0].ConfigValue.Trim().Replace("..", System.Configuration.ConfigurationManager.AppSettings["ApplicationName"].ToString());
            var image = imagepath.Replace("../", "");
            test = "<img src='" + GetUrl(image) + "'/>";
        }

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            HospitalName = lstConfig[0].ConfigValue.Trim();
            while (HospitalName.Contains(",,"))
            {
                ReplaceunwantedComma(ref HospitalName, ",,");
            }
         //   lblHosital.Text = HospitalName;
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Buffer = true;
 
            Response.AddHeader("content-disposition", "attachment;filename=StockReport.xls");
            Response.ContentType = "application/vnd.ms-excel";
            string StockDetailsHeader = "Stock Details Report";


            string prefix = string.Empty;
            prefix = "Stock Details Report_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.Output.Write("\n<html>\n<body>");
            Response.Output.Write("<table>");
            Response.Output.Write("<tr> <td valign='bottom' align='center' colspan='2'><center><div align='center' style='padding-left:10px;'  valign='middle'>" + test + "</div> </center></td> <td valign='bottom' colspan='8'><div style='text-align:center'>" + HospitalName + "</div> </td> </tr>");
            
    
          
            Response.Output.Write("<tr> <td></td></tr>");
        
         
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            htmlWrite.WriteLine("<tr> <td >" + "<div style='text-align:center;font-size:14.0pt; color:#538ED5;font-weight:700;'><B>" + StockDetailsHeader + "</div></B></td></tr>");
      
            Response.Output.Write("<tr> <td><br/></td></tr>");
            Response.Output.Write("<tr> <td></td></tr>");
            Response.Output.Write("</table>");
       
          
              EnableViewState = false;
            grdResult.RenderControl(htmlWrite);
        
            Response.Output.Write(stringWrite.ToString());
            htmlWrite.Close();
            stringWrite.Close();
            Response.Output.Write("\n</body>\n</html>");
            Response.Flush();
            Response.End();
       
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
          return;
    }
    public void exporttopdf()
    {

        List<Organization> lstOrganization = new List<Organization>();
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);





     
            grdResult.AllowPaging = false;
            string productSearchStr = string.Empty;
            int categoryID = -1;
            ProductSearch1.GetSearchParameters(out productSearchStr, out categoryID);
            BindProductList(categoryID, "", productSearchStr);
     
            string rptName = string.Empty;
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();


                    string prefix = string.Empty;

                    string rptDate = prefix + DateTimeNow.ToShortDateString();
                    string StockDetailsHeader = "Stock Details Report";


                    rptName = StockDetailsHeader;


                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");

                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td align='center' style='font-size:8px' colspan = '2'>");


                    sb.Append("<tr> <td></td></tr>");

                    sb.Append(" </td></tr>");

                    sb.Append("<tr><td align='center' style='font-size:8px' colspan = '2'>");

                    sb.Append("<tr> <td valign='bottom' colspan='8' style='text-align:center;font-weight:Bold'>" + OrgName.ToString() + " </td>  </tr>");

                    sb.Append("<tr><td align='center' style='font-size:8px' colspan = '2'>");
                    sb.Append(lstOrganization[0].Address + "-" + lstOrganization[0].City);
                    sb.Append(" </td></tr>");

                    sb.Append("<tr><td align='center' style='font-size:8px' colspan = '2'>Phone No.: " + lstOrganization[0].PhoneNumber + "</td></tr>");
                    sb.Append("<tr><td><br /></td></tr>");
                    sb.Append("<tr><td><br /></td></tr>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2' style='font-weight:bold;font-size:11px'><b>" + rptName + "</b></td></tr>");


                    sb.Append("</table>");
                    sb.Append("<br />");


                    sb.Append("<table border = '1' style='font-size:7;'>");
                    sb.Append("<tr>");
                    sb.Append("<td width='25%' style='font-weight:bold;text-align:center;width:150px'>");
                    sb.Append("Product");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("Batch No");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("Expiry Date");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("InHand Qty");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("Units");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("Selling Price");
                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;'>");
                    sb.Append("Tax");

                    sb.Append("</td>");
                    sb.Append("<td style='font-weight:bold;text-align:center;width:5%'>");
                    sb.Append("Rack Number");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");

                    EnableViewState = false;
                    if (grdResult.Rows != null && grdResult.Rows.Count > 0)
                    {
                        foreach (GridViewRow row in grdResult.Rows)
                        {

                            sb.Append("<td width:30%>");
                            sb.Append(row.Cells[0].Text);
                           
                            sb.Append("</td>");
                            sb.Append("<td>");
                            sb.Append(row.Cells[1].Text);
                          
                            sb.Append("<td>");
                            sb.Append(row.Cells[2].Text);
                           
                            sb.Append("</td>");
                            sb.Append("<td>");
                            sb.Append(row.Cells[3].Text);
                            
                            sb.Append("</td>");
                            sb.Append("<td>");
                            sb.Append(row.Cells[4].Text);
                            
                            sb.Append("</td>");
                            sb.Append("<td style='text-align:right;'>");
                            // String.Format("{0:0.##}", 123.4567);      // "123.46" String.Format("", Convert.ToDecimal(e.Row.Cells[i].Text));
                            sb.Append(String.Format("{0:0.00}", Convert.ToDecimal(row.Cells[5].Text)));// l.DecimaParse(Debitvalue.ToString("0.00"));String.Format("{0:.##}", Debitvalue)
                          //   sb.Append( String.Format("{0:C2}", Convert.ToDecimal(row.Cells[5].Text)));
                            sb.Append("<td>");
                            sb.Append(row.Cells[6].Text);
                          
                            sb.Append("</td>");
                            sb.Append("<td style='width:5%'>");
                            sb.Append(row.Cells[7].Text);
                           
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");




                    }



                    sb.Append("</table>");


                  
                    //Export HTML String as PDF.

                    StringReader sr = new StringReader(sb.ToString());

                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    
                    htmlparser.Parse(sr);

                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=" + rptName + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.Flush();
                    Response.End();

                }
            }
       

    }
    protected void btnprnt_Click(Object sender, EventArgs e)
    {
        try
        {
         exporttopdf();


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PurchaseOrderReport.", ex);
        }


    }

  
    
}