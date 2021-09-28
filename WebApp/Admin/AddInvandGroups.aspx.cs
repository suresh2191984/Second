using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;
using Attune.Kernel.PlatForm.Base;

public partial class Admin_AddInvandGroups : BasePage
{
    public Admin_AddInvandGroups()
        : base("Admin_AddInvandGroups_aspx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                mpeAttributeLocation.Show();
                LoadMetaData();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in page load in AddINVandGroups page", ex);
        }
        if (Request.QueryString["IsPopUp"] == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
        }
    }
    #region  Added from Jagatheeshkumar

    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "AdminInvorGroup";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "AdminInvorGroup"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlLocation.DataSource = childItems;
                    ddlLocation.DataTextField = "DisplayText";
                    ddlLocation.DataValueField = "Code";
                    ddlLocation.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    protected void btnOk_Click(object sender, EventArgs e)
    {
        try
        {



            if (Request.QueryString["IsPopUp"] == "Y" && ddlLocation.SelectedValue == "INV")
            {
                Response.Redirect("TestInvestigation.aspx?IsPopUp=Y");
            }
            else if (ddlLocation.SelectedValue == "INV")
            {
                Response.Redirect("TestInvestigation.aspx");
            }
            else if (Request.QueryString["IsPopUp"] == "Y" && ddlLocation.SelectedValue == "GRP")
            {
                Response.Redirect("TestGroup.aspx?IsPopUp=Y");
            }
            else if (ddlLocation.SelectedValue == "GRP")
            {
                Response.Redirect("TestGroup.aspx");
            }   
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}
