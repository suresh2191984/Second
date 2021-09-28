using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;


public partial class Lab_SampleTransferScreen : BasePage
{

    public Lab_SampleTransferScreen()
        : base("Lab\\SampleTransferScreen.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
   
   
   
 
    long returnCode = -1;
   
    List<OrganizationAddress> Location;
    List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    List<PatientInvSample> lstpinvsample;
    List<InvestigationStatus> lstInvestigationStatus;
    List<LabReferenceOrg> lstLabReferenceOrg;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                string query = Request.QueryString["Flag"];
            //    hdnquerystring.Value = query.ToString();
                lstInvestigationStatus = new List<InvestigationStatus>();
                lstLabReferenceOrg = new List<LabReferenceOrg>();
                AutoCompleteProduct.ContextKey = "";
                returnCode = new Investigation_BL(base.ContextInfo).GetTransferInvestionStatus(OrgID, out lstInvestigationStatus, out lstLabReferenceOrg);
                ddlSampleStatus.DataSource = lstInvestigationStatus;
                ddlSampleStatus.DataTextField = "DisplayText";
                ddlSampleStatus.DataValueField = "InvestigationStatusID";
                ddlSampleStatus.DataBind();
                ddlSampleStatus.Items.Insert(0, "---Select---");
                ddlSampleStatus.Items[0].Value = "-1";
                ddlSampleStatus.SelectedValue = "0";

                hdnlid.Value = LID.ToString();
                hdnBaseILocationID.Value = ILocationID.ToString();
                hdnBaseOrgId.Value = OrgID.ToString();

                if (Request.QueryString["Flag"] == "Y")
                {
                    ddlSampleStatus.SelectedValue = "0";
                }
                else
                {
                    if (ddlSampleStatus.Items.Contains(ddlSampleStatus.Items.FindByText("SampleReceived")))
                    {
                        ddlSampleStatus.Items.Remove(ddlSampleStatus.Items.FindByText("SampleReceived"));
                    }
                }

                txtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
                txtTo.Text = OrgTimeZone;
                hdnDate.Value = Convert.ToDateTime(OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
                txttranDate.Text = Convert.ToDateTime(OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
                //pnlSampleList.Visible = false;
               // pnlFooter.Visible = false;
                pnlFooter.Style.Add("display", "none");

                LoadMetaData();
                LoadLocation();
                LoadSourceNameTrustedOrg();
                AutoCompleteExtender1.ContextKey = OrgID.ToString();
                AutoCompleteExtender2.ContextKey = OrgID.ToString();
                AutoCompleteExtender3.ContextKey = OrgID.ToString();
                AutoCompleteExtender5.ContextKey = OrgID.ToString();
                AutoCompleteExtendercon.ContextKey = OrgID.ToString();

                if (CID > 0)
                {
                    hdnClientID.Value = Convert.ToString(CID);
                    txtClientName.Text = UserName;
                    txtClientName.Attributes.Add("disabled", "true");
                }
                else
                {
                    hdnClientID.Value = "";
                    txtClientName.Text = "";
                    txtClientName.Attributes.Remove("disabled");
                }
           
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing InvestigationSample page", ex);
        }
    }
  

    protected void grdResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            DropDownList ddlSampleStatus = e.Item.FindControl("lblstatusID") as DropDownList;
            ddlSampleStatus.SelectedValue = ((PatientInvSample)e.Item.DataItem).InvSampleStatusID.ToString();
        }
    }

   

    private void LoadLocation()
    {

        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<OrganizationAddress> ProcessedAt = new List<OrganizationAddress>();
        List<OrganizationAddress> TransferLoc = new List<OrganizationAddress>();
        returnCode = new Referrals_BL(base.ContextInfo).GetALLProcessingLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();

            ddltransferloc.DataSource = lstLocation;
            ddltransferloc.DataTextField = "Location";
            ddltransferloc.DataValueField = "AddressID";
            ddltransferloc.DataBind();
            //added by sudhakar//
            if (Request.QueryString["Flag"] == "Y")
            {
                ddltransferloc.Items.Insert(0, "------SELECT------");
                ddltransferloc.Items[0].Value = "-1";
            }

            //var s = lstLocation.FindAll(p => p.OrganizationID == OrgID);

            ddlprocessedlocation.DataSource = lstLocation;
            ddlprocessedlocation.DataTextField = "Location";
            ddlprocessedlocation.DataValueField = "AddressID";
            ddlprocessedlocation.DataBind();
            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, "------SELECT------");
                ddlLocation.Items[0].Value = "-1";

                //ddltransferloc.Items.Insert(0, "------SELECT------");
                //ddltransferloc.Items[0].Value = "-1";

                ddlprocessedlocation.Items.Insert(0, "------SELECT------");
                ddlprocessedlocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, "------SELECT------");
                ddlLocation.Items[0].Value = "-1";

                //ddltransferloc.Items.Insert(0, "------SELECT------");
                //ddltransferloc.Items[0].Value = "-1";


                //added by sudhakar//
                if (Request.QueryString["Flag"] == "Y")
                {
                    ddltransferloc.SelectedValue = "-1";
                }


                //ddltransferloc.SelectedValue = s[0].ToString();

                ddlprocessedlocation.Items.Insert(0, "------SELECT------");
                ddlprocessedlocation.Items[0].Value = "-1";
            }
        }
    }

    public void LoadSourceNameTrustedOrg()
    {
        try
        {
            string pType = "OUT";
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetInvTransferClientMaster(OrgID, string.Empty, out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
                ddClientName.Items.Insert(0, "------SELECT------");
                ddClientName.Items[0].Value = "-1";
            }
            //List<OrganizationAddress> lstProcessingLocation = new List<OrganizationAddress>();
            //Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            //oInvestigationBL.GetTestProcessingLocation(OrgID, pType, out lstProcessingLocation);
            if (lstLabReferenceOrg.Count > 0)
            {
                ddloutsource.DataSource = lstLabReferenceOrg;
                ddloutsource.DataTextField = "RefOrgName";
                ddloutsource.DataValueField = "LabRefOrgID";
                ddloutsource.DataBind();
                ddloutsource.Items.Insert(0, "------SELECT------");
                ddloutsource.Items[0].Value = "-1";
            }
            else
            {
                ddloutsource.Items.Insert(0, "------SELECT------");
                ddloutsource.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
        }
    }
    protected void grdSample_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (HdnCheckBoxId.Value == "")
            {
                if (((CheckBox)e.Row.FindControl("chkselect")).Enabled == true)
                {

                    HdnCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkselect")).ClientID;
                }
            }
            else
            {
                if (((CheckBox)e.Row.FindControl("chkselect")).Enabled == true)
                {
                    HdnCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkselect")).ClientID;
                }
            }
            CollectedSample lstCollectedSample = (CollectedSample)e.Row.DataItem;
            if (lstCollectedSample.RefOrgName == "Y")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
            }
            e.Row.Cells[11].Text = ddltransferloc.SelectedItem.Text;
        }
    }

  

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "VisitType,TraType,ISSTAT";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                //var childItems = from child in lstmetadataOutput
                //                 where child.Domain == "TraType"
                //                 select child;
                //ddlType.DataSource = childItems;
                //ddlType.DataTextField = "DisplayText";
                //ddlType.DataValueField = "Code";
                //ddlType.DataBind();
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddVisitType.DataSource = childItems2;
                ddVisitType.DataTextField = "DisplayText";
                ddVisitType.DataValueField = "Code";
                ddVisitType.DataBind();
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "ISSTAT"
                                  select child;
                ddlstat.DataSource = childItems3;
                ddlstat.DataTextField = "DisplayText";
                ddlstat.DataValueField = "Code";
                ddlstat.DataBind();
                ddlstat.SelectedValue = "-1";
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
           // ErrorDisplay1.ShowError = true;
        //    ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
}



