using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;

public partial class ANC_BaselineScreeningHistory : BasePage
{

    #region variable declaration
    List<Complication> lstcomp = new List<Complication>();
    List<GPALDetails> gpaldetails = new List<GPALDetails>();
    List<BackgroundProblem> lstbp = new List<BackgroundProblem>();
    List<PatientVaccinationHistory> lstvacc = new List<PatientVaccinationHistory>();
    List<GPALDetails> savegpaldetails = new List<GPALDetails>();
    List<BackgroundProblem> savebp = new List<BackgroundProblem>();
    List<Complication> savecomp = new List<Complication>();
    List<PatientVaccinationHistory> savevacc = new List<PatientVaccinationHistory>();
    long visitID = 0;
    long createdBy = 0;
    long patientid = 0;
    int specialityid = 0;
    List<Complication> lstComplication = new List<Complication>();
    List<Vaccination> lstVaccination = new List<Vaccination>();
    List<PlacentalPositions> lstPlacentalPositions = new List<PlacentalPositions>();
    List<ModeOfDelivery> lstMod = new List<ModeOfDelivery>();
    List<BirthMaturity> lstBirthMaturity = new List<BirthMaturity>();
    string sexofchild = string.Empty;
    string modeofdelivery = string.Empty;
    string birthmaturity = string.Empty;
    string growth1 = string.Empty;
    string growth = string.Empty;
    long returnCode = -1;
    List<PatientVaccinationHistory> finalpv = new List<PatientVaccinationHistory>();
    List<BackgroundProblem> finalbp = new List<BackgroundProblem>();
    List<GPALDetails> gpaldata = new List<GPALDetails>();
    List<PatientPastComplication> lstPComplication = new List<PatientPastComplication>();
    List<Complaint> lstComplaint = new List<Complaint>();
    List<Complication> finalcomp = new List<Complication>();
    #endregion variable declaration

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientid);
        Int64.TryParse(Request.QueryString["uid"], out createdBy);
        TVH.Attributes.Add("onClick", "OnTreeClick(event)");
        btnCheckRoutineLabs.Attributes.Add("onClick", "javascript:GetDesc1();");
        tLMP.Attributes.Add("onchange", "addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
        btnCalcEDD.Attributes.Add("onclick", "return addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
        txtGravida.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtPara.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtAbortUs.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtLive.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtAge.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtBwt.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtGrowthRate.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtYear.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtDoses.Attributes.Add("onkeydown", "return validatenumber(event);");
        List<GPALDetails> lstSaveBaseLine = new List<GPALDetails>();
        List<PatientPastComplication> lstSavePreComp = new List<PatientPastComplication>();
        List<Complaint> lstSaveAssociateDis = new List<Complaint>();
        List<PatientVaccinationHistory> lstSavePriorVacc = new List<PatientVaccinationHistory>();
        lstSaveBaseLine = getBaseLineHistroy();
        lstSavePreComp = getPreviousComplicate();
        lstSaveAssociateDis = getAssociateDiseases();
        lstSavePriorVacc = getPriorVaccinations();

        if (!IsPostBack)
        {
            try
            {
                ANC_BL ancBL = new ANC_BL(base.ContextInfo);
                //Get Speciality Id
                //ancBL.GetANCSpecilaityID(visitID, out specialityid);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on pageload", ex);
            }
            //To load all ANC Specilaity complaint 
            loadANCComplaint();
            //To load all ANC Complication
            loadPreviousComplicatedPregnancies();
            //To load Vaccination
            loadpriorvaccination();
            //To load mode of delivery
            loadmodeofdelivery();
            //To load Birth Maturity
            loadbirthmaturity();
            //To load Placental position
            loadplacentalpositions();
        }
    }

    protected void loadPreviousComplicatedPregnancies()
    {
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            //To get complication   
            ancBL.GetPregnancyComplication(specialityid, out lstComplication);
            loadComplication(lstComplication);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    //To load complication in check box list
    public void loadComplication(List<Complication> lstComplication)
    {
        if (lstComplication.Count > 0)
        {
            PCP.Items.Clear();

            foreach (Complication com in lstComplication)
            {
                PCP.Items.Add(new ListItem(com.ComplicationName, Convert.ToString(com.ComplicationID)));
            }
        }
    }

    protected void loadANCComplaint()
    {

        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            //Get all ANC complaint
            ancBL.GetANCComplaint(specialityid, out lstComplaint);
            SetANCComplaint(lstComplaint);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    //Load Complaint in Tree view
    void SetANCComplaint(List<Complaint> complaint)
    {
        try
        {
            TVH.NodeStyle.CssClass = "defaultfontcolor";
            TVH.NodeIndent = 0;
            TVH.Nodes[0].Text = "Complaints";
           
            AddHistChildNode(TVH.Nodes[0], complaint);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetHistory", ex);
        }
    }

    void AddHistChildNode(TreeNode parent, List<Complaint> complaint)
    {

        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryHistories = from ex in complaint
                             where ex.ParentID == parentID
                             select ex;
        string treeNodeText = string.Empty;
        foreach (var ex in queryHistories)
        {

            treeNodeText = ex.ParentID == 0 ? "<a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" +
                                               ex.ComplaintId.ToString() + "','tCA" + ex.ComplaintId.ToString() +
                                               "');\">" + ex.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + ex.ComplaintId.ToString() + "'>" : ex.ComplaintName;

            TreeNode tn = new TreeNode();
            tn.Text = treeNodeText;
            tn.Value = ex.ComplaintId.ToString();
            tn.Collapse();
            tn.PopulateOnDemand = false;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
        }
        
        for (int i = 0; i < parent.ChildNodes.Count; i++)
        {
            
            var queryHistories1 = from exc in complaint
                                  where exc.ParentID == Convert.ToInt32(parent.ChildNodes[i].Value)
                                  select exc;
            if (queryHistories1.Count() > 0)
            {
                foreach (var exc in queryHistories1)
                {
                    TreeNode tn = new TreeNode(exc.ParentID != 0 ? "<input id='tCA" + exc.ComplaintId.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "');\">" + exc.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + exc.ComplaintId.ToString() + "'>" : exc.ComplaintName);
                    tn.SelectAction = TreeNodeSelectAction.None;
                    parent.ChildNodes[i].ChildNodes.Add(tn);
                    //treeNodeText = exc.ParentID == 0 ? "<input id='tCA" + exc.ComplaintId.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "');\">" + exc.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + exc.ComplaintId.ToString() + "'>" : exc.ComplaintName;
                }
            }
        }
    }

    //get Vaccination from DB
    protected void loadpriorvaccination()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);

            returnCode = ancBL.GetPriorVaccination(out lstVaccination);
            loadGRD_priorvaccination(lstVaccination);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    //Load vaccination to dropdown

    protected void loadGRD_priorvaccination(List<Vaccination> lstVaccination)
    {
        if (lstVaccination.Count > 0)
        {
            int temp = lstVaccination.Count();
            lstVaccination[temp - 1].VaccinationName = "Other Vaccination";
            drpVaccination.DataSource = lstVaccination;
            drpVaccination.DataTextField = "VaccinationName";
            drpVaccination.DataValueField = "VaccinationID";
            drpVaccination.DataBind();
        }
    }

    //get Placental position from DB
    protected void loadplacentalpositions()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            returnCode = ancBL.GetPlacentalPositions(out lstPlacentalPositions);
            loadGRD_placentalpositions(lstPlacentalPositions);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    //Load Placental Position to drop down
    protected void loadGRD_placentalpositions(List<PlacentalPositions> lstPlacentalPositions)
    {
        if (lstPlacentalPositions.Count > 0)
        {
            drpPlacental.DataSource = lstPlacentalPositions;
            drpPlacental.DataTextField = "PlacentalPositionName";
            drpPlacental.DataValueField = "PlacentalPositionID";
            drpPlacental.DataBind();
        }
    }

    //get mode of delivery
    protected void loadmodeofdelivery()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);

            returnCode = ancBL.GetModeOfDelivery(out lstMod);
            loadGRD_modeofdelivery(lstMod);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    
    //load of mode of delivery to drop down
    protected void loadGRD_modeofdelivery(List<ModeOfDelivery> lstMod)
    {
        if (lstMod.Count > 0)
        {
            drpMOD.DataSource = lstMod;
            drpMOD.DataTextField = "ModeOfDeliveryDesc";
            drpMOD.DataValueField = "ModeOfDeliveryId";
            drpMOD.DataBind();
        }
    }
    
    //To load birth maturity in dropdown
    protected void loadbirthmaturity()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);

            returnCode = ancBL.GetBirthMaturity(out lstBirthMaturity);
            loadGRD_birthmaturity(lstBirthMaturity);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    protected void loadGRD_birthmaturity(List<BirthMaturity> lstBirthMaturity)
    {
        if (lstBirthMaturity.Count > 0)
        {
            drpBMaturity.DataSource = lstBirthMaturity;
            drpBMaturity.DataTextField = "BirthMaturityDesc";
            drpBMaturity.DataValueField = "BirthMaturityID";
            drpBMaturity.DataBind();
        }
    }
   
    protected void drdSOC_SelectedIndexChanged(object sender, EventArgs e)
    {
        sexofchild = drdSOC.SelectedItem.Text;
    }
    
    protected void drpBMaturity_SelectedIndexChanged(object sender, EventArgs e)
    {
        birthmaturity = drpBMaturity.SelectedItem.Text;
    }
   
    protected void drpMOD_SelectedIndexChanged(object sender, EventArgs e)
    {
        modeofdelivery = drpMOD.SelectedItem.Text;
    }
    
    protected void TVH_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        if (TVH.Nodes[0].Checked)
        {
            for (int i = 0; i < TVH.Nodes[0].ChildNodes.Count; i++)
            {
                TVH.Nodes[0].ChildNodes[i].Checked = true;

            }
        }
    }
   
    protected void TVH_SelectedNodeChanged(object sender, EventArgs e)
    {
        if (TVH.Nodes[0].Checked)
        {
            for (int i = 0; i < TVH.Nodes[0].ChildNodes.Count; i++)
            {
                TVH.Nodes[0].ChildNodes[i].Checked = true;
            }
        }
    }

    protected void savedata()
    {

        Int64.TryParse(Convert.ToString(Session["LID"]), out createdBy);
        Int64.TryParse(Request.QueryString["pid"], out patientid);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        ANC_BL ancBL = new ANC_BL(base.ContextInfo);
        List<BackgroundProblem> pComplaint = new List<BackgroundProblem>();
        List<GPALDetails> pGPALDetails = new List<GPALDetails>();
        List<PatientVaccinationHistory> pVaccinationDetails = new List<PatientVaccinationHistory>();
        List<GPALDetails> savegpaldetails = new List<GPALDetails>();
        List<PatientPastComplication> lstSavePreComp = new List<PatientPastComplication>();
        List<Complaint> lstSaveAssociateDis = new List<Complaint>();
        List<PatientVaccinationHistory> lstSavePriorVacc = new List<PatientVaccinationHistory>();
        savegpaldetails = getBaseLineHistroy();
        lstSavePreComp = getPreviousComplicate();
        lstSaveAssociateDis = getAssociateDiseases();
        lstSavePriorVacc = getPriorVaccinations();
        
        try
        {
            //Save GPALDetails
            GPALDetails gdetails = new GPALDetails();
            for (int i = 0; i < savegpaldetails.Count; i++)
            {
                gdetails.PatientID = patientid;
                string str = savegpaldetails[i].SexOfChild.ToString();
                if (str == "Male")
                {
                    str = "M";
                }
                else
                {
                    str = "F";
                }
                string strGrowth=savegpaldetails[i].IsGrowthNormal;
                if(strGrowth =="Normal")
                {
                    strGrowth="N";
                }
                else
                {
                    strGrowth="A";
                }
                gdetails.SexOfChild = str;
                gdetails.Age = savegpaldetails[i].Age;
                gdetails.ModeOfDeliveryID = savegpaldetails[i].ModeOfDeliveryID;
                gdetails.BirthWeight = savegpaldetails[i].BirthWeight;
                gdetails.BirthMaturityID = savegpaldetails[i].BirthMaturityID;
                gdetails.IsGrowthNormal = strGrowth;
                gdetails.GrowthRate = savegpaldetails[i].GrowthRate;
                gdetails.PatientVisitID = visitID;
                gdetails.CreatedBy = LID;
                pGPALDetails.Add(gdetails);
            }

            //Save Complaint
            foreach (string desc in HdnAssociate.Value.Split('^'))
            {
                if (desc.Split('~').Length > 1)
                {
                    BackgroundProblem pex = new BackgroundProblem();
                    pex.ComplaintName = desc.Split('~')[0];
                    pex.PatientID = patientid;
                    pex.PatientVisitID = visitID;
                    pex.Description  = desc.Split('~')[1];
                    pex.CreatedBy = createdBy;
                    pex.Status = "Y";
                    pex.Priority = 1;
                    pComplaint.Add(pex);
                }
            }

            List<BackgroundProblem> pexOth = new List<BackgroundProblem>();
            BackgroundProblem bp = new BackgroundProblem();
            for (int i = 0; i < lstSaveAssociateDis.Count; i++)
            {
                bp.ComplaintName = lstSaveAssociateDis[i].ComplaintName;
                bp.Description = lstSaveAssociateDis[i].ComplaintDesc;
                bp.PatientID = patientid;
                pComplaint.Add(bp);
            }

            //ANCPatientDetails

            DateTime LMP = new DateTime();
            DateTime EDD = new DateTime();
            string pregnancystatus = string.Empty;
            string isprimipara = string.Empty;
            string isbad = string.Empty;
            ANCPatientDetails ancpatientdetails = new ANCPatientDetails();
            ancpatientdetails.PatientID = patientid;
            ancpatientdetails.PatientVisitID = visitID;
            if (tLMP.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tLMP.Text, out LMP))
                    LMP = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                LMP = new DateTime(1800, 1, 1);
            }
            ancpatientdetails.LMPDate = LMP;
            if (txtCalculatedEDD.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(txtCalculatedEDD.Text, out EDD))
                    EDD = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                EDD = new DateTime(1800, 1, 1);
            }
            ancpatientdetails.EDD = EDD;
            if (txtGravida.Text != "")
                ancpatientdetails.Gravida = Convert.ToByte(txtGravida.Text);
            if (txtPara.Text != "")
               ancpatientdetails.Para = Convert.ToByte(txtPara.Text);
            if (txtLive.Text != "")
                ancpatientdetails.Live = Convert.ToByte(txtLive.Text);
            if (txtAbortUs.Text != "")
                ancpatientdetails.Abortus  = Convert.ToByte(txtAbortUs.Text);

            if (drpPregnancy.SelectedItem.Text == "Confirmed")
                pregnancystatus = "1";
            else if (drpPregnancy.SelectedItem.Text == "To re-confirm")
                pregnancystatus = "2";
            else if (drpPregnancy.SelectedItem.Text == "Yet to confirm")
                pregnancystatus = "3";

            ancpatientdetails.PregnancyStatus = pregnancystatus;

            if (chkIsPrimipara.Checked == true)
                isprimipara = "1";
            else
                isprimipara = "2";
            ancpatientdetails.IsPrimipara = isprimipara;

            if (chkIsBad.Checked == true)
                isbad = "1";
            else
                isbad = "2";
            ancpatientdetails.IsBadObstretic = isbad;
            ancpatientdetails.CreatedBy = createdBy;

            //Ultrasound data

            DateTime DateOfUS = new DateTime();
            PatientUltraSoundData ultrasounddata = new PatientUltraSoundData();
            ultrasounddata.PatientID = patientid;
            ultrasounddata.PatientVisitID = visitID;
            ultrasounddata.GestationalWeek = Convert.ToInt32(drpweeks.Text);
            ultrasounddata.GestationalDays = Convert.ToInt32(drpDays.Text);
            ultrasounddata.PlacentalPositionID = Convert.ToInt64(drpPlacental.SelectedItem.Value);
            ultrasounddata.PlacentalPositionName = txtOther1.Text;
            ultrasounddata.MultipleGestation = Convert.ToInt32(drpMultiGest.SelectedItem.Value);
            if (txtDateOfUltraSound.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(txtDateOfUltraSound.Text, out DateOfUS))
                    DateOfUS = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DateOfUS = new DateTime(1800, 1, 1);
            }

            ultrasounddata.DateOfUltraSound = DateOfUS;
            ultrasounddata.CreatedBy = createdBy;

            //Save Complication
            savecomplication();

            //Save Vaccination
            PatientVaccinationHistory pvh = new PatientVaccinationHistory();
            for (int i = 0; i < lstSavePriorVacc.Count(); i++)
            {
                pvh.VaccinationID = lstSavePriorVacc[i].VaccinationID;
                pvh.VaccinationName = lstSavePriorVacc[i].VaccinationName;
                pvh.YearOfVaccination  = lstSavePriorVacc[i].YearOfVaccination;
                pvh.MonthOfVaccination = lstSavePriorVacc[i].MonthOfVaccination;
                pvh.VaccinationDose = lstSavePriorVacc[i].VaccinationDose;
                string strBooster = lstSavePriorVacc[i].IsBooster;
                if (strBooster == "Yes")
                {
                    strBooster = "Y";
                }
                else
                {
                    strBooster = "N";
                }
                pvh.IsBooster = strBooster;
                pvh.PatientID = patientid;
                pvh.PatientVisitID = visitID;
                pvh.CreatedBy = LID;
                pVaccinationDetails.Add(pvh);
            }
            //returnCode = ancBL.SaveANC(ancpatientdetails, pComplaint, pGPALDetails, ultrasounddata, lstPComplication, pVaccinationDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save ANC page", ex);
        }
        clear();
        pGPALDetails.Clear();
        pVaccinationDetails.Clear();
        pComplaint.Clear();
        savegpaldetails.Clear(); 
        lstSavePreComp.Clear();
        lstSaveAssociateDis.Clear();
        lstSavePriorVacc.Clear();
    }

    //clear all values after save method called
    void clear()
    {
        txtAbortUs.Text = string.Empty;
        txtADDesc.Text = string.Empty;
        txtAge.Text = string.Empty;
        txtAssocaitedothers.Text = string.Empty;
        txtBwt.Text = string.Empty;
        txtCalculatedEDD.Text = string.Empty;
        txtDateOfUltraSound.Text = string.Empty;
        txtDoses.Text = string.Empty;
        txtDrugDose.Text = string.Empty;
        txtDrugDose1.Text = string.Empty;
        txtDrugName.Text = string.Empty;
        txtFrequency.Text = string.Empty;
        txtFrequency1.Text = string.Empty;
        txtGravida.Text = string.Empty;
        txtGrowthRate.Text = string.Empty;
        txtLive.Text = string.Empty;
        txtOther1.Text = string.Empty;
        txtothers.Text = string.Empty;
        txtPara.Text = string.Empty;
        txtYear.Text = string.Empty;
        drpPregnancy.SelectedIndex = 0;
        tLMP.Text = string.Empty;
        drpPlacental.SelectedIndex = 0;
        drpweeks.SelectedIndex = 0;
        drpDays.SelectedIndex = 0;
        drpMultiGest.SelectedIndex = 0;
        drpVaccination.SelectedIndex = 0;
        drpMonth.SelectedIndex = 0;
        chkBooster.Checked = false;
        chkIsPrimipara.Checked = false;
        chkIsGrowth.Checked = false;
        chkIsBad.Checked = false;
        TVH.CollapseAll();
        PCP.ClearSelection();
        loadANCComplaint();
        loadPreviousComplicatedPregnancies();
        loadpriorvaccination();
        loadmodeofdelivery();
        loadbirthmaturity();
        loadplacentalpositions();
        lstcomp.Clear();
        lstbp.Clear();
        lstvacc.Clear();
        gpaldetails.Clear();
        lstPComplication.Clear();
        savevacc.Clear();
       // savegpaldetails.Clear();
        savebp.Clear();
        savecomp.Clear();
        finalbp.Clear();
        finalcomp.Clear();
        finalpv.Clear();

    }
    protected void btnCheckRoutineLabs_Click(object sender, EventArgs e)
    {
       savedata();
       //try
       //{
       //    List<Role> lstUserRole = new List<Role>();
       //    string path = string.Empty;
       //    Role role = new Role();
       //    role.RoleID = RoleID;
       //    lstUserRole.Add(role);
       //    returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
       //    Response.Redirect(Request.ApplicationPath + path, true);
       //}
       //catch (System.Threading.ThreadAbortException tae)
       //{
       //    string thread = tae.ToString();
       //}
    }
   
    //get all selected complication
    protected List<PatientPastComplication> savecomplication()
    {
        List<PatientPastComplication> lstSavePreComp = new List<PatientPastComplication>();
        lstSavePreComp = getPreviousComplicate();
        foreach (ListItem li in PCP.Items)
        {
            if (li.Selected)
            {
                PatientPastComplication lstComplication = new PatientPastComplication();
                lstComplication.ComplicationID = Convert.ToInt32(li.Value);
                lstComplication.ComplicationName = li.Text;
                lstComplication.PatientVisitID = visitID;
                lstComplication.CreatedBy = LID;
                lstPComplication.Add(lstComplication);
            }
        }

        List<PatientPastComplication> comp = new List<PatientPastComplication>();
        PatientPastComplication samp = new PatientPastComplication();
        List<PatientPastComplication> Finalcomp = new List<PatientPastComplication>();
        for (int i = 0; i < lstSavePreComp.Count; i++)
        {
            samp.ComplicationName = lstSavePreComp[i].ComplicationName;
            samp.PatientVisitID = visitID;
            samp.CreatedBy = LID;
            lstPComplication.Add(samp);
        }

        return lstPComplication;

    }
    
    // BaseLineHistroy javascript table list
    
    public List<GPALDetails> getBaseLineHistroy()
    {
        List<GPALDetails> lstBaseline = new List<GPALDetails>();
        string HidBLine = HidBaseLine.Value;
        foreach (string splitString in HidBLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    GPALDetails objBaseLine = new GPALDetails();
                    objBaseLine.SexOfChild = lineItems[1];
                    objBaseLine.Age = lineItems[2];
                    objBaseLine.ModeOfDelivery = lineItems[3];
                    objBaseLine.BirthWeight = Convert.ToInt32(lineItems[4]);
                    objBaseLine.IsGrowthNormal=lineItems[5];
                    objBaseLine.GrowthRate = Convert.ToInt32(lineItems[6]);
                    lstBaseline.Add(objBaseLine);
                }
            }
        }
        return lstBaseline;
    }

    // PreviousComplicate javascript table list

    public List<PatientPastComplication> getPreviousComplicate()
    {
        List<PatientPastComplication> lstPreviousComplicate = new List<PatientPastComplication>();
        string HidPreviousLine = HdnPreviousComplicate.Value;
        foreach (string splitString in HidPreviousLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientPastComplication objPreComplicate = new PatientPastComplication();
                    objPreComplicate.ComplicationName= lineItems[0];
                    lstPreviousComplicate.Add(objPreComplicate);
                }
            }
        }
        return lstPreviousComplicate;
    }

    // AssociateDiseases javascript table list

    public List<Complaint> getAssociateDiseases()
    {
        List<Complaint> lstAssDiseas = new List<Complaint>();
        string HidAssLine = HdnAssociate.Value;
        foreach (string splitString in HidAssLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    Complaint objComp = new Complaint();
                    objComp.ComplaintName = lineItems[0];
                    objComp.ComplaintDesc = lineItems[1];
                    lstAssDiseas.Add(objComp);
                }
            }
        }
        return lstAssDiseas;
    }

    // PriorVaccinations javascript table list

    public List<PatientVaccinationHistory> getPriorVaccinations()
    {
        List<PatientVaccinationHistory> lstPriVacc = new List<PatientVaccinationHistory>();
        string HidPrivLine = HdnVaccination.Value;
        foreach (string splitString in HidPrivLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientVaccinationHistory objVac = new PatientVaccinationHistory();
                    objVac.VaccinationName = lineItems[1];
                    objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
                    objVac.MonthName = lineItems[3];
                    objVac.VaccinationDose = lineItems[4];
                    objVac.IsBooster = lineItems[5];
                    lstPriVacc.Add(objVac);
                }
            }
        }
        return lstPriVacc;
    }

}
