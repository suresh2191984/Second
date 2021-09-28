using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Linq;
using System.Drawing;


public partial class CommonControls_EmergencyDashBord : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetEmerencyGridList();
        }
    }

    protected void grdEmDashboard_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var ddlLevel = (DropDownList)e.Row.FindControl("ddlLevel");
                List<EmergencySeverityOrgMapping> lstEMPLevel = new List<EmergencySeverityOrgMapping>();
                new PatientVisit_BL(base.ContextInfo).GetEMPLevel(OrgID, out lstEMPLevel);
                ddlLevel.DataSource = lstEMPLevel;
                ddlLevel.DataTextField = "DisplayText";
                ddlLevel.DataValueField = "EmergencySeverityOrgMappingID";
                ddlLevel.DataBind();
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<PatientVisitDetails> GetPatientDetails = new List<PatientVisitDetails>();
                new PatientVisit_BL(base.ContextInfo).GetEMPGridList(OrgID, out GetPatientDetails);
                var ddlLevel = (DropDownList)e.Row.FindControl("ddlLevel");
                int index = e.Row.RowIndex;
                var GetSelectedValue = GetPatientDetails[index].EmergencySeverityOrgMappingID;
                ddlLevel.SelectedValue = GetSelectedValue.ToString();
                List<EmergencySeverityOrgMapping> lstEMPLevel = new List<EmergencySeverityOrgMapping>();
                new PatientVisit_BL(base.ContextInfo).GetEMPLevel(OrgID, out lstEMPLevel);
                var ColorCode = from child in lstEMPLevel
                                where child.EmergencySerevityID == GetSelectedValue
                                select child.ColorCoding;
                string ColorCode1 = "";
                foreach (string name in ColorCode)
                {
                    ColorCode1 = name;
                }
                int idx = e.Row.RowIndex;
                Color _color = ColorTranslator.FromHtml("#FFFFFF");
                if (ColorCode1 != "")
                    try
                    {
                        _color = ColorTranslator.FromHtml(ColorCode1);
                    }
                    catch (Exception ex)
                    {
                        _color = ColorTranslator.FromHtml("#FFFFFF");
                    }
                e.Row.BackColor = _color;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Emerency Dash Board page", ex);
        }
    }

    protected void ddlLevel_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {           
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.Parent.Parent;
            int idx = row.RowIndex;
            int Getlevel = Convert.ToInt32(ddl.SelectedValue.ToString());
            List<EmergencySeverityOrgMapping> lstEMPLevel = new List<EmergencySeverityOrgMapping>();
            new PatientVisit_BL(base.ContextInfo).GetEMPLevel(OrgID, out lstEMPLevel);
            var ColorCode = from child in lstEMPLevel
                            where child.EmergencySerevityID == Getlevel
                            select child.ColorCoding;
            string ColorCode1 = "";
            foreach (string name in ColorCode)
            {
                ColorCode1 = name;
            }           
            Color _color = ColorTranslator.FromHtml("#FFFFFF");
            if (ColorCode1 != "")
                try
                {
                    _color = ColorTranslator.FromHtml(ColorCode1);
                }
                catch (Exception ex)
                {
                    _color = ColorTranslator.FromHtml("#FFFFFF");
                }
            row.BackColor = _color;
            int MapId = Convert.ToInt32(ddl.SelectedValue.ToString());
            int TrackerId = Convert.ToInt32(grdEmDashboard.DataKeys[idx]["EmergencyPatientTrackerId"].ToString());
            long returnCode = new PatientVisit_BL(base.ContextInfo).PSaveEmerencyPatientHistory(MapId, TrackerId, OrgID);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Update Successfully');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Emerency Dash Board page", ex);
        }
    }

    private void GetEmerencyGridList()
    {
        try
        {
            List<PatientVisitDetails> GetPatientDetails = new List<PatientVisitDetails>();
            new PatientVisit_BL(base.ContextInfo).GetEMPGridList(OrgID, out GetPatientDetails);
            grdEmDashboard.DataSource = GetPatientDetails;
            grdEmDashboard.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Emerency Dash Board page", ex);
        }
    }

    protected void grdEmDashboard_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            //List<EmergencyPatientTracker_History> EmergencyPatientTracker_History = new List<EmergencyPatientTracker_History>();
            //GridViewRow gvr = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            //int index = gvr.RowIndex;
            //DropDownList ddlLevel = (DropDownList)gvr.FindControl("ddlLevel");
            //int MapId = Convert.ToInt32(ddlLevel.SelectedValue.ToString());
            //int TrackerId = Convert.ToInt32(grdEmDashboard.DataKeys[index].Value);
            //long returnCode = new PatientVisit_BL(base.ContextInfo).PSaveEmerencyPatientHistory(MapId, TrackerId, OrgID);
            //if (returnCode > 0)
            //{
            //    string myStringVariable = string.Empty;
            //    myStringVariable = "Level Change Successfully";
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert(" + myStringVariable + ");", true);
            //}
        }
    }

}
