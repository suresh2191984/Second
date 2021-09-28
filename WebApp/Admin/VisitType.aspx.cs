using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Xml;
using Attune.Podium.BillingEngine;

public partial class Admin_VisitType : BasePage
{
    AdminReports_BL AdminReportsBl;
    protected void Page_Load(object sender, EventArgs e)
    {
        AdminReportsBl = new AdminReports_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadDropMaster();
            loadVistiSubType();
        }        
    }
    public void LoadDropMaster()
    {
        long Returncode = -1;
        List<RateMaster> lstRateType = new List<RateMaster>();
        AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);        
        try
        {
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            if (lstRateType.Count > 0)
            {
                ddlratetype.DataSource = lstRateType;
                ddlratetype.DataTextField = "RateName";
                ddlratetype.DataValueField = "RateId";
                ddlratetype.DataBind();
                ddlratetype.Items.Insert(0, "--Select RateType--");
                ddlratetype.Items[0].Value = "0";               
            }
            else
            {
                ddlratetype.DataSource = null;
                ddlratetype.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    private void loadVistiSubType()
    {
        List<RateSubTypeMapping> lstRateSubTypeMapping = new List<RateSubTypeMapping>();
        List<VisitSubType> lstVisitSubType = new List<VisitSubType>();        
        AdminReportsBl.GetVisitSubType(out lstVisitSubType);
        chklstVisitType.DataSource = lstVisitSubType;
        chklstVisitType.DataTextField = "Description";
        chklstVisitType.DataValueField = "VisitSubTypeID";
        chklstVisitType.DataBind();        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<RateSubTypeMapping> lstRateSubTypeMapping = new List<RateSubTypeMapping>();       
        try
        {
            for (int i = 0; i < chklstVisitType.Items.Count; i++)
            {
                RateSubTypeMapping ObjRateSubTypeMapping = new RateSubTypeMapping();    
                if (chklstVisitType.Items[i].Selected == true)
                {
                    ObjRateSubTypeMapping.VisitSubTypeID = Convert.ToInt32(chklstVisitType.Items[i].Value);
                    ObjRateSubTypeMapping.RateID = int.Parse(ddlratetype.SelectedValue);
                    ObjRateSubTypeMapping.TypeOfSubType = "VST";
                    ObjRateSubTypeMapping.OrgID = OrgID;
                    lstRateSubTypeMapping.Add(ObjRateSubTypeMapping);
                    returnCode = AdminReportsBl.SaveRateSubTypeMapping(OrgID, lstRateSubTypeMapping);   
                }
                         
            }                  
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved Successfully.');", true);
                LoadDropMaster();
                loadVistiSubType();                
            }            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Brand Name", excep);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        LoadDropMaster();
        loadVistiSubType();        
    }
   
    protected void ddlratetype_SelectedIndexChanged(object sender, EventArgs e)
    {
        long Returncode = -1;
        List<RateSubTypeMapping> lstRateSubTypeMapping = new List<RateSubTypeMapping>();
        AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
        hdnVisitSubType.Value = String.Empty;
        loadVistiSubType();
        int rateid = int.Parse(ddlratetype.SelectedValue);
        try
        {
            Returncode = objBl.GetVisitSubTypeID(OrgID, rateid, out lstRateSubTypeMapping);
            if (lstRateSubTypeMapping.Count > 0)
            {
                foreach (RateSubTypeMapping ratesubtypemapping in lstRateSubTypeMapping)
                {
                    hdnVisitSubType.Value += ratesubtypemapping.VisitSubTypeID.ToString() + "~";
                }
            }            
            foreach (string txt in hdnVisitSubType.Value.Split('~'))
            {
                foreach (ListItem item in chklstVisitType.Items)
                {
                    if (item.Value.Trim() == txt.Trim())
                    {
                        item.Selected = true;
                    }
                }
            }          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }

    }
}
