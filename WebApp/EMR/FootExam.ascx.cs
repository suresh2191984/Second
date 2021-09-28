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
using Attune.Podium.Common;
public partial class HealthPackageControls_FootExam : BaseControl
{
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {



        EMR1.DDL = ddlPedalRight_100;
        EMR2.DDL = ddlFootRight_102;
        EMR38.DDL = ddlPedalLeft_101;
        EMR39.DDL = ddlFootLeft_103;
        EMR3.DDL =ddlPeripheralRight_104;
        EMR42.DDL =ddlPeripheralLeft_105;
        EMR43.DDL = ddlFootRiskRight_106;
        //EMR5.DDL = ddlType_64;       
       
        //if (IsPostBack)
        //{
        //    if (chkAbdominalInspection_889.Checked == true)
        //    {
        //        tr1chkAbdominalInspection_889.Attributes.Add("Style", "Display:block");
        //    }
        //    else
        //    {
        //        tr1chkAbdominalInspection_889.Attributes.Add("Style", "Display:none");
        //    }
        //    if (chkAbdominalPalpation_890.Checked == true)
        //    {
        //        tr1chkAbdominalPalpation_890.Attributes.Add("Style", "Display:block");
        //    }
        //    else
        //    {
        //        tr1chkAbdominalPalpation_890.Attributes.Add("Style", "Display:none");
        //    }
        //    if (chkLiver_891.Checked == true)
        //    {
        //        tr1chkLiver_891.Attributes.Add("Style", "Display:block");
        //    }
        //    else
        //    {
        //        tr1chkLiver_891.Attributes.Add("Style", "Display:none");
        //    }
        //    if (chkSpleen_892.Checked == true)
        //    {
        //        tr1chkSpleen_892.Attributes.Add("Style", "Display:block");
        //    }
        //    else
        //    {
        //        tr1chkSpleen_892.Attributes.Add("Style", "Display:none");
        //    }
        //    if (chkKidneys_893.Checked == true)
        //    {
        //        tr1chkKidneys_893.Attributes.Add("Style", "Display:block");
        //    }
        //    else
        //    {
        //        tr1chkKidneys_893.Attributes.Add("Style", "Display:none");
        //    }
            
        //}
    }
    #region Bind dropdown
    //protected void ddlType_60_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlType_60.SelectedItem.Text != "Not Palable")
    //    {
    //        trDescription_61.Style.Add("display", "block");
    //    }
    //    else
    //    {
    //        trDescription_61.Style.Add("display", "none");
    //    }
    //}
    //protected void ddlType_62_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlType_62.SelectedItem.Text != "Not Palable")
    //    {
    //        trDescription_63.Style.Add("display", "block");
    //    }
    //    else
    //    {
    //        trDescription_63.Style.Add("display", "none");
    //    }
    //}
    
    //protected void ddlType_64_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //if (ddlType_64.SelectedItem.Text != "Not Ballotable")
    //    //{
    //    //    trDescription_65.Style.Add("display", "block");
    //    //}
    //    //else
    //    //{
    //    //    trDescription_65.Style.Add("display", "none");
    //    //}
    //}
    #endregion

    public void LoadExamData()
    {
        
    }
    #region GetData
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();
        try
        {
            #region Peripheral Neuropathy
            if (chkPeripheral_934.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 934;
                objPatientExamination.ExaminationName = chkPeripheral_934.Text;
                attribute.Add(objPatientExamination);

                #region lblPeripheralRight_934

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 934;
                    objPatientExaminationAttribute.AttributeID = 0;
                    objPatientExaminationAttribute.AttributevalueID = 498;
                    objPatientExaminationAttribute.AttributeValueName = txtPeripheralRight_934.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblPeripheralRight_934

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 934;
                    objPatientExaminationAttribute.AttributeID = 0;
                    objPatientExaminationAttribute.AttributevalueID = 499;
                    objPatientExaminationAttribute.AttributeValueName = txtPeripheralLeft_934.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion

            }
            #endregion

            #region Pedal Oedema
            if (chkPedalOedema_935.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 935;
                objPatientExamination.ExaminationName = chkPedalOedema_935.Text;
                attribute.Add(objPatientExamination);

                #region lblPedalRight_100

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 935;
                    objPatientExaminationAttribute.AttributeID = 100;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlPedalRight_100.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlPedalRight_100.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblPedalLeft_101

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 935;
                    objPatientExaminationAttribute.AttributeID = 101;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlPedalLeft_101.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlPedalLeft_101.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion

            }
            #endregion
            #region Foot or Toe Deformity
            if (chkFoot_936.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 936;
                objPatientExamination.ExaminationName = chkFoot_936.Text;
                attribute.Add(objPatientExamination);

                #region lblFootLeft_102

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 936;
                    objPatientExaminationAttribute.AttributeID = 102;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFootRight_102.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlFootRight_102.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblFootLeft_103

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 936;
                    objPatientExaminationAttribute.AttributeID = 103;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFootLeft_103.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlFootLeft_103.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }
            #endregion

            #region Foot Ulcer
            if (chkFootUl_937.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 937;
                objPatientExamination.ExaminationName = chkFootUl_937.Text;
                attribute.Add(objPatientExamination);

                #region lblFootLeft_102

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 937;
                    objPatientExaminationAttribute.AttributeID = 109;
                    objPatientExaminationAttribute.AttributevalueID = 467;
                    objPatientExaminationAttribute.AttributeValueName = txtFootUlRight_937.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblFootLeft_103

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 937;
                    objPatientExaminationAttribute.AttributeID = 110;
                    objPatientExaminationAttribute.AttributevalueID = 468;
                    objPatientExaminationAttribute.AttributeValueName = txtFootUlLeft_937.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }
            #endregion

            #region Infection
            if (chkInfection_938.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 938;
                objPatientExamination.ExaminationName = chkInfection_938.Text;
                attribute.Add(objPatientExamination);

                #region lblInfectionRight_938

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 938;
                    objPatientExaminationAttribute.AttributeID = 111;
                    objPatientExaminationAttribute.AttributevalueID = 469;
                    objPatientExaminationAttribute.AttributeValueName = txtInfectionRight_938.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblInfectionLeft_938

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 938;
                    objPatientExaminationAttribute.AttributeID = 112;
                    objPatientExaminationAttribute.AttributevalueID = 470;
                    objPatientExaminationAttribute.AttributeValueName = txtInfectionLeft_938.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }
            #endregion

            #region Peripheral Pulses
            if (chkPeripheralPulse_939.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 939;
                objPatientExamination.ExaminationName = chkPeripheralPulse_939.Text;
                attribute.Add(objPatientExamination);

                #region lblPeripheralPulsesRight_939

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 939;
                    objPatientExaminationAttribute.AttributeID = 104;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlPeripheralRight_104.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlPeripheralRight_104.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                #region lblPeripheralPulsesRight_939

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 939;
                    objPatientExaminationAttribute.AttributeID = 105;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlPeripheralLeft_105.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlPeripheralLeft_105.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }
            #endregion

            #region Peripheral Pulses
            if (chkFootRisk_940.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 940;
                objPatientExamination.ExaminationName = chkFootRisk_940.Text;
                attribute.Add(objPatientExamination);

                #region lblPeripheralPulsesRight_940

                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 940;
                    objPatientExaminationAttribute.AttributeID = 106;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFootRiskRight_106.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlFootRiskRight_106.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
                //#region lblPeripheralPulsesRight_939

                //{
                //    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                //    objPatientExaminationAttribute.ExaminationID = 940;
                //    objPatientExaminationAttribute.AttributeID = 0;
                //    objPatientExaminationAttribute.AttributevalueID = 504;
                //    objPatientExaminationAttribute.AttributeValueName = txtFootRiskLeft_106.Text;
                //    attrValue.Add(objPatientExaminationAttribute);
                //}
                //#endregion
            }
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }

        return returnval;
    }
    #endregion

    #region EditData
    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        try
        {
            #region Peripheral Neuropathy
            var listPeripheral = from Res in lstPEA
                                 where Res.ExaminationID == 934
                                 select Res;
            foreach (PatientExaminationAttribute objPEA in listPeripheral)
            {

                if (objPEA.ExaminationID == 934)
                {
                    chkPeripheral_934.Checked = true;
                    tr1chkPeripheral_934.Style.Add("display", "block");
                    if (objPEA.AttributevalueID == 498)
                    {
                        txtPeripheralRight_934.Text = objPEA.AttributeValueName.ToString();
                    }
                    if (objPEA.AttributevalueID == 499)
                    {
                        txtPeripheralLeft_934.Text = objPEA.AttributeValueName.ToString();
                    }

                }
            }
            #endregion

            #region Pedal Oedema
            var listPedal = from Res in lstPEA
                            where Res.ExaminationID == 935
                            select Res;
            foreach (PatientExaminationAttribute objPEA in listPedal)
            {

                if (objPEA.ExaminationID == 935)
                {
                    chkPedalOedema_935.Checked = true;
                    tr1chkPedalOedema_935.Style.Add("display", "block");
                    if (objPEA.AttributeID == 100)
                    {
                        ddlPedalRight_100.SelectedValue = objPEA.AttributevalueID.ToString();
                    }
                    if (objPEA.AttributeID == 101)
                    {
                        ddlPedalLeft_101.SelectedValue = objPEA.AttributevalueID.ToString();
                    }

                }
            }
            #endregion

            #region Foot or Toe Deformity
            var listFootorToe = from Res in lstPEA
                                where Res.ExaminationID == 936
                                select Res;
            foreach (PatientExaminationAttribute objPEA in listFootorToe)
            {

                if (objPEA.ExaminationID == 936)
                {
                    chkFoot_936.Checked = true;
                    tr1chkFoot_936.Style.Add("display", "block");
                    if (objPEA.AttributeID == 102)
                    {
                        ddlFootRight_102.SelectedValue = objPEA.AttributevalueID.ToString();
                    }
                    if (objPEA.AttributeID == 103)
                    {
                        ddlFootLeft_103.SelectedValue = objPEA.AttributevalueID.ToString();
                    }

                }
            }
            #endregion

            #region Foot Ulcer
            var listFootUlcer = from Res in lstPEA
                                where Res.ExaminationID == 937
                                select Res;
            foreach (PatientExaminationAttribute objPEA in listFootUlcer)
            {

                if (objPEA.ExaminationID == 937)
                {
                    chkFootUl_937.Checked = true;
                    tr1chkFootUl_937.Style.Add("display", "block");
                    if (objPEA.AttributevalueID == 467)
                    {
                        txtFootUlRight_937.Text = objPEA.AttributeValueName.ToString();
                    }
                    if (objPEA.AttributevalueID == 468)
                    {
                        txtFootUlLeft_937.Text = objPEA.AttributeValueName.ToString();
                    }

                }
            }
            #endregion

            #region Infection
            var listInfection = from Res in lstPEA
                                where Res.ExaminationID == 938
                                select Res;
            foreach (PatientExaminationAttribute objPEA in listInfection)
            {

                if (objPEA.ExaminationID == 938)
                {
                    chkInfection_938.Checked = true;
                    tr1chkInfection_938.Style.Add("display", "block");
                    if (objPEA.AttributevalueID == 469)
                    {
                        txtInfectionRight_938.Text = objPEA.AttributeValueName.ToString();
                    }
                    if (objPEA.AttributevalueID == 470)
                    {
                        txtInfectionLeft_938.Text = objPEA.AttributeValueName.ToString();
                    }

                }
            }
            #endregion

            #region Peripheral Pulses
            var listPeripheralPulses = from Res in lstPEA
                                       where Res.ExaminationID == 939
                                       select Res;
            foreach (PatientExaminationAttribute objPEA in listPeripheralPulses)
            {

                if (objPEA.ExaminationID == 939)
                {
                    chkPeripheralPulse_939.Checked = true;
                    tr1chkPeripheralPulse_939.Style.Add("display", "block");
                    if (objPEA.AttributeID == 104)
                    {
                        ddlPeripheralRight_104.SelectedValue = objPEA.AttributevalueID.ToString();
                    }
                    if (objPEA.AttributeID == 105)
                    {
                        ddlPeripheralLeft_105.Text = objPEA.AttributevalueID.ToString();
                    }

                }
            }
            #endregion

            #region Foot Risk Assessment
            var listFootRiskAssessment = from Res in lstPEA
                                         where Res.ExaminationID == 940
                                         select Res;
            foreach (PatientExaminationAttribute objPEA in listFootRiskAssessment)
            {

                if (objPEA.ExaminationID == 940)
                {
                    chkFootRisk_940.Checked = true;
                    tr1chkFootRisk_940.Style.Add("display", "block");
                    if (objPEA.AttributeID == 106)
                    {
                        ddlFootRiskRight_106.SelectedValue = objPEA.AttributevalueID.ToString();
                    }
                    //if (objPEA.AttributevalueID == 504)
                    //{
                    //    txtFootRiskLeft_106.Text = objPEA.AttributeValueName.ToString();
                    //}

                }
            }
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }
#endregion

#region SetData
    public void SaveData()
    {
        
    }
    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        try
        {
            #region Pedal Oedema Right
            var listPeripheralRight = from Res in lstPEA
                                      where Res.ExaminationID == 935
                                      select Res;

            List<EMRAttributeClass> typePeripheralRight = (from s in listPeripheralRight
                                                           where s.AttributeID == 100
                                                           select new EMRAttributeClass
                                                             {
                                                                 AttributeName = s.AttributeName,
                                                                 AttributevalueID = s.AttributevalueID,
                                                                 AttributeValueName = s.AttributeValueName
                                                             }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Pedal oedema Right";
            lstEMRvalue.Attributeid = 100;
            lstEMRvalue.Attributevaluename = typePeripheralRight[0].AttributeName;

            EMR1.Bind(lstEMRvalue, typePeripheralRight);
            ddlPedalRight_100.DataSource = typePeripheralRight.ToList();
            ddlPedalRight_100.DataTextField = "AttributeValueName";
            ddlPedalRight_100.DataValueField = "AttributevalueID";
            ddlPedalRight_100.DataBind();
            ddlPedalRight_100.Items.Insert(0, "---Select---");


            #endregion
            #region Pedal Oedema Left
            var listPeripheralLeft = from Res in lstPEA
                                     where Res.ExaminationID == 935
                                     select Res;

            List<EMRAttributeClass> typePeripheralLeft = (from s in listPeripheralLeft
                                                          where s.AttributeID == 101
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = s.AttributeName,
                                                              AttributevalueID = s.AttributevalueID,
                                                              AttributeValueName = s.AttributeValueName
                                                          }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Pedal oedema Left";
            lstEMRvalue.Attributeid = 101;
            lstEMRvalue.Attributevaluename = typePeripheralLeft[0].AttributeName;

            EMR38.Bind(lstEMRvalue,typePeripheralLeft);
            ddlPedalLeft_101.DataSource = typePeripheralLeft.ToList();
            ddlPedalLeft_101.DataTextField = "AttributeValueName";
            ddlPedalLeft_101.DataValueField = "AttributevalueID";
            ddlPedalLeft_101.DataBind();
            ddlPedalLeft_101.Items.Insert(0, "---Select---");


            #endregion




            #region Foot or Toe Deformity Right
            var listFootorToeRight = from Res in lstPEA
                                     where Res.ExaminationID == 936
                                     select Res;

            List<EMRAttributeClass> typeFootorToeRight = (from s in listFootorToeRight
                                                          where s.AttributeID == 102
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = s.AttributeName,
                                                              AttributevalueID = s.AttributevalueID,
                                                              AttributeValueName = s.AttributeValueName
                                                          }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Foot or Toe Deformity Right";
            lstEMRvalue.Attributeid = 102;
            lstEMRvalue.Attributevaluename = typeFootorToeRight[0].AttributeName;

            EMR2.Bind(lstEMRvalue, typeFootorToeRight);
            ddlFootRight_102.DataSource = typeFootorToeRight.ToList();
            ddlFootRight_102.DataTextField = "AttributeValueName";
            ddlFootRight_102.DataValueField = "AttributevalueID";
            ddlFootRight_102.DataBind();
            ddlFootRight_102.Items.Insert(0, "---Select---");


            #endregion
            #region Foot or Toe Deformity Left
            var listFootorToeLeft = from Res in lstPEA
                                    where Res.ExaminationID == 936
                                    select Res;

            List<EMRAttributeClass> typeFootorToeLeft = (from s in listFootorToeLeft
                                                         where s.AttributeID == 103
                                                         select new EMRAttributeClass
                                                         {
                                                             AttributeName = s.AttributeName,
                                                             AttributevalueID = s.AttributevalueID,
                                                             AttributeValueName = s.AttributeValueName
                                                         }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Foot or Toe Deformity Left";
            lstEMRvalue.Attributeid = 103;
            lstEMRvalue.Attributevaluename = typeFootorToeLeft[0].AttributeName;

            EMR39.Bind(lstEMRvalue, typeFootorToeLeft);
            ddlFootLeft_103.DataSource = typeFootorToeLeft.ToList();
            ddlFootLeft_103.DataTextField = "AttributeValueName";
            ddlFootLeft_103.DataValueField = "AttributevalueID";
            ddlFootLeft_103.DataBind();
            ddlFootLeft_103.Items.Insert(0, "---Select---");


            #endregion


            #region Peripheral Pulses Right
            var listPeripheralPulsesRight = from Res in lstPEA
                                            where Res.ExaminationID == 939
                                            select Res;

            List<EMRAttributeClass> typePeripheralPulsesRight = (from s in listPeripheralPulsesRight
                                                                 where s.AttributeID == 104
                                                                 select new EMRAttributeClass
                                                                 {
                                                                     AttributeName = s.AttributeName,
                                                                     AttributevalueID = s.AttributevalueID,
                                                                     AttributeValueName = s.AttributeValueName
                                                                 }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Peripheral Pulses Right";
            lstEMRvalue.Attributeid = 104;
            lstEMRvalue.Attributevaluename = typePeripheralPulsesRight[0].AttributeName;

            EMR3.Bind(lstEMRvalue, typePeripheralPulsesRight);
            ddlPeripheralRight_104.DataSource = typePeripheralPulsesRight.ToList();
            ddlPeripheralRight_104.DataTextField = "AttributeValueName";
            ddlPeripheralRight_104.DataValueField = "AttributevalueID";
            ddlPeripheralRight_104.DataBind();
            ddlPeripheralRight_104.Items.Insert(0, "---Select---");


            #endregion
            #region Peripheral Pulses Left
            var listPeripheralPulsesLeft = from Res in lstPEA
                                           where Res.ExaminationID == 939
                                           select Res;

            List<EMRAttributeClass> typePeripheralPulsesLeft = (from s in listPeripheralPulsesLeft
                                                                where s.AttributeID == 105
                                                                select new EMRAttributeClass
                                                                {
                                                                    AttributeName = s.AttributeName,
                                                                    AttributevalueID = s.AttributevalueID,
                                                                    AttributeValueName = s.AttributeValueName
                                                                }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Peripheral Pulses Left";
            lstEMRvalue.Attributeid = 105;
            lstEMRvalue.Attributevaluename = typePeripheralPulsesLeft[0].AttributeName;

            EMR42.Bind(lstEMRvalue, typePeripheralPulsesLeft);
            ddlPeripheralLeft_105.DataSource = typePeripheralPulsesLeft.ToList();
            ddlPeripheralLeft_105.DataTextField = "AttributeValueName";
            ddlPeripheralLeft_105.DataValueField = "AttributevalueID";
            ddlPeripheralLeft_105.DataBind();
            ddlPeripheralLeft_105.Items.Insert(0, "---Select---");


            #endregion

            #region Foot Risk Assessment
            var listFootRiskAssessmentRight = from Res in lstPEA
                                              where Res.ExaminationID == 940
                                              select Res;

            List<EMRAttributeClass> typeFootRiskAssessmentRight = (from s in listFootRiskAssessmentRight
                                                                   where s.AttributeID == 106
                                                                   select new EMRAttributeClass
                                                                   {
                                                                       AttributeName = s.AttributeName,
                                                                       AttributevalueID = s.AttributevalueID,
                                                                       AttributeValueName = s.AttributeValueName
                                                                   }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Peripheral Pulses Left";
            lstEMRvalue.Attributeid = 106;
            lstEMRvalue.Attributevaluename = typeFootRiskAssessmentRight[0].AttributeName;

            EMR43.Bind(lstEMRvalue, typeFootRiskAssessmentRight);
            ddlFootRiskRight_106.DataSource = typeFootRiskAssessmentRight.ToList();
            ddlFootRiskRight_106.DataTextField = "AttributeValueName";
            ddlFootRiskRight_106.DataValueField = "AttributevalueID";
            ddlFootRiskRight_106.DataBind();
            ddlFootRiskRight_106.Items.Insert(0, "---Select---");
            #endregion

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }

    }
#endregion
}
