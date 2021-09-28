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

public partial class Investigation_InvQualitativeResultMaster : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtInvQualita.Focus();
                GetInvQualitativeResultMaster();
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
                Investigation_BL perphy = new Investigation_BL(base.ContextInfo);
                string phyname = txtInvQualita.Text;
                returncode = perphy.PInsertInvQualitactiveResultMaster(OrgID, phyname);
                    txtInvQualita.Text = "";
                    //btnSave.Enabled = false;
                    txtInvQualita.Focus();
                    GetInvQualitativeResultMaster();
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
    private void GetInvQualitativeResultMaster()
    {
        try
        {
            long returnCode = -1;
            Investigation_BL perphy = new Investigation_BL(base.ContextInfo);
            List<InvQualitativeResultMaster> lstInvQual = new List<InvQualitativeResultMaster>();
            returnCode = perphy.PGetInvQualitativeResult(OrgID, out lstInvQual);
            if (lstInvQual.Count > 0)
            {

                grdInv.Visible = true;
                grdInv.DataSource = lstInvQual;
                grdInv.DataBind();

                //btnEdit.Visible = true;
                //btnDelete.Visible = true;
            }
            else
            {
                grdInv.Visible = false;
                lblMsg.Text = "No Matcing Records Found";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome", ex);
        }
    }
    protected void grdInv_RowDataBound(Object sender, GridViewRowEventArgs e)
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
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdInv, "Select$" + e.Row.RowIndex));
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
    protected void grdInv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex == grdInv.PageCount)
        {
            //ImageButton ibtnNext = (ImageButton)(grdInv.BottomPagerRow.FindControl("lnkNext"));
            //if (ibtnNext != null) ibtnNext.Visible = false;
        }
        if (e.NewPageIndex >= 0)
        {
            grdInv.PageIndex = e.NewPageIndex;
            GetInvQualitativeResultMaster();
        }

    }
    protected void grdInv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            string txt = grdInv.DataKeys[e.RowIndex].Values[1].ToString();
            int phId = Convert.ToInt32(grdInv.DataKeys[e.RowIndex].Values[0].ToString());
            Investigation_BL perphy = new Investigation_BL(base.ContextInfo);
            returnCode = perphy.PdeleteInvQualitativeResultMaster(OrgID,phId, txt);
            if (returnCode != -1)
            {
                //lblRe.Text = "Perpormfing Physician Deative";
                GetInvQualitativeResultMaster();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
        }
    }
    protected void grdInv_RowCommand(object sender, GridViewCommandEventArgs e)
    {


        if (e.CommandName == "ACTIVE")
        {
            long returnCode = -1;
            try
            {
                //string Name = grdResult.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
                int Phyid = Convert.ToInt16(grdInv.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString());
                string PhyName = grdInv.DataKeys[Convert.ToInt32(e.CommandArgument)][1].ToString();
                Physician_BL perphy = new Physician_BL(base.ContextInfo);
                returnCode = perphy.Activeperformingphysician(Phyid, PhyName, OrgID);
                if (returnCode != -1)
                {
                    //lblRe.Text = "Perpormfing Physician Active";
                    GetInvQualitativeResultMaster();
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
            }
        }


    }


    protected void grdInv_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdInv.EditIndex = e.NewEditIndex;
        GetInvQualitativeResultMaster();
    }
    protected void grdInv_RowCancelling(object sender, GridViewCancelEditEventArgs e)
    {
        grdInv.EditIndex = -1;
        GetInvQualitativeResultMaster();
    }
    protected void grdInv_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string s = grdInv.DataKeys[e.RowIndex][0].ToString();
        Label PhyID = grdInv.Rows[e.RowIndex].FindControl("lblId") as Label;
        TextBox PhyName = (TextBox)grdInv.Rows[e.RowIndex].FindControl("txtQualitativeResultName");
        //TextBox PhyQli = (TextBox)grdInv.Rows[e.RowIndex].FindControl("txtPhyQul");
        long returnCode = -1;
        try
        {
            int phyid = Convert.ToInt32(s);
            Investigation_BL perphy = new Investigation_BL(base.ContextInfo);
            returnCode = perphy.PUpdateInvQualitativeResultMaster(OrgID, phyid, PhyName.Text);
            if (returnCode != -1)
            {
                //lblRe.Text = "Successfully Update  :" + PhyName.Text;
                GetInvQualitativeResultMaster();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
        }
        grdInv.EditIndex = -1;
        GetInvQualitativeResultMaster();

    }
}
