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

public partial class Admin_MappingInvtoGrp :BasePage
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
                Hdngid.Value = String.Empty;
                int.TryParse(Request.QueryString["gid"], out gid);
                Hdngid.Value = gid.ToString();
                show(gid);
                group=gid.ToString();                
                hdnInv.Value = String.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    public void show(int groupid)
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
            Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrgID, groupid, out objInvGrp);
            Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrgID, groupid, out objInvMas,out groupname);
           // Returncode = ObjInv.GetInvForMDMAddInvAndNewGrp(OrgID, "GRPINV", out objInvMas);
            lbl_id.Text = groupname;
            if (objInvMas.Count > 0)
            {
                chklstGrp.DataSource = objInvMas;
                chklstGrp.DataTextField = "Name";
                chklstGrp.DataValueField = "ID";                
                chklstGrp.DataBind();
            }
            if (objInvGrp.Count > 0)
            {
                chkGrpMap.DataSource = objInvGrp;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "ID" ;
                chkGrpMap.DataBind();
            }
            foreach (OrderedInvestigations  item in objInvMas)
            {                
                HdnAdd.Value += item.ID + "~" + item.Name+"~" + item.Type+"^";
            }
            //foreach (string splitGRP in HdnAdd.Value.Split('^'))
            //{
            //    if (splitGRP != string.Empty)
            //    {
            //        InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
            //        long Inv = Convert.ToInt64(splitGRP.Split('~')[0]);
            //        long CheckInv = Convert.ToInt64(Hdngid.Value);
            //        if (Inv == CheckInv)
            //        {
            //            lbl_id.Text = splitGRP.Split('~')[1].ToString();
            //        }
            //    }
            //}
            foreach (OrderedInvestigations item in objInvGrp)
            {
                HdnRemove.Value += item.ID + "~" + item.Name + "~" + item.Type + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnGrpAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string id = string.Empty;
            List<OrderedInvestigations> objInvMap = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInv = new List<OrderedInvestigations>();
            foreach (ListItem item in chkGrpMap.Items)
            {
                OrderedInvestigations obj = new OrderedInvestigations();
                obj.ID = Int64.Parse(item.Value);
                obj.Name = item.Text;
                objInvMap.Add(obj);
            }
            foreach (ListItem item in chklstGrp.Items)
            {                
                if (item.Selected)
                {                    
                        //if (x != string.Empty)
                        //{
                    if (chkGrpMap.Items.Contains(new ListItem(item.Text, item.Value)))
                            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Item already exist');", true);
                                return;
                            }
                            else
                            {                         
                                OrderedInvestigations obj = new OrderedInvestigations();
                                obj.ID = Int64.Parse(item.Value);
                                id = item.Value;
                                obj.Name = item.Text;
                                objInvMap.Add(obj);
                                hdnInv.Value += obj.ID + "~" + obj.Name + "^";
                            }
                        //}
                        //else
                        //{
                        //    OrderedInvestigations obj = new OrderedInvestigations();
                        //    obj.ID = Int64.Parse(item.Value);
                        //    id = item.Value;
                        //    obj.Name = item.Text;
                        //    objInvMap.Add(obj);
                        //    hdnInv.Value += obj.ID + "~" + obj.Name + "^";
                        //}                    
                }
                else
                {
                    OrderedInvestigations obj = new OrderedInvestigations();
                    obj.ID = Int64.Parse(item.Value);
                    obj.Name = item.Text;
                    objInv.Add(obj);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.Name
                           select s;
                chkGrpMap.DataSource = temp;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "ID";
                chkGrpMap.DataBind();
                //if (chkGrpMap.Items.FindByValue(id).Text != "")
                //{
                //    chkGrpMap.Items.FindByValue(id).Attributes.Add("style", "Color:blue");
                //}
            }
            if (objInv.Count > 0)
            {
                chklstGrp.DataSource = objInv;
                chklstGrp.DataTextField = "Name";
                chklstGrp.DataValueField = "ID";
                chklstGrp.DataBind();
            }
            else
            {
                chklstGrp.DataSource = objInv;
                chklstGrp.DataTextField = "Name";
                chklstGrp.DataValueField = "ID";
                chklstGrp.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnGrpRemove_Click(object sender, EventArgs e)
    {
        try
        {
            List<OrderedInvestigations> objInvMap = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInv = new List<OrderedInvestigations>();
            foreach (ListItem item in chklstGrp.Items)
            {
                OrderedInvestigations obj = new OrderedInvestigations();
                obj.ID = Int64.Parse(item.Value);
                obj.Name = item.Text;
                objInv.Add(obj);
            }
            foreach (ListItem item in chkGrpMap.Items)
            {
                OrderedInvestigations obj = new OrderedInvestigations();
                obj.ID = Int64.Parse(item.Value);                
                obj.Name = item.Text;                
                if (item.Selected)
                {                    
                objInv.Add(obj);
                hdnRemoveInv.Value += obj.ID + "~" + obj.Name + "^";
                }
                else
                {       
                    objInvMap.Add(obj);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.Name
                           select s;
                chkGrpMap.DataSource = temp;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "ID";
                chkGrpMap.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('The list cannot be empty');", true);
                objInv.Clear();
            }
            if (objInv.Count > 0)
            {
                var temp = from s in objInv
                           orderby s.Name
                           select s;
                chklstGrp.DataSource = temp;
                chklstGrp.DataTextField = "Name";
                chklstGrp.DataValueField = "ID";
                chklstGrp.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('The list cannot be empty');", true);
            }            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Remove", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string groupName = string.Empty;
            string BillingName = string.Empty;
            string GroupCode = string.Empty;
            string remarks = string.Empty;
            string status = string.Empty;
            string pkgcode = string.Empty;
            long returnCode = -1; 
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            string type = "GRP";
            int ddlCase = 3;
            int iDptId = 0;
            long lHeader = 0;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            DataTable dtCodingSchemeMaster=new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 

            if ((hdnInv.Value == String.Empty) && (hdnRemoveInv.Value == String.Empty))
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Select atleast one Group or Investigation!');", true);
                return;
            }
            if ((hdnInv.Value != String.Empty))
            {
                foreach (string splitGRPValue in hdnInv.Value.Split('^'))
                {
                    if (splitGRPValue != string.Empty)
                    {
                        foreach (string splitGRP in HdnAdd.Value.Split('^'))
                        {
                            if (splitGRP != string.Empty)
                            {
                                InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                                long iInv = Convert.ToInt64(splitGRPValue.Split('~')[0]);
                                long Inv = Convert.ToInt64(splitGRP.Split('~')[0]);
                                if (iInv == Inv)
                                {
                                    string iType = (splitGRP.Split('~')[2]);
                                    if (iType == "GRP")
                                    {
                                        objGpMas.Display = "Y";
                                    }
                                    else
                                    {
                                        objGpMas.Display = "";
                                    }
                                    objGpMas.InvestigationID = iInv;
                                    objGpMas.OrgID = gid;
                                    objGpMas.DeptID = 0;
                                    objGpMas.HeaderID = 0;
                                    objMap.Add(objGpMas);
                                }
                            }
                        }
                    }
                }
                returnCode = ObjInv.SaveInvestigationGrpName(objMap, Hdngid.Value, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Changes saved successfully.');", true);
            }

            if (hdnRemoveInv.Value.Split('^')[0] != "")
            {
                objMap.Clear();
                    type = "GRP";
                    ddlCase = 5;
                    iDptId = 0;
                    lHeader = 0;
                    foreach (string splitGRPValue in hdnRemoveInv.Value.Split('^'))
                    {
                        if (splitGRPValue != string.Empty)
                        {
                            InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                            long iInv = Convert.ToInt64(splitGRPValue.Split('~')[0]);
                            objGpMas.InvestigationID = iInv;
                            objGpMas.OrgID = OrgID;
                            objGpMas.DeptID = 0;
                            objGpMas.HeaderID = 0;
                            objMap.Add(objGpMas);
                        }
                    }
                    returnCode = ObjInv.SaveInvestigationGrpName(objMap, Hdngid.Value, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alll", "javascript:alert('Sucessfully removed!');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Remove", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {            
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInvMaP = new List<OrderedInvestigations>();
           // OrderedInvestigations obj = new OrderedInvestigations();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
                strTxtInvName = txtInvestigationName.Text;
                Returncode = ObjInv.SearchInvForMDMAddInvAndNewGrp(strTxtInvName, OrgID, "IDE",GroupCode, out objInvMas);
                //foreach (ListItem item in chkGrpMap.Items)
                //{
                    //foreach (OrderedInvestigations items in objInvMas)
                    //{
                    //    if (item.Text == items.Name)
                    //    {

                    //    }
                    //    else
                    //    {
                    //        obj.ID=items.ID;
                    //        obj.Name=items.Name;
                    //        objInvMaP.Add(obj);
                    //    }
                    //}
                //}
                foreach (OrderedInvestigations items in objInvMas)
                {
                    if (chkGrpMap.Items.Contains(new ListItem(items.Name,items.ID.ToString())))
                    {
                    }
                    else
                    {
                        OrderedInvestigations obj = new OrderedInvestigations();
                        obj.ID = items.ID;
                        obj.Name = items.Name;
                        objInvMaP.Add(obj);
                    }
                }


                if (objInvMas.Count > 0)
                {
                    chklstGrp.DataSource = objInvMaP;
                    chklstGrp.DataTextField = "Name";
                    chklstGrp.DataValueField = "ID";
                    chklstGrp.DataBind();                    
                }
                else
                {                    
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
                }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Find Group", ex);
        }
    }
    protected void btnfind_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            strTxtInvName = txtInvname.Text;
            Returncode = ObjInv.SearchInvForMDMAddInvAndINGrp(strTxtInvName, OrgID, Hdngid.Value, out objInvMas);
            if (objInvMas.Count > 0)
            {
                chkGrpMap.DataSource = objInvMas;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "ID";
                chkGrpMap.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Find Group", ex);
        }
    }
}
