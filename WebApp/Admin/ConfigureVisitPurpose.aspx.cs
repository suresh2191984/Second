using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using AjaxControlToolkit;

public partial class Admin_Configure_VisitPurpose : BasePage
{
    PatientVisit_BL patientvisitBL;
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            patientvisitBL = new PatientVisit_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                fill();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occur in Page_Load", ex);
        }
    }
    public void fill()
    {
        try
        {
            patientvisitBL.GetVisitPurpose(OrgID, "MAP", out lstVisitPurpose);
            if (lstVisitPurpose.Count > 0)
            {
                btnSelectRemove.Visible = true;
                chklstMap.Visible = true;
                chklstMap.DataSource = lstVisitPurpose;
                chklstMap.DataTextField = "VisitPurposeName";
                chklstMap.DataValueField = "VisitPurposeID";
                chklstMap.DataBind();
                ChkboxMap.Visible = true;
            }
            else 
            {
                ChkboxMap.Visible = false;
                btnSelectRemove.Visible = false;
            }
            patientvisitBL.GetVisitPurpose(OrgID, "UNMAP", out lstVisitPurpose);
            if (lstVisitPurpose.Count > 0)
            {
                btnSelectAdd.Visible = true;
                chklstUnMap.Visible = true;
                chklstUnMap.DataSource = lstVisitPurpose;
                chklstUnMap.DataTextField = "VisitPurposeName";
                chklstUnMap.DataValueField = "VisitPurposeID";
                chklstUnMap.DataBind();
                ChkboxUnMap.Visible = true;
            }
            else
            {
                ChkboxUnMap.Visible = false;
                btnSelectAdd.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in the Fill funtion in Group Master", ex);
        }
    }   
    protected void btnSelectAdd_Click(object sender, EventArgs e)
    {
        try
        {
            PatientVisit_BL patientvisitBL = new PatientVisit_BL(base.ContextInfo);
            long returnCode = -1;            
            IEnumerable<ListItem> allChecked = (from ListItem item in chklstUnMap.Items
                                                where item.Selected
                                                select item);
            foreach (ListItem item in allChecked)
            {
                VisitPurpose objVisitPurpose = new VisitPurpose();
                objVisitPurpose.VisitPurposeID = Int32.Parse(item.Value);
                objVisitPurpose.VisitPurposeName = item.Text;
                objVisitPurpose.OrgID = OrgID;
                lstVisitPurpose.Add(objVisitPurpose);
            }
            returnCode = patientvisitBL.GetInsertVisitPurpose(OrgID, lstVisitPurpose, "SELADD");
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved Successfully.');", true);               
            }
            fill();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Adding the Group in Group Master", ex);
        }

    }
    protected void btnSelectRemove_Click(object sender, EventArgs e)
    {
        try
        {
            PatientVisit_BL patientvisitBL = new PatientVisit_BL(base.ContextInfo);
            long returnCode = -1;
            IEnumerable<ListItem> allChecked = (from ListItem item in chklstMap.Items
                                                where item.Selected
                                                select item);
            foreach (ListItem item in allChecked)
            {
                VisitPurpose objVisitPurpose = new VisitPurpose();
                objVisitPurpose.VisitPurposeID = Int32.Parse(item.Value);
                objVisitPurpose.VisitPurposeName = item.Text;
                objVisitPurpose.OrgID = OrgID;
                lstVisitPurpose.Add(objVisitPurpose);
                if (objVisitPurpose.VisitPurposeID == 9)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Admission Cannot Be Moved.');", true);                   
                }
            }
            returnCode = patientvisitBL.GetInsertVisitPurpose(OrgID, lstVisitPurpose, "SELREMOVE");
            if (returnCode == 0)
            {                
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved Successfully.');", true);                
            }
            fill();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Adding the Group in Group Master", ex);
        }

    }
}
