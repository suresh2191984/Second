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
using Attune.Solution.QMSBasecClassConvert;


public partial class QMS_Program : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMetaData();
        hdnOrgID.Value = OrgID.ToString();
 
    }

    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "QMS_PlanStatus,ExamType_QMS";
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
                                 where child.Domain == "QMS_PlanStatus"
                                 select child;
                if (childItems.Count() > 0)
                {
                    txtStatus.DataSource = childItems;
                    txtStatus.DataTextField = "DisplayText";
                    txtStatus.DataValueField = "Code";
                    txtStatus.DataBind();
                    txtStatus.Items.Insert(0, "---select---");
                    txtStatus.Items[0].Value = "0";

                    ddlStatus.DataSource = childItems;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();
                    ddlStatus.Items.Insert(0, "---select---");
                    ddlStatus.Items[0].Value = "0";
                    
                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "ExamType_QMS"
                                  select child;
                if (childItems1.Count() > 0)
                {
                    ddlExamType.DataSource = childItems1;
                    ddlExamType.DataTextField = "DisplayText";
                    ddlExamType.DataValueField = "Code";
                    ddlExamType.DataBind();
                    ddlExamType.Items.Insert(0, "---select---");
                    ddlExamType.Items[0].Value = "0";

                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in QMS Program", ex);
        }
    }
}
