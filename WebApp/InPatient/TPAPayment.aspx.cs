using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class InPatient_TPAPayment : BasePage
{
    int IPtype;
    public InPatient_TPAPayment()
        : base("InPatient\\TPAPayment.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            InsuranceSearch1.onSearchComplete += new EventHandler(InsuranceSearch1_onSearchComplete);
            if (!IsPostBack)
            {

                if (RoleID == 1)
                {
                    //PhyHeader1.Visible = true;
                    //UsrHeader1.Visible = false;
                }
                else
                {
                    //PhyHeader1.Visible = false;
                    //UsrHeader1.Visible = true;
                }
                IPtype = Convert.ToInt32(TaskHelper.SearchType.TPASearch);
                long returnCode = -1;
                Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
                List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IPtype, out lstActionMaster); //returnCode = nurseBL.GetSearchActionsInPatient(RoleID, IPtype, out pages);


                if (OrgID == 78)
                {
                    if (RoleName == "Accounts")
                    {
                        bGo.Visible = true;
                        BtnSave.Visible = false;
                    }
                    else
                    {
                        bGo.Visible = false;
                        BtnSave.Visible = true;
                    }
                }
                else
                {
                    bGo.Visible = true;
                }
                

                //string strConfigKey = "IsSurgeryAdvance";
                //string configValue = GetConfigValue(strConfigKey, OrgID);

                //if (configValue == "N")
                //{
                //    var lstAction = from Res in lstActionMaster
                //                    where Res.ActionName != "Collect Surgery Advance"
                //                    select Res;
                //    dList.DataSource = lstAction;
                //    dList.DataTextField = "ActionName";
                //    dList.DataValueField = "PageURL";
                //    dList.DataBind();
                //}
                //else
                //{
                //    dList.DataSource = lstActionMaster;
                //    dList.DataTextField = "ActionName";
                //    dList.DataValueField = "PageURL";
                //    dList.DataBind();
                //}
                //if (Request.QueryString["showMsg"] == "True")
                //{
                //    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "chkItems", "javascript:alert('Check item and then click Go');", true);
                //}

            }

            bGo.PostBackUrl = "~/InPatient/TpaPaymentCollection.aspx";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page_Load in tpaPayment page", ex);
        }
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
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void InsuranceSearch1_onSearchComplete(object sender, EventArgs e)
    {
        if (InsuranceSearch1.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            hdnField.Value = InsuranceSearch1.GetValue();
            //if (hdnField.Value == string.Empty)
            //{
            //    Response.Redirect("~/InPatient/TPAPayment.aspx?showMsg=True", false);

            //}
        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in TPApayment .aspx", ex);
        }
    }
   
    protected void BtnSave_click(object sender, EventArgs e)
    {
        try
        {
            long finalBillID = -1;
            long PatientID = -1;
            long VisitID = -1;
            string Status = string.Empty;
            // decimal writeoff = 0;
            long returncode = -1;
            DateTime SettlementDate = DateTime.MinValue;
            DateTime ClaimForwaredDate = DateTime.MinValue;


            List<PatientDueChart> pDueChrt = new List<PatientDueChart>();
            GridView grdview = (GridView)InsuranceSearch1.FindControl("grdResult");
            foreach (GridViewRow GR in grdview.Rows)
            {
                CheckBox cbox = (CheckBox)GR.FindControl("rdSel");
                if (cbox.Checked)
                {
                    PatientDueChart PDChart = new PatientDueChart();
                    PatientID = Convert.ToInt64(grdview.DataKeys[GR.RowIndex][0].ToString());
                    VisitID = Convert.ToInt64(grdview.DataKeys[GR.RowIndex][1].ToString());
                    finalBillID = Convert.ToInt64(grdview.DataKeys[GR.RowIndex][2].ToString());
                    TextBox txtdate = (TextBox)GR.FindControl("txtClaimForwardDate");
                    if (txtdate.Text != "")
                    {
                        ClaimForwaredDate = Convert.ToDateTime(txtdate.Text);
                    }
                    else
                    {
                        ClaimForwaredDate = Convert.ToDateTime("1/1/1753");
                    }

                    PDChart.ToDate = Convert.ToDateTime(ClaimForwaredDate);
                    PDChart.DetailsID = finalBillID;
                    PDChart.PatientID = PatientID;
                    PDChart.CreatedBy = Convert.ToInt32(LID);
                    PDChart.VisitID = VisitID;
                    PDChart.Description = "Update";
                    PDChart.Status = "Pending";
                    PDChart.FromDate = Convert.ToDateTime("1/1/1753");
                    PDChart.TPAApprovedDate = Convert.ToDateTime("1/1/1753");
                    //PDChart.RightOff = 0;

                    //PDChart.FromDate = "NULL";
                    //PDChart.RightOff = null;
                    pDueChrt.Add(PDChart);

                }
            }
            if (pDueChrt.Count > 0)
            {
                returncode = new IP_BL(base.ContextInfo).InsertTPAPayment(pDueChrt, OrgID);
                string sPath = "InPatient\\\\TPAPayment.aspx.cs_4";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);

                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "InPatient\\TPAPayment.aspx.cs_4").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "dueChart", "alert('" + sUserMsg + "')", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "dueChart", "javascript:alert('Claim forward Date save Succesfully');", true);
                //}
                //Response.Redirect("../Inpatient/TPAPayment.aspx", true);
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save FinalBill ", ex);
        }
    }
}



