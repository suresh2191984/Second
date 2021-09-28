using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;

public partial class CommonControls_IpDrugEntry : BaseControl
{
    public string prescription = string.Empty;
    string prescriptionLoggedUser = string.Empty;
    List<DrugUseInstruction> lstDruguseInstruction = new List<DrugUseInstruction>();
    PatientPrescription_BL objPatientPrescriptionBL;
    long lResult = -1;
    private ViewMode adviceType;
    public ViewMode AdviceMode
    {
        get { return adviceType; }
        set { adviceType = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        objPatientPrescriptionBL = new PatientPrescription_BL(base.ContextInfo);
        ddFormulation.Attributes.Add("onChange", "adv_loadSelectedValue('Formulation', '" + ddFormulation.ClientID.ToString() + "','" + tFrm.ClientID.ToString() + "','" + tDose.ClientID.ToString() + "');");
        ddFrequency.Attributes.Add("onChange", "adv_loadSelectedValue('Frequency', '" + ddFrequency.ClientID.ToString() + "','" + tFRQ.ClientID.ToString() + "','" + ddlFrequencyNumber.ClientID.ToString() + "');");
        txtDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        hdnRoleName.Value = RoleName;
        lblDrugMessage.Visible = false;
        if (!IsPostBack)
        {
            lResult = objPatientPrescriptionBL.GetDrugUseInstruction(out lstDruguseInstruction);
            if (lstDruguseInstruction.Count > 0)
            {
                ddlInstruction.DataSource = lstDruguseInstruction;
                ddlInstruction.DataTextField = "DrugUseDescription";
                ddlInstruction.DataValueField = "DrugUseDescription";
                ddlInstruction.DataBind();
                ddlInstruction.Items.Insert(0, new ListItem("----Select----", ""));
            }
            if (RoleName == "Physician" || RoleName == "Operation Theatre")
            {
                txtDate.Style.Add("display", "none");
                txtToDate.Style.Add("display", "none");

                //imgsFDate.Style.Add("display", "none");
                //imgsTDate.Style.Add("display", "none");
                //txtDate.Text = "-";
                //txtToDate.Text = "-";
            }
        }
    }
    string drugName = string.Empty;


    public List<DrugDetails> GetPrescription(long patientVisitID)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        if (hdnDrugsDeleted.Value != null)
        {
            dtoRemove = hdnDrugsDeleted.Value.ToString();
        }
        List<DrugDetails> advices = new List<DrugDetails>();
        if (hdfDrugs.Value != null)
            prescription = hdfDrugs.Value.ToString();

        string sNewDatas = "";
        bool bDeleted = false;
        foreach (string row in prescription.Split('|'))
        {
            bDeleted = false;
            foreach (string removedrow in dtoRemove.Split('|'))
            {
                if (row.Trim() == removedrow.Trim())
                {
                    bDeleted = true;
                }
            }
            if (bDeleted != true)
            {
                sNewDatas += row.ToString() + "|";
            }
        }


        did.Value = "";

        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                DrugDetails advice = new DrugDetails();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    switch (colName)
                    {
                        case "DNAME":
                            advice.DrugName  = colValue;
                            break;
                        case "DFRM":
                            advice.DrugFormulation = colValue;
                            break;
                        case "ROA":
                            advice.ROA = colValue;
                            break;
                        case "DDOSE":
                            advice.Dose = colValue;
                            break;
                        case "FREQ":
                            advice.DrugFrequency = colValue;
                            break;
                        case "DUR":
                            advice.Duration = colValue;
                            break;
                        case "INST":
                            advice.Instruction = colValue;
                            break;
                        case "DAT":
                            if ((colValue == "01-01-0001 12:00:00 AM") || (colValue == "01/01/0001 00:00:00") || (colValue == "") || (colValue == "01-01-1800 12:00:00 AM") || (colValue == "-"))
                            {
                                advice.AdministeredAtFrom = new DateTime(1800, 1, 1);
                            }
                            else
                            {
                                advice.AdministeredAtFrom = Convert.ToDateTime(colValue);
                            }
                            break;
                        case "DATto":
                            if ((colValue == "01-01-0001 12:00:00 AM") || (colValue == "01/01/0001 00:00:00") || (colValue == "") || (colValue == "01-01-1800 12:00:00 AM") || (colValue == "-"))
                            {
                                advice.AdministeredAtTo = new DateTime(1800, 1, 1);
                            }
                            else
                            {
                                advice.AdministeredAtTo = Convert.ToDateTime(colValue);
                            }
                            break;
                        case "PresID":
                            advice.PrescriptionID = Convert.ToInt64(colValue);
                            break;
                    };
                }
                if (RoleName == "Physician")
                {
                    advice.DrugStatus = "ADMINISTERED";
                }
                else
                {
                    advice.DrugStatus = "ADMINISTERED";
                }
                advice.PatientVisitID = patientVisitID;
                advice.CreatedBy = LID;
                advices.Add(advice);
            }

        }

        return advices;
    }

    //public void SetPrescription(List<DrugDetails> lstDrugDetailsOtherUser, List<DrugDetails> lstDrugDetailsLoggedUser)
    //{
    //    int rowcount = 0;
    //    string sMedicinesPresent = "";
    //    string sMedicinesPresentLoggedUser = string.Empty;
    //    foreach (DrugDetails drgDet in lstDrugDetailsOtherUser)
    //    {
    //        rowcount++;
    //        string adminAtFrom = drgDet.AdministeredAtFrom.ToString("dd-MM-yyyy hh:mm:ss tt");
    //        if ((adminAtFrom == "01-01-0001 12:00:00 AM") || (adminAtFrom == "01/01/0001 00:00:00") || (adminAtFrom == "01-01-1800 12:00:00 AM") || (adminAtFrom == ""))
    //        {
    //            adminAtFrom = "";
    //        }
    //        //else
    //        //{
    //        //    adminAtFrom = Convert.ToDateTime(adminAtFrom).ToString();
    //        //}
    //        string adminAtTo = drgDet.AdministeredAtTo.ToString("dd-MM-yyyy hh:mm:ss tt");
    //        if ((adminAtTo == "01-01-0001 12:00:00 AM") || (adminAtTo == "01/01/0001 00:00:00") || (adminAtTo == "01-01-1800 12:00:00 AM") || (adminAtTo == ""))
    //        {
    //            adminAtTo = "";
    //        }
    //        //else
    //        //{
    //        //    adminAtTo = Convert.ToDateTime(adminAtTo).ToString();
    //        //}
    //        prescription += "RID^0~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~DDOSE^" + drgDet.Dose + "~ROA^" + drgDet.ROA + "~FREQ^" + drgDet.DrugFrequency + "~DUR^" + drgDet.Duration + "~INST^" + drgDet.Instruction + "~DAT^" + adminAtFrom + "~DATto^" + adminAtTo + "~PresID^" + drgDet.PrescriptionID + "|";
    //        sMedicinesPresent += drgDet.DrugName + "-" + drgDet.DrugFormulation + "-" + drgDet.Dose + "-" + drgDet.ROA + "-" + adminAtFrom + "-" + adminAtTo + "|";
    //    }
    //    //hdfDrugs.Value = prescription;
    //    hdfDrugsOthersUsers.Value = prescription;
    //    hdnDrugNameExists.Value = sMedicinesPresent;

    //    if (lstDrugDetailsLoggedUser.Count > 0)
    //    {
    //        foreach (DrugDetails drgDet in lstDrugDetailsLoggedUser)
    //        {
    //            rowcount++;
    //            string adminAtFrom = drgDet.AdministeredAtFrom.ToString("dd-MM-yyyy hh:mm:ss tt");
    //            if ((adminAtFrom == "01-01-0001 12:00:00 AM") || (adminAtFrom == "01/01/0001 00:00:00") || (adminAtFrom == "01-01-1800 12:00:00 AM") || (adminAtFrom == ""))
    //            {
    //                adminAtFrom = "";
    //            }
    //            //else
    //            //{
    //            //    adminAtFrom = Convert.ToDateTime(adminAtFrom).ToString();
    //            //}
    //            string adminAtTo = drgDet.AdministeredAtTo.ToString("dd-MM-yyyy hh:mm:ss tt");
    //            if ((adminAtTo == "01-01-0001 12:00:00 AM") || (adminAtTo == "01/01/0001 00:00:00") || (adminAtTo == "01-01-1800 12:00:00 AM") || (adminAtTo == ""))
    //            {
    //                adminAtTo = "";
    //            }
    //            //else
    //            //{
    //            //    adminAtTo = Convert.ToDateTime(adminAtTo).ToString();
    //            //}
    //            prescriptionLoggedUser += "RID^0~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~DDOSE^" + drgDet.Dose + "~ROA^" + drgDet.ROA + "~FREQ^" + drgDet.DrugFrequency + "~DUR^" + drgDet.Duration + "~INST^" + drgDet.Instruction + "~DAT^" + adminAtFrom + "~DATto^" + adminAtTo + "~PresID^" + drgDet.PrescriptionID + "|";
    //            sMedicinesPresentLoggedUser += drgDet.DrugName + "-" + drgDet.DrugFormulation + "-" + drgDet.Dose + "-" + drgDet.ROA + "-" + adminAtFrom + "-" + adminAtTo + "|";
    //        }
    //        hdfDrugs.Value = prescriptionLoggedUser;
    //        hdnDrugNameExists.Value = string.Empty;
    //        hdnDrugNameExists.Value = sMedicinesPresentLoggedUser;
    //        this.Page.RegisterStartupScript("Scrpt", "<script>CreateJavaScriptTables() </Script>");
    //    }
        
    //}

    public void SetPrescription(List<DrugDetails> lstDrugDetails)
    {
        int rowcount = 0;
        string sMedicinesPresentLoggedUser = string.Empty;

        if (lstDrugDetails.Count > 0)
        {
            foreach (DrugDetails drgDet in lstDrugDetails)
            {
                rowcount++;
                string adminAtFrom = drgDet.AdministeredAtFrom.ToString("dd-MM-yyyy hh:mm:ss tt");
                if ((adminAtFrom == "01-01-0001 12:00:00 AM") || (adminAtFrom == "01/01/0001 00:00:00") || (adminAtFrom == "01-01-1800 12:00:00 AM") || (adminAtFrom == ""))
                {
                    adminAtFrom = "";
                }
                //else
                //{
                //    adminAtFrom = Convert.ToDateTime(adminAtFrom).ToString();
                //}
                string adminAtTo = drgDet.AdministeredAtTo.ToString("dd-MM-yyyy hh:mm:ss tt");
                if ((adminAtTo == "01-01-0001 12:00:00 AM") || (adminAtTo == "01/01/0001 00:00:00") || (adminAtTo == "01-01-1800 12:00:00 AM") || (adminAtTo == ""))
                {
                    adminAtTo = "";
                }
                //else
                //{
                //    adminAtTo = Convert.ToDateTime(adminAtTo).ToString();
                //}
                prescriptionLoggedUser += "RID^0~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~DDOSE^" + drgDet.Dose + "~ROA^" + drgDet.ROA + "~FREQ^" + drgDet.DrugFrequency + "~DUR^" + drgDet.Duration + "~INST^" + drgDet.Instruction + "~DAT^" + adminAtFrom + "~DATto^" + adminAtTo + "~PresID^" + drgDet.PrescriptionID + "|";
                sMedicinesPresentLoggedUser += drgDet.DrugName + "-" + drgDet.DrugFormulation + "-" + drgDet.Dose + "-" + drgDet.ROA + "-" + adminAtFrom + "-" + adminAtTo + "|";
            }
            //hdfDrugs.Value = prescriptionLoggedUser;
            hdnDrugNameExists.Value = string.Empty;
            hdnDrugNameExists.Value = sMedicinesPresentLoggedUser;
            //this.Page.RegisterStartupScript("Scrpt", "<script>CreateJavaScriptTables() </Script>");
        }

    }


    public void LoadPrescription()
    {
        PatientPrescription_BL PPBL = new PatientPrescription_BL(base.ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        long lresult = -1;
        int i = 0;
        string DrugName = tDName.Text;
        string Formulation = string.Empty;
        string ROA = string.Empty;
        string Dose = string.Empty;
        long visitID = 0;
        lresult = PPBL.GetPrescription(DrugName, 1, OrgID, out lstPrescription,ILocationID,InventoryLocationID,visitID);
        string drugNamesArray = null;
        int count = 0;
     
        if (lstPrescription.Count > 0)

        {

            drugNamesArray = string.Empty;
            string[] Dose1 = new string[lstPrescription.Count];
            string[] ROA1 = new string[lstPrescription.Count];

            for (i = 0; i < lstPrescription.Count; i++)
            {
                if (count == 0)
                {
                    drugNamesArray = "'" + lstPrescription[i].BrandName + "'";
                }
                else
                {
                    drugNamesArray = drugNamesArray + "," + "'" + lstPrescription[i].BrandName + "'";
                }
                Dose1[i] = lstPrescription[i].Dose;
                ROA1[i] = lstPrescription[i].ROA;
            }

            Page.RegisterStartupScript("drug", "<script>var customArray = new Array(" + drugNamesArray + ");actb(document.getElementById('Advice1$tDName'),customArray);</script>");
        }
    }
}