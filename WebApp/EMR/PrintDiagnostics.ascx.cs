using System;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Podium.SmartAccessor;
using System.Linq;

public partial class EMR_PrintDiagnostics : BaseControl
{
    string ECG, MPS, MVS, CoronaryAngiogram, Myocardium, SRECGChanges, AssociatedSymptoms, TMTUnitsresult,TMT;
    string strDia = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void LoadDiagnostics(long pVisitID)
    {
        long returnCode = -1;
        List<PatientDiagnosticsAttribute> lstPDA = new List<PatientDiagnosticsAttribute>();
        List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
        returnCode = new SmartAccessor(base.ContextInfo).GetPatientDiagnosticsPackage(pVisitID, OrgID, out lstDiagonistics, out lstPDA);
        hdnEcho.Value = "";
        if (lstPDA.Count > 0)
        {
            for (int i = 0; i < lstPDA.Count(); i++)
            {
                #region ECG

                if (lstPDA[i].DiagnosticsID == 2)
                {
                    lblECGNill.Visible = false;
                    trECGNill.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 1)
                    {
                        
                        if (lstPDA[i].AttributeValueName == "NSR,WNL")
                        {
                            ECG = lstPDA[i].AttributeValueName;
                        }
                    }

                    if (lstPDA[i].AttributeID == 2)
                    {                        
                        ECG = lstPDA[i].AttributeValueName;
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");
                }

                #endregion

                #region Echocardiogram

                if (lstPDA[i].DiagnosticsID == 3)
                {
                    lblECNil.Visible = false;
                    trEchocard.Attributes.Add("Style", "display:block");
                    hdnEcho.Value = lstPDA[i].DiagnosticsID.ToString();
                    if (lstPDA[i].AttributeID == 3)
                    {
                        Myocardium = lstPDA[i].AttributeValueName;                        
                    }

                    if (lstPDA[i].AttributeID == 6)
                    {
                        Myocardium = Myocardium +",  Ejection Fraction:  " + lstPDA[i].AttributeValueName;
                    }

                    if (lstPDA[i].AttributeID == 4)
                    {
                        lblRwma_51.Visible = true;
                        lblRwma_51.Text = lstPDA[i].AttributeValueName + " present";
                    }

                    if (lstPDA[i].AttributeID == 5)
                    {
                        lblValveAbnormality_5.Visible = true;
                        lblValveAbnormality_5.Text = lstPDA[i].AttributeValueName;
                    }

                    if (lstPDA[i].AttributeID == 7)
                    {
                        lblOtherLesions_7.Visible = true;
                        lblOtherLesions_7.Text = lstPDA[i].AttributeValueName+" effusion present";
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");

                }


                #endregion

                #region Treadmill Test


                if (lstPDA[i].DiagnosticsID == 4)
                {
                    lblTTNil.Visible = false;
                    trTreadmill.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 8)
                    {
                       
                        TMT = lstPDA[i].AttributeValueName;
                    }              


                    if (lstPDA[i].AttributeID == 9)
                    {


                        if (SRECGChanges == null)
                        {
                            SRECGChanges = lstPDA[i].AttributeValueName;
                        }
                        else
                        {
                            SRECGChanges += "," + lstPDA[i].AttributeValueName;
                        }
                       

                    }

                    if (lstPDA[i].AttributeID == 10)
                    {

                        if (AssociatedSymptoms == null)
                        {
                            AssociatedSymptoms = lstPDA[i].AttributeValueName;
                        }
                        else
                        {
                            AssociatedSymptoms += "," + lstPDA[i].AttributeValueName;
                        }                       

                    }


                     if (lstPDA[i].AttributeID == 11)
                    {

                        if (TMTUnitsresult == null)
                        {
                            TMTUnitsresult = "MPHR - " + lstPDA[i].AttributeValueName;
                        }
                        else
                        {
                            TMTUnitsresult += "," + "MPHR - " + lstPDA[i].AttributeValueName;
                        }                       

                    }


                     if (lstPDA[i].AttributeID == 12)
                     {

                         if (TMTUnitsresult == null)
                         {
                             TMTUnitsresult = "MAHR - " + lstPDA[i].AttributeValueName;
                         }
                         else
                         {
                             TMTUnitsresult += "," + "MAHR - " + lstPDA[i].AttributeValueName;
                         }

                     }


                     if (lstPDA[i].AttributeID == 13)
                     {

                         if (TMTUnitsresult == null)
                         {
                             TMTUnitsresult = "Work load - " + lstPDA[i].AttributeValueName;
                             TMT += " at " + lstPDA[i].AttributeValueName;
                         }
                         else
                         {
                             TMTUnitsresult += "," + "Work load - " + lstPDA[i].AttributeValueName;
                             TMT += " at " + lstPDA[i].AttributeValueName;
                         }

                     }

                     tblDia.Attributes.Add("Style", "display:block");
                     tblDia1.Attributes.Add("Style", "display:block");
                  
                }


                #endregion

                #region Myocardial Perfusion Study

                if (lstPDA[i].DiagnosticsID == 5)
                {
                    lblMPSNil_5.Visible = false;
                    trMPS.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 14)
                    {

                        MPS = lstPDA[i].AttributeValueName;
                        
                    }

                    if (lstPDA[i].AttributeID == 15)
                    {
                        MPS = MPS + ": " + lstPDA[i].AttributeValueName;
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");
                }

                #endregion

                #region Myocardial Viability Study

                if (lstPDA[i].DiagnosticsID == 6)
                {
                    lblMVSNil_6.Visible = false;
                    trMVS.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 16)
                    {

                        MVS = lstPDA[i].AttributeValueName;

                    }

                    if (lstPDA[i].AttributeID == 17)
                    {
                        MVS = MVS + ": " + lstPDA[i].AttributeValueName;
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");
                }

                #endregion

                #region Coronary Angiogram

                if (lstPDA[i].DiagnosticsID == 7)
                {
                    lblCoronaryAngiogramNil_7.Visible = false;
                    trCoronary.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 18)
                    {

                        if (lstPDA[i].AttributeValueName == "Normal epicardial Coronaries")
                        {
                            CoronaryAngiogram = lstPDA[i].AttributeValueName;
                        }
                        else
                        {
                            CoronaryAngiogram = lstPDA[i].AttributeValueName;
                        }
                    }

                    if (lstPDA[i].AttributeID == 19)
                    {
                        CoronaryAngiogram = CoronaryAngiogram + ": " + lstPDA[i].AttributeValueName;
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");
                }

                #endregion

                #region Other Diagnostics
                if (lstPDA[i].DiagnosticsID == 8)
                {
                    lblOtherDiagnosticsNil_8.Visible = false;
                    trOtherDia.Attributes.Add("Style", "display:block");
                    if (lstPDA[i].AttributeID == 20)
                    {
                        lblOtherDiagnosticsResult_8.Visible = true;
                        lblOtherDiagnosticsResult_8.Text = lstPDA[i].AttributeValueName;
                    }
                    tblDia.Attributes.Add("Style", "display:block");
                    tblDia1.Attributes.Add("Style", "display:block");
                }
                #endregion              
            }

            #region ECG

            if (ECG != null)
            {
                lblECGResult_2.Visible = true;
                lblECGResult_2.Text = ECG;
            }

            #endregion

            #region Echocardiogram 

            #region Myocardium
            if (Myocardium != null)
            {
                lblMyocardiumAndEF_3.Visible = true;
                lblMyocardiumAndEF_3.Text = Myocardium;
            }
            #endregion

            #region RWMA
            if (hdnEcho.Value != "" && lblRwma_51.Text=="")
            {
                lblRwma_51.Visible = true;
                lblRwma_51.Text = "No RWMA";
            }
            #endregion

            #endregion

            #region Treadmill Test  Results
            if (SRECGChanges == null)
            {
                lblSRECG_9.Visible = true;
                lblSRECG_9.Text = "No stress-related ECG changes";
            }
            else
            {
                lblSRECG_9.Visible = true;
                lblSRECG_9.Text = SRECGChanges + " during stress noted";
            }
            if (AssociatedSymptoms == null)
            {
                lblAssociatedSymptoms_10.Visible = true;
                lblAssociatedSymptoms_10.Text = "Asymptomatc during the test";
            }
            else
            {
                lblAssociatedSymptoms_10.Visible = true;
                lblAssociatedSymptoms_10.Text = AssociatedSymptoms + " on excertion noted";
            }
            if (TMTUnitsresult != null)
            {
                lblMPHR_11.Visible = true;
                lblMPHR_11.Text = TMTUnitsresult;
            }
            if (TMT != null)
            {
                lblTreadmillTestResult_8.Visible = true;
                lblTreadmillTestResult_8.Text = TMT;
            }      
            #endregion

            #region Myocardial Perfusion Study

            if (MPS != null)
            {
                lblMPSResult_5.Visible = true;
                lblMPSResult_5.Text = MPS;
            }

            #endregion

            #region Myocardial Viability Study
            if (MVS != null)
            {
                lblMVSresult_6.Visible = true;
                lblMVSresult_6.Text = MVS;
            }
            #endregion

            #region CoronaryAngiogram
            if (CoronaryAngiogram != null)
            {
                lblCoronaryAngiogramResult_7.Visible = true;
                lblCoronaryAngiogramResult_7.Text = CoronaryAngiogram;
            }
            #endregion          

        }
    }
}
