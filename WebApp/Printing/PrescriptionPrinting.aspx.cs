using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;
public partial class Printing_PrescriptionPrinting : BasePage
{
    long taskID = -1;
    long visitID = -1;
    long returnCode = -1;
    int pdid = 0;



     protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["vid"], out visitID);

        returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
        printHeader();
       PrintPrescription.LoadDetails(visitID);
   
         //opCaseSheet.LoadPatientDetails(visitID, pdid);
    }
    private void printHeader()
    {

        List<Config> lstConfig = new List<Config>();

        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.CaseSheet;


        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
            imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
            if (lstConfig[0].ConfigValue.Trim() != "")
            {
                imgBillLogo.Visible = true;
            }
            else
            {
                imgBillLogo.Visible = false;
            }
        }
        else
        {
            imgBillLogo.Visible = false;
        }

        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "OrgName", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0)
        {
            // lblHospitalName.Text = "Kamakshi Memoial ";

            lblHospitalName.Text = lstConfig[0].ConfigValue.ToString();

            //lblHospitalName.Style.Add("OrgName", lstConfig[0].ConfigValue.Trim());
            //    lblimagelogo.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());

        }


        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Footer", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0)
        {
            lblFooter.Text = lstConfig[0].ConfigValue.ToString();
            //lblFooter.Style.Add("Footer", lstConfig[0].ConfigValue.Trim());
            //    lblimagelogo.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());

        }

        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "moto", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0)
        {
            lblmoto.Text = lstConfig[0].ConfigValue.ToString();
            //lblmoto.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            //  lblimagelogo.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
        }


    }

   
}
