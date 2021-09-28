using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Drawing.Printing;
using System.Text.RegularExpressions;



public partial class CommonControls_SmartCard : BaseControl
{
    string SmartCardNo = string.Empty;
    string IsSmartCardIssued = string.Empty;
    public string Save_Message = Resources.AppMessages.Update_Message;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string SmartCardPrintConfig = string.Empty;
            SmartCardPrintConfig = GetConfigValue("SmartCardPrint_AutoSelect", OrgID);
            hdnSmartCardPrintConfig.Value = SmartCardPrintConfig;

            btnPrint.Attributes.Add("onclick", "ClientSidePrint('" + divSCDetail.ClientID + "','" + btnPrint.ClientID + "');");
            btnIDPrint.Attributes.Add("onclick", "PrintIDCard('" + divIDCard.ClientID + "','" + btnIDPrint.ClientID + "');");
            //txtScNo.Attributes.Add("onKeyDown", "return ValidateSmartCardNo(event)");
            txtScNo.Attributes.Add("onblur", "CheckSCNoExists()");
            rdoYes.Attributes.Add("onclick", "ValidateYes('" + rdoYes.ClientID + "')");
            rdoNo.Attributes.Add("onclick", "ValidateNo('" + rdoNo.ClientID + "')");
            btnUctlFinish.Attributes.Add("onclick", "return ValidateSmartCardRdo()");


        }

    }
    public bool ShowIssueSmartCard
    {
        set { rowIssueSmartCard.Visible = value; }
        get { return rowIssueSmartCard.Visible; }
    }

    public bool ShowReIssueSmartCard
    {
        set { rowReIssueSmartCard.Visible = value; }
        get { return rowReIssueSmartCard.Visible; }
    }

    public bool ShowUpdateSmartCardno
    {
        set { rowUpdateSmartCardNo.Visible = value; }
        get { return rowUpdateSmartCardNo.Visible; }
    }
    public void ShowPopUp()
    {
        mpeSmartCard.Show();
    }

    public bool ShowSmartCardPopup
    {
        set { if (value) { mpeSmartCard.Show(); } else { mpeSmartCard.Hide(); } }
    }

    public void LoadPatientDetail(long patientID)
    {
        try
        {
            hdnPatientID.Value = patientID.ToString();
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<Patient> patients = new List<Patient>();
            List<SmartCardMaster> lstSmtCard = new List<SmartCardMaster>();
            List<PatientAddress> patientsAddress = new List<PatientAddress>();
            pBL.GetPatientDemoandAddress(patientID, out patients);
            pBL.GetTableFormat(OrgID, out lstSmtCard);

            if (patients.Count > 0)
            {
                //lblPatientName.Attributes.Add("value",patients[0].Name );
                //lblPatientNumber.Attributes.Add("value", patients[0].PatientNumber);
                //lblPatientSex.Attributes.Add("value", patients[0].SEX == "M" ? "Male" : "Female");

                lblPatientName.Text = patients[0].Name;
                lblPatientNumber.Text = patients[0].PatientNumber;
                if (patients[0].DOB.ToString() != "" && patients[0].DOB != null)
                {
                    lblDOB.Text = "DOB: " + patients[0].DOB.ToString("dd/MM/yyyy") + ", ";
                }
                lblPatientSex.Text = patients[0].SEX == "M" ? "Male" : "Female";

                patientsAddress = patients[0].PatientAddress;
                if (patientsAddress.Count > 0)
                {
                    var pAdd = from p in patientsAddress where p.AddressType == "P" select p;
                    if (pAdd != null)
                    {
                        foreach (PatientAddress item in pAdd)
                        {
                            lblArea.Text = "Area: " + FirstUppercase(item.City.ToLower());
                        }
                    }
                    else
                    {
                        var cAdd = from c in patientsAddress where c.AddressType == "C" select c;
                        foreach (PatientAddress item in cAdd)
                        {
                            lblArea.Text = "Area: " + FirstUppercase(item.City.ToLower());
                        }
                    }
                }

                lblIssuedOn.Text = "Issued on: " + patients[0].CreatedAt.ToString("MMM, yyyy").Replace(",", "'");
                if (lstSmtCard.Count > 0)
                {
                    string strSex = string.Empty;
                    if (patients[0].SEX.ToString() == "M")
                    {
                        strSex = "Male";
                    }
                    else
                    {
                        strSex = "Female";
                    }
                    string strAge = string.Empty;
                    strAge = patients[0].Age.ToString();
                    int intp = Int32.Parse(strAge.IndexOf(" ").ToString());
                    strAge = strAge.Substring(0, intp);
                    string strAdd = string.Empty;
                    if (patientsAddress[0].Add1 != null && patientsAddress[0].Add1 != "")
                    {
                        strAdd = patientsAddress[0].Add1.ToString();
                    }
                    else if (patientsAddress[1].Add1 != null && patientsAddress[1].Add1 != "")
                    {
                        strAdd = patientsAddress[1].Add1.ToString();
                    }
                    if (patientsAddress[0].Add2 != null && patientsAddress[0].Add2 != "")
                    {
                        strAdd += "\n" + patientsAddress[0].Add2.ToString();
                    }
                    else if (patientsAddress[1].Add2 != null && patientsAddress[1].Add2 != "")
                    {
                        strAdd += "\n" + patientsAddress[1].Add2.ToString();
                    }
                    if (patientsAddress[0].Add3 != null && patientsAddress[0].Add3 != "")
                    {
                        strAdd += "\n" + patientsAddress[0].Add3.ToString();
                    }
                    else if (patientsAddress[1].Add3 != null && patientsAddress[1].Add3 != "")
                    {
                        strAdd += "\n" + patientsAddress[1].Add3.ToString();
                    }
                    string strPh = string.Empty;
                    if (patientsAddress[0].LandLineNumber != null && patientsAddress[0].LandLineNumber != "")
                    {
                        strPh = patientsAddress[0].LandLineNumber.ToString();

                    }
                    else if (patientsAddress[1].LandLineNumber != null && patientsAddress[1].LandLineNumber != "")
                    {
                        strPh = patientsAddress[1].LandLineNumber.ToString();

                    }
                    if (patientsAddress[0].MobileNumber != null && patientsAddress[0].MobileNumber != "")
                    {
                        if (strPh != "")
                        {
                            strPh = strPh + "/" + patientsAddress[0].MobileNumber.ToString();
                        }
                        else
                        {
                            strPh = patientsAddress[0].MobileNumber.ToString();
                        }
                    }
                    else if (patientsAddress[1].MobileNumber != null && patientsAddress[1].MobileNumber != "")
                    {
                        if (strPh != "")
                        {
                            strPh = strPh + "/" + patientsAddress[1].MobileNumber.ToString();
                        }
                        else
                        {
                            strPh = patientsAddress[1].MobileNumber.ToString();
                        }
                    }
                    string strTable = lstSmtCard[0].DisplayFormat.ToString();
                    string[] strLabFormat = strTable.Split('&');
                    strTable = strTable.Replace("Label&", "");
                    string[] strArr = new string[10];
                    int intLine = 0;
                    strArr[0] = patients[0].PatientNumber;
                    strArr[1] = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    strArr[2] = patients[0].TitleName.ToString() + patients[0].Name.ToString();
                    strArr[3] = strAge + " / " + strSex;

                    strAdd = TextWordWrap(strAdd, 23, out intLine);
                    if (patientsAddress[0].City != null && patientsAddress[0].City != "")
                    {
                        strArr[4] = strAdd + "<br/>\n" + patientsAddress[0].City.ToString();
                    }
                    else if (patientsAddress[1].City != null && patientsAddress[1].City != "")
                    {
                        strArr[4] = strAdd + "<br/>\n" + patientsAddress[1].City.ToString();
                    }
                    strArr[5] = strPh;
                    if (strLabFormat[0] == "Label")
                    {
                        strArr[4] = patients[0].DOB.ToString("dd/MM/yyyy");
                        //strArr[4] = OrgName;
                        strArr[6] = "../admin/BarcodeHandler.ashx?barcodeno=" + patients[0].PatientNumber + "&width=100&height=50";
                        strArr[7] = OrgName;
                    }
                    strArr[8] = strAge;
                    strArr[9] = strSex;
                    strTable = string.Format(strTable, strArr);
                    lblIDTable.Text = strTable;
                    divSmartCard.Visible = false;
                    divIDCard.Visible = true;
                    tblID.Visible = true;
                    divIDCard.Style.Add("width", "321px");
                    pnlSmartCard.Style.Add("width", "321px");

                }
                else
                {
                    divSmartCard.Visible = true;
                    tblID.Visible = false;
                }
            }
            if (rowUpdateSmartCardNo.Visible == true)
            {
                tblPrint.Visible = false;
                divScNo.Attributes.Add("style", "display:block;");
                txtScNo.Focus();


            }
            else if (rowReIssueSmartCard.Visible == true)
            {
                tblPrint.Visible = true;

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SmartCard LoadPatientDetail method", ex);
        }
    }

    public void SetRedirectURL(string value)
    {
        hdnURL.Value = value;
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        Redirect();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(hdnURL.Value.ToString(), true);
    }

    private void Redirect()
    {
        long returnCode = -1;
        try
        {
            SmartCardNo = txtScNo.Text.Trim();
            if (rdoYes.Checked)
            {
                IsSmartCardIssued = "Y";
            }
            else { IsSmartCardIssued = "N"; }

            if (chkRe_Issue.Checked == true)
            {
                IsSmartCardIssued = "Y";
            }

            if (chkRe_Issue.Checked == true)
            {
                returnCode = new Patient_BL(base.ContextInfo).InsertSmartCardDetail(SmartCardNo, IsSmartCardIssued, "RE-ISSUE", LID, Convert.ToInt64(hdnPatientID.Value));
            }
            else if (rowReIssueSmartCard.Visible)
            {
                returnCode = new Patient_BL(base.ContextInfo).InsertSmartCardDetail(SmartCardNo, IsSmartCardIssued, ddlReIssueReason.SelectedItem.Text, LID, Convert.ToInt64(hdnPatientID.Value));
            }
            if (rowReIssueSmartCard.Visible)
            {
                returnCode = new Patient_BL(base.ContextInfo).InsertSmartCardDetail(SmartCardNo, IsSmartCardIssued, ddlReIssueReason.SelectedItem.Text, LID, Convert.ToInt64(hdnPatientID.Value));
            }
            else if (rowIssueSmartCard.Visible)
            {
                returnCode = new Patient_BL(base.ContextInfo).InsertSmartCardDetail(SmartCardNo, IsSmartCardIssued, "New", LID, Convert.ToInt64(hdnPatientID.Value));
            }

            Response.Redirect(hdnURL.Value.ToString(), true);

        }
        catch (Exception er)
        {
            CLogger.LogError("Error While Trying to InsertSmartCard Detail in SmartCard.ascx.cs", er);
        }

    }

    private string FirstUppercase(string s)
    {
        if (string.IsNullOrEmpty(s))
        {
            return string.Empty;
        }
        return char.ToUpper(s[0]) + s.Substring(1);
    }
    protected string TextWordWrap(string strWordWarp, int WordLength, out int strLineCount)
    {

        strLineCount = 0;
        int strTotalCount = WordLength;
        int strStratCount = 0;

        int strLength = strWordWarp.Length;
        int intCount = 0;
        string strReturnValue = "";
        while (strTotalCount < strLength)
        {
            char st = strWordWarp[strTotalCount];
            while ((st != '\n' && strTotalCount > strStratCount && st != ' '))
            {
                st = strWordWarp[strTotalCount];
                strTotalCount = strTotalCount - 1;
            }
            if (strTotalCount == strStratCount)
            {
                strTotalCount = strStratCount + WordLength;
            }
            strTotalCount++;
            strReturnValue += strWordWarp.Substring(strStratCount, strTotalCount - strStratCount) + "\n";
            strLineCount += 1;
            strStratCount = strTotalCount + 1;
            strTotalCount = strStratCount + WordLength;
        }
        if (strStratCount < strLength)
        {
            strReturnValue += strWordWarp.Substring(strStratCount);
            strLineCount += 1;
        }
        int stLen = strLength;
        int chCount = 0;
        while (stLen > 0)
        {
            char c = strWordWarp[chCount];
            if (c == '\n')
            {
                intCount++;
            }

            if (intCount == 3)
            {
                strReturnValue = strReturnValue.Substring(0, chCount);
                strReturnValue = strReturnValue.Replace("\n", "<br/>");
                return strReturnValue;
            }
            stLen--;
            chCount++;
        }
        if (strLength > 65)
        {
            strReturnValue = strReturnValue.Substring(0, 65);
            return strReturnValue;
        }
        strReturnValue = strReturnValue.Replace("\n", "<br/>");
        return strReturnValue;
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
