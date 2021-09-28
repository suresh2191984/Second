using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
public partial class QMS_MRM : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMetaData();
        //fromda.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
        //WaterstxtTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
        hdnOrgID.Value = OrgID.ToString();

    }

    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "QMS_PlanStatus";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {

                var childItems1 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_PlanStatus"
                                   select child).OrderBy(c => c.MetaDataID);
                if (childItems1.Count() > 0)
                {

                    ddlStatusFilter.DataSource = childItems1;
                    ddlStatusFilter.DataTextField = "DisplayText";
                    ddlStatusFilter.DataValueField = "Code";
                    ddlStatusFilter.DataBind();
                    ddlStatusFilter.Items.Insert(0, "All");
                    ddlStatusFilter.Items[0].Value = "0";

                    ddlStatus.DataSource = childItems1;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();
                  ddlStatus.Items.Insert(0, "--select--");
                    ddlStatus.Items[0].Value = "0";
                    
                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }
}
