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


public partial class Investigation_HemotologyDisplay : BaseControl
{
    ArrayList lstParent = new ArrayList();
    Boolean show = false;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public Boolean diplayHemotology(List<InvestigationValues> investValues, List<InvestigationDisplayName> lstDisplayName)
    {


        try
        {

            Hashtable ht = null;
            ArrayList lstId = new ArrayList();
           
            var getID = from ex in lstDisplayName
                        where ex.InvestigationID > 2001 && ex.InvestigationID < 3001
                        select ex.InvestigationID;

            foreach (int id in getID)
            {
                lstId.Add(id);
            }

            if (lstId.Count > 0)
            {
                CallAbstract obj = new CallAbstract();
                ht = obj.CallCreateHemotology();
                //a3002.Visible = true;
                show = true;
            }


            for (int i = 0; i < lstId.Count; i++)
            {
                if (ht != null)
                {
                    foreach (DictionaryEntry de in ht)
                    {
                        if (de.Key != "")
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
                { }
            }


            foreach (int parent in lstId)
            {

                try
                {
                    HtmlContainerControl hcc = (HtmlContainerControl)this.FindControl("d" + parent);
                    if (hcc != null)
                    {
                        hcc.Style["display"] = "block";
                    }
                }
                catch (Exception ex)
                { }
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
            List<InvestigationValues> temp3044 = new List<InvestigationValues>();


            InvestigationValues HematObj;


            for (int i = 0; i < lstDisplayName.Count; i++)
            {

                for (int j = 0; j < investValues.Count; j++)
                {
                    if (lstDisplayName[i].InvestigationID == investValues[j].InvestigationID)
                    {

                        //HB TC
                        if ((Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2002 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2003) || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2058)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues.Add(HematObj);
                        }

                        //DC
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2005 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2012)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues1.Add(HematObj);
                        }

                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2013 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2015)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues2.Add(HematObj);
                        }

                        //QBC
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2055)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues3.Add(HematObj);
                        }

                        //Red Cells
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2018 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2022)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues4.Add(HematObj);
                        }

                        //WBC Cells
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2024 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2026)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues5.Add(HematObj);
                        }

                        //Platlets
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2028 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2029)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues6.Add(HematObj);
                        }

                        //Parasites
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2030)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues7.Add(HematObj);
                        }

                        //MCV,MCH,MCVH
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2032 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2035)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues8.Add(HematObj);
                        }

                         //Blood Group
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2031)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues14.Add(HematObj);
                        }

                        //Direct
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2037)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues9.Add(HematObj);
                        }

                        //Indirect
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2038)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues10.Add(HematObj);
                        }

                        //Sickling,Rh.antibody
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2039 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2040)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues11.Add(HematObj);
                        }

                         //HB
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2041)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            tempValues12.Add(HematObj);
                        }

                         //Coagulation Profile
                        else if ((Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 2043 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 2054) &&
                            Convert.ToInt32(lstDisplayName[i].InvestigationID) != 2047)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues13.Add(HematObj);
                        }
                        else if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 2047)
                        {
                            HematObj = new InvestigationValues();
                            HematObj.Value = investValues[j].Value;
                            HematObj.InvestigationName = investValues[j].InvestigationName;
                            HematObj.UOMCode = investValues[j].UOMCode;
                            tempValues15.Add(HematObj);
                        }
                    }

                }

            }




            rpt2002.DataSource = tempValues;
            rpt2002.DataBind();


            rpt2004.DataSource = tempValues1;
            rpt2004.DataBind();


            rpt12004.DataSource = tempValues2;
            rpt12004.DataBind();


            rpt2017.DataSource = tempValues4;
            rpt2017.DataBind();


            rpt2023.DataSource = tempValues5;
            rpt2023.DataBind();


            rpt2027.DataSource = tempValues6;
            rpt2027.DataBind();


            rpt2032.DataSource = tempValues8;
            rpt2032.DataBind();

            rpt2036.DataSource = tempValues11;
            rpt2036.DataBind();


            rpt2042.DataSource = tempValues13;
            rpt2042.DataBind();



            if (tempValues3.Count > 0)
            {
                l2055.Text = tempValues3[0].InvestigationName;
                l12055.Text = tempValues3[0].Value;
                Uom2055.Text = tempValues3[1].Value;
            }


            if (tempValues7.Count > 0)
            {
                pn2030.Visible = true;
                lbl2030.Text = tempValues7[0].InvestigationName;
                lbl12030.Text = tempValues7[0].Value;
                lbl22030.Text = tempValues7[1].Value;
                if(tempValues7.Count>2)
                lbl32030.Text = tempValues7[2].Value;
            }

           


            if (tempValues14.Count > 0)
            {
                lbl2031.Text = tempValues14[0].InvestigationName;
                lbl12031.Text = tempValues14[0].Value;
                lbl22031.Text = tempValues14[1].Value;
            }

            if (tempValues15.Count > 0)
            {

                lblpro.Text = tempValues[0].InvestigationName;
                lblControl.Text = "Control";
                lblResult1.Text = tempValues15[0].Value;
                Uomcontrol.Text = tempValues15[0].UOMCode;

                lblPatient.Text = "Patient";
                lblResult2.Text = tempValues15[1].Value;
                UomResult.Text = tempValues15[1].UOMCode;

                lblINR.Text = "INR";
                lblResult3.Text = tempValues15[2].Value;
                UomINR.Text = tempValues15[2].UOMCode;
                
            }

            if (tempValues9.Count > 0)
            {
                l2037.Text = tempValues9[0].InvestigationName;
                l12037.Text = tempValues9[0].Value;
                l22037.Text = tempValues9[1].Value;
            }

            if (tempValues10.Count > 0)
            {
                l2038.Text = tempValues10[0].InvestigationName;
                l12038.Text = tempValues10[0].Value;
                l22038.Text = tempValues10[1].Value;
            }

            if (tempValues12.Count > 0)
            {
                l2041.Text = tempValues12[0].InvestigationName;
                l12041.Text = tempValues12[0].Value;
                l22041.Text = tempValues12[1].Value;
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while displaying Hematology", ex);
        }

        return show;
    }



    public void getParent(Hashtable ht, string id)
    {
        if (ht != null)
        {
            foreach (DictionaryEntry de in ht)
            {
                if (de.Key == id.ToString())
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
