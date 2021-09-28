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
public partial class Admin_AddInvGroups : BasePage{

    List<InvestigationMaster> objInvdet = new List<InvestigationMaster>();
    
    string Hdn;
    string Hdngrp;
    string ModifiedBy = string.Empty;
    ListItem lst = new ListItem();     
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                DivLoad();
                chkLstInv.Visible = false;
                HdnCntHeader.Value = "0";
                HdnRemoveGrp.Value = String.Empty;
                pnl_search.Visible = false;
                //HdnGrp.value = String.Empty;
                pnlinvmap.Visible = false;
                hInvName.Value = String.Empty;
                Hdngrp = String.Empty;
                //pnl.Visible = false;  
                pnl.Attributes.Add("Style", "Display:None");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while page load", ex);
        }
    }
    public void fill()
    {
        try
        {            
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
            long Returncode = -1;
            HdnLoad.Value = String.Empty;
            Returncode = ObjInv.GetInvForMDMAddInv(OrgID, "MAP", out objLoadInvMap);
            Investigation_BL Obj = new Investigation_BL(base.ContextInfo);
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
            Obj.getOrgDepartName(OrgID, out ObjInvDep);
            HdnDept.Value = "0" + "~" + "Select" + "^";
            foreach (InvDeptMaster dept in ObjInvDep)
            {
                HdnDept.Value += dept.DeptID + "~" + dept.DeptName + "^";
            }
            List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
            Obj.getOrgHeaderName(out objHeader);
            Hdnheader.Value = "0" + "~" + "Select" + "^";
            foreach (InvestigationHeader head in objHeader)
            {
                Hdnheader.Value += head.HeaderID + "~" + head.HeaderName + "^";
            }
            foreach (InvestigationOrgMapping item in objLoadInvMap)
            {
                HdnLoad.Value += item.InvestigationID + "~" + item.DeptID + "~" + item.HeaderID + "~" + item.InvestigationName + "^";
            }
            if (txtinvestigation.Text.Trim() != String.Empty)
            {
                mapSearch();                
            }
            else
            {
                grdResult.DataSource = objLoadInvMap;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while fill the investigation", ex);
        }
    }
    private void go()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvestigationMaster> objInvMap = new List<InvestigationMaster>();
            List<InvGroupMaster> objInvGrp = new List<InvGroupMaster>();
            List<InvGroupMaster> objGrpMap = new List<InvGroupMaster>();
            List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
            List<OrderedInvestigations> validID = new List<OrderedInvestigations>();
            List <OrderedInvestigations> grouvalid=new List<OrderedInvestigations> ();
            long Returncode = -1;                 
            if (ddlInves.SelectedIndex == 1)
            {
                if (HdnNewGrp.Value == String.Empty)
                {
                    btnSave.Text = "Save & Continue";
                    hdnInv.Value = String.Empty;
                    HdnCntDept.Value=String.Empty;

                    HdnCntHeader.Value=String.Empty;

                    HdnDeptvalid.Value=String.Empty;
                    HdnHeadvalid.Value = String.Empty;
                    btnSave.Attributes.Add("onClick", "return validateAddInv('" + ddlDept.ClientID + "','" + ddlHeader.ClientID + "');");
                    lstDepartName();
                    lstHeaderName();
                    Returncode = ObjInv.GetInvForMDMAddInvAndGrp(OrgID, "INV", out objInvMas);
                    if (objInvMas.Count > 0)
                    {
                        Chklst.DataSource = objInvMas;
                        Chklst.DataTextField = "InvestigationName";
                        Chklst.DataValueField = "InvestigationID";
                        Chklst.DataBind();
                        divInv.Visible = true;
                        divInvGp.Visible = false;
                        pnlINV.Visible = true;
                        pnlGRP.Visible = false;
                        pnlSave.Visible = true;
                        pnlHeader.Visible = false;
                        divInvDel.Visible = false;
                        PnlDelBtn.Visible = false;
                        PnlUpGp.Visible = false;
                        PnlEditGp.Visible = false;
                        pnlinvmap.Visible = false;
                        //PnlCreateGrp.Visible = false;
                    }
                    Returncode = ObjInv.GetInvForMDMAddInvAndGrp(OrgID, "INVMAP", out objInvMap);
                    if (objInvMap.Count > 0)
                    {
                        chklstInvmap.DataSource = objInvMap;
                        chklstInvmap.DataTextField = "InvestigationName";
                        chklstInvmap.DataValueField = "InvestigationID";
                        chklstInvmap.DataBind();
                    }
                }
                else
                {
                    ddlInves.SelectedIndex = 2;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Please save the selected Group');", true);
                    return; 
                }
            }
            else if (ddlInves.SelectedIndex == 2)
            {
                if (hdnInv.Value == String.Empty)
                {
                    HdnRemoveGrp.Value = String.Empty;                    
                    hInvName.Value = String.Empty;
                    HdnNewGrp.Value = String.Empty;
                    // btnSave.Attributes.Add("onClick", "return validateAddGrp('" + txtGpName.ClientID + "');");
                    Returncode = ObjInv.GetInvForMDMAddGrp(OrgID, "GRP", out objInvGrp,out validID );
                    if (objInvGrp.Count > 0)
                    {
                        chklstGrp.DataSource = objInvGrp;
                        chklstGrp.DataTextField = "GroupName";
                        chklstGrp.DataValueField = "GroupID";
                        chklstGrp.DataBind();
                        divInvGp.Visible = true;
                        divInv.Visible = false;
                        pnlHeader.Visible = false;
                        pnlGRP.Visible = true;
                        pnlINV.Visible = false;
                        pnlSave.Visible = true;
                        PnlUpGp.Visible = false;
                        PnlEditGp.Visible = false;
                        PnlINVdel.Visible = false;
                        PnlDelBtn.Visible = false;
                        pnl_search.Visible = false;
                        pnlinvmap.Visible = false;
                        HdnNewGrp.Value = String.Empty;
                    }
                    Returncode = ObjInv.GetInvForMDMAddGrp(OrgID, "GRPMAP", out objGrpMap,out grouvalid );
                    foreach (InvGroupMaster item in objGrpMap)
                    {
                        item.GroupName += "<input onclick='show(name);' name='" + item.GroupID + "'  value = 'Show' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    }
                    if (objGrpMap.Count > 0)
                    {
                        chkGrpMap.DataSource = objGrpMap;
                        chkGrpMap.DataTextField = "GroupName";
                        chkGrpMap.DataValueField = "GroupID";
                        chkGrpMap.DataBind();
                    }
                }
                else
                {
                    ddlInves.SelectedIndex = 1;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "inv", "alert('You havent yet saved the selected Investigation ');", true);
                    return;
                }
            }         
            
            else if (ddlInves.SelectedIndex == 3)
            {
                if (HdnNewGrp.Value == String.Empty)
                {
                    fill();
                    btnSave.Text = "Update";
                    HdnHeadvalid.Value = String.Empty;
                    pnlHeader.Visible = true;
                    divInvDel.Visible = false;
                    divInv.Visible = false;
                    divInvGp.Visible = false;
                    PnlINVdel.Visible = false;
                    pnlINV.Visible = false;
                    pnlGRP.Visible = false;
                    pnlSave.Visible = true;
                    PnlDelBtn.Visible = false;
                    PnlUpGp.Visible = false;
                    PnlEditGp.Visible = false;
                    pnl_search.Visible = true;
                    pnlinvmap.Visible = false;
                    //PnlCreateGrp.Visible = false;
                }
                else
                {
                    ddlInves.SelectedIndex = 2;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('You havent yet saved the selected Group');", true);
                    return; 
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }
    public void show(int groupid)
    {
        try
        {
            long Returncode = -1;
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvestigationMaster> objInvGrp = new List<InvestigationMaster>();
            objInvMas.Clear();
            objInvGrp.Clear();
            pnlinvmap.Visible = true;
            Returncode = ObjInv.GetInvForMDLoadInvInGrp(OrgID, groupid, out objInvGrp);
            Returncode = ObjInv.GetInvForMDMAddInvAndGrp(OrgID, "INV", out objInvMas);
            if (objInvMas.Count > 0)
            {
                chklstGrp.DataSource = objInvMas; 
                chklstGrp.DataTextField = "InvestigationName";
                chklstGrp.DataValueField = "InvestigationID";
                chklstGrp.DataBind();                
            }             
            if (objInvGrp.Count > 0)
            {
                chkGrpMap.DataSource = objInvGrp;
                chkGrpMap.DataTextField = "InvestigationName";
                chkGrpMap.DataValueField = "InvestigationID";
                chkGrpMap.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            go();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
       Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
       List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
       List<InvestigationMaster> objInvMap = new List<InvestigationMaster>();
       List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
       long Returncode = -1;
       string strTxtInvName = string.Empty;
       string GroupCode = string.Empty;
           strTxtInvName = txtInvestigationName.Text;
           Returncode = ObjInv.SearchInvForMDMAddInvAndGrp(strTxtInvName, OrgID, "INV",GroupCode, out objInvMas);
           if (objInvMas.Count > 0)
           {
               foreach (InvestigationMaster items in objInvMas)
                {
                    if (chklstInvmap.Items.Contains(new ListItem(items.InvestigationName, items.InvestigationID.ToString())))
                    {
                        
                    }
                    else
                    {
                        InvestigationMaster obj = new InvestigationMaster();
                        obj.InvestigationID = items.InvestigationID;
                        obj.InvestigationName = items.InvestigationName;
                        objInvMap.Add(obj);
                    }
                }
                   Chklst.DataSource = objInvMap;
                   Chklst.DataTextField = "InvestigationName";
                   Chklst.DataValueField = "InvestigationID";
                   Chklst.DataBind();
                   divInv.Visible = true;
                   divInvGp.Visible = false;
                   pnlSave.Visible = true;
                   pnlINV.Visible = true;     
           }
           else
           {
               divInv.Visible = true;
               divInvGp.Visible = false;
               pnlSave.Visible = true;
               pnlINV.Visible = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
           }            
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            string groupName;
            string type;
            long value;
            string text;
            string GroupCode = string.Empty;
            long returnCode = -1;
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            if (ddlInves.SelectedIndex == 3)
            {
                if (HdnNewGrp.Value == String.Empty)
                {
                    if (btnSave.Text != "Update")
                    {
                        foreach (string str in HdnHeadvalid.Value.Split('^'))
                        {
                            if (str != "")
                            {
                                InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                                string[] list = str.Split('~');
                                objGpMas.InvestigationID = Int64.Parse(list[0]);
                                objGpMas.DeptID = Int16.Parse(list[1]);
                                objGpMas.HeaderID = Int64.Parse(list[2]);
                                objGpMas.OrgID = OrgID;
                                objMap.Add(objGpMas);
                            }
                        }
                    }
                    else
                    {
                        foreach (string str in HdnUpdateDept.Value.Split('^'))
                        {
                            if (str != "")
                            {
                                InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                                string[] list = str.Split('~');
                                objGpMas.InvestigationID = Int64.Parse(list[0]);
                                objGpMas.DeptID = Int16.Parse(list[1]);
                                objGpMas.HeaderID = Int64.Parse(list[2]);
                                objGpMas.OrgID = OrgID;
                                objMap.Add(objGpMas);
                            }
                        }
                    }
                    if (objMap.Count > 0)
                    {
                        returnCode = ObjInv.SaveInvestigationName(objMap);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Changes saved successfully.');", true);
                        ddlInves.SelectedIndex = 1;
                        go();
                    }
                }
                else
                {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('At least one item needs to be added');", true);
                    return;
                }


            }
            else if (ddlInves.SelectedIndex == 2)
            {
                //if (hdnInv.Value == String.Empty)
                //{
                if (hdnInv.Value == String.Empty)
                {

                    if (HdnRemoveGrp.Value != String.Empty)
                    {
                        groupName = txtgrp.Text;
                        string BillingName = string.Empty;
                        type = "GRP";
                        int ddlCase = 6;
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
                        foreach (string splitGRPValue in HdnRemoveGrp.Value.Split('^'))
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
                        returnCode = ObjInv.SaveInvestigationGrpName(objMap, groupName, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                        if (returnCode > 0)
                        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Successfully removed');", true);
                        }
                    }

                }
                else
                {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('At least one investigation needs to be added');", true);
                    return;
                }
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('At least one investigation needs to be added');", true);
                //    return;
                //}
                HdnNewGrp.Value = String.Empty;
            }
            else if (ddlInves.SelectedIndex == 1)
            {
                if (hgroupName.Value == String.Empty)
                {                   
                        if (hdnInv.Value != String.Empty)
                        {
                            List<InvestigationMaster> lstinv = new List<InvestigationMaster>();
                            grdResult.DataSource = null;
                            grdResult.DataBind();
                            foreach (string str in hdnInv.Value.Split('^'))
                            {
                                if (str != "")
                                {
                                    string[] lst = str.Split('~');
                                    value = Int64.Parse(lst[0]);
                                    text = lst[1].ToString();
                                    if (chklstInvmap.Items.Contains(new ListItem(text, lst[0])))
                                    {
                                        InvestigationMaster inv = new InvestigationMaster();
                                        inv.InvestigationID = Int64.Parse(lst[0]);
                                        inv.InvestigationName = lst[1].ToString();
                                        if (lstinv.Contains(inv))
                                        {

                                        }
                                        else
                                        {
                                            lstinv.Add(inv);
                                        }
                                    }
                                    else
                                    {
                                        value = 0;
                                        text = String.Empty;
                                        InvestigationMaster inv = new InvestigationMaster();
                                        inv.InvestigationID = Int64.Parse(lst[0]);
                                        inv.InvestigationName = lst[1].ToString();
                                        lstinv.Add(inv);
                                        lstinv.Remove(inv);
                                    }
                                }
                            }
                            pnlHeader.Visible = true;
                            grdResult.DataSource = lstinv;
                            grdResult.DataBind();
                            Investigation_BL Obj = new Investigation_BL(base.ContextInfo);
                            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
                            Obj.getOrgDepartName(OrgID, out ObjInvDep);
                            HdnDept.Value = "0" + "~" + "Select" + "^";
                            foreach (InvDeptMaster dept in ObjInvDep)
                            {
                                HdnDept.Value += dept.DeptID + "~" + dept.DeptName + "^";
                            }
                            List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
                            Obj.getOrgHeaderName(out objHeader);
                            Hdnheader.Value = "0" + "~" + "Select" + "^";
                            foreach (InvestigationHeader head in objHeader)
                            {
                                Hdnheader.Value += head.HeaderID + "~" + head.HeaderName + "^";
                            }
                            pnlINV.Visible = false;
                            divInv.Visible = false;
                            ddlInves.SelectedIndex = 3;
                        }
                        else
                        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('At least one item needs to be added');", true);
                            return;
                        }
                    
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }       
    }
    protected void lstEditGp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objMas = new List<InvestigationMaster>();
            List<InvestigationOrgMapping> objOrgMap = new List<InvestigationOrgMapping>();
            if (rdoBtnShow.Checked == true)
            {
                chkLstInv.Visible = true;
                int OrgGroupID = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                Returncode = ObjInv.GetInvGroupLt(OrgGroupID, out objMas);
                chkLstInv.DataSource = objMas;
                chkLstInv.DataTextField = "InvestigationName";
                chkLstInv.DataValueField = "InvestigationID";
                chkLstInv.DataBind();
            }
            else if (rdoBtnAddInv.Checked == true)
            {
                chkLstInv.Visible = true;
                int GroupID = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                Returncode = ObjInv.GetAddNewINVGroup(OrgID, GroupID, out objOrgMap);
                chkLstInv.DataSource = objOrgMap;
                chkLstInv.DataTextField = "InvestigationName";
                chkLstInv.DataValueField = "InvestigationID";
                chkLstInv.DataBind();
            }
            DivDisplay();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }

    protected void rdoBtnShow_CheckedChanged(object sender, EventArgs e)
    {

        if (rdoBtnShow.Checked == true)
        {
            btnDeleteGp.Text = "Delete";
            lstEditGp.SelectedIndex = -1;
        }
        else if (rdoBtnAddInv.Checked == true)
        {
            btnDeleteGp.Text = "Update";
            lstEditGp.SelectedIndex = -1;
        }
        DivDisplay();
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        CancelButtonClick();
    }

    protected void btnDelCancel_Click1(object sender, EventArgs e)
    {
        CancelButtonClick();
    }

    protected void btnUpCancel_Click(object sender, EventArgs e)
    {
        CancelButtonClick();

    }
    public void CancelButtonClick()
    {
        long Returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            //Response.Redirect(Helper.GetAppName() + path, true);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        string strInvID = string.Empty;
        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
        foreach (string splitValue in hInvDel.Value.Split('^'))
        {
            if (splitValue != string.Empty)
            {
                strInvID += splitValue.Split('~')[0].ToString() + ",";
            }
        }
        Returncode = ObjInv.GetDeleteMDMInv(OrgID, strInvID);
        if (Returncode == 0)
        {
            divInvDel.Visible = true;
            divInv.Visible = false;
            divInvGp.Visible = false;
            pnlSave.Visible = false;
            PnlINVdel.Visible = true;
            PnlDelBtn.Visible = true;
        }
        btnSearch_Click(sender, e);
    }
    
    protected void btnDeleteGp_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnDeleteGp.Text == "Delete")
            {
                long Returncode = -1;
                string strInvID = string.Empty;
                Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
                foreach (ListItem lstValue in chkLstInv.Items)
                {
                    if (lstValue.Selected)
                    {
                        InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                        long iInv = Convert.ToInt64(lstValue.Value);
                        objGpMas.InvestigationID = iInv;
                        objGpMas.OrgID = OrgID;
                        strInvID += iInv + ",";
                    }
                }
                int OrgGroupID = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                Returncode = ObjInv.GetDeleteShowInv(OrgGroupID, strInvID);
                if (Returncode == 0)
                {
                    Investigation_BL ObjInv1 = new Investigation_BL(base.ContextInfo);
                    List<InvestigationMaster> objMas = new List<InvestigationMaster>();
                    int OrgGroupID1 = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                    Returncode = ObjInv1.GetInvGroupLt(OrgGroupID1, out objMas);
                    chkLstInv.DataSource = objMas;
                    chkLstInv.DataTextField = "InvestigationName";
                    chkLstInv.DataValueField = "InvestigationID";
                    chkLstInv.DataBind();
                    DivDisplay();
                    lstEditGp.SelectedIndex = -1;
                }
            }

            if (btnDeleteGp.Text == "Update")
            {
                long Returncode = -1;
                string strInvID = string.Empty;
                Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
                List<InvGroupMapMaster> objMap = new List<InvGroupMapMaster>();
                foreach (ListItem lstValue in chkLstInv.Items)
                {
                    if (lstValue.Selected)
                    {
                        InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                        long iInv = Convert.ToInt64(lstValue.Value);
                        objGpMas.InvestigationID = iInv;
                        objGpMas.OrgID = OrgID;
                        strInvID += iInv + ",";
                    }
                }
                int OrgGroupID = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                Returncode = ObjInv.SaveNewInvestigation(OrgGroupID, strInvID);
                if (Returncode == 0)
                {
                    Investigation_BL ObjInv1 = new Investigation_BL(base.ContextInfo);
                    List<InvestigationOrgMapping> objOrgMap = new List<InvestigationOrgMapping>();
                    int GroupID = Convert.ToInt32(lstEditGp.SelectedItem.Value);
                    Returncode = ObjInv1.GetAddNewINVGroup(OrgID, GroupID, out objOrgMap);
                    chkLstInv.DataSource = objOrgMap;
                    chkLstInv.DataTextField = "InvestigationName";
                    chkLstInv.DataValueField = "InvestigationID";
                    chkLstInv.DataBind();
                    DivDisplay();
                    lstEditGp.SelectedIndex = -1;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }

    

    public void DivDisplay()
    {
        divEditGp.Visible = true;
        divInvGp.Visible = false;
        divInv.Visible = false;
        divInvDel.Visible = false;
        PnlEditGp.Visible = true;
        PnlUpGp.Visible = true;
        pnlGRP.Visible = false;
        pnlINV.Visible = false;
        PnlINVdel.Visible = false;
        pnlSave.Visible = false;
        
    }
    
    public void DivLoad()
    {
        try
        {
            divInv.Visible = false;
            divInvGp.Visible = false;
            divInvDel.Visible = false;
            pnlINV.Visible = false;
            pnlGRP.Visible = false;
            PnlINVdel.Visible = false;
            PnlDelBtn.Visible = false;
            PnlEditGp.Visible = false;
            PnlUpGp.Visible = false;
            hInvDel.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }

    public void lstDepartName()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
            ObjInv.getOrgDepartName(OrgID, out ObjInvDep);
            ddlDept.DataSource = ObjInvDep;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();
            ddlDept.Items.Insert(0, "---Select---");
            ddlDept.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }

    public void lstHeaderName()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
            ObjInv.getOrgHeaderName(out objHeader);
            ddlHeader.DataSource = objHeader;
            ddlHeader.DataTextField = "HeaderName";
            ddlHeader.DataValueField = "HeaderID";
            ddlHeader.DataBind();
            ddlHeader.Items.Insert(0, "---Select---");
            ddlHeader.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if(e.Row.RowType==DataControlRowType.DataRow)
            {
            e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (grdResult.PageIndex * grdResult.PageCount));
            
            HiddenField hdn = (HiddenField)e.Row.FindControl("lblInvestigationId");
                DropDownList ddldept=(DropDownList)e.Row.FindControl("ddlDept");
                DropDownList ddlhead=(DropDownList)e.Row.FindControl("ddlHeader");
                HdnDeptvalid.Value += ddldept.ClientID + "~" + ddlhead.ClientID + "~" + hdn.ClientID + "^";

                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnfind_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
                strTxtInvName = txtInvname.Text;
                Returncode = ObjInv.SearchInvForMDMAddInvAndGrp(strTxtInvName, OrgID, "INVMAP",GroupCode, out objInvMas);
                if (objInvMas.Count > 0)
                {
                    chklstInvmap.DataSource = objInvMas;
                    chklstInvmap.DataTextField = "InvestigationName";
                    chklstInvmap.DataValueField = "InvestigationID";
                    chklstInvmap.DataBind();
                    divInv.Visible = true;
                    divInvGp.Visible = false;
                    pnlSave.Visible = true;
                    pnlINV.Visible = true;
                }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void grdResult_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            grdResult.EditIndex = e.NewEditIndex;
            fill();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void grdResult_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            grdResult.EditIndex = -1;
            fill();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        try
        {
            


        }
        catch (Exception ex)
        {
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdResult.PageIndex = e.NewPageIndex;
            fill();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btninves_Click(object sender, EventArgs e)
    {
        try
        {
            mapSearch();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }

    public void mapSearch()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> objInvMas = new List<InvestigationOrgMapping>();
           long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
            if (ddlInves.SelectedIndex == 3)
            {
                if (txtinvestigation.Text.Trim() != String.Empty)
                {
                    strTxtInvName = txtinvestigation.Text;
                    Returncode = ObjInv.SearchInvForMDMAddInvMapping(strTxtInvName, OrgID, "MAP",GroupCode, out objInvMas);
                    if (objInvMas.Count > 0)
                    {
                        grdResult.DataSource = objInvMas;
                        grdResult.DataBind();
                    }
                }
            }
        }
        catch(Exception ex)
            {
                CLogger.LogError("Error while Save Group", ex);
            }
    }
    protected void btnInvGrpadd_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnGrpAdd_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvGroupMaster> objInvMap = new List<InvGroupMaster>();
            List<InvGroupMaster> objInv = new List<InvGroupMaster>();
            string HdnGrp = String.Empty;

            foreach (ListItem item in chkGrpMap.Items)
            {
                InvGroupMaster obj = new InvGroupMaster();
                obj.GroupID = int.Parse(item.Value);
                obj.GroupName = item.Text;
                objInvMap.Add(obj);
            }
            foreach (ListItem item in chklstGrp.Items)
            {
                if (item.Selected)
                {
                    if (chkGrpMap.Items.Contains(new ListItem(item.Text, item.Value)))
                    {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Item already exist');", true);
                        return;
                    }
                    else
                    {
                        InvGroupMaster obj = new InvGroupMaster();
                        obj.GroupID = int.Parse(item.Value);
                        item.Text += "<input onclick='show(name);' name='" + item.Value + "'value = 'Show' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        obj.GroupName = item.Text;
                        objInvMap.Add(obj);
                        HdnGrp += obj.GroupID + "~" + obj.GroupName + "^";
                    }
                }
                else
                {
                    InvGroupMaster obj = new InvGroupMaster();
                    obj.GroupID = int.Parse(item.Value);
                    obj.GroupName = item.Text;
                    objInv.Add(obj);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.GroupName
                           select s;

                chkGrpMap.DataSource = temp;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "GroupID";
                chkGrpMap.DataBind();
            }
            if (objInv.Count > 0)
            {
                chklstGrp.DataSource = objInv;
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataBind();
            }
            else
            {
                chklstGrp.DataSource = objInv;
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataBind();
            }
            HdnNewGrp.Value += HdnGrp;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnAdd_Click1(object sender, EventArgs e)
    {
        
        try
        {
            
            string id = string.Empty;
            string Hdninv=string.Empty;            
            List<InvestigationMaster> objInvMap = new List<InvestigationMaster>();
            List<InvestigationMaster> objInv = new List<InvestigationMaster>();
           
            foreach (ListItem item in chklstInvmap.Items)
            {
                InvestigationMaster obj = new InvestigationMaster();
                obj.InvestigationID = Int64.Parse(item.Value);
                obj.InvestigationName = item.Text;
                objInvMap.Add(obj);
            }
            foreach (ListItem item in Chklst.Items)
            {
                
                if (item.Selected)
                {
                    //foreach (var O in hdnInv.Value.Split('^'))
                    //{
                    //    string x = O.Split('~')[0];

                    
                    
                    //chklstInvmap.Items.FindByValue(x).Text != string.Empty
                            //if (item.Value != x)
                            //{
                    if (chklstInvmap.Items.Contains(new ListItem(item.Text, item.Value)))
                            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Item already exist');", true);
                                return;
                            }
                            else
                            {                           
                                InvestigationMaster obj = new InvestigationMaster();
                                id = item.Value;
                                obj.InvestigationID = Int64.Parse(item.Value);
                                obj.InvestigationName = item.Text;
                                objInvMap.Add(obj);
                                if (hdnInv.Value.Contains(obj.InvestigationName))
                                {
                                }
                                else
                                {
                                    hdnInv.Value += obj.InvestigationID + "~" + obj.InvestigationName + "^";
                                                                    }
                            }                     
                                                            
                                          
                                                            }

                else
                {
                    InvestigationMaster obj = new InvestigationMaster();
                    obj.InvestigationID = Int64.Parse(item.Value);
                    obj.InvestigationName = item.Text;
                    objInv.Add(obj);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.InvestigationName
                           select s;
                chklstInvmap.DataSource = temp;
                chklstInvmap.DataTextField = "InvestigationName";
                chklstInvmap.DataValueField = "InvestigationID";
                chklstInvmap.DataBind();
                //if (chklstInvmap.Items.FindByValue(id).Text != "")
                //{
                //    chklstInvmap.Items.FindByValue(id).Attributes.Add("style", "Color:blue");
                //}
            }
            if (objInv.Count > 0)
            {
                Chklst.DataSource = objInv;
                Chklst.DataTextField = "InvestigationName";
                Chklst.DataValueField = "InvestigationID";
                Chklst.DataBind();
            }
            else
            {
                Chklst.DataSource = objInv;
                Chklst.DataTextField = "InvestigationName";
                Chklst.DataValueField = "InvestigationID";
                Chklst.DataBind();
            }
           // Hdninv += Hdn;
           // foreach (string str in hdnInv.Value.Split('^'))
           //{
           //    foreach (string hdn in Hdn.Split('^'))
           //    {
           //        string[] lst = str.Split('~');
           //        string[] lstchk=hdn.Split('~');                   
                   
           //            if (lstchk[0] != String.Empty)
           //            {
           //                if (lst[0] == lstchk[0])
           //                {

           //                }
           //                else
           //                {
           //                    Hdninv += lstchk[0] + "~" + lstchk[1] + "^";
           //                }
           //            }
                   
           //    }                
           //}
           // hdnInv.Value += Hdn;
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnRemove_Click1(object sender, EventArgs e)
    {
        try
        {
            List<InvestigationMaster> objInvMap = new List<InvestigationMaster>();
            List<InvestigationMaster> objInv = new List<InvestigationMaster>();
            foreach (ListItem item in Chklst.Items)
            {
                InvestigationMaster obj = new InvestigationMaster();
                obj.InvestigationID = Int64.Parse(item.Value);
                obj.InvestigationName = item.Text;
                objInv.Add(obj);
            }
            foreach (ListItem item in chklstInvmap.Items)
            {
                InvestigationMaster obj = new InvestigationMaster();
                obj.InvestigationID = Int64.Parse(item.Value);
                obj.InvestigationName = item.Text;
                if (item.Selected)
                {                    
                    objInv.Add(obj);
                }
                else
                {
                    objInvMap.Add(obj);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.InvestigationName
                           select s;
                chklstInvmap.DataSource = temp;
                chklstInvmap.DataTextField = "InvestigationName";
                chklstInvmap.DataValueField = "InvestigationID";
                chklstInvmap.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('The list cannot be empty');", true);
                objInv.Clear();
            }
            if (objInv.Count > 0)
            {
                var temp = from s in objInv
                           orderby s.InvestigationName
                           select s;
                Chklst.DataSource = temp;
                Chklst.DataTextField = "InvestigationName";
                Chklst.DataValueField = "InvestigationID";
                Chklst.DataBind();
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
            string[] lst;
            List<InvGroupMaster> objInvMap = new List<InvGroupMaster>();
             List<InvGroupMaster> objInv = new List<InvGroupMaster>();
            foreach (ListItem item in chklstGrp.Items)
            {
                InvGroupMaster obj = new InvGroupMaster();
                obj.GroupID = int.Parse(item.Value);
                obj.GroupName = item.Text;
                objInv.Add(obj);
            }
            foreach (ListItem item in chkGrpMap.Items)
            {
                InvGroupMaster objGrp = new InvGroupMaster();
                objGrp.GroupID = int.Parse(item.Value);
                objGrp.GroupName = item.Text;
                if (item.Selected)
                {
                    lst = item.Text.Split('<');
                    objGrp.GroupName = lst[0];
                    objInv.Add(objGrp);
                    
                    HdnRemoveGrp.Value += objGrp.GroupID + "~" + objGrp.GroupName + "^";
                    
                }
                else
                {
                    objInvMap.Add(objGrp);
                }
            }
            if (objInvMap.Count > 0)
            {
                var temp = from s in objInvMap
                           orderby s.GroupName
                           select s;
                chkGrpMap.DataSource = temp;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "GroupID";
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
                           orderby s.GroupName
                           select s;
                chklstGrp.DataSource = temp;
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataBind();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btngrp_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
            strTxtInvName = txtgrp.Text;
            Returncode = ObjInv.SearchInvForMDMAddGrp(strTxtInvName, OrgID, "GRP",GroupCode, out objGpMas);
            if (objGpMas.Count > 0)
            {
                chklstGrp.DataSource = objGpMas;
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataBind();                
            }
            else
            {                
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btngrpmap_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            List<InvGroupMaster> objGpMap = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
            strTxtInvName = txtgrpmap.Text;
            Returncode = ObjInv.SearchInvForMDMAddGrp(strTxtInvName, OrgID, "REF",GroupCode, out objGpMas);
            if (objGpMas.Count > 0)
            {
                chkGrpMap.DataSource = objGpMas;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "GroupID";
                chkGrpMap.DataBind();
                foreach (ListItem item in chkGrpMap.Items)
                {                    
                        InvGroupMaster obj = new InvGroupMaster();
                        obj.GroupID = int.Parse(item.Value);
                        item.Text += "<input onclick='show(name);' name='" + item.Value + "'value = 'Show' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        obj.GroupName = item.Text;
                        objGpMap.Add(obj);
                        Hdngrp += obj.GroupID + "~" + obj.GroupName + "^";
                    
                        //hdnInv.Value += obj.GroupID + "~" + obj.GroupName + "^";    
                    
                }
                chkGrpMap.DataSource = objGpMap;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "GroupID";
                chkGrpMap.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    //code by venkat
    //void SetEnableFalse()
    //{
    //    foreach (string O in hdnInv.Value.Split('^'))
    //    {
    //        string x = string.Empty;
    //        string Name = string.Empty;
    //        x = O.Split('~')[0];
    //        Name = O.Split('~')[1];
    //        if (x != string.Empty)
    //        {
    //            if (chklstInvmap.Items.FindByValue(x).Text != string.Empty)
    //            {
    //                //chklstInvmap.Items.FindByValue(x).Enabled = false;
    //                chklstInvmap.Items.FindByValue(x).Attributes.Add("style", "Color:blue");

    //            }
    //            if (Chklst.Items.Contains(new ListItem(Name,x)))
    //            {
    //                Chklst.Items.FindByValue(x).Enabled = false;
    //                Chklst.Items.FindByValue(x).Attributes.Add("style", "Color:blue");

    //            }
    //        }
    //    }
    ////}
    protected void btnGrpSave_Click(object sender, EventArgs e)
    {
        try
        {
            string groupName = string.Empty;
            string BillingName = string.Empty;
            string type = string.Empty; 
            string text = string.Empty;
            string GroupCode = string.Empty;
            string remarks = string.Empty;
            string status = string.Empty;
            string pkgcode = string.Empty;
            long returnCode;
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            groupName =  txtGrpName.Text;
            BillingName = txtGrpName.Text;
            lblstatus.Text = String.Empty;
            gvGrp.DataSource = null;
            gvGrp.DataBind();
            type = "GRP";
            int ddlCase = 2;
            int iDptId = 0;
            long lHeader = 0;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
            List<InvGroupMaster> objGpMap = new List<InvGroupMaster>();
            List<OrderedInvestigations> valiID = new List<OrderedInvestigations>();
            long iInv = 0;
            returnCode = ObjInv.SearchInvForMDMAddGrp(groupName, OrgID, "CHKGRP",GroupCode, out objGpMap);
            if (objGpMap.Count > 0)
            {
                lblstatus.Text = "Already Exists";
                MPE.Show();
            }
            else
            {
                objGpMas.InvestigationID = iInv;
                objGpMas.OrgID = OrgID;
                objGpMas.DeptID = 0;
                objGpMas.HeaderID = 0;
                objMap.Add(objGpMas);
                returnCode = ObjInv.SaveInvestigationGrpName(objMap, groupName, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                ClientScript.RegisterStartupScript(this.GetType(), "key", "alert('Changes saved successfully.');");
                txtGrpName.Text = String.Empty;
                returnCode = ObjInv.GetInvForMDMAddGrp(OrgID, "GRPMAP", out objGpMap,out valiID );
                foreach (InvGroupMaster item in objGpMap)
                {
                    item.GroupName += "<input onclick='show(name);' name='" + item.GroupID + "'  value = 'Show' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                }
                if (objGpMap.Count > 0)
                {
                    chkGrpMap.DataSource = objGpMap;
                    chkGrpMap.DataTextField = "GroupName";
                    chkGrpMap.DataValueField = "GroupID";
                    chkGrpMap.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Insert Group", ex);
        }
    }
    protected void gvGrp_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (gvGrp.PageIndex * gvGrp.PageSize));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }
    }
    protected void gvGrp_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvGrp.EditIndex = e.NewEditIndex;
            fillgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }
    }
    protected void gvGrp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvGrp.PageIndex = e.NewPageIndex;
            fillgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }

            }
    public void fillgrid()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> objLoadInvMap = new List<InvGroupMaster>();
            List<OrderedInvestigations> validId = new List<OrderedInvestigations>();
            long Returncode = -1;
            Returncode = ObjInv.GetInvForMDMAddGrp(OrgID, "GRPMAP", out objLoadInvMap,out validId );
            gvGrp.DataSource = objLoadInvMap;
            gvGrp.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }
    }
    protected void gvGrp_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvGrp.EditIndex = -1;
            fillgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group Addition", ex);
        }
    }
    protected void lnk_Click(object sender, EventArgs e)
    {
        try
        {
            MPE.Show();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }

    }
    protected void btnGrpCheck_Click(object sender, EventArgs e)
    {
        try
        {
            MPE.Show();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationMaster> objInvMas = new List<InvestigationMaster>();
            List<InvGroupMaster> objGpMas = new List<InvGroupMaster>();
            List<InvGroupMaster> objGpMap = new List<InvGroupMaster>();
            long Returncode = -1;
            string strTxtInvName = string.Empty;
            string GroupCode = string.Empty;
            checkgrp();
            Returncode = ObjInv.SearchInvForMDMAddGrp(strTxtInvName, OrgID, "NEWGRP",GroupCode, out objGpMas);
            if (objGpMas.Count > 0)
            {
                gvGrp.DataSource = objGpMas;
                gvGrp.DataBind();
            }
            else
            {
                lblstatus.Text = "No Records Found";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btnGrpCancel_Click(object sender, EventArgs e)
    {
        try
        {
            checkgrp();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    public void checkgrp()
    {
        try
        {
            txtGrpName.Text = String.Empty;
            lblstatus.Text = String.Empty;
            gvGrp.DataSource = null;
            gvGrp.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
}
