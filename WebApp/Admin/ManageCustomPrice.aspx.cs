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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Linq;
using Attune.Podium.Common;

public partial class Admin_ManageCustomPrice : BasePage
{
    long returnCode = -1;
    int RefPhyID;
    long RefOrgID;
    List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();
    List<LabReferenceOrg> getReferingHospital = new List<LabReferenceOrg>();
    List<LabReferenceOrg> getReferingHospitalTemp = new List<LabReferenceOrg>();
    Patient_BL patBL;
    Investigation_BL invBL;
    List<PCCustomPriceMapping> lstPCCPM = new List<PCCustomPriceMapping>();
    List<PCCustomPriceMapping> lstPCCPMSave = new List<PCCustomPriceMapping>();
    List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            patBL = new Patient_BL(base.ContextInfo);
            invBL = new Investigation_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                LoadReferingPhysician();
                LoadHospital();
            }
            lblMessage.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageCustomPrice.aspx:Page_Load", ex);
        }
    }
    public void LoadReferingPhysician()
    {
        try
        {
            returnCode = patBL.GetReferingPhysician(OrgID, "", "", out getReferingPhysician);
            if (getReferingPhysician.Count > 0)
            {
                ddlReferingPhysician.DataSource = getReferingPhysician;
                ddlReferingPhysician.DataTextField = "PhysicianName";
                ddlReferingPhysician.DataValueField = "ReferingPhysicianID";
                ddlReferingPhysician.DataBind();
            }
            ddlReferingPhysician.Items.Insert(0, "-----Select-----");
            ddlReferingPhysician.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Physician Details.", ex);
        }
    }
    public void LoadHospital()
    {
        try
        {
            returnCode = patBL.GetLabRefOrg(OrgID, 0, "", out getReferingHospital);
            getReferingHospitalTemp = getReferingHospital.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (getReferingHospitalTemp.Count > 0)
            {
                ddlReferingHospital.DataSource = getReferingHospitalTemp;
                ddlReferingHospital.DataTextField = "RefOrgNameWithAddress";
                ddlReferingHospital.DataValueField = "LabRefOrgID";
                ddlReferingHospital.DataBind();

            } ddlReferingHospital.Items.Insert(0, "-----Select-----");
            ddlReferingHospital.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Hospital Details.", ex);
        }
    }

    protected void ddlReferingPhysician_SelectedIndexChanged(object sender, EventArgs e)
    {
        long refPhyID = 0;
        refPhyID = Convert.ToInt64(ddlReferingPhysician.SelectedValue);
        patBL.GetMappedOrganisation(OrgID, refPhyID, out getReferingHospital);
        if (getReferingHospital.Count > 0)
        {
            ddlReferingHospital.Items.Clear();
            ddlReferingHospital.DataSource = getReferingHospital;
            ddlReferingHospital.DataTextField = "RefOrgNameWithAddress";
            ddlReferingHospital.DataValueField = "LabRefOrgID";
            ddlReferingHospital.DataBind();
        }
        ddlReferingHospital.Items.Insert(0, "-----Select-----");
        ddlReferingHospital.Items[0].Value = "0";
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Visible = false;
            RefPhyID = Convert.ToInt32(ddlReferingPhysician.SelectedValue);
            RefOrgID = Convert.ToInt64(ddlReferingHospital.SelectedValue);
            if (txtInvestigationName.Text.Trim() != "")
            {
                returnCode = invBL.GetCustomPriceWithInvName(OrgID, RefPhyID, RefOrgID, txtInvestigationName.Text.Trim(), out lstPCCPM, out lstIOM);
            }
            else
            {
                returnCode = invBL.GetCustomPrice(OrgID, RefPhyID, RefOrgID, out lstPCCPM, out lstIOM);
            }

            if (lstIOM.Count > 0)
            {

                //TableRow row1 = new TableRow();
                //TableCell cell1 = new TableCell();
                //cell1.Attributes.Add("align", "left");
                //cell1.Text = "Investigation";
                //TableCell cell2 = new TableCell();
                //cell2.Attributes.Add("align", "left");
                //cell2.Text = "Custom Price";
                //cell1.BorderWidth = 1;
                //cell2.BorderWidth = 1;
                //row1.Cells.Add(cell1);
                //row1.Height = Unit.Pixel(20);
                //row1.Cells.Add(cell2);
                //row1.Font.Bold = true;
                //row1.Font.Size = 10;
                //row1.Style.Add("background-color", "#2c88b1");
                //row1.Style.Add("color", "#ffffff");
                //row1.BorderWidth = 1;
                //masterTab.Rows.Add(row1);
                //hdnInvList.Value = "";
                //foreach (InvestigationOrgMapping objIOM in lstIOM)
                //{
                //    decimal rate = 0;
                //    foreach (PCCustomPriceMapping objPCCPM in lstPCCPM)
                //    {
                //        if (objIOM.InvestigationID == objPCCPM.ID)
                //        {
                //            rate = objPCCPM.Rate;
                //        }
                //    }
                //    hdnInvList.Value += objIOM.InvestigationID + "~";
                //    TableRow row11 = new TableRow();
                //    row11.ID = "row" + objIOM.InvestigationID.ToString();
                //    TextBox txtBoxDT = new TextBox();
                //    TableCell cell11 = new TableCell();
                //    cell11.Attributes.Add("align", "left");
                //    cell11.Text = objIOM.InvestigationName;
                //    TableCell cell22 = new TableCell();
                //    cell22.Attributes.Add("align", "left");
                //    txtBoxDT.ID = "txtDT" + objIOM.InvestigationID.ToString();
                //    cell22.Controls.Add(txtBoxDT);
                //    txtBoxDT.Width = Unit.Pixel(75);
                //    txtBoxDT.Attributes.Add("onKeyDown", "return validatenumber(event);");
                //    txtBoxDT.Attributes.Add("onblur", "convertNumber(this.id);");
                //    txtBoxDT.Text = String.Format("{0:0.00}", Convert.ToDouble(rate));
                //    txtBoxDT.Style.Add("text-align", "right");
                //    txtBoxDT.ToolTip = "Enter Custom Price";
                //    row11.Cells.Add(cell11);
                //    row11.Cells.Add(cell22);
                //    row11.Font.Bold = false;
                //    row11.Font.Size = 8;
                //    row11.Style.Add("color", "#000000");
                //    row11.BorderWidth = 1;
                //    masterTab.Rows.Add(row11);
                //}

                //var query = from p in people
                //            where p.ID == 1
                //            from r in roles
                //            where r.ID == p.IDRole
                //            select new { p.FirstName, p.LastName, r.Role };

                //var query = from p in lstIOM
                //            where p.InvestigationID == 1
                //               from r in lstPCCPM

                gvResult.DataSource = lstIOM.OrderBy(P => P.InvestigationName).ToList();
                gvResult.DataBind();

                saveTab.Visible = true;
            }
            else
            {
                saveTab.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Custom Price Details.", ex);
        }
    }

    protected void gvResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InvestigationOrgMapping objIOM = new InvestigationOrgMapping();

            objIOM = (InvestigationOrgMapping)e.Row.DataItem;
            decimal rate = 0;
            foreach (PCCustomPriceMapping objPCCPM in lstPCCPM)
            {
                if (objIOM.InvestigationID == objPCCPM.ID)
                {
                    rate = objPCCPM.Rate;
                }
            }
            ((TextBox)e.Row.FindControl("txtCustomPrice")).Text = String.Format("{0:0.00}", Convert.ToDouble(rate));
        }
    }

    protected void gvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {


        if (e.NewPageIndex != -1)
        {
            gvResult.PageIndex = e.NewPageIndex;
            hdnPageIndx.Value = gvResult.PageIndex.ToString();
            btnSearch_Click(sender, e);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            RefPhyID = Convert.ToInt32(ddlReferingPhysician.SelectedValue);
            RefOrgID = Convert.ToInt64(ddlReferingHospital.SelectedValue);
            lstPCCPMSave = GetCollectedItems();
            returnCode = invBL.SaveCustomPrice(OrgID, RefPhyID, RefOrgID, lstPCCPMSave);
            btnSearch_Click(sender, e);
            gvResult.PageIndex = int.Parse(hdnPageIndx.Value);

            lblMessage.Visible = true;
            lblMessage.Text = "Custom Price List Updated Successfully...";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Custom Price Details.", ex);
        }
    }

    protected void gvResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "pEdit")
        {
            foreach (GridViewRow row in gvResult.Rows)
            {

                HiddenField hdnInvestigationID = (HiddenField)row.FindControl("hdnInvestigationID");
                TextBox txtCustomPrice = (TextBox)row.FindControl("txtCustomPrice");
                if (hdnInvestigationID.Value == e.CommandArgument.ToString())
                {
                    PCCustomPriceMapping objPCCPMSave = new PCCustomPriceMapping();
                    objPCCPMSave.ID = Convert.ToInt64(hdnInvestigationID.Value);
                    objPCCPMSave.OrgID = OrgID;
                    objPCCPMSave.Type = "INV";
                    objPCCPMSave.RefOrgID = Convert.ToInt64(ddlReferingHospital.SelectedValue);
                    objPCCPMSave.RefPhyID = Convert.ToInt32(ddlReferingPhysician.SelectedValue);
                    objPCCPMSave.Rate = Convert.ToDecimal(txtCustomPrice.Text);
                    lstPCCPMSave.Add(objPCCPMSave);
                }
            }
            if (lstPCCPMSave.Count > 0)
            {
                RefPhyID = Convert.ToInt32(ddlReferingPhysician.SelectedValue);
                RefOrgID = Convert.ToInt64(ddlReferingHospital.SelectedValue);
                returnCode = invBL.SaveCustomPrice(OrgID, RefPhyID, RefOrgID, lstPCCPMSave);

                btnSearch_Click(sender, e);
                gvResult.PageIndex = int.Parse(hdnPageIndx.Value);
                lblMessage.Visible = true;

                lblMessage.Text = "Custom Price List Updated Successfully...";
            }
            else
            {
                lblMessage.Text = "Custom Price List Updated Failed...";
            }

        }
    }


    protected List<PCCustomPriceMapping> GetCollectedItems()
    {
        foreach (GridViewRow row in gvResult.Rows)
        {
            PCCustomPriceMapping objPCCPMSave = new PCCustomPriceMapping();
            HiddenField hdnInvestigationID = (HiddenField)row.FindControl("hdnInvestigationID");
            TextBox txtCustomPrice = (TextBox)row.FindControl("txtCustomPrice");
            objPCCPMSave.ID = Convert.ToInt64(hdnInvestigationID.Value);
            objPCCPMSave.OrgID = OrgID;
            objPCCPMSave.Type = "INV";
            objPCCPMSave.RefOrgID = Convert.ToInt64(ddlReferingHospital.SelectedValue);
            objPCCPMSave.RefPhyID = Convert.ToInt32(ddlReferingPhysician.SelectedValue);
            objPCCPMSave.Rate = Convert.ToDecimal(txtCustomPrice.Text);
            lstPCCPMSave.Add(objPCCPMSave);
        }

        return lstPCCPMSave;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

}
