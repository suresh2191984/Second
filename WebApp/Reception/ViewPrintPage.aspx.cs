using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;

public partial class Reception_ViewPrintPage : BasePage
{

    public Reception_ViewPrintPage()
        : base("Reception_ViewPrintPage_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long visitID = -1;
    long taskID = -1;
    string pageid = string.Empty;
    long returncode = -1;
    List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
    string pagename = string.Empty;
    long patientID = -1;
    int specialityid, followup;
    int pdp = -1;
    string labno = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string IsBillWithBarcode = string.Empty;
            //IsBillWithBarcode = GetConfigValue("PrintBillBarcode", OrgID);
            //if (IsBillWithBarcode == "Y")
            //{
            //    btnPrintBarcode.Visible = false;
            //}
            //else
            //{
            //    btnPrintBarcode.Visible = true;
            //}
            string lsConfigValue = GetConfigValue("SHOWFEESPLIT", OrgID);

            if (lsConfigValue == "Y")
            {
                chkSplit.Style.Add("display", "block");

                if (Request.QueryString["ViewSplitCheckbox"] == "Y")
                {
                    chkSplit.Style.Add("display", "none");
                }

            }
            if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "" && Request.QueryString["pid"] != null && Request.QueryString["pid"]!="")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
            }
        }
        long returnCode;
        GateWay gateWay = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
             string DummyBill = GetConfigValue("DummyBill", OrgID);
             if (DummyBill == "Y")
            {
                hdndummybill.Value = "Y";
            }
        returnCode = gateWay.GetConfigDetails("BillPrintControl", OrgID, out lstConfig);
        if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "QuatumBillPrint.ascx")
        {
            btnPrintFullBill.Visible = false;
        }
        if (Request.QueryString["RedirectPage"] != null)
        {
            btnBack.Attributes.Add("style", "display:none");
        }
        if (Request.QueryString["CCPage"] == "Y")
        {
            //LeftMenu1.Visible = false;
            //MHead.Visible = false;
            //RHead.Visible = false;
           // header.Visible = false;
           // lblDiagnosisHeader.Visible = false;
            //data.Visible = false;
           // Footer1.Visible = false;
            btnPrint.Visible = false;
            btnPrintFullBill.Visible = false;
            btnHome.Visible = false;
           // showmenu.Visible = false;
            //ErrorDisplay1.Visible = false;
           // TopHeader1.Visible = false;
           // content.Visible = false;

            chkDuplicate.Visible = false;
            Attuneheader.Visible = false;
            Attunefooter.Visible = false;
            
            btnBack.Visible = false;
            btnPrintBarcode.Visible = false;
            //chkheader.Style.Add("display", "none");
            hdnPopup.Value = "1";
        }


        try
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            pageid = Request.QueryString["pagetype"].ToString();
            if (Request.QueryString["LabNo"] != null)
            {
                labno = Request.QueryString["LabNo"];
            }
            if (Request.QueryString["pdp"] != null)
            {
                pdp = Convert.ToInt32(Request.QueryString["pdp"]);
            }
            long FinalBillID = 0;
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
            PatientVisit_BL pvBL = new PatientVisit_BL(base.ContextInfo);
            returncode = pvBL.GetVisitPurposeName(OrgID, visitID, out lstvisitpurpose);
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            ancBL.GetANCSpecilaityID(visitID, out specialityid, out followup);
            string RedirectPage = GetConfigValue("BillPrintControl", OrgID);


            #region Dynamically push the user control depending on the Organization (as per value in the RedirectPage variable)
            Control objCtrl;

            switch (RedirectPage)
            {
                case "RakshithBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/RakshithBillPrint.ascx");
                    Billing_RakshithBillPrint oRakshithBillPrint = (Billing_RakshithBillPrint)objCtrl;
                    objCtrl.ID = "rakshithbillPrint";
                    oRakshithBillPrint.LoadSessionValue();
                    oRakshithBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    break;
                case "EsBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/EsBillPrint.ascx");
                    CommonControls_EsBillPrint oESBillPrint = (CommonControls_EsBillPrint)objCtrl;
                    objCtrl.ID = "EsBillPrint1";
                    oESBillPrint.LoadSessionValue();
                    oESBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    oESBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    break;
                case "Medfort_BillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/Medfort_BillPrint.ascx");
                    CommonControls_Medfort_BillPrint oMedFortBillPrint = (CommonControls_Medfort_BillPrint)objCtrl;
                    objCtrl.ID = "medfortBillPrint";
                    oMedFortBillPrint.LoadSessionValue();
                    oMedFortBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    oMedFortBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    break;
                case "JulianBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/JulianBillPrint.ascx");
                    CommonControls_JulianBillPrint oJulianBillPrint = (CommonControls_JulianBillPrint)objCtrl;
                    objCtrl.ID = "JulianBillPrint";
                    oJulianBillPrint.LoadSessionValue();
                    oJulianBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    oJulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    break;
                case "NMC-MeerutBill.ascx":
                    objCtrl = LoadControl("../CommonControls/NMC-MeerutBill.ascx");
                    CommonControls_NMC_MeerutBill oNMCBillPrint = (CommonControls_NMC_MeerutBill)objCtrl;
                    objCtrl.ID = "NMCMeerutBill";
                    oNMCBillPrint.LoadSessionValue();
                    oNMCBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    oNMCBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    break;
                case "AdvanceBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/AdvanceBillPrint.ascx");
                    CommonControls_AdvanceBillPrint Advbillprint = (CommonControls_AdvanceBillPrint)objCtrl;
                    objCtrl.ID = "AdvanceBillPrint";
                    Advbillprint.LoadSessionValue();
                    Advbillprint.LoadBillConfigMetadata(OrgID, ILocationID);
                    Advbillprint.BillPrinting(visitID, FinalBillID, pdp);

                    break;

                case "Genes2meBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/Genes2meBillPrint.ascx");
                    CommonControls_Genes2MEBillPrint Genes2MEBillPrint = (CommonControls_Genes2MEBillPrint)objCtrl;
                    objCtrl.ID = "Genes2MEBillPrint";
                    Genes2MEBillPrint.LoadSessionValue();
                    Genes2MEBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    Genes2MEBillPrint.BillPrinting(visitID, FinalBillID, pdp);

                    break;
                case "IGeneticBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/IGeneticBillPrint.ascx");
                    CommonControls_IGeneticBillPrint IGeneticBillPrint = (CommonControls_IGeneticBillPrint)objCtrl;
                    objCtrl.ID = "IGeneticBillPrint";
                    IGeneticBillPrint.LoadSessionValue();
                    IGeneticBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    string strIgeN_BillType = string.Empty;
                    if (Request.QueryString.AllKeys.Contains("DuplicateBill"))
                    {
                        if (!string.IsNullOrEmpty(Request.QueryString["DuplicateBill"].ToString()))
                        {
                            strIgeN_BillType = Request.QueryString["DuplicateBill"].ToString();
                        }

                        if (strIgeN_BillType == "Y")
                        {
                            IGeneticBillPrint.BillPrinting1(visitID, FinalBillID, pdp);
                            
                        }
                        else
                        {
                            IGeneticBillPrint.BillPrinting(visitID, FinalBillID, pdp);

                        }
                    }
                    else
                    {
                        IGeneticBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                        
                    }
  
                    break;
                case "QuatumBillPrint.ascx":
                    objCtrl = LoadControl("../CommonControls/QuatumBillPrint.ascx");
                    CommonControls_QuatumBillPrint QuantumBillprint = (CommonControls_QuatumBillPrint)objCtrl;
                    objCtrl.ID = "QuatumBillPrint";
                    QuantumBillprint.LoadSessionValue();
                    QuantumBillprint.LoadBillConfigMetadata(OrgID, ILocationID);
                    QuantumBillprint.BillPrinting(visitID, FinalBillID, pdp);

                    break;
                case "Anjanabillprint.ascx":
                    objCtrl = LoadControl("../CommonControls/Anjanabillprint.ascx");
                    CommonControls_Anjanabillprint Anjanabillprint = (CommonControls_Anjanabillprint)objCtrl;
                    objCtrl.ID = "Anjanabillprint";
                    Anjanabillprint.LoadSessionValue();
                    Anjanabillprint.LoadBillConfigMetadata(OrgID, ILocationID);
                    Anjanabillprint.BillPrinting(visitID, FinalBillID, pdp);
                    ////////////////////////////////////////////////////////////////////content.Style.Add("display", "none");
                    trPrintPrescription.Style.Add("display", "none");
                    trUserControls.Style.Add("display", "none");
                    break;
                case "Infexnbillprint.ascx":
                    objCtrl = LoadControl("../CommonControls/Infexnbillprint.ascx");
                    CommonControls_Infexnbillprint Infexnbillprint = (CommonControls_Infexnbillprint)objCtrl;
                    objCtrl.ID = "Infexnbillprint";
                    Infexnbillprint.LoadSessionValue();
                    Infexnbillprint.LoadBillConfigMetadata(OrgID, ILocationID);
                    Infexnbillprint.BillPrinting1(visitID, FinalBillID, pdp);
                    ////////////////////////////////////////////////////////////////////content.Style.Add("display", "none");
                    trPrintPrescription.Style.Add("display", "none");
                    trUserControls.Style.Add("display", "none");
                    break;
                case "Uniscanbillprint.ascx":
                    objCtrl = LoadControl("../CommonControls/Uniscanbillprint.ascx");
                    CommonControls_Uniscanbillprint Uniscanbillprint = (CommonControls_Uniscanbillprint)objCtrl;
                    objCtrl.ID = "Uniscanbillprint";
                    Uniscanbillprint.LoadSessionValue();
                    Uniscanbillprint.LoadBillConfigMetadata(OrgID, ILocationID);
                    Uniscanbillprint.BillPrinting(visitID, FinalBillID, pdp);
                    ////////////////////////////////////////////////////////////////////content.Style.Add("display", "none");
                    trPrintPrescription.Style.Add("display", "none");
                    trUserControls.Style.Add("display", "none");
                    break;
                default:
                    objCtrl = LoadControl("../CommonControls/BillPrint.ascx");
                    Billing_BillPrint oBaseBillPrint = (Billing_BillPrint)objCtrl;
                    objCtrl.ID = "BillPrint";
                    oBaseBillPrint.LoadSessionValue();
                    oBaseBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                    oBaseBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    btnPrintFullBill.Visible = true;
                    btnPrint.Visible = true;
                    btnDynamicPrint.Visible = false;
                    if (oBaseBillPrint.isDynamicPrint)
                    {
                        pagetdPrint.InnerHtml = oBaseBillPrint.getprinter();
                        btnDynamicPrint.Visible = true;
                        btnPrint.Visible = false;
                        if (Request.QueryString["dinc"] != null)
                        {
                            btnDynamicPrint.Visible = false;
                            oBaseBillPrint.Visible = false;
                            Response.Write(pagetdPrint.InnerHtml);
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript: window.print();", true);
                        }

                    }

                    GridView gvBillingDetail = (GridView)oBaseBillPrint.FindControl("gvBillingDetail");

                    if (gvBillingDetail.Rows.Count > 0)
                    {
                        string Str;
                        Str = "Y";
                        foreach (GridViewRow row in gvBillingDetail.Rows)
                        {
                            Label lblSplit = (Label)row.FindControl("lblSplitDescription");

                            if (lblSplit.Text != "")
                            {
                                Str = "N";
                            }

                        }
                        if (Str == "Y")
                        {
                            chkSplit.Style.Add("display", "none"); 
                        }

                    }

                    break;
            }
            //objCtrl.ID = "CustomBillControl";
            pnlBillPrint.Controls.Add(objCtrl);
            #endregion

            if (pageid == "SPP")
            {
                ucSecPPage.Visible = true;
                ucSecPPage.loadPatientSecPrintPage();
                OPCaseSheet.Visible = false;
                ancCaseSheet.Visible = false;
                //BillPrint.Visible = false;
                //EsBillPrint1.Visible = false;
                //rakshithbillPrint.Visible = false;
                //medfortBillPrint.Visible = false;
                PrintPrescription.Visible = false;
                Treatment.Visible = false;
                Receipt.Visible = false;
                onFlowDialysis.Visible = false;
                DialysisCaseSheet.Visible = false;

                //chkheader.Style.Add("display", "none");
                //NMCMeerutBill.Visible = false;
            }
            else if (pageid == "BP")
            {
                //OPCaseSheet.LoadPatientDetails(visitID, 0);
                if (lstvisitpurpose.Count > 0)
                {
                    string strConfigKey = "CustomizedIPViewBilling";
                    string configValue = GetConfigValue(strConfigKey, OrgID);
                    if (lstvisitpurpose[0].VisitPurposeName == "Admission")
                    {
                        if (Request.QueryString["CCPage"] == "Y")
                        {
                            if (configValue == "Y")
                            {
                                Response.Redirect("../InPatient/KMHIPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y" + "&IsPopup=Y&CCPage=Y");
                            }
                            else
                            {
                                Response.Redirect("../InPatient/IPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y" + "&IsPopup=Y&CCPage=Y");
                            }
                        }
                        else
                        {
                            if (Request.QueryString["action"] == "print")
                            {
                                if (configValue == "Y")
                                {
                                    Response.Redirect("../InPatient/KMHIPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y&action=print");
                                }
                                else
                                {
                                    Response.Redirect("../InPatient/IPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y&action=print");
                                }
                            }
                            else
                            {
                                if (configValue == "Y")
                                {
                                    Response.Redirect("../InPatient/KMHIPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y");
                                }
                                else
                                {
                                    Response.Redirect("../InPatient/IPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y");
                                }
                            }
                        }
                    }
                    else
                    {
                        #region Commented Code
                        /*
                        if (RedirectPage == "RakshithBillPrint.ascx")
                        {
                            rakshithbillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = true;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "EsBillPrint.ascx")
                        {
                            EsBillPrint1.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = true;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "Medfort_BillPrint.ascx")
                        {
                            medfortBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            medfortBillPrint.Visible = true;
                            rakshithbillPrint.Visible = false ;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                            
                        }
                        else if (RedirectPage == "JulianBillPrint.ascx")
                        {
                            JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            JulianBillPrint.Visible = true;
                            medfortBillPrint.Visible = false;
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            NMCMeerutBill.Visible = false;

                        }
                        else if (RedirectPage == "NMC-MeerutBill.ascx")
                        {
                            NMCMeerutBill.BillPrinting(visitID, FinalBillID, pdp);
                            NMCMeerutBill.Visible = true;
                            JulianBillPrint.Visible = false;
                            medfortBillPrint.Visible = false;
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;

                        }
                        else
                        {
                            BillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            BillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        */
                        #endregion

                        ucSecPPage.Visible = false;
                        OPCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        //BillPrint.Visible = true;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;

                        // chkheader.Style.Add("display", "none");
                    }
                }
            }
            else if (pageid == "CP")
            {
                if (lstvisitpurpose.Count > 0)
                {

                    string strConfigKey1 = "EMRcasesheet";

                    string configValue1 = GetConfigValue(strConfigKey1, OrgID);

                    if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                    {
                        DialysisCaseSheet.loadDialysisDetails(visitID);
                        DialysisCaseSheet.LoadPatientPrescription();
                        //BillPrint.BillPrinting(visitID);
                        //onFlowDialysis.GetData(visitID, false);
                        ucSecPPage.Visible = false;
                        OPCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        //BillPrint.Visible = false;
                        //EsBillPrint1.Visible = false;
                        //rakshithbillPrint.Visible = false;
                        //JulianBillPrint.Visible = false;
                        //medfortBillPrint.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = true;
                        //NMCMeerutBill.Visible = false;
                    }
                    else
                    {



                        //emr case sheet added
                        //end 

                        //OPCaseSheet.LoadPatientDetails(visitID, 0);
                        //OPCaseSheet.Visible = true;
                        if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                        {

                            if (configValue1 == "Y")
                            {
                                EMRCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = false;
                                ancCaseSheet.Visible = false;
                                EMRCaseSheet.Visible = true;

                            }
                            else
                            {

                                string chkheader = Request.QueryString["chkheader"];

                                if (chkheader == "Y")
                                {
                                    OPCaseSheet.FindControl("imgBillLogo").Visible = true;
                                    Label lbHospName = (Label)OPCaseSheet.FindControl("lblHospitalName");
                                    if (lbHospName.Visible == false)
                                    {
                                        lbHospName.Visible = true;
                                    }
                                    OPCaseSheet.FindControl("lblHospitalName").Visible = true;
                                    OPCaseSheet.FindControl("lblfooter").Visible = true;
                                    OPCaseSheet.FindControl("lblmoto").Visible = true;
                                    OPCaseSheet.LoadPatientDetails(visitID, 0);
                                    OPCaseSheet.Visible = true;
                                    ancCaseSheet.Visible = false;
                                    EMRCaseSheet.Visible = false;
                                    pnlBillPrint.Visible = false;

                                }
                                else
                                {

                                    OPCaseSheet.LoadPatientDetails(visitID, 0);
                                    OPCaseSheet.Visible = true;
                                    ancCaseSheet.Visible = false;
                                    EMRCaseSheet.Visible = false;
                                    pnlBillPrint.Visible = false;


                                }

                                OPCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = true;
                                ancCaseSheet.Visible = false;
                                EMRCaseSheet.Visible = false;
                                pnlBillPrint.Visible = false;
                            }
                        }
                        else
                        {
                            ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                            ancCaseSheet.Visible = true;
                            OPCaseSheet.Visible = false;
                            EMRCaseSheet.Visible = false;
                            pnlBillPrint.Visible = false;
                        }
                        ucSecPPage.Visible = false;
                        //BillPrint.Visible = false;
                        //rakshithbillPrint.Visible = false;
                        //EsBillPrint1.Visible = false;
                        //medfortBillPrint.Visible = false;
                        //JulianBillPrint.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;

                        DialysisCaseSheet.Visible = false;
                        //NMCMeerutBill.Visible = false;
                    }
                }
            }
            else if (pageid == "CR")
            {
                if (lstvisitpurpose.Count > 0)
                {
                    if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                    {
                        DialysisCaseSheet.loadDialysisDetails(visitID);
                        DialysisCaseSheet.LoadPatientPrescription();

                        #region Commented code
                        /*
                        if (RedirectPage == "RakshithBillPrint.ascx")
                        {
                            rakshithbillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = true;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "EsBillPrint.ascx")
                        {
                            EsBillPrint1.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = true;
                            medfortBillPrint.Visible = false;
                        }
                        else if (RedirectPage == "Medfort_BillPrint.ascx")
                        {
                            medfortBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            medfortBillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            NMCMeerutBill.Visible = false;

                        }
                        else
                        {
                            BillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            BillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        } */
                        #endregion

                        PrintPrescription.LoadDetails(visitID);

                        ucSecPPage.Visible = false;
                        OPCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        // BillPrint.Visible = true;
                        PrintPrescription.Visible = true;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = true;
                        string chkheaders = GetConfigValue("PrintCaseSheetWithHeader", OrgID);
                        if (chkheaders == 'Y'.ToString())
                        {
                            chkheader.Style.Add("display", "block");
                        }

                    }
                    else
                    {
                        if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                        {

                            string chkheader = Request.QueryString["chkheader"];
                            if (chkheader == "Y")
                            {
                                OPCaseSheet.FindControl("imgBillLogo").Visible = true;
                                Label lbHospName = (Label)OPCaseSheet.FindControl("lblHospitalName");
                                if (lbHospName.Visible == false)
                                {
                                    lbHospName.Visible = true;
                                }
                                OPCaseSheet.FindControl("lblHospitalName").Visible = true;
                                OPCaseSheet.FindControl("lblfooter").Visible = true;
                                OPCaseSheet.FindControl("lblmoto").Visible = true;
                                OPCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = true;
                                ancCaseSheet.Visible = false;
                                btnPrint.Visible = false;
                                pnlBillPrint.Visible = false;

                            }
                            else
                            {
                                OPCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = true;
                                ancCaseSheet.Visible = false;
                                btnPrint.Visible = false;
                                pnlBillPrint.Visible = false;

                            }
                        }
                        else
                        {
                            ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                            ancCaseSheet.Visible = true;
                            OPCaseSheet.Visible = false;
                        }
                        ucSecPPage.Visible = false;

                        #region Commented Code
                        /*
                        if (RedirectPage == "RakshithBillPrint.ascx")
                        {
                            rakshithbillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = true;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "EsBillPrint.ascx")
                        {
                            EsBillPrint1.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = true;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "Medfort_BillPrint.ascx")
                        {
                            EsBillPrint1.BillPrinting(visitID, FinalBillID, pdp);
                            rakshithbillPrint.Visible = false;
                            medfortBillPrint.Visible = true;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else
                        {
                            BillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            BillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        } */
                        #endregion

                        //PrintPrescription.LoadDetails(visitID);
                        //JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                        //JulianBillPrint.Visible = true;
                        //BillPrint.Visible = true;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                    }
                }
            }
            else if (pageid == "PP")
            {
                //PrintPrescription.LoadDetails(visitID);
                ucSecPPage.Visible = false;
                OPCaseSheet.Visible = false;
                ancCaseSheet.Visible = false;
                //BillPrint.Visible = false;
                //EsBillPrint1.Visible = false;
                //rakshithbillPrint.Visible = false;
                //medfortBillPrint.Visible = false;
                PrintPrescription.Visible = true;
                Treatment.Visible = false;
                Receipt.Visible = false;
                onFlowDialysis.Visible = false;
                DialysisCaseSheet.Visible = false;

                //
                //JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                //JulianBillPrint.Visible = true;
                //NMCMeerutBill.Visible = false;
            }
            else if (pageid == "CPL")
            {
                if (lstvisitpurpose.Count > 0)
                {
                    if (lstvisitpurpose[0].VisitPurposeName == "Lab Report")
                    {
                        DialysisCaseSheet.loadDialysisDetails(visitID);
                        DialysisCaseSheet.LoadPatientPrescription();
                        //BillPrint.BillPrinting(visitID);

                        //onFlowDialysis.GetData(visitID, false);

                        ucSecPPage.Visible = false;
                        OPCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        //BillPrint.Visible = false;
                        //rakshithbillPrint.Visible = false;
                        //medfortBillPrint.Visible = false;
                        //EsBillPrint1.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = true;

                        chkheader.Style.Add("display", "none");
                        //NMCMeerutBill.Visible = false;
                    }
                    else
                    {

                        //OPCaseSheet.LoadPatientDetails(visitID, 0);
                        //OPCaseSheet.Visible = true;
                        if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                        {
                            OPCaseSheet.LoadPatientDetails(visitID, 0);
                            OPCaseSheet.Visible = true;
                            ancCaseSheet.Visible = false;
                        }
                        else
                        {
                            ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                            ancCaseSheet.Visible = true;
                            OPCaseSheet.Visible = false;
                        }
                        ucSecPPage.Visible = false;
                        //BillPrint.Visible = false;
                        //EsBillPrint1.Visible = false;
                        //rakshithbillPrint.Visible = false;
                        //medfortBillPrint.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                        //NMCMeerutBill.Visible = false;
                    }
                }
            }
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
            }
            if (Request.QueryString["chkheader"] != null)
            {
                btnPrint.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Reception-ViewPrintPage.aspx", ex);
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            //string RedirectPage = GetConfigValue("Navigation", OrgID);
            //if (RedirectPage == "Navigation")
            //{
            //    Response.Redirect(Request.ApplicationPath + "/Billing/HospitalBillSearch.aspx", true);
            //}
            //else
            //{

            if (Request.QueryString["RedirectPage"] == null)
            {
                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
            else
            {
                string RedirectPage = Request.QueryString["RedirectPage"];
                Response.Redirect(Request.ApplicationPath + RedirectPage, true);
            }


            //}

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }

    protected void btnBack_Click1(object sender, EventArgs e)
    {
        if (Request.QueryString["billNo"] == null && Request.QueryString["billNo"] == "")
            Response.Redirect(Request.ApplicationPath + "/Reception/VisitDetails.aspx", true);
        else if (Request.QueryString["billNo"] != "")
            Response.Redirect(Request.ApplicationPath + "/Billing/HospitalBillSearch.aspx", true);

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        string chkheader = Request.QueryString["chkheader"];
        if (chkheader == "Y")
        {
            OPCaseSheet.FindControl("imgBillLogo").Visible = true;
            Label lbHospName = (Label)OPCaseSheet.FindControl("lblHospitalName");
            if (lbHospName.Visible == false)
            {
                lbHospName.Visible = true;
            }
            OPCaseSheet.FindControl("lblHospitalName").Visible = true;
            OPCaseSheet.FindControl("lblfooter").Visible = true;
            OPCaseSheet.FindControl("lblmoto").Visible = true;
            OPCaseSheet.LoadPatientDetails(visitID, 0);
            OPCaseSheet.Visible = true;
            ancCaseSheet.Visible = false;
            EMRCaseSheet.Visible = false;
        }
        else
        {
            OPCaseSheet.LoadPatientDetails(visitID, 0);
            OPCaseSheet.Visible = true;
            ancCaseSheet.Visible = false;
            EMRCaseSheet.Visible = false;
        }

    }

    protected void btnPrintBarcode_Click(object sender, EventArgs e)
    {
        try
        {
            if (!String.IsNullOrEmpty(Request.QueryString["vid"]) && !String.IsNullOrEmpty(Request.QueryString["bid"]))
            {
                long visitId = -1;
                long billId = -1;
                Int64.TryParse(Request.QueryString["vid"], out visitId);
                Int64.TryParse(Request.QueryString["bid"], out billId);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + visitId + "&billId=" + billId + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.Bill + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
            }
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while generating barcode.";
            CLogger.LogError("Error in Print Barcode", ex);
        }
    }

    public string isQuickPrint()
    {
        string strVal = "N";
        if (Request.QueryString["quickbill"] != null)
        {
            strVal = Request.QueryString["quickbill"].ToString();
        }
        return strVal;
    }
}
