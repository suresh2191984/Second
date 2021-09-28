using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.ServiceModel;


public partial class CommonControls_OrthoEMR : BaseControl
{
    List<SpecialtyUniqueParts> lstSpecialtyUniqueParts;
    List<BodyPartChildItems> lstBodyPartChildItems;
    List<OrthoPatientDetails> lstOrthoPatientDetails;
    List<PatientBodyPartDetails> lstPatientBodyPartDetails;
    List<PatientOpenWound> lstPatientOpenWound;
    List<PatientVascularDetails> lstPatientVascularDetails;
    List<PatientNeurologicalDetails> lstPatientNeurologicalDetails;
    List<PatientReflexes> lstPatientReflexes;
    List<PatientMuscleDetail> lstPatientMuscleDetail;
    List<PatientBodyPartDetails> lstPatientDistinctBodyPartDetails;
    List<PatientMuscleWasting> lstPatientMuscleWasting;

    IP_BL objIP_BL;
    long returnCode = -1;
    int Count = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMetaData();
        
    }

    public void GetOrthoSpecialtyDetails(int OrgID)
    {
        try
        {

            lstSpecialtyUniqueParts = new List<SpecialtyUniqueParts>();
            lstBodyPartChildItems = new List<BodyPartChildItems>();
            objIP_BL = new IP_BL(base.ContextInfo);

            objIP_BL.GetOrthoSpecialtyDetails(OrgID, out lstSpecialtyUniqueParts, out lstBodyPartChildItems);

            if (lstSpecialtyUniqueParts.Count > 0)
            {
                List<SpecialtyUniqueParts> listBodyParts = (from listSPUP in lstSpecialtyUniqueParts
                                                            where listSPUP.SpecialtyAreaName == "BodyParts"
                                                            select listSPUP).ToList();

                ddlBodyPart.DataSource = listBodyParts;
                ddlBodyPart.DataValueField = "SpecialtyUniquePartID";
                ddlBodyPart.DataTextField = "Name";
                ddlBodyPart.DataBind();


                List<SpecialtyUniqueParts> listVasculardeficit = (from listSPUP in lstSpecialtyUniqueParts
                                                                  where listSPUP.SpecialtyAreaName == "Vasculardeficit"
                                                                  select listSPUP).ToList();

                chkVDPHV.DataSource = listVasculardeficit;
                chkVDPHV.DataValueField = "SpecialtyUniquePartID";
                chkVDPHV.DataTextField = "Name";
                chkVDPHV.DataBind();


                List<SpecialtyUniqueParts> listNeuroRootLevel = (from listSPUP in lstSpecialtyUniqueParts
                                                                 where listSPUP.SpecialtyAreaName == "NeuroRootLevel"
                                                                 select listSPUP).ToList();

                chkRootlvl.DataSource = listNeuroRootLevel;
                chkRootlvl.DataValueField = "SpecialtyUniquePartID";
                chkRootlvl.DataTextField = "Name";
                chkRootlvl.DataBind();


                List<SpecialtyUniqueParts> listNeuroPlexusLevel = (from listSPUP in lstSpecialtyUniqueParts
                                                                   where listSPUP.SpecialtyAreaName == "NeuroPlexusLevel"
                                                                   select listSPUP).ToList();

                chkPlexlvl.DataSource = listNeuroPlexusLevel;
                chkPlexlvl.DataValueField = "SpecialtyUniquePartID";
                chkPlexlvl.DataTextField = "Name";
                chkPlexlvl.DataBind();

                List<SpecialtyUniqueParts> listNeuroNerveLevel = (from listSPUP in lstSpecialtyUniqueParts
                                                                  where listSPUP.SpecialtyAreaName == "NeuroNerveLevel"
                                                                  select listSPUP).ToList();

                chkNervelvl.DataSource = listNeuroNerveLevel;
                chkNervelvl.DataValueField = "SpecialtyUniquePartID";
                chkNervelvl.DataTextField = "Name";
                chkNervelvl.DataBind();

                List<SpecialtyUniqueParts> listReflexes = (from listSPUP in lstSpecialtyUniqueParts
                                                           where listSPUP.SpecialtyAreaName == "Reflexes"
                                                           select listSPUP).ToList();

                ddlRefName.DataSource = listReflexes;
                ddlRefName.DataValueField = "SpecialtyUniquePartID";
                ddlRefName.DataTextField = "Name";
                ddlRefName.DataBind();


                List<SpecialtyUniqueParts> listMuscular = (from listSPUP in lstSpecialtyUniqueParts
                                                           where listSPUP.SpecialtyAreaName == "Muscular"
                                                           select listSPUP).ToList();

                ddlMuscleType.DataSource = listMuscular;
                ddlMuscleType.DataValueField = "SpecialtyUniquePartID";
                ddlMuscleType.DataTextField = "Name";
                ddlMuscleType.DataBind();




                ddlScience.DataSource = lstBodyPartChildItems;
                ddlScience.DataValueField = "BodyPartChildItemsID";
                ddlScience.DataTextField = "Name";
                ddlScience.DataBind();
                ddlScience.Items.Insert(0, "--Select--");
                ddlScience.Items[0].Value = "0";


                List<SpecialtyUniqueParts> listPMW = (from listSPUP in lstSpecialtyUniqueParts
                                                      where listSPUP.SpecialtyAreaName == "MuscleWasting"
                                                                  select listSPUP).ToList();
                chkMWValue.DataSource = listPMW;
                chkMWValue.DataValueField = "SpecialtyUniquePartID";
                chkMWValue.DataTextField = "Name";
                chkMWValue.DataBind();

                trchkMWValue.Style.Add("display", "block");



               


            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Adding GetOrthoSpecialtyDetails", ex);
        }
        

    }

    public long SetOrthoPatientDetails(long VisitID)
    {
        try
        {
            objIP_BL = new IP_BL(base.ContextInfo);
            lstBodyPartChildItems = new List<BodyPartChildItems>();
            lstPatientBodyPartDetails = new List<PatientBodyPartDetails>();
            lstPatientOpenWound = new List<PatientOpenWound>();
            lstPatientVascularDetails = new List<PatientVascularDetails>();
            lstPatientNeurologicalDetails = new List<PatientNeurologicalDetails>();
            lstPatientReflexes = new List<PatientReflexes>();
            lstPatientMuscleDetail = new List<PatientMuscleDetail>();
            lstOrthoPatientDetails = new List<OrthoPatientDetails>();
            lstPatientDistinctBodyPartDetails = new List<PatientBodyPartDetails>();
            lstPatientMuscleWasting = new List<PatientMuscleWasting>();
            
            objIP_BL.GetOrthoPatientDetailsForEdit(VisitID, OrgID, out lstOrthoPatientDetails, out lstPatientBodyPartDetails,
                                                   out lstPatientOpenWound, out lstPatientVascularDetails,
                                                   out lstPatientNeurologicalDetails, out lstPatientReflexes,
                                                   out lstPatientMuscleDetail, out lstPatientDistinctBodyPartDetails, out Count, out lstPatientMuscleWasting);



            #region Set PatientBodyPartDetails
            if (lstPatientBodyPartDetails.Count > 0)
            {
                chkBP.Checked = true;
                trchkBP.Style.Add("display", "block");
                // parseInt(rwNumber) + "~" + BPValue + "~" + BPText + "~" + BPPText + "~" 
                //+ BPCValue + "~" + BPCText + "~" + txtDecs + "~" + IsPresent + "^";
                int i = 110;
                foreach (PatientBodyPartDetails objBP in lstPatientBodyPartDetails)
                {

                    hdnBPItems.Value += i + "~" + objBP.BodyPartsID + "~" + objBP.Name + "~" + objBP.Position +
                                        "~" + objBP.ChildItemID + "~" + objBP.ChildItemName
                                        + "~" + objBP.ChildItemDescription + "~" + objBP.Status + "^";
                    i += 1;
                }

            }
            #endregion

            #region Set PatientOpenWound
            if (lstPatientOpenWound.Count > 0)
            {
                chkOpenwound.Checked = true;
                trchkOpenwound.Style.Add("display", "block");
                //parseInt(rwNumber) + "~" + Size + "~" + Units + "~" + Location + "~" + Description + "^";
                int i = 510;
                foreach (PatientOpenWound objOW in lstPatientOpenWound)
                {

                    hdnOWItems.Value += i + "~" + objOW.Size + "~" + objOW.Units + "~" + objOW.Location +
                                        "~" + objOW.Description + "^";
                    i += 1;
                }

            }
            #endregion

            #region SET PatientVascularDetails
            if (lstPatientVascularDetails.Count > 0)
            {
                chkVDPH.Checked = true;
                trchkVDPH.Style.Add("display", "block");
                foreach (ListItem li in chkVDPHV.Items)
                {
                    foreach (PatientVascularDetails objPVD in lstPatientVascularDetails)
                    {
                        if (li.Value == objPVD.VascularDeficitID.ToString())
                        {
                            li.Selected = true;

                        }


                    }
                }
            }
            #endregion

            #region SET PatientNeurologicalDetails
            if (lstPatientNeurologicalDetails.Count > 0)
            {
                chkNDPH.Checked = true;
                trchkNDPH.Style.Add("display", "block");

                List<PatientNeurologicalDetails> listRootlvl = (from listRoot in lstPatientNeurologicalDetails
                                                                where listRoot.NeurologicalType == "Root level"
                                                                select listRoot).ToList();
                if (listRootlvl.Count() > 0)
                {
                    foreach (ListItem li in chkRootlvl.Items)
                    {
                        foreach (PatientNeurologicalDetails objPND in listRootlvl)
                        {
                            if (li.Value == objPND.ItemID.ToString())
                            {
                                li.Selected = true;


                            }


                        }
                    }
                }


                List<PatientNeurologicalDetails> listPlexuslvl = (from listPlexus in lstPatientNeurologicalDetails
                                                                  where listPlexus.NeurologicalType == "Plexus level"
                                                                  select listPlexus).ToList();
                if (listPlexuslvl.Count() > 0)
                {
                    foreach (ListItem li in chkPlexlvl.Items)
                    {
                        foreach (PatientNeurologicalDetails objPND in listPlexuslvl)
                        {
                            if (li.Value == objPND.ItemID.ToString())
                            {
                                li.Selected = true;


                            }


                        }
                    }
                }

                List<PatientNeurologicalDetails> listNervelvl = (from listNerve in lstPatientNeurologicalDetails
                                                                 where listNerve.NeurologicalType == "Nerve level"
                                                                 select listNerve).ToList();
                if (listNervelvl.Count() > 0)
                {
                    foreach (ListItem li in chkNervelvl.Items)
                    {
                        foreach (PatientNeurologicalDetails objPND in listNervelvl)
                        {
                            if (li.Value == objPND.ItemID.ToString())
                            {
                                li.Selected = true;


                            }


                        }
                    }
                }
            }

            #endregion

            #region Set PatientReflexes

            if (lstPatientReflexes.Count > 0)
            {
                chkReflexes.Checked = true;
                trchkReflexes.Style.Add("display", "block");
                // parseInt(rwNumber) + "~" + RefTvalue + "~" + RefTText + "~" + RefPText + "~" +
                //RefSvalue + "~" + RefSText + "^";

                int i = 810;
                foreach (PatientReflexes objPR in lstPatientReflexes)
                {

                    hdnRefItems.Value += i + "~" + objPR.ReflexesTypeID + "~" + objPR.Name + "~" + objPR.Position +
                                        "~" + objPR.Status + "~" + objPR.Status + "^";
                    i += 1;
                }
            }
            #endregion

            #region Set  PatientMuscleDetail
            if (lstPatientMuscleDetail.Count > 0)
            {
                chkME.Checked = true;
                trchkME.Style.Add("display", "block");
                //parseInt(rwNumber) + "~" + MusTvalue + "~" + MusTText + "~" + MusPvalue + "~" + 
                //MusPText + "~" + MusTnvalue + "~" + MusTnText + "^";

                int i = 1000;
                foreach (PatientMuscleDetail objPMus in lstPatientMuscleDetail)
                {

                    hdnMusExItems.Value += i + "~" + objPMus.MuscleID + "~" + objPMus.Name + "~" + objPMus.MusclePower +
                                        "~" + objPMus.MusclePower + "~" + objPMus.MuscleTone + "~" + objPMus.MuscleTone + "^";
                    i += 1;
                }
            }
            #endregion

            #region Set PatientMuscleWasting



            if (lstPatientMuscleWasting.Count > 0)
            {
                chkMW.Checked = true;
                trchkMW.Style.Add("display", "block");
                ddlMuscleWasting.SelectedValue = lstPatientMuscleWasting[0].Status;
                if (lstPatientMuscleWasting[0].Status == "Absent")
                {
                    trchkMWValue.Style.Add("display", "none");
                }
                else
                {
                    trchkMWValue.Style.Add("display", "block");
                    foreach (ListItem li in chkMWValue.Items)
                    {
                        foreach (PatientMuscleWasting objMW in lstPatientMuscleWasting)
                        {
                            if (li.Value == objMW.ItemID.ToString())
                            {
                                li.Selected = true;

                            }


                        }
                    }
                }
            }
            #endregion
           
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in SetOrthoPatientDetails", ex);
        }


        return Count;

    }

        

    public long SaveOrthoPatientDetails(long VisitID, long PatientID)
    {
        try
        {

            lstBodyPartChildItems = new List<BodyPartChildItems>();
            lstPatientBodyPartDetails = new List<PatientBodyPartDetails>();
            lstPatientOpenWound = new List<PatientOpenWound>();
            lstPatientVascularDetails = new List<PatientVascularDetails>();
            lstPatientNeurologicalDetails = new List<PatientNeurologicalDetails>();
            lstPatientReflexes = new List<PatientReflexes>();
            lstPatientMuscleDetail = new List<PatientMuscleDetail>();
            lstOrthoPatientDetails = new List<OrthoPatientDetails>();
            lstPatientMuscleWasting = new List<PatientMuscleWasting>();

            lstOrthoPatientDetails = GetOrthoPatientDetails();
            if (chkBP.Checked)
            {
                lstPatientBodyPartDetails = GetPatientBodyPartDetails();
            }
            if (chkOpenwound.Checked)
            {
                lstPatientOpenWound = GetPatientOpenWound();
            }
            if (chkVDPH.Checked)
            {
                lstPatientVascularDetails = GetPatientVascularDetails();
            }
            if (chkNDPH.Checked)
            {
                lstPatientNeurologicalDetails = GetPatientNeurologicalDetails();
            }
            if (chkReflexes.Checked)
            {
                lstPatientReflexes = GetPatientReflexes();
            }
            if(chkME.Checked)
            {
            lstPatientMuscleDetail = GetPatientMuscleDetail();
            }
            if (chkMW.Checked)
            {
                lstPatientMuscleWasting = GetPatientMuscleWasting();
            }

            objIP_BL = new IP_BL(base.ContextInfo);

            returnCode=objIP_BL.SaveOrthoPatientDetails(VisitID, PatientID, OrgID, LID,
                                             lstOrthoPatientDetails, lstPatientBodyPartDetails,
                                             lstPatientOpenWound, lstPatientVascularDetails,
                                             lstPatientNeurologicalDetails, lstPatientReflexes,
                                             lstPatientMuscleDetail, lstPatientMuscleWasting);



        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in SaveOrthoPatientDetails", ex);
        }
        return returnCode;

       

     
    }

    private List<OrthoPatientDetails> GetOrthoPatientDetails()
    {
        List<OrthoPatientDetails> lstOrthoPatientDetailsTemp = new List<OrthoPatientDetails>();

        try
        {


            //if (chkBP.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Body Parts";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Body Parts";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            //if (chkOpenwound.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Open Wound";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Open Wound";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            //if (chkVDPH.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Vascular Deficit";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Vascular Deficit";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            //if (chkNDPH.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Neurological Deficit";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Neurological Deficit";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            //if (chkReflexes.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Reflexes";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Reflexes";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            //if (chkME.Checked)
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Muscular Examination";
            //    objOPD.Status = "Present";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}
            //else
            //{
            //    OrthoPatientDetails objOPD = new OrthoPatientDetails();
            //    objOPD.SpecialityPartsName = "Muscular Examination";
            //    objOPD.Status = "Absent";
            //    lstOrthoPatientDetailsTemp.Add(objOPD);
            //}

            if (chkMW.Checked)
            {
                OrthoPatientDetails objOPD = new OrthoPatientDetails();
                objOPD.SpecialityPartsName = "Muscle Wasting";
                objOPD.Status = ddlMuscleWasting.SelectedValue;
                lstOrthoPatientDetailsTemp.Add(objOPD);
            }
           

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetOrthoPatientDetails", ex);
        }

        return lstOrthoPatientDetailsTemp;



    }

    private List<PatientMuscleDetail> GetPatientMuscleDetail()
    {
        List<PatientMuscleDetail> lstPatientMuscleDetailTemp = new List<PatientMuscleDetail>();

        try
        {


            //parseInt(rwNumber) + "~" + MusTvalue + "~" + MusTText + "~" + MusPvalue + "~" + 
            //MusPText + "~" + MusTnvalue + "~" + MusTnText + "^";

            foreach (string listMusItems in hdnMusExItems.Value.Split('^'))
            {
                if (listMusItems != "")
                {
                    PatientMuscleDetail objMusItems = new PatientMuscleDetail();
                    string[] strMustems = listMusItems.Split('~');
                    objMusItems.MuscleID = Convert.ToInt64(strMustems[1]);
                    objMusItems.MusclePower = strMustems[4];
                    objMusItems.MuscleTone = strMustems[5];
                    lstPatientMuscleDetailTemp.Add(objMusItems);
                }
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientMuscleDetail", ex);
        }
        return lstPatientMuscleDetailTemp;
    }

    private List<PatientReflexes> GetPatientReflexes()
    {
        List<PatientReflexes> lstPatientReflexesTemp = new List<PatientReflexes>();

        try
        {


            // parseInt(rwNumber) + "~" + RefTvalue + "~" + RefTText + "~" + RefPText + "~" +
            //RefSvalue + "~" + RefSText + "^";

            foreach (string listRefItems in hdnRefItems.Value.Split('^'))
            {
                if (listRefItems != "")
                {
                    PatientReflexes objRefItems = new PatientReflexes();
                    string[] strReftems = listRefItems.Split('~');
                    objRefItems.ReflexesTypeID = Convert.ToInt64(strReftems[1]);
                    objRefItems.Position = strReftems[3];
                    objRefItems.Status = strReftems[4];
                    lstPatientReflexesTemp.Add(objRefItems);
                }
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientReflexes", ex);
        }
        return lstPatientReflexesTemp;
    }

    private List<PatientNeurologicalDetails> GetPatientNeurologicalDetails()
    {
        List<PatientNeurologicalDetails> lstPatientNeurologicalDetailstemp = new List<PatientNeurologicalDetails>();

        try
        {



            foreach (ListItem li in chkRootlvl.Items)
            {
                if (li.Selected)
                {
                    PatientNeurologicalDetails objND = new PatientNeurologicalDetails();
                    objND.ItemID = Convert.ToInt64(li.Value);
                    objND.NeurologicalType = "Root level";
                    lstPatientNeurologicalDetailstemp.Add(objND);
                }
            }

            foreach (ListItem li in chkPlexlvl.Items)
            {
                if (li.Selected)
                {
                    PatientNeurologicalDetails objND = new PatientNeurologicalDetails();
                    objND.ItemID = Convert.ToInt64(li.Value);
                    objND.NeurologicalType = "Plexus level";
                    lstPatientNeurologicalDetailstemp.Add(objND);
                }
            }


            foreach (ListItem li in chkNervelvl.Items)
            {
                if (li.Selected)
                {
                    PatientNeurologicalDetails objND = new PatientNeurologicalDetails();
                    objND.ItemID = Convert.ToInt64(li.Value);
                    objND.NeurologicalType = "Nerve level";
                    lstPatientNeurologicalDetailstemp.Add(objND);
                }
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientNeurologicalDetails", ex);
        }

        return lstPatientNeurologicalDetailstemp;

    }

    private List<PatientVascularDetails> GetPatientVascularDetails()
    {
        List<PatientVascularDetails> lstPatientVascularDetailstemp = new List<PatientVascularDetails>();

        try
        {



            foreach (ListItem li in chkVDPHV.Items)
            {
                if (li.Selected)
                {
                    PatientVascularDetails objVD = new PatientVascularDetails();
                    objVD.VascularDeficitID = Convert.ToInt64(li.Value);
                    lstPatientVascularDetailstemp.Add(objVD);
                }
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientVascularDetails", ex);
        }

        return lstPatientVascularDetailstemp;



    }

    private List<PatientOpenWound> GetPatientOpenWound()
    {
        List<PatientOpenWound> lstPatientOpenWoundTemp = new List<PatientOpenWound>();

        try
        {


            //parseInt(rwNumber) + "~" + Size + "~" + Units + "~" + Location + "~" + Description + "^";

            foreach (string listOWItems in hdnOWItems.Value.Split('^'))
            {
                if (listOWItems != "")
                {
                    PatientOpenWound objOWI = new PatientOpenWound();
                    string[] strOWItems = listOWItems.Split('~');
                    objOWI.Size = strOWItems[1];
                    objOWI.Units = strOWItems[2];
                    objOWI.Location = strOWItems[3];
                    objOWI.Description = strOWItems[4];
                    lstPatientOpenWoundTemp.Add(objOWI);
                }
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientOpenWound", ex);
        }

       return lstPatientOpenWoundTemp;
    }

    private List<PatientBodyPartDetails> GetPatientBodyPartDetails()
    {
        List<PatientBodyPartDetails> lstPatientBodyPartDetailsTemp = new List<PatientBodyPartDetails>();

        try
        {
            // parseInt(rwNumber) + "~" + BPValue + "~" + BPText + "~" + BPPText + "~" 
            //+ BPCValue + "~" + BPCText + "~" + txtDecs + "~" + IsPresent + "^";

           
            foreach (string listBPItems in hdnBPItems.Value.Split('^'))
            {
                if (listBPItems != "")
                {
                    PatientBodyPartDetails objPBPD = new PatientBodyPartDetails();
                    string[] strBPItems = listBPItems.Split('~');
                    objPBPD.BodyPartsID = Convert.ToInt64(strBPItems[1]);
                    objPBPD.Position = strBPItems[3];
                    objPBPD.ChildItemID = Convert.ToInt64(strBPItems[4]);
                    objPBPD.ChildItemDescription = strBPItems[6];
                    objPBPD.Status = strBPItems[7];
                    lstPatientBodyPartDetailsTemp.Add(objPBPD);
                }
            }

            

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in  GetPatientBodyPartDetails", ex);
        }
        return lstPatientBodyPartDetailsTemp;
    }

    private List<PatientMuscleWasting> GetPatientMuscleWasting()
    {
        List<PatientMuscleWasting> lstPatientMuscleWastingtemp = new List<PatientMuscleWasting>();

        try
        {


            if (ddlMuscleWasting.SelectedValue == "Present")
            {
                foreach (ListItem li in chkMWValue.Items)
                {
                    if (li.Selected)
                    {
                        PatientMuscleWasting objMW = new PatientMuscleWasting();
                        objMW.Status = "Present";
                        objMW.ItemID = Convert.ToInt64(li.Value);
                        lstPatientMuscleWastingtemp.Add(objMW);
                    }
                }
            }
            else
            {
                PatientMuscleWasting objMW = new PatientMuscleWasting();
                objMW.Status = "Absent";
                objMW.ItemID = 0;
                lstPatientMuscleWastingtemp.Add(objMW);
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetPatientMuscleWasting", ex);
        }

        return lstPatientMuscleWastingtemp;


    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "BodyPartPosition,Units,ReflexPosition,ReflexStatus,MusclePower,MuscleTone,MuscleWasting";
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


            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "BodyPartPosition"
                                     select child;
                    ddlBPPosition.DataSource = childItems;
                    ddlBPPosition.DataTextField = "DisplayText";
                    ddlBPPosition.DataValueField = "Code";
                    ddlBPPosition.DataBind();

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "Units"
                                      select child;

                    ddlUnits.DataSource = childItems1;
                    ddlUnits.DataTextField = "DisplayText";
                    ddlUnits.DataValueField = "Code";
                    ddlUnits.DataBind();

                    var childItems2 = from child in lstmetadataOutput
                                      where child.Domain == "ReflexPosition"
                                      select child;

                    ddlRefPosition.DataSource = childItems2;
                    ddlRefPosition.DataTextField = "DisplayText";
                    ddlRefPosition.DataValueField = "Code";
                    ddlRefPosition.DataBind();



                    var childItems3 = from child in lstmetadataOutput
                                      where child.Domain == "ReflexStatus"
                                     select child;
                    ddlRefStatus.DataSource = childItems3;
                    ddlRefStatus.DataTextField = "DisplayText";
                    ddlRefStatus.DataValueField = "Code";
                    ddlRefStatus.DataBind();

                    var childItems4 = from child in lstmetadataOutput
                                      where child.Domain == "MusclePower"
                                      select child;

                    ddlMusclePower.DataSource = childItems4;
                    ddlMusclePower.DataTextField = "DisplayText";
                    ddlMusclePower.DataValueField = "Code";
                    ddlMusclePower.DataBind();

                    var childItems5 = from child in lstmetadataOutput
                                      where child.Domain == "MuscleTone"
                                      select child;

                    ddlMuscleTone.DataSource = childItems5;
                    ddlMuscleTone.DataTextField = "DisplayText";
                    ddlMuscleTone.DataValueField = "Code";
                    ddlMuscleTone.DataBind();

                    var childItems6= from child in lstmetadataOutput
                                     where child.Domain == "MuscleWasting"
                                     select child;

                   ddlMuscleWasting.DataSource = childItems6;
                   ddlMuscleWasting.DataTextField = "DisplayText";
                   ddlMuscleWasting.DataValueField = "Code";
                   ddlMuscleWasting.DataBind();

                    
                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data  ... ", ex);

        }
    }

   
}
