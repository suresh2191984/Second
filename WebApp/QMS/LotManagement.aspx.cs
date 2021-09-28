using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Solution.QMSBusinessLogic;

public partial class QMS_LotManagement : BasePage
{
    public QMS_LotManagement()
        : base("QMS_LotManagement_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //LoadMetaData();
    }
    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "LotLevel";
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
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "LotLevel"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlLevel.DataSource = childItems;
                    ddlLevel.DataTextField = "DisplayText";
                    ddlLevel.DataValueField = "MetaDataID";
                    ddlLevel.DataBind();
                    ddlLevel.Items.Insert(0, "---select---");
                    ddlLevel.Items[0].Value = "0";

                }
             

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in QMS_LotManagement", ex);
        }
    }

}
