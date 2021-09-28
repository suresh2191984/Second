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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class BillGeneration : BasePage
{
    long pVisitID = 0;
    long pPatientID = 0;
    int pClientID = 0;
    long result = -1;
    int type = 0;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    long returncode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            Int64.TryParse(Request.QueryString["vid"], out pVisitID);
            Int64.TryParse(Request.QueryString["pid"], out pPatientID);
            Int32.TryParse(Request.QueryString["cid"], out pClientID);
            BillPrintCtrl.AddNewItem += new EventHandler(BillPrintCtrl_AddNewItem);
            if (Request.QueryString["PKG"] != null)
            {
                long retCode = 0;
                dBill.Style.Add("display", "block");
                dinves.Style.Add("display", "none");
                //BillPrintCtrl.LoadBillItems(lineItems[1].Split('-')[0], cid, rate, type);
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
                List<PatientInvestigation> lstPkg = new List<PatientInvestigation>();

                retCode = investigationBL.GetInvestigationByClientID(OrgID, pClientID, "PKG", out lstInvestigation);
                lstPkg = lstInvestigation.FindAll(delegate(PatientInvestigation h) { return (h.Type == "PKG" && h.GroupID == pClientID); });
                if(lstPkg.Count>0)
                BillPrintCtrl.LoadBillItems(lstPkg[0].GroupName, pClientID, lstPkg[0].Rate, "PKG");

            }
            else
            {
                dBill.Style.Add("display", "none");
                dinves.Style.Add("display", "block");
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                InvestigationControl1.ClientID = pClientID;
                List<PatientInvestigation> lstGroups = new List<PatientInvestigation>();
                List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
                investigationBL.GetInvestigationByClientID(OrgID, pClientID, "ALL", out lstGroups);
                investigationBL.GetInvestigationByClientID(OrgID, pClientID, "INV", out lstInvestigations);

                InvestigationControl1.LoadLabData(lstGroups, lstInvestigations);
            }
            BillPrintCtrl.addNewItemLblCaption = "Add Consumables";           

            LoadOrderedItems();
            lblPatientNo.Text = pPatientID.ToString();
            lblVisitNo.Text = pVisitID.ToString();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<Patient> patientList = new List<Patient>();
            result = patientBL.GetLabPatientDemoandAddress(pPatientID, out patientList);
            lblPatientName.Text = patientList[0].TitleName + " " + patientList[0].Name;
            if (patientList[0].SEX == "M")
            {
                lblGender.Text = "[Male]"; 
            }
            else
            {
                lblGender.Text = "[Female]";
            }
            lblAge.Text = patientList[0].Age.ToString();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in SampleRegistration.aspx:Page_Load", ex);
        }
    }

    void BillPrintCtrl_AddNewItem(object sender, EventArgs e)
    {
        dBill.Style.Add("display", "block");
        dinves.Style.Add("display", "none");
    }

    
    protected void btnBillShow_Click(object sender, EventArgs e)
    {
        dBill.Style.Add("display", "block");
        dinves.Style.Add("display", "none");
        //LoadOrderedItems();
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("PatientSampleRegistration.aspx",true);
    }
    public void LoadOrderedItems()
    {
        string hidValue = InvestigationControl1.HiddenFieldValue;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    long id = Convert.ToInt64(lineItems[0]);
                    int rIndex = lineItems[1].IndexOf("-"+CurrencyName+":");
                    strInvName = lineItems[1].Substring(0, rIndex);
                    strRate = lineItems[1].Substring(rIndex + 4);
                    decimal.TryParse(strRate, out rate);
                    string type = lineItems[2];
                    BillPrintCtrl.LoadBillItems(strInvName, id, rate, type);
                }

            }

        }
    }

    protected void lnkAddMore_Click(object sender, EventArgs e)
    {
        dBill.Style.Add("display", "none");
        dinves.Style.Add("display", "block");
        //Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID+"&cid="+pClientID, true);

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PatientSampleRegistration.aspx", true);
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {

        try
        {
            string gUID = string.Empty;
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
                
            }
            long returnCode = -1;
            string BillNo = string.Empty;
            int pOrderedInvCnt = 0;

            BillMaster billMaster = new BillMaster();
            billMaster = BillPrintCtrl.Getillmaster();
            List<PatientInvestigation> orderedInves = InvestigationControl1.GetOrderedList();
            List<PatientInvestigation> patInves = new List<PatientInvestigation>();

            foreach (PatientInvestigation patient in orderedInves)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = patient.InvestigationID;
                objInvest.InvestigationName = patient.InvestigationName;
                objInvest.PatientVisitID = pVisitID;
                objInvest.GroupID = patient.GroupID;
                objInvest.GroupName = patient.GroupName;
                objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objInvest.Status = "Ordered";
                objInvest.CreatedBy = LID;
                objInvest.Type = patient.Type;
                patInves.Add(objInvest);
            }
            returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(patInves, OrgID,"", out pOrderedInvCnt);
            if (returnCode == 0)
            {
                returnCode = BillPrintCtrl.GetBillItems(billMaster, pVisitID, pPatientID, out BillNo);

                long createTaskID = -1;

                // Create task to lab tech for collect samples
                //if (Convert.ToString(Request.QueryString["ftype"]) == "INV")
                //{

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), pVisitID, 0,
                pPatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID); ;                        
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = pVisitID;
                task.PatientID = pPatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task        

                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                // }


                if (returnCode != 0)
                {
                    //ErrorDisplay1.ShowError = true;
                    //ErrorDisplay1.Status = "Error while saving Billing Details. Please try after some time.";
                }
                else
                {
                    if (btnFinish.Text == "Finish")
                    {
                        // ErrorDisplay1.ShowError = true;
                        // ErrorDisplay1.Status = "Billing Completed Successfully.";

                    }

                }
                ViewState["TotalLineItems"] = "";
                Response.Redirect("ViewBill.aspx?type=N&billNo=" + BillNo, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Billing Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";

        }
    }
  
   

}
