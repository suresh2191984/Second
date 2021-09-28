using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;

public partial class Patient_PendingRecommendation : BasePage
{
    PatientVisit Patient = new PatientVisit();
    PatientVisit_BL Patientvisit;
    long returncode = -1;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Patientvisit = new PatientVisit_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                Hdnvalue.Value = String.Empty;
                returncode = Patientvisit.GetRecommendationDetails(OrgID, out lstPatientVisit);
                if (lstPatientVisit.Count > 0)
                {
                    foreach (PatientVisit pd in lstPatientVisit)
                    {
                        Hdnvalue.Value += pd.PatientVisitId + "~" + pd.PatientID + "~" + pd.Name + "~" + pd.Sex + "^";
                       
                    }
                    gvPatient.DataSource = lstPatientVisit;
                    gvPatient.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }
    protected void gvPatient_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {               
               
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (gvPatient.PageIndex) * (gvPatient.PageSize));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientRecommendation", ex);
        }
    }
    protected void gvPatient_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("enter"))
            {
                long visitid = Convert.ToInt64(e.CommandArgument.ToString());
                foreach (string str in Hdnvalue.Value.Split('^'))
                {
                    string[] value = str.Split('~');
                    long vid = Convert.ToInt64(value[0]);
                    long pid = Convert.ToInt64(value[1]);
                    string sex = value[2].ToString();
                    string sp = "N";
                    if (visitid == vid)
                    {
                        Response.Redirect(Request.ApplicationPath + "/Patient/ViewEMRPackages.aspx?vid=" + visitid + "&pid=" + pid + "&sex=" + sex + "&sp=" + sp + "&PCL=Y" + "");//PCL Refers to display only PatientRecomendation Button.
                    }
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Log Error in gvPatient_RowCommand", ex);
        }
    }
    
}


