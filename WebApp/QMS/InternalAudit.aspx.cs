using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
public partial class QMS_InternalAudit : BasePage
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
            string domains = "QMS_PlanStatus,QMS_AuditType,QMS_Catagory,QMS_NCClassification,QMS_ActionVerified";
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
                    //ddlStatusFilter.Items.Insert(0, "All");
                    //ddlStatusFilter.Items[0].Value = "0";
                }
                var childItems2 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_AuditType"
                                   select child).OrderBy(c => c.MetaDataID);
                if (childItems2.Count() > 0)
                {

                    ddlAuditType.DataSource = childItems2;
                    ddlAuditType.DataTextField = "DisplayText";
                    ddlAuditType.DataValueField = "Code";
                    ddlAuditType.DataBind();
                    ddlAuditType.Items.Insert(0, "--Select--");
                    ddlAuditType.Items[0].Value = "0";
                }
                var childItems3 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_Catagory"
                                   select child).OrderBy(c => c.MetaDataID);
                if (childItems3.Count() > 0)
                {

                    ddlCategory.DataSource = childItems3;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.DataBind();
                    ddlCategory.Items.Insert(0, "--Select--");
                    ddlCategory.Items[0].Value = "0";
                }
                var childItems4 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_NCClassification"
                                   select child).OrderBy(c => c.MetaDataID);
                if (childItems4.Count() > 0)
                {

                   ddlClassification.DataSource = childItems4;
                   ddlClassification.DataTextField = "DisplayText";
                   ddlClassification.DataValueField = "Code";
                   ddlClassification.DataBind();
                   ddlClassification.Items.Insert(0, "--Select--");
                   ddlClassification.Items[0].Value = "0";
                }


                var childItems5 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_ActionVerified"
                                   select child).OrderBy(c => c.MetaDataID);
                if (childItems5.Count() > 0)
                {

                  ddlCorrectiveVerified.DataSource = childItems5;
                  ddlCorrectiveVerified.DataTextField = "DisplayText";
                  ddlCorrectiveVerified.DataValueField = "Code";
                  ddlCorrectiveVerified.DataBind();
                  ddlCorrectiveVerified.Items.Insert(0, "--Select--");
                  ddlCorrectiveVerified.Items[0].Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }
}
