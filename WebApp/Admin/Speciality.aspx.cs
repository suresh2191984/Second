using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

public partial class Admin_Speciality : BasePage
{
    long returnCode = -1;
    Speciality_BL specialityBL ;
    List<Speciality> lstSpeciality = new List<Speciality>();  
    Speciality ObjSpeciality = new Speciality();
    string spcialityname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        specialityBL = new Speciality_BL(base.ContextInfo);
        btnRefresh.Visible = false;
        if (!IsPostBack)
        {
            GetSpecialityName();
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Speciality.aspx");
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("Speciality.aspx");
    }
    protected void grdView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                txtSpecialityName.Text = "";
                txtSpecialityName.Text = Convert.ToString(grdView.DataKeys[RowIndex][1]);
                hdnSpecialityID.Value = Convert.ToString(grdView.DataKeys[RowIndex][0]);
                btnSave.Text = "Update";
                txtSpecialityName.Focus();
                GridViewRow row = (GridViewRow)grdView.Rows[RowIndex];                
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Drug Details to Update", ex);
        }
    }
    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdView.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdView.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }
    protected void grdView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdView, "Select$" + e.Row.RowIndex));               
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Drug Details to Update", ex);
        }
    }
    private void GetSpecialityName()
    {
        specialityBL.pViewSpeciality(OrgID, out lstSpeciality);
            if(lstSpeciality.Count > 0)
            {
                grdView.Visible = true;
                grdView.DataSource = lstSpeciality;
                grdView.DataBind();
                lblstatus.Visible = false;
            }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string specialityname = txtSearch.Text;
        specialityBL.SearchSpeciality(OrgID, specialityname, out lstSpeciality);
        if (lstSpeciality.Count > 0)
        {
            grdView.Visible = true;
            grdView.DataSource = lstSpeciality;
            grdView.DataBind();
            lblstatus.Visible = false;
        }
        else
        {
            lblstatus.Visible = true;
            grdView.Visible = false;
            lblstatus.Text = "No Matching Records Found!";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long SpecialityID = -1;
        try
        {
            if (btnSave.Text == "Save")
            {
                ObjSpeciality.SpecialityName = txtSpecialityName.Text;                
                returnCode = specialityBL.pSaveSpecialityName(ObjSpeciality, out SpecialityID);
                if (returnCode == 0)
                {
                    txtSpecialityName.Text = "";
                    lblstatus.Visible = true;
                    btnRefresh.Visible = true;
                    hdnSpecialityID.Value = "";
                    lblstatus.Text = "Speciality Name Is Successfully Added";
                    btnCancel.Enabled = false;
                }
            }
            else if (btnSave.Text == "Update")
            {
                ObjSpeciality.SpecialityID = Convert.ToInt32(hdnSpecialityID.Value);
                ObjSpeciality.SpecialityName= txtSpecialityName.Text;
                string lid = Convert.ToString(LID);
                ObjSpeciality.ModifiedBy = lid;
                returnCode = specialityBL.pUpdateSpecialityName(ObjSpeciality);
                if (returnCode == 0)
                {
                    txtSpecialityName.Text = "";
                    lblstatus.Visible = true;
                    btnRefresh.Visible = true;
                    hdnSpecialityID.Value = "";
                    lblstatus.Text = "Speciality Name  Is Successfully Updated";
                    btnCancel.Enabled = false;
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Brand Name", excep);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
}
