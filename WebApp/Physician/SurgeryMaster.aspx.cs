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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
public partial class Physician_SurgeryMaster : BasePage
{
    Master_BL Master_BL;
    IPTreatmentPlan objTreatmentPlan = new IPTreatmentPlan();
    List<IPTreatmentPlan> lstTreatmentPlan = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lstGetTreatmentPlan = new List<IPTreatmentPlan>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Master_BL = new Master_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            GetTreatmentPlan();            
            SurgeryMasterItems();
        }
    }

    public void GetTreatmentPlan()
    {
        try
        {
            Master_BL.GetTreatmentPlan(OrgID, out lstGetTreatmentPlan);
            rblTreatmentplan.DataSource = lstGetTreatmentPlan;
            rblTreatmentplan.DataValueField = "OperationID";
            rblTreatmentplan.DataTextField = "PhysicianName";
            rblTreatmentplan.DataBind();
            rblTreatmentplan.Items.Add(new ListItem("All", "-1"));
            rblTreatmentplan.SelectedValue = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load - SurgeryMaster.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public void SurgeryMasterItems()
    {
        try
        {
            string sVal = "0";
            long pID= -1;
            long returnCode = -1;
            hdnTreatmentType.Value = "";
            hdnCheckIsUsed.Value = "";
            returnCode=Master_BL.GetSurgeryMasterItems(OrgID, out lstTreatmentPlan);
            if (lstTreatmentPlan.Count > 0)
            {
                for (int i = 0; i < lstTreatmentPlan.Count; i++)
                {
                    hdnCheckIsUsed.Value += lstTreatmentPlan[i].PhysicianName +"^";
                }
            }
            pID = Convert.ToInt64(rblTreatmentplan.SelectedItem.Value);
            if (pID != -1)
            {
                gvSurgeryMaster.DataSource = lstTreatmentPlan.FindAll(p => p.OperationID == pID).ToList();
            }
            else
            {
                sVal = "1";
                hdnTreatmentType.Value = sVal;
                gvSurgeryMaster.DataSource = lstTreatmentPlan;
            }
            gvSurgeryMaster.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load - SurgeryMaster.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            
                objTreatmentPlan.PhysicianName = txtCode.Text.Trim();
                objTreatmentPlan.IPTreatmentPlanName = txtDisplayText.Text.Trim();
                objTreatmentPlan.OrgID = OrgID;
                objTreatmentPlan.CreatedBy = LID;
                if (hdnStatus.Value == "Save")
                {
                    objTreatmentPlan.OperationID = Convert.ToInt64(rblTreatmentplan.SelectedValue);
                    objTreatmentPlan.ParentName = rblTreatmentplan.SelectedItem.Text;
                }
                if (hdnStatus.Value == "Update")
                {
                    objTreatmentPlan.OperationID = Convert.ToInt64(hdnTreatmentplan.Value);
                    objTreatmentPlan.ParentName = hdnTreatmentplanName.Value;
                }
                objTreatmentPlan.Status = "YES";
                if (chkDelete.Checked == true)
                {
                    objTreatmentPlan.Status = "NO";
                }
                returnCode = Master_BL.SaveSurgeryMasterItems(objTreatmentPlan);
                if (returnCode > 0)
                {
                    SurgeryMasterItems();
                    if (hdnStatus.Value == "Update")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update", "alert('Code Updated Successfully')", true);
                    }
                    if (hdnStatus.Value == "Save")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update", "alert('Code Added Successfully')", true);
                    }
                }
                else
                {
                    if (hdnStatus.Value == "Update")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update", "alert('Code Updated Failed')", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update", "alert('Code Added Failed')", true);
                    }
                }
                Clear();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving SurgeryCode - SurgeryMaster.aspx", ex);
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void rblTreatmentplan_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtCode.Text = "";
        txtDisplayText.Text = "";
        chkDelete.Checked = false;
        SurgeryMasterItems();
    }
    public void Clear()
    {
        hdnStatus.Value = "";
        txtCode.Text = "";
        txtDisplayText.Text = "";
        chkDelete.Checked = false;
    }
    protected void gvSurgeryMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvSurgeryMaster.PageIndex = e.NewPageIndex;
            SurgeryMasterItems();
        }
    }
}
