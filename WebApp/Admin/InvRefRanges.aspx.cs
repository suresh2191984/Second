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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Linq;
using System.IO;
using Attune.Podium.ExcelExportManager;
using OfficeOpenXml;
using Excel;

public partial class Admin_InvRefRanges : BasePage, System.Web.UI.ICallbackEventHandler
{

    public Admin_InvRefRanges()
        : base("Admin_InvRefRanges_aspx")
    {
    }
    long returnCode = -1;
    long StartIndex = -1;
    long EndIndex = -1;
    long TotalCount = -1;
    long TotalSerachCount = -1;
    int PageSize = 20;

    long GrpStartIndex = -1;
    long GrpEndIndex = -1;
    long GrpTotalCount = -1;
    long GrpTotalSerachCount = -1;
    //code added for reference range
    string xmlContent;
    string rawData;

    Patient_BL patientBL ;
    Investigation_BL investigationBL ;
    List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
    List<InvGroupMaster> grpIOM = new List<InvGroupMaster>();
    List<InvestigationMethod> lstInvMethod = new List<InvestigationMethod>();
    List<InvPrincipleMaster> lstInvPrinciple = new List<InvPrincipleMaster>();
    List<InvKitMaster> lstInvKit = new List<InvKitMaster>();
    List<InvInstrumentMaster> lstInvInstrument = new List<InvInstrumentMaster>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    List<OrganizationAddress> lstProcessingCentres = new List<OrganizationAddress>();
    List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
    List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
    List<InvestigationLocationMapping> lstInvMappedLocations = new List<InvestigationLocationMapping>();

    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        investigationBL = new Investigation_BL(base.ContextInfo);
        //code added for reference range - begin
        ClientScriptManager cs = Page.ClientScript;
        String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "ReceiveXmlData", "", "ProcessCallBackError", false);
        String callBackScript = "function ConvertToXml(arg) {" + callBackReference + "; }";
        cs.RegisterClientScriptBlock(this.GetType(), "CallXmlConversion", callBackScript, true);
        //code added for reference range - ends
       
        if (!IsPostBack)
        {
            //code added for reference range - begins
            ddlCategory.Attributes.Add("onchange", "CategoryChange('" + ddlCategory.ClientID + "')");
            ddlSubCategory.Attributes.Add("onchange", "SubCategoryChange('" + ddlSubCategory.ClientID + "')");
            ddlOperatorRange1.Attributes.Add("onchange", "ShowAgeBetween('" + ddlOperatorRange1.ClientID + "')");
            ddlOperatorRange2.Attributes.Add("onchange", "ShowValueBetween('" + ddlOperatorRange2.ClientID + "')");
            ddlGenderValueOpt.Attributes.Add("onchange", "ShowGenderValueBetween('" + ddlGenderValueOpt.ClientID + "')");
            ddlOtherRangeOpt.Attributes.Add("onchange", "ShowOtherValueBetween('" + ddlOtherRangeOpt.ClientID + "')");
            hlnkAddAge.Attributes.Add("onClick", "AddAgeReferenceRange('" + ddlCategory.ClientID + "','" + ddlOperatorRange1.ClientID + "','" + txtAgeRange1.ClientID + "','" + txtAgeRange2.ClientID + "','" + ddlOperatorRange2.ClientID + "','" + txtValueRange1.ClientID + "','" + txtValueRange2.ClientID + "','" + ddlAgeType.ClientID + "')");
            hlnkAddAge.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            hlnkGenderValueAdd.Attributes.Add("onClick", "AddGenderReferenceRange('" + ddlCategory.ClientID + "','" + ddlGenderValueOpt.ClientID + "','" + txtGenderValueStart.ClientID + "','" + txtGenderValueEnd.ClientID + "','" + ddlSubCategory.ClientID + "')");

            hlnkGenderValueAdd.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            hlnkGenderGeneralOther.Attributes.Add("onClick", "AddOtherReferenceRange('" + ddlCategory.ClientID + "','" + txtGenderOther.ClientID + "','" + ddlOtherRangeOpt.ClientID + "','" + txtOtherRange1.ClientID + "','" + txtOtherRange2.ClientID + "')");
            hlnkGenderGeneralOther.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            hlnksaveClose.Attributes.Add("onClick", "javascript:SaveCloseRRPopUp();");
            hlnksaveClose.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            //code added for reference range - ends
            //code added for Auto Authorize - begins

            LoadAutoAutorize();
            LoadMeatData();
            hlnksaveCloseAA.Attributes.Add("onClick", "javascript:SaveCloseAAPopUp();");
            hlnksaveCloseAA.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            //code added for Auto Authorize - ends

            //hlnkGenderValueAdd.Attributes.Add("onMouseOver", "this.style.cursor='hand'");

            chkAllInvProcLocMapping.Attributes.Add("onClick", "javascript:ShowPCPopUp('','" + "All Investigations" + "','Add','" + "-1" + "');");

            try
            {


                lblMessage.Text = "";
                hdnSL.Value = "";
                hdnSC.Value = "";
                hdnTest.Value = "";
                hdnUpdatedTest.Value = "";
                hdnUpdatedList.Value = "";
                hdnGrpUpdatedList.Value = "";
                hdnGrpUpdatedTest.Value = "";
                hdnPR.Value = "";
                hdnMT.Value = "";
                hdnKT.Value = "";
                hdnIT.Value = "";
                hdnPC.Value = "";
                hdnStartIndex.Value = "";
                hdnEndIndex.Value = "";
                hdnGrpStartIndex.Value = "";
                hdnGrpEndIndex.Value = "";
                btnPrevious.Visible = false;
                btnNext.Visible = false;
                btnPreviousTop.Visible = false;
                btnNextTop.Visible = false;
                Inves.Attributes.Add("Style", "Display:Block");
                Inv.Attributes.Add("Style", "Display:table-row");
                pnlSerch.Attributes.Add("Style", "Display:Block");
                Grp.Attributes.Add("Style", "Display:None");
                pnlGrpSearch.Attributes.Add("Style", "Display:None");
                InvLoad();
                rdbInvestigaion.Checked = true;

            }
            catch (Exception ex)
            {
              //  ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                CLogger.LogError("Error While Loading Reference Range and related Details.", ex);
            }
        }
    }

    public void LoadAutoAutorize()
    {
        List<LoginRole> objLoginRole = new List<LoginRole>();
        returnCode = investigationBL.GetRoleUserLogin(OrgID, out  objLoginRole);

        if (objLoginRole.Count > 0)
        {
            Hashtable htRole = new Hashtable();
            SortedDictionary<string, string> sdList =
            new SortedDictionary<string, string>();
            sdList.Add("0", "Select");

            foreach (LoginRole item in objLoginRole)
            {
                if (!htRole.Contains(item.RoleID))
                {
                    htRole.Add(item.RoleID, item.RoleName);
                }

                if (!sdList.ContainsKey(item.RoleID.ToString()))
                {
                    sdList.Add(item.RoleID.ToString(), item.RoleName.ToString());
                }

                hdnRoleUser.Value += item.Status.ToString() + "~" + item.OrganisationName.ToString() + "^";
            }

            ddlRole.DataTextField = "Value";
            ddlRole.DataValueField = "Key";
            ddlRole.DataSource = sdList;
            ddlRole.DataBind();
            ddlRole.Attributes.Add("onchange", "ShowUserForRole()");
            ddlUsers.Attributes.Add("onchange", "ChangeUserLogin()");
        }

    }

    public void InvLoad()
    {
        try
        {
            StartIndex = 1;
            EndIndex = PageSize;
            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
            if (returnCode == 0)
            {
                hdnTotalCount.Value = TotalCount.ToString();
                if (TotalCount > EndIndex)
                {
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                }
                else
                {
                    btnNext.Visible = false;
                    btnNextTop.Visible = false;
                    btnPrevious.Visible = false;
                    btnPreviousTop.Visible = false;
                }
                LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);

            }
        }
        catch (Exception ex)
        {

        }
    }

    public void GrpLoad()
    {
        try
        {
            GrpStartIndex = 1;
            GrpEndIndex = PageSize;
            hdnGrpStartIndex.Value = GrpStartIndex.ToString();
            hdnGrpEndIndex.Value = GrpEndIndex.ToString();
            returnCode = investigationBL.GetGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, out grpIOM, out TotalCount);
            if (returnCode == 0)
            {
                hdnGrpTotalCount.Value = TotalCount.ToString();
                GrpLoadTable(grpIOM);
                if (TotalCount > GrpEndIndex)
                {
                    btnGrpNext.Visible = true;
                    // btnNextTop.Visible = true;
                }
                else
                {
                    btnGrpNext.Visible = false;
                    //btnNextTop.Visible = false;
                    btnGrpPrevious.Visible = false;
                    //btnPreviousTop.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void GrpLoadTable(List<InvGroupMaster> lstGrpMapp)
    {
        string strGroup = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_06 == null ? "Group" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_06;
        string strDisplay = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_07 == null ? "Display Text" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_07;
        string strType = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_08 == null ? "Type" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_08;
        string strDisplaytext = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_09 == null ? "Enter Display Text" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_09;
        string strPackage = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_10 == null ? "Package" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_10;

        try
        {
            foreach (InvGroupMaster objMap in lstGrpMapp)
            {
                hdnGrpTest.Value += objMap.GroupID + "^";
            }
            TableRow grow1 = new TableRow();
            TableCell gcell1 = new TableCell();
            TableCell gcell2 = new TableCell();
            TableCell gcell3 = new TableCell();
            gcell1.Attributes.Add("align", "left");
            gcell1.Text = strGroup;
            gcell1.BorderWidth = 1;
            gcell2.Attributes.Add("align", "left");
            gcell2.Text = strDisplay;
            gcell2.BorderWidth = 1;
            gcell3.Attributes.Add("align", "left");
            gcell3.Text = strType;
            gcell3.BorderWidth = 1;
            grow1.Cells.Add(gcell1);
            grow1.Cells.Add(gcell2);
            grow1.Cells.Add(gcell3);
            grow1.Font.Bold = true;
            grow1.Font.Size = 8;
            grow1.CssClass = "Duecolor gridHeader";
            //grow1.Style.Add("background-color", "#");
            //grow1.Style.Add("color", "#ffffff");
            grow1.BorderWidth = 1;
            masterGrpTab.Rows.Add(grow1);
            foreach (InvGroupMaster objMap in lstGrpMapp)
            {
                TableRow grow11 = new TableRow();
                grow11.ID = "row" + objMap.GroupID.ToString();
                TableCell gcell11 = new TableCell();
                gcell11.Attributes.Add("align", "left");
                gcell11.Text = objMap.GroupName;
                TextBox gtxtBoxDT = new TextBox();
                TableCell gcell22 = new TableCell();
                gcell22.Attributes.Add("align", "left");
                gtxtBoxDT.ID = "txtDT" + objMap.GroupID.ToString();
                gtxtBoxDT.TextMode = TextBoxMode.MultiLine;
                gtxtBoxDT.Rows = 1;
                gtxtBoxDT.Columns = 7;
                gcell22.Controls.Add(gtxtBoxDT);
                gtxtBoxDT.Attributes.Add("onfocus", "javascript:expandGrpBox(this.id);");
                gtxtBoxDT.Attributes.Add("onblur", "javascript:collapseGrpBox(this.id);");
                gtxtBoxDT.Attributes.Add("onkeypress", "javascript:ValidateOnlyNumeric(this);");
                gtxtBoxDT.TextMode = TextBoxMode.SingleLine;
                gtxtBoxDT.MaxLength = 100;
                gtxtBoxDT.Width = 300;

                gtxtBoxDT.Text = objMap.DisplayText;
                gtxtBoxDT.ToolTip = strDisplaytext;
                gcell22.BorderWidth = 1;
                TableCell gcell12 = new TableCell();
                gcell12.Attributes.Add("align", "left");

                if (objMap.Type == "GRP")
                {
                    gcell12.Text = strGroup;
                }
                else if (objMap.Type == "PKG")
                {
                    gcell12.Text = strPackage;
                }
                //row11.Cells.Add(cell11aa);
                grow11.Cells.Add(gcell11);
                grow11.Cells.Add(gcell22);
                grow11.Cells.Add(gcell12);
                grow11.Font.Bold = false;
                grow11.Font.Size = 8;
                grow11.Style.Add("color", "#000000");
                grow11.BorderWidth = 1;
                masterGrpTab.Rows.Add(grow11);
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadTable(List<InvestigationOrgMapping> lstInOrgMapp, List<InvSampleMaster> lstInvSM, List<InvestigationMethod> lstInvMtd, List<InvPrincipleMaster> lstInvPR, List<InvKitMaster> lstInvKT, List<InvInstrumentMaster> lstInvIM, List<InvestigationSampleContainer> lstInvSC, List<OrganizationAddress> lstOrganizationAddress, List<OrganizationAddress> lstProcCentres)
    {
        string strDisplay = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_07 == null ? "Display Text" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_07;
        string strInv = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_11 == null ? "Investigation" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_11;
        string strUnits = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_12 == null ? "Units" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_12;
        string strRef = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_13 == null ? "Reference Range" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_13;
        string strSample = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_14 == null ? "Sample" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_14;
        string strAdd = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_15 == null ? "Additive" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_15;
        string strMethod = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_16 == null ? "Method" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_16;
        string strPrinci = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_17 == null ? "Principle" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_17;
        string strKit = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_18 == null ? "Kit" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_18;
        string strInst = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_19 == null ? "Instrument" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_19;
        string strQc = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_20 == null ? "QC Data" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_20;
        string strInterPre = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_21 == null ? "Interpretation / Notes" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_21;
        string strAuto = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_22 == null ? "Auto-Authorize" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_22;
        string strDefault = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_23 == null ? "Default Processing Center" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_23;
        string strPanic = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_24 == null ? "Panic Range" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_24;
        string strAutoID = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_25 == null ? "AutoAuthorizeID" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_25;
        string strClickHere = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_26 == null ? "Click here to Change Unit Of Measurment" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_26;
        string strDisplaytext = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_09 == null ? "Enter Display Text" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_09;
        string strAddRef = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_27 == null ? "Add" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_27;
        string strInv15 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_42 == null ? "Add/Update a new reference range" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_42;
        string strInv01 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_28 == null ? "Enter ReferenceRange" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_28;
        string strInv02 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_29 == null ? "Add/Update a new panic range" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_29;
        string strInv03 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_30 == null ? "(Formed As XML)" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_30;
        string strInv04 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_31 == null ? "Enter PanicRange" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_31;
        string strInv05 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_32 == null ? "Select Test Sample" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_32;
        string strInv06 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_33 == null ? "Select Test Sample Additive" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_33;
        string strInv07 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_34 == null ? "Select Test Method" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_34;
        string strInv08 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_35 == null ? "Select Test Kit" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_35;
        string strInv09 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_36 == null ? "Select Test Instrument" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_36;
        string strInv10 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_37 == null ? "Check for Quality Control Data" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_37;
        string strInv11 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_38 == null ? "Enter AutoAuthorize LoginID" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_38;
        string strInv12 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_39 == null ? "AutoAuthorize Name" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_39;
        string strInv13 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_40 == null ? "Check for Authorize" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_40;
        string strInv14 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_41 == null ? "Add/Update a new Processing Centre" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_41;

        List<TrustedOrgDetails> lstTrustedOrgDetails = new List<TrustedOrgDetails>();
        new GateWay(base.ContextInfo).GetOrgDetails(OrgID, out lstTrustedOrgDetails);
        if (lstTrustedOrgDetails.Count > 0)
        {
            //foreach (TrustedOrgDetails objDPC in lstTrustedOrgDetails)
            //{
            //    hdnDPC.Value += objDPC.OrgName + "|" + objDPC.OrgID + "^";
            //}
        }
        if (lstIOM.Count > 0)
        {
            foreach (InvestigationOrgMapping objMap in lstInOrgMapp)
            {
                hdnTest.Value += objMap.InvestigationID + "~" + objMap.SampleCode + "~" + objMap.SampleContainerID + "~" + objMap.MethodID + "~" + objMap.PrincipleID + "~" + objMap.KitID + "~" + objMap.InstrumentID + "~" + objMap.ProcessingAddressID + "^";
            }
            if (lstOrganizationAddress.Count > 0)
            {
                hdnPC.Value = "";
                hdnPC.Value += "0~--Select--^";
                foreach (OrganizationAddress OA in lstOrganizationAddress)
                {
                    hdnPC.Value += OA.AddressID + "~" + OA.Location + "^";
                }
            }

            if (lstProcCentres.Count > 0)
            {
                hdnPCActual.Value = "";
                hdnPCActual.Value += "0~--Select--^";
                foreach (OrganizationAddress OA in lstProcCentres)
                {
                    hdnPCActual.Value += OA.AddressID + "~" + OA.Location + "^";
                }
            }

            if (lstInvSM.Count > 0)
            {
                hdnSL.Value = "";
                hdnSL.Value += "0~--Select--^";
                foreach (InvSampleMaster objSL in lstInvSM)
                {
                    hdnSL.Value += objSL.SampleCode + "~" + objSL.SampleDesc + "^";
                }
            }
            if (lstInvSC.Count > 0)
            {
                hdnSC.Value = "";
                hdnSC.Value += "0~--Select--^";
                foreach (InvestigationSampleContainer objSC in lstInvSC)
                {
                    hdnSC.Value += objSC.SampleContainerID + "~" + objSC.ContainerName + "^";
                }
            }
            if (lstInvMtd.Count > 0)
            {
                hdnMT.Value = "";
                hdnMT.Value += "0~--Select--^";
                foreach (InvestigationMethod objMT in lstInvMtd)
                {
                    hdnMT.Value += objMT.MethodID + "~" + objMT.MethodName + "^";
                }
            }
            if (lstInvPR.Count > 0)
            {
                hdnPR.Value = "";
                hdnPR.Value += "0~--Select--^";
                foreach (InvPrincipleMaster objPR in lstInvPR)
                {
                    hdnPR.Value += objPR.PrincipleID + "~" + objPR.PrincipleName + "^";
                }
            }
            if (lstInvKT.Count > 0)
            {
                hdnKT.Value = "";
                hdnKT.Value += "0~--Select--^";
                foreach (InvKitMaster objKT in lstInvKT)
                {
                    hdnKT.Value += objKT.KitID + "~" + objKT.KitName + "^";
                }
            }
            if (lstInvIM.Count > 0)
            {
                hdnIT.Value = "";
                hdnIT.Value += "0~--Select--^";
                foreach (InvInstrumentMaster objIT in lstInvIM)
                {
                    hdnIT.Value += objIT.InstrumentID + "~" + objIT.InstrumentName + "^";
                }
            }
            lblStatus.Visible = false;
            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            cell1.Attributes.Add("align", "left");
            cell1.Text = strInv;
            TableCell cell1a = new TableCell();
            cell1a.Attributes.Add("align", "left");
            cell1a.Text = strUnits;
            TableCell cell2 = new TableCell();
            cell2.Attributes.Add("align", "left");
            cell2.Text = strDisplay;
            TableCell cell3 = new TableCell();
            cell3.Attributes.Add("align", "left");
            cell3.Text = strRef;
            TableCell cell4 = new TableCell();
            cell4.Attributes.Add("align", "left");
            cell4.Text = strSample;
            TableCell cell11a = new TableCell();
            cell11a.Attributes.Add("align", "left");
            cell11a.Text = strAdd;
            TableCell cell5 = new TableCell();
            cell5.Attributes.Add("align", "left");
            cell5.Text = strMethod;
            TableCell cell6 = new TableCell();
            cell6.Attributes.Add("align", "left");
            cell6.Text = strPrinci;
            TableCell cell7 = new TableCell();
            cell7.Attributes.Add("align", "left");
            cell7.Text = strKit;
            TableCell cell8 = new TableCell();
            cell8.Attributes.Add("align", "left");
            cell8.Text = strInst;
            TableCell cell9 = new TableCell();
            cell9.Attributes.Add("align", "left");
            cell9.Text = strQc;
            TableCell cell10 = new TableCell();
            cell10.Attributes.Add("align", "left");
            //cell10.Text = "Interpretation / Notes";
            cell10.Text = strInterPre;
            cell10.Width = 36;
            TableCell cell12 = new TableCell();
            cell12.Attributes.Add("align", "left");
            cell12.Text = strAuto;
            TableCell cell13 = new TableCell();
            cell13.Attributes.Add("align", "left");
            //cell13.Text = "Default Processing Center";
            cell13.Text = strDefault;
            cell13.Width = 50;
            TableCell cell14 = new TableCell(); //panic
            cell14.Attributes.Add("align", "left");
            cell14.Text = strPanic;
            cell14.Width = 10;
            TableCell cell15 = new TableCell();
            cell15.Attributes.Add("align", "left");
           // cell15.Text = "AutoAuthorizeID";
            cell15.Text = strAutoID;
            cell15.Width = 50;
            cell15.Attributes.Add("style", "display:none");

            cell1.BorderWidth = 1;
            cell1a.BorderWidth = 1;
            cell2.BorderWidth = 1;
            cell3.BorderWidth = 1;
            cell4.BorderWidth = 1;
            cell5.BorderWidth = 1;
            cell6.BorderWidth = 1;
            cell7.BorderWidth = 1;
            cell8.BorderWidth = 1;
            cell9.BorderWidth = 1;
            cell10.BorderWidth = 1;
            cell11a.BorderWidth = 1;
            cell12.BorderWidth = 1;
            cell13.BorderWidth = 1;
            cell14.BorderWidth = 1;
            cell15.BorderWidth = 1;

            row1.Cells.Add(cell1);
            row1.Cells.Add(cell1a);
            row1.Cells.Add(cell2);
            row1.Cells.Add(cell3);
            row1.Cells.Add(cell4);
            row1.Cells.Add(cell11a);
            row1.Cells.Add(cell5);
            row1.Cells.Add(cell6);
            row1.Cells.Add(cell7);
            row1.Cells.Add(cell8);
            row1.Cells.Add(cell9);
            row1.Cells.Add(cell10);
            row1.Cells.Add(cell12);
            row1.Cells.Add(cell13);
            row1.Cells.Add(cell14);
            row1.Cells.Add(cell15);

            row1.Font.Bold = true;
            row1.Font.Size = 8;
            row1.CssClass = "Duecolor gridHeader";
            //row1.Style.Add("background-color", "#");
            //row1.Style.Add("color", "#ffffff");
            row1.BorderWidth = 1;
            masterTab.Rows.Add(row1);
            foreach (InvestigationOrgMapping objIOM in lstInOrgMapp)
            {
                TableRow row11 = new TableRow();
                row11.ID = "row" + objIOM.InvestigationID.ToString();
                TextBox txtBoxDT = new TextBox();
                TextBox txtBoxRR = new TextBox();
                TextBox txtBoxPR = new TextBox();
                //code added for reference range
                HyperLink hlnkRR = new HyperLink();
                HyperLink hlnkPC = new HyperLink();
                HyperLink hlnkPR = new HyperLink();
                DropDownList ddlSL = new DropDownList();
                DropDownList ddlSC = new DropDownList();
                DropDownList ddlMT = new DropDownList();
                DropDownList ddlPR = new DropDownList();
                DropDownList ddlKT = new DropDownList();
                DropDownList ddlIT = new DropDownList();
                DropDownList ddlPC = new DropDownList();
                CheckBox chkQD = new CheckBox();
                CheckBox chkAA = new CheckBox();
                FredCK.FCKeditorV2.FCKeditor fckInterPret = new FredCK.FCKeditorV2.FCKeditor();

                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");

                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath;
                sPath = sPath + "/fckeditor/";
                fckInterPret.BasePath = sPath;
                fckInterPret.ToolbarSet = "Interpretation";
                fckInterPret.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                fckInterPret.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                HyperLink hypLnkUOM = new HyperLink();
                //hypLnkUOM.NavigateUrl = "ChangeUOM.aspx";
                //hypLnkUOM.Target = "UnitsWindow";
                hypLnkUOM.ForeColor = System.Drawing.Color.Black;
                HtmlInputHidden hdnUOMID = new HtmlInputHidden();
                HtmlInputHidden hdnUOMCode = new HtmlInputHidden();
                HiddenField hdnRRstring = new HiddenField();
				HiddenField hdnPRstring = new HiddenField();
                HiddenField hdnRRXML = new HiddenField();
				HiddenField hdnPRXML = new HiddenField();
                Label lblAlert=new Label();
                TextBox txtBoxAALID = new TextBox();//AutoApprovel
                Label lblAAName = new Label();
                TableCell cell11 = new TableCell();
                cell11.Attributes.Add("align", "left");
                cell11.Text = objIOM.InvestigationName;
                cell11.Width = 130;
                TableCell cell11aa = new TableCell();
                cell11aa.Attributes.Add("align", "left");
                hypLnkUOM.ID = "hypUM" + objIOM.InvestigationID.ToString();
                hdnUOMID.ID = "hdnUI" + objIOM.InvestigationID.ToString();
                hdnUOMCode.ID = "hdnUC" + objIOM.InvestigationID.ToString();
                hdnUOMID.Value = objIOM.UOMID.ToString();
                hdnUOMCode.Value = objIOM.UOMCode;
                hypLnkUOM.Text = objIOM.UOMCode;
                //hypLnkUOM.ToolTip = "Click here to Change Unit Of Measurment";
                hypLnkUOM.ToolTip = strClickHere;
                hypLnkUOM.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //string strScript = "javascript:MM_openBrWindow('ChangeUOM.aspx','','width=500,height=600');";
                hypLnkUOM.Attributes.Add("onclick", "javascript:setUOM(this.id);");
                cell11aa.Controls.Add(hypLnkUOM);
                cell11aa.Controls.Add(hdnUOMID);
                cell11aa.Controls.Add(hdnUOMCode);
                TableCell cell22 = new TableCell();
                cell22.Attributes.Add("align", "left");
                txtBoxDT.ID = "txtDT" + objIOM.InvestigationID.ToString();
                txtBoxDT.TextMode = TextBoxMode.MultiLine;
                txtBoxDT.Rows = 1;
                txtBoxDT.Columns = 5;
                cell22.Controls.Add(txtBoxDT);
                txtBoxDT.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
                txtBoxDT.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
                txtBoxDT.Text = objIOM.DisplayText;
                //txtBoxDT.ToolTip = "Enter Display Text";
                txtBoxDT.ToolTip = strDisplaytext;
                TableCell cell33 = new TableCell();
                cell33.Attributes.Add("align", "left");
                txtBoxRR.ID = "txtRR" + objIOM.InvestigationID.ToString();
                hdnRRstring.ID = "hdnRRstr" + objIOM.InvestigationID.ToString();
                hdnRRXML.ID = "hdnRRXML" + objIOM.InvestigationID.ToString();
                lblAlert.ID="lblAlert" + objIOM.InvestigationID.ToString();
                lblAlert.Text = "";
                lblAlert.ForeColor = System.Drawing.Color.Red;
                hlnkRR.ID = "hlnkRR" + objIOM.InvestigationID.ToString();
               // hlnkRR.Text = "Add";
                hlnkRR.Text = strAddRef;
                hlnkRR.ForeColor = System.Drawing.Color.Blue;
                //hlnkRR.ToolTip = "Add/Update a new reference range";
                hlnkRR.ToolTip = strInv15;
                hlnkRR.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                hlnkRR.Attributes.Add("onClick", "javascript:ShowRRPopUp1('" + txtBoxRR.ClientID + "','" + objIOM.InvestigationName.ToString() + "','" + hdnRRstring.ClientID + "','" + hdnRRXML.ClientID +"','Add');");
                cell33.Controls.Add(txtBoxRR);
                cell33.Controls.Add(hdnRRstring);
                cell33.Controls.Add(hdnRRXML);
                cell33.Controls.Add(hlnkRR);
                txtBoxRR.TextMode = TextBoxMode.MultiLine;
                txtBoxRR.Rows = 1;
                txtBoxRR.Columns = 5;
                string ReferenceRange = string.Empty;
                string uom = string.Empty;
				string RangeType = string.Empty;
                if (TryParseXml(objIOM.ReferenceRange))
                {
					RangeType = "referencerange";
                    ConvertXmlToString(objIOM.ReferenceRange, out ReferenceRange, uom, RangeType);
                    txtBoxRR.Text = ReferenceRange;
                    hdnRRXML.Value = objIOM.ReferenceRange;
                    txtBoxRR.ReadOnly = true;
                    cell33.Controls.Add(lblAlert);
                    txtBoxRR.Attributes.Add("onfocus", "javascript:expandBox(this.id);ShowAlert(this.id,"+lblAlert.ClientID+");");
                    txtBoxRR.Attributes.Add("onblur", "javascript:collapseBox(this.id);HideAlert(this.id," + lblAlert.ClientID + ");");
                }
                else
                {
                txtBoxRR.Text = objIOM.ReferenceRange;
                hdnRRXML.Value = "";
                txtBoxRR.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
                txtBoxRR.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
                }
                if (objIOM.ReferenceRangeString != "" && objIOM.ReferenceRangeString != null)
                {
                    string Value = string.Empty;
                    Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                    obj.Crypt(objIOM.ReferenceRangeString.ToString(), out Value);
                    hdnRRstring.Value = Value;
                }
                else
                {
                    hdnRRstring.Value = "";
                }
                //if (objIOM.ReferenceRangeString == "" || objIOM.ReferenceRangeString==null)
                //{
                //        txtBoxRR.ReadOnly = false;  
                //}
                if (txtBoxRR.Text != "")
                {
                    if (TryParseXml(objIOM.ReferenceRange))
                    {
                        //txtBoxRR.ToolTip = txtBoxRR.Text + "(Formed As XML)";
                        txtBoxRR.ToolTip = txtBoxRR.Text + strInv03;
                    }
                    else
                    {
                        txtBoxRR.ToolTip = txtBoxRR.Text;
                    }
                }
                else
                {
                   // txtBoxRR.ToolTip = "Enter ReferenceRange";
                    txtBoxRR.ToolTip = strInv01;
                }
                // below Code is for panic range
                TableCell cell34 = new TableCell();
                cell34.Attributes.Add("align", "left");
                txtBoxPR.ID = "txtPR" + objIOM.InvestigationID.ToString();
                hlnkPR.ID = "hlnkPR" + objIOM.InvestigationID.ToString();
				hdnPRstring.ID = "hdnPRstr" + objIOM.InvestigationID.ToString();
                hdnPRXML.ID = "hdnPRXML" + objIOM.InvestigationID.ToString();
                lblAlert.ID = "lblAlert" + objIOM.InvestigationID.ToString();
                lblAlert.Text = "";
                lblAlert.ForeColor = System.Drawing.Color.Red;
                //hlnkPR.Text = "Add";
                hlnkPR.Text = strAdd;
                hlnkPR.ForeColor = System.Drawing.Color.Blue;
                //hlnkPR.ToolTip = "Add/Update a new panic range";
                hlnkPR.ToolTip = strInv02;
                hlnkPR.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                hlnkPR.Attributes.Add("onClick", "javascript:ShowRRPopUp('" + txtBoxPR.ClientID + "','" + objIOM.InvestigationName.ToString() + "','" + hdnPRstring.ClientID + "','" + hdnPRXML.ClientID + "','Add');");
                cell34.Controls.Add(txtBoxPR);
                cell34.Controls.Add(hlnkPR);
				cell34.Controls.Add(hdnPRstring);
                cell34.Controls.Add(hdnPRXML);
                txtBoxPR.TextMode = TextBoxMode.MultiLine;
                txtBoxPR.Rows = 1;
                txtBoxPR.Columns = 5;
                txtBoxPR.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
                txtBoxPR.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
				string PanicRange = string.Empty;
                if (TryParseXml(objIOM.ReferenceRange))
                {
                    RangeType = "panicrange";
                    ConvertXmlToString(objIOM.ReferenceRange, out PanicRange, uom, RangeType);
                    txtBoxPR.Text = PanicRange;
                    hdnPRXML.Value = objIOM.ReferenceRange;
                    txtBoxPR.ReadOnly = true;
                    //cell34.Controls.Add(lblAlert);
                    //txtBoxPR.Attributes.Add("onfocus", "javascript:expandBox(this.id);ShowAlert(this.id," + lblAlert.ClientID + ");");
                    //txtBoxPR.Attributes.Add("onblur", "javascript:collapseBox(this.id);HideAlert(this.id," + lblAlert.ClientID + ");");
                }
                else
                {
                    txtBoxPR.Text = objIOM.ReferenceRange;
                    hdnPRXML.Value = "";
                    txtBoxPR.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
                    txtBoxPR.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
                }
                if (txtBoxPR.Text != "")
                {
                    if (TryParseXml(objIOM.PanicRange))
                    {
                        //txtBoxPR.ToolTip = txtBoxPR.Text + "(Formed As XML)";
                        txtBoxPR.ToolTip = txtBoxPR.Text + strInv03;
                    }
                    else
                    {
                        txtBoxPR.ToolTip = txtBoxPR.Text;
                    }
                }
                else
                {
                    //txtBoxPR.ToolTip = "Enter PanicRange";
                    txtBoxPR.ToolTip = strInv04;
                }
                TableCell cell44 = new TableCell();
                cell44.Attributes.Add("align", "left");
                ddlSL.ID = "ddlSL" + objIOM.InvestigationID.ToString();
                cell44.Controls.Add(ddlSL);
                ddlSL.Width = 50;
                //ddlSL.DataSource = lstInvSM;
                //ddlSL.DataTextField = "SampleDesc";
                //ddlSL.DataValueField = "SampleCode";
                //ddlSL.DataBind();
                //ddlSL.Items.Insert(0, "-----Select-----");
                //ddlSL.Items[0].Value = "0";
                ddlSL.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlSL.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlSL.ToolTip = "Select Test Sample";
                ddlSL.ToolTip = strInv05;
                TableCell cell44a = new TableCell();
                cell44a.Attributes.Add("align", "left");
                ddlSC.ID = "ddlSC" + objIOM.InvestigationID.ToString();
                cell44a.Controls.Add(ddlSC);
                ddlSC.Width = 50;
                //ddlSL.DataSource = lstInvSM;
                //ddlSL.DataTextField = "SampleDesc";
                //ddlSL.DataValueField = "SampleCode";
                //ddlSL.DataBind();
                //ddlSL.Items.Insert(0, "-----Select-----");
                //ddlSL.Items[0].Value = "0";
                ddlSC.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlSC.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlSC.ToolTip = "Select Test Sample Additive";
                ddlSC.ToolTip = strInv06;
                TableCell cell55 = new TableCell();
                cell55.Attributes.Add("align", "left");
                ddlMT.ID = "ddlMT" + objIOM.InvestigationID.ToString();
                cell55.Controls.Add(ddlMT);
                ddlMT.Width = 50;
                //ddlMT.DataSource = lstInvMtd;
                //ddlMT.DataTextField = "MethodName";
                //ddlMT.DataValueField = "MethodID";
                //ddlMT.DataBind();
                //ddlMT.Items.Insert(0, "-----Select-----");
                //ddlMT.Items[0].Value = "0";
                ddlMT.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlMT.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlMT.ToolTip = "Select Test Method";
                ddlMT.ToolTip = strInv07;
                TableCell cell66 = new TableCell();
                cell66.Attributes.Add("align", "left");
                ddlPR.ID = "ddlPR" + objIOM.InvestigationID.ToString();
                cell66.Controls.Add(ddlPR);
                ddlPR.Width = 50;
                //ddlPR.DataSource = lstInvPR;
                //ddlPR.DataTextField = "PrincipleName";
                //ddlPR.DataValueField = "PrincipleID";
                //ddlPR.DataBind();
                //ddlPR.Items.Insert(0, "-----Select-----");
                //ddlPR.Items[0].Value = "0";
                ddlPR.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlPR.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlPR.ToolTip = "Select Test Principle";
                string strInv16 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_43 == null ? "Select Test Principle" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_43;

                ddlPR.ToolTip = strInv16;
                //ddlPR.SelectedValue = "5";
                TableCell cell77 = new TableCell();
                cell77.Attributes.Add("align", "left");
                ddlKT.ID = "ddlKT" + objIOM.InvestigationID.ToString();
                cell77.Controls.Add(ddlKT);
                ddlKT.Width = 50;
                //ddlKT.DataSource = lstInvKT;
                //ddlKT.DataTextField = "KitName";
                //ddlKT.DataValueField = "KitID";
                //ddlKT.DataBind();
                //ddlKT.Items.Insert(0, "-----Select-----");
                //ddlKT.Items[0].Value = "0";
                ddlKT.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlKT.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlKT.ToolTip = "Select Test Kit";
                ddlKT.ToolTip = strInv08;
                TableCell cell88 = new TableCell();
                cell88.Attributes.Add("align", "left");
                ddlIT.ID = "ddlIT" + objIOM.InvestigationID.ToString();
                cell88.Controls.Add(ddlIT);
                ddlIT.Width = 50;
                //ddlIT.DataSource = lstInvIM;
                //ddlIT.DataTextField = "InstrumentName";
                //ddlIT.DataValueField = "InstrumentID";
                //ddlIT.DataBind();
                //ddlIT.Items.Insert(0, "-----Select-----");
                //ddlIT.Items[0].Value = "0";
                ddlIT.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlIT.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                //ddlIT.ToolTip = "Select Test Instrument";
                ddlIT.ToolTip = strInv09;
                TableCell cell99 = new TableCell();
                cell99.Attributes.Add("align", "left");
                chkQD.ID = "chkQD" + objIOM.InvestigationID.ToString();
                cell99.Controls.Add(chkQD);
                if (objIOM.QCData == "Y")
                {
                    chkQD.Checked = true;
                }
                chkQD.Attributes.Add("onclick", "javascript:checkClick(this.id);");
                //chkQD.ToolTip = "Check for Quality Control Data";
                chkQD.ToolTip = strInv10;
                //AutoApprovel
                TableCell cell102 = new TableCell();
                cell102.Attributes.Add("align", "left");
                txtBoxAALID.ID = "txtAA" + objIOM.InvestigationID.ToString();
                cell102.Controls.Add(txtBoxAALID);
                txtBoxAALID.Rows = 1;
                txtBoxAALID.Columns = 5;
                txtBoxAALID.Text = Convert.ToString(objIOM.AutoApproveLoginID);
                //txtBoxAALID.ToolTip = "Enter AutoAuthorize LoginID";
                txtBoxAALID.ToolTip = strInv11;
                txtBoxAALID.Attributes.Add("style", "display:none");


                lblAAName.ID = "lblAA" + objIOM.InvestigationID.ToString();

                lblAAName.Text = objIOM.AutoApproveLoginName;
                //lblAAName.ToolTip = "AutoAuthorize Name";
                lblAAName.ToolTip = strInv12;
                lblAAName.Attributes.Add("style", "display:block");
                 

                TableCell cell990 = new TableCell();
                cell990.Attributes.Add("align", "left");
                chkAA.ID = "chkAA" + objIOM.InvestigationID.ToString();
                if (objIOM.AutoApproveLoginID > 0)
                {
                    chkAA.Checked = true;
                }
                cell990.Controls.Add(chkAA);
                cell990.Controls.Add(lblAAName);
                chkAA.Attributes.Add("onclick", "javascript:ShowAAPopUp('" + txtBoxAALID.ClientID + "','" + objIOM.InvestigationName.ToString() + "','" + chkAA.ClientID + "','" + lblAAName.ClientID + "');");
                //chkAA.ToolTip = "Check for Authorize";
                chkAA.ToolTip = strInv13;
                TableCell cell100 = new TableCell();
                cell100.Attributes.Add("align", "left");
                
                fckInterPret.ID = "fckInterPret" + objIOM.InvestigationID.ToString();
                cell100.Controls.Add(fckInterPret);

                TableCell cell101 = new TableCell();
                cell101.Attributes.Add("align", "left");
                ddlPC.ID = "ddlPC" + objIOM.InvestigationID.ToString();
                ddlPC.Attributes.Add("onfocus", "javascript:expandList(this.id);");
                ddlPC.Attributes.Add("onblur", "javascript:collapseList(this.id);");
                cell101.Controls.Add(ddlPC);
                ddlPC.Width = 50;

                hlnkPC.ID = "hlnkPC" + objIOM.InvestigationID.ToString();
                hlnkPC.Text = "Add";
                hlnkPC.ForeColor = System.Drawing.Color.Blue;
                //hlnkPC.ToolTip = "Add/Update a new Processing Centre";
                hlnkPC.ToolTip = strInv14;
                hlnkPC.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                hlnkPC.Attributes.Add("onClick", "javascript:ShowPCPopUp('" + txtBoxAALID.ClientID + "','" + objIOM.InvestigationName.ToString() + "','Add','" + objIOM.InvestigationID.ToString() + "');");
                cell101.Controls.Add(hlnkPC);

                HiddenField hdnInvMappedLocations = new HiddenField();
                hdnInvMappedLocations.ID = "hdnInvMappedLocations" + objIOM.InvestigationID.ToString();
                returnCode = investigationBL.GetInvMappedLocations(objIOM.InvestigationID, out lstInvMappedLocations);
                if (lstInvMappedLocations != null && lstInvMappedLocations.Count > 0)
                {
                    foreach (InvestigationLocationMapping lstLoc in lstInvMappedLocations)
                    {
                        if (hdnInvMappedLocations.Value == "")
                        {
                            hdnInvMappedLocations.Value = lstLoc.LocationID.ToString() + "~" + lstLoc.ProcessingAddressID.ToString() + "^";
                        }
                        else
                        {
                            hdnInvMappedLocations.Value += lstLoc.LocationID.ToString() + "~" + lstLoc.ProcessingAddressID.ToString() + "^";
                        }
                    }
                }
                cell101.Controls.Add(hdnInvMappedLocations);

                fckInterPret.Width = 180;
                fckInterPret.Height = 55;
                fckInterPret.ToolbarStartExpanded = false;
                fckInterPret.Value = objIOM.Interpretation;

                cell11.BorderWidth = 1;
                cell11aa.BorderWidth = 1;
                cell22.BorderWidth = 1;
                cell33.BorderWidth = 1;
                cell44.BorderWidth = 1;
                cell44a.BorderWidth = 1;
                cell55.BorderWidth = 1;
                cell66.BorderWidth = 1;
                cell77.BorderWidth = 1;
                cell88.BorderWidth = 1;
                cell99.BorderWidth = 1;
                cell100.BorderWidth = 1;
                cell990.BorderWidth = 1;
                cell101.BorderWidth = 1;
                cell34.BorderWidth = 1;
                cell102.BorderWidth = 1;

                row11.Cells.Add(cell11);
                row11.Cells.Add(cell11aa);
                row11.Cells.Add(cell22);
                row11.Cells.Add(cell33);
                row11.Cells.Add(cell44);
                row11.Cells.Add(cell44a);
                row11.Cells.Add(cell55);
                row11.Cells.Add(cell66);
                row11.Cells.Add(cell77);
                row11.Cells.Add(cell88);
                row11.Cells.Add(cell99);
                row11.Cells.Add(cell100);
                row11.Cells.Add(cell990);
                row11.Cells.Add(cell101);
                row11.Cells.Add(cell34);
                row11.Cells.Add(cell102);

                row11.Font.Bold = false;
                row11.Font.Size = 8;
                row11.Style.Add("color", "#000000");
                row11.BorderWidth = 1;
                masterTab.Rows.Add(row11);


            }
            btnTab.Visible = true;
            btnTabTop.Visible = true;


        }
        else
        {
            lblStatus.Visible = true;
            btnTab.Visible = false;
            btnTabTop.Visible = false;
        }
        LoadProcessingCentreTable();
    }

    protected void LoadProcessingCentreTable()
    {
        string strInv17 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_44 == null ? "Collection Centre" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_44;
        string strInv18 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_45 == null ? "Processing Centre" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_45;
        string strInv19 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_46 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_46;
        string strInv20 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_47 == null ? "Mapped Centres" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_47;


        TableRow row1 = new TableRow();
        TableCell cell1 = new TableCell();
        cell1.Attributes.Add("align", "left");
        //cell1.Text = "Collection Centre";
        cell1.Text = strInv17;
        TableCell cell2 = new TableCell();
        cell2.Attributes.Add("align", "left");
        //cell2.Text = "Processing Centre";
        cell2.Text = strInv18;

        TableCell cell13 = new TableCell();
        cell13.Attributes.Add("align", "left");
       // cell13.Text = "Select";
        cell13.Text = strInv19;
        cell13.ID = "cellAllInv";

        cell1.BorderWidth = 1;
        row1.Cells.Add(cell1);
        row1.Cells.Add(cell2);
        row1.Cells.Add(cell13);
        //Mapped Loc Testing
        TableCell cell14 = new TableCell();
        //cell14.Text = "Mapped Centres";
        cell14.Text = strInv20;
        cell14.ID = "cellMappedCentres";
        cell14.Attributes.Add("align", "left");
        row1.Cells.Add(cell14);
        //Mapped Loc Testing

        row1.Font.Bold = true;
        row1.Font.Size = 8;
        row1.CssClass = "Duecolor";
        row1.BorderWidth = 1;
        tblPCpopup.Rows.Add(row1);

        hdnPCddlControls.Value = "";
        hdnCCFinalList.Value = "";
        hdnPCFinalList.Value = "";

        foreach (OrganizationAddress objCC in lstOrganizationAddress)
        {
            TableRow row2 = new TableRow();
            row2.ID = "row" + objCC.AddressID.ToString();
            Label LBL1 = new Label();
            TableCell cell3 = new TableCell();
            cell3.Controls.Add(LBL1);
            LBL1.ID = "LBL" + objCC.AddressID.ToString();
            LBL1.Text = objCC.Location;
            DropDownList DDL1 = new DropDownList();
            DDL1.ID = "DDL" + objCC.AddressID.ToString();
            TableCell cell4 = new TableCell();

            CheckBox chkAll = new CheckBox();
            chkAll.ID = "chkAll" + objCC.AddressID.ToString();
            //SetFinalChkValues()
            chkAll.Attributes.Add("onClick", "SetFinalChkValues('" + chkAll.ClientID.ToString() + "');");
            TableCell cell5 = new TableCell();
            cell5.Controls.Add(chkAll);

            Label lblMappedLoc = new Label();
            lblMappedLoc.ID = "lblMappedLoc" + objCC.AddressID.ToString();

            cell4.Controls.Add(DDL1);
            //cell4.Controls.Add(lblMappedLoc);

            row2.Cells.Add(cell3);
            row2.Cells.Add(cell4);
            //Mapped Locations Testing
            TableCell cell8 = new TableCell();
            cell8.ID = "cellMappedCentresCtl" + objCC.AddressID.ToString();
            cell8.Controls.Add(lblMappedLoc);
            row2.Cells.Add(cell8);
            //Mapped Locations Testing
            row2.Cells.Add(cell5);

            row2.Font.Bold = false;
            row2.Font.Size = 8;

            HiddenField hdnColCent = new HiddenField();
            hdnColCent.ID = "hdnColCent" + objCC.AddressID.ToString();
            hdnColCent.Value = lstOrganizationAddress[0].AddressID + "~" + lstOrganizationAddress[0].OrgID + "|" + lstOrganizationAddress[0].AddressType + "^";
            cell3.Controls.Add(hdnColCent);

            DDL1.DataTextField = "Location";
            DDL1.DataValueField = "Comments";
            DDL1.DataSource = lstProcessingCentres;
            DDL1.DataBind();

            HiddenField hdnProCent = new HiddenField();
            hdnProCent.ID = "hdnProCent" + objCC.AddressID.ToString();
            // hdnProCent.Value = lstProcessingCentres[0].Comments.ToString();
            hdnProCent.Value = (lstProcessingCentres != null && lstProcessingCentres.Count > 0) ? lstProcessingCentres[0].Comments.ToString() : string.Empty;
            cell4.Controls.Add(hdnProCent);

            DDL1.Attributes.Add("onChange", "SetChangedPCValue('" + DDL1.ClientID.ToString() + "','" + hdnProCent.ClientID.ToString() + "');");

            if (hdnPCddlControls.Value == "")
            {
                hdnPCddlControls.Value = DDL1.ClientID.ToString();
            }
            else
            {
                hdnPCddlControls.Value += '~' + DDL1.ClientID.ToString();
            }

            if (hdnPCchkAllControls.Value == "")
            {
                hdnPCchkAllControls.Value = chkAll.ClientID.ToString();
                hdnPCchkAllFinalList.Value = "0";
            }
            else
            {
                hdnPCchkAllControls.Value += "~" + chkAll.ClientID.ToString();
                hdnPCchkAllFinalList.Value += "~" + "0";
            }

            if (hdnCCControls.Value == "")
            {
                hdnCCControls.Value = hdnColCent.ClientID;
            }
            else
            {
                hdnCCControls.Value += '~' + hdnColCent.ClientID;
            }

            if (hdnPCControls.Value == "")
            {
                hdnPCControls.Value = hdnProCent.ClientID;
            }
            else
            {
                hdnPCControls.Value += '~' + hdnProCent.ClientID;
            }

            row2.BorderWidth = 1;
            tblPCpopup.Rows.Add(row2);

        }

        for (int i = 0; i < lstOrganizationAddress.Count; i++)
        {

            if (hdnCCFinalList.Value == "")
            {
                hdnCCFinalList.Value = lstOrganizationAddress[i].Comments;
            }
            else
            {
                hdnCCFinalList.Value += lstOrganizationAddress[i].Comments;
            }
        }

        for (int i = 0; i < lstProcessingCentres.Count; i++)
        {
            if (hdnPCFinalList.Value == "")
            {
                hdnPCFinalList.Value = lstProcessingCentres[i].Comments;
            }
            else
            {
                hdnPCFinalList.Value += lstProcessingCentres[i].Comments;
            }
        }

        TableRow row3 = new TableRow();
        Label LBL2 = new Label();

        TableCell cell7 = new TableCell();
        row3.Controls.Add(cell7);
        string strInv21 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_48 == null ? "Save/Close" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_48;

        TableCell cell6 = new TableCell();
        HyperLink hlnkSaveClosePc = new HyperLink();
        cell6.HorizontalAlign = HorizontalAlign.Right;
        cell6.ColumnSpan = 3;
        hlnkSaveClosePc.ID = "hlnkSaveClosePc";
        //hlnkSaveClosePc.Text = "Save/Close";
        hlnkSaveClosePc.Text = strInv21;
        hlnkSaveClosePc.Attributes.Add("class", "btn");
        hlnkSaveClosePc.Attributes.Add("onclick", "javascript:SaveClosePc();");
        hlnkSaveClosePc.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
        cell6.Controls.Add(hlnkSaveClosePc);
        row3.Cells.Add(cell6);
        row3.CssClass = "Duecolor";
        tblPCpopup.Rows.Add(row3);

        divPCpopup.Visible = true;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            //Response.Redirect(Request.ApplicationPath + path, true);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int success = 1;
        string temp = string.Empty;
        //returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument);
        //if (returnCode == 0)
        //{
        //    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument);
        //}
        List<InvestigationOrgMapping> lstInvestigationOM = new List<InvestigationOrgMapping>();
        try
        {
            foreach (string str in hdnUpdatedList.Value.Split('^'))
            {
                string[] lineItems = str.Split('~');
                if (lineItems[0] != "")
                {
                    foreach (string str1 in temp.Split('~'))
                    {
                        if (str1 == lineItems[0])
                        {
                            //success = 0;
                        }
                    }
                    if (success == 1)
                    {
                        InvestigationOrgMapping objIOM = new InvestigationOrgMapping();
                        int nResult32 = 0;
                        long nResult64 = 0;
                        //TableRow tRW = (TableRow)masterTab.FindControl("row"+str);
                        //TextBox tDT = (TextBox)tRW.FindControl("txtDT" + str);
                        //TextBox tDT = (TextBox)masterTab.FindControl("txtDT" + str);
                        //TextBox tRR = (TextBox)masterTab.FindControl("txtRR" + str);
                        //CheckBox cQD = (CheckBox)masterTab.FindControl("chkQD" + str);
                        //TextBox tIN = (TextBox)masterTab.FindControl("txtIN" + str);
                        //DropDownList dSL = (DropDownList)masterTab.FindControl("ddlSL" + str);
                        //DropDownList dMT = (DropDownList)masterTab.FindControl("ddlMT" + str);
                        //DropDownList dPR = (DropDownList)masterTab.FindControl("ddlPR" + str);
                        //DropDownList dKT = (DropDownList)masterTab.FindControl("ddlKT" + str);
                        //DropDownList dIT = (DropDownList)masterTab.FindControl("ddlIT" + str);                   
                        objIOM.InvestigationID = Convert.ToInt64(lineItems[0]);
                        objIOM.OrgID = OrgID;
                        objIOM.LoginID = LID;
                        objIOM.DisplayText = lineItems[1];
                        //objIOM.ReferenceRange = lineItems[2];
                        if (lineItems[9] == "Y")
                        {
                            objIOM.QCData = "Y";
                        }
                        else
                        {
                            objIOM.QCData = "N";
                        }
                        objIOM.Interpretation = lineItems[10];
                        //objIOM.SampleCode = Convert.ToInt32(lineItems[3]);
                        //objIOM.SampleContainerID = Convert.ToInt32(lineItems[4]);
                        //objIOM.MethodID = Convert.ToInt64(lineItems[5]);
                        //objIOM.PrincipleID = Convert.ToInt64(lineItems[6]);
                        //objIOM.KitID = Convert.ToInt64(lineItems[7]);
                        //objIOM.InstrumentID = Convert.ToInt64(lineItems[8]);
                        //objIOM.UOMID = Convert.ToInt32(lineItems[11]);
                        //objIOM.UOMCode = lineItems[12];
                        //objIOM.DeptID = Convert.ToInt32(lineItems[13]);
                        objIOM.SampleCode = Int32.TryParse(lineItems[3], out nResult32) == true ? nResult32 : 0;
                        objIOM.SampleContainerID = Int32.TryParse(lineItems[4], out nResult32) == true ? nResult32 : 0;
                        objIOM.MethodID = Int64.TryParse(lineItems[5], out nResult64) == true ? nResult64 : 0;
                        objIOM.PrincipleID = Int64.TryParse(lineItems[6], out nResult64) == true ? nResult64 : 0;
                        objIOM.KitID = Int64.TryParse(lineItems[7], out nResult64) == true ? nResult64 : 0;
                        objIOM.InstrumentID = Int64.TryParse(lineItems[8], out nResult64) == true ? nResult64 : 0;
                        objIOM.UOMID = Int32.TryParse(lineItems[11], out nResult32) == true ? nResult32 : 0;
                        objIOM.UOMCode = lineItems[12];
                        objIOM.DeptID = Int32.TryParse(lineItems[13], out nResult32) == true ? nResult32 : 0;
                        objIOM.PanicRange = lineItems[14];
 string prpstr = string.Empty;
                        //string[] value = objIOM.PanicRange.Split('<');

                        if (TryParseXml(lineItems[14]))
                        {

                            XElement xe = XElement.Parse(lineItems[14]);
                            var paniceprop = (from prop in xe.Elements("referencerange").Elements("property")
                                              select prop).ToList();
                            if (paniceprop[0] != null)
                            {
                                prpstr = paniceprop[0].ToString();
                            }
                            objIOM.PanicRange = "<panicrange>" + prpstr + "</panicrange>";
                        }
                        else
                        {
                            objIOM.PanicRange = lineItems[14];
                        }
                        if (TryParseXml(lineItems[2]))
                        {
                            XElement xer = XElement.Parse(lineItems[2]);
                            if (xer.Elements("referencerange").Elements("property") != null)
                            {
                                int reflen = lineItems[2].Length;
                                int subi = reflen - 18;
                                string str1stPart = lineItems[2].Substring(0, (reflen - 18));
                                string str3rdPart = "</referenceranges>";
                                objIOM.ReferenceRange = str1stPart + objIOM.PanicRange + str3rdPart;

                            }


                        }
                        else
                        {
                            objIOM.ReferenceRange = lineItems[2];
                        }
                        objIOM.PanicRange = lineItems[14];
                        if (Convert.ToBoolean(lineItems[16]))
                        {
                            objIOM.AutoApproveLoginID = Int32.TryParse(lineItems[15], out nResult32) == true ? nResult32 : 0;
                        }
                        else
                        {
                            objIOM.AutoApproveLoginID = 0;
                        }
                        if (lineItems[17] != "" && lineItems[17] != null)
                        {
                            string Value = string.Empty;
                            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                            obj.Crypt(lineItems[17].ToString(), out Value);
                            objIOM.ReferenceRangeString = Value;
                        }
                        else
                        {
                            objIOM.ReferenceRangeString = "";
                        }
                        lstInvestigationOM.Add(objIOM);
                        temp += lineItems[0] + "~";
                    }
                    success = 1;
                }
            }
            if (lstInvestigationOM.Count > 0)
            {
                returnCode = investigationBL.SaveReferenceRange(lstInvestigationOM, OrgID);
            }
            if (returnCode == 0)
            {
                string strInv22 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_49 == null ? "Investigation related details Updated Successfully..!" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_49;


               // lblMessage.Text = "Investigation related details Updated Sucessfully..!";
                lblMessage.Text = strInv22;
                string strTxtInvName;
                hdnSL.Value = "";
                hdnSC.Value = "";
                hdnTest.Value = "";
                hdnUpdatedTest.Value = "";
                hdnUpdatedList.Value = "";
                hdnPR.Value = "";
                hdnMT.Value = "";
                hdnKT.Value = "";
                hdnPC.Value = "";
                hdnIT.Value = "";
                strTxtInvName = txtInvestigationName.Text;
                if (strTxtInvName != "")
                {
                    StartIndex = Convert.ToInt64(hdnStartIndex.Value);
                    EndIndex = Convert.ToInt64(hdnEndIndex.Value);
                    returnCode = investigationBL.SearchInvRefRangeForMDM(strTxtInvName, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
                }
                else
                {
                    StartIndex = Convert.ToInt64(hdnStartIndex.Value);
                    EndIndex = Convert.ToInt64(hdnEndIndex.Value);
                    returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
                }
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }
            }
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Saving Reference Range Details.", ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strTxtInvName;
        try
        {

            btnNext.Visible = false;
            btnNextTop.Visible = false;
            btnPrevious.Visible = false;
            btnPreviousTop.Visible = false;
            lblMessage.Text = "";
            hdnSL.Value = "";
            hdnSC.Value = "";
            hdnTest.Value = "";
            hdnUpdatedTest.Value = "";
            hdnUpdatedList.Value = "";
            hdnPR.Value = "";
            hdnMT.Value = "";
            hdnKT.Value = "";
            hdnIT.Value = "";
            hdnPC.Value = "";
            strTxtInvName = txtInvestigationName.Text;
            StartIndex = 1;
            EndIndex = PageSize;
            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            returnCode = investigationBL.SearchInvRefRangeForMDM(strTxtInvName, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
            if (returnCode == 0)
            {
                hdnSearchTotalCount.Value = TotalSerachCount.ToString();
                if (TotalSerachCount > EndIndex)
                {
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                }
                else
                {
                    btnNext.Visible = false;
                    btnNextTop.Visible = false;
                    btnPrevious.Visible = false;
                    btnPreviousTop.Visible = false;
                }
                LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
            }
        }
        catch (Exception ex)
        {
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Searching Reference Range and related Details.", ex);
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {

        if (txtInvestigationName.Text != "")
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

            if (Convert.ToInt64(hdnSearchTotalCount.Value) > StartIndex)
            {
                btnNext.Visible = true;
                btnPrevious.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.SearchInvRefRangeForMDM(txtInvestigationName.Text, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }
                if (EndIndex > Convert.ToInt64(hdnSearchTotalCount.Value))
                {
                    btnNext.Visible = false;
                    btnPrevious.Visible = true;
                    btnNextTop.Visible = false;
                    btnPreviousTop.Visible = true;
                }
            }
        }
        else
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

            if (Convert.ToInt64(hdnTotalCount.Value) > StartIndex)
            {
                btnNext.Visible = true;
                btnPrevious.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = true;

                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }
                if (EndIndex > Convert.ToInt64(hdnTotalCount.Value))
                {
                    btnNext.Visible = false;
                    btnPrevious.Visible = true;
                    btnNextTop.Visible = false;
                    btnPreviousTop.Visible = true;
                }
            }
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {

        if (txtInvestigationName.Text != "")
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

            if (StartIndex >= 1)
            {
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.SearchInvRefRangeForMDM(txtInvestigationName.Text, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }

                if (StartIndex == 1)
                {
                    btnPrevious.Visible = false;
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                    btnPreviousTop.Visible = false;

                }
            }
        }
        else
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

            if (StartIndex >= 1)
            {
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }

                if (StartIndex == 1)
                {
                    btnPrevious.Visible = false;
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                    btnPreviousTop.Visible = false;

                }
            }
        }


    }

    protected void btnNextTop_Click(object sender, EventArgs e)
    {
        if (txtInvestigationName.Text != "")
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

            if (Convert.ToInt64(hdnSearchTotalCount.Value) > StartIndex)
            {
                btnNext.Visible = true;
                btnPrevious.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.SearchInvRefRangeForMDM(txtInvestigationName.Text, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }
                if (EndIndex > Convert.ToInt64(hdnSearchTotalCount.Value))
                {
                    btnNext.Visible = false;
                    btnPrevious.Visible = true;
                    btnNextTop.Visible = false;
                    btnPreviousTop.Visible = true;
                }
            }
        }
        else
        {

            StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

            if (Convert.ToInt64(hdnTotalCount.Value) > StartIndex)
            {
                btnNext.Visible = true;
                btnPrevious.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = true;

                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }
                if (EndIndex > Convert.ToInt64(hdnTotalCount.Value))
                {
                    btnNext.Visible = false;
                    btnPrevious.Visible = true;

                    btnNextTop.Visible = false;
                    btnPreviousTop.Visible = true;
                }
            }
        }


    }

    protected void btnPreviousTop_Click(object sender, EventArgs e)
    {
        if (txtInvestigationName.Text != "")
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

            if (StartIndex >= 1)
            {
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.SearchInvRefRangeForMDM(txtInvestigationName.Text, OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalSerachCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }

                if (StartIndex == 1)
                {
                    btnPrevious.Visible = false;
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                    btnPreviousTop.Visible = false;

                }
            }
        }
        else
        {
            StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
            EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

            if (StartIndex >= 1)
            {
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                hdnStartIndex.Value = StartIndex.ToString();
                hdnEndIndex.Value = EndIndex.ToString();
                returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, StartIndex, EndIndex, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);
                if (returnCode == 0)
                {
                    LoadTable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, lstOrganizationAddress, lstProcessingCentres);
                }

                if (StartIndex == 1)
                {
                    btnPrevious.Visible = false;
                    btnNext.Visible = true;
                    btnNextTop.Visible = true;
                    btnPreviousTop.Visible = false;

                }
            }
        }


    }

    #region  Added from Jagatheeshkumar

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "TMasterCtrlCategory,TMasterCtrlSubCategory,TMasterCtrlSelType,TMasterCtrlOperRange";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems6 = from child in lstmetadataOutputs
                                  where child.Domain == "TMasterCtrlCategory"
                                  select child;
                if (childItems6.Count() > 0)
                {
                    ddlCategory.DataSource = childItems6;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.DataBind();

                }
                var childItems7 = from child in lstmetadataOutputs
                                  where child.Domain == "TMasterCtrlSubCategory"
                                  select child;
                if (childItems7.Count() > 0)
                {
                    ddlSubCategory.DataSource = childItems7;
                    ddlSubCategory.DataTextField = "DisplayText";
                    ddlSubCategory.DataValueField = "Code";
                    ddlSubCategory.DataBind();

                }
                var childItems8 = from child in lstmetadataOutputs
                                  where child.Domain == "TMasterCtrlSelType"
                                  select child;
                if (childItems8.Count() > 0)
                {
                    ddlAgeType.DataSource = childItems8;
                    ddlAgeType.DataTextField = "DisplayText";
                    ddlAgeType.DataValueField = "Code";
                    ddlAgeType.DataBind();

                }
                var childItems9 = from child in lstmetadataOutputs
                                  where child.Domain == "TMasterCtrlOperRange"
                                  select child;
                if (childItems9.Count() > 0)
                {
                    ddlOperatorRange1.DataSource = childItems9;
                    ddlOperatorRange1.DataTextField = "DisplayText";
                    ddlOperatorRange1.DataValueField = "Code";
                    ddlOperatorRange1.DataBind();
                    ddlOperatorRange2.DataSource = childItems9;
                    ddlOperatorRange2.DataTextField = "DisplayText";
                    ddlOperatorRange2.DataValueField = "Code";
                    ddlOperatorRange2.DataBind();
                    ddlGenderValueOpt.DataSource = childItems9;
                    ddlGenderValueOpt.DataTextField = "DisplayText";
                    ddlGenderValueOpt.DataValueField = "Code";
                    ddlGenderValueOpt.DataBind();
                    ddlOtherRangeOpt.DataSource = childItems9;
                    ddlOtherRangeOpt.DataTextField = "DisplayText";
                    ddlOtherRangeOpt.DataValueField = "Code";
                    ddlOtherRangeOpt.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion

    protected void rdbGroup_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            Grp.Attributes.Add("Style", "Display:table-row");
            pnlGrpSearch.Attributes.Add("Style", "Display:Block");
            Inves.Attributes.Add("Style", "Display:None");
            Inv.Attributes.Add("Style", "Display:None");
            pnlSerch.Attributes.Add("Style", "Display:None");
            GrpLoad();
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnGrpSave_Click(object sender, EventArgs e)
    {
        try
        {
            int success = 1;
            string strTxtGrpName = String.Empty;
            List<InvOrgGroup> lstGroupOM = new List<InvOrgGroup>();
            foreach (string str in hdnGrpUpdatedList.Value.Split('^'))
            {
                string[] lineItems = str.Split('~');
                if (lineItems[0] != "")
                {
                    if (success == 1)
                    {
                        InvOrgGroup objIOM = new InvOrgGroup();
                        objIOM.AttGroupID = int.Parse(lineItems[0]);
                        objIOM.OrgID = OrgID;
                        objIOM.DisplayText = lineItems[1];
                        lstGroupOM.Add(objIOM);
                    }
                }
            }
            if (lstGroupOM.Count > 0)
            {
                returnCode = investigationBL.SaveGrpReferenceRange(lstGroupOM, OrgID);
            }
            strTxtGrpName = txtGroupName.Text;
            hdnGrpUpdatedList.Value = "";
            hdnGrpUpdatedTest.Value = "";
            if (strTxtGrpName != "")
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value);
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value);
            }
            else
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value);
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value);
                returnCode = investigationBL.GetGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, out grpIOM, out TotalCount);
            }
            if (returnCode == 0)
            {
                GrpLoadTable(grpIOM);
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnGrpNext_Click(object sender, EventArgs e)
    {
        try
        {
            string strTxtInvName;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> lstGroupOM = new List<InvGroupMaster>();
            if (txtGroupName.Text != "")
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value) + PageSize;
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value) + PageSize;
                if (Convert.ToInt64(hdnSearchGrpTotalCount.Value) > GrpStartIndex)
                {
                    btnGrpNext.Visible = true;
                    btnGrpPrevious.Visible = true;
                    //btnNextTop.Visible = true;
                    //btnPreviousTop.Visible = true;
                    strTxtInvName = txtGroupName.Text;
                    hdnGrpStartIndex.Value = GrpStartIndex.ToString();
                    hdnGrpEndIndex.Value = GrpEndIndex.ToString();
                    returnCode = investigationBL.SearchGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, strTxtInvName, out lstGroupOM, out TotalSerachCount);
                    if (returnCode == 0)
                    {
                        GrpLoadTable(lstGroupOM);
                    }
                    if (GrpEndIndex > Convert.ToInt64(TotalSerachCount))
                    {
                        btnGrpNext.Visible = false;
                        btnGrpPrevious.Visible = true;
                        //btnNextTop.Visible = false;
                        //btnPreviousTop.Visible = true;
                    }
                }
            }
            else
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value) + PageSize;
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value) + PageSize;

                if (Convert.ToInt64(hdnGrpTotalCount.Value) > GrpStartIndex)
                {
                    btnGrpNext.Visible = true;
                    btnGrpPrevious.Visible = true;
                    //btnNextTop.Visible = true;
                    //btnPreviousTop.Visible = true;
                    //if (GrpEndIndex > Convert.ToInt64(hdnGrpTotalCount.Value))
                    //{
                    //    GrpEndIndex = Convert.ToInt64(hdnGrpTotalCount.Value);
                    //}
                    hdnGrpStartIndex.Value = GrpStartIndex.ToString();
                    hdnGrpEndIndex.Value = GrpEndIndex.ToString();
                    returnCode = investigationBL.GetGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, out grpIOM, out TotalCount);
                    if (returnCode == 0)
                    {
                        GrpLoadTable(grpIOM);
                    }
                    if (GrpEndIndex > Convert.ToInt64(hdnGrpTotalCount.Value))
                    {
                        btnGrpNext.Visible = false;
                        btnGrpPrevious.Visible = true;
                        //btnNextTop.Visible = false;
                        //btnPreviousTop.Visible = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnGrpPrevious_Click(object sender, EventArgs e)
    {
        try
        {
            string strTxtInvName;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> lstGroupOM = new List<InvGroupMaster>();
            if (txtGroupName.Text != "")
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value) - PageSize;
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value) - PageSize;

                if (GrpStartIndex >= 1)
                {
                    btnGrpNext.Visible = true;
                    btnGrpPrevious.Visible = true;
                    //btnNextTop.Visible = true;
                    //btnPreviousTop.Visible = true;
                    strTxtInvName = txtGroupName.Text;
                    hdnGrpStartIndex.Value = GrpStartIndex.ToString();
                    hdnGrpEndIndex.Value = GrpEndIndex.ToString();
                    returnCode = investigationBL.SearchGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, strTxtInvName, out lstGroupOM, out TotalSerachCount);
                    if (returnCode == 0)
                    {
                        GrpLoadTable(lstGroupOM);
                    }
                    if (GrpStartIndex == 1)
                    {
                        btnGrpNext.Visible = true;
                        btnGrpPrevious.Visible = false;
                        //btnNextTop.Visible = false;
                        //btnPreviousTop.Visible = true;
                    }
                }
            }
            else
            {
                GrpStartIndex = Convert.ToInt64(hdnGrpStartIndex.Value) - PageSize;
                GrpEndIndex = Convert.ToInt64(hdnGrpEndIndex.Value) - PageSize;
                if (GrpStartIndex >= 1)
                {
                    btnGrpNext.Visible = true;
                    btnGrpPrevious.Visible = true;
                    //btnNextTop.Visible = true;
                    //btnPreviousTop.Visible = true;
                    hdnGrpStartIndex.Value = GrpStartIndex.ToString();
                    hdnGrpEndIndex.Value = GrpEndIndex.ToString();
                    returnCode = investigationBL.GetGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, out grpIOM, out TotalCount);
                    if (returnCode == 0)
                    {
                        GrpLoadTable(grpIOM);
                    }
                    if (GrpStartIndex == 1)
                    {
                        btnGrpNext.Visible = true;
                        btnGrpPrevious.Visible = false;
                        //btnNextTop.Visible = false;
                        //btnPreviousTop.Visible = true;
                    }
                }
            }
        }

        catch (Exception ex)
        {

        }
    }
    protected void btnGrpSearch_Click(object sender, EventArgs e)
    {

        string strTxtInvName;
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            List<InvGroupMaster> lstGroupOM = new List<InvGroupMaster>();
            btnGrpNext.Visible = false;
            // btnNextTop.Visible = false;
            btnGrpPrevious.Visible = false;
            // btnPreviousTop.Visible = false;
            lblMessage.Text = "";
            strTxtInvName = txtGroupName.Text;
            GrpStartIndex = 1;
            GrpEndIndex = PageSize;
            hdnGrpStartIndex.Value = GrpStartIndex.ToString();
            hdnGrpEndIndex.Value = GrpEndIndex.ToString();
            returnCode = investigationBL.SearchGrpRefRangeForMDM(OrgID, GrpStartIndex, GrpEndIndex, strTxtInvName, out lstGroupOM, out TotalSerachCount);
            if (returnCode == 0)
            {
                hdnSearchGrpTotalCount.Value = TotalSerachCount.ToString();
                if (TotalSerachCount > GrpEndIndex)
                {
                    btnGrpNext.Visible = true;
                    // btnNextTop.Visible = true;
                }
                else
                {
                    btnGrpNext.Visible = false;
                    //btnNextTop.Visible = false;
                    btnGrpPrevious.Visible = false;
                    //btnPreviousTop.Visible = false;
                }
                GrpLoadTable(lstGroupOM);
            }
        }
        catch (Exception ex)
        {
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Searching Reference Range and related Details.", ex);
        }

    }
    protected void btnGrpCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void rdbInvestigaion_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            Inves.Attributes.Add("Style", "Display:Block");
            Inv.Attributes.Add("Style", "Display:table-row");
            pnlSerch.Attributes.Add("Style", "Display:Block");
            Grp.Attributes.Add("Style", "Display:None");
            pnlGrpSearch.Attributes.Add("Style", "Display:None");
            InvLoad();
        }
        catch (Exception ex)
        {
        }
    }


    // Code added for XML conversion -  begin

    public void RaiseCallbackEvent(String eventArgument)
    {
        rawData = eventArgument;

        ConvertRawData(rawData, out xmlContent);

    }

    public void ConvertRawData(string rawdata, out string xmlContent)
    {
        xmlContent = string.Empty;

        char[] CatagoryAgedelimiter = { '|' };
        string[] CatagoryAgeMain = rawdata.Split('|');
        //Age
        if (CatagoryAgeMain[1].ToString() == "Age")
        {
            Array CatagoryAgeMainarr = CatagoryAgeMain[1].Split('|');
            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');

            using (var sw = new StringWriter())
            {
                using (var xw = XmlWriter.Create(sw))
                {

                    xw.WriteStartDocument();
                    xw.WriteStartElement("referenceranges");
                    xw.WriteStartElement("referencerange");
                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                    {

                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                        xw.WriteStartElement("property");
                        xw.WriteAttributeString("type", "age");
                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        xw.WriteAttributeString("mode", CatagoryAgeSubarrAge.GetValue(3).ToString());


                        if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lst")
                        {
                            xw.WriteStartElement("lst");
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lsq")
                        {
                            xw.WriteStartElement("lsq");
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "eql")
                        {
                            xw.WriteStartElement("eql");
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grt")
                        {
                            xw.WriteStartElement("grt");
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grq")
                        {
                            xw.WriteStartElement("grq");
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "btw")
                        {
                            xw.WriteStartElement("btw");
                        }

                        if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "lst")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());


                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "lsq")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "eql")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "grt")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "grq")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "btw")
                        {
                            xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                        }
                        xw.WriteString(CatagoryAgeSubarrAge.GetValue(2).ToString());
                        xw.WriteEndElement();
                        xw.WriteEndElement();
                    }
                    xw.WriteEndElement();
                    xw.WriteEndElement();

                    xw.WriteEndDocument();
                    xw.Close();
                }
                xmlContent = sw.ToString();
            }

        }
        //Common
        if (CatagoryAgeMain[1].ToString() == "Common")
        {
            Array CatagoryAgeMainarr = CatagoryAgeMain[1].Split('|');
            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
            using (var sw = new StringWriter())
            {
                using (var xw = XmlWriter.Create(sw))
                {
                    xw.WriteStartDocument();
                    xw.WriteStartElement("referenceranges");
                    xw.WriteStartElement("referencerange");
                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                    {

                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                        xw.WriteStartElement("property");
                        xw.WriteAttributeString("type", "common");
                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());

                        if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lst")
                        {
                            xw.WriteStartElement("lst");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lsq")
                        {
                            xw.WriteStartElement("lsq");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "eql")
                        {
                            xw.WriteStartElement("eql");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grt")
                        {
                            xw.WriteStartElement("grt");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grq")
                        {
                            xw.WriteStartElement("grq");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "btw")
                        {
                            xw.WriteStartElement("btw");
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        }
                        xw.WriteString(CatagoryAgeSubarrAge.GetValue(2).ToString());
                        xw.WriteEndElement();
                        xw.WriteEndElement();
                    }
                    xw.WriteEndElement();
                    xw.WriteEndElement();
                    xw.WriteEndDocument();
                    xw.Close();
                }
                xmlContent = sw.ToString();
            }
        }
        //Other
        if (CatagoryAgeMain[1].ToString() == "Other")
        {

            Array CatagoryAgeMainarr = CatagoryAgeMain[1].Split('|');
            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
            using (var sw = new StringWriter())
            {
                using (var xw = XmlWriter.Create(sw))
                {
                    xw.WriteStartDocument();
                    xw.WriteStartElement("referenceranges");
                    xw.WriteStartElement("referencerange");
                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                    {
                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                        xw.WriteStartElement("property");
                        xw.WriteAttributeString("type", "other");
                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                        xw.WriteAttributeString("ResultType", CatagoryAgeSubarrAge.GetValue(5).ToString());

                        if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lst")
                        {
                            xw.WriteStartElement("lst");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                            

                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lsq")
                        {
                            xw.WriteStartElement("lsq");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());

                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "eql")
                        {
                            xw.WriteStartElement("eql");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());

                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grt")
                        {
                            xw.WriteStartElement("grt");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());

                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grq")
                        {
                            xw.WriteStartElement("grq");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());

                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "btw")
                        {
                            xw.WriteStartElement("btw");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                        }
                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "")
                        {
                            xw.WriteStartElement("txt");
                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                        }
                        xw.WriteString(CatagoryAgeSubarrAge.GetValue(1).ToString());
                        xw.WriteEndElement();
                        xw.WriteEndElement();
                    }
                    xw.WriteEndElement();
                    xw.WriteEndElement();
                    xw.WriteEndDocument();
                    xw.Close();
                }
                xmlContent = sw.ToString();
            }
        }



    }

    public string GetCallbackResult()
    {
        return xmlContent.ToString();
    }

    public string ConvertOperator(string symbol)
    {
        string ReturnValue = "";
        switch (symbol)
        {
            case "<":
                ReturnValue = "lst";
                break;
            case "<=":
                ReturnValue = "lsq";
                break;
            case "=":
                ReturnValue = "eql";
                break;
            case ">":
                ReturnValue = "grt";
                break;
            case "=>":
                ReturnValue = "grq";
                break;
            case "Between":
                ReturnValue = "btw";
                break;

        }
        return ReturnValue;

    }



    public string ConvertStringOptr(string symbol)
    {
        string ReturnValue = "";
        switch (symbol)
        {
            case "lst":
                ReturnValue = "<";
                break;
            case "lsq":
                ReturnValue = "<=";
                break;
            case "eql":
                ReturnValue = "=";
                break;
            case "grt":
                ReturnValue = ">";
                break;
            case "grq":
                ReturnValue = "=>";
                break;
            case "btw":
                ReturnValue = "Between";
                break;

        }
        return ReturnValue;

    }

    // Code added for XML conversion -  ends
    //code added Reference Range - Print Out - begins
    protected void print_Click(object sender, EventArgs e)
    {  

        try
        {
            returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, 1, 1000, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);

            returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);


            //export to excel
            DataTable dt = gettable(lstIOM, lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, ObjInvDep);
            string prefix = string.Empty;
            prefix = "Investigation_Master_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            var ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, Investigation Report", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {

        try
        {
            returnCode = investigationBL.GetInvRefRangeForMDM(OrgID, 1, 1000, out lstIOM, out lstInvSampleMaster, out lstInvMethod, out lstInvPrinciple, out lstInvKit, out lstInvInstrument, out lstSampleContainer, out lstOrganizationAddress, out TotalCount, out lstProcessingCentres);

            returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);

            var childitem = from saminv in lstIOM
                            where saminv.SampleCode == 0 || saminv.MethodID == 0
                            select saminv;

            //export to excel
            DataTable dt = gettable(childitem.ToList(), lstInvSampleMaster, lstInvMethod, lstInvPrinciple, lstInvKit, lstInvInstrument, lstSampleContainer, ObjInvDep);
            string prefix = string.Empty;
            prefix = "Investigation_Master_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            var ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, Investigation Report", ex);
        }


    }

    public DataTable gettable(List<InvestigationOrgMapping> lst, List<InvSampleMaster> lstInvSampleMaster, List<InvestigationMethod> lstInvMethod, List<InvPrincipleMaster> lstInvPrinciple, List<InvKitMaster> lstInvKit, List<InvInstrumentMaster> lstInvInstrument, List<InvestigationSampleContainer> lstSampleContainer, List<InvDeptMaster> lstDept)
    {
        DataTable dt = new DataTable();
        string ReferenceRange = string.Empty;
        string PanicRange = string.Empty;
		 string RangeType = string.Empty;
        string uom = string.Empty;

        try
        {
            if (lst.Count != 0)
            {
                DataColumn dc1 = new DataColumn("InvestigationID");
                DataColumn dc2 = new DataColumn("InvestigationName");
                DataColumn dc3 = new DataColumn("DisplayText");
                DataColumn dc4 = new DataColumn("ReferenceRange");
                DataColumn dc5 = new DataColumn("UOMCode");
                DataColumn dc6 = new DataColumn("SampleName");
                DataColumn dc7 = new DataColumn("MethodName");
                DataColumn dc8 = new DataColumn("Principle");
                DataColumn dc9 = new DataColumn("Kit");
                DataColumn dc10 = new DataColumn("Instrument");
                DataColumn dc11 = new DataColumn("SampleCon");
                DataColumn dc12 = new DataColumn("ReferenceRangeIntelligence");
                DataColumn dc13 = new DataColumn("Department");
                DataColumn dc15 = new DataColumn("PanicRange");
                DataColumn dc16 = new DataColumn("PanicRangeIntelligence");
                DataColumn dc17 = new DataColumn("ReferenceRangeString");

                dt.Columns.Add(dc1);
                dt.Columns.Add(dc2);
                dt.Columns.Add(dc3);
                dt.Columns.Add(dc4);
                dt.Columns.Add(dc5);
                dt.Columns.Add(dc6);
                dt.Columns.Add(dc7);
                dt.Columns.Add(dc8);
                dt.Columns.Add(dc9);
                dt.Columns.Add(dc10);
                dt.Columns.Add(dc11);
                dt.Columns.Add(dc12);
                dt.Columns.Add(dc13);
                dt.Columns.Add(dc15);
                dt.Columns.Add(dc16);
				dt.Columns.Add(dc17);


                foreach (InvestigationOrgMapping item in lst)
                {
                    DataRow dr = dt.NewRow();

                    dr["InvestigationID"] = item.InvestigationID;
                    dr["InvestigationName"] = item.InvestigationName;
                    dr["DisplayText"] = item.DisplayText;
                    ReferenceRange = string.Empty;
                      if ((item.ReferenceRange) != "")
                    {
                        if (TryParseXml(item.ReferenceRange))
                        {
                            string RType = string.Empty;
                            RType = "referencerange";
                            ConvertXmlToString(item.ReferenceRange, out   ReferenceRange, uom, RType);
                            dr["ReferenceRange"] = ReferenceRange;
                            dr["ReferenceRangeIntelligence"] = "Y";
                        }
                        else
                        {



                            dr["ReferenceRange"] = item.ReferenceRange;
                            dr["ReferenceRangeIntelligence"] = "N";
                        }
                    }
                    dr["ReferenceRangeString"] = item.ReferenceRangeString;
                    dr["UOMCode"] = item.UOMCode;

                    var sample = from n in lstInvSampleMaster
                                 where n.SampleCode == item.SampleCode
                                 select n.SampleDesc;
                    if (sample.Count() == 1)
                    {

                        foreach (var smp in sample)
                        {
						if (smp != null)
                            dr["SampleName"] = smp.ToString();
                        }
                    }

                    else
                    {

                        dr["SampleName"] = item.SampleCode;

                    }

                    var Method = from n in lstInvMethod
                                 where n.MethodID == item.MethodID
                                 select n.MethodName;

                    if (Method.Count() == 1)
                    {

                        foreach (var mtd in Method)
                        {
							 if (mtd != null)
                            dr["MethodName"] = mtd.ToString();
                        }
                    }

                    else
                    {

                        dr["MethodName"] = item.MethodID;

                    }


                    var Principle = from n in lstInvPrinciple
                                    where n.PrincipleID == item.PrincipleID
                                    select n.PrincipleName;

                    if (Principle.Count() == 1)
                    {

                        foreach (var prc in Principle)
                        {
							if (prc != null)
                            dr["Principle"] = prc.ToString();
                        }
                    }

                    else
                    {

                        dr["Principle"] = item.PrincipleID;

                    }


                    var Kit = from n in lstInvKit
                              where n.KitID == item.KitID
                              select n.KitName;

                    if (Kit.Count() == 1)
                    {

                        foreach (var kt in Kit)
                        {
							 if (kt != null)
                            dr["Kit"] = kt.ToString();
                        }
                    }

                    else
                    {

                        dr["Kit"] = item.KitID;

                    }


                    var Instrument = from n in lstInvInstrument
                                     where n.InstrumentID == item.InstrumentID
                                     select n.InstrumentName;

                    if (Instrument.Count() == 1)
                    {

                        foreach (var Ins in Instrument)
                        {
							if (Ins != null)
                            dr["Instrument"] = Ins.ToString();
                        }
                    }

                    else
                    {

                        dr["Instrument"] = item.InstrumentID;

                    }



                    var SampleCon = from n in lstSampleContainer
                                    where n.SampleContainerID == item.SampleContainerID
                                    select n.ContainerName;

                    if (SampleCon.Count() == 1)
                    {

                        foreach (var SCon in SampleCon)
                        {
							if (SCon != null)
                            dr["SampleCon"] = SCon.ToString();
                        }
                    }

                    else
                    {

                        dr["SampleCon"] = item.SampleContainerID;

                    }

                    var InvDepartment = from n in lstDept
                                        where n.DeptID == item.DeptID
                                        select n.DeptName;

                    if (InvDepartment.Count() == 1)
                    {

                        foreach (var InvDept in InvDepartment)
                        {
							if (InvDept != null)
                            dr["Department"] = InvDept.ToString();
                        }
                    }

                    else
                    {

                        dr["Department"] = item.DeptID;

                    }
                    PanicRange = string.Empty;
                    if ((item.PanicRange) != "")
                    {
                        if (TryParseXml(item.PanicRange))
                        {
                            string RType = string.Empty;
                            RType = "panicrange";
                            ConvertXmlToString(item.PanicRange, out   PanicRange, uom, RType);
                            dr["PanicRange"] = PanicRange;

                            dr["PanicRangeIntelligence"] = "Y";
                        }
                        else
                        {



                            dr["PanicRange"] = item.PanicRange;
                            dr["PanicRangeIntelligence"] = "N";
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while converting IOM Datatable", ex);
        }

        return dt;
    }


    public void ConvertXmlToString(string xmlData, out string Range, string uom, string rangeType)
    {
        Range = string.Empty;
        //string Rtype = string.Empty;

        uom = uom == "" ? "" : uom;


        string[] CatagoryAgeMain = xmlData.Split('|');



        XElement xe = XElement.Parse(xmlData);



        var ageRange = from age in xe.Elements(rangeType).Elements("property")
                       where (string)age.Attribute("type") == "age" //&& (string)age.Attribute("value") == pGender && (string)age.Attribute("mode") == pAgetype
                       select age;

        var commonRange = from common in xe.Elements(rangeType).Elements("property")
                          where (string)common.Attribute("type") == "common" //&& (string)common.Attribute("value") == pGender
                          select common;

        var otherRange = from other in xe.Elements(rangeType).Elements("property")
                         where (string)other.Attribute("type") == "other" //&& (string)other.Attribute("value") == pGender
                         select other;

        //------------------------Shobana Changes Starts----------//		 

        var otherRangeText = from other in xe.Elements("Range").Elements("property")
                             where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") != "Both" && (string)other.Attribute("ResultType") == "Text"
                             select other;

        var otherRangeBothText = from other in xe.Elements("Range").Elements("property")
                                 where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == "Both" && (string)other.Attribute("ResultType") == "Text"
                                 select other;
        //------------------------Shobana Changes Ends----------//	

        if (otherRangeText != null)
        {
            foreach (var lst in otherRangeText)
            {
                if (lst.Element("txt") != null)
                {
                    Range += lst.Element("txt").Value + "\n";
                }
            }
        }

        if (otherRangeBothText != null)
        {
            foreach (var lst in otherRangeBothText)
            {
                if (lst.Element("txt") != null)
                {
                    Range += lst.Element("txt").Value + "\n";
                }
            }
        }

        if (ageRange != null)
        {

            foreach (var lst in ageRange)
            {

                if (lst.Element("lst") != null)
                {
                    if (((lst.Element("lst").Attribute("gender")) != null) && ((lst.Element("lst").Attribute("agetype")) != null) && ((lst.Element("lst").FirstAttribute) != null) && ((lst.Element("lst").LastAttribute) != null))


                    {
                        //if (pAgeint < Convert.ToInt32(lst.Element("lst").Value))
                        if (true)
                        {
                            Range += lst.Element("lst").Attribute("gender").Value + ": " + ConvertStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    //if (pAgeint <= Convert.ToInt32(lst.Element("lsq").Value))

                    if (((lst.Element("lsq").Attribute("gender")) != null) && ((lst.Element("lsq").Attribute("agetype")) != null) && ((lst.Element("lsq").FirstAttribute) != null) && ((lst.Element("lsq").LastAttribute) != null))

                    {
                        if (true)
                        {
                            Range += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if (((lst.Element("eql").Attribute("gender")) != null) && ((lst.Element("eql").Attribute("agetype")) != null) && ((lst.Element("eql").FirstAttribute) != null) && ((lst.Element("eql").LastAttribute) != null))


                    {
                        //if (pAgeint == Convert.ToInt32(lst.Element("eql").Value))
                        if (true)
                        {
                            Range += lst.Element("eql").Attribute("gender").Value + ": " + ConvertStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (((lst.Element("grt").Attribute("gender")) != null) && ((lst.Element("grt").Attribute("agetype")) != null) && ((lst.Element("grt").FirstAttribute) != null) && ((lst.Element("grt").LastAttribute) != null))


                    {
                        //if (pAgeint > Convert.ToInt32(lst.Element("grt").Value))
                        if (true)
                        {
                            Range += lst.Element("grt").Attribute("gender").Value + ": " + ConvertStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "\n";
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if (((lst.Element("grq").Attribute("gender")) != null) && ((lst.Element("grq").Attribute("agetype")) != null) && ((lst.Element("grq").FirstAttribute) != null) && ((lst.Element("grq").LastAttribute) != null))


                    {
                        //if (pAgeint >= Convert.ToInt32(lst.Element("grq").Value))
                        if (true)
                        {
                            Range += lst.Element("grq").Attribute("gender").Value + ": " + ConvertStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    string[] between = lst.Element("btw").Value.Split('-');
                    //if (pAgeint >= Convert.ToDecimal(between[0]) && pAgeint <= Convert.ToDecimal(between[1]))
                    if (((lst.Element("btw").Attribute("gender")) != null) && ((lst.Element("btw").Attribute("agetype")) != null) && ((lst.Element("btw").FirstAttribute) != null) && ((lst.Element("btw").LastAttribute) != null))

                    {
                        if (true)
                        {
                            Range += lst.Element("btw").Attribute("gender").Value + ": " + ConvertStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + AddSpace(lst.Element("btw").LastAttribute.Value) + "\n";
                        }
                    }
                }
            }
        }

        if (commonRange != null)
        {

            foreach (var lst in commonRange)
            {
                if (lst.Element("lst") != null)
                {
                    if ((lst.Element("lst").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("lst").FirstAttribute.Value + ": < " + lst.Element("lst").Value + "\n";
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    if ((lst.Element("lsq").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("lsq").FirstAttribute.Value + ": <= " + lst.Element("lsq").Value + "\n";
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if ((lst.Element("eql").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("eql").FirstAttribute.Value + ": = " + lst.Element("eql").Value + "\n";
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if ((lst.Element("grt").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("grt").FirstAttribute.Value + ": > " + lst.Element("grt").Value + "\n";
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if ((lst.Element("grq").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("grq").FirstAttribute.Value + ": => " + lst.Element("grq").Value + "\n";
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    if ((lst.Element("btw").FirstAttribute) != null)
                    {
                        if (true)
                        {
                            Range += lst.Element("btw").FirstAttribute.Value + ": " + AddSpace(lst.Element("btw").Value) + "\n";
                        }
                    }
                }
            }
        }

        if (otherRange != null)
        {

            foreach (var lst in otherRange)
            {

                if (lst.Element("lst") != null)
                {
                    if (((lst.Element("lst").FirstAttribute) != null) && ((lst.Element("lst").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("lst").FirstAttribute.Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").LastAttribute.Value + "\n";
                        }
                    }

                }
                if (lst.Element("lsq") != null)
                {
                    if (((lst.Element("lsq").FirstAttribute) != null) && ((lst.Element("lsq").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("lsq").FirstAttribute.Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if (((lst.Element("eql").FirstAttribute) != null) && ((lst.Element("eql").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("eql").FirstAttribute.Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").LastAttribute.Value + "\n";
                        }

                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (((lst.Element("grt").FirstAttribute) != null) && ((lst.Element("grt").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("grt").FirstAttribute.Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").LastAttribute.Value + "\n";
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if (((lst.Element("grq").FirstAttribute) != null) && ((lst.Element("grq").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("grq").FirstAttribute.Value + ": " + lst.Element("grq").Value + ": >= " + lst.Element("grq").LastAttribute.Value + "\n";
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    if (((lst.Element("btw").FirstAttribute) != null) && ((lst.Element("btw").FirstAttribute) != null))
                    {
                        if (true)
                        {
                            Range += lst.Element("btw").FirstAttribute.Value + ": " + lst.Element("btw").Value + ": " + AddSpace(lst.Element("btw").LastAttribute.Value) + "\n";
                        }
                    }
                }
            }
        }


        if (Range == "")

        {
            XElement xer = XElement.Parse(xmlData);

            if (xe.Elements(rangeType).Elements("property") != null)
            {
                Range = "NIL";

            }
            else
            {
                Range = xmlData;

            }
        }
    }

    bool TryParseXml(string xml)
    {
        try
        {
            XElement xe = XElement.Parse(xml);
            return true;
        }
        catch (XmlException e)
        {
            return false;
        }
    }

    string AddSpace(string text)
    {
        string[] rawText = text.Split('-');
        string spacedText = string.Empty;
        if (rawText.Count() == 2)
        {
            spacedText = rawText[0] + " - " + rawText[1];

        }
        return spacedText;

    }

    protected void hBtnUpload_Click(object sender, EventArgs e)
    {
        string strInv23 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_50 == null ? "Excel Uploaded Successfully...!" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_50;
        string strInv24 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_51 == null ? "Please make sure that you have uploaded a excel file" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_51;
        string strInv25 = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_52 == null ? "Error While Loading Reference Range and related Details" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_52;


        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        List<InvestigationOrgMapping> lstRefRangeXML = new List<InvestigationOrgMapping>();
        if (FileUpload1.HasFile && Path.GetExtension(FileUpload1.PostedFile.FileName) == ".xlsx")
        {
            try
            {
                var file = new FileInfo(FileUpload1.PostedFile.FileName);
                using (var excel = new ExcelPackage(FileUpload1.PostedFile.InputStream))
                {
                    for (int l = 1; l <= excel.Workbook.Worksheets.Count; l++)
                    {
                        var ws = excel.Workbook.Worksheets[l];
                        string Name = excel.Workbook.Worksheets[l].Name;
                        if (ws.Dimension != null)
                        {
                            var tbl = new DataTable();
                            var hasHeader = true;
                            if (l >= 1)
                            {
                                // add DataColumns to DataTable
                                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                                    tbl.Columns.Add(hasHeader ? firstRowCell.Text
                                        : String.Format("Column {0}", firstRowCell.Start.Column));

                            }
                            // add DataRows to DataTable
                            int startRow = hasHeader ? 2 : 1;
                            for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                            {
                                var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                                DataRow row = tbl.NewRow();
                                foreach (var cell in wsRow)
                                    row[cell.Start.Column - 1] = char.ToUpper(cell.Text[0]) + cell.Text.Substring(1);
                                tbl.Rows.Add(row);
                            }
                            for (int j = 0; j < tbl.Rows.Count; j++)
                            {
                                string con = string.Empty;
                                for (int i = 0; i <= tbl.Columns.Count; i++)
                                {
                                    if (con == "")
                                    {
                                        con = tbl.Rows[j][i].ToString() + "/";
                                    }
                                    else
                                    {
                                        if (i == tbl.Columns.Count)
                                        {
                                            if (Name == "Age")
                                            {
                                                con = con + "^|Age";
                                            }
                                            if (Name == "Other")
                                            {
                                                con = con + "^|Other";
                                            }
                                            else if (Name == "Common")
                                            {
                                                con = con + "^|Common";
                                            }
                                        }
                                        else if ((tbl.Rows[j][i].ToString()) == "Between")
                                        {
                                            con = con + "~" + tbl.Rows[j][i].ToString();
                                            i++;
                                            con = con + "~" + tbl.Rows[j][i].ToString();
                                            i++;
                                            con = con + "-" + tbl.Rows[j][i].ToString();
                                        }
                                        else
                                        {
                                            con = con + "~" + tbl.Rows[j][i].ToString();
                                        }
                                    }
                                }
                                string[] SplitResult = con.Split('/');
                                string InvgId = SplitResult[0];
                                string fs = string.Empty;
                                string dataxl = string.Empty;
                                int k = 0;
                                dataxl = SplitResult[1].ToString();
                                if (dataxl.Contains("~~"))
                                {
                                    fs = dataxl.Replace("~~", "~");
                                    dataxl = fs;
                                    
                                }
                                if (dataxl.Contains("~^"))
                                {
                                    fs = dataxl.Replace("~^", "^");
                                    dataxl = fs;
                                }
                                dataxl = dataxl.Remove(0, 1);
                                ConvertRawData(dataxl, out xmlContent);
                                string xmlForm = xmlContent;

                                InvestigationOrgMapping objRR = new InvestigationOrgMapping();
                                objRR.InvestigationID = Convert.ToInt64(InvgId);
                                objRR.ReferenceRange = xmlContent;
                                lstRefRangeXML.Add(objRR);
                            }
                        }
                    }
                }
                returnCode = investigationBL.InsertReferenceRangeXML(lstRefRangeXML, OrgID);
                InvLoad();
                lblMessage.Text = "";
                //lblMessage.Text = "Excel Uploaded Successfully...!";
                lblMessage.Text = strInv23;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "";
                //lblMessage.Text = "Error While Loading Reference Range and related Details" + ex;
                lblMessage.Text = strInv25 + ex;
            }
        }
        else
        {
            lblMessage.Text = "";
            //lblMessage.Text = "Please make sure that you have uploaded a excel file";
            lblMessage.Text = strInv24;
        }
    }

}
