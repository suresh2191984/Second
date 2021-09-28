using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_InvestigationSearchControl : BaseControl
{
    List<PatientInvestigation> lstPat = new List<PatientInvestigation>();
    private int orgID = 0;
    string filterText = string.Empty;
    int pClientID;

  
    public int ClientID
    {
        get { return pClientID; }
        set { pClientID = value; }
    }
    public string lblPackageText
    {
       get { return lblPackage.Text; }
       set { lblPackage.Text = value; }
    } 
    protected void Page_Load(object sender, EventArgs e)
    {
               
    }

    public void LoadDatas(List<InvGroupMaster> lstGroups, List<InvestigationMaster> lstInvestigations)
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

    public void LoadLabData(List<PatientInvestigation> lstGroups
                            , List<PatientInvestigation> lstPKG
                            , List<PatientInvestigation> lstInvestigations
                            , List<LabConsumables> lstLabConsumables
                            , List<PatientInvestigation> lstPhyRates, string FilterBY)
    {


        if (lstGroups .Count() > 0)
        {
            //listGRP.Visible = true;
            listGRP.Style.Add("display", "block");
            lblGroup.Visible = true;
            listGRP.DataSource = lstGroups;
            listGRP.DataTextField = "GroupNameRate";
            listGRP.DataValueField = "GroupID";
            listGRP.DataBind();
        }

        if (lstPKG.Count() > 0)
        {
            //listPKG.Visible = true;
           //listLCON.Style.Add("display", "block");
           listPKG.Style.Add("display", "block");
            lblPackage.Visible = true;
            listPKG.DataSource = lstPKG;
            listPKG.DataTextField = "GroupNameRate";
            listPKG.DataValueField = "GroupID";
            listPKG.DataBind();
        }

        if (lstLabConsumables.Count() > 0)
        {
            //listLCON.Visible = true;
            listLCON.Style.Add("display", "block");
            lblLCON.Visible = true;
            listLCON.DataSource = lstLabConsumables;
            listLCON.DataTextField = "ConsumableNameRate";
            listLCON.DataValueField = "ConsumableID";
            listLCON.DataBind();
        }

        if (lstInvestigations.Count > 0)
        {

            if (FilterBY != "All")
            {
                //listINV.Visible = true;
                listINV.Style.Add("display", "block");
                lblInvestigation.Visible = true;
                List<PatientInvestigation> FilteredInv = new List<PatientInvestigation>();
                FilteredInv = lstInvestigations.FindAll(p => p.HeaderName == "Imaging");
                listINV.DataSource = FilteredInv;
                listINV.DataTextField = "InvestigationNameRate";
                listINV.DataValueField = "InvestigationID";
                listINV.DataBind();

                List<PatientInvestigation> labInv = new List<PatientInvestigation>();
                labInv = lstInvestigations.FindAll(p => p.HeaderName != "Imaging");
                if (labInv.Count > 0)
                {
                    listOtherInv.Style.Add("display", "block");
                    listOtherInv.Visible = true;

                    listOtherInv.DataSource = labInv;
                    listOtherInv.DataTextField = "InvestigationNameRate";
                    listOtherInv.DataValueField = "InvestigationID";
                    listOtherInv.DataBind();
                }
            }
            else
            {
                listINV.Style.Add("display", "block");
                lblInvestigation.Visible = true;
                listINV.DataSource = lstInvestigations;
                listINV.DataTextField = "InvestigationNameRate";
                listINV.DataValueField = "InvestigationID";
                listINV.DataBind();

            }
        }

        foreach (PatientInvestigation pInves in lstPhyRates)
        {
            List<PatientInvestigation> FoundInv = new List<PatientInvestigation>();
            FoundInv = lstInvestigations.FindAll(delegate(PatientInvestigation h) { return h.InvestigationID == pInves.InvestigationID; });

            if (FoundInv.Count() > 0)
            {
                HdnLPF.Value += pInves.InvestigationID + "~" + FoundInv[0].InvestigationName + "~ -"+CurrencyName+": " + pInves.Rate + "~" + pInves.Type + "^";
            }
        }
    }

    public List<PatientInvestigation> GetOrderedList()
    {
        List<PatientInvestigation> lstpatInves = new List<PatientInvestigation>();
        PatientInvestigation PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string strRate = string.Empty;
        string strInvName = string.Empty;
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

                    if (lineItems[1].Contains("-"+CurrencyName+":"))
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-"+CurrencyName+":");
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
                            PatientInves.GroupName = null;
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


   

  

    public int OrgID
    {
        get { return orgID; }
        set { orgID = value; }
    }

    public string HiddenFieldValue
    {
        get { return iconHid.Value; }
        set { iconHid.Value = value; }
    }

    public void setOrderedList(string List)
    {
        iconHid.Value = List;
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:LoadOrdItems();", true);
    }
}  
