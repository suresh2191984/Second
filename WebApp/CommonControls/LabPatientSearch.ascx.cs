using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class CommonControls_LabPatientSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtMobilenumber.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtVisitNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string strPatientName = "";
        string strMnumber=string.Empty;
        long visitID = 0;
        long billID = 0;
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strPatientName = txtPatientName.Text;
        strMnumber = txtMobilenumber.Text;
        if (txtVisitNo.Text != "")
        {
            visitID = Convert.ToInt64(txtVisitNo.Text);
        }
        if (txtBillNo.Text != "")
        {
            billID = Convert.ToInt64(txtBillNo.Text);
        }
        try
        {
            returnCode = patientBL.SearchLabPatient(strPatientName, strMnumber, OrgID,visitID,billID, out lstPatient);
        }
        catch
        {
        }
        if (returnCode == 0 && lstPatient.Count>0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstPatient;
            grdResult.DataBind();
            HasResult = true;
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
        }
        onSearchComplete(this, e);
    }
    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;
                string strScript = "SelectRowCommonForLab('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
    }
    public long GetSelectedPatient()
    {
        long patientID = -1;
        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToInt32(Request.Form["pid"]);
        }
        return patientID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
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
}
