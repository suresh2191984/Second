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


public partial class Admin_ManageLogisticsDetails : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            hdnBaseOrgId.Value = OrgID.ToString();
            hdnorgAddressId.Value = ILocationID.ToString();
            LoadTransitTimeType();
           
        }
    }

    protected void LoadTransitTimeType()
    {
        try
        {

            long returncode = -1;
            string domains = "TransitTime";
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
                var childItemsTAT = from child in lstmetadataOutput
                                    where child.Domain == "TransitTime"
                                    select child;

                if (childItemsTAT.Count() > 0)
                {
                    ddlTransitTime.DataSource = childItemsTAT;
                    ddlTransitTime.DataTextField = "DisplayText";
                    ddlTransitTime.DataValueField = "Code";
                    ddlTransitTime.DataBind();
                    ddlTransitTime.Items.Insert(0, "--Select--");
                    ddlTransitTime.Items[0].Value = "0";
                    ddlTransitTime.SelectedValue = "0";
                }

               

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadTransitTimeType() Method in TAT Manage Logistics", ex);

        }  
    }
}


   
  



