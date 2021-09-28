using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;


public partial class ClinicalTrial_EpisodeContainerTracking : BasePage
{

    ClinicalTrail_BL CT_BL;
    List<ControlMappingDetails> lstTempControlSavedValues;
    List<ControlMappingDetails> lstControlMappingDetails;
    List<ControlMappingDetails> lstControlMappingValues;
    ControlMappingDetails objControlMappingDetails;
    object objControls;
    Control pControls;  
    protected void Page_Load(object sender, EventArgs e)
    {
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            long Eid = -1;
            string Res = string.Empty;
            LoadShippingCondition();
            SetContext();
            LoadStatusMaster();
            GetEpiContainerTracking();
           
            if ((!string.IsNullOrEmpty(Request.QueryString["Res"])))
            {
                Res = Request.QueryString["Res"].ToString();
            }
            if (Res == "Y")
            {
                //lblmsg.Text = "Episode Added sucessfully";
                //lblmsg.Attributes.Add("style", "display:block");
                //lblmsg.ForeColor = System.Drawing.Color.Green;
            }
            else if (Res == "N")
            {
                //lblmsg.Text = "Episode Added Failed";
                //lblmsg.Attributes.Add("style", "display:block");
                //lblmsg.ForeColor = System.Drawing.Color.Red;
            }
            if ((!string.IsNullOrEmpty(Request.QueryString["Eid"])))
            {
                Eid = Convert.ToInt64(Request.QueryString["Eid"].ToString());
                List<Episode> lstEpisodeMaster = new List<Episode>();
                List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
                List<ProductEpisodeVisitMapping> lstProductDetails = new List<ProductEpisodeVisitMapping>();
                List<SiteEpisodeVisitMapping> lstSiteDetails = new List<SiteEpisodeVisitMapping>();
                CT_BL.GetEpisodeDetails(OrgID, "", Eid, out lstEpisodeMaster, out lstEpisodeVisitDetails, out lstProductDetails, out lstSiteDetails);
                //if (lstEpisodeMaster.Count > 0)
                //{
                    //gvclientmaster.DataSource = lstEpisodeMaster;
                    //gvclientmaster.DataBind();
                //}
            }
            else
            {
                //GetClientDetails();
            }
             
           //  ScriptManager1.RegisterPostBackControl(btnFinish);
        } 
     }
    public void LoadShippingCondition()
    {
        List<ShippingConditionMaster> lstShippingConditionMaster = new List<ShippingConditionMaster>();
        CT_BL.GetShippingCondition(OrgID, out lstShippingConditionMaster);
        if (lstShippingConditionMaster.Count > 0)
        {
            ddlShipping.DataTextField = "ConditionDesc";
            ddlShipping.DataValueField = "ShippingConditionID";
            ddlShipping.DataSource = lstShippingConditionMaster;
            ddlShipping.DataBind();
            ddlShipping.Items.Insert(0, "--Select--");
            ddlShipping.Items[0].Value = "0";
           
        }

    }
    public void LoadStatusMaster()
    {
        List<StatusMaster> lstStatusMaster = new List<StatusMaster>();
        CT_BL.GetStatusMaster(OrgID, out lstStatusMaster);
        if (lstStatusMaster.Count > 0)
        {
            
            ddlConainerStatus.DataTextField = "StatusDesc";
            ddlConainerStatus.DataValueField = "StatusID";

            ddlConainerStatus.DataSource = lstStatusMaster.FindAll(p => p.StatusID != 0);
            ddlConainerStatus.DataBind();
            ddlConainerStatus.Items.Insert(0, "--ALL--");
            ddlConainerStatus.Items[0].Value = "0";
           
        }

    }
    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();
        int SiteID = 0;
        long EpisodeID = -1;
        int ShippingCondID = 0;
        int VisitID = 0;
        string AddInfo = string.Empty;
        SiteID =Int32.Parse(hdnClientID.Value); //1;// Int32.Parse(ddlSite.SelectedValue);
        EpisodeID = Int32.Parse(hdnEpisodeID.Value);
        ShippingCondID = Int32.Parse(ddlShipping.SelectedValue);
        VisitID = (string.IsNullOrEmpty(txtVisitNo.Text)) == false ? Int32.Parse(txtVisitNo.Text) : 0;
        AddInfo = txtAdditionalDetails.Text;
        long RegTrackID = -1;
        CT_BL.SaveEpiContainerTracking(SiteID, EpisodeID, ShippingCondID, VisitID, AddInfo, OrgID, LID,-1, out RegTrackID);
        GetEpiContainerTracking();
        ClearField();
    }
    public void GetEpiContainerTracking()
    {
        try
        {
            long TaksID = -1;
            int TStatusID = 0;
            TaksID =string.IsNullOrEmpty(txtTaskID.Text)==true ?0: Int64.Parse(txtTaskID.Text);
            TStatusID = Int32.Parse(ddlConainerStatus.SelectedValue);
            List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();
            lstEpiContainerTracking.Clear(); 
            string EpisodeName = string.Empty;
            
            CT_BL.GetEpiContainerTracking(OrgID,TaksID,TStatusID, out lstEpiContainerTracking);
            //if (lstEpiContainerTracking.Count > 0)
            //{
                grdResult.DataSource = lstEpiContainerTracking;
                grdResult.DataBind();

           // }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting client - Invoicemaster.aspx", ex);
        }
    }
    public void SetContext()
    { 
         string ClientID = hdnClientID.Value;
        //AutoCompleteSittingEpisode.ContextKey = OrgID.ToString() +""+ ClientID;
       // AutoCompleteSittingEpisode.ContextKey =  OrgID.ToString()+""+;
         AutoCompleteExtenderClientCorp.ContextKey = "SIT";


    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            GetEpiContainerTracking();
        }
    }
    protected void ChildGrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
             
             
        }
    }
    public void ClearField()
    {
        txtEpisodeName.Text = "";
        txtVisitNo.Text = "";
        txtAdditionalDetails.Text = "";
        ddlShipping.SelectedIndex = 0;
        //ddlSite.SelectedIndex = 0;
        hdnClientID.Value = "";
        txtClient.Text = "";
        hdnEpisodeID.Value = "";
        hdnContainerStatusID.Value = "";
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            { 
                HtmlTable  tblTabChild = (HtmlTable)e.Row.FindControl("TabChild");

                HtmlTableCell tblTabChild1 = (HtmlTableCell)tblTabChild.FindControl("tdGridContainerStatus");
                HtmlTableCell tblTabChild2 = (HtmlTableCell)tblTabChild.FindControl("tdChangeStatus");

             


                EpiContainerTracking BMaster = (EpiContainerTracking)e.Row.DataItem;
                DropDownList childddlGridContainerStatus = (DropDownList)tblTabChild1.FindControl("ddlGridContainerStatus");

                if (!string.IsNullOrEmpty(BMaster.EpiStatus))
                {
                    var List = BMaster.EpiStatus.Split('^');
                    List<StatusMaster> lstStatus = new List<StatusMaster>();
                    for (int i = 0; i <= List.Count() - 1; i++)
                    {
                        StatusMaster lstSt = new StatusMaster(); ;
                        if (List[i] != "")
                        { 
                            var ST = List[i].Split('~');
                            lstSt.StatusID = Convert.ToInt32(ST[0]);
                            lstSt.StatusDesc = ST[1];
                            lstSt.SeqNo =Convert.ToInt32(ST[3]);
                            lstStatus.Add(lstSt);
                        }

                    }

                    if (lstStatus.Count > 0)
                    {  
                        childddlGridContainerStatus.DataTextField = "StatusDesc";
                        childddlGridContainerStatus.DataValueField = "StatusID";
                        childddlGridContainerStatus.DataSource = lstStatus.OrderBy(p => p.SeqNo).ToList();
                        childddlGridContainerStatus.DataBind();

                    }
                    tblTabChild2.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.className='hover'");
                    tblTabChild2.Attributes.Add("onmouseout", "this.className='hout'");
                    tblTabChild2.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "ChangeStatus$" + e.Row.RowIndex));

                    

                }
                else
                {
                    HtmlInputButton btnChangeStatus = (HtmlInputButton)tblTabChild1.FindControl("btnChangeStatus");
                    childddlGridContainerStatus.Items.Insert(0, "Status Completed");
                    childddlGridContainerStatus.Items[0].Value = "0";
                     tblTabChild2.Disabled=true;
                     childddlGridContainerStatus.Enabled = false;

                          
                }
            }  
        } 
    }
    protected void btnPopUpSave_Click(object sender, EventArgs e)
    {
        long TrackID = Convert.ToInt64(hdnTrackID.Value); 
        int ContainerStatusID = Convert.ToInt32(hdnContainerStatusID.Value);
        string Attributes = string.Empty;
          List<ControlMappingDetails> lstControlMappingDetails=new List<ControlMappingDetails>();

          ControlListDetails.getControlsValues(out lstControlMappingDetails);

          CT_BL.UpdateContainerStatus(TrackID, ContainerStatusID, Attributes, OrgID, LID, lstControlMappingDetails);
        GetEpiContainerTracking();
        
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "hideDiv", "javascript:alert('Status Updated Sucessfuly');", true);

    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        { 
            {
                if (e.CommandName == "ChangeStatus")
                {
                    long RetValue = -1;
                    int rowIndexS = -1;
                    rowIndexS = Convert.ToInt32(e.CommandArgument);
                    long TrackID = Convert.ToInt64(grdResult.DataKeys[rowIndexS][0].ToString());
                    //EpisodeName = grdResult.DataKeys[rowIndexS][2].ToString();

                    GridViewRow row = grdResult.Rows[rowIndexS];
                    DropDownList childddlGridContainerStatus = (DropDownList)row.FindControl("ddlGridContainerStatus");
                    int ContainerStatusID = Convert.ToInt32(childddlGridContainerStatus.SelectedValue);
                    //string Attributes = string.Empty;
                    //CT_BL.UpdateContainerStatus(TrackID, ContainerStatusID, Attributes, OrgID, LID);
                    //GetEpiContainerTracking();
                     List<ControlMappingDetails>  lstControlValues=new List<ControlMappingDetails>(); 
                    hdnTrackID.Value = TrackID.ToString();
                    hdnLID.Value = LID.ToString();
                    hdnContainerStatusID.Value = ContainerStatusID.ToString();
                    RetValue = ControlListDetails.LoadCustomerControls(ContainerStatusID, "CT", "",-1, lstControlValues);
                    if (RetValue == 0)
                    {
                        ModalPopupExtender1.Show();
                        btnPopUpSave.Attributes.Add("style", "display:block");
                    }
                    if (RetValue == -1)
                    {
                        SaveAttributes();
                    }
                }
                else
                {
                    if (HdnID.Value != string.Empty)
                    {
                        if (HdnID.Value != e.CommandArgument.ToString())
                        {
                            int rID = Convert.ToInt32(HdnID.Value);
                            HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                            ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                            imgBTN.ImageUrl = "~/Images/collapse.jpg";
                            Div1.Style.Add("display", "none");
                        }
                    } 
                    if (e.CommandArgument.ToString() != "")
                    {
                        int A = 0;
                        ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
                        imgBTN.ImageUrl = "~/Images/expand.jpg";
                        //TextBox patientId = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientId");
                        HtmlControl Div = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
                        string[] str = (Div.Attributes["style"].ToString()).Split(';');
                        if (str[0] == "display:block")
                        {
                            Div.Style.Add("display", "none");
                            imgBTN.ImageUrl = "~/Images/collapse.jpg";
                        }
                        else
                        {
                            Div.Style.Add("display", "block");
                            A = A + 2;
                        }
                        if (A > 0)
                        {
                            int rowIndexS = -1;
                            rowIndexS = Convert.ToInt32(e.CommandArgument);
                            long TrackID = Convert.ToInt64(grdResult.DataKeys[rowIndexS][0].ToString());
                            //EpisodeName = grdResult.DataKeys[rowIndexS][2].ToString();

                            GridViewRow row = grdResult.Rows[rowIndexS];
                            GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGrid");


                            List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();
                            lstEpiContainerTracking.Clear();


                            CT_BL.GetEpiContainerTrackingDetails(OrgID, TrackID, out lstEpiContainerTracking);
                            if (lstEpiContainerTracking.Count > 0)
                            {
                                ChildGrd.DataSource = lstEpiContainerTracking;
                                ChildGrd.DataBind();
                                 
                               // ChildGrd.SelectedRow.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + ChildGrd.SelectedRow.RowIndex));
                            }

                        }
                        HdnID.Value = e.CommandArgument.ToString(); 
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
        }
    }
    public void SaveAttributes()
    {
        long TrackID = Convert.ToInt64(hdnTrackID.Value);
        int ContainerStatusID = Convert.ToInt32(hdnContainerStatusID.Value);
        string Attributes = string.Empty;
        List<ControlMappingDetails> lstControlMappingDetails = new List<ControlMappingDetails>();

        // getControlsValues(out lstControlMappingDetails);

        CT_BL.UpdateContainerStatus(TrackID, ContainerStatusID, Attributes, OrgID, LID, lstControlMappingDetails);
        GetEpiContainerTracking();
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "alert(TrackID : '" + TrackID.ToString() + "' Status is Updated)", true);
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "hideDiv", "javascript:alert('Status Updated Sucessfuly');", true);
    }
    #region DynamicControls Comment
    //protected void LoadCustomerControls(long ReferenceID, string ReferenceType, string pType, List<ControlMappingDetails> lstControlValues)
    //{
    //    try
    //    {
    //        new ClinicalTrail_BL(base.ContextInfo).GetControlListDetails(OrgID, ReferenceID, ReferenceType, pType, out lstControlMappingDetails, out lstControlMappingValues);
    //        gdvCustomerControls.DataSource = lstControlMappingDetails;
    //        gdvCustomerControls.DataBind();
    //        if (lstControlMappingDetails.Count > 0)
    //        {
    //            ModalPopupExtender1.Show();
    //        }
    //        else
    //        {
    //            SaveAttributes();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Page Load - LoadCustomerControls", ex);

    //    }

    //}
   
    //protected void gdvCustomerControls_RowDataBound(Object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {

    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {

    //            objControlMappingDetails = (ControlMappingDetails)e.Row.DataItem;
    //            if (objControlMappingDetails.ControlCode == "DDL")
    //            {
    //                objControls = (DropDownList)e.Row.FindControl("ddlControlValue");
    //            }
    //            if (objControlMappingDetails.ControlCode == "TEXT"   )
    //            {
    //                objControls = (TextBox)e.Row.FindControl("txtControlValue");
                    
    //            }
    //            if (objControlMappingDetails.ControlCode == "DATE")
    //            {
    //                objControls = (TextBox)e.Row.FindControl("txtControldade");
    //            }
    //            if (objControlMappingDetails.ControlCode == "RDO")
    //            {
    //                objControls = (RadioButtonList)e.Row.FindControl("rdoControlValue");
    //            }
    //            if (objControlMappingDetails.ControlCode == "CHB")
    //            {
    //                objControls = (CheckBoxList)e.Row.FindControl("chkControlValue");
    //            }
    //            BindControlValues(objControls, objControlMappingDetails);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Page Load - gdvCustomerControls", ex);

    //    }
    //}

    //private void BindControlValues(object objControls, ControlMappingDetails objControlMappingDetails)
    //{

    //    switch (objControlMappingDetails.ControlCode)
    //    {

    //        case "DDL":

    //            DropDownList ddl = (DropDownList)objControls;
    //            ddl.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
    //            ddl.DataValueField = "ControlValue";
    //            ddl.DataTextField = "ControlValue";
    //            ddl.DataBind();
    //            ddl.Visible = true;
    //            break;

    //        case "CHB":

    //            CheckBoxList chb = (CheckBoxList)objControls;
    //            chb.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
    //            chb.DataValueField = "ControlValue";
    //            chb.DataTextField = "ControlValue";
    //            chb.DataBind();
    //            chb.Visible = true;
    //            break;

    //        case "TEXT":
    //            TextBox txt = (TextBox)objControls;
    //            txt.Visible = true;
    //            break;

    //        case "DATE":
    //            TextBox txtdate = (TextBox)objControls;
    //            //objAnchor.HRef = "javascript:NewCssCal('" + txtdate.ClientID + "','ddmmyyyy','arrow',true,12)";
    //            //objAnchor.Visible = true;
    //            txtdate.Visible = true;
    //            break;

    //        case "RDO":

    //            RadioButtonList rdo = (RadioButtonList)objControls;
    //            rdo.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
    //            rdo.DataValueField = "ControlValue";
    //            rdo.DataTextField = "ControlValue";
    //            rdo.DataBind();
    //            rdo.Visible = true;
    //            break;


    //        default:
    //            break;
    //    }
    //}


    //protected void getControlsValues(out List<ControlMappingDetails> lstControlSavedValues)
    //{
    //    lstControlSavedValues = new List<ControlMappingDetails>();

    //    foreach (GridViewRow item in gdvCustomerControls.Rows)
    //    {

    //        objControlMappingDetails = new ControlMappingDetails();
    //        DropDownList ddl = (DropDownList)item.FindControl("ddlControlValue");
    //        TextBox txt = (TextBox)item.FindControl("txtControlValue");
    //        RadioButtonList rdo = (RadioButtonList)item.FindControl("rdoControlValue");
    //        CheckBoxList chk = (CheckBoxList)item.FindControl("chkControlValue");
    //        HiddenField hdnControlMappingID = (HiddenField)item.FindControl("hdnControlMappingID");
    //        HiddenField hdnControlTypeID = (HiddenField)item.FindControl("hdnControlTypeID");
    //        HiddenField hdnControlCode = (HiddenField)item.FindControl("hdnControlCode");
    //           Label LblDisplayText = (Label)item.FindControl("LblDisplayTextGrid");
    //        HiddenField hdnID = (HiddenField)item.FindControl("hdnID");

            
    //        objControlMappingDetails.ControlMappingID = Convert.ToInt64(hdnControlMappingID.Value);
    //         objControlMappingDetails.ControlName = LblDisplayText.Text;
    //        if (hdnControlCode.Value == "DDL")
    //        {
    //            objControlMappingDetails.ControlValue = ddl.SelectedValue;
    //        }
    //        if (hdnControlCode.Value == "TEXT")
    //        {
    //            objControlMappingDetails.ControlValue = txt.Text;
    //        }
    //        if (hdnControlCode.Value == "RDO")
    //        {
    //            objControlMappingDetails.ControlValue = rdo.SelectedValue;
    //        }
    //        if (hdnControlCode.Value == "CHB")
    //        {
    //            foreach (ListItem val in chk.Items)
    //            {
    //                if (val.Selected)
    //                {
    //                    objControlMappingDetails.ControlValue = val.Value;
    //                    lstControlSavedValues.Add(objControlMappingDetails);
    //                }
    //            }

    //        }
    //        else
    //        {
    //            lstControlSavedValues.Add(objControlMappingDetails);
    //        }
    //    }
    //}

    #endregion 


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetEpiContainerTracking();
    }

    protected void ChildGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
             

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Style.Add("Cursor", "Pointer");
                GridView G =(GridView)e.Row.Parent.Parent;
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(G, "SHOWDETAILS$" + e.Row.RowIndex));
            }

           // ClientMaster si = (ClientMaster)e.Row.DataItem;
           
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
            

        }
    }
    protected void ChildGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "SHOWDETAILS")
            {
                 int rowIndexS = -1;
                  GridView G = (GridView)e.CommandSource;

                 rowIndexS = Convert.ToInt32(e.CommandArgument);

                 long TrackID = Convert.ToInt64(G.DataKeys[rowIndexS][0].ToString());
                 long TrackDetailsID = Convert.ToInt64(G.DataKeys[rowIndexS][1].ToString());
                 long CurrentStatusID = Convert.ToInt64(G.DataKeys[rowIndexS][2].ToString());

                 List<ControlMappingDetails> lstControlValues = new List<ControlMappingDetails>();
                 long RetValue = ControlListDetails.LoadCustomerControls(CurrentStatusID, "CT", "VIEW",TrackDetailsID, lstControlValues);
                 if (RetValue == 0)
                 {
                     btnPopUpSave.Attributes.Add("style", "display:none");
                     ModalPopupExtender1.Show();
                     
                 }

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Client Attributes.", ex);

        }


    }

    //protected void SortRecords(object sender, GridViewSortEventArgs e)
    //{ 
    //    string sortExpression = e.SortExpression; 
    //    string direction = string.Empty;  
    //    if (SortDirection == SortDirection.Ascending)
    //    { 
    //        SortDirection = SortDirection.Descending; 
    //        direction = " DESC"; 
    //    } 
    //    else
    //    { 
    //        SortDirection = SortDirection.Ascending; 
    //        direction = " ASC"; 
    //    } 
    //    DataTable table = this.GetData(); 
    //    table.DefaultView.Sort = sortExpression + direction;
    //    grdResult.DataSource = table;
    //    grdResult.DataBind(); 
    //}
    //public SortDirection SortDirection
    //{ 
    //    get
    //    { 
    //        if (ViewState["SortDirection"] == null)
    //        { 
    //            ViewState["SortDirection"] = SortDirection.Ascending; 
    //        } 
    //        return (SortDirection)ViewState["SortDirection"]; 
    //    } 
    //    set
    //    { 
    //        ViewState["SortDirection"] = value; 
    //    } 
    //}

    //    private DataTable GetData()

    //    {

    //    DataTable table = new DataTable();



    //    // get the connection

    //    using (SqlConnection conn = new SqlConnection())
    //        {        // write the sql statement to execute
    //      string sql=  "SELECT ECT.TrackID , ECT.EpisodeId,E.EpisodeName, ECT.SiteID,CM.ClientName, ECT.ShippingConditionID,SCM.ConditionDesc , ISNULL(ECT.VisitNo,'0'), ECT.AdditionalInfo, ECT.CurrentStatusID,SM.StatusDesc, ECT.OrgID, ECT.CreatedAt, ECT.CreatedBy,      (SELECT DISTINCT  CONVERT(VARCHAR,SM.StatusID)   +'~' +CONVERT(VARCHAR,Sm.StatusDesc)+'~' +CONVERT(VARCHAR,Smp.StatusID)+'^' from StatusMaster SM    INNER JOIN Statusmapping SMP ON SMP.MappingID=SM.StatusID  where SMP.StatusID=ECT.CurrentStatusID FOR XML PATH(''))  EpiStatus FROM EpiContainerTracking ECT INNER JOIN Episode E ON E.EpisodeID=ECT.EpisodeID INNER JOIN ClientMaster CM ON CM.ClientID= ECT.SiteID INNER JOIN ShippingConditionMaster SCM ON SCM.ShippingConditionID=ECT.ShippingConditionID      INNER JOIN StatusMaster SM ON SM.StatusID=ECT.CurrentStatusID WHERE ECT.Orgid=67 AND CM.OrgID=67 AND E.OrgID=67 order by ";
    //   // string sql = "SELECT AutoId, FirstName, LastName, Age, Active FROM PersonalDetail ORDER By AutoId";

    //    // instantiate the command object to fire

    //    using (SqlCommand cmd = new SqlCommand(sql, conn))

    //    {

    //    // get the adapter object and attach the command object to it

    //    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))

    //    {

    //    // fire Fill method to fetch the data and fill into DataTable

    //    ad.Fill(table);

    //    }

    //    }

    //    }

    //    return table;

    //    }
}
