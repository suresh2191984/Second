using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;
using System.Security.Cryptography;
using System.Text;

public partial class Lab_Test : BasePage
{
    string Task = string.Empty;
    string PatientName = string.Empty;
    int HC;
    int searchtype;
    List<InvestigationQueue> lstTest = new List<InvestigationQueue>();

    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    string GUID = Guid.NewGuid().ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        //AutoCompleteProduct.ContextKey = "Y";
       
        if (!IsPostBack)
        {

            hdnPatientID.Value = "";
            hdnSelectedPatientID.Value = "";
            rdoRetest.Focus();
            rdoRetest.Checked = true;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            invbl.GetInvestigationSamplesCollect(0, OrgID, RoleID,"", ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
            ddlSampleName.DataSource = lstInvSampleMaster;

            ddlSampleName.DataTextField = "SampleDesc";
            ddlSampleName.DataValueField = "SampleCode";
            ddlSampleName.DataBind();
            ddlSampleName.Items.Insert(0, new ListItem("--Select--", "0"));
            if (RoleName == "Lab Technician")
            {
                dList.Items.Insert(0, new ListItem("Investigation Capture", "1"));
            }
            if(RoleName=="Phlebotomist")
            {
                dList.Items.Insert(0, new ListItem("Collect sample", "0"));
            }

            AutoCompleteProduct.ContextKey = Convert.ToString("Y");
            //btnSearch_Click(this, e);


            HC = 32;// Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 

            if (IsTrustedOrg == "Y")
            {
                returnCode = nurseBL.GetActionsIsTrusterdOrg(RoleID, HC, out lstActionMaster);
            }
            else
            {
                returnCode = nurseBL.GetActions(RoleID, HC, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }
            //dList.DataSource = lstActionMaster;
            //dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            //dList.DataBind();
            searchtype = 0;


            //new Investigation_BL(base.ContextInfo).GetTestDetails(OrgID, searchtype, out lstTest);
            //if (lstTest.Count > 0)
            //{
            //    grdResult.DataSource = lstTest;
            //    grdResult.DataBind();
            //    aRow.Style.Add("display", "block");
            //}

        }

    }



    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InvestigationQueue T = (InvestigationQueue)e.Row.DataItem;

            string strScript = "SelectRow('" + ((CheckBox)e.Row.Cells[1].FindControl("ChkSel")).ClientID + "','" + T.TestID + "','" + T.PatientID + "','" + T.Status + "','" + T.VisitID + "','" + T.UID + "','" + T.ClientID + "','" + T.AccessionNumber + "');";
            ((CheckBox)e.Row.Cells[0].FindControl("ChkSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((CheckBox)e.Row.Cells[0].FindControl("ChkSel")).Attributes.Add("onclick", strScript);
        }
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        //Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?pid=" + hdnPatientID.Value.ToString() + "&TestID=" + hdnTestID.Value.ToString() + "&vid=" + hdnvid.Value.ToString() + "&gUID=" + hdnUID.Value.ToString() + "&tid=0" + "&cid=" + hdnClientID.Value.ToString(), true);
        string page = string.Empty;
        string LabNo=string.Empty;
        long ReorderedVisitID = -1;
        long returnCode = -1;
        List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
        // List<OrderedInvestigations> orderedInves = GetOrderedList();
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        long RefID = -1; string RefType = "";
        returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "INV", out LabNo, RefID, RefType);
        if (dList.Visible == true)
        {
            if (dList.SelectedItem.Text == "Order Investigation")
            {
                page = "/Reception/InvestigationSearch.aspx?pid=" + hdnPatientID.Value.ToString() + "&gUID=" + hdnUID.Value.ToString().ToString();
            }
            else if (dList.SelectedItem.Text == "Make Bill Entry")
            {
                page = "/Reception/LabPatientRegistration.aspx?pid=" + hdnPatientID.Value.ToString() + "&gUID=" + hdnUID.Value.ToString().ToString();
            }
            else if (dList.SelectedItem.Text == "Collect sample")
            {

                long InvID = 0;
                
                foreach (GridViewRow Gv in grdResult.Rows)
                {
                    CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                    if (chkID.Checked == true)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                        Label lblType = (Label)Gv.FindControl("lblType");
                        Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                        Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");
                        Label lblOrderedUID = (Label)Gv.FindControl("lblOrderedUID");



                        objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                        objInvest.Name = lblInvestigationName.Text;
                        objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                        objInvest.Status = "Paid";
                        objInvest.PaymentStatus = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = lblType.Text;
                        objInvest.OrgID = OrgID;
                        objInvest.LabNo = LabNo;
                        objInvest.ReferenceType = "R";
                        if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                        {
                            objInvest.UID = GUID = lblOrderedUID.Text;
                        }
                        else
                        {
                            objInvest.UID = GUID;
                        }
                        objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        ordInves.Add(objInvest);

                    }
                }
                page = "/Lab/InvestigationSample.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString();
            }
            else
            {
                long InvID = 0;
                
                foreach (GridViewRow Gv in grdResult.Rows)
                {
                    CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                    if (chkID.Checked == true)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                        Label lblType = (Label)Gv.FindControl("lblType");
                        Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                        Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");
                        Label lblOrderedUID = (Label)Gv.FindControl("lblOrderedUID");



                        objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                        objInvest.Name = lblInvestigationName.Text;
                        objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                        objInvest.Status = "Pending";
                        objInvest.PaymentStatus = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = lblType.Text;
                        objInvest.OrgID = OrgID;
                        objInvest.LabNo = LabNo;
                        objInvest.ReferenceType = "R";
                        if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                        {
                            objInvest.UID = GUID = lblOrderedUID.Text;
                        }
                        else
                        {
                            objInvest.UID = GUID;
                        }
                        objInvest.ReferedToLocation = ILocationID;
                        objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        ordInves.Add(objInvest);

                    }
                }
                page = "/Investigation/InvestigationResultsCapture.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&Invid=";
            }
        }
        else
        {

            if (dList1.SelectedItem.Text == "Order Investigation")
            {
                page = "/Reception/InvestigationSearch.aspx?pid=" + hdnPatientID.Value.ToString() + "&gUID=" + hdnUID.Value.ToString() + "&billtype=skip";

            }
            else if (dList1.SelectedItem.Text == "Make Bill Entry")
            {
                page = "/Reception/LabPatientRegistration.aspx?pid=" + hdnPatientID.Value.ToString() + "&gUID=" + hdnUID.Value.ToString();
            }
            else if (dList1.SelectedItem.Text == "Collect sample")
            {
                long InvID = 0;
                
                foreach (GridViewRow Gv in grdResult.Rows)
                {
                    CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                    if (chkID.Checked == true)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                        Label lblType = (Label)Gv.FindControl("lblType");
                        Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                        Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");



                        objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                        objInvest.Name = lblInvestigationName.Text;
                        objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                        objInvest.Status = "Paid";
                        objInvest.PaymentStatus = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = lblType.Text;
                        objInvest.OrgID = OrgID;
                        objInvest.UID = GUID;
                        objInvest.LabNo = LabNo;
                        objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        ordInves.Add(objInvest);

                    }
                }
                page = "/Lab/InvestigationSample.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString();
            }
            else
            {
                long InvID = 0;
                
                foreach (GridViewRow Gv in grdResult.Rows)
                {
                    CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                    if (chkID.Checked == true)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                        Label lblType = (Label)Gv.FindControl("lblType");
                        Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                        Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");



                        objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                        objInvest.Name = lblInvestigationName.Text;
                        objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                        objInvest.Status = "SampleReceived";
                        objInvest.PaymentStatus = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = lblType.Text;
                        objInvest.OrgID = OrgID;
                        objInvest.UID = GUID;
                        objInvest.LabNo = LabNo;
                        objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        ordInves.Add(objInvest);
                    }
                }
                page = "/Investigation/InvestigationResultsCapture.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&Invid=";
                //page = "/Reception/InvestigationSearch.aspx?pid=" + hdnPatientID.Value.ToString() + "&gUID = " + hdnUID.Value.ToString().ToString();
            }
        }

        if (ordInves.Count > 0)
        {
            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(ordInves, OrgID);
        }

        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
        List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
        List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        List<InvDeptMaster> deptList = new List<InvDeptMaster>();
        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
        List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
        List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
        List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
        List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
        int pOrderedCount = -1;
        invbl.GetInvestigationSamplesCollect(Convert.ToInt64(hdnvid.Value), OrgID, RoleID, GUID, ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

        foreach (PatientInvestigation patient in lstPatientInvestigation)
        {

            PatientInvestigation objInvest = new PatientInvestigation();
            objInvest.InvestigationID = patient.InvestigationID;
            objInvest.InvestigationName = patient.InvestigationName;
            objInvest.PatientVisitID = patient.PatientVisitID;
            objInvest.GroupID = patient.GroupID;
            objInvest.GroupName = patient.GroupName;
            objInvest.Status = patient.Status;
            objInvest.CollectedDateTime = patient.CreatedAt;
            objInvest.CreatedBy = LID;
            objInvest.Type = patient.Type;
            objInvest.OrgID = OrgID;
            objInvest.InvestigationMethodID = 0;
            objInvest.KitID = 0;
            objInvest.InstrumentID = 0;
            objInvest.UID = patient.UID;
            SaveInvestigation.Add(objInvest);
        }
        if (lstPatientInvestigation.Count > 0)
        {
            if (lstPatientInvestigation[0].UID != null)
            {
                GUID = lstPatientInvestigation[0].UID;
            }
        }







        if (SaveInvestigation.Count > 0)
        {
            returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation,OrgID,GUID,out pOrderedCount);
        }

        Response.Redirect(Request.ApplicationPath + page + "&TestID=" + hdnTestID.Value.ToString() + "&vid=" + hdnvid.Value.ToString() + "&tid=0" + "&cid=" + hdnClientID.Value.ToString() + "&AccNo=" + hdnAccessionNumber.Value.ToString(), true);

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


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (rdoRetest.Checked == true)
        {
            searchtype = 1;
            dList.Visible = true;
            dList1.Visible = false;

        }
        else if (rdoRefelectTest.Checked == true)
        {
            searchtype = 2;
            dList1.Visible = true;
            dList.Visible = false;

        }
        else
        {
            searchtype = 0;
        }
        long PatientID = -1;
        long SampleCode=-1;
        string BillNumber = String.Empty;
        if (hdnSearchPatientID.Value == "")
        {
            PatientID = 0;
        }
        if (hdnSearchPatientID.Value != null && hdnSearchPatientID.Value != "")
        {
            PatientID=Convert.ToInt64(hdnSearchPatientID.Value);
        }
       
        if (txtBillNumber.Text != null && txtBillNumber.Text != "")
        {
            BillNumber = txtBillNumber.Text.Trim();
        }
        SampleCode = Convert.ToInt64(ddlSampleName.SelectedItem.Value);
        new Investigation_BL(base.ContextInfo).GetTestDetails(OrgID, searchtype, PatientID, BillNumber, SampleCode, out lstTest);
        
            grdResult.DataSource = lstTest;
            grdResult.DataBind();
            if (lstTest.Count > 0)
            {
                aRow.Style.Add("display", "block");
            }
            else
            {
                aRow.Style.Add("display", "none");
            }
    }
}

