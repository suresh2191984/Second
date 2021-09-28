using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Web.UI.HtmlControls;
using Attune.Podium.Common;

public partial class Investigation_ClinicalDisplay : BaseControl
{
    public Investigation_ClinicalDisplay()
        : base("Investigation_ClinicalDisplay_ascx")
    {
    }
    ArrayList lstParent = new ArrayList();
    Boolean show = false;
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #endregion

    #region "Methods"

    public Boolean diplayBiochemistry(List<InvestigationValues> investValues, List<InvestigationDisplayName> lstDisplayName)
    {

        try
        {


            Hashtable ht = null;
            ArrayList lstId = new ArrayList();

            var getID = from ex in lstDisplayName
                        where ex.InvestigationID > 4001 && ex.InvestigationID < 5001
                        select ex.InvestigationID;

            foreach (int id in getID)
            {
                lstId.Add(id);
            }

            if (lstId.Count > 0)
            {
                CallAbstract obj = new CallAbstract();
                ht = obj.CallClinicalPathology();
                //a3002.Visible = true;
                show = true;
            }


            for (int i = 0; i < lstId.Count; i++)
            {
                if (ht != null)
                {
                    foreach (DictionaryEntry de in ht)
                    {
                        if (de.Key.ToString() != "")
                        {
                            if (Convert.ToInt32(de.Key) == Convert.ToInt32(lstId[i]))
                            {
                                if (!lstParent.Contains(de.Value.ToString()))
                                {
                                    lstParent.Add(de.Value.ToString());
                                }
                                getParent(ht, de.Value.ToString());
                            }
                        }
                    }
                }
            }


            foreach (string parent in lstParent)
            {

                try
                {
                    HtmlContainerControl hcc = (HtmlContainerControl)this.FindControl("d" + parent);
                    if (hcc != null)
                    {
                        hcc.Style["display"] = "block";
                    }
                    HtmlAnchor anchor = (HtmlAnchor)this.FindControl("a" + parent);
                    if (anchor != null)
                    {
                        anchor.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error", ex);
                }
            }


            foreach (int child in lstId)
            {
                try
                {
                    HtmlContainerControl hcc = (HtmlContainerControl)this.FindControl("d" + Convert.ToString(child));
                    if (hcc != null)
                    {
                        hcc.Style["display"] = "block";
                    }
                    HtmlAnchor anchor = (HtmlAnchor)this.FindControl("a" + Convert.ToString(child));
                    if (anchor != null)
                    {
                        anchor.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error", ex);
                }
            }


            List<InvestigationValues> tempValues = new List<InvestigationValues>();
            List<InvestigationValues> tempValues1 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues2 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues3 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues4 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues5 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues6 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues7 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues8 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues9 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues10 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues11 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues12 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues13 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues14 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues15 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues16 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues17 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues18 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues19 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues20 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues21 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues22 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues23 = new List<InvestigationValues>();
            List<InvestigationValues> tempValues24 = new List<InvestigationValues>();

            InvestigationValues tempObj;

            for (int i = 0; i < lstDisplayName.Count; i++)
            {

                for (int j = 0; j < investValues.Count; j++)
                {
                    if (lstDisplayName[i].InvestigationID == investValues[j].InvestigationID)
                    {
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4003 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4005)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues.Add(tempObj);
                        }

                        //Cells and Casts
                        else if ((Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4007 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4012)
                            || (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4150 && Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4156))
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues1.Add(tempObj);
                        }

                        //Chemistry
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4014 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4024)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues2.Add(tempObj);
                        }

                        //Urine Microscopic
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4026 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4033)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues3.Add(tempObj);
                        }


                        //24 hr Urine sample
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4035 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4044)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues4.Add(tempObj);
                        }

                        //Body fluid
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4046 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4049)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues5.Add(tempObj);
                        }

                        //Cells
                        else if ((Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4051 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4052)
                            || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4057 || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4058)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues6.Add(tempObj);
                        }

                        //Differential Count
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4054 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4056)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues7.Add(tempObj);
                        }

                        //Chemistry
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4060 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4065)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues8.Add(tempObj);
                        }

                        //Immunological
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4067 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4072)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues9.Add(tempObj);
                        }

                         //Cytology
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4074 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4076)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues10.Add(tempObj);
                        }

                        //Sputum Grams Stain
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4080 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4081)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues24.Add(tempObj);
                        }






                        //Hepatatis
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4086 ||
                            (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4126 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4135)
                            || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4089 || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4090
                            || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4092)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].Name;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues11.Add(tempObj);
                        }

                         //ASO
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4091)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues12.Add(tempObj);
                        }

                        //Widal
                        //else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4121 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4124)
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4093)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.Name = investValues[j].Name;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues13.Add(tempObj);
                        }

                        //ANA
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4097)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues14.Add(tempObj);
                        }

                         //dsDNA
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4098)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues15.Add(tempObj);
                        }

                         //ANCA
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4100 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4101)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues16.Add(tempObj);
                        }

                       //Macroscopic
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4104 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4108)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues17.Add(tempObj);
                        }


                         //Microscopic
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 4110)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues18.Add(tempObj);
                        }


                         //Macroscopic-Motility
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4112 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4116)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues19.Add(tempObj);
                        }

                         //Morphology
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4118 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4120)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues20.Add(tempObj);
                        }


                        //HIV1
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4084 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4085)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.Name = investValues[j].Name;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempObj.InvestigationID = investValues[j].InvestigationID;
                            tempValues21.Add(tempObj);
                        }

                        //Leptospira
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 4087 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 4088)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.Name = investValues[j].Name;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempObj.InvestigationID = investValues[j].InvestigationID;
                            tempValues22.Add(tempObj);
                        }
                    }

                }

            }



            rpt4002.DataSource = tempValues;
            rpt4002.DataBind();


            rpt4006.DataSource = tempValues1;
            rpt4006.DataBind();


            rpt4013.DataSource = tempValues2;
            rpt4013.DataBind();

            rpt4025.DataSource = tempValues3;
            rpt4025.DataBind();


            rpt4034.DataSource = tempValues4;
            rpt4034.DataBind();

            rpt4045.DataSource = tempValues5;
            rpt4045.DataBind();


            rpt4050.DataSource = tempValues6;
            rpt4050.DataBind();


            rpt4053.DataSource = tempValues7;
            rpt4053.DataBind();

            rpt4059.DataSource = tempValues8;
            rpt4059.DataBind();


            rpt4066.DataSource = tempValues9;
            rpt4066.DataBind();


            rpt4073.DataSource = tempValues10;
            rpt4073.DataBind();


            rpt4086.DataSource = tempValues11;
            rpt4086.DataBind();


            //rpt4093.DataSource = tempValues13;
            //rpt4093.DataBind();


            rpt4096.DataSource = tempValues15;
            rpt4096.DataBind();

            rpt4099.DataSource = tempValues16;
            rpt4099.DataBind();


            rpt4103.DataSource = tempValues17;
            rpt4103.DataBind();

            rpt4109.DataSource = tempValues18;
            rpt4109.DataBind();

            rpt4111.DataSource = tempValues19;
            rpt4111.DataBind();

            rpt4117.DataSource = tempValues20;
            rpt4117.DataBind();


            rpt4079.DataSource = tempValues24;
            rpt4079.DataBind();


            if (tempValues12.Count > 0)
            {
                l4091.Text = tempValues12[0].InvestigationName;
                l14091.Text = tempValues12[0].Value;
                l34091.Text = tempValues12[0].UOMCode;
            }


            if (tempValues21.Count > 0)
            {
                for (int i = 0; i < tempValues21.Count; i++)
                {
                    var queryInvestigation = from ex in lstDisplayName
                                             where ex.InvestigationID == tempValues21[i].InvestigationID
                                             select ex;

                    IEnumerable<InvestigationDisplayName> ienum = queryInvestigation;
                    //HIV 1
                    if (tempValues21[i].InvestigationID == 4084)
                    {
                        pn4084.Visible = true;
                        l4084.Text = tempValues21[0].InvestigationName + "(" + ienum.ElementAt<InvestigationDisplayName>(0).Method + ")";
                        l14084.Text = tempValues21[1].Value;
                    }

                    //HIV 2
                    else if (tempValues21[i].InvestigationID == 4085)
                    {
                        pn4085.Visible = true;
                        l4085.Text = tempValues21[i].InvestigationName + "(" + ienum.ElementAt<InvestigationDisplayName>(0).Method + ")";
                        l14085.Text = tempValues21[i].Value;
                    }
                }

            }

            if (tempValues22.Count > 0)
            {

                var queryInvestigation = from ex in investValues
                                         where ex.InvestigationID == 4088
                                         select ex;

                var lstdisplay = from ex in lstDisplayName
                                 where ex.InvestigationID == 4088
                                 select ex;
                if (lstdisplay.Count() > 0)
                {
                    IEnumerable<InvestigationDisplayName> ienum = lstdisplay;
                    pn4087.Visible = true;
                    if (queryInvestigation.Count() > 0)
                    {
                        lbl4087.Text = tempValues22[0].InvestigationName + "(" + ienum.ElementAt<InvestigationDisplayName>(0).Method + ")";
                    }

                    //l14087.Text = tempValues22[1].Name;
                    //l24087.Text = tempValues22[1].Value;
                    //l34087.Text = tempValues22[2].Name;
                    //l44087.Text = tempValues22[2].Value;
                    //l54087.Text = tempValues22[3].Name;
                    //l64087.Text = tempValues22[4].Value;
                    rpt4087.DataSource = queryInvestigation;
                    rpt4087.DataBind();
                }

            }


            if (tempValues22.Count > 0)
            {

                var queryInvestigation = from ex in investValues
                                         where ex.InvestigationID == 4087
                                         select ex;

                var lstdisplay = from ex in lstDisplayName
                                 where ex.InvestigationID == 4087
                                 select ex;
                if (lstdisplay.Count() > 0)
                {
                    IEnumerable<InvestigationDisplayName> ienum = lstdisplay;
                    pn4087.Visible = true;
                    if (queryInvestigation.Count() > 0)
                    {
                        lblHead.Text = tempValues22[0].InvestigationName + "(" + ienum.ElementAt<InvestigationDisplayName>(0).Method + ")";
                    }

                    //l14087.Text = tempValues22[1].Name;
                    //l24087.Text = tempValues22[1].Value;
                    //l34087.Text = tempValues22[2].Name;
                    //l44087.Text = tempValues22[2].Value;
                    //l54087.Text = tempValues22[3].Name;
                    //l64087.Text = tempValues22[4].Value;
                    rptRubella.DataSource = queryInvestigation;
                    rptRubella.DataBind();
                }

            }


            if (tempValues14.Count > 0)
            {
                pn4098.Visible = true;
                l4098.Text = tempValues14[0].InvestigationName;
                l14098.Text = tempValues14[0].Value;
                l24098.Text = tempValues14[1].Value;
                l34098.Text = tempValues14[2].Value;
            }


            int count1 = 0;
            int count2 = 0;
            int count3 = 0;
            int count4 = 0;
            string typhiH = string.Empty;
            string typhiO = string.Empty;
            string paraH = string.Empty;
            string paraO = string.Empty;
            string[] getVal;
            if (tempValues13.Count > 0)
            {
                for (int i = 0; i < tempValues13.Count; i++)
                {
                    if (tempValues13[i].Name == "Typhis H")
                    {
                        if (count1 == 0)
                        {
                            typhiH = tempValues13[i].Name;
                            count1++;
                        }
                        else
                        {
                            typhiH = typhiH + "," + tempValues13[i].Value;
                        }
                    }

                    if (tempValues13[i].Name == "Typhis O")
                    {
                        if (count2 == 0)
                        {
                            typhiO = tempValues13[i].Name;
                            count2++;
                        }
                        else
                        {
                            typhiO = typhiO + "," + tempValues13[i].Value;
                        }
                    }

                    if (tempValues13[i].Name == "Paratyphis H")
                    {
                        if (count3 == 0)
                        {
                            paraH = tempValues13[i].Name;
                            count3++;
                        }
                        else
                        {
                            paraH = paraH + "," + tempValues13[i].Value;
                        }
                    }


                    if (tempValues13[i].Name == "Paratyphis O")
                    {
                        if (count4 == 0)
                        {
                            paraO = tempValues13[i].Name;
                            count4++;
                        }
                        else
                        {
                            paraO = paraO + "," + tempValues13[i].Value;
                        }
                    }
                }

                string strDilution = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_10 == null ? "Dilution" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_10;
                string strResult = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_11 == null ? "Result" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_11;
                string strTyphiO = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_12 == null ? "Typhi 'H'" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_12;
                string strTyphiH = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_13 == null ? "Typhi 'O'" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_13;
                string strParatyphisH = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_14 == null ? "Paratyphis 'H'" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_14;
                string strParatyphisO = Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_15 == null ? "Paratyphis 'O'" : Resources.Investigation_ClientDisplay.Investigation_ClinicalDisplay_aspx_15;

                Table tbl = new Table();
                tbl.Style["color"] = "black";
                tbl.Style["font-weight"] = "bold";
                tbl.CellSpacing = 2;
                tbl.BorderColor = System.Drawing.Color.Black;
                tbl.BorderWidth = 1;
                tbl.BorderStyle = BorderStyle.Solid;
                TableRow tr = new TableRow();
                TableCell tc;

                tc = new TableCell();
                tc.Text = "";
                tr.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = strDilution.Trim();
                tr.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = strResult.Trim();
                tr.Cells.Add(tc);
                tbl.Rows.Add(tr);


                pn4093.Controls.Add(tbl);

                getVal = typhiH.Split(',');

                TableRow tr1 = new TableRow();
                tc = new TableCell();
                tc.Text = strTyphiH.Trim();
                tr1.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[1].ToString();
                tr1.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[2].ToString();
                tr1.Cells.Add(tc);
                tbl.Rows.Add(tr1);

                pn4093.Controls.Add(tbl);

                getVal = typhiO.Split(',');

                TableRow tr2 = new TableRow();
                tc = new TableCell();
                tc.Text = strTyphiO.Trim();
                tr2.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[1].ToString();
                tr2.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[2].ToString();
                tr2.Cells.Add(tc);
                tbl.Rows.Add(tr2);

                pn4093.Controls.Add(tbl);

                getVal = paraH.Split(',');

                TableRow tr3 = new TableRow();
                tc = new TableCell();
                tc.Text = strParatyphisH.Trim();
                tr3.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[1].ToString();
                tr3.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[2].ToString();
                tr3.Cells.Add(tc);
                tbl.Rows.Add(tr3);

                pn4093.Controls.Add(tbl);

                getVal = paraO.Split(',');

                TableRow tr4 = new TableRow();
                tc = new TableCell();
                tc.Text = strParatyphisO.Trim();
                tr4.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[1].ToString();
                tr4.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = getVal[2].ToString();
                tr4.Cells.Add(tc);
                tbl.Rows.Add(tr4);

                pn4093.Controls.Add(tbl);




            }






        }


        catch (Exception ex)
        {
            CLogger.LogError("Error in ClinicalDisplay", ex);
        }

        return show;

    }


    public void getParent(Hashtable ht, string id)
    {
        if (ht != null)
        {
            foreach (DictionaryEntry de in ht)
            {
                if (de.Key.ToString() == id.ToString())
                {
                    if (!lstParent.Contains(de.Value.ToString()))
                    {
                        lstParent.Add(de.Value.ToString());
                    }
                    getParent(ht, de.Value.ToString());
                }
            }
        }

    }
    #endregion
}
