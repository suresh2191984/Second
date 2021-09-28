using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;

public partial class CommonControls_ManageInvestigation : BaseControl
{
    public CommonControls_ManageInvestigation()
        : base("CommonControls_ManageInvestigation_ascx")
    {
    }
    string ModifiedBy = string.Empty;
    int gid;
    List<InvestigationMaster> objSearch = new List<InvestigationMaster>();
    List<InvestigationMaster> objmapSearch = new List<InvestigationMaster>();
    List<InvestigationMaster> objMap = new List<InvestigationMaster>();
    List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
    Investigation_BL ObjInv;
    public string save_message = Resources.AppMessages.Save_Message;
    public string removal_message = Resources.AppMessages.Removal_Message;
    public string ntfound_mesge = Resources.AppMessages.NotFound_Message;
    public void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            if (!IsPostBack)
            {
               
                //fill();
                txt_gid.Text = "";
                    
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Page Load", ex);
        }
    }
    //public CommonControls_ManageInvestigation()
    //{ }
    public void fill()
    {
        try
        {
            chklstGrp.Items.Clear();
            chkGrpMap.Items.Clear();
            ObjInv = new Investigation_BL(base.ContextInfo);
            ObjInv.GetInvList(OrgID, out objMap);
            //Session["search"] = new List<InvestigationMaster>();
            //Session["search"] = objMap;
            if (objMap.Count > 0)
            {
                //txt_search.Text = String.Empty;
                txt_searchmap.Text = String.Empty;
                //split the mapped and unmapped Investigation using LINQ
                //if (txt_searchmap.Text != "")
                //{
                    var temp = from s in objMap
                               where s.IsMapped == "Y"
                               orderby s.InvestigationName
                               select s;
                    chkGrpMap.DataSource = temp;
                    chkGrpMap.DataValueField = "InvestigationID";
                    chkGrpMap.DataTextField = "InvestigationName";
                    chkGrpMap.DataBind();
                //}

                var tempmap = from map in objMap
                              where map.IsMapped == "N"
                              orderby map.InvestigationName
                              select map;
                
                if (chkmasshow.Checked == false)
                {
                    chklstGrp.DataSource = tempmap;
                    chklstGrp.DataValueField = "InvestigationID";
                    chklstGrp.DataTextField = "InvestigationName";
                    chklstGrp.DataBind();
                }
                else if (txt_search.Text != "")
                {
                    string srch = txt_search.Text.Trim();
                    var search = from find in objMap
                                 where
                                 find.InvestigationName.Contains(srch.ToUpper()) &&
                                 find.IsMapped == "N"
                                 orderby find.InvestigationName.ToUpper()
                                 select find;

                    if (search.Count() > 0)
                    {
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "InvestigationID";
                        chklstGrp.DataTextField = "InvestigationName";
                        chklstGrp.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Investigation", ex);
        }
    }
    public void show(int OrganId,int id)
    {
        //this.Load += new EventHandler(Page_Load);
       //btnInvAdd.Click += new EventHandler(this.btnInvAdd_Click);
        //((IPostBackEventHandler)this.Page).RaisePostBackEvent(null);
        try
        {
            chklstGrp.Items.Clear();            
            chkGrpMap.Items.Clear();
            txt_search.Text = "";
            //if (txt_search.Text.Trim() != "")
            //{
                txt_gid.Text = id.ToString();
                long Returncode = -1;
                string groupname;
                OrderedInvestigations obj = new OrderedInvestigations();
                Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
                List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
                objInvMas.Clear();
                objInvGrp.Clear();
                Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrganId, id, out objInvMas);
                Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrganId, id, out objInvGrp, out groupname);
                Label3.Text = groupname;

                var temp = from s in objInvMas
                           where s.Type == "INV"
                           orderby s.InvestigationName
                           select s;

                var tempmap = from map in objInvGrp
                              orderby map.InvestigationName
                              select map;
                //Session["InvGrpmas"] = new List<OrderedInvestigations>();
                //Session["InvGrpmas"] = objInvMas;
                //Session["InvGrpmap"] = new List<OrderedInvestigations>();
                //Session["InvGrpmap"] = objInvGrp;
                //if (objInvMas.Count > 0)
                //{
                if (txt_search.Text.Trim() != "")
                {
                    chklstGrp.DataSource = temp;
                    chklstGrp.DataTextField = "Name";
                    chklstGrp.DataValueField = "ID";
                    chklstGrp.DataBind();
                }
                //}
                //if (objInvGrp.Count > 0)
                //{
                chkGrpMap.DataSource = tempmap;
                chkGrpMap.DataTextField = "Name";
                chkGrpMap.DataValueField = "ID";
                chkGrpMap.DataBind();
                //}
                //else
                //{
                //    chkGrpMap.DataSource = "";
                //    chkGrpMap.DataBind();
                //}

            //}
                chkmasshow.Visible = false;
                rdoGroup.Visible = true;
                rdoInvestigation.Visible = true;
                //rdoInvestigation.Checked = true;
           
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Show Group", ex);
        }
    }
    protected void btnInvAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string type;
            string GroupCode = string.Empty;
            string BillingName = string.Empty;
            int count = 0;
            long returnCode = -1;
            int ddlCase = 3;
            int iDptId = 0;
            long lHeader = 0;
            string remarks = string.Empty;
            string status = string.Empty;
            string pkgcode = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            DataTable dtcodingSchememaster = new DataTable();
            dtcodingSchememaster.Columns.Add("CodeLabel");
            dtcodingSchememaster.Columns.Add("CodeTextbox");
            dtcodingSchememaster.Columns.Add("CodeMasterID");
            dtcodingSchememaster.AcceptChanges(); 
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            List<InvestigationOrgMapping> objGpMas = new List<InvestigationOrgMapping>();
            List<OrderedInvestigations> final = new List<OrderedInvestigations>();
            List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
            //List<OrderedInvestigations> objSearch = new List<OrderedInvestigations>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            if (txt_gid.Text != "")
            {
                if ((rdoGroup.Visible == false && rdoInvestigation.Visible == false) || rdoInvestigation.Checked == true)
                {
                    type = "INV";


                    //objSearch = (List<OrderedInvestigations>)Session["InvGrpmas"];
                    //Get the Selected Item in checkboxlist using LINQ.
                    IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items.Cast<ListItem>()
                                                        where item.Selected
                                                        select item);

                    foreach (ListItem item in allChecked)
                    {
                        count = count + 1;
                        //OrderedInvestigations obj = new OrderedInvestigations();
                        //obj.InvestigationID = Convert.ToInt64(item.Value);
                        //obj.InvestigationName = item.Text;
                        //objInvMas.Add(obj);

                        //string[] strValue = item.Value.Split('~');
                        InvestigationOrgMapping obj = new InvestigationOrgMapping();
                        obj.Display = "N";
                        obj.InvestigationID = Convert.ToInt32(item.Value);
                        obj.InvestigationName = item.Text;
                        obj.OrgID = Convert.ToInt32(txt_gid.Text);
                        obj.DeptID = 0;
                        obj.HeaderID = 0;
                        obj.IsActive = "Y";
                        obj.Interpretation = "A";
                        obj.DisplayText = item.Text;
                        objMap.Add(obj);
                    }
                }
                else
                {
                    type = "GRP";


                    IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items.Cast<ListItem>()
                                                        where item.Selected
                                                        select item);

                    foreach (ListItem item in allChecked)
                    {
                        count = count + 1;
                        //OrderedInvestigations obj = new OrderedInvestigations();
                        //obj.InvestigationID = Convert.ToInt64(item.Value);
                        //obj.InvestigationName = item.Text;
                        //objInvMas.Add(obj);

                        //string[] strValue = item.Value.Split('~');
                        InvestigationOrgMapping obj = new InvestigationOrgMapping();
                        obj.Display = "Y";
                        obj.InvestigationID = Convert.ToInt32(item.Value);
                        obj.InvestigationName = item.Text;
                        obj.OrgID = Convert.ToInt32(txt_gid.Text);
                        obj.DeptID = 0;
                        obj.HeaderID = 0;
                        obj.IsActive = "Y";
                        obj.Interpretation = "A";
                        obj.DisplayText = item.Text;
                        objMap.Add(obj);
                    }
                }
                if (count == 0)
                {
                    
                  //  string sPath = "CommonControls\\\\ManageInvestigation.ascx.cs_2";
                    string sPath = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_03 == null ? "select an item to add" : Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_03;
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowAlertMsg('" + sPath + "');", true);
                }
                else
                {
                    returnCode = ObjInv.SaveInvestigationGrpName(objMap, txt_gid.Text.ToString(), BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtcodingSchememaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType, false);
                    if (returnCode > 0)
                    {
                        string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                        string SaveDisplayMsg = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_01 == null ? "Save Successfully !!" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_01;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + SaveDisplayMsg + "','" + Information + "');", true);

                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('" + save_message + "');", true);
                        fill();
                    }
                    if (rdoInvestigation.Checked == true)
                    {
                        show(OrgID, Convert.ToInt32(txt_gid.Text));
                    }
                    else
                    {
                        int id;
                        id = Convert.ToInt32(txt_gid.Text);
                        long Returncode = -1;
                        string groupname;
                        OrderedInvestigations obj = new OrderedInvestigations();
                        Investigation_BL ObjInv1 = new Investigation_BL(base.ContextInfo);
                        List<OrderedInvestigations> objInvMas1 = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
                        objInvMas.Clear();
                        objInvGrp.Clear();
                        Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrgID, id, out objInvMas1);
                        Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrgID, id, out objInvGrp, out groupname);
                        Label3.Text = groupname;
                        var temp = from s in objInvMas1
                                   where s.Type == "GRP"
                                   orderby s.InvestigationName
                                   select s;

                        var tempmap = from map in objInvGrp
                                      orderby map.InvestigationName
                                      select map;
                        chklstGrp.DataSource = temp;
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataBind();
                        chkGrpMap.DataSource = tempmap;
                        chkGrpMap.DataTextField = "Name";
                        chkGrpMap.DataValueField = "ID";
                        chkGrpMap.DataBind();
                        chkmasshow.Visible = false;
                        rdoGroup.Visible = true;
                        rdoInvestigation.Visible = true;
                    }
                }
            }
            else
            {
                List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
                //Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                //long returnCode = -1;
                //Get the Selected Item in checkboxlist using LINQ.
                IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items.Cast<ListItem>()
                                                    where item.Selected
                                                    select item);

                foreach (ListItem item in allChecked)
                {
                    InvestigationOrgMapping objmap = new InvestigationOrgMapping();
                    objmap.InvestigationID = Int64.Parse(item.Value);
                    objmap.InvestigationName = item.Text;
                    objmap.DisplayText = item.Text;
                    objmap.OrgID = OrgID;
                    objmap.Interpretation = "A";
                    lstIOM.Add(objmap);
                }
                if (lstIOM.Count > 0)
                {
                    returnCode = ObjInv.SaveInvestigationName(lstIOM);
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    string SaveDisplayMsg = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_01 == null ? "Save Successfully !!" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + SaveDisplayMsg + "','" + Information + "');", true);

                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('" + save_message + "');", true);
                    fill();
                    //loadInvestigationgrid();
                }
                else
                {
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    string sPath = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_03 == null ? "select an item to add " : Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_03;
                    //string sPath = "CommonControls\\\\ManageInvestigation.ascx.cs_2";
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowAlertMsg('" + sPath + "');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Add Investigation", ex);
        }
    }

    protected void btnInvRemove_Click(object sender, EventArgs e)
    {
        try
        {
            int cnt = 0;
            if (txt_gid.Text != "")
            {
                string type = "GRP";
                string GroupCode = string.Empty;
                int ddlCase = 5;
                int iDptId = 0;
                long lHeader = 0;
                long returnCode = -1;
                string remarks = string.Empty;
                string status = string.Empty;
                string pkgcode = string.Empty;
                string BillingName = string.Empty;
                int CutOffTimeValue = 0;
                string CutOffTimeType = string.Empty;
                string Gender = string.Empty;
                string IsServiceTaxable = string.Empty;
                short ScheduleType = 0;
                DataTable dtcodingSchememaster = new DataTable();
                dtcodingSchememaster.Columns.Add("CodeLabel");
                dtcodingSchememaster.Columns.Add("CodeTextbox");
                dtcodingSchememaster.Columns.Add("CodeMasterID");
                dtcodingSchememaster.AcceptChanges(); 
                List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
                Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                List<InvestigationOrgMapping> objInvMas = new List<InvestigationOrgMapping>();
                //Get the Selected Item in checkboxlist using LINQ.
                IEnumerable<ListItem> allChecked = (from ListItem item in chkGrpMap.Items
                                                    where item.Selected
                                                    select item);
                foreach (ListItem item in allChecked)
                {
                    cnt = cnt + 1;
                    InvestigationOrgMapping obj = new InvestigationOrgMapping();
                    obj.InvestigationID = Convert.ToInt64(item.Value);
                    obj.InvestigationName = item.Text;
                    obj.OrgID = OrgID;
                    obj.DeptID = 0;
                    obj.HeaderID = 0;
                    obj.Interpretation = "D";
                    obj.Display = "Y";
                    objInvMas.Add(obj);
                }
                if (cnt == 0)
                {
                    //string sPath = "CommonControls\\\\ManageInvestigation.ascx.cs_1";
                    string sPath = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_02 == null ? "select an item to remove" : Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_02;
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowAlertMsg('" + sPath + "');", true);
                    
                }
                else
                {
                    ModifiedBy = Convert.ToInt64(LID).ToString();
                    returnCode = ObjInv.SaveInvestigationGrpName(objInvMas, txt_gid.Text.ToString(), BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtcodingSchememaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType, false);
                    if (returnCode > 0)
                    {
                        string sPath = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_02 == null ? "Successfully removed!" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_02;
                        string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alll", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                    
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alll", "javascript:alert('" + removal_message + "');", true);
                        fill();
                    }
                    if (rdoInvestigation.Checked == true)
                    {
                        show(OrgID, Convert.ToInt32(txt_gid.Text));
                    }
                    else
                    {
                        int id;
                        id = Convert.ToInt32(txt_gid.Text);
                        long Returncode = -1;
                        string groupname;
                        OrderedInvestigations obj = new OrderedInvestigations();
                        Investigation_BL ObjInv1 = new Investigation_BL(base.ContextInfo);
                        List<OrderedInvestigations> objInvMas1 = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
                        objInvMas.Clear();
                        objInvGrp.Clear();
                        Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrgID, id, out objInvMas1);
                        Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrgID, id, out objInvGrp, out groupname);
                        Label3.Text = groupname;
                        var temp = from s in objInvMas1
                                   where s.Type == "GRP"
                                   orderby s.InvestigationName
                                   select s;

                        var tempmap = from map in objInvGrp
                                      orderby map.InvestigationName
                                      select map;
                        chklstGrp.DataSource = temp;
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataBind();
                        chkGrpMap.DataSource = tempmap;
                        chkGrpMap.DataTextField = "Name";
                        chkGrpMap.DataValueField = "ID";
                        chkGrpMap.DataBind();
                        chkmasshow.Visible = false;
                        rdoGroup.Visible = true;
                        rdoInvestigation.Visible = true;
                    }
                }
            }
            else
            {
                List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
                Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                long returnCode = -1;
                string inv;
                //InvestigationOrgMapping objmap = new InvestigationOrgMapping();
                //Get the Selected Item in checkboxlist using LINQ.
                IEnumerable<ListItem> allChecked = (from item in chkGrpMap.Items.Cast<ListItem>()
                                                    where item.Selected
                                                    select item);

                foreach (ListItem item in allChecked)
                {
                    cnt = cnt + 1;
                    InvestigationOrgMapping objmap = new InvestigationOrgMapping();
                    objmap.InvestigationID = Int64.Parse(item.Value);
                    objmap.InvestigationName = item.Text;
                    objmap.OrgID = OrgID;
                    objmap.Interpretation = "D";
                    lstIOM.Add(objmap);
                }
                if (lstIOM.Count > 0)
                {
                    returnCode = ObjInv.DeleteInvestigationName(lstIOM, out inv);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Removed Successfully " + inv{0}: + " The other investigations are ordered, hence they cannot be removed.  ',inv);", true);

                    fill();
                }
                else
                {
                    //string sPath = "CommonControls\\\\ManageInvestigation.ascx.cs_1";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowAlertMsg('"+ sPath +"');", true);
                    ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('select an item to remove');", true);
                    string sPath = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_02 == null ? "select an item to remove" : Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_02;
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                    
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Remove Investigation", ex);
        }
    }
    protected void rdoInvestigation_CheckedChanged(object sender, EventArgs e)
    {
        show(OrgID, Convert.ToInt32(txt_gid.Text));
    }
    protected void rdoGroup_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            int id;
            /*AB Code*/
            txt_search.Text = "";
            /**/
            id = Convert.ToInt32(txt_gid.Text);
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
            Label3.Text = groupname;
            var temp = from s in objInvMas
                       where s.Type == "GRP"
                       orderby s.InvestigationName
                       select s;

            var tempmap = from map in objInvGrp
                          orderby map.InvestigationName
                          select map;
            chklstGrp.DataSource = temp;
            chklstGrp.DataTextField = "Name";
            chklstGrp.DataValueField = "ID";
            chklstGrp.DataBind();
            chkGrpMap.DataSource = tempmap;
            chkGrpMap.DataTextField = "Name";
            chkGrpMap.DataValueField = "ID";
            chkGrpMap.DataBind();
            chkmasshow.Visible = false;
            rdoGroup.Visible = true;
            rdoInvestigation.Visible = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Show Group", ex);
        } 
    }
    protected void btnmassearch_Click(object sender, EventArgs e)
    {
        try
        {
            ObjInv = new Investigation_BL(base.ContextInfo);
            if (txt_gid.Text != "")
            {
                long Returncode = -1;
                List<OrderedInvestigations> objInvMas = new List<OrderedInvestigations>();
                string srch = txt_search.Text.Trim();
                
                Returncode = ObjInv.GetInvForMDLoadInvInNewGrp(OrgID, Convert.ToInt32(txt_gid.Text), out objInvMas);
                if (rdoInvestigation.Checked == true)
                {
                    if (srch.Length == 2)
                    {
                        var search = from find in objInvMas
                                     where (find.Name.Contains(srch.ToUpper()) || find.Name.Equals(srch.ToUpper())) && find.Type == "INV"
                                     orderby find.Name.ToUpper()
                                     select find;
                        //if (search.Count() > 0)
                        //{
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataBind();
                    }
                    else
                    {
                        var search = from find in objInvMas
                                     where find.Name.Contains(srch.ToUpper()) && find.Type == "INV"
                                     orderby find.Name.ToUpper()
                                     select find;
                        //if (search.Count() > 0)
                        //{
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataBind();

                    }
                    //}
                    
                }
                else
                {
                    if (srch.Length == 2)
                    {
                        var search = from find in objInvMas
                                     where (find.Name.Contains(srch.ToUpper()) || find.Name.Equals(srch.ToUpper())) && find.Type == "GRP"
                                     orderby find.Name.ToUpper()
                                     select find;
                        //if (search.Count() > 0)
                        //{
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataBind();
                        //}

                    }
                    else
                    {
                        var search = from find in objInvMas
                                     where find.Name.Contains(srch.ToUpper()) && find.Type == "GRP"
                                     orderby find.Name.ToUpper()
                                     select find;
                        //if (search.Count() > 0)
                        //{
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "ID";
                        chklstGrp.DataTextField = "Name";
                        chklstGrp.DataBind();
                    }
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert(No Such Records found);", true);
                    //}
                }
                
                chkmasshow.Checked = false;
            }
            else
            {
                string srch = txt_search.Text.Trim();

                // using LINQ search the investigation
                ObjInv.GetInvList(OrgID, out objSearch);
                if (srch.Length == 2)
                {
                    var search = from find in objSearch
                                 where
                                 find.InvestigationName.Equals(srch.ToUpper()) &&
                                 find.IsMapped == "N"
                                 orderby find.InvestigationName.ToUpper()
                                 select find;

                    if (search.Count() > 0)
                    {
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "InvestigationID";
                        chklstGrp.DataTextField = "InvestigationName";
                        chklstGrp.DataBind();
                    }
                    else
                    {
                        string MsgNotFound = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03 == null ? "No Matching Records found" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03;
                        string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + MsgNotFound + "','" + Information + "');", true);
                    
                        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('" + ntfound_mesge + "');", true);

                    }
                }
                else
                {
                    var search = from find in objSearch
                                 where
                                 find.InvestigationName.Contains(srch.ToUpper()) &&                                  
                                 find.IsMapped == "N"
                                 orderby find.InvestigationName.ToUpper()
                                 select find;

                    if (search.Count() > 0)
                    {
                        chklstGrp.DataSource = search;
                        chklstGrp.DataValueField = "InvestigationID";
                        chklstGrp.DataTextField = "InvestigationName";
                        chklstGrp.DataBind();
                    }
                    else
                    {
                        string MsgNotFound = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03 == null ? "No Matching Records found" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03;
                        string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + MsgNotFound + "','" + Information + "');", true);
                    
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('" + ntfound_mesge + "');", true);

                    }

                }
                chkmasshow.Checked = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Master Investigation Search", ex);
        }
    }
    protected void btnmapsearch_Click(object sender, EventArgs e)
    {
        try
        {
            ObjInv = new Investigation_BL(base.ContextInfo);
            if (txt_gid.Text != "")
            {
                long Returncode = -1;
                string groupname;
                string srch = txt_searchmap.Text.Trim();
                List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
                
                Returncode = ObjInv.GetInvForMDLoadInvGrpMAP(OrgID, Convert.ToInt32(txt_gid.Text), out objInvGrp, out groupname);
                if (srch.Length == 2)
                {
                    var search = from find in objInvGrp
                                 /*AB Added*/
                                 /*where find.Name.Equals(srch.ToUpper())*/
                                 where (find.Name.Contains(srch.ToUpper()) || find.Name.Equals(srch.ToUpper()))
                                 orderby find.Name.ToUpper()
                                 select find;

                    //if (search.Count() > 0)
                    //{
                    chkGrpMap.DataSource = search;
                    chkGrpMap.DataTextField = "Name";
                    chkGrpMap.DataValueField = "ID";
                    chkGrpMap.DataBind();
                }
                else
                {
                    var search = from find in objInvGrp
                                 where
                                 find.Name.Contains(srch.ToUpper())
                                 orderby find.Name.ToUpper()
                                 select find;

                //if (search.Count() > 0)
                //{
                    chkGrpMap.DataSource = search;
                    chkGrpMap.DataTextField = "Name";
                    chkGrpMap.DataValueField = "ID";
                    chkGrpMap.DataBind();
                }
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmap", "javascript:alert(No Such Records found);", true);
                //}
            }
            else
            {
            string srch = txt_searchmap.Text.Trim();
            // using LINQ search the investigation

            ObjInv = new Investigation_BL(base.ContextInfo);
            ObjInv.GetInvList(OrgID, out objSearch);
            if (srch.Length == 2)
            {
                var search = from find in objSearch
                                 where find.IsMapped == "Y" && find.Active.Trim() != "D" &&
                             find.InvestigationName.Equals(srch.ToUpper())
                                 orderby find.InvestigationName.ToUpper()
                                 select find;

                if (search.Count() > 0)
                {
                    chkGrpMap.DataSource = search;
                    chkGrpMap.DataValueField = "InvestigationID";
                    chkGrpMap.DataTextField = "InvestigationName";
                    chkGrpMap.DataBind();
                }
                else
                {
                    string MsgNotFound = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03 == null ? "No Matching Records found" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03;
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + MsgNotFound + "','" + Information + "');", true);
                    
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "javascript:alert('" + ntfound_mesge + "');", true);
                }
            }
            else
            {
                var search = from find in objSearch
                             where find.IsMapped == "Y" &&
                             find.InvestigationName.Contains(srch.ToUpper())
                             orderby find.InvestigationName.ToUpper()
                             select find;

                if (search.Count() > 0)
                {
                    chkGrpMap.DataSource = search;
                    chkGrpMap.DataValueField = "InvestigationID";
                    chkGrpMap.DataTextField = "InvestigationName";
                    chkGrpMap.DataBind();
                }
                else
                {
                    string MsgNotFound = Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03 == null ? "No Matching Records found" : Resources.CommonControls_ClientDisplay.CommonControls_ManageInvestigation_ascx_03;
                    string Information = Resources.CommonControls_AppMsg.CommonControls_ManageInvestigation_ascx_01;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + MsgNotFound + "','" + Information + "');", true);
                    
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "javascript:alert('" + ntfound_mesge + "');", true);
                }
            }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Mapped Investigation Search", ex);
        }
    }
    protected void chkmasshow_CheckedChanged(object sender, EventArgs e)
    {
        if (chkmasshow.Checked == true)
        {
            if (txt_gid.Text != "")
            {
                show(OrgID, Convert.ToInt32(txt_gid.Text));
            }
            else
            {
                fill();
            }
        }
        else
        {
            DataTable dt = new DataTable();
            chklstGrp.DataSource =dt ;
            chklstGrp.DataBind();
        }
    }

}
