using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;

public partial class ANC_ANCFollowUp2 : BaseControl
{
    int ComplaintId, Invid, ParentID, ParentIDCN;
    //long visitID = 1;
    //long createdBy = 0;
    int ExaminationId;
    int flag;
    int flag1;
    int flag2;
    int flagHistory, flagCom1, flagCom2, flagEctopic;
    //int Fetals = 2;
    string CN1, CN2;

    long PID = 0;

    List<History> lstHistory = new List<History>();
    List<Complication> lstCompNamee = new List<Complication>();
    List<Complication> lstComplication = new List<Complication>();
    
    //List<Complication> lstComplication2 = new List<Complication>();

    List<Examination> lstExamination = new List<Examination>();
    List<Examination> lstExamination1 = new List<Examination>();
    

    List<FetalPresentations> lstFetalPresentations = new List<FetalPresentations>();
    List<FetalPosition> lstFetalPosition = new List<FetalPosition>();
    List<FetalMovements> lstFetalMovements = new List<FetalMovements>();
    List<FetalFHS> lstFetalFHS = new List<FetalFHS>();
    List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();

    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<PatientComplication> lstPatientComplication = new List<PatientComplication>();
    List<PatientFetalFindings> lstPatientFetalFindings = new List<PatientFetalFindings>();

    ANCVitalInformation_BL ancbl;

    CheckBoxList cbAbnormal = new CheckBoxList();
    

    protected void Page_Load(object sender, EventArgs e)
    {
        ancbl = new ANCVitalInformation_BL(base.ContextInfo);
        //TVH.Attributes.Add("onclick", "OnTreeClick(event)");
        cbAbnormal.SelectedIndexChanged += new EventHandler(cbAbnormal_SelectedIndexChanged);
        
        ComplaintId = 534;
        Invid = 837;
        
        flag = 0;
        flag1 = 0;
        flag2 = 0;
        flagHistory = 0;
        flagCom1 = 0;
        flagCom2 = 0;


        CN1 = "Foetus";
        CN2 = "Maternal";
        ParentIDCN = 28;

        //ancbl.getANCFollowUP(ComplaintId, CN2, CN1, out lstHistory, out lstCompNamee, out lstComplication, out lstFetalPresentations, out lstFetalPosition, out lstFetalMovements, out lstFetalFHS, out lstComplaintInvestigation);

        //LoadANCFollowups(lstHistory, lstCompNamee, lstComplication, lstFetalPresentations, lstFetalPosition, lstFetalMovements, lstFetalFHS);

        if (!IsPostBack)
        {

            try
            {
                //divExam.Visible = false;
                //ANCVitalInformation_BL ancBL = new ANCVitalInformation_BL(base.ContextInfo);
                //Get all ANC complaint
                //ancBL.pGetANCComplication(out lstComplication);

                //SetANCComplaint(lstComplication);

                //settree(lstComplication1, lstComplication2);
                TVH.CssClass = "defaultfontcolor";

                //if (rblExamination1.SelectedItem.Text == "Normal")
                //{
                //    divExamOthers.Visible = false;
                //}
                //else
                //{
                //    divExamOthers.Visible = true;
                //}

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on pageload", ex);
            }


            chkAbnormal.Visible = false;
            chkGeneral.Visible = false;
            chkObstretric.Visible = false;
            
            //lblGeneral.Visible = false;
            //lblObstretric.Visible = false;

            //lblBreast.Visible = false;
            //lblNipples.Visible = false;
            //lblGenitalia.Visible = false;

            chkBreast.Visible = false;
            chkNipples.Visible = false;
            chkGenitalia.Visible = false;

            lblEctopic.Visible = false;
            chkEctopicGestation.Visible = false;
        }
    }

    public void LoadANCFollowups(int nooffetals, List<History> lstHistory, List<Complication> lstCompNamee, List<Complication> lstComplication, List<FetalPresentations> lstFetalPresentations, List<FetalPosition> lstFetalPosition, List<FetalMovements> lstFetalMovements, List<FetalFHS> lstFetalFHS)
    {
        foreach (ListItem lstS in chkSymptomatic.Items)
        {
            if (lstS.Selected)
            {
                flagHistory++;
                break;
            }
        }
        if (flagHistory == 0)
        {
            chkSymptomatic.DataSource = lstHistory;
            chkSymptomatic.DataTextField = "HistoryName";
            chkSymptomatic.DataValueField = "HistoryID";
            chkSymptomatic.DataBind();
        }

        foreach (ListItem lstM in chkMaternal.Items)
        {
            if (lstM.Selected)
            {
                flagCom1++;
                break;
            }
        }
        if (flagCom1 == 0)
        {
            chkMaternal.DataSource = lstCompNamee;
            chkMaternal.DataTextField = "ComplicationName";
            chkMaternal.DataValueField = "ComplicationID";
            chkMaternal.DataBind();
        }
        if (nooffetals > 0)
        {
            for (int i = 0; i < nooffetals; i++)
            {
                DropDownList ddlFPresentation = new DropDownList();
                ddlFPresentation.ID = "ddlFPresentation" + (i + 1).ToString();
                ddlFPresentation.DataSource = lstFetalPresentations;
                ddlFPresentation.DataTextField = "FetalPresentationDesc";
                ddlFPresentation.DataValueField = "FetalPresentationID";
                ddlFPresentation.DataBind();
                ddlFPresentation.Items.Insert(0, "Select");
                ddlFPresentation.Items[0].Value = "0";

                DropDownList ddlFPosition = new DropDownList();
                ddlFPosition.ID = "ddlFPosition" + (i + 1).ToString();
                ddlFPosition.DataSource = lstFetalPosition;
                ddlFPosition.DataTextField = "FetalPositionDesc";
                ddlFPosition.DataValueField = "FetalPositionID";
                ddlFPosition.DataBind();
                ddlFPosition.Items.Insert(0, "Select");
                ddlFPosition.Items[0].Value = "0";

                DropDownList ddlFMovement = new DropDownList();
                ddlFMovement.ID = "ddlFMovement" + (i + 1).ToString();
                ddlFMovement.DataSource = lstFetalMovements;
                ddlFMovement.DataTextField = "FetalMovementsDesc";
                ddlFMovement.DataValueField = "FetalMovementsID";
                ddlFMovement.DataBind();
                ddlFMovement.Items.Insert(0, "Select");
                ddlFMovement.Items[0].Value = "0";

                DropDownList ddlFFHS = new DropDownList();
                ddlFFHS.ID = "ddlFFHS" + (i + 1).ToString();
                ddlFFHS.DataSource = lstFetalFHS;
                ddlFFHS.DataTextField = "FetalFHSDesc";
                ddlFFHS.DataValueField = "FetalFHSID";
                ddlFFHS.DataBind();
                ddlFFHS.Items.Insert(0, "Select");
                ddlFFHS.Items[0].Value = "0";

                TextBox txtFhsOthers = new TextBox();
                txtFhsOthers.ID = "txtFhsOthers" + (i + 1).ToString();
                txtFhsOthers.Width = 75;

                int j = i + 1;

                Label lblFetalNo = new Label();
                lblFetalNo.ID = "lblFetalNo" + (i + 1).ToString();
                lblFetalNo.Text = j.ToString();

                TableCell tabcel1 = new TableCell();
                tabcel1.Controls.Add(lblFetalNo);

                TableCell tabcel2 = new TableCell();
                tabcel2.Controls.Add(ddlFPresentation);

                TableCell tabcel3 = new TableCell();
                tabcel3.Controls.Add(ddlFPosition);

                TableCell tabcel4 = new TableCell();
                tabcel4.Controls.Add(ddlFMovement);

                TableCell tabcel5 = new TableCell();
                tabcel5.Controls.Add(ddlFFHS);

                TableCell tabcel6 = new TableCell();
                tabcel6.Controls.Add(txtFhsOthers);

                TableRow tabrow = new TableRow();
                tabrow.Cells.Add(tabcel1);
                tabrow.Cells.Add(tabcel2);
                tabrow.Cells.Add(tabcel3);
                tabrow.Cells.Add(tabcel4);
                tabrow.Cells.Add(tabcel5);
                tabrow.Cells.Add(tabcel6);

                ddlTable.Rows.Add(tabrow);
            }
        }
        else
        {
            ddlTable.Visible = false;
            lblFetals.Text = "No Fetals Available";
        }
        if (!IsPostBack)
        {
            //SetANCComplaint(lstComplication);
        }
    }
    void settree(List<Complication> lstComplication11, List<Complication> lstComplication22)
    {
        if (lstComplication11 != null)
        {
            if (lstComplication11.Count > 0)
            {
                List<Complication> lstComp = new List<Complication>();
                foreach (Complication comp in lstComplication11)
                {
                    TVH.NodeIndent = 0;
                    TVH.Nodes.Add(new TreeNode(Convert.ToString(comp.ComplicationName), Convert.ToString(comp.ComplicationID)));
                }
            }
        }
        if (lstComplication22.Count > 0)
        {
            foreach (TreeNode tr in TVH.Nodes)
            {
                var query = from inv in lstComplication22
                            where inv.ParentID == 28
                            select inv;
                if (query.Count() > 0)
                {
                    int checkedStatus = 0;
                    foreach (TreeNode cTR in tr.ChildNodes)
                    {
                        for (int i = 0; i < query.Count(); i++)
                        {
                            long str = query.ElementAt(i).ComplicationID;
                            int childCount = tr.ChildNodes.Count;
                            if (cTR.Value == Convert.ToString(query.ElementAt(i).ComplicationID))
                            {
                                cTR.Checked = true;
                                checkedStatus++;
                                if (childCount == checkedStatus)
                                    tr.Checked = true;
                            }
                        }
                    }
                }
            }
        }
    }

    //void SetANCComplaint(List<Complication> lstComplication)
    //{
    //    TreeNode ndParent;
    //    //try
    //    //{
    //        if (lstComplication != null)
    //        {
    //            if (lstComplication.Count > 0)
    //            {
    //                List<Complication> lstComp = new List<Complication>();

    //                foreach (Complication comp in lstComplication)
    //                {
    //                    if (comp.ParentID == null || comp.ParentID == 0)
    //                    {
    //                        ndParent = new TreeNode();
    //                        TVH.NodeStyle.CssClass = "defaultfontcolor";
    //                        TVH.NodeIndent = 0;
    //                        ndParent.SelectAction = TreeNodeSelectAction.Expand;
    //                        ndParent.Text = comp.ComplicationName;
    //                        ndParent.Value = comp.ComplicationID.ToString();
    //                        TVH.Nodes.Add(ndParent);
    //                        AddCompChildNode(ndParent, lstComplication, comp.ComplicationID);
    //                    }
    //                }
    //            }
    //        }
    //    //}
    //    //catch (Exception ex)
    //    //{
    //    //    CLogger.LogError("Error while executing GetHistory", ex);
    //    //}
    //}

    //void AddCompChildNode(TreeNode tvn, IEnumerable<Complication> lstComplication, int parentID)
    //{


    //    if (lstComplication.Count() > 0)
    //    {
    //        TreeNode chldNode;

    //        var queryComps = from ex in lstComplication
    //                         where (ex.ParentID == parentID)
    //                         select ex;
    //        tvn.ShowCheckBox = true;
    //        foreach (var ex in queryComps)
    //        {
    //            chldNode = new TreeNode();
    //            chldNode.Text = ex.ComplicationName;
    //            chldNode.Value = ex.ComplicationID.ToString();
    //            chldNode.SelectAction = TreeNodeSelectAction.Expand;
    //            tvn.ShowCheckBox = false;
    //            tvn.ChildNodes.Add(chldNode);
                
    //            queryComps = from ex1 in lstComplication
    //                         where (ex1.ParentID == ex.ComplicationID)
    //                         select ex1;

    //            AddCompChildNode(chldNode, lstComplication, ex.ComplicationID);
    //        }    

            
    //    }
    //    else
    //    {
    //        return;
    //    }
    //}

    protected void rblExamination1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ancbl.pGetANCFollowUPExamination(ComplaintId, ParentID, out lstExamination, out lstExamination1, out lstComplication); 

        if (rblExamination1.SelectedItem.Text == "Abnormal")
        {
            chkAbnormal.Visible = true;

            chkAbnormal.DataSource = lstExamination;
            chkAbnormal.DataTextField = "ExaminationName";
            chkAbnormal.DataValueField = "ExaminationID";
            chkAbnormal.DataBind();
        }
        else
        {
            //lblGeneral.Visible = false;
            //lblObstretric.Visible = false;

            chkAbnormal.Visible = false;
            chkGeneral.Visible = false;
            chkObstretric.Visible = false;

            //lblBreast.Visible = false;
            //lblNipples.Visible = false;
            //lblGenitalia.Visible = false;

            chkBreast.Visible = false;
            chkNipples.Visible = false;
            chkGenitalia.Visible = false;
        }
    }
    protected void chkAbnormal_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach(ListItem lst in this.chkAbnormal.Items)
        {
            if (lst.Selected)
            {
                string exam = lst.Text;
                ParentID = int.Parse(lst.Value);
                ancbl.pGetANCFollowUPExamination(ComplaintId, ParentID, out lstExamination, out lstExamination1, out lstComplication);

                switch(exam)
                {
                    case "General":
                        
                        foreach (ListItem lstG in chkGeneral.Items)
                        {
                            if (lstG.Selected)
                            {
                                flag++;
                                break;
                            }
                        }
                        if (flag == 0)
                        {
                            lblGeneral.Visible = true;
                            chkGeneral.Visible = true;

                            chkGeneral.DataSource = lstExamination1;
                            chkGeneral.DataTextField = "ExaminationName";
                            chkGeneral.DataValueField = "ExaminationID";
                            chkGeneral.DataBind();
                        }
                        break;
                    case "Obstretric":     //Obstretric

                        foreach (ListItem lstO in chkObstretric.Items)
                        {
                            if (lstO.Selected)
                            {
                                flag1++;
                                break;
                            }
                        }
                        if (flag1 == 0)
                        {
                            lblObstretric.Visible = true;
                            chkObstretric.Visible = true;

                            chkObstretric.DataSource = lstExamination1;
                            chkObstretric.DataTextField = "ExaminationName";
                            chkObstretric.DataValueField = "ExaminationID";
                            chkObstretric.DataBind();
                        }
                        break;
                }
            }
            else
            {
                if (lst.Text == "General")
                {
                    lblGeneral.Visible = false;
                    chkGeneral.Items.Clear();
                    chkGeneral.Visible = false;
                }

                if (lst.Text == "Obstretric")
                {
                    lblObstretric.Visible = false;
                    chkObstretric.Items.Clear();
                    chkObstretric.Visible = false;

                    lblBreast.Visible = false;
                    lblNipples.Visible = false;
                    lblGenitalia.Visible = false;

                    chkBreast.Items.Clear();
                    chkNipples.Items.Clear();
                    chkGenitalia.Items.Clear();

                    chkBreast.Visible = false;
                    chkNipples.Visible = false;
                    chkGenitalia.Visible = false;

                }
            }
            
        }
    }
    protected void cbAbnormal_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void chkObstretric_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem lst in this.chkObstretric.Items)
        {
            if (lst.Selected)
            {
                string exam = lst.Text;
                ParentID = int.Parse(lst.Value);
                //if (chkObstretric.SelectedItem.Text != "")
                //{
                //ParentID = int.Parse(chkObstretric.SelectedItem.Value.ToString());
                ancbl.pGetANCFollowUPExamination(ComplaintId, ParentID, out lstExamination, out lstExamination1, out lstComplication);
                //}
                switch (exam)
                {
                    case "Breast":

                        foreach (ListItem lstB in chkBreast.Items)
                        {
                            if (lstB.Selected)
                            {
                                flag++;
                                break;
                            }
                        }
                        if (flag == 0)
                        {
                            lblBreast.Visible = true;
                            chkBreast.Visible = true;

                            chkBreast.DataSource = lstExamination1;
                            chkBreast.DataTextField = "ExaminationName";
                            chkBreast.DataValueField = "ExaminationID";
                            chkBreast.DataBind();
                        }
                        break;
                    case "Nipples":     //Nipples

                        foreach (ListItem lstN in chkNipples.Items)
                        {
                            if (lstN.Selected)
                            {
                                flag1++;
                                break;
                            }
                        }
                        if (flag1 == 0)
                        {
                            lblNipples.Visible = true;
                            chkNipples.Visible = true;

                            chkNipples.DataSource = lstExamination1;
                            chkNipples.DataTextField = "ExaminationName";
                            chkNipples.DataValueField = "ExaminationID";
                            chkNipples.DataBind();
                        }
                        break;
                    case "Genitalia":     //Genitalia

                        foreach (ListItem lstG in chkGenitalia.Items)
                        {
                            if (lstG.Selected)
                            {
                                flag2++;
                                break;
                            }
                        }
                        if (flag2 == 0)
                        {
                            lblGenitalia.Visible = true;
                            chkGenitalia.Visible = true;

                            chkGenitalia.DataSource = lstExamination1;
                            chkGenitalia.DataTextField = "ExaminationName";
                            chkGenitalia.DataValueField = "ExaminationID";
                            chkGenitalia.DataBind();
                        }
                        break;
                }
            }
            else
            {
                if (lst.Text == "Breast")
                {
                    lblBreast.Visible = false;
                    chkBreast.Items.Clear();
                    chkBreast.Visible = false;
                }

                if (lst.Text == "Nipples")
                {
                    lblNipples.Visible = false;
                    chkNipples.Items.Clear();
                    chkNipples.Visible = false;
                }

                if (lst.Text == "Genitalia")
                {
                    lblGenitalia.Visible = false;
                    chkGenitalia.Items.Clear();
                    chkGenitalia.Visible = false;
                }

            }
        }
    }
    protected void chkFoetus_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem lstchkF in this.chkFoetus.Items)
        {
            if (lstchkF.Selected)
            {
                string Foetus = lstchkF.Text;
                ParentID = int.Parse(lstchkF.Value);

                ancbl.pGetANCFollowUPExamination(ComplaintId, ParentID, out lstExamination, out lstExamination1, out lstComplication);

                switch (Foetus)
                {
                    case "Ectopic Gestation":

                        foreach (ListItem lstEctopic in chkEctopicGestation.Items)
                        {
                            if (lstEctopic.Selected)
                            {
                                flagEctopic++;
                                break;
                            }
                        }
                        if (flagEctopic == 0)
                        {
                            lblEctopic.Visible = true;
                            chkEctopicGestation.Visible = true;

                            chkEctopicGestation.DataSource = lstComplication;
                            chkEctopicGestation.DataTextField = "ComplicationName";
                            chkEctopicGestation.DataValueField = "ComplicationID";
                            chkEctopicGestation.DataBind();
                        }
                        break;

                }
            }
            else
            {
                if (lstchkF.Text == "Ectopic Gestation")
                {
                    lblEctopic.Visible = false;
                    chkEctopicGestation.Items.Clear();
                    chkEctopicGestation.Visible = false;
                }
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //ancbl.pInsertANCFollowup(lstPatientFetalFindings, out retStat);
        //ancbl.saveHECFC(lstPatientHistory, lstPatientExamination, lstPatientComplication, lstPatientFetalFindings);
    }


    //public List<PatientHistory> saveAncFollowUp1(List<PatientHistory> lstlstPatientHistory, List<PatientExamination> lstPatientExamination, List<PatientComplication> lstPatientComplication, List<PatientFetalFindings> lstPatientFetalFindings)
    //{

    //    long returnCode = -1;
    //    int retStat = -1;
    //    PatientFetalFindings pff = null;

    //    foreach (ListItem li in chkSymptomatic.Items)
    //    {
    //        if (li.Selected)
    //        {
    //            PatientHistory ph = new PatientHistory();

    //            ph.HistoryID = Convert.ToInt32(li.Value);
    //            ph.PatientVisitID = visitID;
    //            ph.HistoryName = li.Text;
    //            ph.CreatedBy = createdBy;
    //            ph.ComplaintId = ComplaintId;
    //            lstPatientHistory.Add(ph);
    //        }
    //    }
    //    if (txtSymptomatic.Text != "")
    //    {
    //        PatientHistory phO = new PatientHistory();
    //        phO.HistoryID = 0;
    //        phO.PatientVisitID = visitID;
    //        phO.HistoryName = txtSymptomatic.Text;
    //        phO.CreatedBy = createdBy;
    //        phO.ComplaintId = ComplaintId;
    //        lstPatientHistory.Add(phO);
    //    }

    //    if (rblExamination1.SelectedItem.Text == "Normal")
    //    {
    //        PatientExamination pe = new PatientExamination();

    //        pe.PatientVisitID = visitID;
    //        pe.ExaminationID = 0;
    //        pe.ExaminationName = rblExamination1.SelectedItem.Text;
    //        pe.Description
    //        pe.CreatedBy = createdBy;
    //        pe.ComplaintId = ComplaintId;
    //        lstPatientExamination.Add(pe);
    //    }
    //    else
    //    {
    //        foreach (ListItem lst in this.chkAbnormal.Items)
    //        {

    //            if (lst.Selected)
    //            {
    //                string exam = lst.Text;

    //                switch (exam)
    //                {
    //                    case "General":
    //                        foreach (ListItem lstG in chkGeneral.Items)
    //                        {
    //                            if (lstG.Selected)
    //                            {
    //                                PatientExamination pexG = new PatientExamination();

    //                                pexG.PatientVisitID = visitID;
    //                                pexG.ExaminationID = Convert.ToInt32(lstG.Value);
    //                                pexG.ExaminationName = lstG.Text;
    //                                pexG.CreatedBy = createdBy;
    //                                pexG.ComplaintId = ComplaintId;
    //                                lstPatientExamination.Add(pexG);
    //                            }
    //                        }
    //                        break;

    //                    case "Obstretric":
    //                        foreach (ListItem lstOb in this.chkObstretric.Items)
    //                        {
    //                            if (lstOb.Selected)
    //                            {
    //                                string examObs = lstOb.Text;

    //                                switch (examObs)
    //                                {
    //                                    case "Breast":
    //                                        foreach (ListItem lstB in chkBreast.Items)
    //                                        {
    //                                            if (lstB.Selected)
    //                                            {
    //                                                PatientExamination pexB = new PatientExamination();
    //                                                pexB.PatientVisitID = visitID;
    //                                                pexB.ExaminationID = Convert.ToInt32(lstB.Value);
    //                                                pexB.ExaminationName = lstB.Text;
    //                                                pexB.CreatedBy = createdBy;
    //                                                pexB.ComplaintId = ComplaintId;
    //                                                lstPatientExamination.Add(pexB);
    //                                            }
    //                                        }
    //                                        break;

    //                                    case "Nipples":
    //                                        foreach (ListItem lstN in chkNipples.Items)
    //                                        {
    //                                            if (lstN.Selected)
    //                                            {
    //                                                PatientExamination pexN = new PatientExamination();
    //                                                pexN.PatientVisitID = visitID;
    //                                                pexN.ExaminationID = Convert.ToInt32(lstN.Value);
    //                                                pexN.ExaminationName = lstN.Text;
    //                                                pexN.CreatedBy = createdBy;
    //                                                pexN.ComplaintId = ComplaintId;
    //                                                lstPatientExamination.Add(pexN);
    //                                            }
    //                                        }
    //                                        break;

    //                                    case "Genitalia":
    //                                        foreach (ListItem lstOG in chkGenitalia.Items)
    //                                        {
    //                                            if (lstOG.Selected)
    //                                            {
    //                                                PatientExamination pexOG = new PatientExamination();
    //                                                pexOG.PatientVisitID = visitID;
    //                                                pexOG.ExaminationID = Convert.ToInt32(lstOG.Value);
    //                                                pexOG.ExaminationName = lstOG.Text;
    //                                                pexOG.CreatedBy = createdBy;
    //                                                pexOG.ComplaintId = ComplaintId;
    //                                                lstPatientExamination.Add(pexOG);
    //                                            }
    //                                        }
    //                                        break;
    //                                }
    //                            }
    //                        }

    //                        break;
    //                }

    //            }
    //        }
    //    }
    //    if (txtExamination.Text != "")
    //    {
    //        PatientExamination pexO = new PatientExamination();
    //        pexO.PatientVisitID = visitID;
    //        pexO.ExaminationID = 0;
    //        pexO.ExaminationName = txtExamination.Text;
    //        pe.Description
    //        pexO.CreatedBy = createdBy;
    //        pexO.ComplaintId = ComplaintId;
    //        lstPatientExamination.Add(pexO);
    //    }


    //    foreach (ListItem liCM in chkMaternal.Items)
    //    {
    //        PatientComplication pc = new PatientComplication();

    //        if (liCM.Selected)
    //        {
    //            pc.PatientVisitID = visitID;
    //            pc.ComplicationID = Convert.ToInt32(liCM.Value);
    //            pc.ComplicationName = liCM.Text;

    //            pc.CreatedBy = createdBy;
    //            pc.ComplaintID = ComplaintId;
    //            lstPatientComplication.Add(pc);
    //        }
    //    }
    //    if (txtMComplication.Text != "")
    //    {
    //        PatientComplication pcO = new PatientComplication();
    //        pcO.PatientVisitID = visitID;
    //        pcO.ComplicationID = 0;
    //        pcO.ComplicationName = txtMComplication.Text;
    //        pcO.CreatedBy = createdBy;
    //        lstPatientComplication.Add(pcO);
    //    }

    //    if (TVH.CheckedNodes.Count > 0)
    //    {

    //        foreach (TreeNode node in TVH.CheckedNodes)
    //        {
    //            PatientComplication pcf = new PatientComplication();
    //            pcf.PatientVisitID = visitID;
    //            pcf.ComplicationID = Convert.ToInt32(node.Value);
    //            pcf.ComplicationName = node.Text;

    //            pcf.CreatedBy = createdBy;
    //            lstPatientComplication.Add(pcf);
    //        }
    //    }
    //    if (txtFComplication.Text != "")
    //    {
    //        PatientComplication pcfO = new PatientComplication();
    //        pcfO.PatientVisitID = visitID;
    //        pcfO.ComplicationID = 0;
    //        pcfO.ComplicationName = txtMComplication.Text;
    //        pcfO.CreatedBy = createdBy;
    //        lstPatientComplication.Add(pcfO);
    //    }

    //    foreach (TableRow tr in ddlTable.Rows)
    //    {
    //        object sttrr = tr.GetType().Name;
    //        if (tr.GetType().Name != "TableHeaderRow")
    //        {

    //            int index = ddlTable.Rows.GetRowIndex(tr);

    //            Label lblFno = (Label)ddlTable.FindControl("lblFetalNo" + index);
    //            DropDownList ddlfpr = (DropDownList)ddlTable.FindControl("ddlFPresentation" + index);
    //            DropDownList ddlfpo = (DropDownList)ddlTable.FindControl("ddlFPosition" + index);
    //            DropDownList ddlfmo = (DropDownList)ddlTable.FindControl("ddlFMovement" + index);
    //            DropDownList ddlffh = (DropDownList)ddlTable.FindControl("ddlFFHS" + index);
    //            TextBox txtFhs = (TextBox)ddlTable.FindControl("txtFhsOthers" + index);

    //            string txt = ddlfpr.SelectedItem.Text;
    //            string txt1 = ddlfpo.SelectedItem.Text;
    //            string txt2 = ddlfmo.SelectedItem.Text;
    //            string txt3 = ddlffh.SelectedItem.Text;
    //            string txt4 = txtFhs.Text;

    //            PatientFetalFindings pff = new PatientFetalFindings();

    //            pff.PatientID = PID;
    //            pff.PatientVisitID = visitID;
    //            pff.FetalNumber = int.Parse(lblFno.Text);
    //            pff.FetalPresentationDesc = ddlfpr.SelectedItem.Text;
    //            pff.FetalPositionDesc = ddlfpo.SelectedItem.Text;
    //            pff.FetalMovementsDesc = ddlfmo.SelectedItem.Text;
    //            pff.FetalFHSDesc = ddlffh.SelectedItem.Text;
    //            pff.FetalOthers = txtFhs.Text;

    //            lstPatientFetalFindings.Add(pff);

    //        }
    //    }
    //}


    public List<PatientHistory> GetPatientHistory(long visitID)
    {
        Int64.TryParse(Request.QueryString["pid"], out PID);

        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();

        foreach (ListItem li in chkSymptomatic.Items)
        {
            if (li.Selected)
            {
                PatientHistory ph = new PatientHistory();
                ph.HistoryID = Convert.ToInt32(li.Value);
                ph.PatientVisitID = visitID;
                ph.HistoryName = li.Text;
                ph.CreatedBy = LID;
                ph.ComplaintId = ComplaintId;
                lstPatientHistory.Add(ph);
            }
        }
        if (hResultvalues.Value != string.Empty)
        {
            

            //a~1^Resistant To~2^
            string desc = string.Empty;

            foreach (string strValues in hResultvalues.Value.Split('^'))
            {
                if (strValues != string.Empty)
                {
                    PatientHistory phO = new PatientHistory();
                    //desc += desc == string.Empty ? strValues.Split('~')[0] : "," + strValues.Split('~')[0];
                    desc = strValues.Split('~')[0];
                    phO.HistoryID = 0;
                    phO.PatientVisitID = visitID;
                    phO.HistoryName = null;
                    phO.Description = desc;
                    phO.CreatedBy = LID;
                    phO.ComplaintId = ComplaintId;
                    lstPatientHistory.Add(phO);
                }
            }

        }

        return lstPatientHistory;
        
    }

    public List<PatientExamination> GetPatientExamination(long visitID)
    {
        Int64.TryParse(Request.QueryString["pid"], out PID);

        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        
        #region Commented Codes
        //if (rblExamination1.SelectedItem.Text == "Normal")
        //{
        //    PatientExamination pe = new PatientExamination();

        //    pe.PatientVisitID = visitID;
        //    pe.ExaminationID = 0;
        //    pe.ExaminationName = rblExamination1.SelectedItem.Text;
        //    pe.Description = "";
        //    pe.CreatedBy = LID;
        //    pe.ComplaintId = ComplaintId;
        //    lstPatientExamination.Add(pe);
        //}
        //else
        //{
        //    foreach (ListItem lst in this.chkAbnormal.Items)
        //    {

        //        if (lst.Selected)
        //        {
        //            string exam = lst.Text;

        //            switch (exam)
        //            {
        //                case "General":
        //                    foreach (ListItem lstG in chkGeneral.Items)
        //                    {
        //                        if (lstG.Selected)
        //                        {
        //                            PatientExamination pexG = new PatientExamination();

        //                            pexG.PatientVisitID = visitID;
        //                            pexG.ExaminationID = Convert.ToInt32(lstG.Value);
        //                            pexG.ExaminationName = lstG.Text;
        //                            pexG.CreatedBy = LID;
        //                            pexG.ComplaintId = ComplaintId;
        //                            lstPatientExamination.Add(pexG);
        //                        }
        //                    }
        //                    break;

        //                case "Obstretric":
        //                    foreach (ListItem lstOb in this.chkObstretric.Items)
        //                    {
        //                        if (lstOb.Selected)
        //                        {
        //                            string examObs = lstOb.Text;

        //                            switch (examObs)
        //                            {
        //                                case "Breast":
        //                                    foreach (ListItem lstB in chkBreast.Items)
        //                                    {
        //                                        if (lstB.Selected)
        //                                        {
        //                                            PatientExamination pexB = new PatientExamination();
        //                                            pexB.PatientVisitID = visitID;
        //                                            pexB.ExaminationID = Convert.ToInt32(lstB.Value);
        //                                            pexB.ExaminationName = lstB.Text;
        //                                            pexB.CreatedBy = LID;
        //                                            pexB.ComplaintId = ComplaintId;
        //                                            lstPatientExamination.Add(pexB);
        //                                        }
        //                                    }
        //                                    break;

        //                                case "Nipples":
        //                                    foreach (ListItem lstN in chkNipples.Items)
        //                                    {
        //                                        if (lstN.Selected)
        //                                        {
        //                                            PatientExamination pexN = new PatientExamination();
        //                                            pexN.PatientVisitID = visitID;
        //                                            pexN.ExaminationID = Convert.ToInt32(lstN.Value);
        //                                            pexN.ExaminationName = lstN.Text;
        //                                            pexN.CreatedBy = LID;
        //                                            pexN.ComplaintId = ComplaintId;
        //                                            lstPatientExamination.Add(pexN);
        //                                        }
        //                                    }
        //                                    break;

        //                                case "Genitalia":
        //                                    foreach (ListItem lstOG in chkGenitalia.Items)
        //                                    {
        //                                        if (lstOG.Selected)
        //                                        {
        //                                            PatientExamination pexOG = new PatientExamination();
        //                                            pexOG.PatientVisitID = visitID;
        //                                            pexOG.ExaminationID = Convert.ToInt32(lstOG.Value);
        //                                            pexOG.ExaminationName = lstOG.Text;
        //                                            pexOG.CreatedBy = LID;
        //                                            pexOG.ComplaintId = ComplaintId;
        //                                            lstPatientExamination.Add(pexOG);
        //                                        }
        //                                    }
        //                                    break;
        //                            }
        //                        }
        //                    }

        //                    break;
        //            }

        //        }
        //    }
        //}

        //---------------------

        #endregion

        //if (txtExamination.Text != "")
        //{
        //    PatientExamination pexO = new PatientExamination();
        //    pexO.PatientVisitID = visitID;
        //    pexO.ExaminationID = 0;
        //    pexO.ExaminationName = txtExamination.Text;
        //    pexO.Description = "";
        //    pexO.CreatedBy = createdBy;
        //    pexO.ComplaintId = ComplaintId;
        //    lstPatientExamination.Add(pexO);
        //}


        if (rbNormal.Checked == true)
        {
            //PatientExamination pe = new PatientExamination();

            //pe.PatientVisitID = visitID;
            //pe.ExaminationID = 0;
            //pe.ExaminationName = rbNormal.Text;
            //pe.Description = "";
            //pe.CreatedBy = LID;
            //pe.ComplaintId = ComplaintId;
            //lstPatientExamination.Add(pe);
        }
        else if (rbAbNormal.Checked == true)
        {
            #region General
            if (chkGenH.Checked == true)
            {
                foreach (ListItem lstG in cblGeneral.Items)
                {
                    if (lstG.Selected)
                    {
                        PatientExamination pexG = new PatientExamination();

                        pexG.PatientVisitID = visitID;
                        pexG.ExaminationID = Convert.ToInt32(lstG.Value);
                        pexG.ExaminationName = lstG.Text;
                        pexG.CreatedBy = LID;
                        pexG.ComplaintId = ComplaintId;
                        lstPatientExamination.Add(pexG);
                    }
                }
            }
            #endregion

            #region Obstretic

            if (chkObsH.Checked == true)
            {
                if (chkBreastH.Checked == true)
                {
                    foreach (ListItem lstB in cblBreastO.Items)
                    {
                        if (lstB.Selected)
                        {
                            PatientExamination pexB = new PatientExamination();
                            pexB.PatientVisitID = visitID;
                            pexB.ExaminationID = Convert.ToInt32(lstB.Value);
                            pexB.ExaminationName = lstB.Text;
                            pexB.CreatedBy = LID;
                            pexB.ComplaintId = ComplaintId;
                            lstPatientExamination.Add(pexB);
                        }
                    }
                }
                if (chkNipplesH.Checked == true)
                {
                    foreach (ListItem lstN in cblNipplesO.Items)
                    {
                        if (lstN.Selected)
                        {
                            PatientExamination pexN = new PatientExamination();
                            pexN.PatientVisitID = visitID;
                            pexN.ExaminationID = Convert.ToInt32(lstN.Value);
                            pexN.ExaminationName = lstN.Text;
                            pexN.CreatedBy = LID;
                            pexN.ComplaintId = ComplaintId;
                            lstPatientExamination.Add(pexN);
                        }
                    }
                }
                if (chkGenitaliaH.Checked == true)
                {
                    foreach (ListItem lstOG in cblGenetaliaO.Items)
                    {
                        if (lstOG.Selected)
                        {
                            PatientExamination pexOG = new PatientExamination();
                            pexOG.PatientVisitID = visitID;
                            pexOG.ExaminationID = Convert.ToInt32(lstOG.Value);
                            pexOG.ExaminationName = lstOG.Text;
                            pexOG.CreatedBy = LID;
                            pexOG.ComplaintId = ComplaintId;
                            lstPatientExamination.Add(pexOG);
                        }
                    }
                }
            }

            #endregion
        }

        if (hdnExaminations.Value != string.Empty)
        {
            

            //a~1^Resistant To~2^
            string desc = string.Empty;

            foreach (string strValues in hdnExaminations.Value.Split('^'))
            {
                if (strValues != string.Empty)
                {
                    PatientExamination pexOG = new PatientExamination();

                    //desc += desc == string.Empty ? strValues.Split('~')[0] : "," + strValues.Split('~')[0];
                    desc = strValues.Split('~')[0];
                    pexOG.ExaminationID = 0;
                    pexOG.PatientVisitID = visitID;
                    pexOG.Description = desc;
                    pexOG.CreatedBy = LID;
                    pexOG.ComplaintId = ComplaintId;
                    lstPatientExamination.Add(pexOG);
                }
            }

        }

        return lstPatientExamination;
    }

    public List<PatientComplication> GetPatientComplication(long visitID)
    {
        Int64.TryParse(Request.QueryString["pid"], out PID);

        List<PatientComplication> lstPatientComplication = new List<PatientComplication>();
        foreach (ListItem liCM in chkMaternal.Items)
        {
            PatientComplication pc = new PatientComplication();

            if (liCM.Selected)
            {
                pc.PatientVisitID = visitID;
                pc.ComplicationID = Convert.ToInt32(liCM.Value);
                pc.ComplicationName = liCM.Text;
                pc.CreatedBy = LID;
                pc.ComplaintId = ComplaintId;
                pc.PatientID = PID;
                // M Refers to Maternal
                pc.ANCStatus = "M";
                lstPatientComplication.Add(pc);
            }
        }

        if (hdnMComplication.Value != string.Empty)
        {
            

            //a~1^Resistant To~2^
            string desc = string.Empty;

            foreach (string strValues in hdnMComplication.Value.Split('^'))
            {
                if (strValues != string.Empty)
                {
                    PatientComplication pcO = new PatientComplication();
                    //desc += desc == string.Empty ? strValues.Split('~')[0] : "," + strValues.Split('~')[0];
                    desc = strValues.Split('~')[0];
                    pcO.ComplicationID = 0;
                    pcO.PatientVisitID = visitID;
                    pcO.ComplicationName = desc;
                    pcO.CreatedBy = LID;
                    pcO.ComplaintId = ComplaintId;
                    pcO.PatientID = PID;
                    // M Refers to Maternal
                    pcO.ANCStatus = "M";
                    lstPatientComplication.Add(pcO);
                }
            }

        }

        //if (TVH.CheckedNodes.Count > 0)
        //{

        //    foreach (TreeNode node in TVH.CheckedNodes)
        //    {
        //        PatientComplication pcf = new PatientComplication();
        //        pcf.PatientVisitID = visitID;
        //        pcf.ComplicationID = Convert.ToInt32(node.Value);
        //        pcf.ComplicationName = node.Text;

        //        pcf.CreatedBy = LID;
        //        pcf.PatientID = PID;

        //        // F Refers to Foetus
        //        pcf.ANCStatus = "F";
        //        lstPatientComplication.Add(pcf);
        //    }
        //}

        foreach (ListItem liCF in cblFoetus.Items)
        {
            PatientComplication pcf = new PatientComplication();

            if (liCF.Selected)
            {
                pcf.PatientVisitID = visitID;
                pcf.ComplicationID = Convert.ToInt32(liCF.Value);
                pcf.ComplicationName = liCF.Text;
                pcf.CreatedBy = LID;
                pcf.ComplaintId = ComplaintId;
                pcf.PatientID = PID;
                // F Refers to Foetus
                pcf.ANCStatus = "F";
                lstPatientComplication.Add(pcf);
            }
        }

        if (hdnFComplication.Value != string.Empty)
        {
            

            //a~1^Resistant To~2^
            string desc = string.Empty;

            foreach (string strValues in hdnFComplication.Value.Split('^'))
            {
                if (strValues != string.Empty)
                {
                    PatientComplication pcfO = new PatientComplication();
                    //desc += desc == string.Empty ? strValues.Split('~')[0] : "," + strValues.Split('~')[0];
                    desc = strValues.Split('~')[0];
                    pcfO.ComplicationID = 0;
                    pcfO.PatientVisitID = visitID;
                    pcfO.ComplicationName = desc;
                    pcfO.CreatedBy = LID;
                    pcfO.ComplaintId = ComplaintId;
                    pcfO.PatientID = PID;
                    
                    // F Refers to Foetus
                    pcfO.ANCStatus = "F";

                    lstPatientComplication.Add(pcfO);
                }
            }

        }
        return lstPatientComplication;
    }

    public List<PatientFetalFindings> GetPatientFetalFindings(long visitID)
    {
        List<PatientFetalFindings> lstPatientFetalFindings = new List<PatientFetalFindings>();
        foreach (TableRow tr in ddlTable.Rows)
        {
            object sttrr = tr.GetType().Name;
            if (tr.GetType().Name != "TableHeaderRow")
            {

                int index = ddlTable.Rows.GetRowIndex(tr);

                Label lblFno = (Label)ddlTable.FindControl("lblFetalNo" + index);
                DropDownList ddlfpr = (DropDownList)ddlTable.FindControl("ddlFPresentation" + index);
                DropDownList ddlfpo = (DropDownList)ddlTable.FindControl("ddlFPosition" + index);
                DropDownList ddlfmo = (DropDownList)ddlTable.FindControl("ddlFMovement" + index);
                DropDownList ddlffh = (DropDownList)ddlTable.FindControl("ddlFFHS" + index);
                TextBox txtFhs = (TextBox)ddlTable.FindControl("txtFhsOthers" + index);

                string txt = ddlfpr.SelectedValue.ToString();
                string txt1 = ddlfpo.SelectedValue.ToString();
                string txt2 = ddlfmo.SelectedValue.ToString();
                string txt3 = ddlffh.SelectedValue.ToString();

                string txt4 = txtFhs.Text;


                    PatientFetalFindings pff = new PatientFetalFindings();

                    pff.PatientID = PID;
                    pff.PatientVisitID = visitID;
                    pff.FetalNumber = int.Parse(lblFno.Text);
                    //pff.FetalPresentationDesc = ddlfpr.SelectedItem.Text;
                    //pff.FetalPositionDesc = ddlfpo.SelectedItem.Text;
                    //pff.FetalMovementsDesc = ddlfmo.SelectedItem.Text;
                    //pff.FetalFHSDesc = ddlffh.SelectedItem.Text;

                    if (ddlfpr.SelectedValue.ToString() != "0")
                    {
                        pff.FetalPresentationDesc = ddlfpr.SelectedItem.Text;
                    }
                    else
                    {
                        pff.FetalPresentationDesc = "0";
                    }

                    if (ddlfpo.SelectedValue.ToString() != "0")
                    {
                        pff.FetalPositionDesc = ddlfpo.SelectedItem.Text;
                    }
                    else
                    {
                        pff.FetalPositionDesc = "0";
                    }

                    if (ddlfmo.SelectedValue.ToString() != "0")
                    {
                        pff.FetalMovementsDesc = ddlfmo.SelectedItem.Text;
                    }
                    else
                    {
                        pff.FetalMovementsDesc = "0";
                    }
                    //pff.FetalMovementsDesc = ddlfmo.SelectedItem.Text;
                    if (ddlffh.SelectedValue.ToString() != "0")
                    {
                        pff.FetalFHSDesc = ddlffh.SelectedItem.Text;
                    }
                    else
                    {
                        pff.FetalFHSDesc = "0";
                    }

                    pff.IsNormalFinding = rblFetals.SelectedValue.ToString();
                    pff.FetalOthers = txtFhs.Text;
                    pff.CreatedBy = LID;

                    lstPatientFetalFindings.Add(pff);
                //}
                //else
                //{

                //}

            }
        }
        return lstPatientFetalFindings;
    }

    public void setPatientHistory(List<PatientHistory> lstPatientHistory, List<PatientExamination> lstPatientExamination, List<PatientComplication> lstPatientComplication, List<PatientFetalFindings> lstPatientFetalFindings)
    {
        #region Bind Patient History if Exists

        if (lstPatientHistory.Count > 0)
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTable", "javascript:showExam();", true);
            string retrivepHistory = string.Empty;
            string historyDesc = string.Empty;

            int pHistory = 0;
            for (int ii = 0; ii < lstPatientHistory.Count; ii++)
            {
                foreach (ListItem li in chkSymptomatic.Items)
                {
                    if (li.Value == lstPatientHistory[ii].HistoryID.ToString())
                    {
                        li.Selected = true;
                    }
                }

                if (lstPatientHistory[ii].HistoryID == 0)
                {
                    pHistory = pHistory + 1;
                    historyDesc = lstPatientHistory[ii].Description;

                    retrivepHistory += historyDesc + "~" + pHistory + "^";
                }
            }
            hResultvalues.Value = retrivepHistory;

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTable", "javascript:AddItemsToTableSymptomatic('" + btnAddProcess.ClientID + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTable", "javascript:TableSymptomatic('" + btnAddProcess.ClientID + "');", true);
        }

        #endregion

        #region Bind Patient Examination if Exists

        if (lstPatientExamination.Count > 0)
        {
            //rbAbNormal.Checked = true;
            //chkObsH.Checked = true;
            //chkGenH.Checked = true;

            string retrivepExam = string.Empty;
            string ExamDesc = string.Empty;

            int pExam = 0;
            int countGeneral = 0;
            int countObstraticBNG = 0;
            int countBreast = 0;
            int countNipples = 0;
            int countGenitalia = 0;

            for (int jj = 0; jj < lstPatientExamination.Count; jj++)
            {
                foreach (ListItem liExamG in cblGeneral.Items)
                {
                    if (liExamG.Value == lstPatientExamination[jj].ExaminationID.ToString())
                    {
                        countGeneral = countGeneral + 1;
                        liExamG.Selected = true;
                    }
                }

                foreach (ListItem liExamB in cblBreastO.Items)
                {
                    if (liExamB.Value == lstPatientExamination[jj].ExaminationID.ToString())
                    {
                        countObstraticBNG = countObstraticBNG + 1;
                        countBreast = countBreast + 1;
                        liExamB.Selected = true;
                    }
                }

                foreach (ListItem liExamN in cblNipplesO.Items)
                {
                    if (liExamN.Value == lstPatientExamination[jj].ExaminationID.ToString())
                    {
                        countObstraticBNG = countObstraticBNG + 1;
                        countNipples = countNipples + 1;
                        liExamN.Selected = true;
                    }
                }

                foreach (ListItem liExamG in cblGenetaliaO.Items)
                {
                    if (liExamG.Value == lstPatientExamination[jj].ExaminationID.ToString())
                    {
                        countObstraticBNG = countObstraticBNG + 1;
                        countGenitalia = countGenitalia + 1;
                        liExamG.Selected = true;
                    }
                }

                if (lstPatientExamination[jj].ExaminationID == 0)
                {
                    pExam = pExam + 1;
                    ExamDesc = lstPatientExamination[jj].Description;

                    retrivepExam += ExamDesc + "~" + pExam + "^";
                }
            }
            if (countGeneral > 0)
            {
                rbAbNormal.Checked = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "rblAbN", "javascript:ValidateExam('" + rbAbNormal.ClientID + "');", true);
                chkGenH.Checked = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "rblchkG", "javascript:ValidateGenObs('" + chkGenH.ClientID + "');", true);
            }
            if (countObstraticBNG > 0)
            {
                chkObsH.Checked = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "rblchkH", "javascript:ValidateGenObs('" + chkObsH.ClientID + "');", true);
                if (countBreast > 0)
                {
                    chkBreastH.Checked = true;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "cchkBreast", "javascript:validateObsChild('" + chkBreastH.ClientID + "');", true);
                }
                if (countNipples > 0)
                {
                    chkNipplesH.Checked = true;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "cchkNipples", "javascript:validateObsChild('" + chkNipplesH.ClientID + "');", true);
                }
                if (countGenitalia > 0)
                {
                    chkGenitaliaH.Checked = true;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "cchkGenitalia", "javascript:validateObsChild('" + chkGenitaliaH.ClientID + "');", true);
                }
            }
            hdnExaminations.Value = retrivepExam;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTableExam", "javascript:TableExamination('" + Button1.ClientID + "');", true);
        }

        #endregion

        #region Bind Patient Complication if Exists

        if (lstPatientComplication.Count > 0)
        {
            string retrivepcompM = string.Empty;
            string CompDescM = string.Empty;

            string retrivepcompF = string.Empty;
            string CompDescF = string.Empty;

            int pCompM = 0;
            int pCompF = 0;

            for (int kk = 0; kk < lstPatientComplication.Count; kk++)
            {
                foreach (ListItem liComp in chkMaternal.Items)
                {
                    if (liComp.Value == lstPatientComplication[kk].ComplicationID.ToString())
                    {
                        liComp.Selected = true;
                    }
                }
                if (lstPatientComplication[kk].ComplicationID == 0 && lstPatientComplication[kk].ANCStatus == "M")
                {
                    pCompM = pCompM + 1;
                    CompDescM = lstPatientComplication[kk].ComplicationName;

                    retrivepcompM += CompDescM + "~" + pCompM + "^";
                }
            }
            hdnMComplication.Value = retrivepcompM;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTableCompM", "javascript:TableCompM('" + btnMComplication.ClientID + "');", true);

            for (int mm = 0; mm < lstPatientComplication.Count; mm++)
            {
                foreach (ListItem liComp in cblFoetus.Items)
                {
                    if (liComp.Value == lstPatientComplication[mm].ComplicationID.ToString())
                    {
                        liComp.Selected = true;
                    }
                }
                if (lstPatientComplication[mm].ComplicationID == 0 && lstPatientComplication[mm].ANCStatus == "F")
                {
                    pCompF = pCompF + 1;
                    CompDescF = lstPatientComplication[mm].ComplicationName;

                    retrivepcompF += CompDescF + "~" + pCompF + "^";
                }
            }
            hdnFComplication.Value = retrivepcompF;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTableCompF", "javascript:TableCompF('" + btnFComplication.ClientID + "');", true);

        }

        #endregion

        #region Bind Patient Fetal findinds if Exists

        if (lstPatientFetalFindings.Count > 0)
        {
            for (int s = 0; s < lstPatientFetalFindings.Count; s++)
            {
                foreach (TableRow tr in ddlTable.Rows)
                {
                    object sttrr = tr.GetType().Name;
                    if (tr.GetType().Name != "TableHeaderRow")
                    {
                        int index = ddlTable.Rows.GetRowIndex(tr);

                        Label lblFno = (Label)ddlTable.FindControl("lblFetalNo" + index);

                        if (lblFno.Text == lstPatientFetalFindings[s].FetalNumber.ToString())
                        {
                            if (lstPatientFetalFindings[s].FetalPresentationDesc != "0")
                            {
                                DropDownList ddlFPresentation = (DropDownList)this.FindControl("ddlFPresentation" + lblFno.Text);
                                ddlFPresentation.SelectedValue = lstPatientFetalFindings[s].FetalPresentationID.ToString();
                            }
                            if (lstPatientFetalFindings[s].FetalPositionDesc != "0")
                            {
                                DropDownList ddlFPosition = (DropDownList)this.FindControl("ddlFPosition" + lblFno.Text);
                                ddlFPosition.SelectedValue = lstPatientFetalFindings[s].FetalPositionID.ToString();
                            }
                            if (lstPatientFetalFindings[s].FetalMovementsDesc != "0")
                            {
                                DropDownList ddlFMovements = (DropDownList)this.FindControl("ddlFMovement" + lblFno.Text);
                                ddlFMovements.SelectedValue = lstPatientFetalFindings[s].FetalMovementsID.ToString();
                            }
                            if (lstPatientFetalFindings[s].FetalFHSDesc != "0")
                            {
                                DropDownList ddlFHS = (DropDownList)this.FindControl("ddlFFHS" + lblFno.Text);
                                ddlFHS.SelectedValue = lstPatientFetalFindings[s].FetalFHSID.ToString();
                            }
                            if (lstPatientFetalFindings[s].FetalOthers != "")
                            {
                                TextBox txtFetalOthers = (TextBox)this.FindControl("txtFhsOthers" + lblFno.Text);
                                txtFetalOthers.Text = lstPatientFetalFindings[s].FetalOthers.ToString();
                            }
                        }
                    }
                }
            }
        }

        #endregion
    }
}
