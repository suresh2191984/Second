using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;


public partial class Admin_ChangeCollectSampleDate : BasePage
{
    public Admin_ChangeCollectSampleDate(): base("Admin\\CashInFlow.aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        ACEVisitNumber.ContextKey = OrgID.ToString();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        long VisitID=0, returnCode=-1;      
        DateTime ApproedAt; DateTime CollectSample; DateTime ReceivedDate;
        Investigation_BL objInvestigation_BL = new Investigation_BL(base.ContextInfo);

        VisitID = !string.IsNullOrEmpty(hdnVisitID.Value) == true ? Convert.ToInt64(hdnVisitID.Value) : -1;
        CollectSample = !string.IsNullOrEmpty(txtCollectSampleDate.Text) == true ? Convert.ToDateTime(txtCollectSampleDate.Text) : Convert.ToDateTime("1/1/1753 12:00:00 AM");
        ApproedAt = !string.IsNullOrEmpty(txtApprovedDate.Text) == true ? Convert.ToDateTime(txtApprovedDate.Text) : Convert.ToDateTime("1/1/1753 12:00:00 AM");
        ReceivedDate = !string.IsNullOrEmpty(txtSampleReceivedDate.Text) == true ? Convert.ToDateTime(txtSampleReceivedDate.Text) : Convert.ToDateTime("1/1/1753 12:00:00 AM");
      
        returnCode = objInvestigation_BL.UpdateCollectReceiveApprovedDate_BL(VisitID, OrgID, txtVisitNumber.Text.ToString(), CollectSample, ReceivedDate, ApproedAt);
        if (returnCode>-1)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "alert('Updated Successfully');", true);
        }
        Clear();
       
    }
    private void Clear()
    {
        hdnVisitID.Value = string.Empty;
        txtVisitNumber.Text = string.Empty;
        txtSampleReceivedDate.Text = string.Empty;
        txtCollectSampleDate.Text = string.Empty;
        txtApprovedDate.Text = string.Empty;
       
    }

} 
