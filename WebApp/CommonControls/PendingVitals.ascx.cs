using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class CommonControls_PendingVitals : BaseControl
{
    private int orgID;

    public CommonControls_PendingVitals()
        : base("CommonControls_PendingVitals_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    public int OrgID
    {
        get
        {
            return OrgID;
        }
        set
        {
            OrgID = value;
            LoadPendingPatientsForVitals();
        }
    }

    private void LoadPendingPatientsForVitals()
    {
        long returnCode = -1;

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstPatient = new List<Patient>();

        try
        {
            returnCode = patientBL.GetPendingPatientsForVitals(OrgID, out lstPatient);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetPendingPatientsForVitals SP", ex);
        }

        if (returnCode == 0 && lstPatient.Count > 0)
        {
            grdPendingVitals.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdPendingVitals.DataSource = lstPatient;
            grdPendingVitals.DataBind();
        }
        else
        {
            grdPendingVitals.Visible = false;
            lblResult.Visible = true;
            string UsrMsgClientDisp = Resources.CommonControls_ClientDisplay.CommonControls_PendingVitals_ascx_01 == null ? "No Vitals pending to be captured!!!" : Resources.CommonControls_ClientDisplay.CommonControls_PendingVitals_ascx_01;
            lblResult.Text = UsrMsgClientDisp;
        }
    }

    protected void grdPendingVitals_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Display the RedExclaim image
            Patient p = (Patient)e.Row.DataItem;
            if (p.BGColor.ToUpper() == "RED")
            {
                //e.Row.BackColor = System.Drawing.Color.Orange;
                e.Row.CssClass = "patientSearch";
            }
            e.Row.ToolTip = "Collect Vitals";
            e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            e.Row.Attributes.Add("onclick",this.Page.ClientScript.GetPostBackClientHyperlink(this.grdPendingVitals, "Select$" + e.Row.RowIndex));
        }
    }

    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdPendingVitals.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdPendingVitals.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }

    protected void grdPendingVitals_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                int ID; //ID is GridView's DataKeyNames field

                ID = Convert.ToInt32(grdPendingVitals.DataKeys[RowIndex][0]);

                Response.Redirect("~/Nurse/PatientVitals.aspx?PatientID=" + ID.ToString(), true);

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
}
