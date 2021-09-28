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
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using System.Text;

public partial class ClinicalTrial_CTBulkRegistration : BasePage
{

    ClinicalTrail_BL CT_BL ;
    List<ControlMappingDetails> lstTempControlSavedValues;
    List<ControlMappingDetails> lstControlMappingDetails;
    List<ControlMappingDetails> lstControlMappingValues;
    ControlMappingDetails objControlMappingDetails;
    object objControls;
    Control pControls;

    Patient objPatient = new Patient();
    string AgeUnit = string.Empty;
    int AgeValue = 0;
    int ClientID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        if (!IsPostBack)
        { 
            long Eid = -1;
            string Res = string.Empty;
            loadClient();
            loadRateType();
            SetSiteClientID();
            LoadShippingCondition();
            SetContext();
            LoadMeatData();
            
            SetDept();
            hdnCollectedDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");
            hdnOrgID.Value = OrgID.ToString();
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
    public void SetSiteClientID()
    {
        string IsChildCTOrg = string.Empty;
        IsChildCTOrg = GetConfigValue("CTCHILDORG", OrgID);
        if (IsChildCTOrg == "Y")
        {
            string TypeLevel = "SITELEVEL";
            int AddressID = ILocationID;
            long SiteClientID=-1;
            List<Organization> lstOrganization = new List<Organization>();
            new ClinicalTrail_BL(base.ContextInfo).GetOrgDetailsWithTypeLevel(AddressID, TypeLevel, out lstOrganization);
            if (lstOrganization.Count > 0)
            {
                SiteClientID = lstOrganization[0].ReferTypeID;
                hdnClientID.Value = SiteClientID.ToString();
            }
            TdSiteName1.Attributes.Add("style", "display:none");
            TdSiteName2.Attributes.Add("style", "display:none");

        }

    }
    public void Testing()
    {
        List<PatientInvestigation> lstSampleDept = new List<PatientInvestigation>();
        List<PatientInvSample> lstPatInvSample = new List<PatientInvSample>();
        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(3, OrgID, RoleID, "6f1abb3c-1cb6-48db-a829-9ce97ae3037f", out lstSampleDept, out lstPatInvSample);
        List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();

        IEnumerable<InvDeptSamples> FilterValue = (from list in lstSampleDept
                                                   group list by new
                                                   {
                                                       list.DeptID,
                                                       list.OrgID

                                                   } into g1
                                                   select new InvDeptSamples
                                                   {
                                                       DeptID = g1.Key.DeptID,
                                                       OrgID = g1.Key.OrgID,
                                                       PatientVisitID = 123456

                                                   }).ToList();


        lstDeptSamples = FilterValue.ToList();
        foreach (InvDeptSamples ob in lstDeptSamples)
        {
            ob.PatientVisitID = 789123;
        }
        lstDeptSamples = lstDeptSamples.ToList();

    }
    public void SetDept()
    {
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<InvDeptMaster> lstRoleDeptMap = new List<InvDeptMaster>();
        int DeptID = 0;
        new Role_BL(base.ContextInfo).GetRoleLocation(OrgID, RoleID, LID, out lstLocation, out lstRoleDeptMap);
        if (lstRoleDeptMap.Count > 0)
        {
            hdnDeptID.Value = Convert.ToString(lstRoleDeptMap[0].DeptID);
        }
        else
        {
            hdnDeptID.Value = "0";
        }
    }
    public void LoadShippingCondition()
    {
        List<ShippingConditionMaster> lstShippingConditionMaster = new List<ShippingConditionMaster>();
        CT_BL.GetShippingCondition(OrgID, out lstShippingConditionMaster);
        if (lstShippingConditionMaster.Count > 0)
        {
            //ddlShippingCondtion.DataTextField = "ConditionDesc";
            //ddlShippingCondtion.DataValueField = "ShippingConditionID";
            //ddlShippingCondtion.DataSource = lstShippingConditionMaster;
            //ddlShippingCondtion.DataBind();
            //ddlShippingCondtion.Items.Insert(0, "--Select--");
            //ddlShippingCondtion.Items[0].Value = "0";
            ShippingConditionMaster lstObj = new ShippingConditionMaster();
            lstObj.ShippingConditionID = 0;
            lstObj.ConditionDesc = "--Select--";
            lstShippingConditionMaster.Add(lstObj);
            lstShippingConditionMaster = lstShippingConditionMaster.OrderBy(p => p.ShippingConditionID).ToList();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
            lstNameValuePair = (from l in lstShippingConditionMaster
                                select new NameValuePair { Name = l.ConditionDesc, Value = Convert.ToString(l.ShippingConditionID) }).ToList<NameValuePair>();
            hdnShippingCondition.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);
        }

    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();
        List<Patient> objPatient = new List<Patient>();
        int SiteID = 0;
        long EpisodeID = -1;
        int ShippingCondID = 0;
        int VisitID = 0;
        string AddInfo = string.Empty;
         SiteID = Int32.Parse(hdnClientID.Value); //1;// Int32.Parse(ddlSite.SelectedValue);
       
        // EpisodeID = Int32.Parse(hdnEpisodeID.Value);
        //ShippingCondID = Int32.Parse(ddlShippingCondtion.SelectedValue);
        //VisitID = (string.IsNullOrEmpty(txtVisitNo.Text)) == false ? Int32.Parse(txtVisitNo.Text) : 0;
        //AddInfo = txtAdditionalDetails.Text; 
        //CT_BL.SaveEpiContainerTracking(SiteID, EpisodeID, ShippingCondID, VisitID, AddInfo, OrgID,LID);

        //JavaScriptSerializer serializer = new JavaScriptSerializer();
        //string strLstobjPatient = hdnLstobjPatient.Value;
        //objPatient = serializer.Deserialize<List<Patient>>(strLstobjPatient);
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;

         GetPatientDetails();
        // Testing();

        
    }

    public void SetContext()
    {
        string ClientID = hdnClientID.Value;
        //AutoCompleteSittingEpisode.ContextKey = OrgID.ToString() +""+ ClientID;
        // AutoCompleteSittingEpisode.ContextKey =  OrgID.ToString()+""+;
        AutoCompleteExtenderClientCorp.ContextKey = "SIT";
        AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + "~-1";

        SetAutoCompleteSittingEpisode();
        string BaseClientID = hdnBaseClientID.Value;
        hdnSelectedClientClientID.Value = hdnBaseClientID.Value;
        string IsMapped = "N";
        string FeeType = "COM";
        string sval = FeeType + "~" + BaseClientID + "~" + IsMapped + "~" + "";
        GeneralBillItemsAutoCompleteExtender.ContextKey = sval;
    }
    public void SetAutoCompleteSittingEpisode()
    {
        var pOrgID = OrgID;
        var pClinetID = ILocationID;
        hdnOrgID.Value=OrgID.ToString(); 
        string sval = pOrgID + "~" + pClinetID + "~" + "COM";
        AutoCompleteSittingEpisode.ContextKey = sval;

    }

    public void ClearField()
    {
        txtEpisodeName.Text = "";
        //txtVisitNo.Text = "";
        //txtAdditionalDetails.Text = "";
        //ddlShippingCondtion.SelectedIndex = 0;
        //ddlSite.SelectedIndex = 0;
        hdnClientID.Value = "";
        txtClient.Text = "";

    }

    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "DateAttributes,Gender";
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
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedValue = "M";
                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "PatientStatusinCollection"
                                  select child;

                if (childItems2.Count() > 0)
                {
                    ddlPStatus.DataSource = childItems2;
                    ddlPStatus.DataTextField = "DisplayText";
                    ddlPStatus.DataValueField = "Code";
                    ddlPStatus.DataBind();
                    ddlPStatus.Items.Insert(0, "--Select--");
                    ddlPStatus.Items[0].Value = "0";
                }

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType" && child.Code!="-1"
                                  select child;

                if (childItems3.Count() > 0)
                {
                    ddlVType.DataSource = childItems3;
                    ddlVType.DataTextField = "DisplayText";
                    ddlVType.DataValueField = "Code";
                    ddlVType.DataBind();
                    //ddlVType.Items.Insert(0, "--Select--");
                    //ddlVType.Items[0].Value = "0";
                }

            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    public void GetPatientDetails()
    {         
        List<Patient> lstobjPatientCollection = new List<Patient>();
        List<PatientDueChart> lstPatientDueChartCollection = new List<PatientDueChart>();
        List<OrderedInvestigations> lstInvCollection = new List<OrderedInvestigations>();
        List<FinalBill> objFinalBillCollection = new List<FinalBill>();

        List<PatientInvSample> lstPatientInvSampleCollection = new List<PatientInvSample>();
        List<SampleTracker> lstSampleTrackerCollection = new List<SampleTracker>();
        List<PatientInvSampleMapping> lstSampleMappingCollection = new List<PatientInvSampleMapping>();
        List<InvestigationValues> lstinvValuesCollection = new List<InvestigationValues>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

        //Empty List
        List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
        List<ControlMappingDetails> lstControlSavedValues = new List<ControlMappingDetails>();
        DataTable dtAmountReceivedDet = null;

        try
        {

            //Hidden to List
            List<Patient> lstobjPatient = new List<Patient>();
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            List<FinalBill> objFinalBill = new List<FinalBill>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
            List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            string strLstobjPatient = hdnLstobjPatient.Value;
            lstobjPatient = serializer.Deserialize<List<Patient>>(strLstobjPatient);

            string strlstPatientDueChart = hdnLslstPatientDueChart.Value;
            lstPatientDueChart = serializer.Deserialize<List<PatientDueChart>>(strlstPatientDueChart);

            string strLstlstInv = hdnLslstInv.Value;
            lstInv = serializer.Deserialize<List<OrderedInvestigations>>(strLstlstInv);

            string strLstobjFinalBill = hdnLslstFinalBill.Value;
            objFinalBill = serializer.Deserialize<List<FinalBill>>(strLstobjFinalBill);

            string strlstPatientInvSample = hdnLslstPatientInvSample.Value;
            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strlstPatientInvSample);

            string strlstInvestigationValues = hdnLslstInvestigationValues.Value;
            lstInvestigationValues = serializer.Deserialize<List<InvestigationValues>>(strlstInvestigationValues);

            string strlstPatientInvSampleMapping = hdnLslstPatientInvSampleMapping.Value;
            lstPatientInvSampleMapping = serializer.Deserialize<List<PatientInvSampleMapping>>(strlstPatientInvSampleMapping);
            /******Added by Vijayalakshmi.M***********/
            string StatFlag = string.Empty;
            string ClientFlag = string.Empty;

            if (!string.IsNullOrEmpty(hdnCheckFlag.Value))
            {
                StatFlag = hdnCheckFlag.Value;
            }
            if (!string.IsNullOrEmpty(hdnClientFlag.Value))
            {
                ClientFlag = hdnClientFlag.Value;
            }


            #region GeneralItems
            long ReferedPhyID = -1;
            int RefPhySpecialityID = 0;
            int pSpecialityID = 0;
            string ReferralType = "";
            string paymentstatus = "Paid";
            //dtAmountReceivedDet = Empty;
            int SavePicture = 0;
            string sVal = "";
            string IsReceptionPhlebotomist = "Y";

            ///  long EpisodeVisitID = 2;
            // long   VisitTrackID  = 0 ;
            int SiteID = 0;
            string VisitSampleStatus = "Fasting";
            //dtSampleDate = "{19/11/2012 00:00:00}";
            //   int ConsignmentNo = 27;
            long EpisodeID = Convert.ToInt64(hdnEpisodeID.Value);//2
            DateTime dtSampleDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            SiteID = Int32.Parse(hdnClientID.Value);
            //lstControlSavedValues = Empty;
            #endregion 

            foreach (Patient obj in lstobjPatient)
            {
                Patient patient = new Patient();
                string GUID = Guid.NewGuid().ToString();
                string StudyInstanceUId = CreateUniqueDecimalString();
                #region PatientList
                short CountryID;
                short StateID;
                PatientAddress PA = new PatientAddress();
                Int16 age = 0;
                DateTime DOB = new DateTime();
                // objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();

                List<PatientAddress> pAddresses = new List<PatientAddress>();

                string[] SplitAge = obj.Age.Split('~');
                AgeValue = Convert.ToInt32(SplitAge[0]);
                if (SplitAge[1].Trim() == "Day(s)")
                {
                    AgeUnit = "D";
                }
                else if (SplitAge[1].Trim() == "Week(s)")
                {
                    AgeUnit = "W";
                }
                else if (SplitAge[1].Trim() == "Month(s)")
                {
                    AgeUnit = "M";
                }
                else
                {
                    AgeUnit = "Y";
                }

                string finalPName = obj.Name.Trim();


                patient.PatientID = obj.PatientID;// Convert.ToInt64(hdnPatientID.Value);
                patient.OrgID = OrgID;
                patient.CreatedBy = LID;
                patient.Name = finalPName;
                patient.TITLECode = Convert.ToByte(obj.SEX == "M" ? 7 : 2); //Convert.ToByte(ddSalutation.SelectedValue); Make Default Value
                //patient.SEX = ddlSex.SelectedValue;
                patient.SEX = obj.SEX;// ddlSex.SelectedValue;
                DOB = new DateTime(1800, 1, 1);
                // tDOB.Text = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
                patient.DOB = obj.DOB;// Convert.ToDateTime(tDOB.Text);
                //Int16.TryParse(txtDOBNos.Text.Trim(), out age);
                patient.Age = obj.Age;// age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                patient.PatientNumber = obj.PatientNumber;// hdnPatientNumber.Value;

                PA.Add1 = "";
                PA.Add2 = "";
                PA.City = "Chennai";
                patient.Add3 = "";
                PA.AddressType = "P";
                PA.LandLineNumber = "";
                PA.MobileNumber = "";
                //hdnMobileNumber.Value = "";
                CountryID = 75;
                StateID = 31;

                PA.CountryID = CountryID;
                PA.StateID = StateID;
                pAddresses.Add(PA);
                patient.PatientAddress = pAddresses;
                //patient.MartialStatus = ddMarital.SelectedValue.ToString();
                patient.CompressedName = finalPName.ToString();
                patient.Nationality = 81;
                patient.StateID = StateID;
                patient.CountryID = CountryID;
                patient.PostalCode = "";
                patient.RegistrationFee = 0;
                patient.SmartCardNumber = "0";
                patient.RelationName = "";
                patient.RelationTypeId = 0;
                patient.Race = "";
                patient.EMail = "";
                patient.VisitPurposeID = 3;
                ClientID = hdnClientID.Value == "-1" ? Convert.ToInt32(hdnBaseClientID.Value) : Convert.ToInt32(hdnClientID.Value);
                patient.ClientID = ClientID;
                patient.SecuredCode = System.Guid.NewGuid().ToString();
                patient.RateID = Convert.ToInt32(hdnRateID.Value);
                //patient.PriorityID = ddlPriority.SelectedValue;
                patient.ReferingPhysicianName = "";
                //patient.ReferedHospitalID = Convert.ToInt32(hdfReferalHospitalID.Value);
                patient.ReferedHospitalName = "";
                patient.TPAID = -1;// Convert.ToInt64(hdnTPAID.Value);
                patient.TPAName = "";
                patient.TypeName = "CRP";// hdnClientType.Value;
                patient.TPAAttributes = "";
                patient.PatientVisitID = 0;
                patient.PatientHistory = "";// txtPatientHistory.Text.Trim();
                patient.PatientIdentifyID = obj.PatientIdentifyID;

                patient.AgeValue = AgeValue;
                patient.AgeUnit = AgeUnit;
                patient.EpisodeVisitId = obj.EpisodeVisitId;
                patient.ReferedHospitalID = obj.ReferedHospitalID;
                patient.GUID = GUID;
                patient.RegistrationRemarks = string.Empty;
                patient.ILocationID = ILocationID;
                int taskactionID = (int)TaskHelper.TaskAction.CollectSample;
                patient.TaskactionID = taskactionID;
                patient.URNO = obj.URNO;
                patient.URNTypeId = 7;
                patient.URNofId = 1;
                patient.VistTypeID = obj.VistTypeID;
                patient.PStatusID = obj.PStatusID;
                lstobjPatientCollection.Add(patient);
                #endregion
                #region PatientDueChart
                foreach (PatientDueChart obj1 in lstPatientDueChart.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    PatientDueChart PatientDueChart = new PatientDueChart();

                    PatientDueChart.FeeType = obj1.FeeType;
                    PatientDueChart.FeeID = obj1.FeeID;
                    PatientDueChart.Description = obj1.Description;
                    PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);// obj1.FromDate;
                    PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);// obj1.ToDate;
                    PatientDueChart.Status = obj1.Status;
                    PatientDueChart.Unit = obj1.Unit;
                    PatientDueChart.Amount = obj1.Amount;
                    PatientDueChart.PatientIdentifyID = obj1.PatientIdentifyID;

                    lstPatientDueChartCollection.Add(PatientDueChart);
                }
                #endregion
                #region OrderedInvestigations
                foreach (OrderedInvestigations obj2 in lstInv.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    OrderedInvestigations OrderedInvestigations = new OrderedInvestigations();
                    OrderedInvestigations.Name = obj2.Name;
                    OrderedInvestigations.ID = obj2.ID;
                    OrderedInvestigations.Status = obj2.Status;
                    OrderedInvestigations.Type = obj2.Type;
                    OrderedInvestigations.OrgID = OrgID;
                    OrderedInvestigations.StudyInstanceUId = StudyInstanceUId;
                    OrderedInvestigations.UID = GUID;
                    OrderedInvestigations.PatientIdentifyID = obj2.PatientIdentifyID;

                    lstInvCollection.Add(OrderedInvestigations);
                }
                #endregion
                #region FinalBill
                foreach (FinalBill obj3 in objFinalBill.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    FinalBill FinalBill = new FinalBill();

                    FinalBill.OrgAddressID = ILocationID;
                   
                    
                    FinalBill.GrossBillValue = obj3.GrossBillValue;
                    FinalBill.DiscountAmount = 0;
                    FinalBill.DiscountReason = "";
                    FinalBill.DiscountApprovedBy = 0;
                    FinalBill.TaxAmount = 0;
                    FinalBill.ServiceCharge = 0;
                    FinalBill.RoundOff = 0;
                    FinalBill.NetValue = obj3.NetValue;
                    FinalBill.Due = obj3.Due;
                    FinalBill.IsCreditBill = obj3.IsCreditBill;
                    //FinalBill.DespatchMode = string.Empty;
                    DateTime ReportCommitedDate = Convert.ToDateTime("01/01/1753");
                    FinalBill.TATDate = ReportCommitedDate;
                    FinalBill.CreatedBy = LID;
                    FinalBill.EDCess = 0;
                    FinalBill.SHEDCess = 0;
                    FinalBill.PatientIdentifyID = obj3.PatientIdentifyID;


                    objFinalBillCollection.Add(FinalBill);
                }

               

                #endregion
                #region patientInvSample
                foreach (PatientInvSample obj4 in lstPatientInvSample.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    PatientInvSample PatientInvSample = new PatientInvSample();
                    //PatientInvSample.PatientVisitID = 14;
                    PatientInvSample.SampleID = obj4.SampleID;
                    PatientInvSample.SampleContainerID = obj4.SampleContainerID;
                    PatientInvSample.SampleConditionID = obj4.SampleConditionID;
                    PatientInvSample.CollectedDateTime = obj4.CollectedDateTime;
                    PatientInvSample.LocationName = obj4.LocationName;
                    PatientInvSample.RecSampleLocID = obj4.RecSampleLocID;
                    PatientInvSample.SampleCode = obj4.SampleID;
                    PatientInvSample.InvSampleStatusDesc = obj4.InvSampleStatusDesc;
                    PatientInvSample.BarcodeNumber = obj4.BarcodeNumber;
                    PatientInvSample.VmUnitID = obj4.VmUnitID;
                    PatientInvSample.VmValue = obj4.VmValue;
                    PatientInvSample.PatientIdentifyID = obj4.PatientIdentifyID;
                    PatientInvSample.OrgID = OrgID;
                    PatientInvSample.UID = GUID;
                    PatientInvSample.CollectedLocID = ILocationID;
                    PatientInvSample.CreatedBy = RoleID;

                    PatientInvSample.InvSampleStatusID = 0;
                    PatientInvSample.Recorgid = 0;
                    PatientInvSample.SampleDesc = "";
                    PatientInvSample.SampleMappingID = 0;
                    PatientInvSample.PatientIdentifyID = obj4.PatientIdentifyID;

                    lstPatientInvSampleCollection.Add(PatientInvSample);

                    SampleTracker lstSampleTracker = new SampleTracker();
                    //lstSampleTracker.PatientVisitID = 14;// Get From lstobjPatientCollection
                    lstSampleTracker.DeptID = Convert.ToInt32(hdnDeptID.Value);
                    lstSampleTracker.CreatedBy = LID;
                    lstSampleTracker.OrgID = OrgID;
                    lstSampleTracker.CollectedIn = OrgID;
                    lstSampleTracker.InvSampleStatusID = 1;
                    lstSampleTracker.Reason = "";
                    lstSampleTracker.SampleID = obj4.SampleID;

                    lstSampleTracker.Barcode = "";
                    lstSampleTracker.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    lstSampleTracker.CurrentOrgID = 0;
                    lstSampleTracker.IPInvSampleCollectionMasterID = 0;
                    lstSampleTracker.SampleTrackerID = 0;
                    lstSampleTracker.PatientIdentifyID = obj4.PatientIdentifyID;
                    lstSampleTrackerCollection.Add(lstSampleTracker);


                    //PatientInvSampleMapping lSampleMapping = new PatientInvSampleMapping();
                    //lSampleMapping.ID = obj.RelationTypeId;
                    //lSampleMapping.SampleID = obj4.SampleID;
                    //lSampleMapping.Type = "PKG";
                    //lSampleMapping.Barcode = "0";
                    //// lSampleMapping.VisitID = 14;
                    //lSampleMapping.OrgID = OrgID;
                    //lSampleMapping.UID = GUID;

                    //lSampleMapping.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    //lSampleMapping.DeptID = 0;
                    //lSampleMapping.SampleInstanceID = 0;
                    //lSampleMapping.SampleMappingID = 0;
                    //lSampleMapping.PatientIdentifyID = obj4.PatientIdentifyID;
                    //lstSampleMappingCollection.Add(lSampleMapping);


                    //InvestigationValues linvValues = new InvestigationValues();
                    //linvValues.InvestigationID = obj.RelationTypeId;
                    //linvValues.Orgid = OrgID;
                    //linvValues.Status = "PKG";
                    //linvValues.Value = "Collected";
                    //linvValues.ReferralID = -1;
                    //linvValues.SequenceNo = OrgID;
                    //linvValues.PatientIdentifyID = obj4.PatientIdentifyID;
                    //lstinvValuesCollection.Add(linvValues);

                }
                #endregion
                #region PatientInvSampleMapping

                foreach (PatientInvSampleMapping obj2 in lstPatientInvSampleMapping.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    PatientInvSampleMapping lSampleMapping = new PatientInvSampleMapping();
                    lSampleMapping.ID = obj2.ID;
                    lSampleMapping.SampleID = obj2.SampleID;
                    lSampleMapping.Type = obj2.Type;
                    lSampleMapping.Barcode = obj2.Barcode;
                    // lSampleMapping.VisitID = 14;
                    lSampleMapping.OrgID = OrgID;
                    lSampleMapping.UID = GUID;

                    lSampleMapping.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    lSampleMapping.DeptID = 0;
                    lSampleMapping.SampleInstanceID = 0;
                    lSampleMapping.SampleMappingID = 0;
                    lSampleMapping.PatientIdentifyID = obj2.PatientIdentifyID;
                    

                    lstSampleMappingCollection.Add(lSampleMapping);
                }
                #endregion
                #region InvestigationValues

                foreach (InvestigationValues obj2 in lstInvestigationValues.FindAll(p => p.PatientIdentifyID == obj.PatientIdentifyID))
                {
                    InvestigationValues linvValues = new InvestigationValues();

                    linvValues.InvestigationID = obj2.InvestigationID;
                    linvValues.Orgid = OrgID;
                    linvValues.Status = obj2.Status;
                    linvValues.Value = obj2.Value;
                    linvValues.ReferralID = obj2.ReferralID;
                    linvValues.SequenceNo = OrgID;
                    linvValues.PatientIdentifyID = obj.PatientIdentifyID;
                    lstinvValuesCollection.Add(linvValues);
                }
                #endregion

                //new Patient_BL(base.ContextInfo).InsertPatientBilling(objPatient, objFinalBill, ReferedPhyID,
                //                                 RefPhySpecialityID, pSpecialityID, lstPatientDueChart, AgeValue, AgeUnit,
                //                                 pSpecialityID, ReferralType, paymentstatus, GUID, dtAmountReceivedDet, lstInv, lstTaxDetails,
                //                                 out lstBillingDetails, out returnStatus, SavePicture, sVal, RoleID, LID, PageContextDetails,
                //                                 IsReceptionPhlebotomist, 1, "", Convert.EpisodeID,
                //                                 Convert.ToInt64(hdnEpisodeVisitID.Value), Convert.ToInt64(hdnVisitTrackID.Value), SiteID, VisitSampleStatus,

            }
            List<FinalBill> objFinalBillCollectionGrouped = new List<FinalBill>();
            List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
            if (lstPatientInvSample.Count > 0)
            {
                IEnumerable<FinalBill> FinalBillFilterValue = (from list in objFinalBillCollection
                                                      group list by new
                                                      {
                                                          list.OrgAddressID,
                                                          
                                                          list.GrossBillValue,
                                                          list.DiscountAmount,
                                                          list.DiscountReason,
                                                          list.DiscountApprovedBy,
                                                          list.TaxAmount,
                                                          list.ServiceCharge,
                                                          list.RoundOff,
                                                          list.NetValue,
                                                          list.Due,
                                                          list.IsCreditBill,
                                                          //list.DespatchMode,
                                                          list.TATDate,
                                                          list.CreatedBy,
                                                          list.EDCess,
                                                          list.SHEDCess,
                                                          list.PatientIdentifyID
                                                      } into g1
                                                      select new FinalBill
                                                      {
                                                          OrgAddressID = g1.Key.OrgAddressID,
                                                          
                                                          
                                                          GrossBillValue = g1.Sum(Q => Q.GrossBillValue),
                                                          DiscountAmount = g1.Sum(Q => Q.DiscountAmount),
                                                          DiscountReason = g1.Key.DiscountReason,
                                                          DiscountApprovedBy = g1.Key.DiscountApprovedBy,
                                                          TaxAmount = g1.Sum(Q => Q.TaxAmount),
                                                          ServiceCharge = g1.Sum(Q => Q.ServiceCharge),
                                                          RoundOff = g1.Sum(Q => Q.RoundOff),
                                                          NetValue = g1.Sum(Q => Q.NetValue),
                                                          Due = g1.Sum(Q => Q.Due),
                                                          IsCreditBill = g1.Key.IsCreditBill,
                                                          //DespatchMode = g1.Key.DespatchMode,
                                                          TATDate = g1.Key.TATDate,
                                                          CreatedBy = g1.Key.CreatedBy,
                                                          EDCess = g1.Key.EDCess,
                                                          SHEDCess = g1.Key.SHEDCess,
                                                          PatientIdentifyID = g1.Key.PatientIdentifyID

                                                      }).ToList();

                foreach (FinalBill ob in FinalBillFilterValue)
                {
                    objFinalBillCollectionGrouped.Add(ob);

                }
            }

            #region Consginment Creation
            List<PatientInvSample> lstPastConsignmentwithSampleCondition = new List<PatientInvSample>();
            string strConsignmentwithSampleCondition = hdnConsignmentwithSampleCondition.Value;
            lstPastConsignmentwithSampleCondition = serializer.Deserialize<List<PatientInvSample>>(strConsignmentwithSampleCondition);


            string ConsignmentNo = string.Empty;
            long RegTrackID = -1;
            long CurrentRegTrackID = -1;
            Int64.TryParse(hdnConsignmentNo.Value, out CurrentRegTrackID);
            CurrentRegTrackID = CurrentRegTrackID == 0 ? -1 : CurrentRegTrackID;

            List<PatientInvSample> lstSampleCondition = new List<PatientInvSample>();

            IEnumerable<PatientInvSample> FilterValue = (from list in lstPatientInvSampleCollection
                                                         group list by new
                                                         {
                                                             list.SampleConditionID

                                                         } into g1
                                                         select new PatientInvSample
                                                         {
                                                             SampleConditionID = g1.Key.SampleConditionID

                                                         }).ToList();

            lstSampleCondition = FilterValue.ToList();



            //  lstConsignmentwithSampleCondition = lstConsignmentwithSampleCondition.Where(c => lstSampleCondition.Exists(cr => cr.SampleConditionID != c.SampleConditionID)).ToList();


            if (lstPastConsignmentwithSampleCondition != null)
            {
                lstSampleCondition = lstSampleCondition.Where(c => !lstPastConsignmentwithSampleCondition.Exists(cr => cr.SampleConditionID == c.SampleConditionID)).ToList();


                foreach (PatientInvSample obj in lstPastConsignmentwithSampleCondition)
                {
                    foreach (PatientInvSample ObjPatientInvSampleCollection in lstPatientInvSampleCollection.Where(p => p.SampleConditionID == obj.SampleConditionID))
                    {
                        ObjPatientInvSampleCollection.ConsignmentNo = obj.ConsignmentNo;
                    }
                }
            }

            #endregion
            List<Attune.Podium.BusinessEntities.PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
            List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();  

            long ret = CT_BL.InsertPatientBilling(lstobjPatientCollection, objFinalBillCollectionGrouped, lstPatientDueChartCollection, lstInvCollection, lstTaxDetails, lstControlSavedValues, dtAmountReceivedDet,
                   OrgID, ReferedPhyID, RefPhySpecialityID, pSpecialityID, ReferralType, paymentstatus, SavePicture, sVal, RoleID, LID, PageContextDetails,
                   IsReceptionPhlebotomist, EpisodeID, SiteID, VisitSampleStatus, dtSampleDate,
                   lstPatientInvSampleCollection, lstSampleTrackerCollection, lstSampleMappingCollection, lstinvValuesCollection, out ConsignmentNo,
                   InventoryLocationID, lstSampleCondition, CurrentRegTrackID, out RegTrackID, lstDispatchDetails, lstVisitClientMapping, "", "", lstPatientDiscount, lstPatientRedemDetails, lstPkgandGrps, StatFlag, ClientFlag,0,"","","","");

            //ClearField();
            string AlertMesg = "Subject details saved sucessfully under the Registration Track ID: " + RegTrackID +", and The Consignment Numbers are:{" + ConsignmentNo + "}";
            string PageUrl = Request.ApplicationPath + @"/ClinicalTrial/CTBulkRegistration.aspx?IsPopup=Y";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient & Billing details in CT Bult Registration.", ex);
        }
    }


    ////public void SampleCollection()
    ////{
    ////    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    ////    if (lstBillingDetails.Count > 0 && returnStatus >= 0)
    ////    {
    ////        long patientVisitID = lstBillingDetails[0].VisitID; //12,13
    ////        string Labno = lstBillingDetails[0].LabNo; //1700,1701
    ////        long FinalBillID = lstBillingDetails[0].FinalBillID;//12,13
    ////        long patientID = lstBillingDetails[0].PatientID; //12,13
    ////        string gUID = "gUID";//32baaa54-4903-4fa2-bbda-95d5ee682df2,62146f29-faa8-410b-ab47-1f30f79261b4
    ////        int taskactionID = (int)TaskHelper.TaskAction.CollectSample;

    ////        hdnPageUrl.Value = "/Lab/InvestigationSample.aspx?pid=" + patientID.ToString()
    ////                                       + "&vid=" + patientVisitID.ToString()
    ////                                       + "&gUID=" + gUID
    ////                                       + "&taskactionid=" + taskactionID
    ////                                       + "&LNo=" + lstBillingDetails[0].LabNo
    ////                                       + "&RNo" + lstBillingDetails[0].LabNo
    ////                                       + "&POrgID" + OrgID.ToString()
    ////                                       + "&IsCT=Y";
    ////        //////////SampleID,SampleContainerID
    ////        List<PatientInvSample> lstPatientInvSampleCollection = new List<PatientInvSample>();
    ////        PatientInvSample lstPatientInvSample = new PatientInvSample();

    ////        lstPatientInvSample.PatientVisitID = 14;//Get From lstobjPatientCollection
    ////        lstPatientInvSample.OrgID = 67; //General
    ////        lstPatientInvSample.CreatedBy = LID; //General
    ////        lstPatientInvSample.CollectedLocID = 67;  //General
    ////        lstPatientInvSample.SampleRelationshipID = 0; //Default
    ////        lstPatientInvSample.UID = "acaa868e-29a8-46a2-b80c-8f854d38e8c1"; // Get From lstobjPatientCollection
    ////        lstPatientInvSample.SampleID = 0; //Get From lstSample
    ////        lstPatientInvSample.SampleContainerID = 1; //Get From lstSample
    ////        lstPatientInvSample.InvSampleStatusDesc = "Collected"; //Default
    ////        lstPatientInvSample.BarcodeNumber = "0";//Default
    ////        lstPatientInvSample.LocationName = "Metropolis CT Center(TODI ESTATE)";//Get From lstSample
    ////        lstPatientInvSample.RecSampleLocID = 67; //Get From lstSample
    ////        lstPatientInvSample.CollectedDateTime = DateTime.Parse("20/11/2012 16:39:2"); //Get From lstSample
    ////        lstPatientInvSample.VmUnitID = 0;//Default
    ////        lstPatientInvSample.VmValue = 0;//Default
    ////        lstPatientInvSample.SampleConditionID = 1;  //Get From lstSample

    ////        lstPatientInvSample.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //Default
    ////        lstPatientInvSample.InvSampleStatusID = 0; //Default
    ////        lstPatientInvSample.Recorgid = 0; //Default
    ////        lstPatientInvSample.SampleDesc = ""; //Default
    ////        lstPatientInvSample.SampleMappingID = 0; //Default

    ////        lstPatientInvSampleCollection.Add(lstPatientInvSample);
    ////        ////////////////// SampleID,InvSampleStatusID
    ////        List<SampleTracker> lstSampleTrackerCollection = new List<SampleTracker>();
    ////        SampleTracker lstSampleTracker = new SampleTracker();

    ////        lstSampleTracker.PatientVisitID = 14;// Get From lstobjPatientCollection
    ////        lstSampleTracker.DeptID = 2357;//?
    ////        lstSampleTracker.CreatedBy = LID; //General
    ////        lstSampleTracker.OrgID = 67;   //General
    ////        lstSampleTracker.CollectedIn = 67; //General
    ////        lstSampleTracker.InvSampleStatusID = 1; //General
    ////        lstSampleTracker.Reason = "";//General
    ////        lstSampleTracker.SampleID = 1; //Get From lstSample

    ////        lstSampleTracker.Barcode = ""; //Default
    ////        lstSampleTracker.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //Default
    ////        lstSampleTracker.CurrentOrgID = 0; //Default
    ////        lstSampleTracker.IPInvSampleCollectionMasterID = 0; //Default
    ////        lstSampleTracker.SampleTrackerID = 0;//Default
    ////        lstSampleTrackerCollection.Add(lstSampleTracker);
    ////        //////////////////sampleID and SampleCOntainerID
    ////        List<PatientInvSampleMapping> lSampleMappingCollection = new List<PatientInvSampleMapping>();
    ////        PatientInvSampleMapping lSampleMapping = new PatientInvSampleMapping();

    ////        lSampleMapping.ID = 360;
    ////        lSampleMapping.SampleID = 1; //Get From lstSample
    ////        lSampleMapping.Type = "PKG";//Default
    ////        lSampleMapping.Barcode = "0";//Default
    ////        lSampleMapping.VisitID = 14;
    ////        lSampleMapping.OrgID = 67;//General
    ////        lSampleMapping.UID = "acaa868e-29a8-46a2-b80c-8f854d38e8c1"; //Get From lstSample


    ////        lSampleMapping.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);//Default
    ////        lSampleMapping.DeptID = 0;  //Default
    ////        lSampleMapping.SampleInstanceID = 0; //Default
    ////        lSampleMapping.SampleMappingID = 0; //Default

    ////        lSampleMappingCollection.Add(lSampleMapping);
    ////        /////////////////Same Data across all Samples
    ////        List<InvestigationValues> linvValuesCollection = new List<InvestigationValues>();
    ////        InvestigationValues linvValues = new InvestigationValues();
    ////        linvValues.InvestigationID = 360;
    ////        linvValues.Orgid = 67; //General
    ////        linvValues.Status = "PKG";//Default
    ////        linvValues.Value = "Collected";//Default
    ////        linvValues.ReferralID = -1; //Default
    ////        linvValues.SequenceNo = 67;//General

    ////        linvValuesCollection.Add(linvValues);


    ////    }
    ////}

    //protected void SaveSampleData()
    //{
    //    try
    //    {
    //        int status = -1;
    //        int upis = -1;
    //        long vid = Convert.ToInt64(hdnVisitID.Value);
    //        List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
    //        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    //        List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();
    //        Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
    //        List<InvestigationValues> linvValues = new List<InvestigationValues>();
    //        List<PatientInvSampleMapping> lSampleMapping = new List<PatientInvSampleMapping>();
    //        List<string> lstCollectedSampleStatus = new List<string>();
    //        InvDeptSamples eInvDeptSamples = new InvDeptSamples();

    //        JavaScriptSerializer serializer = new JavaScriptSerializer();
    //        string strLstPatientInvSample = hdnLstPatientInvSample.Value;
    //        string strLstSampleTracker = hdnLstSampleTracker.Value;
    //        string strLstPatientInvSampleMapping = hdnLstPatientInvSampleMapping.Value;
    //        string strLstInvestigationValues = hdnLstInvestigationValues.Value;
    //        string strLstCollectedSampleStatus = hdnLstCollectedSampleStatus.Value;
    //        string invStatus = string.Empty;
    //        string gUID = string.Empty;
    //        lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strLstPatientInvSample);
    //        lstSampleTracker = serializer.Deserialize<List<SampleTracker>>(strLstSampleTracker);
    //        lSampleMapping = serializer.Deserialize<List<PatientInvSampleMapping>>(strLstPatientInvSampleMapping);
    //        linvValues = serializer.Deserialize<List<InvestigationValues>>(strLstInvestigationValues);
    //        lstCollectedSampleStatus = serializer.Deserialize<List<string>>(strLstCollectedSampleStatus);
    //        gUID = hdnGuID.Value;
    //        foreach (DataListItem repDept in this.repDepts.Items)
    //        {
    //            CheckBox chkDept = repDept.FindControl("chkDept") as CheckBox;

    //            if (chkDept.Checked)
    //            {
    //                Label lbDeptID = repDept.FindControl("lblDeptID") as Label;
    //                eInvDeptSamples = new InvDeptSamples();
    //                eInvDeptSamples.PatientVisitID = vid;
    //                eInvDeptSamples.DeptID = Convert.ToInt32(lbDeptID.Text);
    //                eInvDeptSamples.OrgID = OrgID;
    //                lstDeptSamples.Add(eInvDeptSamples);
    //            }
    //        }


    //        if (lstSampleTracker.Count > 0 && lstDeptSamples.Count > 0)
    //        {
    //            string lstSampleId = string.Empty;
    //            returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, out status, out lstSampleId);
    //            if (status == 0)
    //            {
    //                int DeptID = 0;

    //                if (invStatus == String.Empty)
    //                {
    //                    new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
    //                }

    //                invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);

    //                invBL.InsertPatientSampleMapping(lSampleMapping, vid, OrgID, 0, LID, out status);
    //                string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
    //                if (IsBarCodeNeed == "Y")
    //                {
    //                    ctlCollectSample.IsBarcodeNeeded = true;
    //                }
    //                if (ctlCollectSample.IsBarcodeNeeded)
    //                {
    //                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + vid + "&sampleId=" + lstSampleId + "&guId=" + gUID + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
    //                }
    //                PrintBilling(Convert.ToInt64(hdnPatientID.Value), Convert.ToInt64(hdnVisitID.Value), Convert.ToInt64(hdnFinalBillID.Value), Convert.ToInt64(hdnVisitPurposeID.Value), txtClient.Text);
    //            }
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while generating work order in Lab Quick Billing", ex);

    //    }
    //}


    public void loadClient()
    {
        SharedInventorySales_BL inventorySalesBL = new SharedInventorySales_BL(base.ContextInfo);
        List<ClientMaster> lstclients = new List<ClientMaster>();
        inventorySalesBL.GetClientNames(OrgID, out lstclients);
        if (lstclients.Count > 0)
        {
            var temp = lstclients.FindAll(p => p.ClientCode == "GENERAL");
            if (lstclients.Count > 0)
            {
                hdnBaseClientID.Value = temp[0].ClientID.ToString();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "alert('No general Client associated this Organisation');", true);
        }
    }
    public void loadRateType()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
            if (lstRateMaster.Count > 0)
            {
                var temp = lstRateMaster.FindAll(p => p.RateCode == "GENERAL");
                if (temp.Count > 0)
                {
                    hdnBaseRateID.Value = temp[0].RateId.ToString();
                    hdnRateID.Value = temp[0].RateId.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}
