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
using Attune.Podium.EMR;

public partial class EMR_Diagnostics : BaseControl
{
    string IsParentAttID = string.Empty;
    long returnCode = -1;
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlType_1;
        EMR2.DDL = ddlAbnormalities_2;
        EMR3.DDL = ddlMyocardium_3;
        EMR4.DDL = ddlValveAbnormality_5;
        EMR5.DDL = ddlTreadmillTestResult_8;
        EMR6.DDL = chkSRECG_9;
        EMR7.DDL = chkAssociatedSymptoms_10;
        EMR8.DDL = ddlType_14;
        EMR9.DDL = ddlType_16;
        EMR10.DDL = ddlCAR_18;
        EMR11.DDL = ddlCoronaryVessel_19;
        if (IsPostBack)
        {
            if ((chkECG_2.Checked == true))
            {
                tr1chkECG_2.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkECG_2.Attributes.Add("Style", "Display:none");
            }
            if ((chkEchocardiogram_3.Checked == true))
            {
                tr1chkEchocardiogram_3.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkEchocardiogram_3.Attributes.Add("Style", "Display:none");
            }
            if ((chkTreadmillTest_4.Checked == true))
            {
                tr1chkTreadmillTest_4.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkTreadmillTest_4.Attributes.Add("Style", "Display:none");
            }
            if ((chkMPS_5.Checked == true))
            {
                tr1chkMPS_5.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkMPS_5.Attributes.Add("Style", "Display:none");
            }
            if ((chkMVS_6.Checked == true))
            {
                tr1chkMVS_6.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkMVS_6.Attributes.Add("Style", "Display:none");
            }
            if ((chkCoronaryAngiogram_7.Checked == true))
            {
                tr1chkCoronaryAngiogram_7.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkCoronaryAngiogram_7.Attributes.Add("Style", "Display:none");
            }
        }
    }
    #region Bind dropdown
    private void BindCoronaryAngiogramResult()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(18, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlCAR_18.DataSource = lstDiagnosticsAttributeValues;
        ddlCAR_18.DataTextField = "AttributeValueName";
        ddlCAR_18.DataValueField = "AttributevalueID";
        ddlCAR_18.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "CoronaryAngiogram";
        lstEMRvalue.Attributeid = 18;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;
        EMR10.Bind(lstEMRvalue, typelist);

    }

    private void BindMVSType()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(16, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlType_16.DataSource = lstDiagnosticsAttributeValues;
        ddlType_16.DataTextField = "AttributeValueName";
        ddlType_16.DataValueField = "AttributevalueID";
        ddlType_16.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "MVS";
        lstEMRvalue.Attributeid = 16;
        lstEMRvalue.Attributevaluename = "Type";
        EMR9.Bind(lstEMRvalue, typelist);

    }

    private void BindMPSType()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(14, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlType_14.DataSource = lstDiagnosticsAttributeValues;
        ddlType_14.DataTextField = "AttributeValueName";
        ddlType_14.DataValueField = "AttributevalueID";
        ddlType_14.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "MPS";
        lstEMRvalue.Attributeid = 14;
        lstEMRvalue.Attributevaluename = "Type";
        EMR8.Bind(lstEMRvalue, typelist);
    }

    private void BindAssociatedSymptoms()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(10, IsParentAttID, out lstDiagnosticsAttributeValues);
        chkAssociatedSymptoms_10.DataSource = lstDiagnosticsAttributeValues;
        chkAssociatedSymptoms_10.DataTextField = "AttributeValueName";
        chkAssociatedSymptoms_10.DataValueField = "AttributevalueID";
        chkAssociatedSymptoms_10.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Symptoms";
        lstEMRvalue.Attributeid = 10;
        lstEMRvalue.Attributevaluename = "Type";
        EMR7.Bind(lstEMRvalue, typelist);
    }

    private void BindStressRelatedECGChanges()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(9, IsParentAttID, out lstDiagnosticsAttributeValues);
        chkSRECG_9.DataSource = lstDiagnosticsAttributeValues;
        chkSRECG_9.DataTextField = "AttributeValueName";
        chkSRECG_9.DataValueField = "AttributevalueID";
        chkSRECG_9.DataBind();

        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Stress";
        lstEMRvalue.Attributeid = 9;
        lstEMRvalue.Attributevaluename = "Related ECG";
        EMR6.Bind(lstEMRvalue, typelist);
    }

    private void BindTreadmillTestResult()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(8, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlTreadmillTestResult_8.DataSource = lstDiagnosticsAttributeValues;
        ddlTreadmillTestResult_8.DataTextField = "AttributeValueName";
        ddlTreadmillTestResult_8.DataValueField = "AttributevalueID";
        ddlTreadmillTestResult_8.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Treadmill";
        lstEMRvalue.Attributeid = 8;
        lstEMRvalue.Attributevaluename = "Test Result";
        EMR5.Bind(lstEMRvalue, typelist);
    }

    private void BindValveAbnormality()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(5, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlValveAbnormality_5.DataSource = lstDiagnosticsAttributeValues;
        ddlValveAbnormality_5.DataTextField = "AttributeValueName";
        ddlValveAbnormality_5.DataValueField = "AttributevalueID";
        ddlValveAbnormality_5.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "MPS";
        lstEMRvalue.Attributeid = 5;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR4.Bind(lstEMRvalue, typelist);

    }

    private void BindMyocardium()
    {
        IsParentAttID = "NO";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(3, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlMyocardium_3.DataSource = lstDiagnosticsAttributeValues;
        ddlMyocardium_3.DataTextField = "AttributeValueName";
        ddlMyocardium_3.DataValueField = "AttributevalueID";
        ddlMyocardium_3.DataBind();
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Echocardiogram";
        lstEMRvalue.Attributeid = 3;
        lstEMRvalue.Attributevaluename = "Myocardium";
        EMR3.Bind(lstEMRvalue, typelist);

        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValue = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(1, IsParentAttID, out lstDiagnosticsAttributeValue);
        ddlType_1.DataSource = lstDiagnosticsAttributeValue;
        ddlType_1.DataTextField = "AttributeValueName";
        ddlType_1.DataValueField = "AttributevalueID";
        ddlType_1.DataBind();
        //trAbnormalities_2.Style.Add("display", "block");
        List<EMRAttributeClass> list = (from s in lstDiagnosticsAttributeValue
                                        select new EMRAttributeClass
                                        {
                                            AttributeName = s.AttributeName,
                                            AttributevalueID = s.AttributevalueID,
                                            AttributeValueName = s.AttributeValueName

                                        }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 1;
        lstEMRvalue.Attributevaluename = "Type";
        EMR1.Bind(lstEMRvalue, list);
    }

    private void BindECGAbnormalities()
    {
        IsParentAttID = "YES";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(1, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlAbnormalities_2.DataSource = lstDiagnosticsAttributeValues;
        ddlAbnormalities_2.DataTextField = "AttributeValueName";
        ddlAbnormalities_2.DataValueField = "AttributevalueID";
        ddlAbnormalities_2.DataBind();
        trAbnormalities_2.Style.Add("display", "block");
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 2;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR2.Bind(lstEMRvalue, typelist);
    }

    private void BindCAGbnormalities()
    {
        IsParentAttID = "YES";
        List<DiagnosticsAttributeValues> lstDiagnosticsAttributeValues = new List<DiagnosticsAttributeValues>();
        returnCode = new SmartAccessor(base.ContextInfo).GetDiagnosticsAttributeValues(18, IsParentAttID, out lstDiagnosticsAttributeValues);
        ddlCoronaryVessel_19.DataSource = lstDiagnosticsAttributeValues;
        ddlCoronaryVessel_19.DataTextField = "AttributeValueName";
        ddlCoronaryVessel_19.DataValueField = "AttributevalueID";
        ddlCoronaryVessel_19.DataBind();
        trCAR_18.Style.Add("display", "block");
        List<EMRAttributeClass> typelist = (from s in lstDiagnosticsAttributeValues
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Coronary Angiogram";
        lstEMRvalue.Attributeid = 19;
        lstEMRvalue.Attributevaluename = "Coronary Vessel";
        EMR11.Bind(lstEMRvalue, typelist);
    }
    protected void ddlType_1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_1.SelectedItem.Text == "Abnormal")
        {
            BindECGAbnormalities();
            tdAbnormalities_2.Style.Add("display", "block");

        }
        else
        {
            trAbnormalities_2.Style.Add("display", "none");
            tdAbnormalities_2.Style.Add("display", "none");

        }
    }
    protected void ddlCAR_18_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCAR_18.SelectedItem.Text != "Normal epicardial Coronaries")
        {
            BindCAGbnormalities();
            tdCAR_18.Style.Add("display", "block");
        }
        else
        {
            trCAR_18.Style.Add("display", "none");
            tdCAR_18.Style.Add("display", "none");
        }
    }
    protected void ddlCoronaryVessel_19_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCoronaryVessel_19.SelectedItem.Text == "Others")
        {
            divddlCoronaryVessel_19.Style.Add("display", "block");
        }
        else
        {
            divddlCoronaryVessel_19.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_2.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_2.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_2.Style.Add("display", "none");
        }
    }

    #endregion

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();
        #region EGC
        if (chkECG_2.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 2;
            objPatientDiagnostics.DiagnosticsName = chkECG_2.Text;
            attribute.Add(objPatientDiagnostics);
            #region lblType_1
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 2;
                objPatientDiagnosticsAttribute.AttributeID = 1;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlType_1.SelectedValue);
                objPatientDiagnosticsAttribute.AttributeValueName = ddlType_1.SelectedItem.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion

            #region lblAbnormalities_68
            if (ddlType_1.SelectedItem.Text == "Abnormal" && ddlAbnormalities_2.SelectedItem.Text != "Others")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 2;
                objPatientDiagnosticsAttribute.AttributeID = 2;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_2.SelectedValue);
                objPatientDiagnosticsAttribute.AttributeValueName = ddlAbnormalities_2.SelectedItem.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            else
            {
                if (ddlType_1.SelectedItem.Text == "Abnormal" && ddlAbnormalities_2.SelectedItem.Text == "Others")
                {
                    PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                    objPatientDiagnosticsAttribute.DiagnosticsID = 2;
                    objPatientDiagnosticsAttribute.AttributeID = 2;
                    objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_2.SelectedValue);
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_33.Text;
                    attrValue.Add(objPatientDiagnosticsAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Echocardiogram


        if (chkEchocardiogram_3.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 3;
            objPatientDiagnostics.DiagnosticsName = chkEchocardiogram_3.Text;
            attribute.Add(objPatientDiagnostics);

            #region lblMyocardium_3
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 3;
                objPatientDiagnosticsAttribute.AttributeID = 3;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlMyocardium_3.SelectedValue);
                if (ddlMyocardium_3.SelectedItem.Text != "Others")
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = ddlMyocardium_3.SelectedItem.Text;
                }
                else
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_50.Text;
                }
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion


            #region RWMA

            if (chkRwma_51.Checked == true)
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 3;
                objPatientDiagnosticsAttribute.AttributeID = 4;
                objPatientDiagnosticsAttribute.AttributevalueID = 51;
                objPatientDiagnosticsAttribute.AttributeValueName = chkRwma_51.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion

            #region Valve Abnormality

            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 3;
                objPatientDiagnosticsAttribute.AttributeID = 5;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlValveAbnormality_5.SelectedValue);
                if (ddlValveAbnormality_5.SelectedItem.Text != "Others")
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = ddlValveAbnormality_5.SelectedItem.Text;
                }
                else
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_84.Text;
                }
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion


            #region  Ejection Fraction

            if (txtEjectionFraction_85.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 3;
                objPatientDiagnosticsAttribute.AttributeID = 6;
                objPatientDiagnosticsAttribute.AttributevalueID = 85;
                objPatientDiagnosticsAttribute.AttributeValueName = txtEjectionFraction_85.Text + " " + lblUom_85.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion

            #region  Other Lesions

            if (txtOtherLesions_86.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 3;
                objPatientDiagnosticsAttribute.AttributeID = 7;
                objPatientDiagnosticsAttribute.AttributevalueID = 86;
                objPatientDiagnosticsAttribute.AttributeValueName = txtOtherLesions_86.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion



        }
        #endregion

        #region Treadmill Test

        if (chkTreadmillTest_4.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 4;
            objPatientDiagnostics.DiagnosticsName = chkTreadmillTest_4.Text;
            attribute.Add(objPatientDiagnostics);

            #region lblTreadmillTestResult_8
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                objPatientDiagnosticsAttribute.AttributeID = 8;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlTreadmillTestResult_8.SelectedValue);
                objPatientDiagnosticsAttribute.AttributeValueName = ddlTreadmillTestResult_8.SelectedItem.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion

            #region lblSRECG_9(Stress Related ECG Changes)
            foreach (ListItem li in chkSRECG_9.Items)//Treatment
            {
                if (li.Selected)
                {
                    if (li.Text != "Others")
                    {
                        PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                        objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                        objPatientDiagnosticsAttribute.AttributeID = 9;
                        objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                        objPatientDiagnosticsAttribute.AttributeValueName = li.Text;
                        attrValue.Add(objPatientDiagnosticsAttribute);
                    }
                    else
                    {
                        PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                        objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                        objPatientDiagnosticsAttribute.AttributeID = 9;
                        objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                        objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_108.Text;
                        attrValue.Add(objPatientDiagnosticsAttribute);
                    }
                }
            }
            #endregion

            #region lblAssociatedSymptoms_10

            foreach (ListItem li in chkAssociatedSymptoms_10.Items)//Treatment
            {
                if (li.Selected)
                {
                    if (li.Text != "Others")
                    {
                        PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                        objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                        objPatientDiagnosticsAttribute.AttributeID = 10;
                        objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                        objPatientDiagnosticsAttribute.AttributeValueName = li.Text;
                        attrValue.Add(objPatientDiagnosticsAttribute);
                    }
                    else
                    {
                        PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                        objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                        objPatientDiagnosticsAttribute.AttributeID = 10;
                        objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                        objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_112.Text;
                        attrValue.Add(objPatientDiagnosticsAttribute);
                    }
                }
            }

            #endregion

            #region  lblMPHR_11

            if (txtMPHR_113.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                objPatientDiagnosticsAttribute.AttributeID = 11;
                objPatientDiagnosticsAttribute.AttributevalueID = 113;
                objPatientDiagnosticsAttribute.AttributeValueName = txtMPHR_113.Text + " " + lblUom_113.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion

            #region  lblMAHR_12

            if (txtMAHR_114.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                objPatientDiagnosticsAttribute.AttributeID = 12;
                objPatientDiagnosticsAttribute.AttributevalueID = 114;
                objPatientDiagnosticsAttribute.AttributeValueName = txtMAHR_114.Text + " " + lblUom_114.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion

            #region  lblWorkLoad_13

            if (txtWorkLoad_115.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 4;
                objPatientDiagnosticsAttribute.AttributeID = 13;
                objPatientDiagnosticsAttribute.AttributevalueID = 115;
                objPatientDiagnosticsAttribute.AttributeValueName = txtWorkLoad_115.Text + " " + lblUom_115.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }

            #endregion

        }
        #endregion

        #region Myocardial Perfusion Study

        if (chkMPS_5.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 5;
            objPatientDiagnostics.DiagnosticsName = chkMPS_5.Text;
            attribute.Add(objPatientDiagnostics);
            #region lblType_14
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 5;
                objPatientDiagnosticsAttribute.AttributeID = 14;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlType_14.SelectedValue);
                if (ddlType_14.SelectedItem.Text != "Others")
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = ddlType_14.SelectedItem.Text;
                }
                else
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_124.Text;
                }
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion

            #region lblDescription_15
            if (txtDescription_125.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 5;
                objPatientDiagnosticsAttribute.AttributeID = 15;
                objPatientDiagnosticsAttribute.AttributevalueID = 125;
                objPatientDiagnosticsAttribute.AttributeValueName = txtDescription_125.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion
        }

        #endregion

        #region Myocardial Viability Study

        if (chkMVS_6.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 6;
            objPatientDiagnostics.DiagnosticsName = chkMVS_6.Text;
            attribute.Add(objPatientDiagnostics);

            #region lblType_16
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 6;
                objPatientDiagnosticsAttribute.AttributeID = 16;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlType_16.SelectedValue);
                if (ddlType_16.SelectedItem.Text != "Others")
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = ddlType_16.SelectedItem.Text;
                }
                else
                {
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_134.Text;
                }
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion

            #region lblDescription_17
            if (txtDescription_135.Text != "")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 6;
                objPatientDiagnosticsAttribute.AttributeID = 17;
                objPatientDiagnosticsAttribute.AttributevalueID = 135;
                objPatientDiagnosticsAttribute.AttributeValueName = txtDescription_135.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion
        }

        #endregion

        #region Coronary Angiogram
        if (chkCoronaryAngiogram_7.Checked == true)
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 7;
            objPatientDiagnostics.DiagnosticsName = chkCoronaryAngiogram_7.Text;
            attribute.Add(objPatientDiagnostics);

            #region lblCAR_18
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 7;
                objPatientDiagnosticsAttribute.AttributeID = 18;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlCAR_18.SelectedValue);
                objPatientDiagnosticsAttribute.AttributeValueName = ddlCAR_18.SelectedItem.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            #endregion


            #region lblCoronaryVessel_19
            if (ddlCAR_18.SelectedItem.Text != "Normal epicardial Coronaries" && ddlCoronaryVessel_19.SelectedItem.Text != "Others")
            {
                PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                objPatientDiagnosticsAttribute.DiagnosticsID = 7;
                objPatientDiagnosticsAttribute.AttributeID = 19;
                objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlCoronaryVessel_19.SelectedValue);
                objPatientDiagnosticsAttribute.AttributeValueName = ddlCoronaryVessel_19.SelectedItem.Text;
                attrValue.Add(objPatientDiagnosticsAttribute);
            }
            else
            {
                if (ddlCAR_18.SelectedItem.Text != "Normal epicardial Coronaries" && ddlCoronaryVessel_19.SelectedItem.Text == "Others")
                {
                    PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
                    objPatientDiagnosticsAttribute.DiagnosticsID = 7;
                    objPatientDiagnosticsAttribute.AttributeID = 19;
                    objPatientDiagnosticsAttribute.AttributevalueID = Convert.ToInt64(ddlCoronaryVessel_19.SelectedValue);
                    objPatientDiagnosticsAttribute.AttributeValueName = txtOthers_162.Text;
                    attrValue.Add(objPatientDiagnosticsAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Other Diagnostics

        if (chkOtherDiagnostics_8.Checked == true && txtOtherDiagnostics_163.Text != "")
        {
            PatientDiagnostics objPatientDiagnostics = new PatientDiagnostics();
            objPatientDiagnostics.DiagnosticsID = 8;
            objPatientDiagnostics.DiagnosticsName = chkOtherDiagnostics_8.Text;
            attribute.Add(objPatientDiagnostics);

            PatientDiagnosticsAttribute objPatientDiagnosticsAttribute = new PatientDiagnosticsAttribute();
            objPatientDiagnosticsAttribute.DiagnosticsID = 8;
            objPatientDiagnosticsAttribute.AttributeID = 20;
            objPatientDiagnosticsAttribute.AttributevalueID = 163;
            objPatientDiagnosticsAttribute.AttributeValueName = txtOtherDiagnostics_163.Text;
            attrValue.Add(objPatientDiagnosticsAttribute);


        }

        #endregion

        return returnval;



    }

    public void EditData(List<PatientDiagnosticsAttribute> lstPDA)
    {
        #region ECG
        var listECG = from Res in lstPDA
                      where Res.DiagnosticsID == 2
                      select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listECG)
        {

            if (objPDA.DiagnosticsID == 2)
            {
                chkECG_2.Checked = true;
                tr1chkECG_2.Style.Add("display", "block");
                ddlType_1.SelectedValue = objPDA.AttributevalueID.ToString();

                if (objPDA.AttributeID == 2)
                {
                    BindECGAbnormalities();
                    ddlAbnormalities_2.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlAbnormalities_2.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_2.Style.Add("display", "block");
                        txtOthers_33.Text = objPDA.AttributeValueName;
                    }
                }

            }
        }
        #endregion

        #region Echocardiogram

        var listEchocardiogram = from Res in lstPDA
                                 where Res.DiagnosticsID == 3
                                 select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listEchocardiogram)
        {

            if (objPDA.DiagnosticsID == 3)
            {
                chkEchocardiogram_3.Checked = true;
                tr1chkEchocardiogram_3.Style.Add("display", "block");

                #region Myocardium
                if (objPDA.AttributeID == 3)
                {

                    ddlMyocardium_3.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlMyocardium_3.SelectedItem.Text == "Others")
                    {
                        divddlMyocardium_3.Style.Add("display", "block");
                        txtOthers_50.Text = objPDA.AttributeValueName;
                    }
                }
                #endregion

                #region RWMA
                if (objPDA.AttributeID == 4)
                {
                    chkRwma_51.Checked = true;
                }
                #endregion

                #region Valve Abnormality
                if (objPDA.AttributeID == 5)
                {

                    ddlValveAbnormality_5.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlValveAbnormality_5.SelectedItem.Text == "Others")
                    {
                        divddlValveAbnormality_5.Style.Add("display", "block");
                        txtOthers_84.Text = objPDA.AttributeValueName;
                    }
                }
                #endregion

                #region Ejection Fraction
                if (objPDA.AttributeID == 6)
                {
                    string[] EF = objPDA.AttributeValueName.Split(' ');
                    txtEjectionFraction_85.Text = EF[0];

                }
                #endregion

                #region Other Lesions
                if (objPDA.AttributeID == 7)
                {
                    string[] OL = objPDA.AttributeValueName.Split(' ');
                    txtOtherLesions_86.Text = OL[0];

                }
                #endregion


            }
        }

        #endregion

        #region Treadmill Test

        var listTT = from Res in lstPDA
                     where Res.DiagnosticsID == 4
                     select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listTT)
        {

            if (objPDA.DiagnosticsID == 4)
            {
                chkTreadmillTest_4.Checked = true;
                tr1chkTreadmillTest_4.Style.Add("display", "block");

                #region Treadmill Test Result
                if (objPDA.AttributeID == 8)
                {

                    ddlTreadmillTestResult_8.SelectedValue = objPDA.AttributevalueID.ToString();
                    ddlTreadmillTestResult_8.Text = objPDA.AttributeValueName;

                }
                #endregion

                #region Stress Related ECG Changes
                if (objPDA.AttributeID == 9)
                {


                    var lstSRECG = from Res in lstPDA
                                   where Res.AttributeID == 9
                                   select Res;

                    foreach (ListItem li in chkSRECG_9.Items)
                    {
                        foreach (PatientDiagnosticsAttribute objlstSRECG in lstSRECG)
                        {
                            if (li.Value == objlstSRECG.AttributevalueID.ToString())
                            {
                                li.Selected = true;

                                if (li.Text == "Others")
                                {
                                    divchkSRECG_9.Style.Add("display", "block");
                                    txtOthers_108.Text = objlstSRECG.AttributeValueName;
                                }
                            }


                        }
                    }
                }

                #endregion

                #region Associated Symptoms
                if (objPDA.AttributeID == 10)
                {


                    var lstAS = from Res in lstPDA
                                where Res.AttributeID == 10
                                select Res;

                    foreach (ListItem li in chkAssociatedSymptoms_10.Items)
                    {
                        foreach (PatientDiagnosticsAttribute objlstAS in lstAS)
                        {
                            if (li.Value == objlstAS.AttributevalueID.ToString())
                            {
                                li.Selected = true;

                                if (li.Text == "Others")
                                {
                                    divchkAssociatedSymptoms_10.Style.Add("display", "block");
                                    txtOthers_112.Text = objlstAS.AttributeValueName;
                                }
                            }


                        }
                    }
                }

                #endregion

                #region MPHR
                if (objPDA.AttributeID == 11)
                {
                    string[] EF = objPDA.AttributeValueName.Split(' ');
                    txtMPHR_113.Text = EF[0];

                }
                #endregion

                #region MAHR
                if (objPDA.AttributeID == 12)
                {
                    string[] MAHR = objPDA.AttributeValueName.Split(' ');
                    txtMAHR_114.Text = MAHR[0];

                }
                #endregion

                #region Work Load
                if (objPDA.AttributeID == 13)
                {
                    string[] WL = objPDA.AttributeValueName.Split(' ');
                    txtWorkLoad_115.Text = WL[0];

                }
                #endregion

            }
        }

        #endregion

        #region Myocardial Perfusion Study


        var listMPS = from Res in lstPDA
                      where Res.DiagnosticsID == 5
                      select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listMPS)
        {

            if (objPDA.DiagnosticsID == 5)
            {
                chkMPS_5.Checked = true;
                tr1chkMPS_5.Style.Add("display", "block");
                if (objPDA.AttributeID == 14)
                {

                    ddlType_14.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlType_14.SelectedItem.Text == "Others")
                    {
                        divddlType_14.Style.Add("display", "block");
                        txtOthers_124.Text = objPDA.AttributeValueName;
                    }
                }

                if (objPDA.AttributeID == 15)
                {
                    txtDescription_125.Text = objPDA.AttributeValueName;
                }
            }
        }
        #endregion

        #region Myocardial Viability Study


        var listMVS = from Res in lstPDA
                      where Res.DiagnosticsID == 6
                      select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listMVS)
        {
            if (objPDA.DiagnosticsID == 6)
            {
                chkMVS_6.Checked = true;
                tr1chkMVS_6.Style.Add("display", "block");
                if (objPDA.AttributeID == 16)
                {

                    ddlType_16.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlType_16.SelectedItem.Text == "Others")
                    {
                        divddlType_16.Style.Add("display", "block");
                        txtOthers_134.Text = objPDA.AttributeValueName;
                    }
                }

                if (objPDA.AttributeID == 17)
                {
                    txtDescription_135.Text = objPDA.AttributeValueName;
                }
            }
        }
        #endregion

        #region Coronary Angiogram

        var listCA = from Res in lstPDA
                     where Res.DiagnosticsID == 7
                     select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listCA)
        {

            if (objPDA.DiagnosticsID == 7)
            {
                chkCoronaryAngiogram_7.Checked = true;
                tr1chkCoronaryAngiogram_7.Style.Add("display", "block");
                ddlCAR_18.SelectedValue = objPDA.AttributevalueID.ToString();

                if (objPDA.AttributeID == 19)
                {
                    BindCAGbnormalities();
                    ddlCoronaryVessel_19.SelectedValue = objPDA.AttributevalueID.ToString();
                    if (ddlCoronaryVessel_19.SelectedItem.Text == "Others")
                    {
                        divddlCoronaryVessel_19.Style.Add("display", "block");
                        txtOthers_162.Text = objPDA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        //#region Other Diagnostics

        //var listOD = from Res in lstPDA
        //             where Res.DiagnosticsID == 8
        //             select Res;

        //foreach (PatientDiagnosticsAttribute objPDA in listOD)
        //{

        //    if (objPDA.DiagnosticsID == 8)
        //    {
        //        chkOtherDiagnostics_8.Checked = true;
        //        tr1chkOtherDiagnostics_8.Style.Add("display", "block");
        //        txtOtherDiagnostics_163.Text = objPDA.AttributeValueName;

        //    }
        //}

        //#endregion
    }

    public void SetData(List<PatientDiagnosticsAttribute> lstPDA)
    {
        #region ECG
        var listECG = from Res in lstPDA
                      where Res.DiagnosticsID == 2
                      select Res;

        List<EMRAttributeClass> type = (from s in listECG
                                        where s.AttributeID == 1
                                        select new EMRAttributeClass
                                        {
                                            AttributeName = s.DiagnosticsName,
                                            AttributevalueID = s.AttributevalueID,
                                            AttributeValueName = s.AttributeValueName

                                        }).ToList();
        ddlType_1.DataSource = type;
        ddlType_1.DataTextField = "AttributeValueName";
        ddlType_1.DataValueField = "AttributevalueID";
        ddlType_1.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 1;
        lstEMRvalue.Attributevaluename = "Type";
        EMR1.Bind(lstEMRvalue, type);


        List<EMRAttributeClass> typelist = (from s in listECG
                                            where s.AttributeID == 2
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.DiagnosticsName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();

        ddlAbnormalities_2.DataSource = typelist;
        ddlAbnormalities_2.DataTextField = "AttributeValueName";
        ddlAbnormalities_2.DataValueField = "AttributevalueID";
        ddlAbnormalities_2.DataBind();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 2;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR2.Bind(lstEMRvalue, typelist);

        #endregion

        #region Echocardiogram

        var listEchocardiogram = from Res in lstPDA
                                 where Res.DiagnosticsID == 3
                                 select Res;

        List<EMRAttributeClass> Echotype = (from s in listEchocardiogram
                                            where s.AttributeID == 3
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.DiagnosticsName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        ddlMyocardium_3.DataSource = Echotype;
        ddlMyocardium_3.DataTextField = "AttributeValueName";
        ddlMyocardium_3.DataValueField = "AttributevalueID";
        ddlMyocardium_3.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 3;
        lstEMRvalue.Attributevaluename = "Type";
        EMR3.Bind(lstEMRvalue, Echotype);


        List<EMRAttributeClass> echoabnormal = (from s in listEchocardiogram
                                                where s.AttributeID == 5
                                                select new EMRAttributeClass
                                                {
                                                    AttributeName = s.DiagnosticsName,
                                                    AttributevalueID = s.AttributevalueID,
                                                    AttributeValueName = s.AttributeValueName

                                                }).ToList();

        ddlValveAbnormality_5.DataSource = echoabnormal;
        ddlValveAbnormality_5.DataTextField = "AttributeValueName";
        ddlValveAbnormality_5.DataValueField = "AttributevalueID";
        ddlValveAbnormality_5.DataBind();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 5;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR4.Bind(lstEMRvalue, echoabnormal);

        //foreach (PatientDiagnosticsAttribute objPDA in listEchocardiogram)
        //{

        //    if (objPDA.DiagnosticsID == 3)
        //    {
        //        chkEchocardiogram_3.Checked = true;
        //        tr1chkEchocardiogram_3.Style.Add("display", "block");

        //        #region Myocardium
        //        if (objPDA.AttributeID == 3)
        //        {                    
        //            ddlMyocardium_3.SelectedValue = objPDA.AttributevalueID.ToString();
        //            if (ddlMyocardium_3.SelectedItem.Text == "Others")
        //            {
        //                divddlMyocardium_3.Style.Add("display", "block");
        //                txtOthers_50.Text = objPDA.AttributeValueName;
        //            }
        //        }
        //        #endregion

        //        #region RWMA
        //        if (objPDA.AttributeID == 4)
        //        {
        //            chkRwma_51.Checked = true;
        //        }
        //        #endregion

        //        #region Valve Abnormality
        //        if (objPDA.AttributeID == 5)
        //        {

        //            ddlValveAbnormality_5.SelectedValue = objPDA.AttributevalueID.ToString();
        //            if (ddlValveAbnormality_5.SelectedItem.Text == "Others")
        //            {
        //                divddlValveAbnormality_5.Style.Add("display", "block");
        //                txtOthers_84.Text = objPDA.AttributeValueName;
        //            }
        //        }
        //        #endregion

        //        #region Ejection Fraction
        //        if (objPDA.AttributeID == 6)
        //        {
        //            string[] EF = objPDA.AttributeValueName.Split(' ');
        //            txtEjectionFraction_85.Text = EF[0];

        //        }
        //        #endregion

        //        #region Other Lesions
        //        if (objPDA.AttributeID == 7)
        //        {
        //            string[] OL = objPDA.AttributeValueName.Split(' ');
        //            txtOtherLesions_86.Text = OL[0];

        //        }
        //        #endregion


        //    }
        //}

        #endregion

        #region Treadmill Test

        var listTT = from Res in lstPDA
                     where Res.DiagnosticsID == 4
                     select Res;


        List<EMRAttributeClass> Treadmilltype = (from s in listTT
                                                 where s.AttributeID == 8
                                                 select new EMRAttributeClass
                                                 {
                                                     AttributeName = s.DiagnosticsName,
                                                     AttributevalueID = s.AttributevalueID,
                                                     AttributeValueName = s.AttributeValueName

                                                 }).ToList();
        ddlTreadmillTestResult_8.DataSource = Treadmilltype;
        ddlTreadmillTestResult_8.DataTextField = "AttributeValueName";
        ddlTreadmillTestResult_8.DataValueField = "AttributevalueID";
        ddlTreadmillTestResult_8.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 8;
        lstEMRvalue.Attributevaluename = "Type";
        EMR5.Bind(lstEMRvalue, Treadmilltype);


        List<EMRAttributeClass> Treadmillabnormal = (from s in listTT
                                                     where s.AttributeID == 9
                                                     select new EMRAttributeClass
                                                     {
                                                         AttributeName = s.DiagnosticsName,
                                                         AttributevalueID = s.AttributevalueID,
                                                         AttributeValueName = s.AttributeValueName

                                                     }).ToList();

        chkSRECG_9.DataSource = Treadmillabnormal;
        chkSRECG_9.DataTextField = "AttributeValueName";
        chkSRECG_9.DataValueField = "AttributevalueID";
        chkSRECG_9.DataBind();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 9;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR6.Bind(lstEMRvalue, Treadmillabnormal);

        List<EMRAttributeClass> Treadmillsymptoms = (from s in listTT
                                                     where s.AttributeID == 10
                                                     select new EMRAttributeClass
                                                     {
                                                         AttributeName = s.DiagnosticsName,
                                                         AttributevalueID = s.AttributevalueID,
                                                         AttributeValueName = s.AttributeValueName

                                                     }).ToList();

        chkAssociatedSymptoms_10.DataSource = Treadmillsymptoms;
        chkAssociatedSymptoms_10.DataTextField = "AttributeValueName";
        chkAssociatedSymptoms_10.DataValueField = "AttributevalueID";
        chkAssociatedSymptoms_10.DataBind();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "ECG";
        lstEMRvalue.Attributeid = 10;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR7.Bind(lstEMRvalue, Treadmillsymptoms);

        //foreach (PatientDiagnosticsAttribute objPDA in listTT)
        //{

        //    if (objPDA.DiagnosticsID == 4)
        //    {
        //        chkTreadmillTest_4.Checked = true;
        //        tr1chkTreadmillTest_4.Style.Add("display", "block");

        //        #region Treadmill Test Result
        //        if (objPDA.AttributeID == 8)
        //        {

        //            ddlTreadmillTestResult_8.SelectedValue = objPDA.AttributevalueID.ToString();
        //            ddlTreadmillTestResult_8.Text = objPDA.AttributeValueName;

        //        }
        //        #endregion

        //        #region Stress Related ECG Changes
        //        if (objPDA.AttributeID == 9)
        //        {


        //            var lstSRECG = from Res in lstPDA
        //                        where Res.AttributeID == 9
        //                        select Res;

        //            foreach (ListItem li in chkSRECG_9.Items)
        //            {
        //                foreach (PatientDiagnosticsAttribute objlstSRECG in lstSRECG)
        //                {
        //                    if (li.Value == objlstSRECG.AttributevalueID.ToString()  )
        //                    {
        //                        li.Selected = true;

        //                        if (li.Text == "Others")
        //                        {
        //                            divchkSRECG_9.Style.Add("display", "block");
        //                            txtOthers_108.Text = objlstSRECG.AttributeValueName;
        //                        }
        //                    }


        //                }
        //            }
        //        }

        //        #endregion

        //        #region Associated Symptoms
        //        if (objPDA.AttributeID == 10)
        //        {


        //            var lstAS = from Res in lstPDA
        //                           where Res.AttributeID == 10
        //                           select Res;

        //            foreach (ListItem li in chkAssociatedSymptoms_10.Items)
        //            {
        //                foreach (PatientDiagnosticsAttribute objlstAS in lstAS)
        //                {
        //                    if (li.Value == objlstAS.AttributevalueID.ToString())
        //                    {
        //                        li.Selected = true;

        //                        if (li.Text == "Others")
        //                        {
        //                            divchkAssociatedSymptoms_10.Style.Add("display", "block");
        //                            txtOthers_112.Text = objlstAS.AttributeValueName;
        //                        }
        //                    }


        //                }
        //            }
        //        }

        //        #endregion

        //        #region MPHR
        //        if (objPDA.AttributeID == 11)
        //        {
        //            string[] EF = objPDA.AttributeValueName.Split(' ');
        //            txtMPHR_113.Text = EF[0];

        //        }
        //        #endregion

        //        #region MAHR
        //        if (objPDA.AttributeID == 12)
        //        {
        //            string[] MAHR = objPDA.AttributeValueName.Split(' ');
        //            txtMAHR_114.Text = MAHR[0];

        //        }
        //        #endregion

        //        #region Work Load
        //        if (objPDA.AttributeID == 13)
        //        {
        //            string[] WL = objPDA.AttributeValueName.Split(' ');
        //            txtWorkLoad_115.Text = WL[0];

        //        }
        //        #endregion

        //    }
        //}

        #endregion

        #region Myocardial Perfusion Study


        var listMPS = from Res in lstPDA
                      where Res.DiagnosticsID == 5
                      select Res;

        List<EMRAttributeClass> Myocardial = (from s in listMPS
                                              where s.AttributeID == 14
                                              select new EMRAttributeClass
                                              {
                                                  AttributeName = s.DiagnosticsName,
                                                  AttributevalueID = s.AttributevalueID,
                                                  AttributeValueName = s.AttributeValueName
                                              }).ToList();

        ddlType_14.DataSource = Myocardial;
        ddlType_14.DataTextField = "AttributeValueName";
        ddlType_14.DataValueField = "AttributevalueID";
        ddlType_14.DataBind();
        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Myocardial";
        lstEMRvalue.Attributeid = 10;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR8.Bind(lstEMRvalue, Myocardial);

        //foreach (PatientDiagnosticsAttribute objPDA in listMPS)
        //{

        //    if (objPDA.DiagnosticsID == 5)
        //    {
        //        chkMPS_5.Checked = true;
        //        tr1chkMPS_5.Style.Add("display", "block");
        //        if (objPDA.AttributeID == 14)
        //        {

        //            ddlType_14.SelectedValue = objPDA.AttributevalueID.ToString();
        //            if (ddlType_14.SelectedItem.Text == "Others")
        //            {
        //                divddlType_14.Style.Add("display", "block");
        //                txtOthers_124.Text = objPDA.AttributeValueName;
        //            }
        //        }

        //        if (objPDA.AttributeID == 15)
        //        {
        //            txtDescription_125.Text = objPDA.AttributeValueName;
        //        }
        //    }
        //}
        #endregion

        #region Myocardial Viability Study


        var listMVS = from Res in lstPDA
                      where Res.DiagnosticsID == 6
                      select Res;


        List<EMRAttributeClass> MyocardialViability = (from s in listMVS
                                                       where s.AttributeID == 16
                                                       select new EMRAttributeClass
                                                       {
                                                           AttributeName = s.DiagnosticsName,
                                                           AttributevalueID = s.AttributevalueID,
                                                           AttributeValueName = s.AttributeValueName
                                                       }).ToList();

        ddlType_16.DataSource = MyocardialViability;
        ddlType_16.DataTextField = "AttributeValueName";
        ddlType_16.DataValueField = "AttributevalueID";
        ddlType_16.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Myocardial";
        lstEMRvalue.Attributeid = 16;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR9.Bind(lstEMRvalue, MyocardialViability);

        //foreach (PatientDiagnosticsAttribute objPDA in listMVS)
        //{
        //    if (objPDA.DiagnosticsID == 6)
        //    {
        //        chkMVS_6.Checked = true;
        //        tr1chkMVS_6.Style.Add("display", "block");
        //        if (objPDA.AttributeID == 16)
        //        {

        //            ddlType_16.SelectedValue = objPDA.AttributevalueID.ToString();
        //            if (ddlType_16.SelectedItem.Text == "Others")
        //            {
        //                divddlType_16.Style.Add("display", "block");
        //                txtOthers_134.Text = objPDA.AttributeValueName;
        //            }
        //        }

        //        if (objPDA.AttributeID == 17)
        //        {
        //            txtDescription_135.Text = objPDA.AttributeValueName;
        //        }
        //    }
        //}
        #endregion

        #region Coronary Angiogram

        var listCA = from Res in lstPDA
                     where Res.DiagnosticsID == 7
                     select Res;


        List<EMRAttributeClass> Coronary = (from s in listCA
                                            where s.AttributeID == 18
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.DiagnosticsName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();

        ddlCAR_18.DataSource = MyocardialViability;
        ddlCAR_18.DataTextField = "AttributeValueName";
        ddlCAR_18.DataValueField = "AttributevalueID";
        ddlCAR_18.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Myocardial";
        lstEMRvalue.Attributeid = 18;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR10.Bind(lstEMRvalue, MyocardialViability);

        List<EMRAttributeClass> Coronarytype = (from s in listCA
                                                where s.AttributeID == 19
                                                select new EMRAttributeClass
                                                {
                                                    AttributeName = s.DiagnosticsName,
                                                    AttributevalueID = s.AttributevalueID,
                                                    AttributeValueName = s.AttributeValueName
                                                }).ToList();

        ddlCoronaryVessel_19.DataSource = MyocardialViability;
        ddlCoronaryVessel_19.DataTextField = "AttributeValueName";
        ddlCoronaryVessel_19.DataValueField = "AttributevalueID";
        ddlCoronaryVessel_19.DataBind();

        lstEMRvalue.Name = "Diagonstics";
        lstEMRvalue.Attributename = "Myocardial";
        lstEMRvalue.Attributeid = 19;
        lstEMRvalue.Attributevaluename = "Abnormalities";
        EMR11.Bind(lstEMRvalue, MyocardialViability);

        //foreach (PatientDiagnosticsAttribute objPDA in listCA)
        //{

        //    if (objPDA.DiagnosticsID == 7)
        //    {
        //        chkCoronaryAngiogram_7.Checked = true;
        //        tr1chkCoronaryAngiogram_7.Style.Add("display", "block");
        //        ddlCAR_18.SelectedValue = objPDA.AttributevalueID.ToString();

        //        if (objPDA.AttributeID == 19)
        //        {
        //            BindCAGbnormalities();
        //            ddlCoronaryVessel_19.SelectedValue = objPDA.AttributevalueID.ToString();
        //            if (ddlCoronaryVessel_19.SelectedItem.Text == "Others")
        //            {
        //                divddlCoronaryVessel_19.Style.Add("display", "block");
        //                txtOthers_162.Text = objPDA.AttributeValueName;
        //            }
        //        }

        //    }
        //}

        #endregion

        #region Other Diagnostics

        var listOD = from Res in lstPDA
                     where Res.DiagnosticsID == 8
                     select Res;

        foreach (PatientDiagnosticsAttribute objPDA in listOD)
        {
            if (objPDA.DiagnosticsID == 8 && objPDA.AttributeValueName !=" ")
            {
                chkOtherDiagnostics_8.Checked = true;
                tr1chkOtherDiagnostics_8.Style.Add("display", "block");
                txtOtherDiagnostics_163.Text = objPDA.AttributeValueName;
            }
        }
        #endregion
    }

    public void BindDropDown()
    {
        BindMyocardium();
        BindValveAbnormality();
        BindTreadmillTestResult();
        BindStressRelatedECGChanges();
        BindAssociatedSymptoms();
        BindMPSType();
        BindMVSType();
        BindCoronaryAngiogramResult();
    }
}
