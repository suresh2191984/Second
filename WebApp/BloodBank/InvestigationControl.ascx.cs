using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.Data;

public partial class BloodBank_InvestigationControl : BaseControl
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BloodBank/Home.aspx");
    }
    protected void btnOrder_Click(object sender, EventArgs e)
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        long returnCode = -1;
        long taskID = -1;
        string labno = string.Empty;
        for(int i=0;i<chklInvestigations.Items.Count;i++)
        {
            if (chklInvestigations.Items[i].Selected == true)
            {
                OrderedInvestigations PatientInves = new OrderedInvestigations();
                //id = Convert.ToInt64(lineItems[0]);
                //int rIndex = lineItems[1].IndexOf("(NA)");
                //strInvName = lineItems[1].Substring(0, rIndex);
                //strRate = lineItems[1].Substring(rIndex + 2);
                //decimal.TryParse(strRate, out rate);
                //string type = lineItems[2];
                //PatientInves.Rate = rate;
                //PatientInves.Type = type;
                PatientInves.ID = Convert.ToInt32(chklInvestigations.Items[i].Value);
                PatientInves.Name = chklInvestigations.Items[i].Text;
                PatientInves.VisitID = visitID;
                PatientInves.OrgID = OrgID;
                PatientInves.StudyInstanceUId = CreateUniqueDecimalString();
                PatientInves.Status = "Ordered";
                PatientInves.CreatedBy = LID;
                PatientInves.Type = "INV";
                lstpatInves.Add(PatientInves);
            }
        }
        returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, lstpatInves, out labno);
        long result = 0;
        int pOrderedInvCnt = 0;
        string paymentstatus = "Paid";
        string GUID = Guid.NewGuid().ToString();
        returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(lstpatInves, OrgID, out pOrderedInvCnt, paymentstatus, GUID, labno);
        if (returnCode == 0)
        {
            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), visitID, 0,
                patientID, lstPatientVisitDetails[0].TitleName + " " + patientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = visitID;
            task.PatientID = patientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = labno.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out taskID);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Investigation(s) ordered successfully.');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey3", "javascript:ChangeInvestigationStatus();", true);
            //Response.Redirect(@"../Patient/ViewEMRPackages.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&Show=Y" + "", true);
        }
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

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
}
