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
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using AjaxControlToolkit;


public partial class Admin_AddInvtoGrp : BasePage 
{
    int gid;
    string group;
    string ModifiedBy = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {              
                int.TryParse(Request.QueryString["gid"], out gid);
                show(gid);
                group = gid.ToString();
                Hdngid.Value = String.Empty;
                Hdngid.Value = gid.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Page Load", ex);
        }
    }
    public void show(int id)
    {
        try
        {
            long Returncode = -1;
            string groupname;
            OrderedInvestigations obj = new OrderedInvestigations();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
            objInvMas.Clear();
            objInvGrp.Clear();
            Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrgID, id, out objInvMas);
            Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrgID, id, out objInvGrp, out groupname);           
            lbl_id.Text = groupname;            
            Session["InvGrpmas"] = new List<OrderedInvestigations>();
            Session["InvGrpmas"] = objInvMas;
            Session["InvGrpmap"] = new List<OrderedInvestigations>();
            Session["InvGrpmap"] = objInvGrp;
            if (objInvMas.Count > 0)
            {
                chklstGrp.DataSource = objInvMas;
                chklstGrp.DataTextField = "Name";
                chklstGrp.DataValueField = "UID";                
                chklstGrp.DataBind();
            }
            if (objInvGrp.Count > 0)
            {
                chkGrpMap.DataSource = objInvGrp;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "UID" ;
                chkGrpMap.DataBind();
            }
            else
            {

                chkGrpMap.DataSource = objInvGrp;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "UID";
                chkGrpMap.DataBind();

            }
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error while Show Group", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            List<OrderedInvestigations> objSearch = new List<OrderedInvestigations>();
            try
            {
                string srch = txtInvestigationName.Text.Trim();
                objSearch = (List<OrderedInvestigations>)Session["InvGrpmas"];
                var search = from find in objSearch
                             where
                             find.Name.Contains(srch.ToUpper())
                             orderby find.Name.ToUpper()
                             select find;
                if (search.Count() > 0)
                {
                    chklstGrp.DataSource = search;
                    chklstGrp.DataValueField = "UID";
                    chklstGrp.DataTextField = "Name";
                    chklstGrp.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert(No Such Records found);", true);
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error Occured in the Group master search in Group Master ", ex);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Search Group Master", ex);
        }

    }
    protected void btnfind_Click(object sender, EventArgs e)
    {
        
            List<OrderedInvestigations> objSrch = new List<OrderedInvestigations>();
            try
            {
                string srch = txtInvname.Text.Trim();
                objSrch = (List<OrderedInvestigations>)Session["InvGrpmap"];
                var search = from find in objSrch
                             where
                             find.Name.Contains(srch.ToUpper())
                             orderby find.Name.ToUpper()
                             select find;                

                if (search.Count() > 0)
                {
                    chkGrpMap.DataSource = search;
                    chkGrpMap.DataTextField = "Name";
                    chkGrpMap.DataValueField = "ID";
                    chkGrpMap.DataBind();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "srchmap", "javascript:alert(No Such Records found);", true);
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error Occured in the Group Map Search in Group Master", ex);
            }
        
    }
    protected void btnGrpAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string type = "GRP";
            int ddlCase = 3;
            int iDptId = 0;
            long lHeader = 0;
            long returnCode = -1;
            string GroupCode = string.Empty;
            string BillingName = string.Empty;
            string Status = string.Empty;
            string Pkgcode = string.Empty;
            string Remarks = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            List<InvestigationOrgMapping> objGpMas = new List<InvestigationOrgMapping>();
            List<OrderedInvestigations> final = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objSearch = new List<OrderedInvestigations>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            objSearch = (List<OrderedInvestigations>)Session["InvGrpmas"];
            DataTable dtCodingSchemeMaster=new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            //Get the Selected Item in checkboxlist using LINQ.
            IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items
                                                where item.Selected
                                                select item);
            
            foreach (ListItem item in allChecked)
            {
                //OrderedInvestigations obj = new OrderedInvestigations();
                //obj.InvestigationID = Convert.ToInt64(item.Value);
                //obj.InvestigationName = item.Text;
                //objInvMas.Add(obj);

                string[] strValue = item.Value.Split('~');
                InvestigationOrgMapping obj = new InvestigationOrgMapping();
                obj.Display = strValue[1] == "GRP" ? "Y" : "N";
                obj.InvestigationID = Convert.ToInt64(strValue[0]);
                obj.InvestigationName = item.Text;
                obj.OrgID = gid;
                obj.DeptID = 0;
                obj.HeaderID = 0;
                objMap.Add(obj);
            }

            //using LINQ to add extra attribute type to differentiate the Group or Investigaion
            
            //var finallst = (from lst in objInvMas 
            //               join lstcheck in objSearch on lst.Name equals lstcheck.Name
            //               select new 
            //               {
            //               InvestigationID = lst.InvestigationID,
            //               InvestigationName = lst.InvestigationName,
            //               Type=(lstcheck.Type=="GRP"? "Y":"N")
            //               }).ToList();

            //final = finallst.ToList<OrderedInvestigations>();
            //foreach (var item in finallst)
            //{
            //    InvestigationOrgMapping obj = new InvestigationOrgMapping();
            //    obj.Display = item.Type;
            //    obj.InvestigationID = item.InvestigationID;
            //    obj.InvestigationName = item.InvestigationName;
            //    obj.OrgID = gid;
            //    obj.DeptID = 0;
            //    obj.HeaderID = 0;
            //    objMap.Add(obj);
            //}
            returnCode = ObjInv.SaveInvestigationGrpName(objMap, Hdngid.Value, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, Remarks, Status, Pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Changes saved successfully.');", true);
            }
            show(int.Parse(Hdngid.Value));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured while Add items in group", ex);
        }
    }
    protected void btnGrpRemove_Click(object sender, EventArgs e)
    {
        try
        {  
            string Status =string.Empty;
             string Pkgcode =string.Empty;
             string Remarks = string.Empty;
            string type = "GRP";
            int ddlCase = 5;
            int iDptId = 0;
            long lHeader = 0;
            long returnCode = -1;
            string GroupCode = string.Empty;
            string BillingName = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> objInvMas = new List<InvestigationOrgMapping>();
            //Get the Selected Item in checkboxlist using LINQ.
            IEnumerable<ListItem> allChecked = (from ListItem item in chkGrpMap.Items
                                                where item.Selected
                                                select item);
            foreach (ListItem item in allChecked)
            {
                InvestigationOrgMapping obj = new InvestigationOrgMapping();
                obj.InvestigationID = Convert.ToInt64(item.Value.Split('~')[0]);
                obj.InvestigationName  = item.Text;
                obj.OrgID = OrgID;
                obj.DeptID = 0;
                obj.HeaderID = 0;
                obj.Display = item.Value.Split('~')[1] == "GRP" ? "Y" : "N";
                objInvMas.Add(obj);
            }
            ModifiedBy =Convert.ToInt64 (LID).ToString ();
            returnCode = ObjInv.SaveInvestigationGrpName(objInvMas, Hdngid.Value, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, Remarks, Status, Pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alll", "javascript:alert('Sucessfully removed!');", true);
            }
                show(int.Parse(Hdngid.Value));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured while Remove items in group", ex);
        }
    }
}
