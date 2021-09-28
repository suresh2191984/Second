using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;

public partial class Admin_SurgeryPackage : BasePage 
{
    public string Delete_Msg = Resources.AppMessages.Delete_Message;

    public Admin_SurgeryPackage()
        : base("Admin\\SurgeryPackage.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returncode = -1;
    SurgeryPackageMaster surgery = new SurgeryPackageMaster();
    List<SurgeryPackageMaster> lstSurgery = new List<SurgeryPackageMaster>();
    List<SurgeryPackageDetails> lstSurgeryDtls = new List<SurgeryPackageDetails>();
    List<SurgeryPackageDetails> lstSurgeryMapping = new List<SurgeryPackageDetails>();
    List<SurgeryPackageMaster> lstPackagesTemp = new List<SurgeryPackageMaster>();
    List<SurgeryPackageDetails> lstCollectedDefaultPackageMapping = new List<SurgeryPackageDetails>();
    List<SurgeryPackageDetails> lstCollectedPackageMapping = new List<SurgeryPackageDetails>();
    List<SurgeryPackageDetails> lstDeletedPackageMapping = new List<SurgeryPackageDetails>();
    Investigation_BL investigationBL;
    //List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
    //List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<InvGroupMaster> lstgroupsIC = new List<InvGroupMaster>();    
    List<InvestigationMaster> lstInvestigationsIC = new List<InvestigationMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                loaddata();
                LoadPackageData();                
                LoadList();
                Loadphysician();                
                hdnid.Value = String.Empty;
                txtAmount.Attributes.Add("Style", "text-align:Right");
                txtDays.Attributes.Add("Style", "text-align:Right");
                txtBefore.Attributes.Add("Style", "text-align:Right");
                txtAfter.Attributes.Add("Style", "text-align:Right");
                txtValidity.Attributes.Add("Style", "text-align:Right");
                List<InvGroupMaster> lstgroupsIC = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigationsIC = new List<InvestigationMaster>();
                new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroupsIC, out lstInvestigationsIC);
                int orgBased = OrgID;                
                InvestigationControl1.OrgSpecific = orgBased;
                InvestigationControl1.LoadDatas(lstgroupsIC, lstInvestigationsIC);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in Surgery Page Load", ex);
        }
    }
    public void LoadList()
    {
        try
        {
            List<Speciality> lstSpeciality = new List<Speciality>();
            List<RoomType> lstroom = new List<RoomType>();
            List<Ambulancedetails> lstAmbulancemaster = new List<Ambulancedetails>();
            List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
            List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
            List<IPTreatmentPlanMaster> lstIPTPM = new List<IPTreatmentPlanMaster>();
            new SurgeryPackage_BL(base.ContextInfo).GetDataList(OrgID, out lstRates, out lstSpeciality, out lstAmbulancemaster, out lstProceduremaster, out lstroom, out lstIPTPM);
            if (lstSpeciality.Count > 0)
            {
                listSpeciality.DataSource = lstSpeciality;
                listSpeciality.DataTextField = "SpecialityName";
                listSpeciality.DataValueField = "SpecialityID";
                listSpeciality.DataBind();
            }
            else
            {
                listSpeciality.DataSource = null;
                listSpeciality.DataBind();
            }
            if (lstroom.Count > 0)
            {
                lstRoomType.DataSource = lstroom;
                lstRoomType.DataTextField = "RoomTypeName";
                lstRoomType.DataValueField = "RoomTypeID";
                lstRoomType.DataBind();
            }
            else
            {
                lstRoomType.DataSource = null;
                lstRoomType.DataBind();
            }
            if (lstIPTPM.Count > 0)
            {
                lstSurgeryType.DataSource = lstIPTPM;
                lstSurgeryType.DataTextField = "IPTreatmentPlanName";
                lstSurgeryType.DataValueField = "IPTreatmentPlanID";
                lstSurgeryType.DataBind();
            }
            else
            {
                lstSurgeryType.DataSource = null;
                lstSurgeryType.DataBind();
            }
            if (lstAmbulancemaster.Count > 0)
            {
                lstambulance.DataSource = lstAmbulancemaster;
                lstambulance.DataTextField = "ItemName";
                lstambulance.DataValueField = "ItemId";
                lstambulance.DataBind();
            }
            else
            {
                lstambulance.DataSource = null;
                lstambulance.DataBind();
            }

            if (lstProceduremaster.Count > 0)
            {
                listProcedure.DataSource = lstProceduremaster;
                listProcedure.DataTextField = "ProcedureName";
                listProcedure.DataValueField = "ProcedureID";
                listProcedure.DataBind();
            }
            else
            {
                listProcedure.DataSource = null;
                listProcedure.DataBind();
            }
                       
            
            if (lstRates.Count > 0)
            {
                listHealthCheckup.DataSource = lstRates;
                listHealthCheckup.DataTextField = "DescriptionName";
                listHealthCheckup.DataValueField = "ID";
                listHealthCheckup.DataBind();
            }
            else
            {
                listHealthCheckup.DataSource = null;
                listHealthCheckup.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in List load", ex);
        }
    }
    

    public void Loadphysician()
    {
        try
        {
            List<Physician> lstroom = new List<Physician>();
            new Physician_BL(base.ContextInfo).GetPhysicianList(OrgID, out lstroom);
            foreach (Physician  str in lstroom)
            {
                hdnphysician.Value += str.PhysicianID + "~" + str.PhysicianName + "~" + str.SpecialityID + "~" + str.SpecialityName + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Physician Load", ex);
        }
    }

    public void LoadPackageData()
    {
       // investigationBL.GetHealthPackageData(OrgID, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        new SurgeryPackage_BL(base.ContextInfo).GetSurgeryDetails(OrgID, out lstSurgery, out lstSurgeryMapping, out lstSurgeryDtls);
        if (lstSurgery.Count > 0)
        {
            submitTab.Attributes.Add("style","display:block");
            TableRow rowHeader = new TableRow();
            TableCell cellHeader = new TableCell();
            cellHeader.Attributes.Add("align", "center");
            cellHeader.Text = "<b>" + "Surgery Packages" + "</b>";
            cellHeader.Font.Bold = true;
            cellHeader.CssClass = "Duecolor";
            //cellHeader.Style.Add("background-color", "#");
            //cellHeader.Style.Add("color", "#FFFFFF");
            rowHeader.Cells.Add(cellHeader);
            healthPackagesTab.Rows.Add(rowHeader);
            foreach (SurgeryPackageMaster objGM in lstSurgery)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                CheckBox chkPKG = new CheckBox();
                chkPKG.Attributes.Add("onclick", "javascript:showHidePKGContent(" + objGM.PackageID.ToString() + ");");
                chkPKG.ID = "chk" + objGM.PackageID.ToString();
                chkPKG.Text = "<b>" + objGM.PackageName+ "</b>";
                cell.Attributes.Add("align", "left");
                cell.Controls.Add(chkPKG);
                row.Cells.Add(cell);
                healthPackagesTab.Rows.Add(row);
                //Package Content
                TableRow rowContentHeader = new TableRow();
                TableCell cellContentHeader = new TableCell();
                rowContentHeader.ID = "rowHeader" + objGM.PackageID.ToString();
                rowContentHeader.Style.Add("display", "none");
                cellContentHeader.Attributes.Add("align", "center");
                cellHeader.CssClass = "Duecolor";
                //cellContentHeader.Style.Add("background-color", "#");
                //cellContentHeader.Style.Add("color", "#FFFFFF");
                cellContentHeader.Style.Add("height", "20px");
                cellContentHeader.Text = "<b>" + objGM.PackageName + "</b>";
                rowContentHeader.Cells.Add(cellContentHeader);
                healthPackagesContentTab.Rows.Add(rowContentHeader);
                TableRow rowContent = new TableRow();
                rowContent.ID = "rowContent" + objGM.PackageID.ToString();
                rowContent.Style.Add("display", "none");
                TableCell cellContent = new TableCell();
                cellContent.CssClass = "dataheaderInvCtrl";               
                Table innerContentTab = new Table();                
                var mappingList = from pkgMapp in lstSurgeryMapping
                                  where pkgMapp.PackageID == objGM.PackageID
                                  select pkgMapp;
                List<SurgeryPackageDetails> lstpkgMappTemp = mappingList.ToList<SurgeryPackageDetails>();
                if (lstpkgMappTemp.Count > 0)
                {
                    foreach (SurgeryPackageDetails objPKGMapp in lstpkgMappTemp)
                    {
                        TableRow rowinnerContent = new TableRow();
                        TableCell cellinnerContent = new TableCell();
                        Table innerContentTab1 = new Table();
                        var invList = from inv in lstSurgeryDtls
                                      where inv.PackageID == objGM.PackageID && inv.FeeID  == objPKGMapp.FeeID && inv.Feetype  == objPKGMapp.Feetype && objPKGMapp.Feetype == "INV"
                                      select inv;
                        List<SurgeryPackageDetails> lstPI1 = invList.ToList<SurgeryPackageDetails>();
                        if (lstPI1.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Investigations";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (SurgeryPackageDetails objPI1 in lstPI1)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI1.ItemName + "</b>" + " (Investigation)" + objPI1.PkgQuantity + "(count)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI1.FeeID.ToString() + "," + objPI1.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI1.FeeID.ToString() + objPI1.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI1.ItemName + "</b>" + " (Investigation)" + objPI1.PkgQuantity + "(count)" + "</font>";
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var grpList = from grp in lstSurgeryDtls
                                      where grp.PackageID == objGM.PackageID && grp.FeeID == objPKGMapp.FeeID && grp.Feetype == objPKGMapp.Feetype  && objPKGMapp.Feetype == "GRP"
                                      select grp;
                        List<SurgeryPackageDetails> lstPI2 = grpList.ToList<SurgeryPackageDetails>();
                        if (lstPI2.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Groups";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (SurgeryPackageDetails objPI2 in lstPI2)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI2.ItemName + "</b>" + " (Group)" + objPI2.PkgQuantity+"(count)"+"</font>";
                                CheckBox chk = new CheckBox();                            
                                chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI2.FeeID.ToString() + "," + objPI2.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI2.FeeID.ToString() + objPI2.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI2.ItemName + "</b>" + " (Group)" + objPI2.PkgQuantity + "(count)" + "</font>";
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var proList = from grp in lstSurgeryDtls
                                      where grp.PackageID == objGM.PackageID && grp.FeeID == objPKGMapp.FeeID && grp.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "PRO"
                                      select grp;
                        List<SurgeryPackageDetails> lstPI = proList.ToList<SurgeryPackageDetails>();
                        if (lstPI.Count > 0)
                        {                            
                            foreach (SurgeryPackageDetails objPI2 in lstPI)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI2.ItemName + "</b>" + " (Procedure)" + objPI2.PkgQuantity + "(count)" + "</font>";
                                CheckBox chk = new CheckBox(); chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI2.FeeID.ToString() + "," + objPI2.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI2.FeeID.ToString() + objPI2.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI2.ItemName + "</b>" + " (Procedure)" + objPI2.PkgQuantity + "(count)" + "</font>";
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var GHCList = from ghc in lstSurgeryDtls
                                      where ghc.PackageID == objGM.PackageID && ghc.FeeID == objPKGMapp.FeeID && ghc.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "MI"
                                      select ghc;
                        List<SurgeryPackageDetails> lstPI5 = GHCList.ToList<SurgeryPackageDetails>();
                        if (lstPI5.Count > 0)
                        {
                            
                            foreach (SurgeryPackageDetails objPI5 in lstPI5)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI5.ItemName+ "</b>" + " (Medical Indent)" + "</font>";
                                CheckBox chk = new CheckBox();
                                 
                                chk.Checked = true;

                                chk.Attributes.Add("OnClick", "javascript:showHidePKG(" + objPI5.FeeID.ToString() + "," + objPI5.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI5.FeeID.ToString() + objPI5.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI5.ItemName + "</b>" + " (Medical Indent)" + objPI5.PkgQuantity + "(count)" + "</font>";                                                            
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);                                
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var RTList = from ghc in lstSurgeryDtls
                                      where ghc.PackageID == objGM.PackageID && ghc.FeeID == objPKGMapp.FeeID && ghc.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "RT"
                                      select ghc;
                        List<SurgeryPackageDetails> lstPI6 = RTList.ToList<SurgeryPackageDetails>();
                        if (lstPI6.Count > 0)
                        {
                            foreach (SurgeryPackageDetails objPI6 in lstPI6)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                 cellinnerContent1.Text = "<b>" + objPI6.ItemName + "</b>" + " (Room Type)" + "</font>";
                                CheckBox chk = new CheckBox();chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI6.FeeID.ToString() + "," + objPI6.PackageID.ToString() + ");");
                               // chk.Attributes.Add("onclick", "javascript:alert(this.id);");
                                chk.ID = "chk" + objPI6.FeeID.ToString() + objPI6.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI6.ItemName + "</b>" + " (Room Type)" + objPI6.PkgQuantity + "(day(s))" + "</font>";
                                
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }

                        var SOIList = from ghc in lstSurgeryDtls
                                     where ghc.PackageID == objGM.PackageID && ghc.FeeID == objPKGMapp.FeeID && ghc.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "SOI"
                                     select ghc;
                        List<SurgeryPackageDetails> lstPI9 = SOIList.ToList<SurgeryPackageDetails>();
                        if (lstPI9.Count > 0)
                        {
                            foreach (SurgeryPackageDetails objPI9 in lstPI9)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI9.ItemName + "</b>" + " (Surgery Type)" + "</font>";
                                CheckBox chk = new CheckBox(); chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI9.FeeID.ToString() + "," + objPI9.PackageID.ToString() + ");");
                                // chk.Attributes.Add("onclick", "javascript:alert(this.id);");
                                chk.ID = "chk" + objPI9.FeeID.ToString() + objPI9.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI9.ItemName + "</b>" + " (Surgery Type)" + objPI9.PkgQuantity + "(count)" + "</font>";

                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }

                        var AMList = from ghc in lstSurgeryDtls
                                     where ghc.PackageID == objGM.PackageID && ghc.FeeID == objPKGMapp.FeeID && ghc.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "AM"
                                     select ghc;
                        List<SurgeryPackageDetails> lstPI7 = AMList.ToList<SurgeryPackageDetails>();
                        if (lstPI7.Count > 0)
                        {
                            foreach (SurgeryPackageDetails objPI7 in lstPI7)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI7.ItemName + "</b>" + " (Ambulance)" + "</font>";
                                CheckBox chk = new CheckBox();  chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI7.FeeID.ToString() + "," + objPI7.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI7.FeeID.ToString() + objPI7.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI7.ItemName + "</b>" + " (Ambulance)" + objPI7.PkgQuantity + "(count)" + "</font>";
                              
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }      
                        var CONList = from ghc in lstSurgeryDtls
                                      where ghc.PackageID == objGM.PackageID && ghc.FeeID == objPKGMapp.SpecialtyID && ghc.Feetype == objPKGMapp.Feetype && objPKGMapp.Feetype == "CON"
                                     select ghc;
                        List<SurgeryPackageDetails> lstPI8 = CONList.ToList<SurgeryPackageDetails>();
                        if (lstPI8.Count > 0)
                        {
                            foreach (SurgeryPackageDetails objPI8 in lstPI8)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI8.ItemName + "</b>" + " (Consultation)" + "</font>";
                                CheckBox chk = new CheckBox(); chk.Checked = true;
                                chk.Attributes.Add("onclick", "javascript:showHidePKG(" + objPI8.FeeID.ToString() + "," + objPI8.PackageID.ToString() + ");");
                                chk.ID = "chk" + objPI8.FeeID.ToString() + objPI8.PackageID.ToString();
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI8.ItemName + "</b>" + " (Consultation)" + objPI8.PkgQuantity + "(count)" + "</font>";
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
                cellContent.Controls.Add(innerContentTab);
                HyperLink hypinnerContentLink = new HyperLink();
                hypinnerContentLink.ID = "hyp" + objGM.PackageID.ToString();
                hypinnerContentLink.CssClass = "colorpacks";
                hypinnerContentLink.Text = "<b><u>Add More..</u></b>";
                hypinnerContentLink.Attributes.Add("onclick", "javascript:showHideSwapBlock(" + objGM.PackageID.ToString() + ");");
                cellContent.Controls.Add(hypinnerContentLink);
                HyperLink hypinnerLink = new HyperLink();
                hypinnerLink.ID = "hyp" + objGM.PackageID.ToString();
                hypinnerLink.CssClass = "colorpacks";
                hypinnerLink.Text = "<b><u>Edit..</u></b>";
                hypinnerLink.Attributes.Add("onclick", "javascript:EditBlock(" + objGM.PackageID.ToString() + ");");
                cellContent.Controls.Add(hypinnerLink);   
                Table tblAddedInvGRP = new Table();
                tblAddedInvGRP.ID = "tblOrderedInvesAddedTemp" + objGM.PackageID.ToString();
                tblAddedInvGRP.CellPadding = 3;
                cellContent.Controls.Add(tblAddedInvGRP);
                Table tblAddedProcedure = new Table();
                tblAddedProcedure.ID = "tblAddedProcedureItems" + objGM.PackageID.ToString();
                tblAddedProcedure.CellPadding = 3;
                cellContent.Controls.Add(tblAddedProcedure);                
                Table tblAddedHealthPKG = new Table();
                tblAddedHealthPKG.ID = "tblAddedHealthCheckupItems" + objGM.PackageID.ToString();
                tblAddedHealthPKG.CellPadding = 3;
                cellContent.Controls.Add(tblAddedHealthPKG);
                Table tblAddedRoomType = new Table();
                tblAddedRoomType.ID = "tblAddedRoomTypeItems" + objGM.PackageID.ToString();
                tblAddedRoomType.CellPadding = 3;
                cellContent.Controls.Add(tblAddedRoomType);
                Table tblAddedSurgeryType = new Table();
                tblAddedSurgeryType.ID = "tblAddedSurgeryTypeItems" + objGM.PackageID.ToString();
                tblAddedSurgeryType.CellPadding = 3;
                cellContent.Controls.Add(tblAddedSurgeryType);
                Table tblAddedAmbulance = new Table();
                tblAddedAmbulance.ID = "tblAddedAmbulanceItems" + objGM.PackageID.ToString();
                tblAddedAmbulance.CellPadding = 3;
                cellContent.Controls.Add(tblAddedAmbulance);
                Table tblAddedConsultation = new Table();
                tblAddedConsultation.ID = "tblAddedConsultationItems" + objGM.PackageID.ToString();
                tblAddedConsultation.CellPadding = 3;
                cellContent.Controls.Add(tblAddedConsultation); 
                HiddenField hdnAddedProcedure = new HiddenField();
                hdnAddedProcedure.ID = "hdnAddedProcedureItems" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedProcedure);                               
                HiddenField hdnAddedInvGRP = new HiddenField();
                hdnAddedInvGRP.ID = "hdnAddedInvGRP" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedInvGRP);
                HiddenField hdnAddedHealthPKG = new HiddenField();
                hdnAddedHealthPKG.ID = "hdnAddedHealthCheckupItems" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedHealthPKG);
                HiddenField hdnAddedRoomType = new HiddenField();
                hdnAddedRoomType.ID = "hdnAddedRoomTypeItems" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedRoomType);
                HiddenField hdnAddedSurgeryType = new HiddenField();
                hdnAddedSurgeryType.ID = "hdnAddedSurgeryTypeItems" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedSurgeryType); 
                HiddenField hdnAddedAmbulance = new HiddenField();
                hdnAddedAmbulance.ID = "hdnAddedAmbulanceItems" + objGM.PackageID.ToString();                
                cellContent.Controls.Add(hdnAddedAmbulance);
                HiddenField hdnAddedConsultation = new HiddenField();
                hdnAddedConsultation.ID = "hdnAddedConsultationItems" + objGM.PackageID.ToString();
                cellContent.Controls.Add(hdnAddedConsultation);
                HiddenField editProcedure = new HiddenField();
                editProcedure.ID = "editProcedure" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editProcedure);
                HiddenField editINVGRP = new HiddenField();
                editINVGRP.ID = "editINVGRP" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editINVGRP);
                HiddenField editHealth = new HiddenField();
                editHealth.ID = "editHealth" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editHealth);
                HiddenField editRoomtype = new HiddenField();
                editRoomtype.ID = "editRoomtype" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editRoomtype);
                HiddenField editSurgerytype = new HiddenField();
                editSurgerytype.ID = "editSurgerytype" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editSurgerytype);
                HiddenField editAmbulance = new HiddenField();
                editAmbulance.ID = "editAmbulance" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editAmbulance);
                HiddenField editspeciality = new HiddenField();
                editspeciality.ID = "editspeciality" + objGM.PackageID.ToString();
                cellContent.Controls.Add(editspeciality);
                CheckBox chkDft = new CheckBox();
                chkDft.ID = "chkDefault" + objGM.PackageID.ToString();
                //chkDft.Style.Add("color", "#");
                chkDft.CssClass = "colorsample";
                chkDft.Text = "<b>Set as Default Items to " + objGM.PackageName + "</b>";
                chkDft.Checked = true;                
                chkDft.Attributes.Add("onfocus", "javascript:setDefaultPKG();");
                cellContent.Controls.Add(chkDft);
                
                if (tblAddedInvGRP.Rows.Count > 0)
                {
                    chkDft.Checked = true;
                }
                hdntotalFinalPKG.Value += objGM.PackageID.ToString() + "~";
                if (lstSurgeryDtls.Count > 0)
                {
                    foreach (SurgeryPackageDetails spd in lstSurgeryDtls)
                    {
                        if ((spd.Feetype == "INV") && (spd.PackageID == objGM.PackageID))
                        {
                            editINVGRP.Value += spd.FeeID + "~" + spd.ItemName + "~" + spd.Feetype + "~" + spd.FeeID + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "GRP" && (spd.PackageID == objGM.PackageID))
                        {
                            editINVGRP.Value += spd.FeeID + "~" + spd.ItemName + "~" + spd.Feetype + "~" + spd.FeeID + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "PRO" && (spd.PackageID == objGM.PackageID))
                        {
                            editProcedure.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "RT" && (spd.PackageID == objGM.PackageID))
                        {
                            editRoomtype.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "SOI" && (spd.PackageID == objGM.PackageID))
                        {
                            editSurgerytype.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "MI" && (spd.PackageID == objGM.PackageID))
                        {
                            editHealth.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "AM" && (spd.PackageID == objGM.PackageID))
                        {
                            editAmbulance.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "^";
                        }
                        else if (spd.Feetype == "CON" && (spd.PackageID == objGM.PackageID))
                        {
                            editspeciality.Value += spd.FeeID + "~" + spd.FeeID + "~" + spd.ItemName + "~" + spd.PkgQuantity + "~" + spd.SpecialtyID + "^";
                        }
                    }
                }
                rowContent.Cells.Add(cellContent);
                healthPackagesContentTab.Rows.Add(rowContent);
            }
        }
    }

    //public void GetAmbulance()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        List<Ambulancedetails> lstAmbulancemaster = new List<Ambulancedetails>();
    //        returnCode = new PatientVisit_BL(base.ContextInfo).GetAmbulance(OrgID, out lstAmbulancemaster);
    //        lstambulance.DataSource = lstAmbulancemaster;
    //        lstambulance.DataTextField = "ItemName";
    //        lstambulance.DataValueField = "ItemId";
    //        lstambulance.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in ambulancedetails", ex);
    //    }
    //}
    //public void GetProcedureData()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
    //        returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);
    //        listProcedure.DataSource = lstProceduremaster;
    //        listProcedure.DataTextField = "ProcedureName";
    //        listProcedure.DataValueField = "ProcedureID";
    //        listProcedure.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Procedure data", ex);
    //    }
    //}
    //public void GetMedicalIndents()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        int ClientId = 0;
    //        int iValue = 5;
    //        List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
    //        AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
    //        returnCode = objBl.GetInvestigationRates(OrgID, iValue, ClientId, out lstRates);            
    //        if (lstRates.Count > 0)
    //        {
    //            listHealthCheckup.DataSource = lstRates;
    //            listHealthCheckup.DataTextField = "DescriptionName";
    //            listHealthCheckup.DataValueField = "ID";
    //            listHealthCheckup.DataBind();
    //        }
    //        else
    //        {
    //            listHealthCheckup.DataSource = null;              
    //            listHealthCheckup.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Loading Medical Indents", ex);
    //    }
    //}

    public void cleardata()
    {
        try
        {
            txtpackage.Text = String.Empty;
            txtAmount.Text = String.Empty;
            txtDays.Text = String.Empty;
            txtBefore.Text = String.Empty;
            txtAfter.Text = String.Empty;
            txtValidity.Text = String.Empty;            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in Surgery Page Load", ex);
        }
    }
    public void loaddata()
    {
        try
        {
            returncode = new SurgeryPackage_BL(base.ContextInfo).GetSurgeryMaster(OrgID, out lstSurgery);
            if (lstSurgery.Count > 0)
            {
                gvSurgery.DataSource = lstSurgery;
                gvSurgery.DataBind();
            }
            else
            {
                gvSurgery.DataSource = null;
                gvSurgery.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in Surgery Load Data", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnid.Value == String.Empty)
            {
                surgery.PackageID = 0;
            }
            else
            {
                surgery.PackageID = Int32.Parse(hdnid.Value);
            }            
            surgery.PackageName = txtpackage.Text.Trim().ToString();
            //surgery.Amount = decimal.Parse(txtAmount.Text);
            surgery.PackageDays = int.Parse(txtDays.Text);
            //surgery.NoFreeConsBefore = int.Parse(txtBefore.Text);
            //surgery.NoFreeConsAfter = int.Parse(txtAfter.Text);
            surgery.OrgID = OrgID;
           // surgery.FreeConsValidity = int.Parse(txtValidity.Text);
            surgery.CreatedBy = Convert.ToInt64(RoleID);
            lstSurgery.Add(surgery);
            returncode = new SurgeryPackage_BL(base.ContextInfo).SaveSurgeryMaster(lstSurgery);
                //ClientScript.RegisterStartupScript(this.GetType(), "mm", "alert('Changes saved successfully.');", true);
            //Response.Redirect("SurgeryPackage.aspx");
            loaddata();
            cleardata();
            hdnid.Value = String.Empty;
            LoadPackageData();
            TabContainer1.ActiveTabIndex = 1;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in Save Surgery Master", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in cancel Surgery Master", ex);
        }
    }
    protected void gvSurgery_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            long pid=0;
            pid = Int64.Parse(gvSurgery.DataKeys[e.RowIndex].Values[0].ToString());
            returncode = new SurgeryPackage_BL(base.ContextInfo).DeleteSurgeryMaster(pid, OrgID);
            if (returncode > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "m", "alert('"+Delete_Msg+"');", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "m", "alert('Deleted successfully');", true);
            }
            loaddata();
            hdnid.Value = String.Empty;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem in Deleting Surgery Master", ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            CollectPackageContent(out lstPackagesTemp, out lstCollectedDefaultPackageMapping, out lstCollectedPackageMapping, out lstDeletedPackageMapping);
            returncode = new SurgeryPackage_BL(base.ContextInfo).UpdatePackageContent(lstCollectedDefaultPackageMapping, lstDeletedPackageMapping, OrgID, RoleID);
            Response.Redirect("SurgeryPackage.aspx");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in save in surgery details", ex);
        }
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
        try
        {
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while cancelling in surgery details", ex);
        }
    }
    

    public void CollectPackageContent(out List<SurgeryPackageMaster> lstPackagesTemp, out List<SurgeryPackageDetails> lstCollectedDefaultPackageMapping, out List<SurgeryPackageDetails> lstCollectedPackageMapping, out List<SurgeryPackageDetails> lstDeletedPackageMapping)
    {
        int success = 0;
        lstCollectedPackageMapping = new List<SurgeryPackageDetails>();
        lstPackagesTemp = new List<SurgeryPackageMaster>();
        lstCollectedDefaultPackageMapping = new List<SurgeryPackageDetails>();
        lstDeletedPackageMapping = new List<SurgeryPackageDetails>();
        new SurgeryPackage_BL(base.ContextInfo).GetSurgeryDetails(OrgID, out lstSurgery, out lstSurgeryMapping, out lstSurgeryDtls);
        //investigationBL.GetHealthPackageData(OrgID, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        if (Hdnfld.Value != "")
        {
            foreach (string value in Hdnfld.Value.Split('^'))
            {
                if (value != "")
                {
                    string[] val = value.Split('~');
                    SurgeryPackageDetails obj = new SurgeryPackageDetails();
                    obj.FeeID = Convert.ToInt64(val[0]);
                    obj.PackageID = Convert.ToInt64(val[1]);
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
                    string[] val = value.Split('~');
                    SurgeryPackageDetails obj = new SurgeryPackageDetails();
                    obj.FeeID = Convert.ToInt64(val[0]);
                    obj.PackageID = Convert.ToInt64(val[1]);
                    lstDeletedPackageMapping.Add(obj);
                }
            }
        }
        foreach (string pkgID in hdntotalFinalPKG.Value.Split('~'))
        {
            if (pkgID != "")
            {
                //foreach (SurgeryPackageMaster objGMTemp in lstSurgery)
                //{
                //    foreach (string pkgIDTemp in hdntotalFinalPKG.Value.Split('~'))
                //    {
                //        if (pkgIDTemp != "")
                //        {
                //            if (Convert.ToInt32(pkgIDTemp) == objGMTemp.OrgGroupID)
                //            {
                //                foreach (string pkgIDTemp1 in setOrderedPKGTemp.Value.Split('~'))
                //                {
                //                    if (pkgIDTemp1 != "" && pkgIDTemp == pkgIDTemp1)
                //                    {
                //                        success = 1;
                //                    }
                //                }
                //                if (success == 0)
                //                {
                //                    setOrderedPKGTemp.Value += pkgIDTemp + "~";
                //                    lstPackagesTemp.Add(objGMTemp);
                //                    var invPMList = from invPM in lstSurgeryMapping
                //                                    where invPM.PackageID == Convert.ToInt32(pkgIDTemp) && invPM.Type == "CON"
                //                                    select invPM;
                //                    List<SurgeryPackageDetails> lstPI1 = invPMList.ToList<SurgeryPackageDetails>();
                //                    foreach (SurgeryPackageDetails objPMTTT in lstPI1)
                //                    {
                //                        Speciality objCollectedSpeciality = new Speciality();
                //                        objCollectedSpeciality.SpecialityID = Convert.ToInt32(objPMTTT.FeeID);
                //                        objCollectedSpeciality.SpecialityName = "";
                //                        lstCollectedSpeciality.Add(objCollectedSpeciality);
                //                    }
                //                }
                //            }
                //        }
                //    }
                //}
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
                                    SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                    objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                    objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems1[0]);
                                    objCollectedINVGRP.Feetype = innerSubItems1[2];
                                    lstCollectedPackageMapping.Add(objCollectedINVGRP);
                                }
                            }
                        }
                    }
                }
                //foreach (string pkgID3 in collectedFinalProcedure.Value.Split(':'))
                //{
                //    if (pkgID3 != "")
                //    {
                //        string[] items3 = pkgID3.Split('-');
                //        if (items3[0] == pkgID)
                //        {
                //            foreach (string innerItems3 in items3[1].Split('^'))
                //            {
                //                if (innerItems3 != "")
                //                {
                //                    string[] innerSubItems3 = innerItems3.Split('~');
                //                    ProcedureMaster objCollectedProcedure = new ProcedureMaster();
                //                    objCollectedProcedure.ProcedureID = Convert.ToInt32(innerSubItems3[1]);
                //                    objCollectedProcedure.ProcedureName = innerSubItems3[2];
                //                    lstCollectedProcedures.Add(objCollectedProcedure);
                //                }
                //            }
                //        }
                //    }
                //}

                //foreach (string pkgID4 in collectedFinalHealthCheckUp.Value.Split(':'))
                //{
                //    if (pkgID4 != "")
                //    {
                //        string[] items3 = pkgID4.Split('-');
                //        if (items3[0] == pkgID)
                //        {
                //            foreach (string innerItems3 in items3[1].Split('^'))
                //            {
                //                if (innerItems3 != "")
                //                {
                //                    string[] innerSubItems3 = innerItems3.Split('~');
                //                    GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                //                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(innerSubItems3[1]);
                //                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = innerSubItems3[2];
                //                    lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                //                }
                //            }
                //        }
                //    }
                //}
                foreach (string pkgIDsetDefault in hdntotalFinalPKG.Value.Split('~'))
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
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems1[0]);
                                            objCollectedINVGRP.ItemName = innerSubItems1[1];
                                            objCollectedINVGRP.Feetype = innerSubItems1[2];
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems1[4]);
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
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                            objCollectedINVGRP.Feetype = "PRO";
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
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
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                            objCollectedINVGRP.Feetype = "MI";
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                        foreach (string pkgID5 in collectedFinalRoomType.Value.Split(':'))
                        {
                            if (pkgID5 != "")
                            {
                                string[] items3 = pkgID5.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                            objCollectedINVGRP.Feetype = "RT";
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                        foreach (string pkgID8 in collectedFinalSurgeryType.Value.Split(':'))
                        {
                            if (pkgID8 != "")
                            {
                                string[] items3 = pkgID8.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                            objCollectedINVGRP.Feetype = "SOI";
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                        foreach (string pkgID6 in collectedFinalAmbulance.Value.Split(':'))
                        {
                            if (pkgID6 != "")
                            {
                                string[] items3 = pkgID6.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                            objCollectedINVGRP.Feetype = "AM";
                                            objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                            foreach (string pkgID7 in collectedFinalSpeciality.Value.Split(':'))
                            {
                                if (pkgID7 != "")
                                {
                                    string[] items3 = pkgID7.Split('-');
                                    if (items3[0] == pkgID)
                                    {
                                        foreach (string innerItems3 in items3[1].Split('^'))
                                        {
                                            if (innerItems3 != "")
                                            {
                                                string[] innerSubItems3 = innerItems3.Split('~');
                                                SurgeryPackageDetails objCollectedINVGRP = new SurgeryPackageDetails();
                                                objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                                objCollectedINVGRP.SpecialtyID = Convert.ToInt16(innerSubItems3[1]);
                                                objCollectedINVGRP.ItemName = innerSubItems3[2].ToString();
                                                objCollectedINVGRP.Feetype = "CON";
                                                objCollectedINVGRP.PkgQuantity = decimal.Parse(innerSubItems3[3]);
                                                objCollectedINVGRP.FeeID = Convert.ToInt64(innerSubItems3[4]);
                                                lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                            }
                                        }
                                    }
                                }
                            }

                        
                    }
                }
                TabContainer1.ActiveTab = tab1;
                // LoadPackageData();
            }
        }
    }
}
