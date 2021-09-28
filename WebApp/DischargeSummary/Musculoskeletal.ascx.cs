using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class DischargeSummary_Musculoskeletal : BaseControl
{
    string BodyParts = string.Empty, 
           ChildItems = string.Empty,
           Position = string.Empty, 
           ChildDes = string.Empty,
           Status = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindMusculoskeletal(long VisitID, int OrgID)
    {
        try
        {
            #region Declaration
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

            objIP_BL = new IP_BL(base.ContextInfo);
            int Count = -1;
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
            #endregion

            #region  GetOrthoPatientDetailsForEdit
            objIP_BL.GetOrthoPatientDetailsForEdit(VisitID, OrgID, out lstOrthoPatientDetails, out lstPatientBodyPartDetails,
                                                          out lstPatientOpenWound, out lstPatientVascularDetails,
                                                          out lstPatientNeurologicalDetails, out lstPatientReflexes,
                                                          out lstPatientMuscleDetail, out lstPatientDistinctBodyPartDetails, out Count, out lstPatientMuscleWasting);

            #endregion

            #region Bind PatientBodyPartDetails
            List<PatientBodyPartDetails> listDBPDPresent = (from listDBPD in lstPatientDistinctBodyPartDetails
                                                            where listDBPD.Status == "Present"
                                                            select listDBPD).ToList();

          
            if (listDBPDPresent.Count > 0)
            {

                foreach (var objDBPD in listDBPDPresent)
                {
                    List<PatientBodyPartDetails> listBPDPresent = (from listBPD in lstPatientBodyPartDetails
                                                                   where listBPD.Status == "Present" && listBPD.Position == objDBPD.Position
                                                                   && listBPD.BodyPartsID == objDBPD.BodyPartsID
                                                                   select listBPD).ToList();
                    if (listBPDPresent.Count > 0)
                    {
                        tblOrtho.Style.Add("display", "block");
                        trBP.Style.Add("display", "block");
                        BodyParts = string.Empty;
                        ChildItems = string.Empty;
                        Position = string.Empty;
                        ChildDes = string.Empty;
                        Status = string.Empty;

                        BodyParts = objDBPD.Name;
                        Position = objDBPD.Position;
                        Status = objDBPD.Status;
                        foreach (var objBPD in listBPDPresent)
                        {
                            if (ChildItems == string.Empty)
                            {
                                if (objBPD.ChildItemName != "")
                                {
                                    ChildItems = objBPD.ChildItemName;
                                }
                                if (objBPD.ChildItemDescription != "")
                                {
                                    ChildDes = "(" + objBPD.ChildItemDescription + ")";
                                    ChildItems += ChildDes;
                                }
                            }
                            else
                            {
                                if (objBPD.ChildItemName != "")
                                {
                                    ChildItems += "," + objBPD.ChildItemName;
                                }
                                if (objBPD.ChildItemDescription != "")
                                {
                                    ChildDes = "(" + objBPD.ChildItemDescription + ")";
                                    ChildItems += ChildDes;
                                }
                            }
                        }

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = BodyParts + "-" + Position + "-" + ChildItems + "  " + Status;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblBP.Rows.Add(row1);
                    }
                }

            }
          
            List<PatientBodyPartDetails> listDBPDAbsent = (from listDBPD in lstPatientDistinctBodyPartDetails
                                                           where listDBPD.Status == "Absent"
                                                           select listDBPD).ToList();
            if (listDBPDAbsent.Count > 0)
            {
                foreach (var objDBPD in listDBPDAbsent)
                {
                    List<PatientBodyPartDetails> listBPDAbsent = (from listBPD in lstPatientBodyPartDetails
                                                                  where listBPD.Status == "Absent" && listBPD.Position == objDBPD.Position
                                                                  && listBPD.BodyPartsID == objDBPD.BodyPartsID
                                                                  select listBPD).ToList();
                    if (listBPDAbsent.Count > 0)
                    {
                        tblOrtho.Style.Add("display", "block");
                        trBPAbsent.Style.Add("display", "block");
                        BodyParts = string.Empty;
                        ChildItems = string.Empty;
                        Position = string.Empty;
                        ChildDes = string.Empty;
                        Status = string.Empty;

                        BodyParts = objDBPD.Name;
                        Position = objDBPD.Position;
                        Status = objDBPD.Status;
                        foreach (var objBPD in listBPDAbsent)
                        {
                            if (ChildItems == string.Empty)
                            {
                                if (objBPD.ChildItemName != "")
                                {
                                    ChildItems = objBPD.ChildItemName;
                                }
                                if (objBPD.ChildItemDescription != "")
                                {
                                    ChildDes = "(" + objBPD.ChildItemDescription + ")";
                                    ChildItems += ChildDes;
                                }
                            }
                            else
                            {
                                if (objBPD.ChildItemName != "")
                                {
                                    ChildItems += "," + objBPD.ChildItemName;
                                }
                                if (objBPD.ChildItemDescription != "")
                                {
                                    ChildDes = "(" + objBPD.ChildItemDescription + ")";
                                    ChildItems += ChildDes;
                                }
                            }
                        }

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = BodyParts + "-" + Position + "-" + ChildItems + "  " + Status;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tbBPAbsent.Rows.Add(row1);
                    }


                }
            }


            #endregion

            #region Bind PatientOpenWound

            if (lstPatientOpenWound.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trOpentWound.Style.Add("display", "block");


                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Open Wound:";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                rowH.Style.Add("color", "#000");
                tblOpentWound.Rows.Add(rowH);

                foreach (var objPOW in lstPatientOpenWound)
                {
                    string Size = string.Empty, Location = string.Empty, Desc = string.Empty;
                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");


                    if (objPOW.Size != "")
                    {
                        Size = objPOW.Size + " - ";
                    }

                    if (objPOW.Description != "")
                    {
                        Location = objPOW.Location + "(" + objPOW.Description + ")";
                    }
                    else
                    {
                        Location = objPOW.Location;
                    }

                    cell1.Text = Size + Location;

                    row1.Cells.Add(cell1);
                    tblOpentWound.Rows.Add(row1);


                }
            }
            #endregion

            #region Bind PatientVascularDetails

            if (lstPatientVascularDetails.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trVD.Style.Add("display", "block");

                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Vascular deficit present:";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                rowH.Style.Add("color", "#000");
                tblVD.Rows.Add(rowH);
                string PVD = string.Empty;
                foreach (var objPVD in lstPatientVascularDetails)
                {
                    if (PVD == string.Empty)
                    {
                        PVD = objPVD.Name;
                    }
                    else
                    {
                        PVD += "," + objPVD.Name;
                    }
                }

                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = PVD;

                row1.Cells.Add(cell1);
                tblVD.Rows.Add(row1);
            }

            #endregion

            #region Bind PatientNeurologicalDetails


            if (lstPatientNeurologicalDetails.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trPND.Style.Add("display", "block");
                trPNDH.Style.Add("display", "block");

                List<PatientNeurologicalDetails> listRootlvl = (from listRoot in lstPatientNeurologicalDetails
                                                                where listRoot.NeurologicalType == "Root level"
                                                                select listRoot).ToList();

                List<PatientNeurologicalDetails> listPlexuslvl = (from listPlexus in lstPatientNeurologicalDetails
                                                                  where listPlexus.NeurologicalType == "Plexus level"
                                                                  select listPlexus).ToList();
                List<PatientNeurologicalDetails> listNervelvl = (from listNerve in lstPatientNeurologicalDetails
                                                                 where listNerve.NeurologicalType == "Nerve level"
                                                                 select listNerve).ToList();


                string RootLvl = string.Empty, PlexusLvl = string.Empty, NerveLvl = string.Empty;

                if (listRootlvl.Count > 0)
                {
                    trRoot.Style.Add("display", "block");
                    foreach (var objPND in listRootlvl)
                    {
                        if (RootLvl == string.Empty)
                        {
                            RootLvl = objPND.Name;
                        }
                        else
                        {
                            RootLvl += "," + objPND.Name;
                        }
                    }
                    lblRoot.Text = "Root Level: " + RootLvl;
                }

                if (listPlexuslvl.Count > 0)
                {
                    trPlexus.Style.Add("display", "block");
                    foreach (var objPND in listPlexuslvl)
                    {
                        if (PlexusLvl == string.Empty)
                        {
                            PlexusLvl = objPND.Name;
                        }
                        else
                        {
                            PlexusLvl += "," + objPND.Name;
                        }
                    }
                    lblPlexus.Text = "Plexus Level: " + PlexusLvl;
                }

                if (listNervelvl.Count > 0)
                {
                    trNerve.Style.Add("display", "block");
                    foreach (var objPND in listNervelvl)
                    {
                        if (NerveLvl == string.Empty)
                        {
                            NerveLvl = objPND.Name;
                        }
                        else
                        {
                            NerveLvl += "," + objPND.Name;
                        }
                    }
                    lblNerve.Text = "Nerve Level: " + NerveLvl;
                }


            }

            #endregion

            #region Bind PatientReflexes


            if (lstPatientReflexes.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trRef.Style.Add("display", "block");


                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Reflexes:";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                rowH.Style.Add("color", "#000");
                tblRef.Rows.Add(rowH);

                foreach (var objRef in lstPatientReflexes)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = objRef.Position + " - " + objRef.Name + " - " + objRef.Status;
                    row1.Cells.Add(cell1);
                    tblRef.Rows.Add(row1);


                }
            }

            #endregion

            #region Bind PatientMuscleDetail


            if (lstPatientMuscleDetail.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trMus.Style.Add("display", "block");


                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Muscular Examination:";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                rowH.Style.Add("color", "#000");
                tblRef.Rows.Add(rowH);

                foreach (var objMus in lstPatientMuscleDetail)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    if (objMus.MusclePower != "")
                    {
                        cell1.Text = objMus.Name + " - " + objMus.MusclePower + " - " + objMus.MuscleTone;
                    }
                    else
                    {
                        cell1.Text = objMus.Name + " - " + objMus.MuscleTone;

                    }
                    row1.Cells.Add(cell1);
                    tblMus.Rows.Add(row1);


                }
            }


            #endregion

            #region Bind PatientMuscleWasting

            if (lstPatientMuscleWasting.Count > 0)
            {
                tblOrtho.Style.Add("display", "block");
                trMW.Style.Add("display", "block");
                string MW = string.Empty;
                if (lstPatientMuscleWasting[0].Status == "Present")
                {
                    foreach (var objPMW in lstPatientMuscleWasting)
                    {
                        if (objPMW.Name != "")
                        {
                            if (MW == string.Empty)
                            {
                                MW = objPMW.Name;
                            }
                            else
                            {
                                MW += "," + objPMW.Name;
                            }
                        }

                    }
                    if (MW != string.Empty)
                    {
                        lblMWT.Text = MW + " " + lstPatientMuscleWasting[0].Status;
                    }
                    else
                    {
                        lblMWT.Text = lstPatientMuscleWasting[0].Status;
                    }
                }
                else
                {
                    lblMWT.Text = lstPatientMuscleWasting[0].Status;
                }
            }
            #endregion

          


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL GetOrthoSpecialtyDetails", ex);
        }

    }
}
