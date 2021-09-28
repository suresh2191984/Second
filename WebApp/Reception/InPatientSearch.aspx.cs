using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using System.Collections;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Data;

public partial class Reception_InPatientSearch : BasePage
{
    int IP;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();

    public Reception_InPatientSearch()
        : base("Reception\\InPatientSearch.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        ucINPatientSearch.onSearchComplete += new EventHandler(ucINPatientSearch_onSearchComplete);
        TextBox txt = (TextBox)ucINPatientSearch.FindControl("txtDOB");
        txt.Attributes.Add("OnChange", "ExcedDate('" + txt.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {
            if (RoleID == 1)
            {
                //PhyHeader1.Visible = true;
                //UsrHeader1.Visible = false;
            }
            else
            {
                //PhyHeader1.Visible = false;
               // UsrHeader1.Visible = true;
            }
            IP = Convert.ToInt32(TaskHelper.SearchType.InPatientSearch);
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster); //returnCode = nurseBL.GetSearchActionsInPatient(RoleID, IP, out pages);
            dList.Items.Clear();
            #region Load Action Menu to Drop Down List
            if (lstActionMaster.Count > 0)
            {
                //lstActionsMaster = lstActionMaster.ToList();
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            #endregion
            //dList.DataSource = lstActionMaster;
            //dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            //dList.DataBind();

            if (ucINPatientSearch.HasResult)
            {
                aRow.Visible = true;

            }
            else
            {
                aRow.Visible = false;
            }
            ucINPatientSearch.DischargeInPatient = "true";
        }
    }
    protected void ucINPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (ucINPatientSearch.HasResult)
        {
            aRow.Visible = true;

        }
        else
        {
            aRow.Visible = false;
        }
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        long pid = 0;
        string vid = "";
        string sPatientName = "";
        long rCode = -1;
        long returnCode = -1;
        long pBornVisitID = -1;
        string roomStatus = string.Empty;
        string IsCreditBill = "N";
        pid = ucINPatientSearch.GetSelectedInPatient();
        string isSurgeryPatient = ucINPatientSearch.GetIsSurgeryPatient();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<PatientVisit> lstPatientVisitCount = new List<PatientVisit>();
        List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
        List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();

        long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(pid, out lstPatientVisit);
        long count = new IP_BL(base.ContextInfo).GetInPatientVisitCount(pid, out lstPatientVisitCount);

        if (lstPatientVisit.Count > 0)
        {
            vid = lstPatientVisit[0].PatientVisitId.ToString();
            sPatientName = lstPatientVisit[0].Name.ToString();
            if (lstPatientVisit[0].ClientMappingDetailsID > 0)
            {
                IsCreditBill = "Y";
            }

        }
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        patientBL.GetPatientDetailsPassingVisitID(Convert.ToInt64(vid), out lstPatient);
        List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();
        returnCode = new IP_BL(base.ContextInfo).GetDischargeSummaryDetailsForupdate(Convert.ToInt64(vid), out lstDischargeSummary, out lstDischargeInvNotes);

        rCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(vid), out pBornVisitID);
        long procID = 0;
        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
        Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
        objPatient_BL.BindOrderedPhysiotherapy(pid, Convert.ToInt64(vid), procID, out lstOrderedPhysiotherapy);

        // Actions for Blood Request ----

        if (dList.SelectedValue == "BloodBank_BloodRequest")
        {
            Response.Redirect("../BloodBank/BloodRequestForm.aspx?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        }

        #region Hardcode Action Master
        //if (dList.SelectedValue == "/InPatient/RoomBooking.aspx")
        //{
        //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP" + "&IsCB=" + IsCreditBill, true);
        //}
        //else
        //{
        //    if (OrgID == 26)
        //    {
        //        rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(vid), out lstBookStatus, out roomStatus);                    

        //        if (roomStatus == "Occupied")
        //        {
        //            if (pBornVisitID == 0 && lstPatientVisitCount.Count > 0 && dList.SelectedValue == "/Physician/IPCaseRecord.aspx")
        //            {
        //                Response.Redirect("../Patient/PatientDetails.aspx?pid=" + pid.ToString() + "&vid=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            }
        //            else if (lstDischargeSummary.Count > 0 && lstDischargeSummary[0].SummaryStatus == "Completed" && dList.SelectedValue == "/Physician/DischargeSummary.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Discharge summary already completed for this patient. Please contact Administrator');", true);
        //            }
        //            else if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" && lstPatient[0].SEX == "M")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for male patient');", true);
        //            }
        //            else if (pBornVisitID == 0 && dList.SelectedValue == "/InPatient/NeonatalNotes.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);
        //            }
        //            else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "/InPatient/PhysiotherapyNotes.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Physiotherapy ordered/Pending for this patient');", true);

        //            }
        //            else
        //            {

        //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            }
        //        }
        //        else if (pBornVisitID > 0)
        //        {
        //            if (lstPatientVisitCount.Count > 0 && dList.SelectedValue == "/Physician/IPCaseRecord.aspx")
        //            {
        //                Response.Redirect("../Patient/PatientDetails.aspx?pid=" + pid.ToString() + "&vid=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            }
        //            else if (lstDischargeSummary.Count > 0 && lstDischargeSummary[0].SummaryStatus == "Completed" && dList.SelectedValue == "/Physician/DischargeSummary.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Discharge summary already completed for this patient. Please contact Administrator');", true);
        //            }
        //            //Commented due to Dynamic DichargeSummmary
        //            //else if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" || dList.SelectedValue == "/Physician/IPCaseRecord.aspx" || dList.SelectedValue == "/Physician/DischargeSummary.aspx" || dList.SelectedValue == "/Physician/DischargeSummaryCaseSheet.aspx")
        //            //{
        //            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed new born baby');", true);
        //            //}
        //            else if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" || dList.SelectedValue == "/Physician/IPCaseRecord.aspx" || dList.SelectedValue == "/Physician/DischargeSummary.aspx" || dList.SelectedValue == "/DischargeSummary/DischargeSummaryDynamic.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed new born baby');", true);
        //            }
        //            else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "/InPatient/PhysiotherapyNotes.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Physiotherapy ordered/Pending for this patient');", true);

        //            }
        //            else
        //            {

        //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            }
        //        }
        //        else
        //        {
        //            if (dList.SelectedValue == "/Reception/InPatientRegistration.aspx")
        //            {
        //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP" + "&IsSurgeryPatient=" + isSurgeryPatient, true);

        //            }
        //            else if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" && lstPatient[0].SEX == "M")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for male patient');", true);

        //            }
        //            else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "/InPatient/PhysiotherapyNotes.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Physiotherapy ordered/Pending for this patient');", true);

        //            }
        //            else
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed as the Room is not occupied by this patient');", true);
        //            }
        //        }
        //    }
        //    else
        //    {
        //        if (pBornVisitID==0 && lstPatientVisitCount.Count > 0 && dList.SelectedValue == "/Physician/IPCaseRecord.aspx")
        //        {
        //            Response.Redirect("../Patient/PatientDetails.aspx?pid=" + pid.ToString() + "&vid=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //        }

        //        else if (pBornVisitID > 0)
        //        {
        //            //Commented due to Dynamic DichargeSummmary
        //            //if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" || dList.SelectedValue == "/Physician/IPCaseRecord.aspx" || dList.SelectedValue == "/Physician/DischargeSummary.aspx" || dList.SelectedValue == "/Physician/DischargeSummaryCaseSheet.aspx")
        //            //{
        //    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed new born baby');", true);
        //            //}
        //            if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" || dList.SelectedValue == "/Physician/IPCaseRecord.aspx" || dList.SelectedValue == "/Physician/DischargeSummary.aspx" || dList.SelectedValue == "/DischargeSummary/DischargeSummaryDynamic.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed new born baby');", true);
        //            }
        //            else if (dList.SelectedItem.Text == "Print Patient Admission Details")
        //            {
        //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&IP=Y", true);
        //            }
        //            else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "/InPatient/PhysiotherapyNotes.aspx")
        //            {
        //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Physiotherapy ordered/Pending for this patient');", true);

        //            }
        //            else
        //            {

        //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            }
        //        }
        //        else if (dList.SelectedItem.Text == "Print Patient Admission Details")
        //        {
        //            Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&IP=Y", true);
        //        }

        //        else if (lstDischargeSummary.Count > 0 && lstDischargeSummary[0].SummaryStatus == "Completed" && dList.SelectedValue == "/Physician/DischargeSummary.aspx")
        //        {
        //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Discharge summary already completed for this patient. Please contact Administrator');", true);
        //        }

        //        else if (dList.SelectedValue == "/InPatient/DeliveryNotes.aspx" && lstPatient[0].SEX == "M")
        //        {
        //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for male patient');", true);
        //        }
        //        else if (pBornVisitID == 0 && dList.SelectedValue == "/InPatient/NeonatalNotes.aspx")
        //        {
        //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);
        //        }
        //        else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "/InPatient/PhysiotherapyNotes.aspx")
        //        {
        //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Physiotherapy ordered/Pending for this patient');", true);

        //        }
        //        else if (dList.SelectedItem.Text == "Edit Referring Physicain")
        //        {
        //            //Response.Redirect("../DischargeSummary/DischargeSummaryDynamic.aspx?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
        //            Response.Redirect(Request.ApplicationPath + dList.SelectedItem.Value + "?vid=" + vid + "&pid=" + pid, true);
        //        }
        //        //else if (dList.SelectedItem.Text == "Discharge Summary")
        //        //{
        //        //    Response.Redirect("../Inpatient/KDRDischargeSummary.aspx?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);

        //        //}
        //        else
        //        {
        //            Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP" + "&IsSurgeryPatient=" + isSurgeryPatient, true);
        //        }
        //    }
        //}
        #endregion

        #region Get RedirectURL
        string sPath;
        if (pBornVisitID > 0)
        {
            if (dList.SelectedValue == "Labour_And_DeliveryNotes_DeliveryNotes" || dList.SelectedValue == "Admission_Notes_IPCaseRecord" || dList.SelectedValue == "Discharge_Summary_DischargeSummary" || dList.SelectedValue == "Print_Discharge_Summary_DischargeSummaryDynamic")
            {
                sPath = "Reception\\\\InPatientSearch.aspx.cs_4";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            }
            else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "Physiotherapy_Notes_PhysiotherapyNotes")
            {
                sPath = "Reception\\\\InPatientSearch.aspx.cs_5";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            }
        }
        else if (lstDischargeSummary.Count > 0 && lstDischargeSummary[0].SummaryStatus == "Completed" && dList.SelectedValue == "Discharge_Summary_DischargeSummary")
        {
            sPath = "Reception\\\\InPatientSearch.aspx.cs_6";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
        }
        else if (dList.SelectedValue == "Labour_And_DeliveryNotes_DeliveryNotes" && lstPatient[0].SEX == "M")
        {
            sPath = "Reception\\\\InPatientSearch.aspx.cs_3";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
        }
        else if (pBornVisitID == 0 && dList.SelectedValue == "Neonatal_Notes_NeonatalNotes")
        {
            sPath = "Reception\\\\InPatientSearch.aspx.cs_4";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
        }
        else if (lstOrderedPhysiotherapy.Count == 0 && dList.SelectedValue == "Physiotherapy_Notes_PhysiotherapyNotes")
        {
            sPath = "Reception\\\\InPatientSearch.aspx.cs_5";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
        }
        else if (dList.SelectedValue == "PRINT_OP_CARD")
        {
            vid = lstPatientVisit[0].PatientVisitId.ToString();
            PrintExistingPatientVisitDetailsXml(pid, Convert.ToInt32(vid));
        }
        else if (dList.SelectedValue == "Print_Patient_Registration_Details_PrintPatientRegistration")
        {
            vid = lstPatientVisit[0].PatientVisitId.ToString();

            PrintNewPatientVisitDetailsXml(pid, Convert.ToInt32(vid));
        }
        else
        {
            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();

            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = dList.SelectedValue;
            string ActionList = ViewState["ActionList"].ToString();
            foreach (string CompareList in ActionList.Split('^'))
            {
                if (CompareList.Split('~')[0] == ActCode)
                {
                    QueryString = CompareList.Split('~')[1];
                    break;
                }
            }
            #endregion
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = pid.ToString();
            objQueryMaster.PatientVisitID = vid.ToString();
            objQueryMaster.PatientName = sPatientName.ToString();
            objQueryMaster.ViewType = "IP";
            if (OrgID == 29)
            {
                objQueryMaster.CreditValue = string.Empty;
                objQueryMaster.Surgery = string.Empty;
            }
            else
            {
                objQueryMaster.CreditValue = IsCreditBill.ToString();
                objQueryMaster.Surgery = isSurgeryPatient.ToString();
            }
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                sPath = "Reception\\\\InPatientSearch.aspx.cs_20";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            }
            #endregion
        }
        #endregion

    }

    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
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
                    xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
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
                xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString());
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
}
