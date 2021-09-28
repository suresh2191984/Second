using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.TrustedOrg;
using System.IO;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.Collections;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using Attune.Podium.BillingEngine;
using Attune.Podium.PerformingNextAction;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;
using iTextSharp.tool.xml.html;
using iTextSharp.tool.xml.parser;
using iTextSharp.tool.xml.css;
using iTextSharp.tool.xml.pipeline.html;
using iTextSharp.tool.xml.pipeline.css;
using iTextSharp.tool.xml.pipeline.end;

using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;
using System.Web.Script.Serialization;
using System.Globalization;


public partial class Reception_RecheckRegisteredVisits : BasePage
{
    int startRowIndex = 1;
    int currentPageNo = 1;
    int _pageSize = 1;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    long returnCode = -1;
    long patientID = -1;
    long visitID = 0;
    string vType = string.Empty;
    long pvisitID = 0;
    string pPatientName = string.Empty;
    string pPatientNo = string.Empty;
    int OP, IP;
    string pVisitType = string.Empty;
    long FinalbillId = 0;
    string BillNumber = string.Empty;
    string Visitno = string.Empty;
    string Gen = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<PatientVisit> lsttotalPatientCount = new List<PatientVisit>();
    string pathname = string.Empty;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    public Reception_RecheckRegisteredVisits()
        : base("Reception\\RecheckRegisteredVisits.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {


        AutoCompleteExtender2.ContextKey = "zone" + '~' + "-1";
        AutoUser.ContextKey = OrgID.ToString();
        ddSalutation.Focus();
        hdnOrgID.Value = OrgID.ToString();
        txtAddress.Text = string.Empty;

        if (!Page.IsPostBack)
        {
            //txtPatientNumber.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //txtPname.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            ddlFileList.Attributes.Add("onchange", "return onChangeFile('" + ddlFileList.ClientID + "');");
            txtFrom.Attributes.Add("onchange", "ExcedDatevisitsearch('" + txtFrom.ClientID.ToString() + "','',0,0);ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            txtTo.Attributes.Add("onchange", "ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            AutoCompleteExtenderRefPhy1.ContextKey = "RPH";

            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");

         
            if (RoleName == RoleHelper.Patient)
            {
               // RHead.Visible = false;
                lblPatientNumber.Visible = false;
                txtPatientNumber.Visible = false;
                lblPatientName.Visible = false;
                txtPname.Visible = false;

            }
            else
            {
               // PatientHeader1.Visible = false;

            }
            
            grdResult.Visible = true;
            //DateTime dt = new DateTime();
            //dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            txtFrom.Text = OrgDateTimeZone;
            // txtFrom.Text = dt.ToString("MM-dd-yyyy") + " " + "00:00:00AM";
            txtTo.Text = OrgDateTimeZone;
            hdnEdit.Value = "Edit";
            string locationID = Convert.ToString(base.ILocationID);
            ddlocations.SelectedValue = locationID;
            LoadMetaData();
            LoadSpeciality();
            LoadDepartment();
            LoadLocation();
            Loadpatientdetails();
          
            Hide();
            DisplaypatientDetails();
            ddlStatus.SelectedValue = "1";
            Session["LastPageUrl"] = Request.Url.AbsolutePath.ToString();
            string configvalue = GetConfigValue("HideColumnForLab", OrgID);
            if (configvalue == "Y")
            {
                HideSpec.Visible = false;
                lblPatientNumber.Text = "Patient No/Visit No :";
                hdnspecdept.Value = configvalue;
            }

            vType = Request.QueryString["vType"];

            if (vType == "OP")
            {
                ddlType.SelectedValue = "OP";
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                GetPatientVisitDetails();
            }
            else if (vType == "IP")
            {
                ddlType.SelectedItem.Text = "IP";
                ddlType.SelectedValue = "IP";
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                GetPatientVisitDetails();
            }
            else
            {
                string temp = string.Empty;
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
                if (lstActionMaster.Count > 0)
                {
                    #region Add View State ActionList
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                }
                    #endregion
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
                if (lstActionMaster.Count > 0)
                {
                    #region Add View State ActionList
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    // ViewState.Add("ActionList", temp);
                }
                ViewState.Add("ActionList", temp);
                hdnCurrent.Value = "1";
                if (CID > 0)
                {
                    txtClientName.Text = UserName;
                    txtClientName.Attributes.Add("disabled", "true");
                }
                LoadGrid(e, 1, PageSize);

                    #endregion
            }

        }
        if (Page.IsPostBack)
        {
          //  Filter.Style.Add("display", "block");
        }
        //ddlFileList.Attributes.Add("onchange", "return onChangeFile('" + ddlFileList.ClientID + "');");
        AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        //  AutoCompleteExtenderRefPhy.ContextKey = "RPH" + "^" + OrgID + "^" + "0";
        AutoCompleteExtenderRefPhy.ContextKey = Convert.ToString(OrgID);
    }
    public void LoadLocation()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlocations.DataSource = LoginLoc;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
            else
            {
                ddlocations.DataSource = lstOrganizationAddress;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
        }
        ddlocations.Items.Insert(0, "--Select--");
        ddlocations.Items[0].Value = "0";
    }

    public void LoadDepartment()
    {
        long returnCode = -1;
        List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
        Master_BL obj = new Master_BL(base.ContextInfo);
        returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
        if (lstEmpDeptMaster.Count > 0)
        {
            ddlDepartment.DataSource = lstEmpDeptMaster;
            ddlDepartment.DataValueField = "Code";
            ddlDepartment.DataTextField = "EmpDeptName";
            ddlDepartment.DataBind();
        }
        ddlDepartment.Items.Insert(0, "--Select--");
        ddlDepartment.Items[0].Value = "0";
    }
    public void LoadSpeciality()
    {
        List<Speciality> lstSpeciality = new List<Speciality>();
        returnCode = new Speciality_BL(base.ContextInfo).GetSpeciality(OrgID, out lstSpeciality);
        if (lstSpeciality.Count > 0)
        {
            ddlspeciality.DataSource = lstSpeciality;
            ddlspeciality.DataTextField = "SpecialityName";
            ddlspeciality.DataValueField = "SpecialityID";
            ddlspeciality.DataBind();
        }
        ddlspeciality.Items.Insert(0, "--Select--");
        ddlspeciality.Items[0].Value = "0";
    }

    private void GetPatientVisitDetails()
    {
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        vType = Request.QueryString["vType"];
        if (vType == "OP")
        {
            pVisitType = "0";
        }
        else
        {
            if (vType == "IP")
            {
                pVisitType = "1";
            }
        }

        if (vType == null)
        {
            if (ddlType.SelectedItem.Text == "OP")
            {
                pVisitType = "0";
            }
            else
            {
                if (ddlType.SelectedItem.Text == "IP")
                {
                    pVisitType = "1";
                }
            }
        }




        //returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(patientID,0, OrgID,Convert.ToInt32(pVisitType), out lstPatientVisit, out pPatientName, out pPatientNo);

        int VisitID = 0;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(patientID, VisitID, OrgID, Convert.ToInt32(pVisitType), out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);


        if (patientID == 0)
        {
            txtPatientNumber.Enabled = true;
        }
        else
        {

            txtPatientNumber.Text = pPatientNo;
            txtPatientNumber.Enabled = false;
        }


        lblPName.Text = pPatientName;

        grdResult.DataSource = lstPatientVisit;
        grdResult.DataBind();
        if (lstPatientVisit != null && lstPatientVisit.Count > 0)
        {
            hdnVisitID.Value = Convert.ToString(lstPatientVisit[0].ParentVisitId);
            Visitno = lstPatientVisit[0].VisitNumber;
        }
        else
        {
            hdnVisitID.Value = "0";
            Visitno = "0";
        }
        PatientDetails();
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {


        if (e.NewPageIndex >= 0)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        startRowIndex = 1;
        hdnCurrent.Value = startRowIndex.ToString();
        hdnSearch.Value = "Y";
        LoadGrid(e, startRowIndex, PageSize);
        lblCurrent.Text = startRowIndex.ToString();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    #region Formtodb Date Conversion
    protected string FormtoDb(string val)
    {
        if (val != "")
        {
            string[] dd = val.Split('/');
            val = dd[1].Trim() + "/" + dd[0].Trim() + "/" + dd[2].Trim();
        }
        return val;
    }
    #endregion

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "VisitType,";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddlType.DataSource = childItems2;
                ddlType.DataTextField = "DisplayText";
                ddlType.DataValueField = "DisplayText";
                ddlType.DataBind();

            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data", ex);
            //edisp.Visible = true;
         //   ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void DisplaypatientDetails()
    {


        lblPatientName.Visible = true;
        lblAge.Visible = true;
        lblGender.Visible = true;
        lblPatientAddress.Visible = true;
        lblPatientAddress1.Visible = true;
        lblCity.Visible = true;
        lblDOB.Visible = true;
        lblMobile.Visible = true;
        lblLandline.Visible = true;
        lblEmailID.Visible = true;
        lblRefDr.Visible = true;
        //txtName.Attributes.Add("style", "display:None");
        //tDOB.Attributes.Add("style", "display:None");
        //ddlSex.Attributes.Add("style", "display:None");
        //txtDOBNos.Attributes.Add("style", "display:None");
        //txtPhone.Attributes.Add("style", "display:None");
        //txtEmail.Attributes.Add("style", "display:None");
        //txtInternalExternalPhysician.Attributes.Add("style", "display:None");
        //ddlDOBDWMY.Attributes.Add("style", "display:None");
        //btnEdit.Text = "Edit";

    }

    private void GenerateBarCodeOutput(string BarcodeType)
    {

        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        long patientVisitID = 0;
        patientVisitID = Convert.ToInt32(hdnVID.Value);
        if (BarcodeType == "Print_VisitBarCode_PrintVisitBarCode")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintVisitBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + patientVisitID + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.VisitNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
        }
        else if (BarcodeType == "Print_MRDBarCode_PrintMRDBarCode")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintVisitBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + patientVisitID + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.MRDNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
        }
    }

    protected void PrintNewPatientVisitDetailsXml(long patientID, long patientVisitID)
    {
        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<Patient> lstPatient = new List<Patient>();

        oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);
        oPatVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

        if (patientVisitID.Equals(-1))
        {
            patientVisitID = 0;
        }
        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("PatientIdentificationSheet");

                xw.WriteStartElement("VisitNo", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber)))
                {
                    xw.WriteString(lstPatientVisit[0].VisitNumber);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitDate", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MedicalRecordNo", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber)))
                {
                    xw.WriteString(lstPatientVisit[0].PatientNumber);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("PatientName", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].Name)))
                {
                    xw.WriteString(lstPatient[0].Name);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Location", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].PlaceOfBirth)))
                {
                    xw.WriteString(lstPatient[0].PlaceOfBirth);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("DOB", "");
                if (!string.IsNullOrEmpty(lstPatient[0].DOB.ToString()))
                {
                    xw.WriteString(lstPatient[0].DOB.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Age", "");
                if (!string.IsNullOrEmpty(lstPatient[0].Age))
                {
                    xw.WriteString(lstPatient[0].Age);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Sex", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].SEX)))
                {
                    xw.WriteString(lstPatient[0].SEX);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Religion", "");
                if (!string.IsNullOrEmpty(lstPatient[0].Religion))
                {
                    xw.WriteString(lstPatient[0].Religion);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Address", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].Address)))
                {
                    xw.WriteString(lstPatientVisit[0].Address);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("RTRW", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("Kelurahan", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("Kecamatan", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("City", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].City)))
                {
                    xw.WriteString(lstPatientVisit[0].City);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("State", "");

                if (!string.IsNullOrEmpty(lstPatient[0].StateName))
                {
                    xw.WriteString(lstPatient[0].StateName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("TelephoneNo", "");
                if (lstPatient.Count != 0 && lstPatient[0].MobileNumber != null)
                {
                    xw.WriteString(lstPatient[0].MobileNumber.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Country", "");
                if (!string.IsNullOrEmpty(lstPatient[0].CountryName))
                {
                    xw.WriteString(lstPatient[0].CountryName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("NoKTP", "");
                if (!string.IsNullOrEmpty(lstPatient[0].URNO))
                {
                    xw.WriteString(lstPatient[0].URNO);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Qualification", "");
                if (!string.IsNullOrEmpty(lstPatient[0].TypeName))
                {
                    xw.WriteString(lstPatient[0].TypeName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Occupation", "");
                if (!string.IsNullOrEmpty(lstPatient[0].OCCUPATION))
                {
                    xw.WriteString(lstPatient[0].OCCUPATION);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MaritalStatus", "");
                if (!string.IsNullOrEmpty(lstPatient[0].MartialStatus))
                {
                    xw.WriteString(lstPatient[0].MartialStatus);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("LastVisitDate", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Insurance", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].ClientName)))
                {
                    xw.WriteString(lstPatientVisit[0].ClientName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Department", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("SubDepartment", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Speciality", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].SpecialityName))
                {
                    xw.WriteString(lstPatientVisit[0].SpecialityName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Allergy", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("CurrentDate", "");
                xw.WriteString(OrgTimeZone);
                xw.WriteEndElement();

                xw.WriteStartElement("LoginName", "");
                if (!string.IsNullOrEmpty(Name))
                {
                    xw.WriteString(Name);
                }
                else
                {
                    xw.WriteString("Officer Sign");
                }
                xw.WriteEndElement();

                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sw.ToString());
                ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                XslTransform xsl = new XslTransform();
                string s = Server.MapPath("..\\xsl\\patientIdentificationSheet.xsl");
                xsl.Load(s);

                XmlOP.Document = xml;
                XmlOP.Transform = xsl;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintOpCard", "PrintOpCard();", true);

            }
        }
    }


    protected void PrintExistingPatientVisitDetailsXml(long patientID, long patientVisitID)
    {
        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<Patient> lstPatient = new List<Patient>();

        oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);
        oPatVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("GenerateVisit");

                xw.WriteStartElement("Department", "");

                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();


                xw.WriteStartElement("VisitPurpose", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].VisitPurposeName))
                {
                    xw.WriteString(lstPatientVisit[0].VisitPurposeName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber))
                {
                    xw.WriteString(lstPatientVisit[0].VisitNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitDate", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString(OrgDateTimeZone);
                }
                xw.WriteEndElement();

                xw.WriteStartElement("SerialNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientVisitId.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].PatientVisitId.ToString());
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MediacalRecordNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber))
                {
                    xw.WriteString(lstPatientVisit[0].PatientNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("PatientName", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].Name)))
                {
                    xw.WriteString(lstPatient[0].Name);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("DOB", "");
                if (!string.IsNullOrEmpty(lstPatient[0].DOB.ToString()))
                {
                    xw.WriteString(lstPatient[0].DOB.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Age", "");
                string age = string.Empty;
                if (!string.IsNullOrEmpty(lstPatient[0].Age))
                {
                    xw.WriteString(lstPatient[0].Age);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Insurance", "");
                xw.WriteString("Insurance");

                xw.WriteEndElement();

                xw.WriteStartElement("InsuranceName", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].ClientName))
                {
                    xw.WriteString(lstPatientVisit[0].ClientName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("LoginName", "");
                xw.WriteString("");
                xw.WriteEndElement();

                xw.WriteEndElement();
                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sw.ToString());
                ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                XslTransform xsl = new XslTransform();
                string s = Server.MapPath("..\\xsl\\GenerateVisit.xsl");
                xsl.Load(s);

                XmlOP.Document = xml;
                XmlOP.Transform = xsl;
            }
        }


        ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintOpCard", "PrintOpCard();", true);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
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

    public List<DynamicColumnMapping> DynamicColumn()
    {
        long retCode = -1;
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        try
        {
            int SearchType = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
            retCode = new Patient_BL(base.ContextInfo).SearchColumns(SearchType, OrgID, out lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SearchColumns", ex);
        }
        return lstColumn;
    }

    private void LoadGrid(EventArgs e, int startRowIndex, int PageSize)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        if (ddlType.SelectedItem.Text == "OP")
        {
            pVisitType = "0";
        }
        else if (ddlType.SelectedItem.Text == "IP")
        {
            pVisitType = "1";
        }
        else
        {
            pVisitType = "";
        }
        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string pSearchType = "RECHECK";
        string ShareType = "Clinical View";
        long ClientID = 0;
        long LoginID = 0;
        long RefPhyID = 0;
        long ZoneId = 0;
        long SelectedlocationID = -1;
        Int64.TryParse(ddlocations.SelectedItem.Value, out SelectedlocationID);
        Int16 IsTRFVerified;
        Int16.TryParse(ddlStatus.SelectedItem.Value, out IsTRFVerified);
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
        }
        else
        {
            TrustedOrgDetails TOD = new TrustedOrgDetails();
            TOD.SharingOrgID = OrgID;
            lstTOD.Add(TOD);
        }
        string tempfrom = "01/01/2000";
        string fromDate, ToDate;
        ClientID = Convert.ToInt64(hdnClientID.Value);
        if (hdnPhysicianID.Value != "0")
        {
            RefPhyID = Convert.ToInt64(hdnPhysicianID.Value.Split('~')[1]);
        }
        else
        {
            RefPhyID = 0;
        }

        if (hdntxtzoneID.Value != "0")
        {
            ZoneId = Convert.ToInt64(hdntxtzoneID.Value);
        }
        else
        {
            ZoneId = 0;
        }

        LoginID = Convert.ToInt64(hdnApprovedByID.Value);
        fromDate = txtFrom.Text.ToString();
        ToDate = txtTo.Text.ToString();

        if (CID > 0)
        {
            ClientID = CID;
        }
        if (RoleName == RoleHelper.Patient)
        {
            returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, fromDate, ToDate, OrgID, pSearchType, out lstPatientVisit, startRowIndex, PageSize, out totalRows);
        }
        else
        {
            if ((txtPatientNumber.Text.Trim() != null) && (txtPatientNumber.Text.Trim() != ""))
            {
                DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00AM");
                fromDate = MinDate.ToString("MM-dd-yyyy") + " " + "00:00:00AM";
                ToDate = OrgDateTimeZone;
                SelectedlocationID = 0;
            }


            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchDetailByPatient(txtPatientNumber.Text.Trim(),
                txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, PageSize, startRowIndex, out totalRows,
                out lstPatientVisit, Convert.ToString(ddlDepartment.SelectedItem.Value), Convert.ToInt64(ddlspeciality.SelectedItem.Value), RefPhyID, ZoneId, out lsttotalPatientCount,
                txtPatientNumber.Text.Trim(), SelectedlocationID, ClientID, LoginID, IsTRFVerified);
            if (totalRows > 0)
            {
                //lblpatientCount.Text = totalRows.ToString();
            }
            else
            {
                //lblpatientCount.Text = "0";
            }
            if (lsttotalPatientCount.Count > 0)
            {
                foreach (var item in lsttotalPatientCount)
                {
                    //lblPatientTotalVisitCount.Text = item.PatientVisitCount.ToString();
                }
            }

        }
        if (lstPatientVisit.Count > 0)
        {
            TRFDETAILS.Visible = true;
            //TRFDETAILS.Style.Add("disabled", "true");
            lblPName.Text = lstPatientVisit[0].PatientName;
            grdResult.DataSource = lstPatientVisit;
            grdResult.DataBind();
            grdResult.Visible = true;
            lblMessage.Text = "";

            if (lstPatientVisit != null && lstPatientVisit.Count > 0)
            {
                hdnVisitID.Value = Convert.ToString(lstPatientVisit[0].PatientVisitId);
                Visitno = lstPatientVisit[0].VisitNumber;

                PatientDetails();
            }
            else
            {
                hdnVisitID.Value = "0";
                Visitno = "0";
            }

            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = startRowIndex.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                startRowIndex = Convert.ToInt32(hdnCurrent.Value);
            }
            if (startRowIndex == 1)
            {
                Btn_Previous.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;
            }
            else
            {
                Btn_Previous.Enabled = true;
                if (startRowIndex == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
        }
        else
        {
            grdResult.Visible = false;
            TRFDETAILS.Visible = false;
            //TRFDETAILS.Style.Add("disabled", "false");
            lblMessage.Text = "No matching records found";
            Filter.Style.Add("display", "block");
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";

    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void Bind(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        if (ddlType.SelectedItem.Text == "OP")
        {
            pVisitType = "0";
        }
        else if (ddlType.SelectedItem.Text == "IP")
        {
            pVisitType = "1";
        }
        else
        {
            pVisitType = "";
        }
        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string pSearchType = "VISIT";
        string ShareType = "Clinical View";
        long ClientID = 0;
        long LoginID = 0;
        long RefPhyID = 0;
        long ZoneId = 0;
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
        }
        else
        {
            TrustedOrgDetails TOD = new TrustedOrgDetails();
            TOD.SharingOrgID = OrgID;
            lstTOD.Add(TOD);
        }
        string tempfrom = "01/01/2000";
        string fromDate, ToDate;
        ClientID = Convert.ToInt64(hdnClientID.Value);
        if (hdnPhysicianID.Value != "0")
        {
            RefPhyID = Convert.ToInt64(hdnPhysicianID.Value.Split('^')[1]);
        }
        else
        {
            RefPhyID = 0;
        }

        if (hdntxtzoneID.Value != "0")
        {
            ZoneId = Convert.ToInt64(hdntxtzoneID.Value);
        }
        else
        {
            ZoneId = 0;
        }
        if (CID > 0)
        {
            ClientID = CID;
        }
        LoginID = Convert.ToInt64(hdnApprovedByID.Value);
        fromDate = txtFrom.Text.ToString();
        ToDate = txtTo.Text.ToString();
        if ((txtPatientNumber.Text.Trim() != null) && (txtPatientNumber.Text.Trim() != ""))
        {
            DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00AM");
            fromDate = MinDate.ToString("MM-dd-yyyy") + " " + "00:00:00AM";
            ToDate = OrgDateTimeZone;
        }
        returnCode = new PatientVisit_BL(base.ContextInfo).GetAllVisitSearchDetailByPatient(txtPatientNumber.Text.Trim(),
              txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, PageSize, startRowIndex, out totalRows,
              out lstPatientVisit, Convert.ToString(ddlDepartment.SelectedItem.Value), Convert.ToInt64(ddlspeciality.SelectedItem.Value), RefPhyID, ZoneId, out lsttotalPatientCount,
              txtPatientNumber.Text.Trim(), Convert.ToInt64(ddlocations.SelectedItem.Value), ClientID, LoginID);
        if (lstPatientVisit.Count > 0)
        {
            for (int i = 0; i < lstPatientVisit.Count; i++)
            {
                List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(lstPatientVisit[i].PatientVisitId, OrgID, ILocationID, out lstorderInv);
                string InvestigationName = string.Empty;
                if (lstorderInv.Count > 0)
                {
                    for (int j = 0; j < lstorderInv.Count; j++)
                    {
                        if (InvestigationName == string.Empty)
                        {
                            InvestigationName = lstorderInv[j].InvestigationName;
                        }
                        else
                        {

                            InvestigationName += "," + lstorderInv[j].InvestigationName;
                        }
                    }
                }
                lstPatientVisit[i].ICDCodeStatus = InvestigationName;
            }
            IEnumerable<PatientVisit> lstfilter = (from S in lstPatientVisit
                                                   group S by new
                                                   {
                                                       S.PatientName,
                                                       S.VisitNumber,
                                                       S.Age,
                                                       S.VisitDate,
                                                       S.ClientName,
                                                       S.PhysicianName,
                                                       S.Zone,
                                                       S.UserName,
                                                       S.ICDCodeStatus
                                                   } into g
                                                   select new PatientVisit
                                                                {
                                                                    PatientName = g.Key.PatientName,
                                                                    VisitNumber = g.Key.VisitNumber,
                                                                    Age = g.Key.Age,
                                                                    VisitDate = g.Key.VisitDate,
                                                                    ClientName = g.Key.ClientName,
                                                                    PhysicianName = g.Key.PhysicianName,
                                                                    Zone = g.Key.Zone,
                                                                    UserName = g.Key.UserName,
                                                                    ICDCodeStatus = g.Key.ICDCodeStatus

                                                                }).ToList();


            grdResult.DataSource = lstfilter;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = "";
            grdResult.DataBind();
            grdResult.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('No Datas Found');", true);
        }
    }

    protected void GrdInv_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");

            if (lblStatus.Text == "Recheck")
            {
                lblStatus.Text = "RR";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "Retest")
            {
                lblStatus.Text = "RC";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "ReflexTest")
            {
                lblStatus.Text = "RF";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lblStatus.Visible = false;
            }
        }
    }

    public void PatientDetails()
    {
        try
        {
            string  AllValuesforHidden = string.Empty;
            Patient_BL patbl = new Patient_BL(base.ContextInfo);
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<WorklistMaster> lstWLMaster = new List<WorklistMaster>();
            List<Notifications> lstNotifications = new List<Notifications>();
            string Name = string.Empty;
            string VisitNumber = string.Empty;
            string BarcodeNumber = string.Empty;
            string CaseNumber = String.Empty;    
            long VisitID = -1;
            string PatientNumber = string.Empty;
            string gUID = string.Empty;
            long ClientID = -1;
            if (CID > 0)
            {
                ClientID = CID;
            }
            patbl.GetPatientTrackingDetails(OrgID, Name, Visitno, BarcodeNumber,"", VisitID, PatientNumber, ClientID, out lstPatientVisitDetails,
                out lstPatientInvSample, out lstPatientInvestigation, out lstWLMaster, out lstNotifications);

            if (lstPatientVisitDetails.Count > 0)
            {
                hdnPatOrgID.Value = lstPatientVisitDetails[0].OrgID.ToString();
                int PatOrgID = 0;

                Int32.TryParse(hdnPatOrgID.Value, out PatOrgID);
                lblPatientName.Text = lstPatientVisitDetails[0].PatientName.ToString();
                lblAge.Text = lstPatientVisitDetails[0].Age.ToString();
                lblGender.Text = lstPatientVisitDetails[0].Sex.ToString();
                lblPatientAddress.Text = lstPatientVisitDetails[0].Address1.ToString();
                lblPatientAddress1.Text = lstPatientVisitDetails[0].Address2.ToString();
                lblCity.Text = lstPatientVisitDetails[0].City.ToString();
                string Age = lstPatientVisitDetails[0].Age.ToString();
                string[] AgeNumber = Age.Split(' ');
                hdnPatientID.Value = lstPatientVisitDetails[0].PatientID.ToString();
                hdnVisitID.Value = lstPatientVisitDetails[0].PatientVisitID.ToString();
                //hdnTitleCode.Value = lstPatientVisitDetails[0].TitleName.ToString();
                if (lstPatientVisitDetails[0].VisitDate.ToString() == "01-01-1800")
                {
                    lblDOB.Text = "";
                    tDOB.Text = "";
                }
                else
                {
                    lblDOB.Text = lstPatientVisitDetails[0].VisitDate.ToString("dd/MM/yyyy");
                    tDOB.Text = lstPatientVisitDetails[0].VisitDate.ToString("dd/MM/yyyy");
                }

                if (lstPatientVisitDetails[0].Status == "S")
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.Orange;
                }
                else if (lstPatientVisitDetails[0].Status == "T")
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.WhiteSmoke;
                }
                lblClientCode.Text = lstPatientVisitDetails[0].AccompaniedBy.ToString();
                if (lstPatientVisitDetails[0].Country != null)
                {
                    lblClientZone.Text = lstPatientVisitDetails[0].Country.ToString();
                }

                lblClientAddress.Text = lstPatientVisitDetails[0].Address.ToString();
                if (lstPatientVisitDetails[0].ReMobilenumber != null && lstPatientVisitDetails[0].ReMobilenumber != "")
                {
                    lblMobile.Text = lstPatientVisitDetails[0].ReMobilenumber.ToString();
                    //txtMobile.Text = lstPatientVisitDetails[0].ReMobilenumber.ToString();
                    txtMobileNumber.Text = lstPatientVisitDetails[0].ReMobilenumber.ToString();
                }

                lblClientPhNo.Text = lstPatientVisitDetails[0].ComplaintDesc;
                lblClientEmail.Text = lstPatientVisitDetails[0].Param3;
                lblEmailID.Text = lstPatientVisitDetails[0].Param4;
                lblRefDr.Text = lstPatientVisitDetails[0].Param6;

                if (lstPatientVisitDetails[0].ReLandline != null && lstPatientVisitDetails[0].ReLandline != "")
                {
                    lblLandline.Text = lstPatientVisitDetails[0].ReLandline.ToString();
                    //txtLandline.Text = lstPatientVisitDetails[0].ReLandline.ToString();
                    txtPhone.Text = lstPatientVisitDetails[0].ReLandline.ToString();
                }

                lblVisitNumber.Text = lstPatientVisitDetails[0].VisitNumber.ToString();
                ddSalutation.SelectedValue = lstPatientVisitDetails[0].TitleCode.ToString();
                hdnSalutation.Value = lstPatientVisitDetails[0].TitleCode.ToString();  
                txtName.Text = lstPatientVisitDetails[0].PatientName.ToString();
                txtAddress.Text = lstPatientVisitDetails[0].Address1.ToString();
                txtPatientAddress1.Text = lstPatientVisitDetails[0].Address2.ToString();
                txtCity.Text = lstPatientVisitDetails[0].City.ToString();
                //ddlSex.SelectedValue = lstPatientVisitDetails[0].Sex.ToString() == "" ? "0" : lstPatientVisitDetails[0].Sex.ToString();
               // ddlSex.SelectedItem.Value = Convert.ToString(lstPatientVisitDetails[0].Sex);
                if (Convert.ToString(lstPatientVisitDetails[0].Sex) == "Female")
                {
                    ddlSex.SelectedValue = "F";
                   // ddlSex.SelectedItem.Text = "Female";
                    hdnSex.Value = "F";
                }
                else if (Convert.ToString(lstPatientVisitDetails[0].Sex) == "Male")
                {
                    ddlSex.SelectedValue = "M";
                    //ddlSex.SelectedItem.Text = "Male";
                    hdnSex.Value = "M";
                }
                if (Convert.ToString(lstPatientVisitDetails[0].Sex) == "Vetrinary")
                {
                    ddlSex.SelectedValue = "V";
                    //ddlSex.SelectedItem.Text = "Vetrinary";
                    hdnSex.Value = "V";
                }
                if (Convert.ToString(lstPatientVisitDetails[0].Sex) == "NA")
                {
                    ddlSex.SelectedValue = "N";
                    //ddlSex.SelectedItem.Text = "NA";
                    hdnSex.Value = "N";
                }
                
                if (AgeNumber.Count() > 1)
                {
                    ddlDOBDWMY.SelectedValue = AgeNumber[1].ToString();
                    hdnDOBDWMY.Value = AgeNumber[1].ToString();
                }
                txtDOBNos.Text = AgeNumber[0].ToString();
                hdntxtDOBNos.Value = AgeNumber[0].ToString();
                txtEmail.Text = lstPatientVisitDetails[0].Param4; 
                txtInternalExternalPhysician.Text = lstPatientVisitDetails[0].Param6; 

                if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
                {
                    List<PatientVisitDetails> groupByResult = new List<PatientVisitDetails>();

                    groupByResult = (from lst in lstPatientVisitDetails
                                     group lst by
                                     new
                                     {  
                                         lst.ID2,
                                         lst.History,
                                         lst.Remarks,
                                         lst.EmergencyPatientTrackerID
                                     } into grp

                                     select new PatientVisitDetails
                                     {
                                         ID2=grp.Key.ID2,
                                         History = grp.Key.History,
                                         Remarks = grp.Key.Remarks,
                                         EmergencyPatientTrackerID = grp.Key.EmergencyPatientTrackerID
                                     }).Distinct().ToList();

                    Bckgrd.DataSource = groupByResult;
                    Bckgrd.DataBind();
                    history.Visible = true;
                }
                else
                {
                    history.Visible = false;
                    
                }

                Investigation_BL DemoBL;
                DemoBL = new Investigation_BL(base.ContextInfo);
                List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();

                DemoBL.pGetpatientInvestigationForVisit(Convert.ToInt64(hdnVisitID.Value), PatOrgID, ILocationID, gUID, out lstorderInvforVisit);

                if (lstorderInvforVisit.Count > 0)
                {
                    GrdInv.DataSource = lstorderInvforVisit;
                    GrdInv.DataBind();
                    //CheakInv.Style.Add("display", "block");
                }
                if (hdnPatientID.Value != "" && hdnVisitID.Value != "")
                {
                    //if (Request.QueryString["IsPopup"] == "Y")
                    //{
                    //    ViewTRF.Style.Add("display", "none");
                    //}
                    //else
                    //{
                    String FileName = String.Empty;
                    int patientid = Convert.ToInt32(hdnPatientID.Value);
                    int visitid = Convert.ToInt32(hdnVisitID.Value);
                    long returncode = -1;
                    List<Patient> lstpat = new List<Patient>();
                    List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
                    List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
                    string Type = "";
                    returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID,Type, out lstFiles);
                    if (lstFiles.Count > 0)
                    {
                        lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "TRF_Upload");
                    }
                    if (lstTRF.Count > 0)
                    {
                        string PictureName = string.Empty;
                        if (lstTRF.Count == 1)
                        {
                            trDropDown.Style.Add("display", "none");
                            PictureName = lstTRF[0].FileName;
                            string fileName = Path.GetFileNameWithoutExtension(PictureName);
                            string fileExtension = Path.GetExtension(PictureName);
                            if (!string.IsNullOrEmpty(PictureName))
                            {
                                if (PictureName != "" && fileExtension != ".pdf")
                                {
                                    if (!String.IsNullOrEmpty(PictureName))
                                    {
                                        trPicPatient.Style.Add("display", "block");
                                        trPDF.Style.Add("display", "none");
                                        imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;
                                    }
                                }
                                else
                                {
                                    trPicPatient.Style.Add("display", "none");
                                    trPDF.Style.Add("display", "block");
                                    ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                                }
                            }
                            else
                            {
                                trPicPatient.Style.Add("display", "none");
                                trPDF.Style.Add("display", "none");
                            }
                        }
                        else if (lstTRF.Count > 1)
                        {
                            trDropDown.Style.Add("display", "block");
                            List<NameValuePair> lstFile = new List<NameValuePair>();
                            string[] fileName;
                            NameValuePair objNameValuePair;
                            foreach (TRFfilemanager obj in lstTRF)
                            {
                                fileName = obj.FileName.Substring(obj.FileName.LastIndexOf('_') + 1).Split('.');
                                if (fileName != null && fileName.Length > 1)
                                {
                                    objNameValuePair = new NameValuePair();
                                    objNameValuePair.Name = fileName[0];
                                    objNameValuePair.Value = obj.FileName;
                                    lstFile.Add(objNameValuePair);
                                }
                            }
                            hdnOrgID.Value = Convert.ToString(OrgID);
                            ddlFileList.DataSource = lstFile;
                            ddlFileList.DataTextField = "Name";
                            ddlFileList.DataValueField = "Value";
                            ddlFileList.DataBind();

                            ddlFileList.Items.Insert(0, new System.Web.UI.WebControls.ListItem("----Select----", "0"));
                            PictureName = lstTRF[0].FileName;
                            string fileExtension = Path.GetExtension(PictureName);
                            string PDFFile = pathname + PictureName;

                            if (PictureName != "")
                            {
                                if (PictureName != "" && fileExtension != ".pdf")
                                {
                                    if (!String.IsNullOrEmpty(PictureName))
                                    {
                                        trPicPatient.Style.Add("display", "block");
                                        trPDF.Style.Add("display", "none");
                                        imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;
                                    }
                                }
                                else
                                {
                                    trPicPatient.Style.Add("display", "none");
                                    trPDF.Style.Add("display", "block");
                                    ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                                }
                            }
                            else
                            {
                                trPicPatient.Style.Add("display", "none");
                                trPDF.Style.Add("display", "none");
                            }
                        }
                    }
                    else
                    {
                        trPicPatient.Style.Add("display", "none");
                        //trPicPatient.Style.Add("display", "block");
                        trPDF.Style.Add("display", "none");
                        trDropDown.Style.Add("display", "none");
                    }
                }
            }
            else
            {
                lblPatientName.Text = "";
                lblAge.Text = "";
                lblGender.Text = "";
                lblDOB.Text = "";
                lblPatientAddress.Text = " ";
                lblPatientAddress1.Text = " ";
                lblCity.Text = " ";
                lblClientName.Text = "";
                lblClientCode.Text = "";
                lblRefDr.Text = "";
                ClearValues();

            }
            //if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
            //{
            //    List<PatientVisitDetails> groupByResult = new List<PatientVisitDetails>();

            //    groupByResult = (from lst in lstPatientVisitDetails
            //                     group lst by
            //                     new
            //                     {
            //                         lst.ID2,
            //                         lst.History,
            //                         lst.Remarks,
            //                         lst.EmergencyPatientTrackerID
            //                     } into grp

            //                     select new PatientVisitDetails
            //                     {
            //                         ID2 = grp.Key.ID2,
            //                         History = grp.Key.History,
            //                         Remarks = grp.Key.Remarks,
            //                         EmergencyPatientTrackerID = grp.Key.EmergencyPatientTrackerID
            //                     }).Distinct().ToList();

            //    Bckgrd.DataSource = groupByResult;
            //    Bckgrd.DataBind();
            //    history.Visible = true;
            //}
            //else
            //{
            //    history.Visible = false;
            //}
        }
        catch (Exception ex)
        {

            CLogger.LogError("Contact System Amdminstrator", ex);
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        if (btnVerify.Text == "Verify")
        {
            long PatientVisitId;
            bool IsEdit = false;
            PatientVisitId = Convert.ToInt64(hdnVisitID.Value);
            long returncode = -1;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            returncode = invbl.SaveTRFverificationDetails(PatientVisitId, IsEdit);
            //Btn_Next_Click(sender, e);
            //hdnVisitID.Value = "";
            LoadGrid(e, 1, PageSize);
        }
        
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //hdnSearch.Value = "N";


        if (hdnEdit.Value == "Update and Verify")
        {
            long PatientID = 0;
            long PatientVisitID = 0;
            int Titlecode = 0;
            string Name = string.Empty;
            string Gender = string.Empty;
            string PatientAddress = string.Empty;
            string Age = string.Empty;
            string Landlineno = string.Empty;
            string Mobileno = string.Empty;
            DateTime DOB = DateTime.MaxValue;
            string EmailID = string.Empty;
            string AgeDesc = string.Empty;
            long RefPhyID = 0;
            string RefPhyName = string.Empty;
            string PatientAddress1 = string.Empty;
            string PatientAddress2 = string.Empty;
            string City = string.Empty;
            int orgID = 0;
            PatientID = Convert.ToInt64(hdnPatientID.Value);
            PatientVisitID = Convert.ToInt64(hdnVisitID.Value);
            Int32.TryParse(ddSalutation.SelectedItem.Value, out Titlecode);
            Name = txtName.Text;
            Gender = Convert.ToString(ddlSex.SelectedItem.ToString());
            PatientAddress = txtAddress.Text;
            PatientAddress1 = PatientAddress;
            PatientAddress2 = txtPatientAddress1.Text;
            City = txtCity.Text;
            Age = txtDOBNos.Text;
            AgeDesc = Convert.ToString(ddlDOBDWMY.SelectedItem.ToString());
            //Mobileno = txtMobile.Text;
           // Landlineno = txtLandline.Text;
            Mobileno = txtMobileNumber.Text;
            Landlineno = txtPhone.Text;
            //   DOB = DateTime.MinValue;
            DOB = DateTime.ParseExact(tDOB.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            //string str = DOB.ToString("dd-MM-yyyy");
            //DateTime.TryParse(str, out DOB);
            EmailID = txtEmail.Text;
            Int64.TryParse(hdnReferedPhyID.Value, out RefPhyID);
            //hdnReferedPhyName.Value = txtInternalExternalPhysician.Text;
            RefPhyName = txtInternalExternalPhysician.Text;
            //RefPhyName = hdnReferedPhyName.Value;
            //string HistoryDetails = string.Empty;
            //string Remarks = string.Empty;
            //foreach (GridViewRow row in Bckgrd.Rows)
            //{
            //    HistoryDetails = ((TextBox)row.FindControl("txtHistory")).Text;
            //    Remarks = ((TextBox)row.FindControl("txtRemarks")).Text;
            //}

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<PatientHistoryExt> lstpatientHistory = new List<PatientHistoryExt>();
            string strLstpatientHistory = string.Empty;
            strLstpatientHistory = hdnlstpatientHistory.Value;
            if (strLstpatientHistory != null && strLstpatientHistory != "")
            {
                lstpatientHistory = serializer.Deserialize<List<PatientHistoryExt>>(strLstpatientHistory);
            }

        
           
            //btnUpdate.Visible = false;
            //this.BindGrid();
            long FinallBillID = -1;
            long returncode = -1;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            returncode = invbl.UpdatePatientdetails(PatientID, PatientVisitID, Titlecode, Name, Gender, PatientAddress1, PatientAddress2,City, Age, AgeDesc, Mobileno, Landlineno, DOB, EmailID, RefPhyID, RefPhyName, orgID, lstpatientHistory, out FinallBillID);
            bool IsEdit = true;
            returncode = invbl.SaveTRFverificationDetails(PatientVisitID, IsEdit);
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            if (hdnIsEditDeFlag.Value == "Y")
            {
                new Patient_BL(base.ContextInfo).RegistrationDeflag(PatientVisitID, OrgID);
            }

            if (hdnIsEditRePush.Value == "Y")
            {

                PageContextDetails.PatientID = PatientID;
                PageContextDetails.PatientVisitID = PatientVisitID;
                PageContextDetails.FinalBillID = FinallBillID;
                PageContextDetails.BillNumber = Convert.ToString(FinallBillID);
                PageContextDetails.ID = LID;// Assign OrgAdressID
                if (hdnIsEditDeFlag.Value == "Y")
                {
                    PageContextDetails.isActionDisabled = true;
                }
                else
                {
                    PageContextDetails.isActionDisabled = false;
                }

                    ActionManager objActionManager = new ActionManager(base.ContextInfo);
                    // objActionManager.PerformingNextStep(PageContextDetails);
                    objActionManager.PerformingNextStepNotification(PageContextDetails, "", "");
                }
          hdnIsEditDeFlag.Value = "";
          hdnIsEditRePush.Value = "";
            }
            //Btn_Next_Click(sender, e);
            //hdnVisitID.Value = "";
            Hide();
            LoadGrid(e, 1, PageSize);
        }


    

    public void Hide()
    {
        tdNameEditmode.Attributes.Add("style", "display:none");
        tdAgeEditmode.Attributes.Add("style", "display:none");
        tdDOBEditmode.Attributes.Add("style", "display:none");
        tdGederEditmode.Attributes.Add("style", "display:none");
        tdPatientAddressEditmode.Attributes.Add("style", "display:none");
        tdPatientAddress1Editmode.Attributes.Add("style", "display:none");
        tdCityEditmode.Attributes.Add("style", "display:none");
        tdMobileEditmode.Attributes.Add("style", "display:none");
        tdEmailEditmode.Attributes.Add("style", "display:none");
        tdRefDrEditmode.Attributes.Add("style", "display:none");
        tdLandlineEditmode.Attributes.Add("style", "display:none");
        ClearValues();
    }


    public void Loadpatientdetails()
    {
        try
        {
            List<Salutation> lstTitles = new List<Salutation>();
            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            List<Country> lstNationality = new List<Country>();
            List<Country> lstCountries = new List<Country>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
            LoadTitle(lstTitles);
            //LoadPriority();
            //LoadCountry(lstCountries);
            //LoadURNtype();
            //LoadNationality(lstNationality);
            LoadMeatData();
            //loadRateType();
            //loadClient();
            //LoadDefaultBillingItemsforWalkins();
            //LoadDespatchMode();
            //LoadInvestigationHistroyDetail();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Quick Billing LoadQuickBillLoading() Method", ex);
        }

    }


    private void LoadTitle(List<Salutation> lstTitles)
    {
        try
        {
            int titleID = 0;
            List<Salutation> titles = new List<Salutation>();
            Salutation selectedSalutation = new Salutation();

            //List<Salutation> childItems = (from child in lstTitles
            //                               where (child.TitleName == "Mr.") || (child.TitleName == "Ms.") || (child.TitleName == "Mrs.")
            //                               || (child.TitleName == "Baby.") || (child.TitleName == "Others.") || (child.TitleName == "Pet.")
            //                               || (child.TitleName == "Undisclosed.")
            //                               select child).ToList();


            ddSalutation.DataSource = lstTitles;
            ddSalutation.DataTextField = "TitleName";
            ddSalutation.DataValueField = "TitleID";
            ddSalutation.DataBind();
            selectedSalutation = lstTitles.Find(Findsalutation);
            ddSalutation.Items.Insert(0, "--Select--");
            ddSalutation.Items[0].Value = "0";
            ddSalutation.SelectedValue = "0";
            //ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTitle() Method in Lab Quick Billing", ex);
        }
    }

    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }


    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,DespatchType";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
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
                    ddlSex.Items[0].Value = "-1";
                   //ddlSex.SelectedValue = "M";
                }



                //var childItems2 = from child in lstmetadataOutput
                //                  where child.Domain == "MaritalStatus"
                //                  select child;

                //if (childItems2.Count() > 0)
                //{
                //    ddMarital.DataSource = childItems2;
                //    ddMarital.DataTextField = "DisplayText";
                //    ddMarital.DataValueField = "Code";
                //    ddMarital.DataBind();
                //    ddMarital.Items.Insert(0, "--Select--");
                //    ddMarital.Items[0].Value = "0";
                //    ddMarital.SelectedValue = "0";
                //}
                //var childItems3 = from child in lstmetadataOutput
                //                  where child.Domain == "PatientType"
                //                  select child;

                //if (childItems3.Count() > 0)
                //{
                //    ddlPatientType.DataSource = childItems3;
                //    ddlPatientType.DataTextField = "DisplayText";
                //    ddlPatientType.DataValueField = "Code";
                //    ddlPatientType.DataBind();
                //}
                //var childItems4 = from child in lstmetadataOutput
                //                  where child.Domain == "PatientStatus"
                //                  select child;

                //if (childItems4.Count() > 0)
                //{
                //    ddlPatientStatus.DataSource = childItems4;
                //    ddlPatientStatus.DataTextField = "DisplayText";
                //    ddlPatientStatus.DataValueField = "Code";
                //    ddlPatientStatus.DataBind(); ;
                //}
                //var childItemsDisPatchType = from child in lstmetadataOutput
                //                             where child.Domain == "DespatchType"
                //                             orderby child.DisplayText descending
                //                             select child;
                //if (childItemsDisPatchType.Count() > 0)
                //{
                //    chkDisPatchType.DataSource = childItemsDisPatchType;
                //    chkDisPatchType.DataTextField = "DisplayText";
                //    chkDisPatchType.DataValueField = "Code";
                //    chkDisPatchType.DataBind();
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    void ClearValues()
    {
        txtName.Text = "";
        txtDOBNos.Text = "";
        ddlDOBDWMY.SelectedIndex = 0;
        txtAddress.Text = " ";
        txtPatientAddress1.Text = " ";
        txtCity.Text = " ";
        tDOB.Text = "dd/MM/yyyy";
        //tDOB.Text=Convert.ToString(DateTime.MaxValue);
        ddlSex.SelectedValue = "-1";
        //txtMobile.Text = "";
        //txtLandline.Text = "";
        txtMobileNumber.Text = "";
        txtPhone.Text = "";
        txtEmail.Text = "";
        txtInternalExternalPhysician.Text = "";
        hdnPatientID.Value = "-1";
        // hdnClientID.Value = "-1";
        hdnReferedPhyID.Value = "0";
        //hdnReferedPhyType.Value = "";
        ddSalutation.Focus();
        txt_DOB_TextBoxWatermarkExtender.WatermarkText = "dd/MM/yyyy";
        hdnVisitID.Value = "-1";
        hdfReferalHospitalID.Value = "0";
        hdnEdit.Value = "Edit";
        btnVerify.Text = "Verify";
        hdnSalutation.Value = "";
        hdnSex.Value = "";
        hdnDOBDWMY.Value = "";
        hdntxtDOBNos.Value = "";
    }





    //protected void OnCheckedChanged(object sender, EventArgs e)
    //{
    //    bool isUpdateVisible = false;
    //    CheckBox chk = (sender as CheckBox);
    //    if (chk.ID == "chkAll")
    //    {
    //        foreach (GridViewRow row in Bckgrd.Rows)
    //        {
    //            if (row.RowType == DataControlRowType.DataRow)
    //            {
    //                row.Cells[0].Controls.OfType<CheckBox>().FirstOrDefault().Checked = chk.Checked;
    //            }
    //        }
    //    }
    //    CheckBox chkAll = (Bckgrd.HeaderRow.FindControl("chkAll") as CheckBox);
    //    chkAll.Checked = true;
    //    foreach (GridViewRow row in Bckgrd.Rows)
    //    {
    //        if (row.RowType == DataControlRowType.DataRow)
    //        {
    //            bool isChecked = row.Cells[0].Controls.OfType<CheckBox>().FirstOrDefault().Checked;
    //            for (int i = 1; i < row.Cells.Count; i++)
    //            {
    //                row.Cells[i].Controls.OfType<Label>().FirstOrDefault().Visible = !isChecked;
    //                //row.Cells[i].Controls.OfType<TextBox>().FirstOrDefault().Visible = isChecked;
    //                if (row.Cells[i].Controls.OfType<TextBox>().ToList().Count > 0)
    //                {
    //                    row.Cells[i].Controls.OfType<TextBox>().FirstOrDefault().Visible = isChecked;
    //                }
    //                if (row.Cells[i].Controls.OfType<TextBox>().ToList().Count > 0)
    //                {
    //                    row.Cells[i].Controls.OfType<TextBox>().FirstOrDefault().Visible = isChecked;
    //                }
    //                if (isChecked && !isUpdateVisible)
    //                {
    //                    isUpdateVisible = true;
    //                }
    //                if (!isChecked)
    //                {
    //                    chkAll.Checked = false;
    //                }
    //            }
    //        }
    //    }
    //      //btnEdit.Visible = isUpdateVisible;

    //}
    //protected void Bckgrd_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        Label lblhistory = (e.Row.FindControl("lblHistory") as Label);

    //        TextBox txtHistory = (e.Row.FindControl("txtHistory") as TextBox);

    //        Label lblRemarks = (e.Row.FindControl("lblRemarks") as Label);

    //        TextBox txtRemarks = (e.Row.FindControl("txtRemarks") as TextBox);
    //    }

    //}

    protected void Bckgrd_RowDataBound(object sender, GridViewRowEventArgs e)
    {


    }
    
}

internal class PdfPageEvents : IPdfPageEvent
{
    #region members

    private PdfContentByte _content;
    private PdfPTable _footerTable;

    #endregion

    #region IPdfPageEvent Members

    public PdfPageEvents(PdfPTable footerTable)
    {
        _footerTable = footerTable;
    }

    public void OnOpenDocument(PdfWriter writer, Document document)
    {
        _content = writer.DirectContent;
    }

    public void OnStartPage(PdfWriter writer, Document document)
    {

    }

    public void OnEndPage(PdfWriter writer, Document document)
    {
        _footerTable.WriteSelectedRows(0, 3, document.LeftMargin, document.PageSize.Height - 40, writer.DirectContent);
    }

    public void OnCloseDocument(PdfWriter writer, Document document)
    {
    }

    public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
    {
    }

    public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
    {
    }

    public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnGenericTag(PdfWriter writer, Document document, iTextSharp.text.Rectangle rect, string text)
    {
    }

    #endregion
}