using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Investigation_MethodKitPreview :BasePage 
{
    long returnCode = -1;
    long vid = -1;
    int deptID = -1;
    long pid = -1;
    Investigation_BL investigationBL;
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    string gUID = string.Empty;
    string InvId = string.Empty;
    string RId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            investigationBL = new Investigation_BL(base.ContextInfo);
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
                hdnHeaderName.Value = Request.QueryString["dept"];
                Int32.TryParse(Request.QueryString["dID"].ToString(), out deptID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
            }
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
            if (Request.QueryString["pid"] != null)
            {
                Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
            }
            InvId = Request.QueryString["Invid"].ToString();
            if ((!string.IsNullOrEmpty(Request.QueryString["RNo"])))
            {
                RId = Request.QueryString["RNo"].ToString();
            }
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while executing Page_Load in MethodKitCapture.aspx.", excep);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string methodKit = string.Empty;
        methodKit = ucMethodKitCapture.hdnMethodKitValues;
        foreach (string splitString in methodKit.Split('^'))
        {
            PatientInvestigation objPatientInvestigation = new PatientInvestigation();
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                objPatientInvestigation.OrgID = OrgID;
                objPatientInvestigation.PatientVisitID = vid;
                if (lineItems[10] == "INV")
                {
                    objPatientInvestigation.InvestigationID = Convert.ToInt64(lineItems[1]);
                    objPatientInvestigation.InvestigationName = lineItems[6];
                }
                else if (lineItems[10] == "GRP")
                {
                    objPatientInvestigation.GroupID = Convert.ToInt32(lineItems[1]);
                    objPatientInvestigation.GroupName = lineItems[6];
                }
                objPatientInvestigation.Type = lineItems[10];
                objPatientInvestigation.InvestigationMethodID = Convert.ToInt64(lineItems[2]);
                objPatientInvestigation.KitID = Convert.ToInt64(lineItems[3]);
                objPatientInvestigation.InstrumentID = Convert.ToInt64(lineItems[4]);
                objPatientInvestigation.PrincipleID = Convert.ToInt64(lineItems[11]);
                if (lineItems[5] != "--")
                {
                    objPatientInvestigation.Interpretation = lineItems[5];
                }
                if (lineItems[7] != "--")
                {
                    objPatientInvestigation.MethodName = lineItems[7];
                }
                if (lineItems[8] != "--")
                {
                    objPatientInvestigation.KitName = lineItems[8];
                }
                if (lineItems[9] != "--")
                {
                    objPatientInvestigation.InstrumentName = lineItems[9];
                }
                if (lineItems[12] != "--")
                {
                    objPatientInvestigation.PrincipleName = lineItems[12];
                }
                if (lineItems[13] != "--")
                {
                    objPatientInvestigation.QCData = lineItems[13];
                }
                lstPatientInvestigation.Add(objPatientInvestigation);
            }
        }

        returnCode = investigationBL.SaveInvestigationMethodKit(vid, OrgID, deptID, lstPatientInvestigation);
        string InvId = Request.QueryString["Invid"].ToString();

        if (returnCode == 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Saved Sucessfully');", true);
            //if (hdnHeaderName.Value != "Imaging")
            //{
            //    //Response.Redirect("~/Investigation/InvReportsForDept.aspx?vid=" + vid + "&dID=" + deptID + "&gUID=" + gUID + "&Invid=" + InvId);
            //    //Response.Redirect("~/Investigation/InvReportsForDept.aspx?vid=" + vid + "&dID=" + deptID + "&gUID=" + gUID + "&Invid=" + InvId + "&pid=" + pid);
            //}
            //else
            //{
            //    Response.Redirect("~/Investigation/ViewInvestigationReport.aspx?vid=" + vid + "&pid=" + pid);
            //}
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {

        try
        {
            // Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + vid);

            Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + vid + "&gUID=" + gUID + "&Invid=" + InvId + "&pid=" + pid + "&RNo=" + RId);
            //Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + vid + "&gUID=" + gUID + "&Invid=");

        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while redirecting InvestigationResultsCapture For Edit", ex);
        }
    }
}
