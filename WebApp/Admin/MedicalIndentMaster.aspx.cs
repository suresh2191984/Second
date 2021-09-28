using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Web.UI.HtmlControls;

public partial class Admin_MedicalIndentMaster : BasePage
{
    string Save_Msg = Resources.AppMessages.Save_Message;
    string Update_Msg = Resources.AppMessages.Update_Message;
    string Delete_Msg = Resources.AppMessages.Delete_Message;
    public Admin_MedicalIndentMaster()
        : base("Admin\\MedicalIndentMaster.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long Returncode = -1;
    AdminReports_BL objBl;
    AdminInvestigationRate IR = new AdminInvestigationRate();
    List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
    List<AdminInvestigationRate> lstgridRates = new List<AdminInvestigationRate>();
    List<RateMaster> lstRateMaster = new List<RateMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            objBl = new AdminReports_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                //LoadMedicalIndent();
                GetMedicalIndentMaster();
                //  loadRateType();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Page load", ex);
        }
    }

    public void LoadMedicalIndent()
    {
        try
        {
            long ClientId = 0;
            int iValue = 5;
            int PageCount = 0;
            Returncode = objBl.GetInvestigationRates(OrgID, iValue, ClientId, -1, -1, null, out lstRates, out lstgridRates, 1, 20, "", out PageCount,"0","0");
            gvMedicalIndent.DataSource = lstRates;
            gvMedicalIndent.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Medical Indents", ex);
        }
    }

    protected void gvMedicalIndent_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                MedicalIndentMaster obj = (MedicalIndentMaster)e.Row.DataItem;

                string Sct = "pUpdateItem('" + obj.MedicalIndentID + "','" + obj.ItemName + "')";

                HtmlInputButton objBtn = ((HtmlInputButton)e.Row.FindControl("btnEdit"));
                objBtn.Attributes.Add("onclick", Sct);
                //e.Row.Cells[0].Text=Convert.ToString((e.Row.RowIndex+1)+ (gvMedicalIndent.PageIndex*gvMedicalIndent.PageCount));                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Medical Indents", ex);
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            int MedicalindentID = 0;
            int MedicalID = Convert.ToInt16(btnID.Value);

            if (txtName.Text != String.Empty)
            {

                if (hdnbtnsave.Value != "Update")
                {
                    Returncode = objBl.pInsertMedicalIndentMaster(OrgID, txtName.Text.Trim().ToUpper(), Convert.ToInt16(LID), MedicalindentID);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "add", "alert('"+Save_Msg+"');fClear()", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "add", "alert('saved successfully.');fClear()", true);
                }
                else
                {
                    Returncode = objBl.pInsertMedicalIndentMaster(OrgID, txtName.Text.Trim().ToUpper(), Convert.ToInt16(LID), MedicalID);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "addexists", "alert('"+Update_Msg+"');fClear();", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "addexists", "alert('changes saved successfully');fClear();", true);
                }
            }

            //LoadMedicalIndent();
            GetMedicalIndentMaster();
            hdnbtnsave.Value = "";

            txtName.Text = String.Empty;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Medical Indents", ex);
        }
    }

    protected void gvMedicalIndent_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            Label lblid = (Label)gvMedicalIndent.Rows[e.RowIndex].FindControl("lblid");
            Returncode = objBl.pDeleteMedicalIndent(OrgID, int.Parse(lblid.Text));
            if (Returncode > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('"+Delete_Msg+"');", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('Deleted successfully');", true);
            }
            // LoadMedicalIndent();
            GetMedicalIndentMaster();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Delete Medical Indents", ex);
        }
    }

    protected void GetMedicalIndentMaster()
    {
        try
        {
            long returnCode = -1;
            List<MedicalIndentMaster> MDI = new List<MedicalIndentMaster>();
            AdminReports_BL obbl = new AdminReports_BL(base.ContextInfo);
            returnCode = obbl.GetMedicalIndentMaster(OrgID, out MDI);
            gvMedicalIndent.DataSource = MDI;
            gvMedicalIndent.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetMedicalIndentMaster", ex);
        }
    }

}

//public void loadRateType()
//{
//    try
//    {
//        Master_BL MasterBL = new Master_BL(base.ContextInfo);
//        Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
//        ddlRateName.DataSource = lstRateMaster;
//        ddlRateName.DataTextField = "RateName";
//        ddlRateName.DataValueField = "RateId";
//        ddlRateName.DataBind();
//    }
//    catch (Exception ex)
//    {
//        CLogger.LogError("Error in load data", ex);
//    }
//}
   
