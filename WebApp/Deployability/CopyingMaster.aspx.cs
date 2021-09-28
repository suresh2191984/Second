using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel.Web;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
public partial class CopyingMaster_Home : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetBaseOrg();
      //  GetTrustedOrg();

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetInactive(List<InvestigationMaster> InputList, String Status)
    { 
        
        if (Status == "Y" || Status == "A")
        {
            var query = from c in InputList
                        where c.Display.Contains(Status)
                        select c;
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(query);
            return strout;
        }
        else
        {
            var query = from c in InputList
                        select c;
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(query);
            return strout;
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static String GetAutoComplete(List<InvestigationMaster> InputList, String Status, string txtName)
    {
            JavaScriptSerializer js = new JavaScriptSerializer();
            if (Status == "Y" || Status == "A")
            {
                if (txtName == "")
                {
                    var query = from c in InputList
                                where c.Display.Contains(Status)
                                select c;
                    return js.Serialize(query);
                }
                else
                {
                    var query = from c in InputList
                                where c.InvestigationName.ToLower().Contains(txtName.ToLower()) || c.InvestigationID.ToString().Contains(txtName) && c.Display.Contains(Status)
                                select c;
                    return js.Serialize(query);

                }
            }
            else
            {
                if (txtName == "")
                {
                    var query = from c in InputList
                                select c;
                    return js.Serialize(query);
                }
                else
                {
                    var query = from c in InputList
                                where c.InvestigationName.ToLower().Contains(txtName.ToLower()) || c.InvestigationID.ToString().Contains(txtName)
                                select c;
                    return js.Serialize(query);

                }
            }
    }
    
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebGet(ResponseFormat = WebMessageFormat.Json)]
    public static string GetDataFromDB(int BaseOrgId, String FeeType)
    {
        long returnvalue = -1;
        Deployability_BL lstInvestigationMasterbl = new Deployability_BL();
        List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();
        returnvalue = lstInvestigationMasterbl.GetCopyMasterDetails(BaseOrgId, FeeType, out lstInvestigationMaster);
       
                JavaScriptSerializer js = new JavaScriptSerializer();

                var query = from c in lstInvestigationMaster
                            select new { c.Active, c.CodeName, c.Display, c.InvestigationID, c.InvestigationName, c.IsMapped, c.IsParameter, c.TestCode, c.UOMID };
                string strout = js.Serialize(query);
                return strout;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static long SaveFeeTypeDetails(int baseorgid, string destorgid, string reset, string lstInvestigationDetail)
    {
        long returncode = -1;
        try
        {
            List<InvestigationDetail> lstInvestigationDetails = new JavaScriptSerializer().Deserialize<List<InvestigationDetail>>(lstInvestigationDetail);
            returncode = new Deployability_BL(new BaseClass().ContextInfo).SaveFeeTypes(baseorgid, destorgid, reset, lstInvestigationDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in copyingmaster   Web Service SaveFeeTypeDetails Message:", ex);
        }
        return returncode;
    }
    public class EmpPro
    {
        public int InvestigationId { get; set; }
        public String CodeName { get; set; }
        public String InvestigationName { get; set; }
        public String Isactive { get; set; }
    }
    public void GetBaseOrg()
    {
        long returnvalue = -1;
        AdminReports_BL adminbl = new AdminReports_BL();
        List<Organization> lstOrganization = new List<Organization>();
        returnvalue = adminbl.pGetOrgLoction(out lstOrganization);
        if (lstOrganization.Count > 0)
        {
            ddlOrgName.DataSource = lstOrganization;
            ddlOrgName.DataTextField = "Name";
            ddlOrgName.DataValueField = "OrgID";
            ddlOrgName.DataBind();
            ddlOrgName.Items.Insert(0, "Select");
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static String GetTrustedOrg(int baseorgid)
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            SharedInventory_BL objBl = new SharedInventory_BL(new BaseClass().ContextInfo);
            objBl.InvTrustedOrgDetail(baseorgid, 0, out lstOrgList);
            //List<Organization> lstorgn = new List<Organization>();
            //AdminReports_BL objBl = new AdminReports_BL();
            //objBl.GetSharingOrganizations(baseorgid, out lstorgn);
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lstOrgList);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error in load TrustedOrg details";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("../NewInstanceCreation/NewInstanceCreation.aspx");
    }
}
