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
using System.Data.SqlClient;
using System.Globalization;

public partial class Admin_BannerMaster : BasePage
{
    Role_BL roleBL;
    Master_BL masterBL;
    List<Role> role = new List<Role>();
    List<Banners> lstBanners = new List<Banners>();
    List<BannerRoleMapping> lstBannerRoleMapping = new List<BannerRoleMapping>();
    string Stype = string.Empty;    
    protected void Page_Load(object sender, EventArgs e)
    {
         roleBL = new Role_BL(base.ContextInfo);
         masterBL = new Master_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                txtbannertext.Text = string.Empty;
                LoadRole();
                hdnCurrentDate.Value =  Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                LoadBannerText();
                btnSave.Text = "Save";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load while loading Role", ex);
        }
    }

    private void LoadRole()
    {
        long returnCode = -1;
        int pOrgID=OrgID;
        returnCode = roleBL.GetRoleName(pOrgID, out role);
        chkbxlstRole.DataSource = role;
        chkbxlstRole.DataTextField = "RoleName";
        chkbxlstRole.DataValueField = "RoleID";
        chkbxlstRole.DataBind();
    }

    private void LoadBannerText()
    {
        long returnCode = -1;                  
        int BannerID = 0;   
        returnCode = masterBL.GetBannerDetails(OrgID, BannerID, out lstBanners, out lstBannerRoleMapping); 
        grdBanner.DataSource = lstBanners;
        grdBanner.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            Banners ObjBanners = new Banners();
            List<BannerRoleMapping> lstBannerRoleMapping = new List<BannerRoleMapping>();                        
            ObjBanners.BannerText = txtbannertext.Text;
            ObjBanners.OrgID = OrgID;
            string stype;
            if (hdnValues.Value == "1")
            {
                stype = "Save";
            }
            else
            {
                stype = "Update";
            }
            //if (btnSave.Text == "Save")
            //{
            //    stype = "Save";
            //}
            //else
            //{
            //    stype = "Update";
            //}
            IEnumerable<ListItem> checkedlist = (from ListItem item in chkbxlstRole.Items
                                                 where item.Selected
                                                 select item);
            foreach (ListItem item in checkedlist)
            {
                BannerRoleMapping ObjBannerRoleMapping = new BannerRoleMapping();
                ObjBannerRoleMapping.RoleID = Int32.Parse(item.Value);
                ObjBannerRoleMapping.LoginID = LID;
                ObjBannerRoleMapping.BannerStartDate = Convert.ToDateTime(txtStartDt.Text);
                ObjBannerRoleMapping.BannerEndDate = Convert.ToDateTime(txtEndDt.Text);
                lstBannerRoleMapping.Add(ObjBannerRoleMapping);
            }
            BannerRoleMapping BRM = new BannerRoleMapping();
            BRM.BannerID = Int64.Parse(hdnBannerID.Value);
            returnCode = masterBL.InsertBannerMaster(ObjBanners, stype, BRM, lstBannerRoleMapping);
            if (returnCode == 0)
            {
                txtbannertext.Text = string.Empty;
                txtStartDt.Text = string.Empty;
                txtEndDt.Text = string.Empty;
                ChkbxRole.Checked = false;
                if (hdnValues.Value == "1")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Save Successfully.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes Save Successfully.');", true);
                }
                txtbannertext.Text = string.Empty;
                hdnCurrentDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                LoadBannerText();
                btnSave.Text = "Save";
                hdnBannerID.Value = "0";
                hdnCurrentDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                LoadRole();
            }            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Saving Banner Test", ex);
        }
    }
    protected void grdBanner_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                LoadRole();
                hdnRoleID.Value = "";               
                long returnCode = -1;
                int RowIndex = Convert.ToInt32(e.CommandArgument);                
                txtbannertext.Text = "";
                txtStartDt.Text = "";
                txtEndDt.Text = "";
                txtbannertext.Text = Convert.ToString(grdBanner.DataKeys[RowIndex][1]);
                hdnBannerID.Value = Convert.ToString(grdBanner.DataKeys[RowIndex][0]);               
                int BannerID = int.Parse(hdnBannerID.Value);          
                returnCode = masterBL.GetBannerDetails(OrgID, BannerID, out lstBanners , out lstBannerRoleMapping);
                if (lstBannerRoleMapping.Count > 0)
                {
                    foreach (BannerRoleMapping ObjBannerRoleMapping in lstBannerRoleMapping)
                    {
                        hdnRoleID.Value += ObjBannerRoleMapping.RoleID.ToString() + "~";
                        txtStartDt.Text = Convert.ToString(ObjBannerRoleMapping.BannerStartDate);
                        txtEndDt.Text = Convert.ToString(ObjBannerRoleMapping.BannerEndDate);
                    }
                }

                foreach (ListItem item in chkbxlstRole.Items)
                {
                    foreach (string txt in hdnRoleID.Value.Split('~'))
                    {
                        if (item.Value.Trim() == txt.Trim())
                        {
                            item.Selected = true;
                        }
                    }
                }
                                  
                btnSave.Text = "Update";
                hdnValues.Value = "0";
                GridViewRow row = (GridViewRow)grdBanner.Rows[RowIndex];
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
        for (int i = 0; i < this.grdBanner.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdBanner.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }
    protected void grdBanner_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");                
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdBanner, "Select$" + e.Row.RowIndex));
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
}
