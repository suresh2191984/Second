using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Investigation_InvestigationDisplay :BasePage
{
    public Investigation_InvestigationDisplay()
        : base("Investigation_InvestigationDisplay_aspx")
    {
    }

    long patientVisitId = 0;
    string viewer = string.Empty;
    long returnCode = -1;
    List<InvestigationValues> investValues;
        
    #region "Common Resource Property"

    string strApproved = Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_01 == null ? "Approve" : Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_01;
    string strOk = Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_02 == null ? "Ok" : Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_02;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["vid"] != null)
        {

            try
            {
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                investValues = new List<InvestigationValues>();
                List<InvestigationDisplayName> lstDisplayName = new List<InvestigationDisplayName>();
                List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                long lResult = -1;                
                patientVisitId = Convert.ToInt64(Request.QueryString["vid"]);
                viewer = Convert.ToString(Request.QueryString["aut"]);
                lResult = investigationBL.GetInvestigationResults(patientVisitId, out investValues, out lstDisplayName, out lstPatientInvSampleResults);
                if (viewer != "phy")
                {
                    btnSave.Text = strApproved.Trim();
                }
                else
                {
                    btnSave.Text = strOk.Trim();
                }
                if (lstPatientInvSampleResults.Count > 0)
                {
                    grdSampleResults.DataSource = lstPatientInvSampleResults;
                    grdSampleResults.DataBind();
                }
                if (lstDisplayName.Count > 0)
                {
                    chkInvLst.DataSource = lstDisplayName;
                    chkInvLst.DataTextField = "InvestigationName";
                    //chkInvLst.DataValueField = "InvestigaionID";
                    chkInvLst.DataBind();

                    foreach (ListItem li in chkInvLst.Items)
                    {
                        li.Selected = true;
                        //li.Enabled = false;
                    }
                }


                if (MicroBioDiplay1.displayMicro(investValues, lstDisplayName))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "d1002", "<script>document.getElementById('DMicro').style.display='block';</script>");
                }
                if (BioChemistryDisplay1.diplayBiochemistry(investValues, lstDisplayName))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "d1003", "<script>document.getElementById('DBio').style.display='block';</script>");
                }
                if (HemotologyDisplay1.diplayHemotology(investValues, lstDisplayName))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "d1004", "<script>document.getElementById('DHemat').style.display='block';</script>");
                }
                if (ClinicalDisplay1.diplayBiochemistry(investValues, lstDisplayName))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "d1005", "<script>document.getElementById('DClinic').style.display='block';</script>");
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading InvestigationDisplay", ex); 
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnSave.Text == strApproved.Trim())
            {
                Investigation_BL investBL = new Investigation_BL(base.ContextInfo);
                List<PatientInvestigation> lstPatInv = ConvertTo(investValues);
                int count = 0;
                //for (int i = 0; i < lstPatInv.Count; i++)
                //{
                //    lstPatInv[i].Status = "APPROVE";
                //}
                investBL.UpdateSampleCollected(lstPatInv, 2, out count);

                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
            else
            {
                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    private List<PatientInvestigation> ConvertTo(List<InvestigationValues> lstValues)
    {
        List<PatientInvestigation> lstPatInv = new List<PatientInvestigation>();
        PatientInvestigation obj;
        for (int i = 0; i < lstValues.Count; i++)
        {
            obj = new PatientInvestigation();
            obj.InvestigationID = Convert.ToInt32(lstValues[i].InvestigationID);
            obj.PatientVisitID = patientVisitId;
            obj.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            obj.Status = "APPROVED";
            lstPatInv.Add(obj);
        }

        return lstPatInv;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    #endregion
}
