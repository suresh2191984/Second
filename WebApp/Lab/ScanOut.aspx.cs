using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Web.Script.Serialization;
using System.Web.UI.HtmlControls;
using System.IO;

using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class Lab_ScanOut : BasePage
{

    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    List<Speciality> lstSpeciality = new List<Speciality>();
    List<TaskActions> lstCategory = new List<TaskActions>();
    List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
    List<ClientMaster> lstClient = new List<ClientMaster>();
    List<MetaData> lstProtocal = new List<MetaData>();
    TaskProfile taskProfile = new TaskProfile();
    bool isScondaryBarcode;

    public Lab_ScanOut()
        : base("Lab_ScanOut_aspx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // iframeBarcode.Attributes.Remove("src");
        if (!IsPostBack)
        {
            GetLocation();
        }
    }

    private void GetLocation()
    {

        long retval = -1;
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient, out lstProtocal);
        LoadLocation(lstDept);
    }



    private void LoadLocation(List<InvDeptMaster> lstDept)
    {
        ddlDepartment.Items.Clear();
        List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
        List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        long returnCode = -1;

        returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);
        try
        {
            if (ObjInvDep.Count > 0)
            {
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "DeptId";
                ddlDepartment.DataSource = ObjInvDep.Except(ObjInvDep.Where(a => a.DeptName.ToUpper() == "SRA" || a.DeptName.ToUpper() == "OUTSOURCE")).ToList();
                ddlDepartment.DataBind();
            }
            ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading departments", ex);
        }
    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                GridView1.PageIndex = e.NewPageIndex;
                ScanOutdetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on OnPageIndexChanging", ex);
        }
    }
    string header = Resources.Lab_AppMsg.Lab_ScanOut_aspx_alert == null ? "Alert" : Resources.Lab_AppMsg.Lab_ScanOut_aspx_alert;

    static List<SampleBatchScanOutDetails> scanout = new List<SampleBatchScanOutDetails>();

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        grouptab.ActiveTabIndex = 0;
        ScanOutdetails();
    }
    private void ScanOutdetails()
    {
        try
        {
            GridView1.DataSource = null;
            GridView1.DataBind();

            long returnCode = -1;
            string BarcodeNumber = String.Empty;
            string BatchNo = String.Empty;
            int DDLno;

            Master_BL masterBL = new Master_BL(base.ContextInfo);
            BarcodeNumber = barcodeid.Text.Trim();
            DDLno = Convert.ToInt32(ddlDepartment.SelectedItem.Value);

            returnCode = masterBL.ScanOut(BarcodeNumber, DDLno, out scanout, out BatchNo);

            if (scanout.Count == 0)
            {
                if (!String.IsNullOrEmpty(BatchNo) && BatchNo.Length > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('" + BatchNo + "');", true);
                    ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    updatePanel1.Update();
                }
            }
            else
            {
                if (scanout.Count > 0)
                {
                    if (!String.IsNullOrEmpty(BatchNo) && BatchNo.Length > 0)
                    {
                        GridView1.DataSource = scanout;
                        GridView1.DataBind();
                        GridView1.Visible = true;
                        ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('" + BatchNo + "');", true);
                        ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                    }
                     else
                    {
                        GridView1.DataSource = scanout;
                        GridView1.DataBind();
                        ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                    }
                }
                //else
                //{
                //    GridView1.DataSource = scanout;
                //    GridView1.DataBind();
                //    ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                //}
            }

            /*  if(BatchNo=="" || BatchNo=="-2" )
              {
                  string pageno = String.Empty;
            
                  pageno = Resources.Lab_AppMsg.Lab_ScanOut_aspx_01 == null ? "Sample Mismatch or Already Exist" : Resources.Lab_AppMsg.Lab_ScanOut_aspx_01;

                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + pageno + "','" + header + "');", true);
                  //genSheet.Visible = false;
              } 
              else if ( BatchNo != "0")
              {

                  string str = Resources.Lab_AppMsg.Lab_ScanOut_aspx_02 == null ? "Given Barcode Sample Batch Already Exist" : Resources.Lab_AppMsg.Lab_ScanOut_aspx_02 + " : " + BatchNo;
                
                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + str + "','"+header+"');", true);

              }  */

            if (BatchNo == "-2" || (BatchNo == "" && scanout.Count <= 0))
            {
                string pageno = String.Empty;

                //pageno = Resources.Lab_AppMsg.Lab_ScanOut_aspx_01 == null ? "Sample is mismatch or Scanned in department" : Resources.Lab_AppMsg.Lab_ScanOut_aspx_01;

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('The sample scanned does not contain tests for the selected department.','" + header + "');", true);
                // genSheet.Visible = false;
            }
            else if (BatchNo == "" && scanout.Count > 0)
            {
                string pageno = String.Empty;

                pageno = Resources.Lab_AppMsg.Lab_ScanOut_aspx_06 == null ? "Already Exists " : Resources.Lab_AppMsg.Lab_ScanOut_aspx_06;

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + pageno + "','d');", true);
                // genSheet.Visible = false;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + pageno + "','" + header + "');", true);
            }
            else if (BatchNo != "0" && scanout.Count > 0)
            {
                //string str = Resources.Lab_AppMsg.Lab_ScanOut_aspx_02 == null ? "Given Barcode Sample Batch Already Exist" : Resources.Lab_AppMsg.Lab_ScanOut_aspx_02 + " : " + BatchNo;

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('The sample scanned does not contain tests for the selected department.','" + header + "');", true);
                //genSheet.Visible = false;
            }

            barcodeid.Text = string.Empty;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Submit_Click", ex);
        }

    }
    /*public void fillgrid()
    {
        GridView1.DataSource = scanout;
       
        //GridView1.DataSource = from t in scanout
        //                       select new
        //                       {
        //                           t.LabNumber,
        //                           t.BarcodeNumber,
        //                           t.DeptName,
        //                           t.SharedDept,
        //                           t.Status
        //                       };
        //  GridView1.DataSource = scanout;

        GridView1.DataBind();
        genSheet.Visible = true;
        imgBarcode.Visible = false;
    }*/
    /*protected void genSheet_Click(object sender, EventArgs e)
    {
        string RtnBatchNo = string.Empty;
        int DDLno;
        if (GridView1.Rows.Count > 0)
        {
            List<ScanOutDetails> sodBarcodeLst = new List<ScanOutDetails>();
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                ScanOutDetails sod=new ScanOutDetails();
                sod.BarcodeNumber=GridView1.Rows[i].Cells[2].Text;
                sodBarcodeLst.Add(sod);
            }
           // barcodeid.Text=GridView1.Rows[0].Cells[2].Text;
            DDLno = Convert.ToInt32(ddlDepartment.SelectedItem.Value);
            try
            {

                string format = String.Empty;
                format = "SCO";
                Master_BL masterBL = new Master_BL(base.ContextInfo);
                masterBL.SOTBatchId(format, DDLno,sodBarcodeLst ,out RtnBatchNo);
                //  imgbtnBarcode.Visible = true;
                GetBarcodePrint(RtnBatchNo);
                genSheet.Visible = false;
          

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while  genSheet_Click", ex);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('No Data Found','alert');", true);
        }
        
    }*/

    /*public void GetBarcodePrint(string BatchId)
    {
        try
        {


            string str1 = string.Empty;
                            str1 = str1 + "barcodeno=" + BatchId + "&width=180&height=40" ;
                            imgBarcode.ImageUrl = "../admin/BarcodeHandler.ashx?" + str1;
                            imgBarcode.Visible = true;
                       
                  
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs GetBarcodePrint()", ex);
        }
    }*/
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    /*protected void imgbtnxls_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "ScanOut Samples" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GridView1.GridLines = GridLines.Both;
        GridView1.HeaderStyle.Font.Bold = true;
        GridView1.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.Flush();
     
        Response.End();     

    }
    protected void imgBtnPDF_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition","attachment;filename=ScanOut_Samples.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
       
        GridView1.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End(); 
    }
    protected void imgbtnhtml_Click(object sender, EventArgs e)
    {
        HtmlForm form = new HtmlForm();
      //  GridView1.AllowPaging = false;
     
        Response.ClearContent();
        Response.AddHeader("content-disposition", string.Format("attachment; filename=ScanOut_Samples.html"));
        Response.Charset = "";
        Response.ContentType = "text/html";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);

        form.Attributes["runat"] = "server";
        form.Controls.Add(GridView1);
        this.Controls.Add(form);
        Form.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.Flush();
        Response.End();  
    }
    protected void imgbtncsv_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=ScanOut_Samples.csv");
        Response.Charset = "";
        Response.ContentType = "application/text";

        
        
        StringBuilder columnbind = new StringBuilder();
        for (int k = 0; k < GridView1.Columns.Count; k++)
        {

            columnbind.Append(GridView1.Columns[k].HeaderText + ',');
        }

        columnbind.Append("\r\n");
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            for (int k = 0; k < GridView1.Columns.Count; k++)
            {
               
                    columnbind.Append(GridView1.Rows[i].Cells[k].Text + ',');
            }

            columnbind.Append("\r\n");
        }
        Response.Output.Write(columnbind.ToString());
        Response.Flush();
        Response.End();  
    }*/

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.PageIndex = 0;
        GridView3.PageIndex = 0;
        grouptab.ActiveTabIndex = 0;
        SampleDetail();
        SampleTrackingDetail();

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
    }

    private void SampleDetail()
    {
        int DDLno;
        try
        {
            if (GridView1.SelectedRow != null)
            {
                string Barcode = ((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfBarcodenumber")).Value.ToString();
                if (!string.IsNullOrEmpty(Barcode))
                {
                    DDLno = Convert.ToInt32(ddlDepartment.SelectedItem.Value);
                    List<PatientInvSample> objscanout = null;
                    Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
                    masterbl.GetSampleDetails(Barcode, DDLno, out objscanout);
                    if (objscanout.Count > 0)
                    {
                        GridView2.DataSource = objscanout;
                        GridView2.DataBind();
                    }
                    else
                    {
                        GridView2.Style.Add("display", "none");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan Out View at SampleDetail method", ex);
        }
    }

    private void SampleTrackingDetail()
    {
        int DDLno;
        try
        {
            if (GridView1.SelectedRow != null)
            {
                string Barcode = ((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfBarcodenumber")).Value.ToString();
                if (!string.IsNullOrEmpty(Barcode))
                {
                    DDLno = Convert.ToInt32(ddlDepartment.SelectedItem.Value);
                    List<SampleBatchScanOutDetails> objscanout = null;
                    Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
                    masterbl.SRATrackingDetails(Barcode, DDLno, out objscanout);
                    if (objscanout.Count > 0)
                    {
                        GridView3.DataSource = objscanout;
                        GridView3.DataBind();
                    }
                    else
                    {
                        GridView3.Style.Add("display", "none");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan Out View at SampleTrackingDetail method", ex);
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
                isScondaryBarcode = ((SampleBatchScanOutDetails)e.Row.DataItem).IsSecBarCode;

                TableCell tatcell = e.Row.Cells[7];
                if (tatcell.Text == DateTime.MinValue.ToString() || tatcell.Text == DateTime.MaxValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }
                TableCell tatcell2 = e.Row.Cells[11];
                if (tatcell2.Text == DateTime.MinValue.ToString() || tatcell2.Text == DateTime.MaxValue.ToString())
                {
                    tatcell2.Text = string.Empty;
                }

                if (GridView1.DataSource != null)
                {
                    if (isScondaryBarcode)
                    {
                        CheckBox chkisdefault = (CheckBox)e.Row.FindControl("chkSecondaryBarcode");
                        if (chkisdefault != null)
                            chkisdefault.Checked = true;
                    }
                    isScondaryBarcode = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan Out View at GridView1_RowDataBound. ", ex);
        }
    }

    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                GridView2.PageIndex = e.NewPageIndex;
                SampleDetail();
            }
        }
        catch (Exception ex)
        {
            GridView2.PageIndex = 0;
            CLogger.LogError("Error on GridView2_PageIndexChanging", ex);
        }
    }

    protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                GridView3.PageIndex = e.NewPageIndex;
                SampleTrackingDetail();
            }
        }
        catch (Exception ex)
        {
            GridView3.PageIndex = 0;
            CLogger.LogError("Error on GridView3_PageIndexChanging", ex);
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell tatcell = e.Row.Cells[1];
                if (tatcell.Text == DateTime.MinValue.ToString() || tatcell.Text == DateTime.MaxValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan Out page at GridView2_RowDataBound", ex);
        }
    }
}
