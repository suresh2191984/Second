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

public partial class CommonControls_Advice : BaseControl
{
    public string prescription = string.Empty;
    List<DrugUseInstruction> lstDruguseInstruction = new List<DrugUseInstruction>();
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
    public string RouteDisplay
    {
        get { return routeDisplay; }
        set { routeDisplay = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        routeBlock1.Style.Add("display", routeDisplay);
        routeBlock2.Style.Add("display", routeDisplay);
        routeBlock3.Style.Add("display", routeDisplay);
        //tDName.Attributes.Add("onblur", "autoFill('" + tDName.ClientID.ToString() + "');");
        //aNew.Attributes.Add("onclick", "pageLoadFocus('" + tDName.ClientID.ToString() + "');");
        //tFrm.Attributes.Add("onblur", "FillDose('" + tFrm.ClientID.ToString() + "','"+tDName.ClientID.ToString() + "');");
        ddFormulation.Attributes.Add("onChange", "adv_loadSelectedValue('Formulation', '" + ddFormulation.ClientID.ToString() + "','" + tFrm.ClientID.ToString() + "','" + tDose.ClientID.ToString() + "');");
        ddFrequency.Attributes.Add("onChange", "adv_loadSelectedValue('Frequency', '" + ddFrequency.ClientID.ToString() + "','" + tFRQ.ClientID.ToString() + "','" + ddlFrequencyNumber.ClientID.ToString() + "');");



        List<InventoryConfig> lstConfigDD = new List<InventoryConfig>();
        Attune.Solution.DAL.DALGateway DALGateway = new Attune.Solution.DAL.DALGateway(base.ContextInfo);
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

                    if (duration == "Days")
                    {
                        lblPrescribeDrugExpiredDate.Text = "The Following Prescribed Drug(s) will be expired on  : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);

                    }
                    else if (duration == "Weeks")
                    {
                        lblPrescribeDrugExpiredDate.Text = "The Following Prescribed Drug(s)  will be expired on : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(7).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(7).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);
                    }

                    else if (duration == "Months")
                    {
                        lblPrescribeDrugExpiredDate.Text = "The Following Prescribed Drug(s)  will be expired on : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);

                    }


                    else
                    {
                        lblPrescribeDrugExpiredDate.Text = "The Following Prescribed Drug(s) will be expired on: " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(ExpiredDrug).ToShortDateString();
                        hdnPrescribedrugexpiryDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(ExpiredDrug).ToShortDateString();
                        prescribeDrugExpiryDate = Convert.ToDateTime(hdnPrescribedrugexpiryDate.Value);

                    }


                }
            }


        }

        //lblDrugMessage.Visible = false;
        if (!IsPostBack)
        {
            LoadMeatData();
            objPatientPrescriptionBL = new PatientPrescription_BL(base.ContextInfo);
            lResult = objPatientPrescriptionBL.GetDrugUseInstruction(out lstDruguseInstruction);
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


        }

        #region Commented By Ashok
        //switch (adviceType)
        //{
        //    case ViewMode.EditMode:
        //        if (prescription.Length > 0)
        //        {
        //            tabDrg.Visible = true;
        //        }
        //        else
        //        {
        //            tabDrg.Visible = false;
        //        }
        //        break;
        //    case ViewMode.PrintMode:

        //        break;
        //};
        //  LoadPrescription();
        #endregion
    }
    string drugName = string.Empty;

    #region Commented By Ashok
    //protected void aNew_Click(object sender, EventArgs e)
    //{
    //    string drugFrm = string.Empty;
    //    string dROA = string.Empty;
    //    string dDose = string.Empty;
    //    string dtoRemove = string.Empty;
    //    string strdFrq = string.Empty; 
    //    string Dura = string.Empty;
    //    dtoRemove = did.Value;

    //    string newPrescription = string.Empty;
    //    int rowCount = 0;
    //    if (ViewState["rowCount"] != null)
    //    {
    //        Int32.TryParse(ViewState["rowCount"].ToString(), out rowCount);
    //    }
    //    rowCount++;            

    //    if (ViewState["pre"] != null)
    //    {
    //        prescription = ViewState["pre"].ToString();           
    //    }
    //    if (tDName.Text != "")
    //    {
    //        if (dtoRemove.Trim().Length > 0)
    //        {
    //            foreach (string drow in prescription.Split('|'))
    //            {

    //                bool IsDeleted = false;
    //                foreach (string s in dtoRemove.Split(','))
    //                {
    //                    if (s != string.Empty && !IsDeleted)
    //                    {
    //                        if (drow.Contains("RID^" + s + "~"))
    //                        {
    //                            IsDeleted = true;
    //                        }
    //                    }
    //                }
    //                if (!IsDeleted && drow != string.Empty)
    //                    newPrescription += drow + "|";
    //            }
    //            prescription = string.Empty;
    //            prescription = newPrescription;
    //        }




    //        did.Value = "";


    //        drugName = tDName.Text.Trim();
    //        drugFrm = tFrm.Text.Trim();
    //        dROA = tROA.Text.Trim();
    //        dDose = tDose.Text.Trim();
    //        strdFrq = tFRQ.Value.Trim();
    //        Dura = tDura.Text.Trim();

    //        tDName.Text = "";
    //        tFrm.Text = "";
    //        tROA.Text = "";
    //        tDose.Text = "";
    //        tFRQ.Value = "";
    //        tDura.Text = "";
    //        if (!prescription.Contains("DNAME^" + drugName + "~DFRM^" + drugFrm))
    //        {
    //            prescription += "RID^" + rowCount.ToString() + "~DNAME^" + drugName + "~DFRM^" + drugFrm + "~DDOSE^" + dDose + "~ROA^" + dROA + "~FRQ^" + strdFrq + "~DURA^" + Dura + "|";
    //            lblDrugMessage.Visible=false;
    //        }
    //        else
    //        {
    //            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "x", "alert('Drug Name already exist');", true);
    //            lblDrugMessage.Visible = true;
    //        }

    //        ViewState["rowCount"] = rowCount;
    //        ViewState["pre"] = prescription;
    //    }
    //        //if (prescription.Trim().Length > 0)

    //        //    BuildTable();

    //        aNew.Attributes.Add("onclick", "pageLoadFocus('" + tDName.ClientID.ToString() + "');");

    //}

    // int count = 0;
    //public void BuildTable()
    //{

    //    List<TableCell> cells = new List<TableCell>();
    //   // int colCount = 0;
    //    string rid = string.Empty;
    //    foreach (string drow in prescription.Split('|'))
    //    {
    //        TableRow row = new TableRow();
    //        if (drow != string.Empty)
    //        {
    //            foreach (string column in drow.Split('~'))
    //            {
    //                cells.Add(AddCell(column, out rid));
    //                if (rid != string.Empty)
    //                    row.Attributes.Add("id", rid);
    //            }
    //            foreach (TableCell cell in cells)
    //            {
    //                row.Cells.Add(cell);
    //            }
    //            cells.Clear();

    //            tabDrg.Rows.Add(row);
    //        }
    //    }
    //    tabDrg.Visible = true;
    //    count++;

    //}   



    //private TableCell AddCell(string column, out string rid)
    //{
    //    string colName = column.Split('^')[0];
    //    string colValue = column.Split('^')[1];
    //    TableCell cell = new TableCell();
    //    cell.Attributes.Add("align", "center");

    //    rid = string.Empty;
    //    switch (colName)
    //    {

    //        case "RID":
    //            HyperLink hLnk = new HyperLink();
    //            hLnk.ImageUrl = "~/Images/delete.jpg";
    //            hLnk.NavigateUrl = "javascript:DeleteRow('" + colValue + "','" + did.ClientID + "');";
    //            cell.Width = Unit.Pixel(20);
    //            rid = colValue;
    //            cell.Controls.Add(hLnk);
    //            break;
    //        case "DNAME":
    //            cell.Text = colValue;
    //            break;
    //        case "DFRM":
    //            cell.Text = colValue;
    //            break;
    //        case "ROA":
    //            cell.Text = colValue;
    //            break;
    //        case "DDOSE":
    //            cell.Text = colValue;
    //            break;
    //        case "FRQ":
    //            cell.Text = colValue;
    //            break;
    //        case "DURA":
    //            cell.Text = colValue;
    //            break;
    //    };
    //    return cell;

    //}
    #endregion
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
        #region Commented By Ashok
        //string[] prescribedDrugs;

        //prescribedDrugs = prescription.Split('|');
        //for (int i = 0; i < prescribedDrugs.Length; i++)
        //{
        //    for (int j = 0; j < arDeletedDatas.Length; j++)
        //    {
        //        if (prescribedDrugs[i].ToString() == arDeletedDatas[j].ToString())
        //        {
        //            prescribedDrugs
        //        }
        //    }
        //}




        //if (dtoRemove.Trim().Length > 0)
        //{
        //    foreach (string drow in prescription.Split('|'))
        //    {

        //        bool IsDeleted = false;
        //        foreach (string s in dtoRemove.Split(','))
        //        {
        //            if (s != string.Empty && !IsDeleted)
        //            {
        //                if (drow.Contains("RID^" + s + "~"))
        //                {
        //                    IsDeleted = true;
        //                }
        //            }
        //        }
        //        if (!IsDeleted && drow != string.Empty)
        //            newPrescription += drow + "|";
        //    }
        //    prescription = string.Empty;
        //    prescription = newPrescription;
        //}
        #endregion

        did.Value = "";
        DrugDetails pAdvices = new DrugDetails();
        PhysicianSchedule physician = new PhysicianSchedule();
        new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
        pAdvices.PhysicianID = physician.PhysicianID;


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
                        case "DFRM":
                            advice.DrugFormulation = colValue;
                            break;
                        case "ROA":
                            advice.ROA = colValue;
                            break;
                        case "DDOSE":
                            advice.Dose = colValue;
                            break;
                        case "FRQ":
                            advice.DrugFrequency = colValue;
                            break;
                        case "DURA":
                            advice.Days = colValue;
                            break;
                        case "INS":
                            advice.Instruction = colValue;
                            break;
                    };
                }
                advice.PatientVisitID = patientVisitID;
                advice.DrugStatus = "PRESCRIBED";
                advice.CreatedBy = LID;
                advice.PhysicianID = pAdvices.PhysicianID;
                advice.PrescribeDrugExpiryDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
                advices.Add(advice);
            }

        }

        return advices;
    }

    public void SetPrescription(List<DrugDetails> drgDetails)
    {
        int rowcount = 0;
        string sMedicinesPresent = "";
        // ViewState.Remove("pre");
        foreach (DrugDetails drgDet in drgDetails)
        {
            rowcount++;
            // prescription += "RID^" + rowcount.ToString() + "~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~ROA^" + drgDet.ROA + "~DDOSE^" + drgDet.Dose + "~FRQ^" + drgDet.DrugFrequency + "~DURA^" + drgDet.Days + "|";
            prescription += "RID^0~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~DDOSE^" + drgDet.Dose + "~ROA^" + drgDet.ROA + "~FRQ^" + drgDet.DrugFrequency + "~DURA^" + drgDet.Days + "~INS^" + drgDet.Instruction + "|";
            sMedicinesPresent += drgDet.DrugName + "-" + drgDet.DrugFormulation + "|";
        }
        hdfDrugs.Value = prescription;
        hdnDrugNameExists.Value = sMedicinesPresent;
        this.Page.RegisterStartupScript("Scrpt", "<script>CreateJavaScriptTables() </Script>");
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
        lresult = PPBL.GetPrescription(DrugName, 1, OrgID, out lstPrescription, ILocationID, InventoryLocationID, visitID);
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
                // Formulation1[i] = lstPrescription[i].Formulation;
                Dose1[i] = lstPrescription[i].Dose;
                ROA1[i] = lstPrescription[i].ROA;
            }

            Page.RegisterStartupScript("drug", "<script>var customArray = new Array(" + drugNamesArray + ");actb(document.getElementById('Advice1$tDName'),customArray);</script>");
            //Page.RegisterStartupScript("drug", "<script>var customArray = new Array(" + drugNamesArray + ");actb(document.getElementById('Advice1$tFRQ'),customArray);</script>");
        }




    }


    public void LoadMeatData()
    {

        long returncode = -1;
        string domains = "DateAttributes";
        string[] Tempdata = domains.Split(',');
        string LangCode = LanguageCode;
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;

        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }
     
        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "DateAttributes"
                             select child;

            ddlFrequencyType.DataSource = childItems.OrderByDescending(p => p.DisplayText);
            ddlFrequencyType.DataTextField = "DisplayText";
            ddlFrequencyType.DataValueField = "DisplayText";
            ddlFrequencyType.DataBind();

        }
    }

}
