using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using AjaxControlToolkit;
using System.Collections;
using System.Web.UI.HtmlControls;

public partial class Admin_ProcedureMaster : BasePage
{
    PatientVisit_BL patientvisitBL;
    Master_BL masterBL;
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<ProcedureMasterMain> lstProcedureMasterMain = new List<ProcedureMasterMain>();
    List<ProcedureMasterSub> lstProcedureMasterSub = new List<ProcedureMasterSub>();
    long procID;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            patientvisitBL = new PatientVisit_BL(base.ContextInfo);
            masterBL = new Master_BL(base.ContextInfo);
            divChk.Style.Add("display", "none");
            divmodpop.Style.Add("display", "none");
            if (!IsPostBack)
            {
                //LoadVisitpurpose();
                LoadProcname();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occur in Page_Load", ex);
        }
    }

    //public void LoadVisitpurpose()
    //{
    //    patientvisitBL.GetVisitPurpose(OrgID, "MAP", out lstVisitPurpose);
    //    if(lstVisitPurpose.Count > 0)
    //    {
    //        ddlproceduretype.DataSource = lstVisitPurpose;
    //        ddlproceduretype.DataValueField = "VisitPurposeID";
    //        ddlproceduretype.DataTextField = "VisitPurposeName";
    //        ddlproceduretype.DataBind();
    //    }
    //}
    public void LoadProcname()
    {
        masterBL.GetProcedreMaster(OrgID, 0, out lstProcedureMasterMain, out lstProcedureMasterSub);
          if(lstProcedureMasterMain.Count>0)
          {
              rdnlstname.DataSource=lstProcedureMasterMain;
              rdnlstname.DataValueField="ProcID";
              rdnlstname.DataTextField="ProcName";
              rdnlstname.DataBind();
          }
    }
    public void rdnlstname_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtproceduredesc.Text = "";
        procID = Convert.ToInt64(rdnlstname.SelectedValue);
        hdnProcID.Value = rdnlstname.SelectedValue;
        LoadGrid();
    }

    public void LoadGrid()
    {
        procID = Convert.ToInt64(rdnlstname.SelectedValue);
        try
        {
            masterBL.GetProcedreMaster(OrgID, procID, out lstProcedureMasterMain, out lstProcedureMasterSub);
            if (lstProcedureMasterSub.Count > 0)
            {
                txtproceduredesc.Text = "";
                chkActive.Checked = false;
                grdView.Visible = true;
                grdView.DataSource = lstProcedureMasterSub;
                grdView.DataBind();
            }
            else
            {
                grdView.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Procedure Master", ex);
        }
    }
    protected void grdView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ProcedureMasterSub objProcedureMasterSub = (ProcedureMasterSub)e.Row.DataItem;
                string edt = "EditFunc('" + objProcedureMasterSub.ProcMainID + "','" + objProcedureMasterSub.ProcDesc + "','" + objProcedureMasterSub.RunningID + "','" + objProcedureMasterSub.IsVisitPurpose + "')";
                HtmlInputButton objBtn = ((HtmlInputButton)e.Row.FindControl("btnEdit"));
                objBtn.Attributes.Add("onclick", edt);
                LinkButton lnkbtn = ((LinkButton)e.Row.FindControl("lnkDelete"));
                Label lbl = (Label)e.Row.FindControl("lblIsVisitPurpose");
                if (lbl.Text == "Y")
                {
                    lnkbtn.Enabled = true;
                }
                else
                {
                    lnkbtn.Enabled = false;
                }             
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Editing Procedure Description", ex);
        }
    }

    protected void grdView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            if (hdndelete.Value == "1")
            {
                string runID = grdView.DataKeys[e.RowIndex].Values[0].ToString();
                ProcedureMasterSub objProcedureMasterSub = new ProcedureMasterSub();
                string sType = "D";
                objProcedureMasterSub.RunningID = Convert.ToInt64(runID);
                objProcedureMasterSub.ProcMainID = 0;
                objProcedureMasterSub.OrgID = Convert.ToInt64(OrgID);
                objProcedureMasterSub.ProcDesc = string.Empty;
                objProcedureMasterSub.IsVisitPurpose = string.Empty;
                returnCode = masterBL.SaveProcDescription(sType, objProcedureMasterSub, LID);
                LoadGrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Deleting Proc Description", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            string sType;
            ProcedureMasterSub objProcedureMasterSub = new ProcedureMasterSub();
            if (hdnBtnID.Value == "0")
            {
                sType = "S";
            }
            else
            {
                sType = "U";
            }
            objProcedureMasterSub.ProcDesc = txtproceduredesc.Text;
            objProcedureMasterSub.OrgID = Convert.ToInt64(OrgID);
            objProcedureMasterSub.ProcMainID = Convert.ToInt64(rdnlstname.SelectedValue);
            objProcedureMasterSub.RunningID = Convert.ToInt64(hdnRunID.Value);
            if (chkActive.Checked == true)
            {
                objProcedureMasterSub.IsVisitPurpose = "Y";
            }
            else
            {
                objProcedureMasterSub.IsVisitPurpose = "N";
            }
            returnCode = masterBL.SaveProcDescription(sType, objProcedureMasterSub, LID);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "add", "alert('saved successfully.');Reset()", true);
                LoadGrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Proc Description", ex);
        }
    }
    protected void btnSaveProc_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            ProcedureMasterMain objProcedureMasterMain = new ProcedureMasterMain();
            objProcedureMasterMain.ProcName = txtProcName.Text;
            returnCode = masterBL.SaveProcedureMain(objProcedureMasterMain);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "add", "alert('Saved successfully.');Reset()", true);
                LoadProcname();
                grdView.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Proc Description", ex);
        }

    }
}
