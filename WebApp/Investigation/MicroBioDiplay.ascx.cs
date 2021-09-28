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

public partial class Investigation_InvestigationDiplay :BaseControl
{
    ArrayList lstParent = new ArrayList();
    Boolean show = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        
       
    }


    public Boolean displayMicro(List<InvestigationValues> investValues, List<InvestigationDisplayName> lstDisplayName)
    {

        try
        {

           
            Hashtable ht = null;
            ArrayList lstId = new ArrayList();
            
           


            var getID = from ex in lstDisplayName
                        where ex.InvestigationID > 1001 && ex.InvestigationID < 2001
                        select ex.InvestigationID;

            foreach (int id in getID)
            {
                lstId.Add(id);
            }

            if (lstId.Count > 0)
            {
                CallAbstract obj = new CallAbstract();
                ht = obj.CallCreateMicroBiology();
                a1002.Visible = true;
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
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error", ex);
                }
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
                {
                    CLogger.LogError("Error", ex);
                }
            }



            //if (lstId.Contains(1004))
            //{
            //    Page.RegisterStartupScript("d1004", "<script>document.getElementById('d1004').style.display='block';</script>");
            //}

            //if (lstId.Contains(1005))
            //{
            //    Page.RegisterStartupScript("d1005", "<script>document.getElementById('d1005').style.display='block';</script>");
            //}

            //if (lstId.Contains(1006))
            //{
            //    Page.RegisterStartupScript("d1006", "<script>document.getElementById('d1006').style.display='block';</script>");
            //}

            //if (lstId.Contains(1007))
            //{
            //    Page.RegisterStartupScript("d1007", "<script>document.getElementById('d1007').style.display='block';</script>");
            //}

            //if (lstId.Contains(1008))
            //{
            //    Page.RegisterStartupScript("d1008", "<script>document.getElementById('d1008').style.display='block';</script>");
            //}

            //if (lstId.Contains(1009))
            //{
            //    Page.RegisterStartupScript("d1009", "<script>document.getElementById('d1009').style.display='block';</script>");
            //}




            for (int i = 0; i < lstDisplayName.Count; i++)
            {
                var queryInvestigation = from ex in investValues
                                         where ex.InvestigationID == lstDisplayName[i].InvestigationID
                                         select ex;


                switch (lstDisplayName[i].InvestigationID)
                {
                    case 1004:
                        lblHead.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rptRubella.DataSource = queryInvestigation;
                        rptRubella.DataBind();
                        break;

                    case 1005:

                        l1005.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rpt1005.DataSource = queryInvestigation;
                        rpt1005.DataBind();
                        break;

                    case 1006:

                        l1006.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rpt1006.DataSource = queryInvestigation;
                        rpt1006.DataBind();
                        break;

                    case 1007:

                        l1007.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rpt1007.DataSource = queryInvestigation;
                        rpt1007.DataBind();
                        break;

                    case 1008:

                        l1008.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rpt1008.DataSource = queryInvestigation;
                        rpt1008.DataBind();
                        break;

                    case 1009:

                        l1009.Text = lstDisplayName[i].InvestigationName + "(" + lstDisplayName[i].Method + ")";
                        rpt1009.DataSource = queryInvestigation;
                        rpt1009.DataBind();
                        break;


                }
            }
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error on MicroBio Display", ex);
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


}
