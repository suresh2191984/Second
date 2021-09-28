using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class QMS_ExternalAudit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMetaData();
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
                    ddlStatus.DataSource = childItems1;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();


           
                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

}
