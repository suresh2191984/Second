using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data.OleDb;
using System.IO;
using System.Data;

public partial class Physician_PerformingPhysician : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtPhysicianName.Focus();
                GetperformingphysicianDetails();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading  Page", ex);
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        try
        {
            if (btnSave.Text == " Save ")
            {
                //string pOrg = Request.QueryString["OrgID"].ToString();
                Physician_BL perphy = new Physician_BL(base.ContextInfo);
                string phyname = txtPhysicianName.Text;
                string phyqly = txtQulification.Text;
                returncode = perphy.PerfomingPhysician(phyname, phyqly, OrgID);
                if (returncode == 1)
                {
                    lblRe.Text = "Perpormfing Physician Added";
                    txtPhysicianName.Text = "";
                    txtQulification.Text = "";
                    //btnSave.Enabled = false;
                    txtPhysicianName.Focus();
                    GetperformingphysicianDetails();
                }
            }
            else if (btnSave.Text == "Update")
            {
                //lblRe.Text = "Perpormfing Physician Update";
                //btnSave.Text = "Save";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Performing Physician", ex);
        }
    }
    private void GetperformingphysicianDetails()
    {
        try
        {
            long returnCode = -1;
            Physician_BL perphy = new Physician_BL(base.ContextInfo);
            List<PerformingPhysician> lstperphysician = new List<PerformingPhysician>();
            List<ReferingPhysician> lstRefphysician = new List<ReferingPhysician>();
            returnCode = perphy.Getperformingphysician(OrgID, out lstperphysician);
            returnCode = perphy.GetReferingphysician(OrgID, out lstRefphysician);
            if (lstperphysician.Count > 0)
            {

                grdResult.Visible = true;
                grdResult.DataSource = lstperphysician;
                grdResult.DataBind();

                //btnEdit.Visible = true;
                //btnDelete.Visible = true;
            }
            else
            {
                grdResult.Visible = false;
                lblMsg.Text = "No Matcing Records Found";
            }
            if (lstperphysician.Count > 0)
            {

                grdRefphy.Visible = true;
                grdRefphy.DataSource = lstRefphysician;
                grdRefphy.DataBind();

                //btnEdit.Visible = true;
                //btnDelete.Visible = true;
            }
            else
            {
                grdRefphy.Visible = false;
                lblMsg.Text = "No Matcing Records Found";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome", ex);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Users p = (Users)e.Row.DataItem;
                ////string strScript = "SelectUserName('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.LoginID + "', '" + p.RoleName + "', '" + p.RoleID + "', '" + p.OrgUserID + "');";
                //string strScript = "SelectUserName('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.LoginID + "', '" + p.RoleName + "');";
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //Label lbl = (Label)e.Row.FindControl("lbledit");
                //lbl.Text = "Edit";
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading User Details to Change or Remove", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex == grdResult.PageCount)
        {
            //ImageButton ibtnNext = (ImageButton)(grdResult.BottomPagerRow.FindControl("lnkNext"));
            //if (ibtnNext != null) ibtnNext.Visible = false;
        }
        if (e.NewPageIndex >= 0)
        {
            grdResult.PageIndex = e.NewPageIndex;
            GetperformingphysicianDetails();
        }

    }
    protected void grdResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            string txt = grdResult.DataKeys[e.RowIndex].Values[1].ToString();
            int phId = Convert.ToInt16(grdResult.DataKeys[e.RowIndex].Values[0].ToString());
            Physician_BL perphy = new Physician_BL(base.ContextInfo);
            returnCode = perphy.Deleteperformingphysician(phId, txt, OrgID);
            if (returnCode != -1)
            {
                lblRe.Text = "Perpormfing Physician Deative";
                GetperformingphysicianDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {


        if (e.CommandName == "ACTIVE")
        {
            long returnCode = -1;
            try
            {
                //string Name = grdResult.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
                int Phyid = Convert.ToInt16(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString());
                string PhyName = grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][1].ToString();
                Physician_BL perphy = new Physician_BL(base.ContextInfo);
                returnCode = perphy.Activeperformingphysician(Phyid, PhyName, OrgID);
                if (returnCode != -1)
                {
                    lblRe.Text = "Perpormfing Physician Active";
                    GetperformingphysicianDetails();
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
            }
        }


    }
    protected void grdRefphy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex == grdRefphy.PageCount)
        {
            //ImageButton ibtnNext = (ImageButton)(grdResult.BottomPagerRow.FindControl("lnkNext"));
            //if (ibtnNext != null) ibtnNext.Visible = false;
        }
        if (e.NewPageIndex >= 0)
        {
            grdRefphy.PageIndex = e.NewPageIndex;
            GetperformingphysicianDetails();
        }

    }

    protected void grdResult_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdResult.EditIndex = e.NewEditIndex;
        GetperformingphysicianDetails();
    }
    protected void grdResult_RowCancelling(object sender, GridViewCancelEditEventArgs e)
    {
        grdResult.EditIndex = -1;
        GetperformingphysicianDetails();
    }
    protected void grdResult_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string s = grdResult.DataKeys[e.RowIndex][0].ToString();
        Label PhyID = grdResult.Rows[e.RowIndex].FindControl("lblId") as Label;
        TextBox PhyName = (TextBox)grdResult.Rows[e.RowIndex].FindControl("txtphysicianName");
        TextBox PhyQli = (TextBox)grdResult.Rows[e.RowIndex].FindControl("txtPhyQul");
        long returnCode = -1;
        try
        {
            int phyid = Convert.ToInt32(s);
            Physician_BL perphy = new Physician_BL(base.ContextInfo);
            returnCode = perphy.Updateperformingphysician(phyid, PhyName.Text, PhyQli.Text, OrgID);
            if (returnCode != -1)
            {
                lblRe.Text = "Successfully Update  :" + PhyName.Text;
                GetperformingphysicianDetails();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
        }
        grdResult.EditIndex = -1;
        GetperformingphysicianDetails();

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        
        for (int i = 0; i < grdRefphy.Rows.Count; i++)
        {
            CheckBox chkDelete = (CheckBox)grdRefphy.Rows[i].Cells[0].FindControl("chkSelect");
            long returnCode = -1;
            try
            {
                if (chkDelete.Checked == true)
                {
                    string phyname;
                    string phyuli;
                    phyname = grdRefphy.Rows[i].Cells[2].Text;
                    phyuli = grdRefphy.Rows[i].Cells[3].Text;
                    Physician_BL perphy = new Physician_BL(base.ContextInfo);
                    returnCode = perphy.PerfomingPhysician(phyname, phyuli, OrgID);
                    
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Add PerformingPhysician.aspx", ex);
            }
        }
        GetperformingphysicianDetails();
        chkReferingphysician.Checked = false;
        
    }
}
