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
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;
using Attune.Podium.BillingEngine;
using System.Globalization;

public partial class Nurse_NurseAdvice : BasePage 
{


    public Nurse_NurseAdvice()
        : base("Nurse\\NurseAdvice.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long visitID = 0;
    long PatientID = 0;
    long returnCode = -1;
    Uri_BL uiBl ;
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
    List<DrugDetails> lstDDforAdding = new List<DrugDetails>();
    List<DrugDetails> lstAdminsteredDrugs = new List<DrugDetails>();

    protected void Page_Load(object sender, EventArgs e)
    {
        uiBl = new Uri_BL(base.ContextInfo);
        try
        {
            PatientID = Convert.ToInt64(Request.QueryString["PID"]);
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
            patientHeader.PatientID = PatientID;
            if (!IsPostBack)
            {
                
                
                returnCode = uiBl.GetSearchPatientPrescription(visitID, LID, RoleID, out lstDrugDetails, out lstAdminsteredDrugs);

                //List<DrugDetails> OtherUser = (from DDOU in lstDrugDetails
                //                               where (
                //                                            (DDOU.RoleID != RoleID)
                //                                            &&
                //                                         (((DDOU.AdministeredAtFrom == System.DateTime.MinValue)
                //                                            &&
                //                                            (DDOU.AdministeredAtTo == System.DateTime.MinValue)
                //                                         )
                //                                           ||
                //                                         (
                //                                            (DDOU.AdministeredAtFrom == Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                            &&
                //                                            (DDOU.AdministeredAtTo == Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                         ))
                //                                     )
                //                               select DDOU).ToList();

                //List<DrugDetails> LoggedUser = (from DDLU in lstDrugDetails
                //                                where (
                //                                            (DDLU.RoleID == RoleID)
                //                                            &&
                //                                          ((
                //                                            (DDLU.AdministeredAtFrom == System.DateTime.MinValue)
                //                                            &&
                //                                            (DDLU.AdministeredAtTo == System.DateTime.MinValue)
                //                                          )
                //                                            ||
                //                                          (
                //                                            (DDLU.AdministeredAtFrom == Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                            &&
                //                                            (DDLU.AdministeredAtTo == Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                          ))
                //                                      )
                //                                select DDLU).ToList();

                //List<DrugDetails> DrugChart = (from DC in lstDrugDetails
                //                               where (
                //                                        (
                //                                            (DC.AdministeredAtFrom != Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                            ||
                //                                            (DC.AdministeredAtTo != Convert.ToDateTime("01/01/1800 00:00:00"))
                //                                        )
                //                                        &&
                //                                        (
                //                                            (DC.AdministeredAtFrom != Convert.ToDateTime("01/01/0001 00:00:00"))
                //                                            ||
                //                                            (DC.AdministeredAtTo != Convert.ToDateTime("01/01/0001 00:00:00"))
                //                                        )
                //                                     )
                //                               select DC).ToList();

                uAd.SetPrescription(lstDrugDetails);

                if (lstAdminsteredDrugs.Count > 0)
                {
                    grdDrugChart.DataSource = lstAdminsteredDrugs;
                    grdDrugChart.DataBind();
                }

                if (lstDrugDetails.Count > 0)
                {
                    string rName = string.Empty;
                    //if (RoleName == "Nurse")
                    //{
                        rName = "Physician";
                    //    lblPrescribedBy.Text = "Below Drugs Prescribed By : " + rName;
                    //}
                    //else if (RoleName == "Physician")
                    //{
                    //    rName = "Nurse";
                        lblPrescribedBy.Text = "Below Drugs Administred By : " + rName;
                    //}

                    //lstDDforAdding = lstDrugDetails;
                    grdPrescription1.DataSource = lstDrugDetails;
                    grdPrescription1.DataBind();
                }
                hdNewID.Value = "-1";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load NurseAdvise", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime FDate, TDate;
            visitID = Convert.ToInt64(Request.QueryString["vid"]);

            lstDrugDetails = uAd.GetPrescription(visitID);
            List<DrugDetails> lstDurgsAdmined = new List<DrugDetails>();
            foreach (GridViewRow gr in grdPrescription1.Rows)
            {
                if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
                {
                    TextBox txtFDate = (TextBox)gr.FindControl("txtFDate");
                    TextBox txtTDate = (TextBox)gr.FindControl("txtTDate");
                    Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");

                    if (txtFDate.Text != "")
                    {
                        FDate = Convert.ToDateTime(txtFDate.Text);
                    }
                    else
                    {
                        FDate = new DateTime(1800, 1, 1);
                    }
                    if (txtTDate.Text != "")
                    {
                        TDate = Convert.ToDateTime(txtTDate.Text);
                    }
                    else
                    {
                        TDate = new DateTime(1800, 1, 1);
                    }

                    DrugDetails DD = new DrugDetails();
                    DD = new DrugDetails();
                    DD.AdministeredAtFrom = FDate;
                    DD.AdministeredAtTo = TDate;
                    DD.ModifiedBy = LID;
                    if (Convert.ToInt32(lbladviceID.Text) < 0)
                    {
                        DD.PrescriptionID = 0;
                    }
                    else
                    {
                        DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                    }
                    //DD.DrugName = gr.Cells[1].Text.ToString();
                    //DD.Dose = gr.Cells[3].Text.ToString();
                    //DD.DrugFormulation = gr.Cells[2].Text.ToString();

                    Label lbDrugFormulation = (Label)gr.FindControl("lblDrugFormulation");
                    Label lbDrugDose = (Label)gr.FindControl("lblDose");
                    Label lbDrugName = (Label)gr.FindControl("lblDrugName");

                    DD.DrugFormulation = lbDrugFormulation.Text.ToString();
                    DD.Dose = lbDrugDose.Text.ToString();
                    DD.DrugName = lbDrugName.Text.ToString();

                    Label lbROA = (Label)gr.FindControl("lblROA");
                    Label lbDrugFrequency = (Label)gr.FindControl("lblDrugFrequency");
                    Label lbDuration = (Label)gr.FindControl("lblDuration");
                    Label lbInstruction = (Label)gr.FindControl("lblInstruction");

                    //Label lbCreatedBy = (Label)gr.FindControl("lblCreatedBy");
                    //DD.CreatedBy = Convert.ToInt64(lbCreatedBy.Text);
                    DD.CreatedBy = LID;

                    DD.ROA = lbROA.Text.ToString();
                    DD.DrugFrequency = lbDrugFrequency.Text.ToString();
                    DD.Duration = lbDuration.Text.ToString();
                    DD.Instruction = lbInstruction.Text.ToString();
                    DD.PatientVisitID = visitID;
                    DD.DrugStatus = "ADMINISTERED";
                    //lstDrugDetailsUpdate.Add(DD);
                    lstDurgsAdmined.Add(DD);
                }
            }

            returnCode = uiBl.SavePrescription(lstDrugDetails, lstDurgsAdmined);

            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            if (lstDrugDetails.Count > 0 || lstDurgsAdmined.Count > 0)
            {
                Response.Redirect(Request.ApplicationPath + path1 + "?TS=S", true);
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + path1, true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string stae = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Submit Event Nurse/NurseAdvice", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void grdPrescription1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DateTime FDate, TDate;
            List<DrugDetails> lstDDforReBind = new List<DrugDetails>();
            List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
            if (e.CommandName == "Add")
            {
                foreach (GridViewRow gr in grdPrescription1.Rows)
                {


                    TextBox txtFDate = (TextBox)gr.FindControl("txtFDate");
                    TextBox txtTDate = (TextBox)gr.FindControl("txtTDate");
                    Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");
                    Label lbSno = (Label)gr.FindControl("lblSno");

                    if (txtFDate.Text != "")
                    {
                        FDate = Convert.ToDateTime(txtFDate.Text);
                    }
                    else
                    {
                        FDate = new DateTime(1800, 1, 1);
                    }
                    if (txtTDate.Text != "")
                    {
                        TDate = Convert.ToDateTime(txtTDate.Text);
                    }
                    else
                    {
                        TDate = new DateTime(1800, 1, 1);
                    }


                    DrugDetails DD = new DrugDetails();
                    DD = new DrugDetails();

                    if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
                    {
                        DD.AdministeredStatus = true;
                    }
                    else
                    {
                        DD.AdministeredStatus = false;
                    }

                    DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                    DD.Sno = Convert.ToInt64(lbSno.Text);
                    //DD.DrugName = gr.Cells[1].Text.ToString();
                    //DD.Dose = gr.Cells[3].Text.ToString();
                    //DD.DrugFormulation = gr.Cells[2].Text.ToString();

                    Label lbDrugFormulation = (Label)gr.FindControl("lblDrugFormulation");
                    Label lbDrugDose = (Label)gr.FindControl("lblDose");
                    Label lbDrugName = (Label)gr.FindControl("lblDrugName");

                    DD.DrugFormulation = lbDrugFormulation.Text.ToString();
                    DD.Dose = lbDrugDose.Text.ToString();
                    DD.DrugName = lbDrugName.Text.ToString();

                    Label lbROA = (Label)gr.FindControl("lblROA");
                    Label lbDrugFrequency = (Label)gr.FindControl("lblDrugFrequency");
                    Label lbDuration = (Label)gr.FindControl("lblDuration");
                    Label lbInstruction = (Label)gr.FindControl("lblInstruction");

                    DD.ROA = lbROA.Text.ToString();
                    DD.DrugFrequency = lbDrugFrequency.Text.ToString();
                    DD.Duration = lbDuration.Text.ToString();
                    DD.Instruction = lbInstruction.Text.ToString();

                    Label lbCreatedBy = (Label)gr.FindControl("lblCreatedBy");
                    DD.CreatedBy = Convert.ToInt64(lbCreatedBy.Text);

                    DD.AdministeredAtFrom = FDate;
                    DD.AdministeredAtTo = TDate;

                    lstDDforReBind.Add(DD);

                }
                int presId = Convert.ToInt32(e.CommandArgument);
                List<DrugDetails> FilterdDD = (from DDRBind in lstDDforReBind
                                               where DDRBind.Sno == presId
                                               select DDRBind).ToList();


                if (FilterdDD.Count > 0)
                {
                    for (int i = 0; i < FilterdDD.Count; i++)
                    {
                        DrugDetails D = new DrugDetails();
                        //D.PrescriptionID = Convert.ToInt32(hdNewID.Value) - 1;
                        D.Sno = Convert.ToInt64(hdNewID.Value) - 1;
                        D.PrescriptionID = FilterdDD[i].PrescriptionID;
                        hdNewID.Value = D.Sno.ToString();
                        D.DrugName = FilterdDD[i].DrugName;
                        D.Dose = FilterdDD[i].Dose;
                        D.DrugFormulation = FilterdDD[i].DrugFormulation;
                        D.ROA = FilterdDD[i].ROA;
                        D.DrugFrequency = FilterdDD[i].DrugFrequency;
                        D.Duration = FilterdDD[i].Duration;
                        D.Instruction = FilterdDD[i].Instruction;
                        D.CreatedBy = FilterdDD[i].CreatedBy;
                        //D.AdministeredAtFrom = FilterdDD[i].AdministeredAtFrom;
                        //D.AdministeredAtTo = FilterdDD[i].AdministeredAtTo;
                        lstDDforReBind.Add(D);
                    }
                }

                grdPrescription1.DataSource = lstDDforReBind;
                grdPrescription1.DataBind();
            }
            if (e.CommandName == "Stop")
            {
                DrugDetails DD = new DrugDetails();
                DD = new DrugDetails();
                DD.PrescriptionID = Convert.ToInt64(e.CommandArgument.ToString());
                DD.DrugStatus = "STOPED";
                DD.AdministeredAtFrom = new DateTime(1800, 1, 1);
                DD.AdministeredAtTo = new DateTime(1800, 1, 1);
                DD.ModifiedBy = LID;
                lstDDtoSTOP.Add(DD);

                returnCode = new Uri_BL(base.ContextInfo).UpdatePrescription(lstDDtoSTOP);
                returnCode = uiBl.GetSearchPatientPrescription(visitID, LID, RoleID, out lstDrugDetails, out lstAdminsteredDrugs);
                if (lstDrugDetails.Count > 0)
                {
                    string rName = string.Empty;
                    //if (RoleName == "Nurse")
                    //{
                    rName = "Physician";
                    //    lblPrescribedBy.Text = "Below Drugs Prescribed By : " + rName;
                    //}
                    //else if (RoleName == "Physician")
                    //{
                    //    rName = "Nurse";
                    lblPrescribedBy.Text = "Below Drugs Administred By : " + rName;
                    //}

                    //lstDDforAdding = lstDrugDetails;
                    grdPrescription1.DataSource = lstDrugDetails;
                    grdPrescription1.DataBind();
                }
                else
                {
                    grdPrescription1.Visible = false;
                }
                hdNewID.Value = "-1";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdPrescription1_RowCommand NurseAdvice", ex);
        }
    }
    protected void grdPrescription1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DrugDetails D = (DrugDetails)e.Row.DataItem;
                if (D.AdministeredStatus == true)
                {
                    CheckBox chkBox = (CheckBox)e.Row.FindControl("chkSelect");
                    chkBox.Checked = true;
                }
                else
                {
                    CheckBox chkBox = (CheckBox)e.Row.FindControl("chkSelect");
                    chkBox.Checked = false;
                }

                TextBox txtFDate = (TextBox)e.Row.FindControl("txtFDate");
                if ((txtFDate.Text == "01/01/0001 00:00:00") || (txtFDate.Text == "01/01/1800 00:00:00") || (txtFDate.Text == ""))
                {
                    txtFDate.Text = string.Empty;
                }
                else
                {

                }

                TextBox txtTDate = (TextBox)e.Row.FindControl("txtTDate");
                if ((txtTDate.Text == "01/01/0001 00:00:00") || (txtTDate.Text == "01/01/1800 00:00:00") || (txtTDate.Text == ""))
                {
                    txtTDate.Text = string.Empty;
                }
                if (RoleName == "Physician")
                {
                    //grdPrescription1.Columns[0].Visible = false;    //Checkbox
                    grdPrescription1.Columns[5].Visible = false;    //From date
                    grdPrescription1.Columns[6].Visible = false;    //To date
                    grdPrescription1.Columns[7].Visible = false;    //Add
                }
                if (RoleName == "Nurse")
                {
                    grdPrescription1.Columns[8].Visible = false;    //Stop
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdPrescription1_RowDataBound NurseAdvice", ex);
        }
    }
    protected void grdDrugChart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFDate = (Label)e.Row.FindControl("lblAdministeredAtFrom");
            Label lblTDate = (Label)e.Row.FindControl("lblAdministeredAtTo");

            if ((lblFDate.Text == "01/01/0001 00:00:00") || (lblFDate.Text == "01/01/1800 00:00:00") || (lblFDate.Text == ""))
            {
                lblFDate.Text = string.Empty;
            }
            if ((lblTDate.Text == "01/01/0001 00:00:00") || (lblTDate.Text == "01/01/1800 00:00:00") || (lblTDate.Text == ""))
            {
                lblTDate.Text = string.Empty;
            }

        }
    }

    protected void btnStopMedicine_Click(object sender, EventArgs e)
    {
        int flag = 0;
        List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
        foreach (GridViewRow gr in grdPrescription1.Rows)
        {
            if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
            {
                flag = flag + 1;
                DrugDetails DD = new DrugDetails();
                DD = new DrugDetails();
                Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");

                DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                DD.DrugStatus = "STOPED";
                DD.AdministeredAtFrom = new DateTime(1800, 1, 1);
                DD.AdministeredAtTo = new DateTime(1800, 1, 1);
                DD.ModifiedBy = LID;
                lstDDtoSTOP.Add(DD);

                returnCode = new Uri_BL(base.ContextInfo).UpdatePrescription(lstDDtoSTOP);
                returnCode = uiBl.GetSearchPatientPrescription(visitID, LID, RoleID, out lstDrugDetails, out lstAdminsteredDrugs);
                if (lstDrugDetails.Count > 0)
                {
                    string rName = string.Empty;
                    //if (RoleName == "Nurse")
                    //{
                    rName = "Physician";
                    //    lblPrescribedBy.Text = "Below Drugs Prescribed By : " + rName;
                    //}
                    //else if (RoleName == "Physician")
                    //{
                    //    rName = "Nurse";
                    lblPrescribedBy.Text = "Below Drugs Administred By : " + rName;
                    //}

                    //lstDDforAdding = lstDrugDetails;
                    grdPrescription1.DataSource = lstDrugDetails;
                    grdPrescription1.DataBind();
                }
                hdNewID.Value = "-1";
            }
        }
        if (flag == 0)
        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "select1", "javascript:alert('Please Select Any one Medicine');", true);
        }
    }
}
