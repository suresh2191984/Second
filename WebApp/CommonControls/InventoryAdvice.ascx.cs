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
using System.IO;
using Attune.Podium.Common;


public partial class CommonControls_InventoryAdvice : BaseControl
{
    public string prescription = string.Empty;
    List<DrugUseInstruction> lstDruguseInstruction = new List<DrugUseInstruction>();
    List<DrugFrequency> lstDrugFrequency = new List<DrugFrequency>();
    PatientPrescription_BL objPatientPrescriptionBL;
    long lResult = -1;
    DateTime prescribeDrugExpiryDate;
    private ViewMode adviceType;
    public ViewMode AdviceMode
    {
        get { return adviceType; }
        set { adviceType = value; }
    }
    string routeDisplay = "none";
    string doseDisplay = "none";
    string pvid = "none";
    public string RouteDisplay
    {
        get { return routeDisplay; }
        set { routeDisplay = value; }
    }
    public string Pvid
    {
        get { return pvid; }
        set { pvid = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        hdnVid.Value = Pvid;
        if (IsCorporateOrg == "Y")
        {
            hdnIsCorpOrg.Value = "Y";
            routeDisplay = "block";
        }
        else
        {
            hdnIsCorpOrg.Value = "N";
            routeDisplay = "none";
        }
        routeBlock1.Style.Add("display", routeDisplay);
        routeBlock2.Style.Add("display", routeDisplay);
        routeBlock3.Style.Add("display", routeDisplay);
        DoseBlock1.Style.Add("display", doseDisplay);
        DoseBlock2.Style.Add("display", doseDisplay);
        DoseBlock3.Style.Add("display", doseDisplay);
        ddFrequency.Attributes.Add("onChange", "adv_loadSelectedValue('Frequency', '" + ddFrequency.ClientID.ToString() + "','" + tFRQ.ClientID.ToString() + "','" + txtFrequencyNumber.ClientID.ToString() + "');");
        long visitID = 0;

        List<InventoryConfig> lstConfigDD = new List<InventoryConfig>();
        LoadData();

        Attune.Solution.DAL.DALGateway DALGateway = new Attune.Solution.DAL.DALGateway();

        DALGateway.GetInventoryConfigDetails("PrescribeDrugExpiredDate", OrgID, ILocationID, out lstConfigDD);
        if (lstConfigDD == null || lstConfigDD.Count == 0)
        {
            lstConfigDD.Add(new InventoryConfig
            {
                ConfigValue = "1-Days"
            });

        }


    

        if (lstConfigDD.Count > 0)
        {
            if (lstConfigDD[0].ConfigValue != null && lstConfigDD[0].ConfigValue != "")
            {
                if (lstConfigDD[0].ConfigValue.Split('-')[0] != null && lstConfigDD[0].ConfigValue.Split('-')[0] != "")
                {
                    int ExpiredDrug = Convert.ToUInt16(lstConfigDD[0].ConfigValue.Split('-')[0]);
                    string duration = lstConfigDD[0].ConfigValue.Split('-')[1];
                    string sPrescriptionMsg = "The Prescription is valid up to: ";

                    if (duration == "Days")
                    {
                        lblPrescribeDrugExpiredDate.Text = sPrescriptionMsg + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);

                    }
                    else if (duration == "Weeks")
                    {
                        lblPrescribeDrugExpiredDate.Text = sPrescriptionMsg + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(7).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(7).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);
                    }

                    else if (duration == "Months")
                    {
                        lblPrescribeDrugExpiredDate.Text = sPrescriptionMsg + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);
                    }
                    else
                    {
                        lblPrescribeDrugExpiredDate.Text = sPrescriptionMsg + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);
                    }
                }
            }
        }



        //END 





        if (!IsPostBack)
        {
            DrugUseInstructionDetails();
            LoadLocationName();
            LoadPrescription();

            //AutoDname.ContextKey = visitID.ToString() + '~' + drplocation.SelectedValue.ToString();
        }

        #region Commented By Ashok
        #endregion
    }


    private void LoadLocationName()
    {
        try
        {
            List<Locations> lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;

            new SharedInventory_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            //lstLocation.Remove(lstLocation.Find(p => p.LocationID == InventoryLocationID));
            //lstLocation.Remove(lstLocation.Find(p => p.LocationTypeCode == "POS" || p.LocationTypeCode == "POD"));
            drplocation.DataSource = lstLocation;
            drplocation.DataTextField = "LocationName";
            drplocation.DataValueField = "LocationID";
            drplocation.DataBind();
            drplocation.Items.Insert(0, new ListItem("--All--", "0"));




        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    public List<DrugDetails> GetPrescription(long patientVisitID)
    {
        string drugName = string.Empty;
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
        DrugDetails pAdvices = new DrugDetails();
        PhysicianSchedule physician = new PhysicianSchedule();
        if (hdnOnBehalfID.Value != "" && hdnOnBehalfID.Value != "0" && hdnOnBehalfID.Value != "-1")
        {
            pAdvices.PhysicianID = Convert.ToInt64(hdnOnBehalfID.Value);
        }
        else
        {
            new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
         
            pAdvices.PhysicianID = physician.PhysicianID;
          
            ////pAdvices.PhysicianID = LID;
        }

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
                    long drugID = 0;
                    short dFrqID = 0;
                    switch (colName)
                    {
                        case "DNAME":
                            advice.DrugName = colValue;
                            break;
                        //case "DFRM":
                        //    advice.DrugFormulation = colValue;
                        //    break;
                        case "ROA":
                            advice.ROA = colValue;
                            break;
                        case "DDOSE":
                            advice.Dose = colValue;
                            break;
                        case "FRQ":
                            advice.DrugFrequency = colValue;
                            break;
                        case "DIR":
                            advice.Direction = colValue;
                            break;
                        case "DURA":
                            advice.Days = colValue;
                            break;
                        case "INS":
                            advice.Instruction = colValue;
                            break;
                        case "PID":
                            advice.DrugID = Convert.ToInt64(colValue.Trim() == "" ? "0" : colValue.Trim());
                            break;
                        case "AutoID":
                            advice.PrescriptionID = Convert.ToInt64(colValue.Trim() == "" ? "0" : colValue.Trim());
                            break;
                        case "TaskID":
                            advice.TaskID = Convert.ToInt64(colValue.Trim() == "" ? "0" : colValue.Trim());
                            break;
                        case "Qty":
                            advice.Qty = Convert.ToDecimal(colValue.Trim() == "" ? "0.00" : colValue.Trim());
                            break;
                    };
                }
                advice.PatientVisitID = patientVisitID;
                advice.DrugStatus = "PRESCRIBED";
                advice.DrugSource = "INV";
                advice.CreatedBy = LID;
                advice.PhysicianID = pAdvices.PhysicianID;
                advice.PrescribeDrugExpiryDate = prescribeDrugExpiryDate;

                advices.Add(advice);
            }

        }

        return advices;
    }

    public void SetPrescription(List<DrugDetails> drgDetails)
    {
        int rowcount = 0;
        string sMedicinesPresent = "";
        long InvtaskStatusID=1;
        long INVTaskID = 0;
        long OnBehalfID = -1;
        // ViewState.Remove("pre");
        foreach (DrugDetails drgDet in drgDetails)
        {
            rowcount++;
            // prescription += "RID^" + rowcount.ToString() + "~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~ROA^" + drgDet.ROA + "~DDOSE^" + drgDet.Dose + "~FRQ^" + drgDet.DrugFrequency + "~DURA^" + drgDet.Days + "|";
            prescription += "RID^0~DNAME^" + drgDet.DrugName + "~DDOSE^" + drgDet.Dose + "~ROA^" + drgDet.ROA + "~FRQ^" + drgDet.DrugFrequency + "~DIR^" + drgDet.Direction + "~DURA^" + drgDet.Days + "~INS^" + drgDet.Instruction + "~PID^" + drgDet.DrugID + "~AutoID^" + drgDet.PrescriptionID + "~TaskID^" + drgDet.TaskID + "~Qty^" + drgDet.Qty + "|";
            //sMedicinesPresent += drgDet.DrugName + "-" + drgDet.DrugFormulation + "|";
            sMedicinesPresent += drgDet.DrugName;
            InvtaskStatusID=drgDet.Sno;
            INVTaskID = drgDet.TaskID;
            OnBehalfID = drgDet.PhysicianID;
        }
        hdfDrugs.Value = prescription;
        hdnInvtaskStatusID.Value = InvtaskStatusID.ToString();
        hdnINVTaskID.Value = INVTaskID.ToString();
        hdnDrugNameExists.Value = sMedicinesPresent;
        hdnOnBehalfID.Value = OnBehalfID.ToString();
        this.Page.RegisterStartupScript("Scrpt", "<script>CreateJavaScriptTables() </Script>");
    }


    public void LoadPrescription()
    {
        PatientPrescription_BL PPBL = new PatientPrescription_BL(base.ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        long lresult = -1;
        int i = 0;
        long visitID = 0;
        string DrugName = tDName.Text;
        string Formulation = string.Empty;
        string ROA = string.Empty;
        string Dose = string.Empty;
        long locid = 0;
        // = visitID;
        //visitID = lstPrescription[0].PatientVisitID;//Convert.ToInt64(Request.QueryString["VID"]);
        //newly added  for check Prescribed Drug Validity Date 
        // AutoDname.ContextKey = visitID.ToString() + '~' + drplocation.SelectedValue.ToString();
        if (ChckAllDrug.Checked == true)
        {
            locid = -1;
        }
        AutoDname.ContextKey = visitID.ToString() + '~' + locid;






        string drugNamesArray = null;
        //string[] Formulation1 = null;
        int count = 0;
        if (lstPrescription.Count > 0)
        {

            drugNamesArray = string.Empty;
            //Formulation1 = new string[lstPrescription.Count];
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

            //Page.RegisterStartupScript("drug", "<script>var customArray = new Array(" + drugNamesArray + ");actb(document.getElementById('Advice1$tDName'),customArray);</script>");
        }




    }
    public void DrugUseInstructionDetails()
    {
        objPatientPrescriptionBL = new PatientPrescription_BL(base.ContextInfo);
        lResult = objPatientPrescriptionBL.GetDrugUseInstructionDetails(out lstDruguseInstruction, out lstDrugFrequency);
        if (lstDruguseInstruction.Count > 0)
        {
            ddlInstruction.DataSource = lstDruguseInstruction;
            ddlInstruction.DataTextField = "DrugUseDescription";
            ddlInstruction.DataValueField = "DrugUseDescription";
            ddlInstruction.DataBind();
            ddlInstruction.Items.Insert(0, new ListItem("----Select----", ""));
        }
        if (lstDruguseInstruction.Count > 0)
        {
            foreach (DrugUseInstruction oDrugUseInstruction in lstDruguseInstruction)
            {
                hdnInstruction.Value += oDrugUseInstruction.DrugUseDescription + "^";
            }
        }

        if (lstDrugFrequency.Count > 0)
        {
            ddFrequency.DataSource = lstDrugFrequency;
            ddFrequency.DataTextField = "ShortName";
            ddFrequency.DataValueField = "ShortName";
            ddFrequency.DataBind();
            ddFrequency.Items.Insert(0, new ListItem("----Select----", ""));

            ddDirection.DataSource = lstDrugFrequency;
            ddDirection.DataTextField = "DisplayText";
            ddDirection.DataValueField = "DisplayText";
            ddDirection.DataBind();
            ddDirection.Items.Insert(0, new ListItem("----Select----", ""));

        }
        if (lstDrugFrequency.Count > 0)
        {
            foreach (DrugFrequency oDrugFrequency in lstDrugFrequency)
            {
                hdnDirection.Value += oDrugFrequency.ShortName + "~" + oDrugFrequency.DisplayText + "~" + oDrugFrequency.DrugCalculation + "^";
            }
        }
    }

    public void LoadData()
    {
        try
        {
            long returncode = -1;
            string domains = "DateAttributes,";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode , out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "DateAttributes"
                                     select child;
                    ddlFrequencyType.DataSource = childItems;
                    ddlFrequencyType.DataTextField = "DisplayText";
                    ddlFrequencyType.DataValueField = "DisplayText";
                    ddlFrequencyType.DataBind();

                  
                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data  ... ", ex);

        }
    }


}
