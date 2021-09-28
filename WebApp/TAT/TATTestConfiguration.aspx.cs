using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class Admin_TATTestConfiguration : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender9.ContextKey = "-1";
            hdnBaseOrgId.Value = OrgID.ToString();
            LoadMeatData();
        }
    }


    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "ConfigureFor,MapToCategory";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new TAT_BL(base.ContextInfo).LoadMetaDataOrgMappingTAT(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItemsTAT = from child in lstmetadataOutput
                                    where child.Domain == "ConfigureFor"
                                    select child;

                if (childItemsTAT.Count() > 0)
                {
                    ddlConfigFor.DataSource = childItemsTAT;
                    ddlConfigFor.DataTextField = "DisplayText";
                    ddlConfigFor.DataValueField = "Code";
                    ddlConfigFor.DataBind();
                    //ddlConfigFor.Items.Insert(0, "--Select--");
                    //ddlConfigFor.Items[0].Value = "0";
                    //ddlConfigFor.SelectedValue = "0";
                }

                var childItemsTatmode = from child in lstmetadataOutput
                                        where child.Domain == "MapToCategory"
                                        select child;

                if (childItemsTatmode.Count() > 0)
                {
                    ddlMapCategory.DataSource = childItemsTatmode;
                    ddlMapCategory.DataTextField = "DisplayText";
                    ddlMapCategory.DataValueField = "Code";
                    ddlMapCategory.DataBind();
                    ddlMapCategory.Items.Insert(0, "--Select--");
                    ddlMapCategory.Items[0].Value = "7";
                    ddlMapCategory.SelectedValue = "7";
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Manage Schedule", ex);

        }
    }

  


}
