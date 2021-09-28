<%@ WebHandler Language="C#" Class="ClientExportToExcelHandler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.ComponentModel;
using System.Web.SessionState;
using System.Data;
using System.Text;

public class ClientExportToExcelHandler : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {

        string CName = string.Empty;
        string CCode = string.Empty;
        int OrgID = 0, ILocationID=0;

        if (context.Request.QueryString["ClientName"] != null)
        {
            CName = context.Request.QueryString["ClientName"].ToString();
            CName = CName.Trim();
        }
        if (context.Request.QueryString["ClientCode"] != null)
        {
            CCode = context.Request.QueryString["ClientCode"].ToString();
            CCode = CCode.Trim(); 
        }
        if (context.Request.QueryString["ILocationID"] != null)
        {
            ILocationID = Convert.ToInt16(context.Request.QueryString["ILocationID"]);
        }
        if (context.Request.QueryString["OrgID"] != null)
        {
            OrgID = Convert.ToInt16(context.Request.QueryString["OrgId"]);
        }
        
        
        
        long returnCode = 0;
        List<ClientMaster> lstinvmasters = new List<ClientMaster>();
        DataTable tblClientDetails = new DataTable(); 
        long ClientID = 0;
        returnCode = new Master_BL(new BaseClass().ContextInfo).GetInvoiceClientDetails(OrgID, ILocationID, CName, CCode, ClientID, out lstinvmasters);
        //Utilities.ConvertFrom(lstinvmasters, out tblClientDetails);

        DataTable dt = new DataTable();
        DataColumn dbCol0 = new DataColumn("SNo");
        DataColumn dbCol1 = new DataColumn("ClientName");
        DataColumn dbCol2 = new DataColumn("ClientCode");
        DataColumn dbCol3 = new DataColumn("ServiceTaxNo");
        DataColumn dbCol4 = new DataColumn("CstNo");
        DataColumn dbCol5 = new DataColumn("ApprovalRequired");

        dt.Columns.Add(dbCol0);
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        dt.Columns.Add(dbCol5);


        DataRow dr;
        int SNo = 1;
        foreach (ClientMaster objRPT in lstinvmasters)
        {
            dr = dt.NewRow();
            dr["SNo"] = SNo;
            dr["ClientName"] = objRPT.ClientName;
            dr["ClientCode"] = objRPT.ClientCode;
            dr["ServiceTaxNo"] = objRPT.ServiceTaxNo;
            dr["CstNo"] = objRPT.CstNo; 
            dr["ApprovalRequired"] = objRPT.ApprovalRequired;
            
            dt.Rows.Add(dr);
            SNo = SNo + 1;
        }
        
        ExportToExcel(dt); 
        
    }
    
    public void ExportToExcel(DataTable dt)
    {
        
        HttpResponse response = HttpContext.Current.Response;

        BasePage Bp = new BasePage();
        DateTime DTime = new DateTime();
        DTime = Convert.ToDateTime(Bp.OrgDateTimeZone);
        string attachment = "attachment; filename=" + "ClientMaster" + DTime + ".xls";
        
        // first let's clean up the response.object
        response.Clear();
        response.Charset = "";

        response.ContentType = "application/ms-excel";
        response.AddHeader("Content-Disposition", attachment);

        // create a string writer
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                // instantiate a datagrid
                DataGrid dg = new DataGrid();
                dg.DataSource = dt;
                dg.DataBind();
                dg.HeaderStyle.Font.Bold = true;
                dg.RenderControl(htw);
                response.Write(sw.ToString());
                response.End();
            }
        }
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}