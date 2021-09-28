using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

public partial class InPatient_PrintDueRequestPage : BasePage
{
    string InterimBillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        
      
        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        if (Request.QueryString["dDate"] != null)
        {
            if (Request.QueryString["dDate"].ToString() != "")
            {
                dDateNow = Request.QueryString["dDate"].ToString();
                DateTime DTPaidDate = Convert.ToDateTime(dDateNow);
                dDateNow = DTPaidDate.ToString("dd/MM/yyyy hh:mm tt");
            }
            else
            {
                dDateNow = "";
            }
        }

        long patientID = 0;
        long visitID = 0;
        string LabNo = string.Empty;
        int orgID = 0;

        Int64.TryParse(Request.QueryString["PID"], out patientID);
        Int64.TryParse(Request.QueryString["VID"], out visitID);
        InterimBillNo=Request.QueryString["ReferenceID"];
        LabNo = Request.QueryString["LabNo"]== null ? "0" : Request.QueryString["LabNo"].ToString();
        Int32.TryParse(Request.QueryString["orgid"], out  orgID);
        string IsSurgeryBill = string.Empty;

        IsSurgeryBill = Request.QueryString["IsAddServices"] == null || Request.QueryString["IsAddServices"] == "" ? "N" : Request.QueryString["IsAddServices"];
        
        uctlDueRequest1.IsSurgeryBill = IsSurgeryBill;

        uctlDueRequest1.RaisedDate = dDateNow;
        uctlDueRequest1.InterimBillNo = InterimBillNo;
        uctlDueRequest1.PatientID = patientID;
        uctlDueRequest1.VisitID = visitID;
        uctlDueRequest1.LabNo = LabNo;
        uctlDueRequest1.ViewBill = 1;
        uctlDueRequest1.SetBillDetails();
        uctlDueRequest1.Visible = true;
        string RedirectPage = GetConfigValue("PharmaBillPrint", orgID);
        if (RedirectPage == "EsIpInvBillPrint")
        {
            EsInvDueRequest.SetBillDetails();
            uctlDueRequest1.Visible = false;
        }
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.Receipt;
        if (uctlDueRequest1.isDynamicPrint)
        {
            pagetdPrint.InnerHtml = uctlDueRequest1.getprinter();
          
        }


        List<Config> lstConfig = new List<Config>();
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);
        if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
        {
            Response.Write(pagetdPrint.InnerHtml);
            uctlDueRequest1.Visible = false;
            EsInvDueRequest.Visible = false;
        }
        
          ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:window.print();", true);
       
        
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
}
