using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
public partial class Investigation_Profile :BaseControl
{
    private long patientVisitId;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public long PatientVisitID
    {
        get { return patientVisitId; }
        set { patientVisitId=value ; }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;
            long taskID = -1;


            ////MicroBiology
            //if (chkKOHMount.Checked)
            //{
            //    PatientInvestigation patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4081;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //if (chkGramsStam.Checked)
            //{
            //    PatientInvestigation patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4080;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);
            //}


            if (chkTorchpanel.Checked)
            {
                PatientInvestigation patientobj1 = null;


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1006;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1004;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }


            if (chk1008.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1009;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }

            if (chk1006.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1006;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1007;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }


            if (chk1005.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1004;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }


            //Hemotology
            if (chkCompleteHemogram.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2002;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2005;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2006;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2010;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2014;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2015;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2032;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2033;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2034;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2035;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }



            if (chk2002.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2002;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2003.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }



            if (chk2005.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2005;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2006;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2010;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2011;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


            }

            if (chk2011.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2011;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2032.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2014.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2014;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2033.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2033;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2034.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2034;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2035.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2035;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2013.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2013;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2058;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2012.Checked == true && (chk2005.Checked == false || chkCompleteHemogram.Checked == false))
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkGlycosylatedHb.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3016;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2018.Checked == true)
            {

                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2018;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2019;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2020;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);




                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2021;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2022;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2024;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2025;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2026;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2028;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2029;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2030;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2031.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2031;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2040;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk2037.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2037;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk2038.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2038;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2055.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2055;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }



            //Coagulation Profile
            if (chkCoagulation.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2015;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2045;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2047;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

            }

            if (chkPlateletCount.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2015;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkBleedingTime.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkClottingTime.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2045;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkProthrombinTimeINR.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2047;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkAPTT.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Motion

            //if (chk3128.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3128;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3129;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3130;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3131;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3132;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3133;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3134;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3135;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3136;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3137;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //}


            //if (chk3137.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3137;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk3131.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3131;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //Bio-Chemistry
            if (chk3012.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3012;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3013.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3013;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3018.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3018;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3021.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3021;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3064.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3064;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3053.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3053;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3055.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3055;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3054.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3054;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3056.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3056;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3057.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3057;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3007.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3007;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3008.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3008;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3003.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3003;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3004.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3004;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3005.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3033.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3033;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3032.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3032;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3040.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3040;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3041.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3041;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3042.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3042;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3043.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3036.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3036;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3037.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3037;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3038.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3038;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3039.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3039;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3048.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3049.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3049;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3051.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3051;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3060.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3060;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3070.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3070;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3044.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3044;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkT3.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3080;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkT4.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3082;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFreeT3.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3079;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFreeT4.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3083;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkTSH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3084;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFSH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3122;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkLH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3123;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkProlactin.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3121;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkEstradiol.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3119;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkProgesterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3117;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk17OHProgesterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3118;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkTestosterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3112;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkDihydrotestosterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3115;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkGrowthHormone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3090;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkACTH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3109;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkBetaHCG.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3124;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Serology

            //if (chkSerology.Checked)
            //{

            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4121;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4122;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4123;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4124;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4089;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4092;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4091;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4090;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4084;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4085;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4088;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}



            //if (chk4121.Checked && chkSerology.Checked==false)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4121;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4122;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4123;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4124;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);



            //}


            //if (chk4089.Checked && chkSerology.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4089;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //if (chk4092.Checked && chkSerology.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4092;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4091.Checked && chkSerology.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4091;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4090.Checked && chkSerology.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4090;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //if (chk4084.Checked && chkSerology.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4084;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4085;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    lstPatientInvestigation.Add(patientobj1);

            //}

            //if (chk4088.Checked && chkSerology.Checked == false)
            //{

            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4088;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //Immunology
            //if (chk4097.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4097;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4098.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4098;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4070.Checked)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4070;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4071.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4071;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4072.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4072;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}



            //Hepatatis
            //if (chkHepatitis.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4127;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4128;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4129;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4132;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4134;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //}

            //if (chk4127.Checked && chkHepatitis.Checked==false )
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4127;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4128.Checked && chkHepatitis.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4128;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4129.Checked && chkHepatitis.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4129;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4132.Checked && chkHepatitis.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4132;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4134.Checked && chkHepatitis.Checked == false)
            //{
            //    PatientInvestigation patientobj1;
            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4134;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //Clinical Pathology

            //if (chk4003.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4003;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4004;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4013;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4014;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4015;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4016;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4017;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4018;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4019;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4020;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4021;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4022;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4023;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4024;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4007;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4008;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4010;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4011;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4150;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4151;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4152;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4153;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4154;
            //    patientobj1.PatientVisitID = patientVisitId;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4155;
            //    patientobj1.PatientVisitID = patientVisitId;


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4156;
            //    patientobj1.PatientVisitID = patientVisitId;


            //    lstPatientInvestigation.Add(patientobj1);


            //}


            //if (chk4018.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4018;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4019;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //if (chk3126.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 3126;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4017.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4017;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4015.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4015;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}

            //if (chk4035.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4035;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4036;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4037;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4038;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4039;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4040;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4041;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4042;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4043;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4044;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //if (chk4104.Checked)
            //{
            //    PatientInvestigation patientobj1;

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4104;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4105;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4106;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4107;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4108;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4110;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4112;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);


            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4113;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4114;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4115;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4116;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4118;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4119;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);

            //    patientobj1 = new PatientInvestigation();
            //    patientobj1.InvestigationID = 4120;
            //    patientobj1.PatientVisitID = patientVisitId;
            //    lstPatientInvestigation.Add(patientobj1);
            //}


            //long result = investigBL.SavePatientInvestigation(lstPatientInvestigation, Convert.ToInt64(patientVisitId), Convert.ToInt64(3));

            //if (result == 0)
            //{
            //    if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
            //    {
            //        Tasks task = new Tasks();
            //        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            //        Int64.TryParse(Request.QueryString["tid"], out taksId);
            //        returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

            //        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientId);

            //        //Create task for Collect investigation payment
            //        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
            //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
            //            patientId, lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0, "INV", out dText, out urlVal);
            //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
            //        task.DispTextFiller = dText;
            //        task.URLFiller = urlVal;
            //        task.RoleID = RoleID;
            //        task.OrgID = OrgID;
            //        task.PatientVisitID = patientVisitId;
            //        task.PatientID = patientId;
            //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;

            //        //create task
            //        returnCode = taskBL.CreateTask(task, out taskID);
            //        string redirectURL = @"..\Billing\InvestigationPayment.aspx?vid=" + patientVisitId + "&tid=" + taskID + "&pid=" + patientId + "&ptid=0&ftype=INV";
            //        Response.Redirect(redirectURL, true);
            //    }
            //    else if (Request.QueryString["pvid"].ToString() != "0")
            //    {
            //        Int64.TryParse(Request.QueryString["pvid"], out previousVisitId);
            //        Response.Redirect("~/Physician/PatientDiagnose.aspx?pvid=" + previousVisitId + "&vid=" + patientVisitId);
            //    }
            //    else
            //    {
            //        Int64.TryParse(Request.QueryString["id"], out complaintId);
            //        Response.Redirect("~/Physician/PatientDiagnose.aspx?id=" + complaintId + "&vid=" + patientVisitId);
            //    }
            //}
            //else
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "Error while saving investigation profile";
            //}
        }

        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while saving investigation profile";
            CLogger.LogError("Error while saving Investigation Profile", ex);

        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
    public List<PatientInvestigation> GetSelectedItems()
    {  
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        try
        {
          
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;
            long taskID = -1;


            //MicroBiology
            if (chkKOHMount.Checked)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4081;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkGramsStam.Checked)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4080;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkTorchpanel.Checked)
            {
                PatientInvestigation patientobj1 = null;


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1006;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
                
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1004;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }


            if (chk1008.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1009;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }

            if (chk1006.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1006;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1007;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }


            if (chk1005.Checked == true && chkTorchpanel.Checked == false)
            {
                PatientInvestigation patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 1005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                PatientInvestigation patientobj2 = new PatientInvestigation();
                patientobj2.InvestigationID = 1004;
                patientobj2.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj2);
            }


            //Hemotology
            if (chkCompleteHemogram.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2002;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2005;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2006;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2010;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2014;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2015;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2032;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2033;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2034;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2035;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }



            if (chk2002.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2002;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2003.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }



            if (chk2005.Checked == true && chkCompleteHemogram.Checked == false)
            {

                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2005;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2006;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);



                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2007;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2008;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2009;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2010;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2011;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


            }

            if (chk2011.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2011;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2032.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2003;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2014.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2014;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2033.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2033;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2034.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2034;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk2035.Checked == true && chkCompleteHemogram.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2035;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2013.Checked == true)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2013;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2058;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2012.Checked == true && (chk2005.Checked == false || chkCompleteHemogram.Checked == false))
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2012;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkGlycosylatedHb.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3016;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);
            }

            //Smear study-load only the group header
            if (chk2018.Checked == true)
            {

                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2016;
                patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2018;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2019;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2020;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2021;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);



                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2022;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2024;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2025;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2026;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2028;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2029;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 2030;
                //patientobj1.PatientVisitID = patientVisitId;

                //lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2031.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2031;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2040;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk2037.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2037;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk2038.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2038;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk2055.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2055;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }



            //Coagulation Profile
            if (chkCoagulation.Checked)
            {
                PatientInvestigation patientobj1;

                if (chkCompleteHemogram.Checked == false)
                {
                    patientobj1 = new PatientInvestigation();
                    patientobj1.InvestigationID = 2015;
                    patientobj1.PatientVisitID = patientVisitId;
                    lstPatientInvestigation.Add(patientobj1);
                }

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2045;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2047;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

            }

            if (chkPlateletCount.Checked && chkCoagulation.Checked == false && chkCompleteHemogram.Checked==false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2015;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkBleedingTime.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkClottingTime.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2045;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkProthrombinTimeINR.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2047;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkAPTT.Checked && chkCoagulation.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 2048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Motion


            if (chk3128.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3128;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3129;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3130;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3131;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3132;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3133;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3134;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3135;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3136;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3137;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

            }


            if (chk3137.Checked && chk3128.Checked==false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3137;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3131.Checked && chk3128.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3131;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Bio-Chemistry
            if (chk3012.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3012;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3013.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3013;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3018.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3018;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3021.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3021;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3064.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3064;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3053.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3053;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3055.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3055;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3054.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3054;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3056.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3056;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3057.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3057;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3007.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3007;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3008.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3008;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3003.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3003;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3004.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3004;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3005.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3005;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3033.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3033;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3032.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3032;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3040.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3040;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3041.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3041;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3042.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3042;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3043.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3036.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3036;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3037.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3037;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3038.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3038;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3039.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3039;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3048.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3048;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3049.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3049;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3051.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3051;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3060.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3060;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3070.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3070;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk3044.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3044;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkT3.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3080;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkT4.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3082;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFreeT3.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3079;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFreeT4.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3083;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkTSH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3084;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkFSH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3122;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkLH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3123;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkProlactin.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3121;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkEstradiol.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3119;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chkProgesterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3117;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk17OHProgesterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3118;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkTestosterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3112;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkDihydrotestosterone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3115;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkGrowthHormone.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3090;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkACTH.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3109;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chkBetaHCG.Checked == true)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3124;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Serology

            if (chkSerology.Checked)
            {

                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4093;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4122;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4123;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4124;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4089;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4092;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4091;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4090;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4084;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4085;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4088;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4087;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }



            if (chk4121.Checked && chkSerology.Checked==false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4093;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4122;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4123;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);


                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4124;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);



            }


            if (chk4089.Checked && chkSerology.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4089;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk4092.Checked && chkSerology.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4092;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4091.Checked && chkSerology.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4091;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4090.Checked && chkSerology.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4090;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk4084.Checked && chkSerology.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4084;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4085;
                patientobj1.PatientVisitID = patientVisitId;

                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk4088.Checked && chkSerology.Checked == false)
            {

                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4088;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4087.Checked && chkSerology.Checked == false)
            {

                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4087;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            //Immunology
            if (chk4097.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4097;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4098.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4098;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4070.Checked)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4070;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4071.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4071;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4072.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4072;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }



           // Hepatatis
            if (chkHepatitis.Checked)
            {
                PatientInvestigation patientobj1;

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4127;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4128;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4129;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4132;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4134;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

            }

            if (chk4127.Checked && chkHepatitis.Checked==false )
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4128.Checked && chkHepatitis.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4129.Checked && chkHepatitis.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4132.Checked && chkHepatitis.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4134.Checked && chkHepatitis.Checked == false)
            {
                PatientInvestigation patientobj1;
                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4086;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //Clinical Pathology

            if (chk4003.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4003;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4004;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                //patientobj1 = new PatientInvestigation();
                //patientobj1.InvestigationID = 4013;
                //patientobj1.PatientVisitID = patientVisitId;
                //lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4014;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4015;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4016;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4017;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4018;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4019;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4020;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4021;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4022;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4023;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4024;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4007;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4008;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4010;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4011;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4150;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4151;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4152;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4153;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4154;
                patientobj1.PatientVisitID = patientVisitId;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4155;
                patientobj1.PatientVisitID = patientVisitId;


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4156;
                patientobj1.PatientVisitID = patientVisitId;


                lstPatientInvestigation.Add(patientobj1);


            }


            if (chk4018.Checked && chk4003.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4018;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4019;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk3126.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 3126;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4017.Checked && chk4003.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4017;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4015.Checked && chk4003.Checked == false)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4015;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }

            if (chk4035.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4035;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4036;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4037;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4038;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4039;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4040;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4041;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4042;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4043;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4044;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            if (chk4104.Checked)
            {
                PatientInvestigation patientobj1;

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4104;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4105;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4106;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4107;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4108;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4110;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4112;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);


                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4113;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4114;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4115;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4116;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4118;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4119;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);

                patientobj1 = new PatientInvestigation();
                patientobj1.InvestigationID = 4120;
                patientobj1.PatientVisitID = patientVisitId;
                lstPatientInvestigation.Add(patientobj1);
            }


            //long result = investigBL.SavePatientInvestigation(lstPatientInvestigation, Convert.ToInt64(patientVisitId), Convert.ToInt64(3));

            //if (result == 0)
            //{
            //    if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
            //    {
            //        Tasks task = new Tasks();
            //        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            //        Int64.TryParse(Request.QueryString["tid"], out taksId);
            //        returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

            //        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientId);

            //        //Create task for Collect investigation payment
            //        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
            //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
            //            patientId, lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0, "INV", out dText, out urlVal);
            //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
            //        task.DispTextFiller = dText;
            //        task.URLFiller = urlVal;
            //        task.RoleID = RoleID;
            //        task.OrgID = OrgID;
            //        task.PatientVisitID = patientVisitId;
            //        task.PatientID = patientId;
            //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;

            //        //create task
            //        returnCode = taskBL.CreateTask(task, out taskID);
            //        string redirectURL = @"..\Billing\InvestigationPayment.aspx?vid=" + patientVisitId + "&tid=" + taskID + "&pid=" + patientId + "&ptid=0&ftype=INV";
            //        Response.Redirect(redirectURL, true);
            //    }
            //    else if (Request.QueryString["pvid"].ToString() != "0")
            //    {
            //        Int64.TryParse(Request.QueryString["pvid"], out previousVisitId);
            //        Response.Redirect("~/Physician/PatientDiagnose.aspx?pvid=" + previousVisitId + "&vid=" + patientVisitId);
            //    }
            //    else
            //    {
            //        Int64.TryParse(Request.QueryString["id"], out complaintId);
            //        Response.Redirect("~/Physician/PatientDiagnose.aspx?id=" + complaintId + "&vid=" + patientVisitId);
            //    }
            //}
            //else
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "Error while saving investigation profile";
            //}
        }

        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while saving investigation profile";
            CLogger.LogError("Error while saving Investigation Profile", ex);

        }

        return lstPatientInvestigation;

    }
}
