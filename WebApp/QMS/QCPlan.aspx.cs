using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class QMS_QCPlan : BasePage
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
            string domains = "QMS_EventType,QMS_PlanStatus,QMS_AuditProgramType,QMS_P&S_FileType";
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
                var childItems = (from child in lstmetadataOutput
                                  where child.Domain == "QMS_EventType"

                                  select child).OrderBy(c => c.MetaDataID);
                if (childItems.Count() > 0)
                {
                    ddlEventType.Items.Clear();
                    EventType.Items.Clear();
                    foreach (var c in childItems)
                    { 
                        ListItem ls=new ListItem ();
                        ls.Text=c.DisplayText;
                        ls.Attributes.Add("data",c.Code);
                        ls.Value =Convert.ToString( c.MetaDataID);
                        EventType.Items.Add(ls);
                        ddlEventType.Items.Add(ls);
                    }
         
                    EventType.Items.Insert(0, "All");
                    EventType.Items[0].Value = "0";

       
                }
                else
                {
                    ddlEventType.Items.Insert(0, "---select---");
                    ddlEventType.Items[0].Value = "0";
                }
                var childItems1 = (from child in lstmetadataOutput
                                  where child.Domain == "QMS_PlanStatus"
                                  select child).OrderBy(c=>c.MetaDataID);
                if (childItems1.Count() > 0)
                {
                    ddlStatus.DataSource = childItems1;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();
                    //ddlStatus.Items.Insert(0, "---select---");
                    //ddlStatus.Items[0].Value = "0";

                    ddlStatusFilter.DataSource = childItems1;
                    ddlStatusFilter.DataTextField = "DisplayText";
                    ddlStatusFilter.DataValueField = "Code";
                    ddlStatusFilter.DataBind();
                    ddlStatusFilter.Items.Insert(0, "All");
                    ddlStatusFilter.Items[0].Value = "0";
                }

                
                var childItems2 = (from child in lstmetadataOutput
                                   where child.Domain == "QMS_AuditProgramType"
                                   select child).OrderBy(c => c.MetaDataID);
                 if (childItems2.Count() > 0)
                {
                    ddlProgType.DataSource = childItems2;
                    ddlProgType.DataTextField = "DisplayText";
                    ddlProgType.DataValueField = "Code";
                    ddlProgType.DataBind();
                 }
                 var childItems3 = (from child in lstmetadataOutput
                                    where child.Domain == "QMS_P&S_FileType"
                                    select child).OrderBy(c => c.MetaDataID);
                 if (childItems2.Count() > 0)
                 {
                     ddlFileType.DataSource = childItems3;
                  ddlFileType.DataTextField = "DisplayText";
                  ddlFileType.DataValueField = "Code";
                  ddlFileType.DataBind();
                 }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

}
