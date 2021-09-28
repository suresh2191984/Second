using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_PackageProfileControl : BaseControl
{
    long visitID = -1;

    Investigation_BL investigationBL;
    List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
    List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
    List<InvPackageMapping> lstPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstSpeciality = new List<Speciality>();
    List<ProcedureMaster> lstProcedures = new List<ProcedureMaster>();

    List<InvPackageMapping> lstCollectedPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
    List<ProcedureMaster> lstCollectedProcedures = new List<ProcedureMaster>();

    List<PatientInvestigation> lstgroupsIC = new List<PatientInvestigation>();
    List<PatientInvestigation> lstInvestigationsIC = new List<PatientInvestigation>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    PatientVisit_BL patientvisitBL;
    List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
    IP_BL ipBL;
    protected int useClientID = 0;
    public int UseClientID
    {
        get { return useClientID; }
        set { useClientID = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        investigationBL = new Investigation_BL(base.ContextInfo);
        patientvisitBL = new PatientVisit_BL(base.ContextInfo);
        ((HiddenField)InvestigationControl1.FindControl("ISAddItems")).Value = "";

        if (!IsPostBack)
        {
            LoadPackageData();
            //Int64.TryParse(Request.QueryString["vid"], out visitID);
            //ipBL.GetIPVisitDetails(visitID, out lstPatientVisit);
            //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].ClientID), "GRP", out lstgroupsIC);
            //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].ClientID), "INV", out lstInvestigationsIC);

            //////investigationBL.GetClientInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstGroups, out lstInvestigations, visitID);
            ////new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), out lstGroups, out lstInvestigations);
            ////int orgBased = 0;
            ////InvestigationControl1.OrgSpecific = orgBased;
            //InvestigationControl1.LoadLabData(lstgroupsIC, lstInvestigationsIC);
            LoadSpecialityName();
            Hdn.Value = String.Empty;
            Hdnfld.Value = String.Empty;
            GetProcedureData();
            List<InvGroupMaster> lstgroupsIC = new List<InvGroupMaster>();
            List<InvestigationMaster> lstInvestigationsIC = new List<InvestigationMaster>();
            new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroupsIC, out lstInvestigationsIC);
            int orgBased = OrgID;
            InvestigationControl1.OrgSpecific = orgBased;
            InvestigationControl1.LoadDatas(lstgroupsIC, lstInvestigationsIC);
        }
        //else
        //{
        //    LoadPackageData();
        //}
    }
    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);
        listSpeciality.DataSource = lstSpeciality;
        listSpeciality.DataTextField = "SpecialityName";
        listSpeciality.DataValueField = "SpecialityID";
        listSpeciality.DataBind();

    }
    public void GetProcedureData()
    {
        long returnCode = -1;
        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);
        listProcedure.DataSource = lstProceduremaster;
        listProcedure.DataTextField = "ProcedureName";
        listProcedure.DataValueField = "ProcedureID";
        listProcedure.DataBind();
    }
    //public void LoadPackageData(List<InvGroupMaster> lstPackages)
    public void LoadPackageData()
    {
        int pkgid = 0;
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        // Int64.TryParse(Request.QueryString["tid"], out taskID);
        List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
        List<OrderedInvestigations> oInvestigations = new List<OrderedInvestigations>();
        if (UseClientID == 0)
        {
            investigationBL.GetHealthPackageData(OrgID,pkgid, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        }
        else
        {
            investigationBL.GetHealthPackageDataWithClientID(OrgID,UseClientID, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        }

        //var Packages = from packageName in lstPackages
        //               where packageName.Type == "PKG"
        //               select packageName;
        //List<InvGroupMaster> lstPackagesTemp = Packages.ToList<InvGroupMaster>();
        new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, visitID, out lstOrderedInves, out oInvestigations);
        
        if (lstGeneralHealthCheckUpMaster.Count > 0)
        {
            listHealthCheckup.DataSource = lstGeneralHealthCheckUpMaster;
            listHealthCheckup.DataTextField = "GeneralHealthCheckUpName";
            listHealthCheckup.DataValueField = "GeneralHealthCheckUpID";
            listHealthCheckup.DataBind();
        }

        if (lstPackages.Count > 0)
        {
            healthPackagesTab.Controls.Clear();
            healthPackagesContentTab.Controls.Clear();
            TableRow rowHeader = new TableRow();
            TableCell cellHeader = new TableCell();
            cellHeader.Attributes.Add("align", "center");
            cellHeader.Text = "<b>" + "Health Packages" + "</b>";
            cellHeader.Font.Bold = true;
            cellHeader.CssClass = "Duecolor";
            //cellHeader.Style.Add("background-color", "#");
            //cellHeader.Style.Add("color", "#FFFFFF");
            rowHeader.Cells.Add(cellHeader);
            healthPackagesTab.Rows.Add(rowHeader);
            foreach (InvGroupMaster objGM in lstPackages)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                CheckBox chkPKG = new CheckBox();
                
                chkPKG.ID = "chk" + objGM.GroupID.ToString();
                chkPKG.Text = "<b>" + objGM.GroupName + "</b>";
                string SvAL = "";
                if (UseClientID == 0)
                {
                    SvAL = objGM.GroupID.ToString().Trim() + "~" + (objGM.GroupName.Split('-')[0]);// + "~" + (((objGM.GroupName.Split('-')[1]).Replace(CurrencyName, "")).Split(':')[1].Trim());// "-Rs: 3250.00";
                }
                else
                {
                    SvAL = objGM.GroupID.ToString().Trim() + "~" + (objGM.GroupName.Split('-')[0]) + "~" + (((objGM.GroupName.Split('-')[1]).Replace(CurrencyName, "")).Split(':')[1].Trim());// "-Rs: 3250.00";
                }

                chkPKG.Attributes.Add("onclick", "javascript:showHidePKGContent(" + objGM.GroupID.ToString() + ");showHideAddedItems('" + chkPKG.ClientID + "','" + SvAL + "');");
                if (oInvestigations.Count > 0)
                {
                    foreach (var o in oInvestigations)
                    {
                        if (o.InvestigationID == objGM.AttGroupID)
                        {
                            chkPKG.Checked = true;
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), o.InvestigationID.ToString(), "javascript:showHidePKGContent(" + objGM.GroupID.ToString() + ");showHideAddedItems('" + chkPKG.ClientID + "');", true);
                        }
                    }
                }
                cell.Attributes.Add("align", "left");
                cell.Controls.Add(chkPKG);
                row.Cells.Add(cell);
                healthPackagesTab.Rows.Add(row);
                //Package Content
                TableRow rowContentHeader = new TableRow();
                TableCell cellContentHeader = new TableCell();
                rowContentHeader.ID = "rowHeader" + objGM.GroupID.ToString();
                rowContentHeader.Style.Add("display", "none");
                cellContentHeader.Attributes.Add("align", "center");
                cellContentHeader.CssClass = "Duecolor";
                //cellContentHeader.Style.Add("background-color", "#");
                //cellContentHeader.Style.Add("color", "#FFFFFF");
                cellContentHeader.Style.Add("height", "20px");
                cellContentHeader.Text = "<b>" + objGM.GroupName + "</b>";
                rowContentHeader.Cells.Add(cellContentHeader);
                healthPackagesContentTab.Rows.Add(rowContentHeader);
                TableRow rowContent = new TableRow();
                rowContent.ID = "rowContent" + objGM.GroupID.ToString();
                rowContent.Style.Add("display", "none");
                TableCell cellContent = new TableCell();
                cellContent.CssClass = "dataheaderInvCtrl";
                //CheckBox chk = new CheckBox();
                //chk.ID = "chk" + objGM.GroupID.ToString();
                //chk.Text = "<b>" + objGM.GroupName + "</b>";
                //cellContent.Attributes.Add("align", "left");
                //cellContent.Controls.Add(chk);
                //   rowContent.Cells.Add(cellContent);
                Table innerContentTab = new Table();
                //  innerContentTab.Rows.Add(rowContent);
                var mappingList = from pkgMapp in lstPackageMapping
                                  where pkgMapp.PackageID == objGM.GroupID
                                  select pkgMapp;
                List<InvPackageMapping> lstpkgMappTemp = mappingList.ToList<InvPackageMapping>();
                if (lstpkgMappTemp.Count > 0)
                {
                    foreach (InvPackageMapping objPKGMapp in lstpkgMappTemp)
                    {
                        TableRow rowinnerContent = new TableRow();
                        TableCell cellinnerContent = new TableCell();
                        Table innerContentTab1 = new Table();
                        var invList = from inv in lstPackageContents
                                      where inv.PackageID == objGM.GroupID && inv.InvestigationID == objPKGMapp.ID && inv.Type == objPKGMapp.Type && objPKGMapp.Type == "INV"
                                      select inv;
                        List<PatientInvestigation> lstPI1 = invList.ToList<PatientInvestigation>();
                        if (lstPI1.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Investigations";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI1 in lstPI1)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI1.InvestigationName + "</b>" + " (Investigation)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI1.InvestigationID.ToString() + ");");
                                chk.ID = "chk" + objPI1.InvestigationID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI1.InvestigationName + "</b>" + " (Investigation)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var grpList = from grp in lstPackageContents
                                      where grp.PackageID == objGM.GroupID && grp.GroupID == objPKGMapp.ID && grp.Type == objPKGMapp.Type && objPKGMapp.Type == "GRP"
                                      select grp;
                        List<PatientInvestigation> lstPI2 = grpList.ToList<PatientInvestigation>();
                        if (lstPI2.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Groups";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI2 in lstPI2)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI2.GroupName + "</b>" + " (Group)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI2.GroupID.ToString() + ");");
                                chk.ID = "chk" + objPI2.GroupID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI2.GroupName + "</b>" + " (Group)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var spList = from sp in lstPackageContents
                                     where sp.PackageID == objGM.GroupID && sp.InvestigationID == objPKGMapp.ID && sp.Type == objPKGMapp.Type && objPKGMapp.Type == "CON"
                                     select sp;
                        List<PatientInvestigation> lstPI3 = spList.ToList<PatientInvestigation>();
                        if (lstPI3.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Consultations";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI3 in lstPI3)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI3.InvestigationName + "</b>" + " (Consultation)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI3.InvestigationID.ToString() + ");");
                                chk.ID = "chk" + objPI3.InvestigationID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI3.InvestigationName + "</b>" + " (Consultation)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var proList = from pro in lstPackageContents
                                      where pro.PackageID == objGM.GroupID && pro.InvestigationID == objPKGMapp.ID && pro.Type == objPKGMapp.Type && objPKGMapp.Type == "PRO"
                                      select pro;
                        List<PatientInvestigation> lstPI4 = proList.ToList<PatientInvestigation>();
                        if (lstPI4.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Procedures";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI4 in lstPI4)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI4.InvestigationName + "</b>" + " (Procedure)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI4.InvestigationID.ToString() + ");");
                                chk.ID = "chk" + objPI4.InvestigationID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI4.InvestigationName + "</b>" + " (Procedure)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }


                        var GHCList = from ghc in lstPackageContents
                                      where ghc.PackageID == objGM.GroupID && ghc.InvestigationID == objPKGMapp.ID && ghc.Type == objPKGMapp.Type && objPKGMapp.Type == "GHC"
                                      select ghc;
                        List<PatientInvestigation> lstPI5 = GHCList.ToList<PatientInvestigation>();
                        if (lstPI5.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Procedures";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI5 in lstPI5)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI5.InvestigationName + "</b>" + " (Health Checkup)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI5.InvestigationID.ToString() + ");");
                                chk.ID = "chk" + objPI5.InvestigationID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI5.InvestigationName + "</b>" + " (Health Checkup)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        cellinnerContent.Controls.Add(innerContentTab1);
                        rowinnerContent.Cells.Add(cellinnerContent);
                        innerContentTab.Rows.Add(rowinnerContent);
                    }
                }
                //TableRow rowinnerContentLink = new TableRow();
                //TableCell cellinnerContentLink = new TableCell();
                //HyperLink hypinnerContentLink = new HyperLink();
                //hypinnerContentLink.ID = "hyp" + objGM.GroupID.ToString();
                //hypinnerContentLink.Text = "<b><u>Add More..</u></b>";
                //cellinnerContentLink.Controls.Add(hypinnerContentLink);
                //rowinnerContentLink.Cells.Add(cellinnerContentLink);
                //healthPackagesContentTab.Rows.Add(rowinnerContentLink);        
                cellContent.Controls.Add(innerContentTab);
                HyperLink hypinnerContentLink = new HyperLink();
                hypinnerContentLink.ID = "hyp" + objGM.GroupID.ToString();
                hypinnerContentLink.CssClass = "colorpacks";
                hypinnerContentLink.Text = "<b><u>Add More..</u></b>";
                hypinnerContentLink.Attributes.Add("onclick", "javascript:showHideSwapBlock(" + objGM.GroupID.ToString() + ");");
                cellContent.Controls.Add(hypinnerContentLink);
                Table tblAddedSpeciality = new Table();
                tblAddedSpeciality.ID = "tblAddedSpecialityItems" + objGM.GroupID.ToString();
                tblAddedSpeciality.CellPadding = 3;
                cellContent.Controls.Add(tblAddedSpeciality);
                Table tblAddedProcedure = new Table();
                tblAddedProcedure.ID = "tblAddedProcedureItems" + objGM.GroupID.ToString();
                tblAddedProcedure.CellPadding = 3;
                cellContent.Controls.Add(tblAddedProcedure);
                Table tblAddedInvGRP = new Table();
                tblAddedInvGRP.ID = "tblOrderedInvesAddedTemp" + objGM.GroupID.ToString();
                tblAddedInvGRP.CellPadding = 3;
                cellContent.Controls.Add(tblAddedInvGRP);
                Table tblAddedHealthPKG = new Table();
                tblAddedHealthPKG.ID = "tblAddedHealthCheckupItems" + objGM.GroupID.ToString();
                tblAddedHealthPKG.CellPadding = 3;
                cellContent.Controls.Add(tblAddedHealthPKG);
                HiddenField hdnAddedSpeciality = new HiddenField();
                hdnAddedSpeciality.ID = "hdnAddedSpecialityItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedSpeciality);
                HiddenField hdnAddedProcedure = new HiddenField();
                hdnAddedProcedure.ID = "hdnAddedProcedureItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedProcedure);
                HiddenField hdnAddedInvGRP = new HiddenField();
                hdnAddedInvGRP.ID = "hdnAddedInvGRP" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedInvGRP);
                HiddenField hdnAddedHealthPKG = new HiddenField();
                hdnAddedHealthPKG.ID = "hdnAddedHealthCheckupItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedHealthPKG);
                CheckBox chkDft = new CheckBox();
                chkDft.ID = "chkDefault" + objGM.GroupID.ToString();
                //chkDft.Style.Add("color", "#");
                chkDft.CssClass = "colorsample";
                chkDft.Text = "<b>Set as Default Items to " + objGM.GroupName + "</b>";
                //chkDft.Style.Add("display", "none");
                chkDft.Attributes.Add("onclick", "javascript:setDefaultPKG();");
                cellContent.Controls.Add(chkDft);
                rowContent.Cells.Add(cellContent);
                healthPackagesContentTab.Rows.Add(rowContent);
                hdntotalFinalPKG.Value += objGM.GroupID.ToString() + "~";
            }
        }
        

    }

    public void CollectPackageContent(out List<InvGroupMaster> lstPackagesTemp, out List<InvPackageMapping> lstCollectedDefaultPackageMapping, out List<InvPackageMapping> lstCollectedPackageMapping, out List<Speciality> lstCollectedSpeciality, out List<ProcedureMaster> lstCollectedProcedures, out List<InvPackageMapping> lstDeletedPackageMapping, out List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster)
    {
        int success = 0;
        int pkgid = 0;
        lstCollectedPackageMapping = new List<InvPackageMapping>();
        lstCollectedSpeciality = new List<Speciality>();
        lstCollectedProcedures = new List<ProcedureMaster>();
        lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
        lstDeletedPackageMapping = new List<InvPackageMapping>();
        lstPackagesTemp = new List<InvGroupMaster>();
        lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
        investigationBL.GetHealthPackageData(OrgID,pkgid, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        if (Hdnfld.Value != "")
        {
            foreach (string value in Hdnfld.Value.Split('^'))
            {
                if (value != "")
                {
                    InvPackageMapping obj = new InvPackageMapping();
                    obj.ID = Convert.ToInt64(value);
                    lstDeletedPackageMapping.Add(obj);
                }
            }
        }
        else if (Hdn.Value != "")
        {
            foreach (string value in Hdn.Value.Split('^'))
            {
                if (value != "")
                {
                    InvPackageMapping obj = new InvPackageMapping();
                    obj.ID = Convert.ToInt64(value);
                    lstDeletedPackageMapping.Add(obj);
                }
            }
        }
        foreach (string pkgID in hdntotalFinalPKG.Value.Split('~'))
        {
            if (pkgID != "")
            {
                foreach (InvGroupMaster objGMTemp in lstPackages)
                {
                    foreach (string pkgIDTemp in setOrderedPKG.Value.Split('~'))
                    {
                        if (pkgIDTemp != "")
                        {
                            if (Convert.ToInt32(pkgIDTemp) == objGMTemp.OrgGroupID)
                            {
                                foreach (string pkgIDTemp1 in setOrderedPKGTemp.Value.Split('~'))
                                {
                                    if (pkgIDTemp1 != "" && pkgIDTemp == pkgIDTemp1)
                                    {
                                        success = 1;
                                    }
                                }
                                if (success == 0)
                                {
                                    setOrderedPKGTemp.Value += pkgIDTemp + "~";
                                    lstPackagesTemp.Add(objGMTemp);
                                    var invPMList = from invPM in lstPackageMapping
                                                    where invPM.PackageID == Convert.ToInt32(pkgIDTemp) && invPM.Type == "CON"
                                                    select invPM;
                                    List<InvPackageMapping> lstPI1 = invPMList.ToList<InvPackageMapping>();
                                    foreach (InvPackageMapping objPMTTT in lstPI1)
                                    {
                                        Speciality objCollectedSpeciality = new Speciality();
                                        objCollectedSpeciality.SpecialityID = Convert.ToInt32(objPMTTT.ID);
                                        objCollectedSpeciality.SpecialityName = "";
                                        lstCollectedSpeciality.Add(objCollectedSpeciality);
                                    }
                                }

                                var invGHList = from invPM in lstPackageMapping
                                                where invPM.PackageID == Convert.ToInt32(pkgIDTemp) && invPM.Type == "GHC"
                                                select invPM;
                                List<InvPackageMapping> lstPI2 = invGHList.ToList<InvPackageMapping>();
                                foreach (InvPackageMapping objGHTTT in lstPI2)
                                {
                                    GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(objGHTTT.ID);
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = "";
                                    lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                                }
                               
                            }
                        }
                    }
                }



                //          alert(document.getElementById('PackageProfileControl_collectedFinalSpeciality').value);
                //          alert(document.getElementById('PackageProfileControl_collectedFinalProcedure').value);
                foreach (string pkgID1 in collectedFinalINVGRP.Value.Split(':'))
                {
                    if (pkgID1 != "")
                    {
                        string[] items1 = pkgID1.Split('$');
                        if (items1[0] == pkgID)
                        {
                            foreach (string innerItems1 in items1[1].Split('^'))
                            {
                                if (innerItems1 != "")
                                {
                                    string[] innerSubItems1 = innerItems1.Split('~');
                                    InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                    objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                    objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems1[0]);
                                    objCollectedINVGRP.Type = innerSubItems1[2];
                                    lstCollectedPackageMapping.Add(objCollectedINVGRP);
                                }
                            }
                        }
                    }
                }


                foreach (string pkgID2 in collectedFinalSpeciality.Value.Split(':'))
                {
                    if (pkgID2 != "")
                    {
                        string[] items2 = pkgID2.Split('-');
                        if (items2[0] == pkgID)
                        {
                            foreach (string innerItems2 in items2[1].Split('^'))
                            {
                                if (innerItems2 != "")
                                {
                                    string[] innerSubItems2 = innerItems2.Split('~');
                                    Speciality objCollectedSpeciality = new Speciality();
                                    objCollectedSpeciality.SpecialityID = Convert.ToInt32(innerSubItems2[1]);
                                    objCollectedSpeciality.SpecialityName = innerSubItems2[2];
                                    lstCollectedSpeciality.Add(objCollectedSpeciality);
                                }
                            }
                        }
                    }
                }



                foreach (string pkgID3 in collectedFinalProcedure.Value.Split(':'))
                {
                    if (pkgID3 != "")
                    {
                        string[] items3 = pkgID3.Split('-');
                        if (items3[0] == pkgID)
                        {
                            foreach (string innerItems3 in items3[1].Split('^'))
                            {
                                if (innerItems3 != "")
                                {
                                    string[] innerSubItems3 = innerItems3.Split('~');
                                    ProcedureMaster objCollectedProcedure = new ProcedureMaster();
                                    objCollectedProcedure.ProcedureID = Convert.ToInt32(innerSubItems3[1]);
                                    objCollectedProcedure.ProcedureName = innerSubItems3[2];
                                    lstCollectedProcedures.Add(objCollectedProcedure);
                                }
                            }
                        }
                    }
                }

                foreach (string pkgID4 in collectedFinalHealthCheckUp.Value.Split(':'))
                {
                    if (pkgID4 != "")
                    {
                        string[] items3 = pkgID4.Split('-');
                        if (items3[0] == pkgID)
                        {
                            foreach (string innerItems3 in items3[1].Split('^'))
                            {
                                if (innerItems3 != "")
                                {
                                    string[] innerSubItems3 = innerItems3.Split('~');
                                    GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(innerSubItems3[1]);
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = innerSubItems3[2];
                                    lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                                }
                            }
                        }
                    }
                }

                //To set as default PKG Mapping
                foreach (string pkgIDsetDefault in setDefaultPKG.Value.Split('~'))
                {
                    if (pkgIDsetDefault != "" && pkgIDsetDefault == pkgID)
                    {
                        //          alert(document.getElementById('PackageProfileControl_collectedFinalSpeciality').value);
                        //          alert(document.getElementById('PackageProfileControl_collectedFinalProcedure').value);
                        foreach (string pkgID1 in collectedFinalINVGRP.Value.Split(':'))
                        {
                            if (pkgID1 != "")
                            {
                                string[] items1 = pkgID1.Split('$');
                                if (items1[0] == pkgID)
                                {
                                    foreach (string innerItems1 in items1[1].Split('^'))
                                    {
                                        if (innerItems1 != "")
                                        {
                                            string[] innerSubItems1 = innerItems1.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems1[0]);
                                            objCollectedINVGRP.Type = innerSubItems1[2];
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }

                        foreach (string pkgID2 in collectedFinalSpeciality.Value.Split(':'))
                        {
                            if (pkgID2 != "")
                            {
                                string[] items2 = pkgID2.Split('-');
                                if (items2[0] == pkgID)
                                {
                                    foreach (string innerItems2 in items2[1].Split('^'))
                                    {
                                        if (innerItems2 != "")
                                        {
                                            string[] innerSubItems2 = innerItems2.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems2[1]);
                                            objCollectedINVGRP.Type = "CON";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);

                                        }
                                    }
                                }
                            }
                        }
                        foreach (string pkgID3 in collectedFinalProcedure.Value.Split(':'))
                        {
                            if (pkgID3 != "")
                            {
                                string[] items3 = pkgID3.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.Type = "PRO";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }

                        foreach (string pkgID4 in collectedFinalHealthCheckUp.Value.Split(':'))
                        {
                            if (pkgID4 != "")
                            {
                                string[] items3 = pkgID4.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.Type = "GHC";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }


            }
        }
    }
}  
