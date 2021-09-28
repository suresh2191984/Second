using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;
using Attune.Podium.EMR;

public partial class BloodBank_BloodCollection : BasePage
{
    long visitID = 0;
    long returnCode = -1;
    long taskID = -1;
    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    List<DonorStatus> lstDonorStatus = new List<DonorStatus>();
    List<BloodCollectionDetails> lstBloodCollect = new List<BloodCollectionDetails>();
    List<BloodCapturedDetials> lstBloodCapture = new List<BloodCapturedDetials>();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtHR.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtBP1.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtBP2.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtSaturation.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtVolume.Attributes.Add("onKeyDown", "return validatenumber(event);");
        visitID = Convert.ToInt32(Request.QueryString["vid"]);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        if (!Page.IsPostBack)
        {
            LoadMetaData();
            
            returnCode = new BloodBank_BL(base.ContextInfo).GetDonorDetailsAndStatus(visitID, out lstPatientVisitDetails, out lstDonorStatus);
            if (lstPatientVisitDetails.Count() > 0)
            {
                lblNameValue.Text = lstPatientVisitDetails[0].PatientName;
                lblAgeOrSexValue.Text = lstPatientVisitDetails[0].Age;
                lblBloodGroupValue.Text = lstPatientVisitDetails[0].Labno;
                string visitType =Convert.ToString(lstPatientVisitDetails[0].VisitType);
                if (visitType == "0")
                {
                    lblVisitTypeValue.Text = "OP";
                }
                else
                {
                    lblVisitTypeValue.Text = "IP";
                }

            }
        }
    }
    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "BloodBagType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "BloodBagType"
                                  select child;

                ddlBagMake.DataSource = childItems4;
                ddlBagMake.DataTextField = "DisplayText";
                ddlBagMake.DataValueField = "Code";
                ddlBagMake.DataBind();
                ddlBagMake.Items.Insert(0, "--Select--");
                ddlBagMake.Items[0].Value = "0";
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    protected void OKButton_Click(object sender, EventArgs e)
    {
        mpe.Hide();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int StockReceivedTypeID = (Int32)StockReceivedTypes.BloodBank;
        BloodCollectionDetails objBloodCollect = new BloodCollectionDetails();
        objBloodCollect.PatientVisitID = visitID;
        objBloodCollect.BagNumber = txtBagNo.Text;
        objBloodCollect.BagType = ddlBagMake.SelectedItem.Text;
        objBloodCollect.BagCapacity = ddlBagCapacity.SelectedItem.Text;
        objBloodCollect.TubeID = TxtTubeID.Text;
        objBloodCollect.BatchNo = txtBatchNo.Text;
        objBloodCollect.BloodComponent = "0";
        for (int i = 0; i < rdoAntiCoagulants.Items.Count; i++)
        {
            if (rdoAntiCoagulants.Items[i].Selected == true)
            {
                objBloodCollect.AntiCoagulants = rdoAntiCoagulants.Items[i].Text;
            }
        }
        objBloodCollect.BloodGroup = lblBloodGroupValue.Text;
      
        objBloodCollect.CollectedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        objBloodCollect.SeperatedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone); 
        objBloodCollect.ReconstitutedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        objBloodCollect.ExpiryDate = Convert.ToDateTime(txtExpiry.Text);
        objBloodCollect.StorageSlot = txtStorageSlot.Text;
       
        lstBloodCollect.Add(objBloodCollect);
        foreach (string str in hdnRecords.Value.Split('^'))
        {
            if (str != "")
            {
                BloodCapturedDetials objBloodCapture = new BloodCapturedDetials();
                string[] list = str.Split('~');
                objBloodCapture.PatientVisitID = visitID;
                objBloodCapture.CapturedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objBloodCapture.HeartRate = list[1].ToString();
                objBloodCapture.BloodPressure = list[2].ToString();
                objBloodCapture.Saturation=Convert.ToInt32(list[3]);
                objBloodCapture.Volume = Convert.ToInt32(list[4]);
                objBloodCapture.Condition = list[5].ToString();
                lstBloodCapture.Add(objBloodCapture);
            }
        }
        int RoleID=0;
        returnCode = new BloodBank_BL(base.ContextInfo).InsertBloodCollectionDetails(visitID, lstBloodCollect, lstBloodCapture, OrgID, ILocationID, LID, RoleID, InventoryLocationID);
        if (returnCode > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "BloodCollection", "alert('Details captured successfully');", true);
        }
        new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

        Navigation navigation = new Navigation();
        Role role = new Role();
        role.RoleID = base.RoleID;
        List<Role> userRoles = new List<Role>();
        userRoles.Add(role);
        string relPagePath = string.Empty;
        returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
        if (returnCode == 0)
        {
            Response.Redirect(Request.ApplicationPath + relPagePath, true);
        }
    }
}
