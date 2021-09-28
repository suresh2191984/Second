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
using System.IO;
using System.Collections;


public partial class Reception_PrintPage : BasePage
{
    public Reception_PrintPage()
        : base("Reception_PrintPage.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long visitID = -1;
    long taskID = -1;
    string pagetype = string.Empty;
    long returncode = -1;
    int orgID;
    int pdid = -1;
    int iCheckedCount = 0;
    long patientID = -1;
    int pdp = -1;
    int specialityid, followup;
    string configValue = string.Empty;
    string isneedinv = string.Empty;
    string lstSampleId = string.Empty;
    List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int32.TryParse(Request.QueryString["pdp"], out pdp);
            pagetype = Request.QueryString["pagetype"].ToString();
            PatientVisit_BL pvBL = new PatientVisit_BL(base.ContextInfo);
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            if (Request.QueryString["IsNeedInv"] != null)
            {
                isneedinv = Request.QueryString["IsNeedInv"].ToString();
            }

            if (!String.IsNullOrEmpty(Request.QueryString["sampleId"]))
            {
                lstSampleId = Convert.ToString(Request.QueryString["sampleId"]);
            }

            long FinalBillID = 0;
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);

            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            ancBL.GetANCSpecilaityID(visitID, out specialityid, out followup);
            string RedirectPage = GetConfigValue("BillPrintControl", orgID);
            string strConfigKey = "EMRcasesheet";

            configValue = GetConfigValue(strConfigKey, orgID);
            returncode = pvBL.GetVisitPurposeName(orgID, visitID, out lstvisitpurpose);

            iCheckedCount = (chkCaseSheet.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkBillPrint.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkPrintPrescription.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkTreatment.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkReceipt.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkonFlowDialysis.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkDialysisCaseSheet.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            iCheckedCount = (chkSecPage.Checked == true ? iCheckedCount + 1 : iCheckedCount);

            #region Newly Added By sami
            iCheckedCount = (chkHealthPKG.Checked == true ? iCheckedCount + 1 : iCheckedCount);
            #endregion

            // <p class="pagestart"></p>
            JulianBillPrint.Visible = false;
            if (pagetype == "SPP")
            {

                OPCaseSheet.Visible = false;
                ancCaseSheet.Visible = false;

                chkCaseSheet.Visible = false;

                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                rakshithbillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                chkBillPrint.Visible = false;

                PrintPrescription.Visible = false;
                chkPrintPrescription.Visible = false;

                Treatment.Visible = false;
                chkTreatment.Visible = false;

                Receipt.Visible = false;
                chkReceipt.Visible = false;

                onFlowDialysis.Visible = false;
                chkonFlowDialysis.Visible = false;

                DialysisCaseSheet.Visible = false;
                chkDialysisCaseSheet.Visible = false;

                chkSecPage.Visible = true;
                ucSecPPage.Visible = true;
                chkSecPage.Checked = true;
                ucSecPPage.loadPatientSecPrintPage();

                #region sami Added
                PrintHistory1.Visible = false;
                PrintExam1.Visible = false;
                grdResult.Visible = false;
                chkHealthPKG.Visible = false;
                #endregion

                btnFilter_Click(sender, e);
            }
            if (pagetype == "BP")
            {
                //OPCaseSheet.LoadPatientDetails(visitID, 0);
                //if (RedirectPage != string.Empty)
                //{
                //    rakshithbillPrint.BillPrinting(visitID, FinalBillID);
                //    rakshithbillPrint.Visible = true;
                //    BillPrint.Visible = false;
                //}
                //else
                //{
                //    BillPrint.BillPrinting(visitID, FinalBillID);
                //    BillPrint.Visible = true;
                //    rakshithbillPrint.Visible = false;
                //}
               // BillPrint.BillPrinting(visitID, FinalBillID);
                if (RedirectPage == "RakshithBillPrint.ascx")
                {
                    rakshithbillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    rakshithbillPrint.Visible = true;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    medfortBillPrint.Visible = false;
                    JulianBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;
                   
                }
                else if (RedirectPage == "EsBillPrint.ascx")
                {
                    EsBillPrint1.BillPrinting(visitID, FinalBillID, pdp);
                    EsBillPrint1.LoadBillConfigMetadata(orgID, ILocationID);
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = true;
                    medfortBillPrint.Visible = false;
                    JulianBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "Medfort_BillPrint.ascx")
                {
                    medfortBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    medfortBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    medfortBillPrint.Visible = true;
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    JulianBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					 IGeneticBillPrint.Visible = false;
                     Uniscanbillprint.Visible = false;
                     Infexnbillprint.Visible = false;
                     Genes2meBillPrint.Visible = false;

                }
                else if (RedirectPage == "JulianBillPrint.ascx")
                {
                    JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    JulianBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    JulianBillPrint.Visible = true;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    NMCMeerutBill.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					 IGeneticBillPrint.Visible = false;
                     Uniscanbillprint.Visible = false;
                     Infexnbillprint.Visible = false;
                     Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "NMC-MeerutBill.ascx")
                {
                    NMCMeerutBill.BillPrinting(visitID, FinalBillID, pdp);
                    NMCMeerutBill.LoadBillConfigMetadata(orgID, ILocationID);
                    NMCMeerutBill.Visible = true;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
					 IGeneticBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;
                }
				 else if (RedirectPage == "IGeneticBillPrint.ascx")
                {
                    //QuantumBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    string strIgeN_BillType=string.Empty;

                    if(!string.IsNullOrEmpty( Request.QueryString["duplicateBill"].ToString()))
                    {
                       strIgeN_BillType = Request.QueryString["duplicateBill"].ToString();
                    }

                    if (strIgeN_BillType == "Y")
                    {
                        IGeneticBillPrint.BillPrinting1(visitID, FinalBillID, pdp);
                    }
                    else
                    {
                        IGeneticBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    }
                    IGeneticBillPrint.Visible = true;
                    Infexnbillprint.Visible = false;
                    IGeneticBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    QuantumBillPrint.Visible = false;
                    advBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
					   Anjanabillprint.Visible = false;
					   QuantumBillPrint.Visible = false;
                       Uniscanbillprint.Visible = false;
                       Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "Infexnbillprint.ascx")
                {

                        Infexnbillprint.BillPrinting1(visitID, FinalBillID, pdp);
                    
                    ////IGeneticBillPrint.Visible = true;
                    IGeneticBillPrint.Visible = false;
                    Infexnbillprint.Visible = true;
                    IGeneticBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    QuantumBillPrint.Visible = false;
                    advBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
					   Anjanabillprint.Visible = false;
					   QuantumBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "AdvanceBillPrint.ascx" && isneedinv!="Y")
                {
                    advBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    advBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    advBillPrint.Visible = true;

                    //Genes2meBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    //Genes2meBillPrint.Visible = true;
                    //Genes2meBillPrint.LoadBillConfigMetadata(orgID, ILocationID);

                    //advBillPrint.Visible = false;


                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;

                }
                else if (RedirectPage == "Genes2meBillPrint.ascx" )
                {
                    
                    Genes2meBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    Genes2meBillPrint.Visible = true;
                    Genes2meBillPrint.LoadBillConfigMetadata(orgID, ILocationID);

                    advBillPrint.Visible = false;

                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;

                }
                else if (RedirectPage == "QuatumBillPrint.ascx" && isneedinv!="Y")
                {
                    QuantumBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    QuantumBillPrint.Visible = true;
                    QuantumBillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                    advBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                     SRSBillPrint.Visible = false;
                     Anjanabillprint.Visible = false;
					  IGeneticBillPrint.Visible = false;
                      Uniscanbillprint.Visible = false;
                      Infexnbillprint.Visible = false;
                      Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "Anjanabillprint.ascx" && isneedinv!="Y" )
                {
                    Anjanabillprint.BillPrinting(visitID, FinalBillID, pdp);
                    Anjanabillprint.Visible = true;
                    Anjanabillprint.LoadBillConfigMetadata(orgID, ILocationID);
                    QuantumBillPrint.Visible = false;
                    advBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
                     IGeneticBillPrint.Visible = false;
                     Infexnbillprint.Visible = false;
                     Uniscanbillprint.Visible = false;
                     Genes2meBillPrint.Visible = false;
                }
                else if (RedirectPage == "Uniscanbillprint.ascx" && isneedinv != "Y")
                {
                    Uniscanbillprint.BillPrinting(visitID, FinalBillID, pdp);
                    Uniscanbillprint.Visible = true;
                    Uniscanbillprint.LoadBillConfigMetadata(orgID, ILocationID);
                    QuantumBillPrint.Visible = false;
                    advBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    JulianBillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
                     IGeneticBillPrint.Visible = false;
                     Infexnbillprint.Visible = false;
                     Genes2meBillPrint.Visible = false;
                }
                else
                {
                    if (isneedinv != "Y")
                    {
                        BillPrint.BillPrinting(visitID, FinalBillID, pdp);
                        BillPrint.Visible = true;
                        BillPrint.LoadBillConfigMetadata(orgID, ILocationID);
                        BillPrint.Visible = false;
                        rakshithbillPrint.Visible = false;
                        EsBillPrint1.Visible = false;
                        medfortBillPrint.Visible = false;
                        JulianBillPrint.Visible = false;
                        NMCMeerutBill.Visible = false;
                        SRSBillPrint.Visible = false;
                        advBillPrint.Visible = false;
                        QuantumBillPrint.Visible = false;
                        Anjanabillprint.Visible = false;
						 IGeneticBillPrint.Visible = false;
						 Uniscanbillprint.Visible = false;
                         Infexnbillprint.Visible = false;
                         Genes2meBillPrint.Visible = false;
                    }
                    //SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp);
                    //SRSBillPrint.Visible = true;
                    
                }
                if (isneedinv == "Y")
                {
                    BillPrint.Visible = false;
                    SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp, lstSampleId);
                    SRSBillPrint.Visible = true; 
                    rakshithbillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    medfortBillPrint.Visible = false;
                    JulianBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;
                    advBillPrint.Visible = false;
                    QuantumBillPrint.Visible = false;
                    Anjanabillprint.Visible = false;
					IGeneticBillPrint.Visible = false;
                    Uniscanbillprint.Visible = false;
                    Infexnbillprint.Visible = false;
                    Genes2meBillPrint.Visible = false;
                }

                if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                {
                    OPCaseSheet.Visible = false;
                }
                else
                {
                    ancCaseSheet.Visible = false;
                }
                chkCaseSheet.Visible = false;

                //BillPrint.Visible = true;
                chkBillPrint.Visible = true;
                chkBillPrint.Checked = true;

                PrintPrescription.Visible = false;
                chkPrintPrescription.Visible = false;

                Treatment.Visible = false;
                chkTreatment.Visible = false;

                Receipt.Visible = false;
                chkReceipt.Visible = false;

                onFlowDialysis.Visible = false;
                chkonFlowDialysis.Visible = false;

                DialysisCaseSheet.Visible = false;
                chkDialysisCaseSheet.Visible = false;

                chkSecPage.Visible = false;
                ucSecPPage.Visible = false;

                #region sami Added
                PrintHistory1.Visible = false;
                PrintExam1.Visible = false;
                grdResult.Visible = false;
                chkHealthPKG.Visible = false;
                #endregion

                btnFilter_Click(sender, e);

            }
            if (pagetype == "CP")
            {
                if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                {
                    DialysisCaseSheet.loadDialysisDetails(visitID);
                    DialysisCaseSheet.LoadPatientPrescription();
                    //BillPrint.BillPrinting(visitID);

                    //onFlowDialysis.GetData(visitID, false);

                    //OPCaseSheet.Visible = false;
                    if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                    {




                        OPCaseSheet.Visible = false;
                    }
                    else
                    {
                        ancCaseSheet.Visible = false;
                    }
                    chkCaseSheet.Visible = false;

                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    rakshithbillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    chkBillPrint.Visible = false;
                    JulianBillPrint.Visible = false;
                    NMCMeerutBill.Visible = false;

                    PrintPrescription.Visible = false;
                    chkPrintPrescription.Visible = false;

                    Treatment.Visible = false;
                    chkTreatment.Visible = false;

                    Receipt.Visible = false;
                    chkReceipt.Visible = false;

                    onFlowDialysis.Visible = false;
                    chkonFlowDialysis.Visible = false;

                    chkSecPage.Visible = false;
                    ucSecPPage.Visible = false;

                    #region sami Added
                    PrintHistory1.Visible = false;
                    PrintExam1.Visible = false;
                    grdResult.Visible = false;
                    chkHealthPKG.Visible = false;
                    #endregion
                }
                else
                {
                    if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                    {
                        if (configValue == "Y")
                        {

                            OPCaseSheet.Visible = false;
                            ancCaseSheet.Visible = false;
                            EMRCaseSheet.LoadPatientDetails(visitID, 0);
                            EMRCaseSheet.Visible = true;


                        }

                        else
                        {
                            string chkhead = Request.QueryString["chkheader"].ToString();
                            if (chkhead == "Y")
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


                            OPCaseSheet.LoadPatientDetails(visitID, 0);
                            OPCaseSheet.Visible = true;
                            ancCaseSheet.Visible = false;
                            EMRCaseSheet.Visible = false;
                        }
                    }


                    else
                    {
                        ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                        ancCaseSheet.Visible = true;
                        OPCaseSheet.Visible = false;
                        EMRCaseSheet.Visible = false;
                    }


                    BillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    rakshithbillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    PrintPrescription.Visible = false;
                    NMCMeerutBill.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;

                    chkCaseSheet.Visible = true;
                    chkBillPrint.Visible = false;
                    chkPrintPrescription.Visible = false;
                    chkTreatment.Visible = false;
                    chkReceipt.Visible = false;
                    chkonFlowDialysis.Visible = false;
                    chkDialysisCaseSheet.Visible = false;

                    chkSecPage.Visible = false;
                    ucSecPPage.Visible = false;
                    chkCaseSheet.Checked = true;
                    JulianBillPrint.Visible = false ;
                    #region sami Added
                    PrintHistory1.Visible = false;
                    PrintExam1.Visible = false;
                    grdResult.Visible = false;
                    chkHealthPKG.Visible = false;
                    #endregion

                    btnFilter_Click(sender, e);

                   
                }
            }
            if (pagetype == "CR")
            {
                if (lstvisitpurpose[0].VisitPurposeName == "Health Package")
                {

                   
                  
                    GetHealthPKGData();
                    //if (RedirectPage != string.Empty)
                    //{
                    //    rakshithbillPrint.BillPrinting(visitID, FinalBillID);
                    //    rakshithbillPrint.Visible = true;
                    //    BillPrint.Visible = false;
                    //}
                    //else
                    //{
                    //    BillPrint.BillPrinting(visitID, FinalBillID);
                    //    BillPrint.Visible = true;
                    //    rakshithbillPrint.Visible = false;
                    //}
                    
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
                        medfortBillPrint.Visible = false ;
                        NMCMeerutBill.Visible = false;
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
                        //SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp);
                        //SRSBillPrint.Visible = true;
                        BillPrint.Visible = true;
                      
                        rakshithbillPrint.Visible = false;
                        EsBillPrint1.Visible = false;
                        medfortBillPrint.Visible = false;
                        NMCMeerutBill.Visible = false;
                    }
                    if (isneedinv == "Y")
                    {
                        SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp,"");
                        SRSBillPrint.Visible = true;
                        BillPrint.Visible = false;
                        rakshithbillPrint.Visible = false;
                        EsBillPrint1.Visible = false;
                        medfortBillPrint.Visible = false;
                        JulianBillPrint.Visible = false;
                        NMCMeerutBill.Visible = false;
                    }
                    //BillPrint.BillPrinting(visitID, FinalBillID);
                    //PrintPrescription.LoadDetails(visitID);

                    //BillPrint.Visible = true;
                    //divBillPrint.InnerHtml = "";
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    chkCaseSheet.Visible = true;
                    chkBillPrint.Visible = true;
                    chkPrintPrescription.Visible = false;
                    chkTreatment.Visible = false;
                    chkReceipt.Visible = false;
                    chkonFlowDialysis.Visible = false;
                    chkDialysisCaseSheet.Visible = false;
                    OPCaseSheet.Visible = true;
                    OPCaseSheet.LoadPatientDetails(visitID, 0);
                    ancCaseSheet.Visible = false;

                    chkSecPage.Visible = false;
                    ucSecPPage.Visible = false;
                    #region sami Added
                     chkHealthPKG.Visible = true;
                    #endregion
                    ucSecPPage.loadPatientSecPrintPage();
                }
                else
                {
                    if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                    {

                        DialysisCaseSheet.loadDialysisDetails(visitID);
                        DialysisCaseSheet.LoadPatientPrescription();
                        //if (RedirectPage != string.Empty)
                        //{
                        //    rakshithbillPrint.BillPrinting(visitID, FinalBillID);
                        //    rakshithbillPrint.Visible = true;
                        //    BillPrint.Visible = false;
                        //}
                        //else
                        //{
                        //    BillPrint.BillPrinting(visitID, FinalBillID);
                        //    BillPrint.Visible = true;
                        //    rakshithbillPrint.Visible = false;
                        //}
                        //BillPrint.BillPrinting(visitID, FinalBillID);
                        if (RedirectPage == "RakshithBillPrint.ascx")
                        {
                            rakshithbillPrint.BillPrinting(visitID, FinalBillID,pdp);
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
                            medfortBillPrint.Visible = false ;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        else if (RedirectPage == "Medfort_BillPrint.ascx")
                        {
                            medfortBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            medfortBillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            BillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;

                        }
                        else
                        {
                            BillPrint.BillPrinting(visitID, FinalBillID, pdp);
                            //SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp);
                            BillPrint.Visible = true;
                            //SRSBillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        if (isneedinv == "Y")
                        {
                            SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp,"");
                            SRSBillPrint.Visible = true;
                            BillPrint.Visible = false;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        PrintPrescription.LoadDetails(visitID);

                        OPCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        //BillPrint.Visible = true;
                        PrintPrescription.Visible = true;
                        //divPrintPrescription.InnerHtml = "<p class='pagestart'></p>";
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = true;
                        
                       


                        chkCaseSheet.Visible = false;
                        chkBillPrint.Visible = true;
                        chkPrintPrescription.Visible = true;
                        chkTreatment.Visible = false;
                        chkReceipt.Visible = false;
                        chkonFlowDialysis.Visible = false;
                        chkDialysisCaseSheet.Visible = true;

                        chkSecPage.Visible = false;
                        ucSecPPage.Visible = false;

                        #region sami Added
                        PrintHistory1.Visible = false;
                        PrintExam1.Visible = false;
                        grdResult.Visible = false;
                        chkHealthPKG.Visible = false;
                        #endregion
                        string PrintOnflow = GetConfigValue("ViewOnFlow", orgID);
                        if (PrintOnflow == "N")
                        {
                            DialysisCaseSheet.FindControl("grdOnFlowDialysis").Visible = false;
                        }
                    }
                    else
                    {
                        //OPCaseSheet.LoadPatientDetails(visitID, 0);
                        //OPCaseSheet.Visible = true;
                        if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                        {
                            if (configValue == "Y")
                            {
                                EMRCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = false;
                                ancCaseSheet.Visible = false;
                                EMRCaseSheet.Visible = true;
                            }

                            else
                            {
                                OPCaseSheet.LoadPatientDetails(visitID, 0);
                                OPCaseSheet.Visible = true;
                                ancCaseSheet.Visible = false;
                                EMRCaseSheet.Visible = false;
                            }

                           
                        }
                        else
                        {
                            ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                            ancCaseSheet.Visible = true;
                            OPCaseSheet.Visible = false;
                        }
                        //if (RedirectPage != string.Empty)
                        //{
                        //    rakshithbillPrint.BillPrinting(visitID, FinalBillID);
                        //    rakshithbillPrint.Visible = true;
                        //    BillPrint.Visible = false;
                        //}
                        //else
                        //{
                        //    BillPrint.BillPrinting(visitID, FinalBillID);
                        //    BillPrint.Visible = true;
                        //    rakshithbillPrint.Visible = false;
                        //}
                        //BillPrint.BillPrinting(visitID, FinalBillID);
                        //PrintPrescription.LoadDetails(visitID);

                        //BillPrint.Visible = true;
                        //divBillPrint.InnerHtml = "";
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
                            //SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp);
                            BillPrint.Visible = true;
                            //SRSBillPrint.Visible = true;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        if (isneedinv == "Y")
                        {
                            SRSBillPrint.LABBillPrinting(visitID, FinalBillID, pdp,"");
                            SRSBillPrint.Visible = true;
                            BillPrint.Visible = false;
                            rakshithbillPrint.Visible = false;
                            EsBillPrint1.Visible = false;
                            medfortBillPrint.Visible = false;
                            JulianBillPrint.Visible = false;
                            NMCMeerutBill.Visible = false;
                        }
                        JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                        JulianBillPrint.Visible = true;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;

                        chkCaseSheet.Visible = true;
                        chkBillPrint.Visible = true;
                        chkPrintPrescription.Visible = false;
                        chkTreatment.Visible = false;
                        chkReceipt.Visible = false;
                        chkonFlowDialysis.Visible = false;
                        chkDialysisCaseSheet.Visible = false;

                        //chkSecPage.Visible = true;
                        //ucSecPPage.Visible = true;
                        //ucSecPPage.loadPatientSecPrintPage();

                        #region sami Added
                        PrintHistory1.Visible = false;
                        PrintExam1.Visible = false;
                        grdResult.Visible = false;
                        chkHealthPKG.Visible = false;
                        #endregion

                        maintable.Style.Remove("display");
                        maintable.Style.Add("display", "block");
                        divPrintDetails.Style.Add("display", "none");
                    }
                }

            }


            if (pagetype == "PP")
            {
               
                    if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                    {

                        string chkheader = Request.QueryString["chk"].ToString();
                        if (chkheader=="Y")
                        {
                            
                              PrintPrescription.FindControl("imgBillLogo").Visible = true;
                                Label lbHospName = (Label)OPCaseSheet.FindControl("lblHospitalName");
                                if (lbHospName.Visible == false)
                                {
                                    lbHospName.Visible = true;
                                }
                                PrintPrescription.FindControl("lblHospitalName").Visible = true;
                                PrintPrescription.FindControl("lblfooter").Visible = true;
                                PrintPrescription.FindControl("lblmoto").Visible = true;
                                PrintPrescription.LoadDetails(visitID);
                        }
                        else
                        {
                            PrintPrescription.LoadDetails(visitID);
                        }
                        OPCaseSheet.LoadPatientDetails(visitID, 0);
                        OPCaseSheet.Visible = false;
                        BillPrint.Visible = false;
                        ancCaseSheet.Visible = false;
                    }
                    else
                    {
                        ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                        ancCaseSheet.Visible = false;
                        OPCaseSheet.Visible = false;
                    }

                    //PrintPrescription.LoadDetails(visitID);



                    BillPrint.Visible = false;
                    SRSBillPrint.Visible = false;
                    EsBillPrint1.Visible = false;
                    rakshithbillPrint.Visible = false;
                    medfortBillPrint.Visible = false;
                    PrintPrescription.Visible = true;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    NMCMeerutBill.Visible = false;

                    chkCaseSheet.Visible = true;
                    chkBillPrint.Visible = false;
                    chkPrintPrescription.Visible = false;
                    chkTreatment.Visible = false;
                    chkReceipt.Visible = false;
                    chkonFlowDialysis.Visible = false;
                    chkDialysisCaseSheet.Visible = false;

                    chkSecPage.Visible = false;
                    ucSecPPage.Visible = false;
                    chkCaseSheet.Checked = false ;
                    JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    JulianBillPrint.Visible = true;

                    #region sami Added
                    PrintHistory1.Visible = false;
                    PrintExam1.Visible = false;
                    grdResult.Visible = false;
                    chkHealthPKG.Visible = false;
                    #endregion

                    btnFilter_Click(sender, e);
                //}
                //else
                //{
                //    //OPCaseSheet.LoadPatientDetails(visitID, 0);
                //    //OPCaseSheet.Visible = true;
                //    if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                //    {
                //        OPCaseSheet.LoadPatientDetails(visitID, 0);
                //        OPCaseSheet.Visible = true;
                //        ancCaseSheet.Visible = false;
                //    }
                //    else
                //    {
                //        ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                //        ancCaseSheet.Visible = true;
                //        OPCaseSheet.Visible = false;
                //    }

                //    //PrintPrescription.LoadDetails(visitID);


                //    BillPrint.Visible = false;
                //    EsBillPrint1.Visible = false;
                //    rakshithbillPrint.Visible = false;
                //    medfortBillPrint.Visible = false;
                //    PrintPrescription.Visible = false;
                //    Treatment.Visible = false;
                //    Receipt.Visible = false;
                //    onFlowDialysis.Visible = false;
                //    DialysisCaseSheet.Visible = false;

                //    chkCaseSheet.Visible = true;
                //    chkBillPrint.Visible = false;
                //    chkPrintPrescription.Visible = false;
                //    chkTreatment.Visible = false;
                //    chkReceipt.Visible = false;
                //    chkonFlowDialysis.Visible = false;
                //    chkDialysisCaseSheet.Visible = false;

                //    chkSecPage.Visible = false;
                //    ucSecPPage.Visible = false;
                //    chkCaseSheet.Checked = true;
                //    JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                //    JulianBillPrint.Visible = true;

                //    #region sami Added
                //    PrintHistory1.Visible = false;
                //    PrintExam1.Visible = false;
                //    grdResult.Visible = false;
                //    chkHealthPKG.Visible = false;
                //    #endregion

                //    btnFilter_Click(sender, e);
                //}
                
            }
            if (pagetype == "CPL")
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
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                rakshithbillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                PrintPrescription.Visible = false;
                Treatment.Visible = false;
                Receipt.Visible = false;
                onFlowDialysis.Visible = false;
                DialysisCaseSheet.Visible = false;

                chkCaseSheet.Visible = true;
                chkBillPrint.Visible = false;
                chkPrintPrescription.Visible = false;
                chkTreatment.Visible = false;
                chkReceipt.Visible = false;
                chkonFlowDialysis.Visible = false;
                chkDialysisCaseSheet.Visible = false;

                chkSecPage.Visible = false;
                ucSecPPage.Visible = false;
                chkCaseSheet.Checked = true;

                #region sami Added
                PrintHistory1.Visible = false;
                PrintExam1.Visible = false;
                grdResult.Visible = false;
                chkHealthPKG.Visible = false;
                #endregion

                //btnFilter_Click(sender, e);
            }
            #region
            if (pagetype == "DCPR")
            {
                //OPCaseSheet.LoadPatientDetails(visitID, 0);
                //OPCaseSheet.Visible = true;
                  if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                    {
                if (configValue == "Y")
                {
                  
                    OPCaseSheet.Visible = false;
                    ancCaseSheet.Visible = false; 
                    EMRCaseSheet .LoadPatientDetails(visitID ,0);
                    EMRCaseSheet .Visible =true ;


                 }

                else
                {
                    string chkheader = Request.QueryString["chk"].ToString();
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
                        BillPrint.Visible = false;
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
                }
                else
                {
                    ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                    ancCaseSheet.Visible = true;
                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                }
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                rakshithbillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                PrintPrescription.Visible = false;
                Treatment.Visible = false;
                Receipt.Visible = false;
                onFlowDialysis.Visible = false;
                DialysisCaseSheet.Visible = false;

                chkSecPage.Visible = false;
                ucSecPPage.Visible = false;
                JulianBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                JulianBillPrint.Visible = false;
                #region sami Added
                PrintHistory1.Visible = false;
                PrintExam1.Visible = false;
                grdResult.Visible = false;
                chkHealthPKG.Visible = false;
                #endregion

                maintable.Style.Remove("display");
                maintable.Style.Add("display", "block");
                divPrintDetails.Style.Add("display", "none");
                this.Page.RegisterStartupScript("scrpt", "<script language='javascript' type='text/javascript'> window.print();</script>");

            }
            #endregion 
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Reception/Print Page", ex);
        }
            
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        if (chkCaseSheet.Checked)
        {
            if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
            {
                OPCaseSheet.Visible = true;
            }
            else
            {
                ancCaseSheet.Visible = true;
            }
            //OPCaseSheet.Visible = true;
        }
        else
        {
            OPCaseSheet.Visible = false;
            ancCaseSheet.Visible = false;
        }
        string RedirectPage = GetConfigValue("BillPrintControl", orgID);
        if (chkBillPrint.Checked)
        {
            //if (RedirectPage != string.Empty)
            //{
            //    rakshithbillPrint.Visible = true;
            //    BillPrint.Visible = false;
            //}
            //else
            //{
            //    BillPrint.Visible = true;
            //    rakshithbillPrint.Visible = false;
            //}

            if (RedirectPage == "RakshithBillPrint.ascx")
            {
             
                rakshithbillPrint.Visible = true;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                medfortBillPrint.Visible = false;
                JulianBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
            }
            else if (RedirectPage == "EsBillPrint.ascx")
            {
              
                rakshithbillPrint.Visible = false;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = true;
                medfortBillPrint.Visible = false ;
                JulianBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
            }
            else if (RedirectPage == "Medfort_BillPrint.ascx")
            {
                medfortBillPrint.Visible = true;
                rakshithbillPrint.Visible = false;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                JulianBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
            }
            else if (RedirectPage == "JulianBillPrint.ascx")
            {
                
                JulianBillPrint.Visible = true;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                NMCMeerutBill.Visible = false;
            }
            else if (RedirectPage == "NMC-MeerutBill.ascx")
            {
             
                NMCMeerutBill.Visible = true;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;

            }
            else if (RedirectPage == "AdvanceBillPrint.ascx" && isneedinv!="Y")
            {

                advBillPrint.Visible = true;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                BillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else if (RedirectPage == "Genes2meBillPrint.ascx" )
            {

                advBillPrint.Visible = false;
                IGeneticBillPrint.Visible = false;
                Infexnbillprint.Visible = false;
                Anjanabillprint.Visible = false;
                QuantumBillPrint.Visible = false;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = true;

            }
            else if (RedirectPage == "IGeneticBillPrint.ascx")
            {
                advBillPrint.Visible = false;
                IGeneticBillPrint.Visible = true;
                Infexnbillprint.Visible = false;
                Anjanabillprint.Visible = false;
                QuantumBillPrint.Visible = false;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else if (RedirectPage == "QuatumBillPrint.ascx" && isneedinv != "Y")
            {
                QuantumBillPrint.Visible = true;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else if (RedirectPage == "Anjanabillprint.ascx" && isneedinv!="Y")
            {
                Anjanabillprint.Visible = true;
                QuantumBillPrint.Visible = false;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else if (RedirectPage == "IGeneticBillPrint.ascx")
            {
                IGeneticBillPrint.Visible = true;
                Infexnbillprint.Visible = false;
                Anjanabillprint.Visible = false;
                QuantumBillPrint.Visible = false;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else if (RedirectPage == "Infexnbillprint.ascx")
            {
                // IGeneticBillPrint.Visible = true;
                IGeneticBillPrint.Visible = false;
                Infexnbillprint.Visible = true;
                Anjanabillprint.Visible = false;
                QuantumBillPrint.Visible = false;
                advBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
                JulianBillPrint.Visible = false;
                medfortBillPrint.Visible = false;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                BillPrint.Visible = false;
                SRSBillPrint.Visible = false;
                Genes2meBillPrint.Visible = false;

            }
            else
            {
                if (isneedinv == "Y")
                {
                    BillPrint.Visible = false;
                }
                else
                    BillPrint.Visible = true;
                rakshithbillPrint.Visible = false;
                EsBillPrint1.Visible = false;
                medfortBillPrint.Visible = false;
                JulianBillPrint.Visible = false;
                NMCMeerutBill.Visible = false;
            }
        }
        else
        {
            BillPrint.Visible = false;
            rakshithbillPrint.Visible = false;
           // medfortBillPrint.Visible = false;

        }
        if (chkPrintPrescription.Checked)
        {
            PrintPrescription.Visible = true;
        }
        else
        {
            PrintPrescription.Visible = false;
        }
        if (chkTreatment.Checked)
        {
            Treatment.Visible = true;
        }
        else
        {
            Treatment.Visible = false;
        }
        if (chkReceipt.Checked)
        {
            Receipt.Visible = true;
        }
        else
        {
            Receipt.Visible = false;
        }
        if (chkonFlowDialysis.Checked)
        {
            onFlowDialysis.Visible = true;
        }
        else
        {
            onFlowDialysis.Visible = false;
        }
        if (chkDialysisCaseSheet.Checked)
        {
            DialysisCaseSheet.Visible = true;
        }
        else
        {
            DialysisCaseSheet.Visible = false;
        }

        if (chkSecPage.Checked)
        {
            ucSecPPage.Visible = true;
        }
        else
        {
            ucSecPPage.Visible = false;
        }
        if(chkHealthPKG.Checked==true)
        {             
            PrintHistory1.Visible = true;
            PrintExam1.Visible = true;
            grdResult.Visible = true;           
                      
        }
        else
        {
            PrintHistory1.Visible = false;
            PrintExam1.Visible = false;
            grdResult.Visible = false;
            
        }


        if (iCheckedCount > 1)
        {
            if (chkBillPrint.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkSecPage.Checked == true))
           
            {
                divSecPage.Visible = true;
            }
            else
            {
                divSecPage.Visible = false;
            }
            if (chkCaseSheet.Checked == true && iCheckedCount > 1 && chkPrintPrescription.Checked == true)
            {
                divOPCaseSheet.Visible = true;
            }
            else
            {
                divOPCaseSheet.Visible = false;
            }
            //divBillPrint.Visible = ((chkBillPrint.Checked == true && iCheckedCount > 1) ? true : false);
            if (chkBillPrint.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkSecPage.Checked == true))
            {
                divBillPrint.Visible = true;
            }
            else
            {
                divBillPrint.Visible = false;
            }
            //divTreatment.Visible = ((chkTreatment.Checked == true && iCheckedCount > 1) ? true : false);
            if (chkTreatment.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkBillPrint.Checked == true))
            {
                divTreatment.Visible = true;
            }
            else
            {
                divTreatment.Visible = false;
            }
            //divReceipt.Visible = ((chkReceipt.Checked == true && iCheckedCount > 1) ? true : false);
            if (chkReceipt.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkBillPrint.Checked == true || chkTreatment.Checked == true))
            {
                divReceipt.Visible = true;
            }
            else
            {
                divReceipt.Visible = false;
            }
            //divonFlowDialysis.Visible = ((chkonFlowDialysis.Checked == true && iCheckedCount > 1) ? true : false);
            if (chkonFlowDialysis.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkBillPrint.Checked == true || chkTreatment.Checked == true || chkReceipt.Checked == true))
            {
                divonFlowDialysis.Visible = true;
            }
            else
            {
                divonFlowDialysis.Visible = false;
            }
            //divDialysisCaseSheet.Visible = ((chkDialysisCaseSheet.Checked == true && iCheckedCount > 1) ? true : false);
            if (chkDialysisCaseSheet.Checked == true && iCheckedCount > 1
                && (chkCaseSheet.Checked == true || chkPrintPrescription.Checked == true || chkBillPrint.Checked == true || chkTreatment.Checked == true || chkReceipt.Checked == true || chkonFlowDialysis.Checked == true))
            {
                divDialysisCaseSheet.Visible = true;
            }
            else
            {
                divDialysisCaseSheet.Visible = false;
            }

              if (chkHealthPKG.Checked == true && iCheckedCount > 1
                && (chkBillPrint.Checked == true || chkCaseSheet.Checked == true))
            {
                divDialysisCaseSheet.Visible = true;
            }
            else
            {
                divDialysisCaseSheet.Visible = false;
            }
            
        }
        else
        {
            divOPCaseSheet.Visible = false;
            divBillPrint.Visible = false;
            divSecPage.Visible = false;
            divTreatment.Visible = false;
            divReceipt.Visible = false;
            divonFlowDialysis.Visible = false;
            divDialysisCaseSheet.Visible = false;
            divHealthPKG.Visible = false;
        }


        maintable.Style.Remove("display");
        maintable.Style.Add("display", "block");
        divPrintDetails.Style.Add("display", "none");

        if (Request.QueryString["quickbill"] == null || Request.QueryString["quickbill"] != "Y")
        {
            this.Page.RegisterStartupScript("scrpt", "<script language='javascript' type='text/javascript'> window.print();</script>");

        }
    }

    public void GetHealthPKGData()
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        PrintHistory1.LoadHistoryData(visitID);
        PrintExam1.LoadExamData(visitID);
        List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
        List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
        List<Patient> patientList = new List<Patient>();
        try
        {
            new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(orgID, visitID, patientID,
                out  rTemplate, out lstschedules, out patientList);
            grdResult.DataSource = rTemplate;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
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