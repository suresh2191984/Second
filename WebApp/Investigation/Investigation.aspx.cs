using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class Investigation_Investigation : BasePage
{
    ArrayList childList = new ArrayList();
    ArrayList parentList = new ArrayList();
    public int save = 0;
    public int isEmpty = 0;
    public long patientVisitId = 2;
    public int completed = 0;
    int selTaskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] != null && Request.QueryString["tid"]!=null)
        {
            patientVisitId = Convert.ToInt32(Request.QueryString["vid"]);
            selTaskID = Convert.ToInt32(Request.QueryString["tid"]);
        }

        //GTT

        if (pn3015.Enabled == true)
        {
            Table tbl = new Table();
            TableCell cell;
            TableRow tr;
            int testCount = Convert.ToInt32(t13015.Text);
            tr = new TableRow();
            DateTime time = Convert.ToDateTime(ddlStartTime.SelectedItem.Text + " " + ddlampm.SelectedItem.Text);
            pn3016.Controls.Clear();

            // Create table Header Name 
            cell = new TableCell();
            Label lblTime = new Label();
            lblTime.Text = "Time <br /> (in hrs)";
            lblTime.CssClass = "label_title";
            cell.Width = 100;
            cell.Style["style"] = "align:center";
            cell.Controls.Add(lblTime);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            Label lblBloodSugar = new Label();
            lblBloodSugar.Text = "Blood Sugar <br /> (in mg/dl)";
            lblBloodSugar.CssClass = "label_title";
            cell.Controls.Add(lblBloodSugar);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            Label lblUrineSugar = new Label();
            lblUrineSugar.Text = "Urine Sugar <br /> (in mg/dl)";
            lblUrineSugar.CssClass = "label_title";
            cell.Controls.Add(lblUrineSugar);
            tr.Controls.Add(cell);

            tbl.Controls.Add(tr);

            tbl.GridLines = GridLines.Both;
            tbl.Style.Add("align", "center");

            for (int i = 0, j = 1; i < testCount; i++, j++)
            {
                DateTime addTime = time.AddMinutes(Convert.ToDouble(ddlTimeInterval.SelectedItem.Text) * j);
                tr = new TableRow();
                cell = new TableCell();
                cell.Width = 100;
                TextBox txt = new TextBox();
                txt.Text = addTime.ToShortTimeString();
                txt.ID = "t" + j.ToString() + "13015";
                txt.CssClass = "textbox_hemat";
                txt.ReadOnly = true;
                cell.Controls.Add(txt);
                tr.Controls.Add(cell);

                cell = new TableCell();
                cell.Width = 100;
                TextBox txt1 = new TextBox();
                txt1.ID = "t" + j.ToString() + "23015";
                txt1.CssClass = "textbox_hemat";
                cell.Controls.Add(txt1);
                tr.Controls.Add(cell);

                cell = new TableCell();
                cell.Width = 100;
                TextBox txt2 = new TextBox();
                txt2.ID = "t" + j.ToString() + "33015";
                txt2.CssClass = "textbox_hemat";
                cell.Controls.Add(txt2);
                tr.Controls.Add(cell);

                tbl.Controls.Add(tr);
            }

            pn3016.Controls.Add(tbl);
        }
        if (!Page.IsPostBack)
        {
            try
            {
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                List<Patient> lstPatient = new List<Patient>();
                //investigationBL.getInvestigationId(patientVisitId, out lstPatientInvestigation, out lstPatient);
                loadList(lstPatientInvestigation, lstPatient);
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error while Investigation Pageload", ex);
            }
           
        }
    }


    public void loadList(List<PatientInvestigation> lstPatientInvetigation, List<Patient> lstPatient)
    {
        try
        {
            CallAbstract obj = new CallAbstract();
            Hashtable ht = null;
            int[] arrlst = new int[lstPatientInvetigation.Count];
            int count = 0;


            for (int temp = 0; temp < lstPatientInvetigation.Count; temp++)
            {
                string InvestigationID = lstPatientInvetigation[temp].InvestigationID.ToString();
                arrlst[temp] = Convert.ToInt32(InvestigationID);

            }

            //Check range between 1000 to 2000- create microbiology
            var range = from n in arrlst
                        where n > 1000 && n < 2001
                        select n;
            foreach (int s in range)
            {
                count++;
                break;
            }

            if (count > 0)
            {
                ht = obj.CallCreateMicroBiology();
                loadMicro(ht, lstPatientInvetigation, lstPatient);
            }

            //Check range between 2000 to 3000- createHematology
            count = 0;
            var range1 = from n in arrlst
                         where n > 2000 && n < 3001
                         select n;
            foreach (int s in range1)
            {
                count++;
                break;
            }

            if (count > 0)
            {
                ht = obj.CallCreateHemotology();
                loadMicro(ht, lstPatientInvetigation, lstPatient);
            }

            //Check range between 3000 to 4000- createBiochemistry
            count = 0;
            var range2 = from n in arrlst
                         where n > 3000 && n < 4001
                         select n;
            foreach (int s in range2)
            {
                count++;
                break;
            }


            if (count > 0)
            {
                ht = obj.CallCreateBioChemistry();
                loadMicro(ht, lstPatientInvetigation, lstPatient);

            }


            //Check range between 4000 to 5000- createClinicalPathology
            count = 0;
            var range3 = from n in arrlst
                         where n > 4000 && n < 5001
                         select n;
            foreach (int s in range3)
            {
                count++;
                break;
            }


            if (count > 0)
            {

                ht = obj.CallClinicalPathology();
                loadMicro(ht, lstPatientInvetigation, lstPatient);

            }


            ViewState["SaveID"] = childList;
            ViewState["Parent"] = parentList;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Loadlist in Investigation", ex);
        }

    }


    public void loadMicro(Hashtable ht, List<PatientInvestigation> lstPatientInvetigation, List<Patient> lstPatient)
    {

        try
        {


            for (int i = 0; i < lstPatientInvetigation.Count; i++)
            {

                if (!childList.Contains(lstPatientInvetigation[i].InvestigationID.ToString()))
                {
                    childList.Add(lstPatientInvetigation[i].InvestigationID.ToString());
                }



                //Add all the Investigation Id into Childlist from hashtable
                if (ht != null)
                {
                    foreach (DictionaryEntry de in ht)
                    {
                        if (de.Value == lstPatientInvetigation[i].InvestigationID.ToString())
                        {
                            if (!childList.Contains(de.Key.ToString()))
                            {
                                childList.Add(de.Key.ToString());
                            }
                            getChild(ht, de.Key.ToString());
                        }
                    }
                }

            }


            //Add all the Parent Id into Parenlist from hashtable
            for (int i = 0; i < lstPatientInvetigation.Count; i++)
            {

                if (ht != null)
                {
                    foreach (DictionaryEntry de in ht)
                    {
                        if (de.Key != "")
                        {
                            if (Convert.ToInt32(de.Key) == lstPatientInvetigation[i].InvestigationID)
                            {
                                if (!parentList.Contains(de.Value.ToString()))
                                {
                                    parentList.Add(de.Value.ToString());
                                }
                                getParent(ht, de.Value.ToString());
                            }
                        }
                    }
                }

            }



            //Enable the Panel
            foreach (string parent in parentList)
            {
                if (visibleControl(parent, "tp", 0, ""))
                {
                    foreach (string controls in childList)
                    {
                        if (visibleControl(controls, "pn", 1, "tp" + parent))
                        {
                            Panel pn = (Panel)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls);
                            pn.Enabled = true;
                        }
                    }
                }
            }




            //Enable the appropriate Div

            if (parentList.Contains("1003"))
            {
                tp1001.Enabled = true;
                a1002.Visible = true;
                Page.RegisterStartupScript("d1002", "<script>document.getElementById('d1002').style.display='block';</script>");
            }



            if (parentList.Contains("2001"))
            {
                tp2001.Enabled = true;
            }



            if (parentList.Contains("2004"))
            {
                a2004.Visible = true;
                Page.RegisterStartupScript("d2004", "<script>document.getElementById('d2004').style.display='block';</script>");
            }




            if (parentList.Contains("2017"))
            {
                a2016.Visible = true;
                a2017.Visible = true;
                Page.RegisterStartupScript("d2016", "<script>document.getElementById('d2016').style.display='block';</script>");
                Page.RegisterStartupScript("d2017", "<script>document.getElementById('d2017').style.display='block';</script>");
            }


            if (parentList.Contains("2023"))
            {
                a2016.Visible = true;
                a2023.Visible = true;
                Page.RegisterStartupScript("d2023", "<script>document.getElementById('d2023').style.display='block';</script>");
                Page.RegisterStartupScript("d2016", "<script>document.getElementById('d2016').style.display='block';</script>");

            }


            if (parentList.Contains("2027"))
            {
                a2016.Visible = true;
                a2027.Visible = true;
                Page.RegisterStartupScript("d2027", "<script>document.getElementById('d2027').style.display='block';</script>");
                Page.RegisterStartupScript("d2016", "<script>document.getElementById('d2016').style.display='block';</script>");

            }

            if (parentList.Contains("2036"))
            {
                a2036.Visible = true;
                Page.RegisterStartupScript("d2036", "<script>document.getElementById('d2036').style.display='block';</script>");
            }


            if (parentList.Contains("2042"))
            {
                a2042.Visible = true;
                Page.RegisterStartupScript("d2042", "<script>document.getElementById('d2042').style.display='block';</script>");
            }



            if (parentList.Contains("3001"))
            {
                tp3001.Enabled = true;
            }


            if (parentList.Contains("3002"))
            {
                a3002.Visible = true;
                Page.RegisterStartupScript("d3002", "<script>document.getElementById('d3002').style.display='block';</script>");
            }


            if (parentList.Contains("3010"))
            {
                a3010.Visible = true;
                Page.RegisterStartupScript("d3010", "<script>document.getElementById('d3010').style.display='block';</script>");
            }


            if (childList.Contains("3016"))
            {
                pn3015.Enabled = true;
                Page.RegisterStartupScript("d3015", "<script>document.getElementById('d3015').style.display='block';</script>");
            }


            if (parentList.Contains("3017"))
            {
                a3017.Visible = true;
                Page.RegisterStartupScript("d3017", "<script>document.getElementById('d3017').style.display='block';</script>");
            }

            if (parentList.Contains("3023"))
            {
                a3023.Visible = true;
                Page.RegisterStartupScript("d3023", "<script>document.getElementById('d3023').style.display='block';</script>");
            }


            if (parentList.Contains("3127"))
            {
                a3127.Visible = true;
                Page.RegisterStartupScript("d3127", "<script>document.getElementById('d3127').style.display='block';</script>");
            }



            if (parentList.Contains("3031"))
            {
                a3031.Visible = true;
                Page.RegisterStartupScript("d3031", "<script>document.getElementById('d3031').style.display='block';</script>");
            }



            if (parentList.Contains("3035"))
            {
                a3035.Visible = true;
                Page.RegisterStartupScript("d3035", "<script>document.getElementById('d3035').style.display='block';</script>");
            }

            if (parentList.Contains("3030"))
            {
                a3030.Visible = true;
                Page.RegisterStartupScript("d3030", "<script>document.getElementById('d3030').style.display='block';</script>");
            }


            if (parentList.Contains("3045"))
            {
                a3045.Visible = true;
                Page.RegisterStartupScript("d3045", "<script>document.getElementById('d3045').style.display='block';</script>");
            }

            if (parentList.Contains("3052"))
            {
                a3052.Visible = true;
                Page.RegisterStartupScript("d3052", "<script>document.getElementById('d3052').style.display='block';</script>");
            }


            if (parentList.Contains("3059"))
            {
                a3059.Visible = true;
                Page.RegisterStartupScript("d3059", "<script>document.getElementById('d3059').style.display='block';</script>");
            }



            if (parentList.Contains("3071"))
            {
                a3071.Visible = true;
                Page.RegisterStartupScript("d3071", "<script>document.getElementById('d3071').style.display='block';</script>");
            }

            if (parentList.Contains("3077"))
            {
                a3077.Visible = true;
                Page.RegisterStartupScript("d3077", "<script>document.getElementById('d3077').style.display='block';</script>");
            }

            if (parentList.Contains("3078"))
            {
                a3078.Visible = true;
                Page.RegisterStartupScript("d3078", "<script>document.getElementById('d3078').style.display='block';</script>");
            }

            if (parentList.Contains("3088"))
            {
                a3088.Visible = true;
                Page.RegisterStartupScript("d3088", "<script>document.getElementById('d3088').style.display='block';</script>");
            }

            if (parentList.Contains("3094"))
            {
                a3094.Visible = true;
                Page.RegisterStartupScript("d3094", "<script>document.getElementById('d3094').style.display='block';</script>");
            }

            if (parentList.Contains("3111"))
            {
                a3111.Visible = true;
                Page.RegisterStartupScript("d3111", "<script>document.getElementById('d3111').style.display='block';</script>");
            }








            if (parentList.Contains("3125"))
            {
                a3111.Visible = true;
                Page.RegisterStartupScript("d3111", "<script>document.getElementById('d3111').style.display='block';</script>");
            }




            if (parentList.Contains("4001"))
            {
                tp4001.Enabled = true;
            }


            if (parentList.Contains("4002"))
            {
                a4002.Visible = true;
                Page.RegisterStartupScript("d4002", "<script>document.getElementById('d4002').style.display='block';</script>");
            }

            if (parentList.Contains("4006"))
            {
                a4006.Visible = true;
                Page.RegisterStartupScript("d4006", "<script>document.getElementById('d4006').style.display='block';</script>");
            }


            if (parentList.Contains("4013"))
            {
                a4013.Visible = true;
                Page.RegisterStartupScript("d4013", "<script>document.getElementById('d4013').style.display='block';</script>");
            }



            if (parentList.Contains("4025"))
            {
                a4025.Visible = true;
                Page.RegisterStartupScript("d4025", "<script>document.getElementById('d4025').style.display='block';</script>");
            }


            if (parentList.Contains("4032"))
            {
                a4032.Visible = true;
                Page.RegisterStartupScript("d4032", "<script>document.getElementById('d4032').style.display='block';</script>");
            }


            if (parentList.Contains("4034"))
            {
                a4034.Visible = true;
                Page.RegisterStartupScript("d4034", "<script>document.getElementById('d4034').style.display='block';</script>");
            }

            if (parentList.Contains("4045"))
            {
                a4045.Visible = true;
                Page.RegisterStartupScript("d4045", "<script>document.getElementById('d4045').style.display='block';</script>");
            }


            if (parentList.Contains("4050"))
            {
                a4050.Visible = true;
                Page.RegisterStartupScript("d4045", "<script>document.getElementById('d4050').style.display='block';</script>");
            }

            if (parentList.Contains("4053"))
            {
                a4053.Visible = true;
                Page.RegisterStartupScript("d4053", "<script>document.getElementById('d4053').style.display='block';</script>");
            }


            if (parentList.Contains("4059"))
            {
                a4059.Visible = true;
                Page.RegisterStartupScript("d4059", "<script>document.getElementById('d4059').style.display='block';</script>");
            }

            if (parentList.Contains("4066"))
            {
                a4066.Visible = true;
                Page.RegisterStartupScript("d4066", "<script>document.getElementById('d4066').style.display='block';</script>");
            }

            if (parentList.Contains("4073"))
            {
                a4073.Visible = true;
                Page.RegisterStartupScript("d4066", "<script>document.getElementById('d4073').style.display='block';</script>");
            }


            if (parentList.Contains("4078"))
            {
                a4078.Visible = true;
                Page.RegisterStartupScript("d4078", "<script>document.getElementById('d4078').style.display='block';</script>");
            }




            //if (parentList.Contains("4078"))
            //{
            //    a4078.Visible = true;
            //    Page.RegisterStartupScript("d4078", "<script>document.getElementById('d4078').style.display='block';</script>");
            //}

            if (parentList.Contains("4082"))
            {
                a4082.Visible = true;
                Page.RegisterStartupScript("d4082", "<script>document.getElementById('d4082').style.display='block';</script>");
            }


            if (parentList.Contains("4083"))
            {
                a4083.Visible = true;
                Page.RegisterStartupScript("d4083", "<script>document.getElementById('d4083').style.display='block';</script>");
            }


            if (parentList.Contains("4093"))
            {
                a4093.Visible = true;
                pn4094.Enabled = true;
                Page.RegisterStartupScript("d4093", "<script>document.getElementById('d4093').style.display='block';</script>");
            }

            if (parentList.Contains("4096"))
            {
                a4096.Visible = true;
                Page.RegisterStartupScript("d4096", "<script>document.getElementById('d4096').style.display='block';</script>");
            }

            if (parentList.Contains("4099"))
            {
                a4099.Visible = true;
                Page.RegisterStartupScript("d4099", "<script>document.getElementById('d4099').style.display='block';</script>");
            }


            if (parentList.Contains("4102"))
            {
                a4102.Visible = true;
                Page.RegisterStartupScript("d4102", "<script>document.getElementById('d4102').style.display='block';</script>");
            }


            if (parentList.Contains("4103"))
            {
                a4102.Visible = true;
                Page.RegisterStartupScript("d4103", "<script>document.getElementById('d4103').style.display='block';</script>");
            }

            if (parentList.Contains("4109"))
            {
                a4109.Visible = true;
                Page.RegisterStartupScript("d4109", "<script>document.getElementById('d4109').style.display='block';</script>");
            }

            if (parentList.Contains("4111"))
            {
                a4111.Visible = true;
                Page.RegisterStartupScript("d4111", "<script>document.getElementById('d4111').style.display='block';</script>");
            }


            if (parentList.Contains("4117"))
            {
                a4117.Visible = true;
                Page.RegisterStartupScript("d4117", "<script>document.getElementById('d4117').style.display='block';</script>");
            }

            if (parentList.Contains("4086"))
            {

                pn4086.Enabled = true;
                r4086.Items[1].Selected = true;
                Page.RegisterStartupScript("divHepat", "<script>document.getElementById('divHepat').style.display='block';</script>");
            }

            if (parentList.Contains("4011"))
            {
                pn4011.Enabled = true;
            }





            if (childList.Contains("2043"))
            {
                if (dd2043.Items.Count == 0)
                {

                    for (int i = 0; i < 13; i++)
                    {
                        if (i < 10)
                        {
                            dd2043.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2043.Items.Add(i.ToString());
                        }
                    }

                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd12043.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd12043.Items.Add(i.ToString());
                        }
                    }
                }
            }

            if (childList.Contains("2045"))
            {
                if (dd2045.Items.Count == 0)
                {
                    for (int i = 0; i < 13; i++)
                    {
                        if (i < 10)
                        {
                            dd2045.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2045.Items.Add(i.ToString());
                        }
                    }

                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd12045.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd12045.Items.Add(i.ToString());
                        }
                    }
                }
            }


            if (childList.Contains("2047"))
            {

                if (dd2047.Items.Count == 0)
                {
                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd2047.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2047.Items.Add(i.ToString());
                        }
                    }
                }
            }

            if (childList.Contains("2049"))
            {
                if (dd2049.Items.Count == 0)
                {

                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd2049.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2049.Items.Add(i.ToString());
                        }
                    }
                }
            }

            if (childList.Contains("2053"))
            {

                if (dd2053.Items.Count == 0)
                {
                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd2053.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2053.Items.Add(i.ToString());
                        }
                    }
                }
            }

            if (childList.Contains("2054"))
            {

                if (dd2054.Items.Count == 0)
                {
                    for (int i = 0; i < 60; i++)
                    {
                        if (i < 10)
                        {
                            dd2054.Items.Add("0" + i.ToString());
                        }
                        else
                        {
                            dd2054.Items.Add(i.ToString());
                        }
                    }
                }
            }




            if (childList.Contains("3117"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {
                        Page.RegisterStartupScript("d3117", "<script>document.getElementById('d3117').style.display='block';</script>");
                    }
                }

            }


            if (childList.Contains("3118"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {
                        //t3117.Visible = false;
                        Page.RegisterStartupScript("dd3118", "<script>document.getElementById('d3118').style.display='block';</script>");
                    }
                }
            }

            if (childList.Contains("3119"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {
                        Page.RegisterStartupScript("dd3119", "<script>document.getElementById('d3119').style.display='block';</script>");

                    }
                }

            }

            if (childList.Contains("3120"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {

                        Page.RegisterStartupScript("dd3120", "<script>document.getElementById('d3120').style.display='block';</script>");

                    }
                }
            }

            if (childList.Contains("3122"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {

                        Page.RegisterStartupScript("dd3122", "<script>document.getElementById('d3122').style.display='block';</script>");

                    }
                }
            }


            if (childList.Contains("3123"))
            {
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SEX == "F")
                    {

                        Page.RegisterStartupScript("dd3123", "<script>document.getElementById('d3123').style.display='block';</script>");

                    }
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("error while loading Investigation", ex);
        }

    }


    //Check whether the control with given id exist or not
    public Boolean visibleControl(string id, string ctrl, int check, string parent)
    {
        bool result = false;
        try
        {
            if (check == 0)
            {
                if (tabContain.FindControl(ctrl + id).Controls.Count > 0)

                    result = true;

            }
            else if (check == 1)
            {
                if (tabContain.FindControl(parent).Controls[0].FindControl(ctrl + id).Controls.Count > 0)
                    result = true;
            }

        }
        catch (Exception ex)
        {
            result = false;
        }
        return result;
    }


    //public Boolean checkPanel(string tctrl, string tid, string pctrl, string ctrl, string id)
    //{

    //    bool result = false;
    //    try
    //    {
    //        if (tabContain.FindControl(tctrl + tid).Controls[0].FindControl(pctrl + id).FindControl(ctrl + id).Controls.Count > 0)
    //            result = true;
    //    }
    //    catch (Exception ex)
    //    {

    //    }

    //    return result;
    //}

    public void getChild(Hashtable ht, string id)
    {

        try
        {
            if (ht != null)
            {
                foreach (DictionaryEntry de in ht)
                {
                    if (de.Value == id.ToString())
                    {
                        if (!childList.Contains(de.Key.ToString()))
                        {
                            childList.Add(de.Key.ToString());
                        }
                        getChild(ht, de.Key.ToString());
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading getChild() in Investigation", ex);
        }

    }

    public void getParent(Hashtable ht, string id)
    {

        try
        {

            if (ht != null)
            {
                foreach (DictionaryEntry de in ht)
                {
                    if (de.Key == id.ToString())
                    {
                        if (!parentList.Contains(de.Value.ToString()))
                        {
                            parentList.Add(de.Value.ToString());
                        }
                        getParent(ht, de.Value.ToString());
                    }
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading getParent() in Investigation", ex);
        }


    }

    protected void btnSaveMicro_Click(object sender, EventArgs e)
    {

        try
        {


            ArrayList parentlst = new ArrayList();
            ArrayList childlst = new ArrayList();

            ArrayList parentlst1 = new ArrayList();
            ArrayList childlst1 = new ArrayList();

            parentlst = (ArrayList)ViewState["Parent"];
            childlst = (ArrayList)ViewState["SaveID"];
            isEmpty = 0;





            for (int temp = 0; temp < childlst.Count; temp++)
            {
                if (Convert.ToInt16(childlst[temp]) > 1000 && Convert.ToInt16(childlst[temp]) < 2000)
                {
                    childlst1.Add(Convert.ToString(childlst[temp]));
                }

            }

            for (int temp = 0; temp < parentlst.Count; temp++)
            {
                if (Convert.ToString(parentlst[temp]) != "")
                {
                    if (Convert.ToInt16(parentlst[temp]) > 1000 && Convert.ToInt16(parentlst[temp]) < 2000)
                    {
                        parentlst1.Add(Convert.ToString(parentlst[temp]));
                    }
                }

            }


            List<PatientInvestigation> lstInvestigationMethod = new List<PatientInvestigation>();

            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            PatientInvestigation investigationObj;

            for (int i = 0; i < childlst1.Count; i++)
            {
                investigationObj = new PatientInvestigation();
                investigationObj.InvestigationID = Convert.ToInt32(childlst1[i]);
                investigationObj.PatientVisitID = patientVisitId;
                lstInvestigation.Add(investigationObj);
            }



            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Name");
            dt.Columns.Add("Value");
            dt.Columns.Add("InvestigationID");
            dt.Columns.Add("GroupID");
            dt.Columns.Add("PatientVisitID");
            dt.Columns.Add("UOMID");



            foreach (string parent in parentlst1)
            {
                if (visibleControl(parent, "tp", 0, ""))
                {
                    foreach (string controls in childlst1)
                    {
                        if (visibleControl(controls, "pn", 1, "tp" + parent))
                        {

                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls).Controls.Count >= 0)
                                {
                                    DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                    DataRow dr = dt.NewRow();
                                    dr["Name"] = "Source";
                                    dr["Value"] = ddl1.SelectedItem.Text;
                                    dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr["GroupID"] = null;
                                    dr["PatientVisitID"] = patientVisitId;
                                    dr["UOMID"] = 0;
                                    dt.Rows.Add(dr);
                                }
                            }
                            catch (Exception ex) { }
                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls).Controls.Count >= 0)
                                {
                                    DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls);

                                    PatientInvestigation patientInvObj = new PatientInvestigation();
                                    patientInvObj.PatientVisitID = patientVisitId;
                                    patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                    patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl2.SelectedValue);
                                    lstInvestigationMethod.Add(patientInvObj);

                                }
                            }
                            catch (Exception ex) { }

                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd3" + controls).Controls.Count >= 0)
                                {
                                    DropDownList ddl3 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd3" + controls);

                                    if (ddl3.SelectedIndex == 1)
                                    {
                                        //DataRow dr = dt.NewRow();

                                        //dr["Name"] = "Result";
                                        //dr["Value"] = ddl3.SelectedItem.Text;
                                        //dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        //dr["GroupID"] = null;
                                        //dr["PatientVisitID"] = patientVisitId;
                                        //dr["UOMID"] = null;
                                        //dt.Rows.Add(dr);


                                        TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Result";
                                        dr2["Value"] = txtbox.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);

                                        DropDownList ddl4 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd4" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl4.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = 0;
                                        dt.Rows.Add(dr1);

                                    }
                                    else if (ddl3.SelectedIndex == 2)
                                    {

                                        DropDownList ddl4 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd4" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl4.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = 0;
                                        dt.Rows.Add(dr1);

                                    }

                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please Select value from Result')</script>", false);
                                        break;
                                    }


                                }
                            }
                            catch (Exception ex) { }
                        }
                    }
                }
            }



            if (isEmpty == 0)
            {
                ViewState["Result"] = dt;
                DataTable dtMicro = new DataTable();
                dtMicro = (DataTable)ViewState["Result"];

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                int resultStatus = -1;
                //investigationBL.saveInvestigationValues(dtMicro, lstInvestigation, lstInvestigationMethod, out resultStatus, out completed);
                if (resultStatus == 1)
                {
                    lblSave.Text = "Successfully Saved";
                    if (completed == 0)
                    {
                        Tasks task = new Tasks();
                        task.TaskActionID = selTaskID;
                        task.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
                        task.ModifiedBy = LID;
                        new Tasks_BL(base.ContextInfo).UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
                    }
                }
                else
                {
                    lblSave.Text = "Error Occurred";
                }
                save++;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Microbilogy", ex);
        }

    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {

        Table tbl = new Table();
        TableCell cell;
        TableRow tr;
        int testCount = Convert.ToInt32(t13015.Text);
        tr = new TableRow();
        DateTime time = Convert.ToDateTime(ddlStartTime.SelectedItem.Text + " " + ddlampm.SelectedItem.Text);
        pn3016.Controls.Clear();

        // Create table Header Name 
        cell = new TableCell();
        Label lblTime = new Label();
        lblTime.Text = "Time <br /> (in hrs)";
        lblTime.CssClass = "label_title";
        cell.Width = 100;
        cell.Style["style"] = "align:center";
        cell.Controls.Add(lblTime);
        tr.Controls.Add(cell);

        cell = new TableCell();
        cell.Width = 100;
        Label lblBloodSugar = new Label();
        lblBloodSugar.Text = "Blood Sugar <br /> (in mg/dl)";
        lblBloodSugar.CssClass = "label_title";
        cell.Controls.Add(lblBloodSugar);
        tr.Controls.Add(cell);

        cell = new TableCell();
        cell.Width = 100;
        Label lblUrineSugar = new Label();
        lblUrineSugar.Text = "Urine Sugar <br /> (in mg/dl)";
        lblUrineSugar.CssClass = "label_title";
        cell.Controls.Add(lblUrineSugar);
        tr.Controls.Add(cell);

        tbl.Controls.Add(tr);

        tbl.GridLines = GridLines.Both;
        tbl.Style.Add("align", "center");

        // Create Dynamic Text control
        for (int i = 0, j = 1; i < testCount; i++, j++)
        {
            DateTime addTime = time.AddMinutes(Convert.ToDouble(ddlTimeInterval.SelectedItem.Text) * j);
            tr = new TableRow();
            cell = new TableCell();
            cell.Width = 100;
            TextBox txt = new TextBox();
            txt.Text = addTime.ToShortTimeString();
            txt.ID = "t" + j.ToString() + "13015";
            txt.CssClass = "textbox_hemat";
            txt.ReadOnly = true;
            cell.Controls.Add(txt);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            TextBox txt1 = new TextBox();
            txt1.ID = "t" + j.ToString() + "23015";
            txt1.CssClass = "textbox_hemat";
            cell.Controls.Add(txt1);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            TextBox txt2 = new TextBox();
            txt2.ID = "t" + j.ToString() + "33015";
            txt2.CssClass = "textbox_hemat";
            cell.Controls.Add(txt2);
            tr.Controls.Add(cell);

            tbl.Controls.Add(tr);
        }

        pn3016.Controls.Add(tbl);
    }

    protected void btnSaveClinic_Click(object sender, EventArgs e)
    {

        try
        {

            ArrayList parentlst = new ArrayList();
            ArrayList childlst = new ArrayList();

            ArrayList parentlst1 = new ArrayList();
            ArrayList childlst1 = new ArrayList();

            parentlst = (ArrayList)ViewState["Parent"];
            childlst = (ArrayList)ViewState["SaveID"];
            isEmpty = 0;





            for (int temp = 0; temp < childlst.Count; temp++)
            {
                if (Convert.ToInt16(childlst[temp]) > 4000 && Convert.ToInt16(childlst[temp]) < 5000)
                {
                    childlst1.Add(Convert.ToString(childlst[temp]));
                }

            }

            for (int temp = 0; temp < parentlst.Count; temp++)
            {
                if (Convert.ToString(parentlst[temp]) != "")
                {
                    if (Convert.ToInt16(parentlst[temp]) > 4000 && Convert.ToInt16(parentlst[temp]) < 5000)
                    {
                        parentlst1.Add(Convert.ToString(parentlst[temp]));
                    }
                }

            }



            List<PatientInvestigation> lstInvestigationMethod = new List<PatientInvestigation>();

            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            PatientInvestigation investigationObj;

            for (int i = 0; i < childlst1.Count; i++)
            {
                investigationObj = new PatientInvestigation();
                investigationObj.InvestigationID = Convert.ToInt32(childlst1[i]);
                investigationObj.PatientVisitID = patientVisitId;
                lstInvestigation.Add(investigationObj);
            }



            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Name");
            dt.Columns.Add("Value");
            dt.Columns.Add("InvestigationID");
            dt.Columns.Add("GroupID");
            dt.Columns.Add("PatientVisitID");
            dt.Columns.Add("UOMID");



            foreach (string parent in parentlst1)
            {
                if (visibleControl(parent, "tp", 0, ""))
                {
                    foreach (string controls in childlst1)
                    {
                        if (visibleControl(controls, "pn", 1, "tp" + parent))
                        {


                            try
                            {

                                //Anti TB IGg,Igm,IgA
                                if (controls == "4070")
                                {
                                    TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                    DataRow dr2 = dt.NewRow();
                                    dr2["Name"] = "Result";
                                    if (txtbox.Text != "")
                                    {
                                        dr2["Value"] = txtbox.Text;
                                    }
                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                        break;
                                    }
                                    dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr2["GroupID"] = null;
                                    dr2["PatientVisitID"] = patientVisitId;
                                    dr2["UOMID"] = null;
                                    dt.Rows.Add(dr2);

                                    DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                    DataRow dr = dt.NewRow();
                                    dr["Name"] = "Result";
                                    dr["Value"] = ddl1.SelectedItem.Text;
                                    dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr["GroupID"] = null;
                                    dr["PatientVisitID"] = patientVisitId;
                                    dr["UOMID"] = null;
                                    dt.Rows.Add(dr);
                                    continue;

                                }

                                if (controls == "4071")
                                {
                                    TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                    DataRow dr2 = dt.NewRow();
                                    dr2["Name"] = "Result";
                                    if (txtbox.Text != "")
                                    {
                                        dr2["Value"] = txtbox.Text;
                                    }
                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                        break;
                                    }
                                    dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr2["GroupID"] = null;
                                    dr2["PatientVisitID"] = patientVisitId;
                                    dr2["UOMID"] = null;
                                    dt.Rows.Add(dr2);

                                    DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                    DataRow dr = dt.NewRow();
                                    dr["Name"] = "Result";
                                    dr["Value"] = ddl1.SelectedItem.Text;
                                    dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr["GroupID"] = null;
                                    dr["PatientVisitID"] = patientVisitId;
                                    dr["UOMID"] = null;
                                    dt.Rows.Add(dr);
                                    continue;


                                }

                                if (controls == "4072")
                                {
                                    TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                    DataRow dr2 = dt.NewRow();
                                    dr2["Name"] = "Result";
                                    if (txtbox.Text != "")
                                    {
                                        dr2["Value"] = txtbox.Text;
                                    }
                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                        break;
                                    }
                                    dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr2["GroupID"] = null;
                                    dr2["PatientVisitID"] = patientVisitId;
                                    dr2["UOMID"] = null;
                                    dt.Rows.Add(dr2);

                                    DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                    DataRow dr = dt.NewRow();
                                    dr["Name"] = "Result";
                                    dr["Value"] = ddl1.SelectedItem.Text;
                                    dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr["GroupID"] = null;
                                    dr["PatientVisitID"] = patientVisitId;
                                    dr["UOMID"] = null;
                                    dt.Rows.Add(dr);
                                    continue;


                                }
                            }
                            catch (Exception ex)
                            { }
                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls).Controls.Count >= 0)
                                {
                                    //HIV1,HIV2
                                    if (controls == "4084")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);

                                        PatientInvestigation patientInvObj = new PatientInvestigation();
                                        patientInvObj.PatientVisitID = patientVisitId;
                                        patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                        patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl1.SelectedValue);
                                        lstInvestigationMethod.Add(patientInvObj);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "4085")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        PatientInvestigation patientInvObj = new PatientInvestigation();
                                        patientInvObj.PatientVisitID = patientVisitId;
                                        patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                        patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl1.SelectedValue);
                                        lstInvestigationMethod.Add(patientInvObj);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "4121")
                                    {

                                        Label lblName = (Label)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("l" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Typhi H";
                                        dr2["Value"] = lblName.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);



                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Dilution";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "4122")
                                    {


                                        Label lblName = (Label)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("l" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Typhi O";
                                        dr2["Value"] = lblName.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);

                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Dilution";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "4123")
                                    {



                                        Label lblName = (Label)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("l" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Paratyphi H";
                                        dr2["Value"] = lblName.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);

                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Dilution";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "4124")
                                    {

                                        Label lblName = (Label)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("l" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Paratyphi O";
                                        dr2["Value"] = lblName.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);


                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Dilution";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }

                                        //ANA
                                    else if (controls == "4097")
                                    {

                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Result";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);

                                        DropDownList ddl3 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Result";
                                        dr2["Value"] = ddl3.SelectedItem.Text;
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);
                                    }
                                    //ASO
                                    else if (controls == "4091")
                                    {

                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Result";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);


                                    }

                                        //TPHA
                                    else if (controls == "4092")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Source";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        PatientInvestigation patientInvObj = new PatientInvestigation();
                                        patientInvObj.PatientVisitID = patientVisitId;
                                        patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                        patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl2.SelectedValue);
                                        lstInvestigationMethod.Add(patientInvObj);


                                        DropDownList ddl3 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls);
                                        DataRow dr3 = dt.NewRow();
                                        dr3["Name"] = "Result";
                                        dr3["Value"] = ddl3.SelectedItem.Text;
                                        dr3["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr3["GroupID"] = null;
                                        dr3["PatientVisitID"] = patientVisitId;
                                        dr3["UOMID"] = null;
                                        dt.Rows.Add(dr3);
                                    }
                                    //LeptoSpira 
                                    else if (controls == "4087")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Source";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = 0;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        PatientInvestigation patientInvObj = new PatientInvestigation();
                                        patientInvObj.PatientVisitID = patientVisitId;
                                        patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                        patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl2.SelectedValue);
                                        lstInvestigationMethod.Add(patientInvObj);

                                        DropDownList ddl3 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls);
                                        DataRow dr3 = dt.NewRow();
                                        dr3["Name"] = "Result";
                                        dr3["Value"] = ddl3.SelectedItem.Text;
                                        dr3["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr3["GroupID"] = null;
                                        dr3["PatientVisitID"] = patientVisitId;
                                        dr3["UOMID"] = 0;
                                        dt.Rows.Add(dr3);

                                        DropDownList ddl4 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd3" + controls);
                                        DataRow dr4 = dt.NewRow();
                                        dr4["Name"] = "Result";
                                        dr4["Value"] = ddl3.SelectedItem.Text;
                                        dr4["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr4["GroupID"] = null;
                                        dr4["PatientVisitID"] = patientVisitId;
                                        dr4["UOMID"] = 0;
                                        dt.Rows.Add(dr4);

                                        TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        DataRow dr5 = dt.NewRow();
                                        dr5["Name"] = "Result";
                                        if (txtbox.Text != "")
                                        {
                                            dr5["Value"] = txtbox.Text;
                                        }
                                        else
                                        {
                                            isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                            break;
                                        }
                                        dr5["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr5["GroupID"] = null;
                                        dr5["PatientVisitID"] = patientVisitId;
                                        dr5["UOMID"] = null;
                                        dt.Rows.Add(dr5);
                                    }

                                    else if (controls == "4088")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Source";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = 0;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        PatientInvestigation patientInvObj = new PatientInvestigation();
                                        patientInvObj.PatientVisitID = patientVisitId;
                                        patientInvObj.InvestigationID = Convert.ToInt16(controls.ToString());
                                        patientInvObj.InvestigationMethodID = Convert.ToInt32(ddl2.SelectedValue);
                                        lstInvestigationMethod.Add(patientInvObj);

                                        DropDownList ddl3 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd2" + controls);
                                        DataRow dr3 = dt.NewRow();
                                        dr3["Name"] = "Result";
                                        dr3["Value"] = ddl3.SelectedItem.Text;
                                        dr3["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr3["GroupID"] = null;
                                        dr3["PatientVisitID"] = patientVisitId;
                                        dr3["UOMID"] = 0;
                                        dt.Rows.Add(dr3);

                                        DropDownList ddl4 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd3" + controls);
                                        DataRow dr4 = dt.NewRow();
                                        dr4["Name"] = "Result";
                                        dr4["Value"] = ddl3.SelectedItem.Text;
                                        dr4["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr4["GroupID"] = null;
                                        dr4["PatientVisitID"] = patientVisitId;
                                        dr4["UOMID"] = 0;
                                        dt.Rows.Add(dr4);

                                        TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        DataRow dr5 = dt.NewRow();
                                        dr5["Name"] = "Result";
                                        if (txtbox.Text != "")
                                        {
                                            dr5["Value"] = txtbox.Text;
                                        }
                                        else
                                        {
                                            isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                            break;
                                        }
                                        dr5["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr5["GroupID"] = null;
                                        dr5["PatientVisitID"] = patientVisitId;
                                        dr5["UOMID"] = null;
                                        dt.Rows.Add(dr5);
                                    }
                                    else
                                    {

                                        if (controls != "4075")
                                        {
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = 0;
                                            dt.Rows.Add(dr);
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            { }
                            try
                            {

                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls).Controls.Count >= 0)
                                {
                                    TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                    DataRow dr2 = dt.NewRow();
                                    dr2["Name"] = "Result";
                                    if (txtbox.Text != "")
                                    {
                                        dr2["Value"] = txtbox.Text;
                                    }
                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                        break;
                                    }
                                    dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr2["GroupID"] = null;
                                    dr2["PatientVisitID"] = patientVisitId;
                                    dr2["UOMID"] = null;
                                    dt.Rows.Add(dr2);
                                }


                            }
                            catch (Exception ex)
                            { }

                            try
                            {

                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("c" + controls).Controls.Count >= 0)
                                {


                                    CheckBox chkbox = (CheckBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("c" + controls);
                                    DataRow dr2 = dt.NewRow();
                                    dr2["Name"] = "Result";
                                    if (chkbox.Checked)
                                    {
                                        dr2["Value"] = "Present";
                                    }
                                    else
                                    {
                                        dr2["Value"] = "Absent";
                                        //DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        //DataRow dr = dt.NewRow();
                                        //dr["Name"] = "Result";
                                        //dr["Value"] = ddl1.SelectedItem.Text;
                                        //dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        //dr["GroupID"] = null;
                                        //dr["PatientVisitID"] = patientVisitId;
                                        //dr["UOMID"] = null;
                                        //dt.Rows.Add(dr);
                                    }

                                    dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr2["GroupID"] = null;
                                    dr2["PatientVisitID"] = patientVisitId;
                                    dr2["UOMID"] = null;
                                    dt.Rows.Add(dr2);
                                }
                            }
                            catch (Exception ex)
                            { }
                            try
                            {

                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls).Controls.Count >= 0)
                                {
                                    //Malignant
                                    if (controls == "4075")
                                    {
                                        RadioButtonList rdobtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Result";
                                        if (rdobtn.Items[0].Selected)
                                        {
                                            dr2["Value"] = "Absent";
                                        }
                                        if (rdobtn.Items[1].Selected)
                                        {
                                            dr2["Value"] = "Present";

                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = null;
                                            dt.Rows.Add(dr);

                                        }
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);
                                    }
                                    //Epithelial
                                    if (controls == "4074")
                                    {
                                        RadioButtonList rdobtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Result";
                                        if (rdobtn.Items[0].Selected)
                                        {
                                            dr2["Value"] = "Absent";
                                        }
                                        if (rdobtn.Items[1].Selected)
                                        {
                                            dr2["Value"] = "Present";
                                        }

                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);
                                    }

                                    //Normal
                                    if (controls == "4076")
                                    {
                                        RadioButtonList rdobtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "Result";
                                        if (rdobtn.Items[0].Selected)
                                        {
                                            dr2["Value"] = "Absent";
                                        }
                                        if (rdobtn.Items[1].Selected)
                                        {
                                            dr2["Value"] = "Present";
                                        }

                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = null;
                                        dt.Rows.Add(dr2);
                                    }

                                }


                            }
                            catch (Exception ex)
                            { }

                        }
                    }
                }
            }




            if (isEmpty == 0)
            {
                ViewState["Result"] = dt;
                DataTable dtMicro = new DataTable();
                dtMicro = (DataTable)ViewState["Result"];
                long result = -1;

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                int resultStatus = -1;
//                result = investigationBL.saveInvestigationValues(dtMicro, lstInvestigation, lstInvestigationMethod, out resultStatus, out completed);
                if (completed == 0)
                {
                    lblMicroMsg.Text = "Saved Successfully";
                    Tasks task = new Tasks();
                    task.TaskActionID = selTaskID;
                    task.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
                    task.ModifiedBy = LID;
                    new Tasks_BL(base.ContextInfo).UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
                }
                else
                {
                    lblMicroMsg.Text = "Error Occurred";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving clinical pathology", ex);
        }

    }

    protected void btnSaveBio_Click(object sender, EventArgs e)
    {


        try
        {

            ArrayList parentlst = new ArrayList();
            ArrayList childlst = new ArrayList();

            ArrayList parentlst1 = new ArrayList();
            ArrayList childlst1 = new ArrayList();

            parentlst = (ArrayList)ViewState["Parent"];
            childlst = (ArrayList)ViewState["SaveID"];
            isEmpty = 0;






            for (int temp = 0; temp < childlst.Count; temp++)
            {
                if (Convert.ToInt16(childlst[temp]) > 3000 && Convert.ToInt16(childlst[temp]) < 4000)
                {
                    childlst1.Add(Convert.ToString(childlst[temp]));
                }

            }

            for (int temp = 0; temp < parentlst.Count; temp++)
            {
                if (Convert.ToString(parentlst[temp]) != "")
                {
                    if (Convert.ToInt16(parentlst[temp]) > 3000 && Convert.ToInt16(parentlst[temp]) < 4000)
                    {
                        parentlst1.Add(Convert.ToString(parentlst[temp]));
                    }
                }

            }



            List<PatientInvestigation> lstInvestigationMethod = new List<PatientInvestigation>();

            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            PatientInvestigation investigationObj;

            for (int i = 0; i < childlst1.Count; i++)
            {
                investigationObj = new PatientInvestigation();
                investigationObj.InvestigationID = Convert.ToInt32(childlst1[i]);
                investigationObj.PatientVisitID = patientVisitId;
                lstInvestigation.Add(investigationObj);
            }




            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Name");
            dt.Columns.Add("Value");
            dt.Columns.Add("InvestigationID");
            dt.Columns.Add("GroupID");
            dt.Columns.Add("PatientVisitID");
            dt.Columns.Add("UOMID");


            foreach (string parent in parentlst1)
            {
                if (visibleControl(parent, "tp", 0, ""))
                {
                    foreach (string controls in childlst1)
                    {
                        if (visibleControl(controls, "pn", 1, "tp" + parent))
                        {

                            //GTT
                            if (controls == "3016")
                            {
                                DataRow dr1 = dt.NewRow();
                                dr1["Name"] = "Sugar Grams";
                                dr1["Value"] = t43015.Text;
                                dr1["InvestigationID"] = "3016";
                                dr1["GroupID"] = null;
                                dr1["PatientVisitID"] = patientVisitId;
                                dr1["UOMID"] = null;
                                dt.Rows.Add(dr1);

                                if (t13015.Text != "")
                                {
                                    for (int i = 1; i <= Convert.ToInt16(t13015.Text); i++)
                                    {
                                        if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + i + "13015").Controls.Count >= 0)
                                        {
                                            TextBox txtbox1 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + i + "13015");
                                            TextBox txtbox2 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + i + "23015");
                                            TextBox txtbox3 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + i + "33015");

                                            DataRow dr2 = dt.NewRow();
                                            dr2["Name"] = "Time";
                                            dr2["Value"] = txtbox1.Text;
                                            dr2["InvestigationID"] = "3016";
                                            dr2["GroupID"] = i;
                                            dr2["PatientVisitID"] = patientVisitId;
                                            dr2["UOMID"] = null;
                                            dt.Rows.Add(dr2);

                                            DataRow dr3 = dt.NewRow();
                                            dr3["Name"] = "Blood Sugar";
                                            dr3["Value"] = txtbox2.Text;
                                            dr3["InvestigationID"] = "3016";
                                            dr3["GroupID"] = i;
                                            dr3["PatientVisitID"] = patientVisitId;
                                            dr3["UOMID"] = null;
                                            dt.Rows.Add(dr3);


                                            DataRow dr4 = dt.NewRow();
                                            dr4["Name"] = "Urine Sugar";
                                            dr4["Value"] = txtbox3.Text;
                                            dr4["InvestigationID"] = "3016";
                                            dr4["GroupID"] = i;
                                            dr4["PatientVisitID"] = patientVisitId;
                                            dr4["UOMID"] = null;
                                            dt.Rows.Add(dr4);

                                        }
                                    }
                                }

                            }
                            else
                            {

                                try
                                {
                                    if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls).Controls.Count >= 0)
                                    {
                                        if (controls == "3126")
                                        {
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = null;
                                            dt.Rows.Add(dr);


                                            DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            dr1["Value"] = ddl2.SelectedItem.Text;
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);
                                        }
                                        //Acid phosphate
                                        //else if (controls == "3044")
                                        //{
                                        //    DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        //    DataRow dr = dt.NewRow();
                                        //    dr["Name"] = "Result";
                                        //    dr["Value"] = ddl1.SelectedItem.Text;
                                        //    dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        //    dr["GroupID"] = null;
                                        //    dr["PatientVisitID"] = patientVisitId;
                                        //    dr["UOMID"] = null;
                                        //    dt.Rows.Add(dr);

                                        //    //TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        //    //DataRow dr1 = dt.NewRow();
                                        //    //dr1["Name"] = "Result";
                                        //    //if (txtbox.Text != "")
                                        //    //{
                                        //    //    dr1["Value"] = txtbox.Text;
                                        //    //}
                                        //    //else
                                        //    //{
                                        //    //    isEmpty = 1;
                //    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                        //    //    break;
                                        //    //}
                                        //    //dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        //    //dr1["GroupID"] = null;
                                        //    //dr1["PatientVisitID"] = patientVisitId;
                                        //    //dr1["UOMID"] = null;
                                        //    //dt.Rows.Add(dr1);

                                        //}
                                        else if (controls == "3117")
                                        {
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = 0;
                                            dt.Rows.Add(dr);

                                        }
                                       
                                        if (controls != "3046" && controls != "3047" && controls != "3117" && controls != "3126")
                                        {

                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = 0;
                                            dt.Rows.Add(dr);
                                        }
                                    }

                                }
                                catch (Exception ex)
                                { }


                                try
                                {
                                    if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls).Controls.Count >= 0)
                                    {
                                        //Troponine T
                                        if (controls == "3047")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);

                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = null;
                                            dt.Rows.Add(dr);

                                        }

                                        else if (controls == "3046")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);

                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr = dt.NewRow();
                                            dr["Name"] = "Result";
                                            dr["Value"] = ddl1.SelectedItem.Text;
                                            dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr["GroupID"] = null;
                                            dr["PatientVisitID"] = patientVisitId;
                                            dr["UOMID"] = null;
                                            dt.Rows.Add(dr);
                                        }

                                        else if (controls == "3117")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);
                                        }

                                        else if (controls == "3024")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);

                                            TextBox txtbox1 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t1" + controls);
                                            DataRow dr2 = dt.NewRow();
                                            dr2["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr2["Value"] = txtbox1.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr2["GroupID"] = null;
                                            dr2["PatientVisitID"] = patientVisitId;
                                            dr2["UOMID"] = null;
                                            dt.Rows.Add(dr2);
                                        }
                                        else if (controls == "3025")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);

                                            TextBox txtbox1 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t1" + controls);
                                            DataRow dr2 = dt.NewRow();
                                            dr2["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr2["Value"] = txtbox1.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr2["GroupID"] = null;
                                            dr2["PatientVisitID"] = patientVisitId;
                                            dr2["UOMID"] = null;
                                            dt.Rows.Add(dr2);


                                        }
                                        else if (controls == "3026")
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);

                                            TextBox txtbox1 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t1" + controls);
                                            DataRow dr2 = dt.NewRow();
                                            dr2["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr2["Value"] = txtbox1.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr2["GroupID"] = null;
                                            dr2["PatientVisitID"] = patientVisitId;
                                            dr2["UOMID"] = null;
                                            dt.Rows.Add(dr2);

                                        }


                                        else
                                        {
                                            TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            if (txtbox.Text != "")
                                            {
                                                dr1["Value"] = txtbox.Text;
                                            }
                                            else
                                            {
                                                isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                                break;
                                            }
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);
                                        }

                                    }
                                }

                                catch (Exception ex)
                                {

                                }

                            }
                        }
                    }
                }
            }


            if (isEmpty == 0)
            {
                ViewState["Result"] = dt;
                DataTable dtMicro = new DataTable();
                dtMicro = (DataTable)ViewState["Result"];

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                int resultStatus = -1;
                //investigationBL.saveInvestigationValues(dtMicro, lstInvestigation, lstInvestigationMethod, out resultStatus, out completed);
                if (resultStatus == 1)
                {

                    lblMsgBio.Text = "Successfully Saved";
                    if (completed ==0)
                    {
                        Tasks task = new Tasks();
                        task.TaskActionID = selTaskID;
                        task.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
                        task.ModifiedBy = LID;
                        new Tasks_BL(base.ContextInfo).UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
                    }

                }
                else
                {
                    lblSave.Text = "Error Occurred";
                    lblMsgBio.Text = "Error Occurred";
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Biochemistry", ex);
        }
    }


    protected void btnSaveHemat_Click(object sender, EventArgs e)
    {

        try
        {

            ArrayList parentlst = new ArrayList();
            ArrayList childlst = new ArrayList();

            ArrayList parentlst1 = new ArrayList();
            ArrayList childlst1 = new ArrayList();

            parentlst = (ArrayList)ViewState["Parent"];
            childlst = (ArrayList)ViewState["SaveID"];
            isEmpty = 0;






            for (int temp = 0; temp < childlst.Count; temp++)
            {
                if (Convert.ToInt16(childlst[temp]) > 2000 && Convert.ToInt16(childlst[temp]) < 3000)
                {
                    childlst1.Add(Convert.ToString(childlst[temp]));
                }

            }

            for (int temp = 0; temp < parentlst.Count; temp++)
            {
                if (Convert.ToString(parentlst[temp]) != "")
                {
                    if (Convert.ToInt16(parentlst[temp]) > 2000 && Convert.ToInt16(parentlst[temp]) < 3000)
                    {
                        parentlst1.Add(Convert.ToString(parentlst[temp]));
                    }
                }

            }


            List<PatientInvestigation> lstInvestigationMethod = new List<PatientInvestigation>();

            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            PatientInvestigation investigationObj;

            for (int i = 0; i < childlst1.Count; i++)
            {
                investigationObj = new PatientInvestigation();
                investigationObj.InvestigationID = Convert.ToInt32(childlst1[i]);
                investigationObj.PatientVisitID = patientVisitId;
                lstInvestigation.Add(investigationObj);
            }



            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Name");
            dt.Columns.Add("Value");
            dt.Columns.Add("InvestigationID");
            dt.Columns.Add("GroupID");
            dt.Columns.Add("PatientVisitID");
            dt.Columns.Add("UOMID");


            foreach (string parent in parentlst1)
            {
                if (visibleControl(parent, "tp", 0, ""))
                {
                    foreach (string controls in childlst1)
                    {
                        if (visibleControl(controls, "pn", 1, "tp" + parent))
                        {

                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls).Controls.Count >= 0)
                                {

                                    if (controls == "2013")
                                    {
                                        TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "ESR";
                                        if (txtbox.Text != "")
                                        {
                                            dr1["Value"] = txtbox.Text;
                                        }
                                        else
                                        {
                                            isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                            break;
                                        }
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = 10;
                                        dt.Rows.Add(dr1);

                                        TextBox txtbox1 = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t1" + controls);
                                        DataRow dr2 = dt.NewRow();
                                        dr2["Name"] = "ESR";
                                        if (txtbox.Text != "")
                                        {
                                            dr2["Value"] = txtbox.Text;
                                        }
                                        else
                                        {
                                            isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                            break;
                                        }
                                        dr2["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr2["GroupID"] = null;
                                        dr2["PatientVisitID"] = patientVisitId;
                                        dr2["UOMID"] = 11;
                                        dt.Rows.Add(dr2);

                                    }
                                    else
                                    {
                                        TextBox txtbox = (TextBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("t" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Result";
                                        if (txtbox.Text != "")
                                        {
                                            dr1["Value"] = txtbox.Text;
                                        }
                                        else
                                        {

                                            isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please fill all the values')</script>", false);
                                            break;
                                        }
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                }
                            }

                            catch (Exception ex)
                            { }

                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls).Controls.Count >= 0)
                                {

                                    if (controls == "2037")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Direct";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "Direct";
                                        dr1["Value"] = ddl2.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);


                                    }
                                    else if (controls == "2038")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "InDirect";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);

                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr1 = dt.NewRow();
                                        dr1["Name"] = "InDirect";
                                        dr1["Value"] = ddl1.SelectedItem.Text;
                                        dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr1["GroupID"] = null;
                                        dr1["PatientVisitID"] = patientVisitId;
                                        dr1["UOMID"] = null;
                                        dt.Rows.Add(dr1);
                                    }
                                    else if (controls == "2043")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "BleedingTime";
                                        dr["Value"] = ddl1.SelectedItem.Text + ddl2.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2045")
                                    {
                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DropDownList ddl2 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd1" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Clotting Time";
                                        dr["Value"] = ddl1.SelectedItem.Text + ddl2.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }

                                    else if (controls != "2041" && controls != "2030" && controls != "2019")
                                    {

                                        DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Result";
                                        dr["Value"] = ddl1.SelectedItem.Text;
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }

                                }
                            }
                            catch (Exception ex)
                            { }

                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls).Controls.Count >= 0)
                                {

                                    if (controls == "2018")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Morphology";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Normal";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Abnormal";
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            dr1["Value"] = ddl1.SelectedItem.Text;
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);


                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }



                                    else if (controls == "2019")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Distribution";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Normal";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Abnormal";
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            dr1["Value"] = ddl1.SelectedItem.Text;
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);


                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2024")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Distribution";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Normal";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Abnormal";
                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2025")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "ImmatureCells";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Absent";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Present";
                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2026")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "MalignantCells";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Absent";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Present";
                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2030")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Parasites";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "None";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Present";
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            dr1["Value"] = ddl1.SelectedItem.Text;
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);
                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }
                                    else if (controls == "2041")
                                    {
                                        RadioButtonList rdoBtn = (RadioButtonList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("r" + controls);
                                        DataRow dr = dt.NewRow();
                                        dr["Name"] = "Hb.Electrophoresis";
                                        if (rdoBtn.Items[0].Selected)
                                        {
                                            dr["Value"] = "Normal";
                                        }
                                        else
                                        {
                                            dr["Value"] = "Abnormal";
                                            DropDownList ddl1 = (DropDownList)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("dd" + controls);
                                            DataRow dr1 = dt.NewRow();
                                            dr1["Name"] = "Result";
                                            dr1["Value"] = ddl1.SelectedItem.Text;
                                            dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                            dr1["GroupID"] = null;
                                            dr1["PatientVisitID"] = patientVisitId;
                                            dr1["UOMID"] = null;
                                            dt.Rows.Add(dr1);
                                        }
                                        dr["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                        dr["GroupID"] = null;
                                        dr["PatientVisitID"] = patientVisitId;
                                        dr["UOMID"] = null;
                                        dt.Rows.Add(dr);
                                    }





                                }
                            }
                            catch (Exception ex)
                            { }


                            try
                            {
                                if (tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("c" + controls).Controls.Count >= 0)
                                {
                                    CheckBox chkBox = (CheckBox)tabContain.FindControl("tp" + parent).Controls[0].FindControl("pn" + controls).FindControl("c" + controls);
                                    DataRow dr1 = dt.NewRow();
                                    dr1["Name"] = "Anisocytosis";
                                    if (chkBox.Checked)
                                    {
                                        dr1["Value"] = "Present";
                                    }
                                    else
                                    {
                                        isEmpty = 1;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please check all the values')</script>", false);
                                        break;
                                    }
                                    dr1["InvestigationID"] = Convert.ToInt16(controls.ToString());
                                    dr1["GroupID"] = null;
                                    dr1["PatientVisitID"] = patientVisitId;
                                    dr1["UOMID"] = null;
                                    dt.Rows.Add(dr1);
                                }

                            }
                            catch (Exception ex)
                            { }



                        }
                    }
                }
            }

            if (isEmpty == 0)
            {
                ViewState["Result"] = dt;
                DataTable dtMicro = new DataTable();
                dtMicro = (DataTable)ViewState["Result"];

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                int resultStatus = -1;
//                investigationBL.saveInvestigationValues(dtMicro, lstInvestigation, lstInvestigationMethod, out resultStatus, out completed);
                if (resultStatus == 1)
                {
                    lblShowHemat.Text = "Successfully Saved";
                    if (completed == 0)
                    {
                        Tasks task = new Tasks();
                        task.TaskActionID = selTaskID;
                        task.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
                        task.ModifiedBy = LID;
                        new Tasks_BL(base.ContextInfo).UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
                    }

                }
                else
                {
                    lblShowHemat.Text = "Error Occurred";
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Hematalogy", ex);
        }

    }


    protected void btnCancelHemat_Click(object sender, EventArgs e)
    { 
       
    }


    protected void t2002_TextChanged(object sender, EventArgs e)
    {

    }
}
