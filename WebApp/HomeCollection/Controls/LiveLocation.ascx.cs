using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HomeCollectionsBL;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;

using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections;

using Attune.Podium.TrustedOrg;
using System.Threading;

using System.IO;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Podium.BillingEngine;
using Microsoft.Reporting.WebForms;



public partial class HomeCollection_Controls_LiveLocation : BaseControl
{
   
    int chid;
    long Addid;
    List<OrgAddressGoogleMap> lstOrgLocation = new List<OrgAddressGoogleMap>();
    protected void Page_Load(object sender, EventArgs e)
    {
          if (!this.IsPostBack)
        {
        HomeCollections_BL objBl = new HomeCollections_BL(base.ContextInfo);
  
        LoadUser(OrgID, RoleID);
        chid = 2;
        Addid = 0;
        hdnOrgID.Value = OrgID.ToString();
      
            long returnCode = -1;
            objBl = new HomeCollections_BL(base.ContextInfo);

            returnCode = objBl.GetOrglocationMap(OrgID, Addid, chid, out lstOrgLocation);
          
            DataTable dt = GetData(lstOrgLocation);
            
          //  rptMarkers.DataSource = dt;
         //   rptMarkers.DataBind();
           // ConvertDataTabletoString(dt);
        }
    }
    // This method is used to convert datatable to json string
    public string ConvertDataTabletoString()
    {
        HomeCollections_BL objBl = new HomeCollections_BL(base.ContextInfo);
        long returnCode = -1;
        objBl = new HomeCollections_BL(base.ContextInfo);
        chid = 2;
        Addid = 0;
        returnCode = objBl.GetOrglocationMap(OrgID, Addid, chid, out lstOrgLocation);

     //   DataTable dt = GetData(lstOrgLocation);
     //   DataTable dt = lstOrgLocation;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        //List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        //Dictionary<string, object> row;
        //foreach (DataRow dr in dt.Rows)
        //{
        //    row = new Dictionary<string, object>();
        //    foreach (DataColumn col in dt.Columns)
        //    {
        //        row.Add(col.ColumnName, dr[col]);
        //    }
        //    rows.Add(row);
        //    //   Response.Write(serializer.Serialize(rows));
        //}
        //return serializer.Serialize(rows);
        
       return serializer.Serialize(lstOrgLocation);
    }

    private DataTable GetData(List<OrgAddressGoogleMap> lstOrgLocation)
    //List<InvestigationMaster> lstInvestigation)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Location");
        DataColumn dcol2 = new DataColumn("Latitude");
        DataColumn dcol3 = new DataColumn("Longitude");
        DataColumn dcol4 = new DataColumn("Description");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        foreach (var item in lstOrgLocation)
        {
            var row = dt.NewRow();
            row["Location"] = item.Location;
            row["Latitude"] = item.Latitude;
            row["Longitude"] = item.Longitude;
            row["Description"] = item.Description;

            dt.Rows.Add(row);
        }
        return dt;
    }
  
    private void LoadUser(long OrgID, long RoleID)
    {
        try
        {
            //  long returncode = -1;
            Role_BL RoleBL = new Role_BL(new BaseClass().ContextInfo);

            long loginid = LID;
            long returnCode = -1;
            GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = loginid;
            loginRole.RoleID = RoleID;
            List<LoginRole> lstrole = new List<LoginRole>();

            gateway.GetLoggedInRoles(loginRole, out lstrole);


            RoleID = Int64.Parse(lstrole.Where(o => o.RoleName == "Phlebotomist").Select(o => o.RoleID).FirstOrDefault().ToString());



            //int RoleIDno=RoleIDL.
            List<Users> lstResult = new List<Users>();

            RoleBL.GetUserName(OrgID, RoleID, out lstResult);
            if (lstResult.Count > 0)
            {
               
                ddlTechni.DataSource = lstResult;
                ddlTechni.DataTextField = "Name";
                ddlTechni.DataValueField = "UserID";

                ddlTechni.DataBind();
                ddlTechni.Items.Insert(0, "------Select ALL------");
                ddlTechni.Items[0].Value = "0";

                PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
                locationpincode.Value = lstLocation[0].PostalCode;
                Session.Add("PostalCode", lstLocation[0].PostalCode);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  LoadUser ", ex);

        }
    }


    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        lbltxt.Text = ddlTechni.SelectedItem.Text;
        lblid.Text = ddlTechni.SelectedItem.Value;
      
    }
  
}
