using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;


public partial class CommonControls_InvestigationControl1 : BaseControl 
{
    List<PatientInvestigation> lstPat = new List<PatientInvestigation>();
    private int orgID = 0;
    string filterText = string.Empty;
    int pClientID;
    private string hidValue = string.Empty;
    int orgSpecific;
    protected string ishdnID = string.Empty;

    public int ClientID
    {
        get { return pClientID; }
        set { pClientID = value; }
    }

    public int OrgSpecific
    {
        get { return orgSpecific; }
        set { orgSpecific = value; }
    }
    public string lblPackageText
    {
        get { return lblPackage.Text; }
        set { lblPackage.Text = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        btnAdd.Attributes.Add("onClick", "return Validation()");
        btnInvAdd.Attributes.Add("onclick", "return Validation1()");

        AutoGname.CompletionSetCount = orgSpecific;
        AutoInvName.CompletionSetCount = orgSpecific;
        ishdnID = ISAddItems.ClientID;
        listBLB.Attributes.Add("ondblClick", "javascript:onClick1('" + listBLB.ClientID + "','" + ishdnID + "');");
        listBLB.Attributes.Add("onkeypress", "javascript:setItem(event,this, '" + ishdnID + "');");

         
        listGRP.Attributes.Add("ondblClick", "javascript:onClick1('" + listGRP.ClientID + "','" + ishdnID + "');");
        listGRP.Attributes.Add("onkeypress", "javascript:setItem(event,this, '" + ishdnID + "');");

        listINV.Attributes.Add("ondblClick", "javascript:onClick1('" + listINV.ClientID + "','" + ishdnID + "');");
        listINV.Attributes.Add("onkeypress", "javascript:setItem(event,this, '" + ishdnID + "');");

        listLCON.Attributes.Add("ondblClick", "javascript:onClick1('" + listLCON.ClientID + "','" + ishdnID + "');");
        listLCON.Attributes.Add("onkeypress", "javascript:setItem(event,this, '" + ishdnID + "');");
        //listBLB
        //listGRP
        //listINV
        //listLCON
    }

    public void LoadDatas(List<InvGroupMaster> lstGroups, List<InvestigationMaster> lstInvestigations)
    {
        if (lstGroups != null)
        {
            var Groups = from groupName in lstGroups
                         where groupName.Type == "GRP"
                         select groupName;

            if (Groups.Count() > 0)
            {
                txtGroup.Visible = true;
                btnAdd.Visible = true;
                listGRP.Visible = true;
                lblGroup.Visible = true;
                listGRP.DataSource = Groups;
                listGRP.DataTextField = "GroupName";
                listGRP.DataValueField = "GroupID";
                listGRP.DataBind();
            }


            var Blood = from groupName in lstGroups
                        where groupName.Type == "BLB"
                        select groupName;
            if (Blood.Count() > 0)
            {
                listBLB.Visible = true;
                lblBloodBank.Visible = true;
                listBLB.DataSource = Blood;
                listBLB.DataTextField = "GroupName";
                listBLB.DataValueField = "GroupID";
                listBLB.DataBind();
            }
        }
        if (lstInvestigations.Count > 0)
        {
            txtINV.Visible = true;
            btnInvAdd.Visible = true;
            listINV.Visible = true;
            lblInvestigation.Visible = true;
            listINV.DataSource = lstInvestigations;
            listINV.DataTextField = "InvestigationName";
            listINV.DataValueField = "InvestigationID";
            listINV.DataBind();
        }


    }

    public void LoadLabData(List<PatientInvestigation> lstGroups, List<PatientInvestigation> lstInvestigations)
    {
        var Groups = from groupName in lstGroups
                     where groupName.Type == "GRP"
                     select groupName;

        if (Groups.Count() > 0)
        {

            listGRP.Visible = true;
            lblGroup.Visible = true;
            listGRP.DataSource = Groups;
            listGRP.DataTextField = "GroupNameRate";
            listGRP.DataValueField = "GroupID";
            listGRP.DataBind();
        }

        var Blood = from groupName in lstGroups
                    where groupName.Type == "BLB"
                    select groupName;
        if (Blood.Count() > 0)
        {
            listBLB.Visible = true;
            lblBloodBank.Visible = true;
            listBLB.DataSource = Blood;
            listBLB.DataTextField = "GroupNameRate";
            listBLB.DataValueField = "GroupID";
            listBLB.DataBind();
        }

        if (lstInvestigations.Count > 0)
        {

            listINV.Visible = true;
            lblInvestigation.Visible = true;
            listINV.DataSource = lstInvestigations;
            listINV.DataTextField = "InvestigationNameRate";
            listINV.DataValueField = "InvestigationID";
            listINV.DataBind();
        }


    }
    public void LoadLabData(List<InvGroupMaster> lstGroups, List<InvestigationMaster> lstInvestigations)
    {
        var Groups = from groupName in lstGroups
                     where groupName.Type == "GRP"
                     select groupName;

        if (Groups.Count() > 0)
        {

            listGRP.Visible = true;
            lblGroup.Visible = true;
            listGRP.DataSource = Groups;
            listGRP.DataTextField = "GroupName";
            listGRP.DataValueField = "GroupID";
            listGRP.DataBind();
        }

        var Blood = from groupName in lstGroups
                    where groupName.Type == "BLB"
                    select groupName;
        if (Blood.Count() > 0)
        {
            listBLB.Visible = true;
            lblBloodBank.Visible = true;
            listBLB.DataSource = Blood;
            listBLB.DataTextField = "GroupName";
            listBLB.DataValueField = "GroupID";
            listBLB.DataBind();
        }

        if (lstInvestigations.Count > 0)
        {

            listINV.Visible = true;
            lblInvestigation.Visible = true;
            listINV.DataSource = lstInvestigations;
            listINV.DataTextField = "InvestigationName";
            listINV.DataValueField = "InvestigationID";
            listINV.DataBind();
        }


    }
    public void LoadLabData(List<PatientInvestigation> lstGroups, List<PatientInvestigation> lstPKG, List<PatientInvestigation> lstInvestigations, List<LabConsumables> lstLabConsumables, List<PatientInvestigation> lstPhyRates)
    {
        if (lstGroups.Count() > 0)
        {
            listGRP.Visible = true;
            lblGroup.Visible = true;
            listGRP.DataSource = lstGroups;
            listGRP.DataTextField = "GroupNameRate";
            listGRP.DataValueField = "GroupID";
            listGRP.DataBind();
        }

        if (lstPKG.Count() > 0)
        {
            listPKG.Visible = true;
            lblPackage.Visible = true;
            listPKG.DataSource = lstPKG;
            listPKG.DataTextField = "GroupNameRate";
            listPKG.DataValueField = "GroupID";
            listPKG.DataBind();
        }

        if (lstLabConsumables.Count() > 0)
        {
            listLCON.Visible = true;
            lblLCON.Visible = true;
            listLCON.DataSource = lstLabConsumables;
            listLCON.DataTextField = "ConsumableNameRate";
            listLCON.DataValueField = "ConsumableID";
            listLCON.DataBind();
        }

        if (lstInvestigations.Count > 0)
        {
            listINV.Visible = true;
            lblInvestigation.Visible = true;
            listINV.DataSource = lstInvestigations;
            listINV.DataTextField = "InvestigationNameRate";
            listINV.DataValueField = "InvestigationID";
            listINV.DataBind();
        }

        foreach (PatientInvestigation pInves in lstPhyRates)
        {
            List<PatientInvestigation> FoundInv = new List<PatientInvestigation>();
            FoundInv = lstInvestigations.FindAll(delegate(PatientInvestigation h) { return h.InvestigationID == pInves.InvestigationID; });

            if (FoundInv.Count() > 0)
            {
                HdnLPF.Value += pInves.InvestigationID + "~" + FoundInv[0].InvestigationName + "~ -" + CurrencyName + ": " + pInves.Rate + "~" + pInves.Type + "^";
            }
        }
    }

    public List<PatientInvestigation> GetOrderedList()
    {
        List<PatientInvestigation> lstpatInves = new List<PatientInvestigation>();
        PatientInvestigation PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string Drname = string.Empty;
        string Date = string.Empty;
        string iqty = string.Empty;
        string iAmt = string.Empty;
        string strInvName = string.Empty;
        string strRate = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new PatientInvestigation();

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Rate = rate;
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.InvestigationID = id;
                            PatientInves.InvestigationName = strInvName;
                        }
                        else
                        {
                            PatientInves.GroupID = Convert.ToInt32(id);
                            PatientInves.GroupName = strInvName;
                        }
                    }
                    else
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        strInvName = lineItems[1];
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.InvestigationID = id;
                            PatientInves.InvestigationName = strInvName;
                        }
                        else
                        {
                            PatientInves.GroupID = Convert.ToInt32(id);
                            PatientInves.GroupName = strInvName;
                        }
                    }
                    lstpatInves.Add(PatientInves);

                }

            }


        }

        return lstpatInves;

    }



    public List<PatientInvestigation> GetNewOrderedList()
    {
        List<PatientInvestigation> lstpatInves = new List<PatientInvestigation>();
        PatientInvestigation PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string Drname = string.Empty;
        string Date = string.Empty;
        string iqty = string.Empty;
        string iAmt = string.Empty;
        string strInvName = string.Empty;
        string strRate = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new PatientInvestigation();

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Rate = rate;
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.InvestigationID = id;
                            PatientInves.InvestigationName = strInvName;
                        }
                        else
                        {
                            PatientInves.GroupID = Convert.ToInt32(id);
                            PatientInves.GroupName = strInvName;
                        }
                    }
                    else
                    {
                        if (lineItems[1].Contains("(Not Known)"))
                        {

                            id = Convert.ToInt64(lineItems[0]);
                            int rIndex = lineItems[1].IndexOf("(Not Known)");
                            strInvName = lineItems[1].Substring(0, rIndex);
                            //strRate = lineItems[1].Substring(rIndex + 2);
                            decimal.TryParse(strRate, out rate);
                            string type = lineItems[2];
                            PatientInves.Rate = rate;
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.InvestigationID = id;
                                PatientInves.InvestigationName = strInvName;
                            }
                            else
                            {
                                PatientInves.GroupID = Convert.ToInt32(id);
                                PatientInves.GroupName = strInvName;
                            }
                        }
                        else
                        {
                            id = Convert.ToInt64(lineItems[0]);
                            strInvName = lineItems[1];
                            string type = lineItems[2];
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.InvestigationID = id;
                                PatientInves.InvestigationName = strInvName;
                            }
                            else
                            {
                                PatientInves.GroupID = Convert.ToInt32(id);
                                PatientInves.GroupName = strInvName;
                            }
                        }
                    }
                    lstpatInves.Add(PatientInves);

                }

            }


        }

        return lstpatInves;

    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        searchInvestigation();
    }

    void searchInvestigation()
    {
        filterText = txtsearch.Text;
        List<PatientInvestigation> lstGetInvestigation = new List<PatientInvestigation>();
        new Investigation_BL(base.ContextInfo).GetInvestigationByOrgID(OrgID, filterText, out lstGetInvestigation);

        if (lstGetInvestigation.Count > 0)
        {
            listINV.DataSource = lstGetInvestigation;
            listINV.DataBind();

        }
        else
        {
            listINV.Items.Clear();
            listINV.Items.Add(new ListItem("No Matching Record Found!"));
        }
    }

    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        searchInvestigation();
    }

    public int OrgID
    {
        get { return orgID; }
        set { orgID = value; }
    }

    public string HiddenFieldValue
    {
        get { return iconHid.Value; }
        set { hidValue = value; }
    }

    public void setOrderedList(string List)
    {
        lblTotal.Text = "0";
        iconHid.Value = List;
    }
    //public void loadOrderedList(List<PatientInvestigation> lstInvestigation)
    //{
    //    string orderedInv = string.Empty;
    //    int grpCount=0;


    //    var group1 = from Inves in lstInvestigation
    //                where Inves.GroupID != 0
    //                select Inves;
    //    if (group1.Count() > 0)
    //    {

    //            //var groupInv = from Inves in group1
    //            //               group Inves by new { Inves.GroupID, Inves.GroupName } into grp
    //            //               select new
    //            //               {
    //            //                   GroupID = grp.Key.GroupID,
    //            //                   GroupName = grp.Key.GroupName
    //            //               };

    //        var groupInv = from inves in group1
    //                       group inves by inves.GroupID into grp
    //                       select grp;
    //        foreach (IGrouping<Int32, PatientInvestigation> dr in groupInv)
    //        {
    //            string groupID = Convert.ToString(dr.Key);
    //            string groupName = dr.ElementAt(0).GroupName;
    //            orderedInv += groupID + "~" + groupName + "~GRP^";
    //        }

    //    }   

    //    var orderedInvList = from inv in lstInvestigation
    //                         where inv.GroupID == 0
    //                         select inv;
    //    if (orderedInvList.Count() > 0)
    //    {

    //        foreach (PatientInvestigation pInv in orderedInvList)
    //        {
    //            orderedInv += pInv.InvestigationID + "~" + pInv.InvestigationName + "~INV^";

    //        }
    //    }
    //    if (orderedInv != string.Empty)
    //    {
    //        setOrderedList(orderedInv);
    //    }
    //}
    public void loadOrderedList(List<OrderedInvestigations> lstInvestigation)
    {
        string orderedInv = string.Empty;
        int grpCount = 0;
        var group1 = from Inves in lstInvestigation
                     where Inves.GroupID != 0
                     select Inves;
        if (group1.Count() > 0)
        {

            //var groupInv = from Inves in group1
            //               group Inves by new { Inves.GroupID, Inves.GroupName } into grp
            //               select new
            //               {
            //                   GroupID = grp.Key.GroupID,
            //                   GroupName = grp.Key.GroupName
            //               };

            var groupInv = from inves in group1
                           group inves by inves.GroupID into grp
                           select grp;
            foreach (IGrouping<Int32, OrderedInvestigations> dr in groupInv)
            {
                string groupID = Convert.ToString(dr.Key);
                string groupName = dr.ElementAt(0).GroupName;
                orderedInv += groupID + "~" + groupName + "~GRP^";
            }
        }

        var orderedInvList = from inv in lstInvestigation
                             where inv.GroupID == 0
                             select inv;
        if (orderedInvList.Count() > 0)
        {

            foreach (OrderedInvestigations pInv in orderedInvList)
            {
                orderedInv += pInv.InvestigationID + "~" + pInv.InvestigationName + "~INV^";

            }
        }
        if (orderedInv != string.Empty)
        {
            setOrderedList(orderedInv);
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string orderedInv = string.Empty;

        ListItem lstInvGroupMaster = new ListItem();

        ListItem lst = new ListItem(txtGroup.Text);

        if (listGRP.Items.FindByText(lst.Text) != null)
        {
            if (!iconHid.Value.Contains(listGRP.SelectedValue.ToString() + "~" + txtGroup.Text + "~GRP^"))
            {
                listGRP.Items.FindByText(txtGroup.Text).Selected = true;
                orderedInv = iconHid.Value;
                orderedInv += listGRP.SelectedValue.ToString() + "~" + txtGroup.Text + "~GRP^";
                listGRP.Items.FindByText(txtGroup.Text).Selected = false;
                iconHid.Value = orderedInv;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:LoadOrdItems();", true);
            }
            else
            {
                orderedInv = iconHid.Value;
                txtGroup.Text = "";
                iconHid.Value = orderedInv;
                string sPath = "CommonControl\\\\InvestigationControl.ascx_1";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('"+sPath +"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey3", "javascript:LoadOrdItems();", true);
            }
        }
        else
        {
            orderedInv = iconHid.Value;
            txtGroup.Text = "";
            iconHid.Value = orderedInv;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey4", "javascript:LoadOrdItems();", true);
        }
        txtGroup.Text = "";
    }
    protected void btnInvAdd_Click(object sender, EventArgs e)
    {
        string orderedInv = string.Empty;
        ListItem lstInvestigationMaster = new ListItem();

        ListItem lInv = new ListItem(txtINV.Text);

        if (listINV.Items.FindByText(lInv.Text) != null)
        {
            if (!iconHid.Value.Contains(listINV.SelectedValue.ToString() + "~" + txtINV.Text + "~INV^"))
            {
                listINV.Items.FindByText(txtINV.Text).Selected = true;
                orderedInv = iconHid.Value;
                orderedInv += listINV.SelectedValue.ToString() + "~" + txtINV.Text + "~INV^";
                listINV.Items.FindByText(txtINV.Text).Selected = false;
                iconHid.Value = orderedInv;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:LoadOrdItems();", true);
            }
            else
            {
                orderedInv = iconHid.Value;
                txtINV.Text = "";
                iconHid.Value = orderedInv;
                string sPath = "CommonControl\\\\InvestigationControl.ascx_1";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:ShowAlertMsg('"+ sPath +"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey3", "javascript:LoadOrdItems();", true);
            }
        }
        else
        {
            orderedInv = iconHid.Value;
            txtINV.Text = "";
            iconHid.Value = orderedInv;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey4", "javascript:LoadOrdItems();", true);
        }
        txtINV.Text = "";
    }

    public List<OrderedInvestigations> GetINVListHOSLAB() // This Method is for Order Investigation
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string Drname = string.Empty;
        string Date = string.Empty;
        string iqty = string.Empty;
        string iAmt = string.Empty;
        string strInvName = string.Empty;
        string strRate = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {
                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Rate = rate;
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.ID = id;
                            PatientInves.Name = strInvName;
                        }
                        else
                        {
                            PatientInves.ID = Convert.ToInt32(id);
                            PatientInves.Name = strInvName;
                        }
                    }
                    else
                    {
                        if (lineItems[1].Contains("(NA)"))
                        {

                            //id = Convert.ToInt64(lineItems[0]);
                            //int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                            //strInvName = lineItems[1].Substring(0, rIndex);
                            //strRate = lineItems[1].Substring(rIndex + 4);
                            //decimal.TryParse(strRate, out rate);
                            //string type = lineItems[2];
                            //PatientInves.Rate = rate;
                            //PatientInves.Type = type;
                            //if (type.ToUpper() == "INV")
                            //{
                            //    PatientInves.ID = id;
                            //    PatientInves.Name = strInvName;
                            //}
                            //else
                            //{
                            //    PatientInves.ID = Convert.ToInt32(id);
                            //    PatientInves.Name = strInvName;
                            //}
                            id = Convert.ToInt64(lineItems[0]);
                            int rIndex = lineItems[1].IndexOf("(NA)");
                            strInvName = lineItems[1].Substring(0, rIndex);
                            //strRate = lineItems[1].Substring(rIndex + 2);
                            decimal.TryParse(strRate, out rate);
                            string type = lineItems[2];
                            PatientInves.Rate = rate;
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.ID = id;
                                PatientInves.Name = strInvName;
                            }
                            else
                            {
                                PatientInves.ID = Convert.ToInt32(id);
                                PatientInves.Name = strInvName;
                            }
                        }
                        else
                        {

                            id = Convert.ToInt64(lineItems[0]);
                            strInvName = lineItems[1];
                            string type = lineItems[2];
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.ID = id;
                                PatientInves.Name = strInvName;
                            }
                            else
                            {
                                PatientInves.ID = Convert.ToInt32(id);
                                PatientInves.Name = strInvName;
                            }
                        }
                    }
                    lstpatInves.Add(PatientInves);

                }

            }
        }
        return lstpatInves;
    }

    public List<OrderedInvestigations> GetNewOrderedListHOSLAB()
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string Drname = string.Empty;
        string Date = string.Empty;
        string iqty = string.Empty;
        string iAmt = string.Empty;
        string strInvName = string.Empty;
        string strRate = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();
                    PatientInves.CreatedAt = Convert.ToDateTime(hdnFromDate.Value.ToString());

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {
                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Rate = rate;
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.ID = id;
                            PatientInves.Name = strInvName;
                        }
                        else
                        {
                            PatientInves.ID = Convert.ToInt32(id);
                            PatientInves.Name = strInvName;
                        }
                    }
                    else
                    {
                        if (lineItems[1].Contains("(Not Known)"))
                        {

                            id = Convert.ToInt64(lineItems[0]);
                            int rIndex = lineItems[1].IndexOf("(Not Known)");
                            strInvName = lineItems[1].Substring(0, rIndex);
                            //strRate = lineItems[1].Substring(rIndex + 2);
                            decimal.TryParse(strRate, out rate);
                            string type = lineItems[2];
                            PatientInves.Rate = rate;
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.ID = id;
                                PatientInves.Name = strInvName;
                            }
                            else
                            {
                                PatientInves.ID = Convert.ToInt32(id);
                                PatientInves.Name = strInvName;
                            }
                        }
                        else
                        {
                            id = Convert.ToInt64(lineItems[0]);
                            strInvName = lineItems[1];
                            string type = lineItems[2];
                            PatientInves.Type = type;
                            if (type.ToUpper() == "INV")
                            {
                                PatientInves.ID = id;
                                PatientInves.Name = strInvName;
                            }
                            else
                            {
                                PatientInves.ID = Convert.ToInt32(id);
                                PatientInves.Name = strInvName;
                            }
                        }
                    }
                    lstpatInves.Add(PatientInves);
                }
            }
        }
        return lstpatInves;
    }




    public void loadOrderedList(List<OrderedInvestigations> lstInv, List<OrderedInvestigations> lstGrp)
    {
        string orderedInv = string.Empty;

        foreach (OrderedInvestigations objOrderedGrp in lstGrp)
        {
            orderedInv += objOrderedGrp.ID + "~" + objOrderedGrp.Name + "~GRP^";
        }

        foreach (OrderedInvestigations objOrderedInv in lstInv)
        {
            orderedInv += objOrderedInv.ID + "~" + objOrderedInv.Name + "~INV^";

        }

        if (orderedInv != string.Empty)
        {
            setOrderedList(orderedInv);
        }
    }
}  

