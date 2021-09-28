using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;


public partial class Inventory_PatientList : BasePage
{
    SharedInventory_BL invenBL ;
    List<Patient> lstPatientDetails = new List<Patient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        invenBL = new SharedInventory_BL(base.ContextInfo);
        string pName = ""; string SmartCardNo = "";
        if (!IsPostBack)
        {
            if (Request.QueryString["pName"] != "")
            {
                pName = Request.QueryString["pName"];
            }
            if (Request.QueryString["Sno"] != "")
            {
                SmartCardNo = Request.QueryString["Sno"]==null? "": Request.QueryString["Sno"];
            }
            string pNo = Request.QueryString["pNo"].ToString(); 
            string pOrg = Request.QueryString["pOrg"].ToString();
            LoadPatientList(pName, pNo,SmartCardNo,int.Parse(pOrg));
        }
    }
    private void LoadPatientList(string pName, string pNo,string SmartCardNo, int pOrgId)
    {
        //invenBL.GetPatientList(pName, pNo,SmartCardNo,pOrgId, out lstPatientDetails);
        grdResult.DataSource = lstPatientDetails;
        grdResult.EmptyDataText = "No matching records found .";
        grdResult.DataBind();
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        int pOrg = 0;
        try
        {
            Int32.TryParse(Request.QueryString["pOrg"], out pOrg);
            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HtmlInputRadioButton rdSel = (HtmlInputRadioButton)e.Row.FindControl("rdSel");
                Patient objPatient = (Patient)e.Row.DataItem;
                pbl.pCheckPatientisIPorOP(0, objPatient.PatientID, pOrg, out patientType);
                if (patientType == "Admitted")
                {
                    rdSel.Value = objPatient.Comments.Trim() + "~" + patientType;
                }
                else
                {
                    rdSel.Value = objPatient.Comments + "~" + "OP";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - SupplierList.aspx", ex);
            
        }
    }

}
