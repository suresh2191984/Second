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
public partial class Investigation_BioChemistryDisplay : BaseControl
{
    public Investigation_BioChemistryDisplay()
        : base("Investigation_BioChemistryDisplay_ascx")
    {
    }
    ArrayList lstParent = new ArrayList();
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #endregion

    #region "Methods"
    public Boolean diplayBiochemistry(List<InvestigationValues> investValues, List<InvestigationDisplayName> lstDisplayName)
    {

        Boolean show =false;
        try
        {
            Hashtable ht = null;
            ArrayList lstId = new ArrayList();
            

            var getID = from ex in lstDisplayName
                        where ex.InvestigationID > 3001 && ex.InvestigationID < 4001
                        select ex.InvestigationID;

            foreach (int id in getID)
            {
                lstId.Add(id);
            }

            if (lstId.Count > 0)
            {
                CallAbstract obj = new CallAbstract();
                ht = obj.CallCreateBioChemistry();
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
                {
                    CLogger.LogError("Error",ex);
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
            List<InvestigationValues> temp3044 = new List<InvestigationValues>();


            InvestigationValues tempObj;

            for (int i = 0; i < lstDisplayName.Count; i++)
            {

                for (int j = 0; j < investValues.Count; j++)
                {
                    if (lstDisplayName[i].InvestigationID == investValues[j].InvestigationID)
                    {
                        //Electrolyte
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3003 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3009)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues.Add(tempObj);
                        }

                        //Blood Sugar
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3011 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3014)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues1.Add(tempObj);
                        }


                        //GTT
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 3016)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Name = investValues[j].Name;
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempObj.GroupID = investValues[j].GroupID;
                            tempValues16.Add(tempObj);
                        }


                        //Renal Function
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3018 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3022 ||
                            (Convert.ToInt32(lstDisplayName[i].InvestigationID) == 3027 || Convert.ToInt32(lstDisplayName[i].InvestigationID) == 3028 ||
                            Convert.ToInt32(lstDisplayName[i].InvestigationID) == 3029))
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues2.Add(tempObj);
                        }

                        //Spot Na+,K+
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3023 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3026)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues3.Add(tempObj);
                        }

                        //Bilrubin

                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3032 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3034)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues4.Add(tempObj);
                        }

                        //Protein
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3036 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3039)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues5.Add(tempObj);
                        }

                        //Liver Function
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3040 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3044)
                        {
                            if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3044)
                            {
                                tempObj = new InvestigationValues();
                                tempObj.Value = investValues[j].Value;
                                tempObj.InvestigationName = investValues[j].InvestigationName;
                                tempObj.UOMCode = investValues[j].UOMCode;
                                temp3044.Add(tempObj);

                            }
                            else
                            {
                                tempObj = new InvestigationValues();
                                tempObj.Value = investValues[j].Value;
                                tempObj.InvestigationName = investValues[j].InvestigationName;
                                tempObj.UOMCode = investValues[j].UOMCode;
                                tempValues6.Add(tempObj);
                            }
                        }


                        //Cardiac Enzymes
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3046 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3051)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues7.Add(tempObj);
                        }


                        //Lipid Profile
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3053 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3058)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues8.Add(tempObj);
                        }

                        //General
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3060 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3070)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues9.Add(tempObj);
                        }

                        //Tumor Markers
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3071 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3076)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues10.Add(tempObj);
                        }

                        //Thyroid Profile
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3078 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3087)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues11.Add(tempObj);
                        }

                        //General
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3089 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3093)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues12.Add(tempObj);
                        }

                        //Adrenal
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3094 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3109)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues13.Add(tempObj);
                        }


                        //Sex steroids
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3112 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3125)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues14.Add(tempObj);
                        }

                        //Stool Analysis
                        if (Convert.ToInt32(lstDisplayName[i].InvestigationID) >= 3127 && Convert.ToInt32(lstDisplayName[i].InvestigationID) <= 3137)
                        {
                            tempObj = new InvestigationValues();
                            tempObj.Value = investValues[j].Value;
                            tempObj.InvestigationName = investValues[j].InvestigationName;
                            tempObj.UOMCode = investValues[j].UOMCode;
                            tempValues15.Add(tempObj);
                        }


                    }
                }
            }

            string strTime = Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_01 == null ? "Time" : Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_01;
            string strBlood = Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_02 == null ? "Blood Sugar" : Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_02;
            string strUrine = Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_03 == null ? "Urine Sugar" : Resources.Investigation_ClientDisplay.Investigation_BioChemistryDisplay_aspx_03;
            if (tempValues16.Count > 0)
            {
                Page.RegisterStartupScript("d3016", "<script>document.getElementById('BioChemistryDisplay1_d3016').style.display='block';</script>");
                Page.RegisterStartupScript("dd3016", "<script>document.getElementById('BioChemistryDisplay1_d13016').style.display='block';</script>");

                l3016.Text = tempValues16[0].InvestigationName;
                lblSugar.Text = tempValues16[0].Name;
                lblValues.Text = tempValues16[0].Value;
                lblUOM.Text = "gms";

                //rpt3016.DataSource = tempValues16;
                //rpt3016.DataBind();


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
                tc.Text = strTime.Trim();
                tr.Cells.Add(tc);

                tc = new TableCell();
                tc.Text = strBlood.Trim();
                tr.Cells.Add(tc);
                tbl.Rows.Add(tr);

                tc = new TableCell();
                tc.Text = strUrine.Trim();
                tr.Cells.Add(tc);
                tbl.Rows.Add(tr);

                pnGTT.Controls.Add(tbl);

                ArrayList lstGTT = new ArrayList();
                string temp = string.Empty;
                int i;
                int j;
                if (tempValues16.Count > 0)
                {
                    for (i = 0; i < tempValues16.Count; i++)
                    {
                        int cnt = 0;
                        for (j = 0; j < tempValues16.Count; j++)
                        {
                            if (tempValues16[i].GroupID == tempValues16[j].GroupID)
                            {
                                if (cnt == 0)
                                {
                                    temp = tempValues16[j].Value;
                                    cnt++;
                                }
                                else
                                {
                                    temp = temp + "," + tempValues16[j].Value;
                                }

                            }
                        }

                        if (!lstGTT.Contains(temp))
                        {
                            lstGTT.Add(temp);
                        }
                    }

                    for (i = 1; i < lstGTT.Count; i++)
                    {
                        string[] GTT = lstGTT[i].ToString().Split(',');
                        TableRow tr1 = new TableRow();
                        TableCell tc1;
                        tc1 = new TableCell();
                        tc1.Text = "";
                        tr1.Cells.Add(tc1);
                        tc1 = new TableCell();
                        tc1.Text = GTT[0].ToString();
                        tc1.Style["text-align"] = "center";
                        tr1.Cells.Add(tc1);
                        tc1 = new TableCell();
                        tc1.Style["text-align"] = "center";
                        tc1.Text = GTT[1].ToString();
                        tr1.Cells.Add(tc1);
                        tc1 = new TableCell();
                        tc1.Style["text-align"] = "center";
                        tc1.Text = GTT[2].ToString();
                        tr1.Cells.Add(tc1);
                        tbl.Rows.Add(tr1);
                    }

                    pnGTT.Controls.Add(tbl);
                }

            }








            rpt3002.DataSource = tempValues;
            rpt3002.DataBind();

            rpt3010.DataSource = tempValues1;
            rpt3010.DataBind();

            rpt3017.DataSource = tempValues2;
            rpt3017.DataBind();

            rpt3023.DataSource = tempValues3;
            rpt3023.DataBind();

            rpt3031.DataSource = tempValues4;
            rpt3031.DataBind();

            rpt3035.DataSource = tempValues5;
            rpt3035.DataBind();

            rpt3030.DataSource = tempValues6;
            rpt3030.DataBind();

            rpt3045.DataSource = tempValues7;
            rpt3045.DataBind();

            rpt3052.DataSource = tempValues8;
            rpt3052.DataBind();

            rpt3059.DataSource = tempValues9;
            rpt3059.DataBind();

            rpt3071.DataSource = tempValues10;
            rpt3071.DataBind();


            rpt3078.DataSource = tempValues11;
            rpt3078.DataBind();


            rpt3088.DataSource = tempValues12;
            rpt3088.DataBind();


            rpt3094.DataSource = tempValues13;
            rpt3094.DataBind();

            rpt3111.DataSource = tempValues14;
            rpt3111.DataBind();

            rpt3127.DataSource = tempValues15;
            rpt3127.DataBind();

            if (temp3044.Count > 0)
            {
                pn3044.Visible = true;
                l3044.Text = temp3044[0].InvestigationName;
                l13044.Text = temp3044[0].Value;
                l23044.Text = temp3044[1].Value;
                Uom3044.Text = temp3044[0].UOMCode;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while calling BiochemistryDisplay", ex);
        }

        return show;


    }

    public void getParent(Hashtable ht, string id)
    {
        if (ht != null)
        {
            foreach (DictionaryEntry de in ht)
            {
                if (de.Key == id)
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
