using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.Caching;

public partial class CommonControls_Profile : BaseControl
{
    string investigationList = string.Empty;
    List<PatientInvestigation> lstInvesGroup = new List<PatientInvestigation>();
    List<PatientInvestigation> lstPackage = new List<PatientInvestigation>();
    private int orgID = 0;
    long returnCode;
    long visitID = 0;
    long patientVisitId;
   
    public long PatientVisitID
    {
        get { return patientVisitId; }
        set { patientVisitId = value; }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lblStatus.Visible = false;
            if (!IsPostBack)
            {
                //Load Group Investigations
                
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationProfile(OrgID, "grp", out lstInvesGroup);
                var groupname = from invname in lstInvesGroup
                                group invname by invname.GroupID into grp
                                select grp;
                List<PatientInvestigation> lstGroupnames = new List<PatientInvestigation>();

                foreach (IGrouping<int, PatientInvestigation> grp in groupname)
                {
                    PatientInvestigation lstGroup = new PatientInvestigation();
                    lstGroup.GroupID = grp.Key;

                    lstGroup.GroupName = grp.ElementAt(0).GroupName;
                    lstGroupnames.Add(lstGroup);

                }
                if (lstGroupnames.Count > 0)
                {
                    dprf.Visible = true;
                    datalst.DataSource = lstGroupnames;
                    datalst.DataBind();
                }
                else
                {
                    dprf.Visible = false;
                }
                hidValue.Value = "1";
                string[] arr = null;
                arr = new TaskHelper().Alphabets();
                List<Alphabets> lstalpha = new List<Alphabets>();

                foreach (string ltr in arr)
                {
                    Alphabets aplha = new Alphabets();
                    aplha.Alpha = ltr;
                    lstalpha.Add(aplha);

                }
                rptName.DataSource = lstalpha;
                rptName.DataBind();

                if (Session["PatientVisitID"] != null)
                {
                    visitID = Convert.ToInt64(Session["PatientVisitID"]);
                }
                else if (Request.QueryString["vid"] != null)
                {
                    visitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                if (visitID != 0)
                {
                    Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                    List<PatientInvestigation> ordInvestigaton = new List<PatientInvestigation>();
                    investigationBL.GetInvestigationSample(visitID, out ordInvestigaton);
                    if (ordInvestigaton.Count > 0)
                    {
                        LoadInvestigation(ordInvestigaton);
                    }

                }
                    
               //Load Package investigation

                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationProfile(OrgID, "pkg", out lstPackage);
                var packageName = from invname in lstPackage
                                  group invname by invname.GroupID into grp
                                  select grp;
                List<PatientInvestigation> lstPackages = new List<PatientInvestigation>();

                foreach (IGrouping<int, PatientInvestigation> grp in packageName)
                {
                    PatientInvestigation lstGroup = new PatientInvestigation();
                    lstGroup.GroupID = grp.Key;

                    lstGroup.GroupName = grp.ElementAt(0).GroupName;
                    lstPackages.Add(lstGroup);

                }
                if (lstPackages.Count > 0)
                {
                    dpkg.Style.Add("display", "block");
                    dtPackage.DataSource = lstPackages;
                    dtPackage.DataBind();
                }
                else
                {
                    dpkg.Style.Add("display", "none");

                }

            }

            if (ViewState["invList"] != null)
            {
                investigationList = ViewState["invList"].ToString();
                SetInvestigationList();

            }
          
            //string scriptKey = string.Format(System.Globalization.CultureInfo.InvariantCulture, "__{0}_{1}",
            //                  this.ClientID, "ClientSideStartupScript");

            //string style = Request.Cookies["displayvalue"].Value.ToString();


            //if (!this.Page.IsStartupScriptRegistered(scriptKey))
            //{

            string style = hidValue.Value;
            string functionName = string.Empty;

            if (style == "1")
            {
                functionName = "showInv";

            }
            else if (style == "2")
            {
                functionName = "showProfile";
            }
            else if (style == "3")
            {
                functionName = "showPackage";
            }

            //StringBuilder javaScript = new StringBuilder();
            //javaScript.Append("\n<script type=text/javascript>\n");
            //javaScript.Append("<!--\n");
            //javaScript.Append("addLoadListener("+ functionName +");\n");
            //javaScript.Append("// -->\n");
            //javaScript.Append("</script>\n");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:" + functionName + "();", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:alert('vcxvc');", true);
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }
       
    }

    protected void rptinvestigation_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "add")
            {
                string invesName = ((Label)e.Item.FindControl("lblInvestigation")).Text;
                int invID = Convert.ToInt32(((Label)e.Item.FindControl("lblinvID")).Text);
                //investigationList += invesName + "," + invID + ",0^";

                if (!investigationList.Contains("InvestigationName:" + invesName + "," + "InvestigationID:" + invID))
                {

                    investigationList += "InvestigationName:" + invesName + "," + "InvestigationID:" + invID + "," + "GroupID:0^";
                    ViewState["invList"] = investigationList;
                }
                else
                {
                    string sPath = "CommonControls\\\\Profile.ascx.cs_1";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "key", "ShowAlertMsg('"+ sPath +"');", true);
                }

                SetInvestigationList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }
    }

    protected void rptName_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            string filterText = ((LinkButton)e.Item.FindControl("lnkbtn")).Text;
            if (e.CommandName == "text")
            {
                List<PatientInvestigation> lstPatinves = new List<PatientInvestigation>();
                new Investigation_BL(base.ContextInfo).GetInvestigationByOrgID(OrgID,filterText, out lstPatinves);

                if (lstPatinves.Count > 0)
                {
                    rptinvestigation.DataSource = lstPatinves;
                    rptinvestigation.DataBind();
                }
                else
                {
                    lblStatus.Visible = true;
                    lblStatus.Text = "No Matching Records Found!";
                    rptinvestigation.DataSource = lstPatinves;
                    rptinvestigation.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }
    }

    #region "StoreValues in table"


    //public void CreateTable()
    //{
    //    int count = tabInv.Rows.Count;
    //    for (int i = count - 1; i > 0; i--)
    //    {
    //        TableRow tbr = tabInv.Rows[i];
    //        //TableCellCollection cells=(TableCellCollection) tabDrg.Rows[i].Cells;
    //        tabInv.Rows.Remove(tbr);
    //    }

    //    if (ViewState["invList"] != null)
    //    {
    //        investigationList = ViewState["invList"].ToString();
    //    }

    //    //investigationList += investigationName + "," + investigationid + "^";
    //    //ViewState["invList"] = investigationList;

    //    if (investigationList != string.Empty)
    //    {
    //        foreach (string list in investigationList.Split('^'))
    //        {
    //            if (list != string.Empty)
    //            {
    //                TableRow tabRow = new TableRow();

    //                foreach (string values in list.Split(','))
    //                {
    //                    TableCell tabcell = new TableCell();
    //                    tabcell.Text = values;
    //                    tabRow.Cells.Add(tabcell);
    //                }

    //                tabInv.Rows.Add(tabRow);
    //                tabInv.Visible = true;
    //            }

    //        }
    //    }

    //}
    # endregion

    #region Profile datalist and child reapeter
        //Child repeater loads here
    protected void datalst_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PatientInvestigation Investigation = (PatientInvestigation)e.Item.DataItem;
                string value = Investigation.GroupName;
                var childInves = from child in lstInvesGroup
                                 where child.GroupName == Investigation.GroupName && child.InvestigationName != null
                                 select child;
                Repeater childReapeter = (Repeater)e.Item.FindControl("rptChild");


                if (childInves.Count() > 0)
                {
                    HtmlContainerControl imgDIV = (HtmlContainerControl)e.Item.FindControl("ImgDiv");
                    imgDIV.Style.Add("display", "block");
                    childReapeter.DataSource = childInves;
                    childReapeter.DataBind();
                }
                else
                {
                    HtmlContainerControl imgDIV = (HtmlContainerControl)e.Item.FindControl("ImgDiv");
                    imgDIV.Style.Add("display", "none");
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }

    }
    #endregion

    protected void datalst_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            int grpID = Convert.ToInt32(((Label)e.Item.FindControl("lblGroup")).Text);
            string groupname = ((Label)e.Item.FindControl("lblParent")).Text;
            if (e.CommandName == "dListAdd")
            {
                
                Repeater rpt = (Repeater)e.Item.FindControl("rptChild");

                if (ViewState["GroupID"] != null)
                {
                    string groupID = ViewState["GroupID"].ToString();
                    string newGrpID = string.Empty;
                    foreach (string chkgrpID in groupID.Split(','))
                    {
                        if (chkgrpID != string.Empty)
                        {
                            if (chkgrpID != Convert.ToString(grpID))
                            {
                                newGrpID += chkgrpID + ",";
                            }

                        }
                    }
                    groupID = newGrpID;
                    ViewState["GroupID"] = groupID;
                }
                if (rpt.Items.Count > 0)
                {
                    foreach (RepeaterItem lbl in rpt.Items)
                    {
                        string invesName = ((Label)lbl.FindControl("lblName")).Text;
                        int invID = Convert.ToInt32(((Label)lbl.FindControl("lblinvID")).Text);

                        if (!investigationList.Contains("InvestigationName:" + invesName + ",InvestigationID:" + invID))
                        {
                            investigationList += "InvestigationName:" + invesName + "," + "InvestigationID:" + invID + "," + "GroupID:" + grpID + "^";
                            ViewState["invList"] = investigationList;
                        }

                        SetInvestigationList();
                    }
                }
                else
                {
                    if (!investigationList.Contains("InvestigationName:" + groupname + ",InvestigationID:0"))
                    {
                        investigationList += "InvestigationName:" + groupname + "," + "InvestigationID:0," + "GroupID:" + grpID + "^";
                        ViewState["invList"] = investigationList;
                    }
                    SetInvestigationList();
                }

            }

            //else if (e.CommandName == "ChdRepeaterload")
            //{
            //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //    {

            //        PatientInvestigation Investigation = new PatientInvestigation();// (PatientInvestigation)e.Item.DataItem;
            //        Investigation.GroupName = groupname;
            //        string value = Investigation.GroupName;
            //        var childInves = from child in lstInvesGroup
            //                         where child.GroupName == Investigsation.GroupName && child.InvestigationName != null
            //                         select child;
            //        Repeater childReapeter = (Repeater)e.Item.FindControl("rptChild");


            //        if (childInves.Count() > 0)
            //        {
            //            HtmlContainerControl imgDIV = (HtmlContainerControl)e.Item.FindControl("ImgDiv");
            //            //HtmlContainerControl imgDIV = (HtmlContainerControl)e.Item.FindControl("PDIV");
            //            imgDIV.Style.Add("display", "block");
            //            childReapeter.DataSource = childInves;
            //            childReapeter.DataBind();
            //        }
            //        else
            //        {
            //            HtmlContainerControl imgDIV = (HtmlContainerControl)e.Item.FindControl("ImgDiv");
            //            imgDIV.Style.Add("display", "none");
            //        }
            //    }
           // }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string filterText = txtSearchText.Text;
            List<PatientInvestigation> lstPatinves = new List<PatientInvestigation>();
            new Investigation_BL(base.ContextInfo).GetInvestigationByOrgID(OrgID,filterText, out lstPatinves);
            if (lstPatinves.Count > 0)
            {
                rptinvestigation.DataSource = lstPatinves;
                rptinvestigation.DataBind();
                lblStatus.Visible = false;
                txtSearchText.Text = string.Empty;

            }
            else
            {
                lblStatus.Visible = true;
                lblStatus.Text = "No Matching Records Found!";
                rptinvestigation.DataSource = lstPatinves;
                rptinvestigation.DataBind();
               txtSearchText.Text = string.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting profile control ", ex);
        }
        

    }



    public List<PatientInvestigation> SetInvestigationList()
    {

        List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();

        if (ViewState["invList"] != null)
        {
            investigationList = ViewState["invList"].ToString();
        }

        if (investigationList != string.Empty)
        {
            foreach (string list in investigationList.Split('^'))
            {
                if (list != string.Empty)
                {

                    PatientInvestigation invesAdd = new PatientInvestigation();

                    foreach (string values in list.Split(','))
                    {
                        string[] items = values.Split(':');
                        string invesValues = string.Empty;
                        if (items.Count() > 0)
                            invesValues = items[1];


                        switch (items[0])
                        {
                            case "InvestigationName":
                                invesAdd.InvestigationName = invesValues;
                                break;

                            case "InvestigationID":
                                invesAdd.InvestigationID = Convert.ToInt64(invesValues);
                                break;

                            case "GroupID":

                                if (ViewState["GroupID"] != null)
                                {
                                    string groupID = ViewState["GroupID"].ToString();
                                    foreach (string grpID in groupID.Split(','))
                                    {
                                        if (grpID != string.Empty)
                                        {
                                            if (invesValues == grpID)
                                                invesValues = "0";
                                        }
                                    }
                                }
                                invesAdd.GroupID = Convert.ToInt32(invesValues);
                                break;
                        };


                    }
                    lstInvestigation.Add(invesAdd);

                }

            }
        }


        if (lstInvestigation.Count > 0)
        {

            dLstAddedInves.Visible = true;
            dLstAddedInves.DataSource = lstInvestigation;
            dLstAddedInves.DataBind();
            //ViewState["GroupID"] = string.Empty;
        }
        else
        {
            dLstAddedInves.Visible = false;
        }
        return lstInvestigation;
    }

    protected void dLstAddedInves_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            int index = e.Item.ItemIndex;
            string deletedGrpid = string.Empty;

            if (e.CommandName == "Delete")
            {
                string newList = string.Empty;
                int groupID = Convert.ToInt32(((Label)e.Item.FindControl("GroupID")).Text);
                string InvestigationName = ((Label)e.Item.FindControl("invName")).Text;
                int InvestigationID = Convert.ToInt32(((Label)e.Item.FindControl("invID")).Text);

                if (ViewState["invList"] != null)
                {
                    investigationList = ViewState["invList"].ToString();
                }

                if (investigationList != string.Empty)
                {
                    foreach (string list in investigationList.Split('^'))
                    {
                        if (list != string.Empty)
                        {
                            foreach (string values in list.Split(','))
                            {
                                string[] items = values.Split(':');
                                string invesValues = string.Empty;
                                if (items.Count() > 0)
                                    invesValues = items[1];

                                if (invesValues != InvestigationName && invesValues != Convert.ToString(InvestigationID))
                                {
                                    switch (items[0])
                                    {
                                        case "InvestigationName":
                                            newList += "InvestigationName:" + invesValues + ",";
                                            break;

                                        case "InvestigationID":
                                            newList += "InvestigationID:" + Convert.ToInt64(invesValues) + ",";
                                            break;

                                        case "GroupID":
                                            newList += "GroupID:" + Convert.ToInt32(invesValues) + "^";
                                            break;
                                    };

                                }
                                else
                                {
                                    if (ViewState["GroupID"] != null)
                                    {
                                        deletedGrpid = ViewState["GroupID"].ToString();
                                    }
                                    deletedGrpid += Convert.ToString(groupID) + ",";
                                    ViewState["GroupID"] = deletedGrpid;
                                    break;

                                }
                            }

                        }

                    }
                    ViewState["invList"] = newList;
                    SetInvestigationList();
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("error while excecuting profile control", ex);
        }
    }

    public int OrgID
    {
        get { return orgID; }
        set { orgID = value; }
    }

    protected void dtPackage_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "packageAdd")
            {
                int grpID = Convert.ToInt32(((Label)e.Item.FindControl("lblPackageID")).Text);
                Repeater rpt = (Repeater)e.Item.FindControl("rptPackageChild");

                if (ViewState["GroupID"] != null)
                {
                    string groupID = ViewState["GroupID"].ToString();
                    string newGrpID = string.Empty;
                    foreach (string chkgrpID in groupID.Split(','))
                    {
                        if (chkgrpID != string.Empty)
                        {
                            if (chkgrpID != Convert.ToString(grpID))
                            {
                                newGrpID += chkgrpID + ",";
                            }

                        }
                    }
                    groupID = newGrpID;
                    ViewState["GroupID"] = groupID;
                }

                foreach (RepeaterItem lbl in rpt.Items)
                {
                    string PkginvesName = ((Label)lbl.FindControl("lblChildName")).Text;
                    int PkginvID = Convert.ToInt32(((Label)lbl.FindControl("lblPackageinvID")).Text);
                    if (!investigationList.Contains("InvestigationName:" + PkginvesName + ",InvestigationID:" + PkginvID))
                    {
                        investigationList += "InvestigationName:" + PkginvesName + "," + "InvestigationID:" + PkginvID + "," + "GroupID:" + grpID + "^";
                        ViewState["invList"] = investigationList;
                    }

                    //CreateTable();
                    SetInvestigationList();
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("error while excecuting profile control", ex);
        }
    }
    protected void dtPackage_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PatientInvestigation Investigation = (PatientInvestigation)e.Item.DataItem;

                string value = Investigation.GroupName;
                var childInves = from child in lstPackage
                                 where child.GroupName == Investigation.GroupName && child.InvestigationName != null
                                 select child;
                Repeater childReapeter = (Repeater)e.Item.FindControl("rptPackageChild");

                childReapeter.DataSource = childInves;
                childReapeter.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("error while excecuting profile control", ex);
        }
    }
    
    void LoadInvestigation(List<PatientInvestigation> ordInvestigation)
    {
        foreach (PatientInvestigation item in ordInvestigation)
        {
            investigationList += "InvestigationName:" + item.InvestigationName + "," + "InvestigationID:" + item.InvestigationID + "," + "GroupID:" + item.GroupID + "^";
        }
        ViewState["invList"] = investigationList;
        SetInvestigationList();

    }
}
