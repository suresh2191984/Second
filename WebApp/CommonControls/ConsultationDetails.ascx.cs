using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Security.Principal;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class CommonControls_ConsultationDetails : BaseControl
{
    Physician_BL ObjPhysician;
    List<Physician> physicianList = new List<Physician>();
    protected string _Status = "";

    int _lVisitID = 0;
    public int lVisitID
    {
        get
        {
            return _lVisitID;
        }
        set
        {
            _lVisitID = value;
        }
    }

    public string Status
    {
        get { return _Status; }
        set { _Status = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       
            txtDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm tt");
            if (!IsPostBack)
            {
                DropDownShowVis();
                txtUnit.Text = "1";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tcons", "javascript:ConsDisplay('divConsultation');", true);
            }
    }

    public void DropDownShowVis()
    {
        IEnumerable PhysicianVis = null;
        ObjPhysician = new Physician_BL(base.ContextInfo);
        ObjPhysician.GetPhysicianListByOrg(OrgID, out physicianList, lVisitID);
        PhysicianVis = from pVis in physicianList where (pVis.PhysicianType == "VIS") select pVis;
        ddlPhysicianVis.DataSource = PhysicianVis;
        ddlPhysicianVis.DataTextField = "PhysicianName";
        ddlPhysicianVis.DataValueField = "Amount";
        ddlPhysicianVis.DataBind();
        ddlPhysicianVis.Items.Insert(0, "--Select--");
        ddlPhysicianVis.Items[0].Value = "0";
       ddlPhysicianVis.Items.Insert(1, "Others");
        ddlPhysicianVis.Items[1].Value = "1";
    }

    public List<PatientDueChart> getPatientConsultationDetails()
    {
        List<PatientDueChart> lstBillingDetails = new List<PatientDueChart>();


        string hidValue = iconHidDelete.Value;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientDueChart objBilling = new PatientDueChart();
                    objBilling.FeeID = Convert.ToInt64(lineItems[0]);
                    objBilling.FeeType = "CON";
                    objBilling.Description = lineItems[2];
                    objBilling.Comments = "";
                    objBilling.Status = Status;
                    objBilling.Amount = Convert.ToDecimal(lineItems[4]);
                    objBilling.Unit = Convert.ToInt32(lineItems[3]);
                    objBilling.FromDate = Convert.ToDateTime(lineItems[5]);
                    objBilling.ToDate = Convert.ToDateTime(lineItems[5]);

                    lstBillingDetails.Add(objBilling);
                }
            }
        }
        return lstBillingDetails;
    }

    public void clearItems()
    {
        iconHidDelete.Value = "";
        hdnShowAmount.Value = "";
    }
    //protected void ddlPhysicianVis_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtUnit.Enabled = true;
    //    string amt = ddlPhysicianVis.SelectedValue.ToString();
        
    //    txtAmount.Text = amt.Split('~')[0].ToString();
    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tcons", "javascript:ConsDisplay('divConsultation');", true);
    //}
}

