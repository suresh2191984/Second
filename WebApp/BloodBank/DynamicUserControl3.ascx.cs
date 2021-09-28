using System;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Podium.SmartAccessor;
using System.Linq;
using Attune.Podium.EMR;
using Attune.Podium.Common;
using System.Data;

public partial class BloodBank_DynamicUserControl3 : BaseControl
{
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    private string id;
    private string attriName;

    public string AttriName
    {
        get { return attriName; }
        set {
            attriName = value;
        }
    }
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        
            int returnval = -1;
            attribute = new List<PatientComplaint>();
            attrValue = new List<PatientComplaintAttribute>();
            List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
            List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
            CheckBoxList chklist = (CheckBoxList)phDDLCHKLiver.FindControl("chkLstItem");
            try
            {
                #region Liver
                if (rdoYes_78.Checked == true)
                {
                    PatientComplaint objPatientComplaint = new PatientComplaint();
                    objPatientComplaint.ComplaintID = Convert.ToInt32(78);
                    objPatientComplaint.ComplaintName = rdoYes_78.Text;
                    lstPatientComplaint.Add(objPatientComplaint);
                    attribute.Add(objPatientComplaint);
                    for (int i = 0; i < chklist.Items.Count; i++)
                    {
                        if (chklist.Items[i].Selected == true)
                        {
                            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(78);
                            objPatientComplaintAttribute.AttributeID = Convert.ToInt64(28);
                            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                            objPatientComplaintAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                            attrValue.Add(objPatientComplaintAttribute);
                        }
                    }
                }
                #endregion

            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }

        return returnval;
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {

        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKLiver.FindControl("chkLstItem");
        try
        {
            #region Liver
            if (rdoYes_78.Checked == true)
            {
                PatientHistory objPatientHistory = new PatientHistory();
                objPatientHistory.HistoryID = Convert.ToInt32(78);
                objPatientHistory.HistoryName = rdoYes_78.Text;
                lstPatientHistory.Add(objPatientHistory);
                attribute.Add(objPatientHistory);
                for (int i = 0; i < chklist.Items.Count; i++)
                {
                    if (chklist.Items[i].Selected == true)
                    {
                        PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
                        objPatientHistoryAttribute.HistoryID = Convert.ToInt32(78);
                        objPatientHistoryAttribute.AttributeID = Convert.ToInt64(28);
                        objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                        objPatientHistoryAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                        lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                        attrValue.Add(objPatientHistoryAttribute);
                    }
                }
            }
            #endregion

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }

        return returnval;
    }
    public void LoadDiabData()
    {
        long visitID = -1;
        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;

        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        long id1 = 332; long id2 = 402; long id3 = 409;

        try
        {
            List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
            List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
            List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
            List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
            List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
            List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
            List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
            ArrayList lstPatientASel = new ArrayList();
            ArrayList lstPatientSel = new ArrayList();

            //returnCode = new SmartAccessor().GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

            if (lstANCPatientDetails.Count > 0)
            {
                
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }

    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        List<PatientComplaintAttribute> lstLiver = (from s in lsthisPCA
                       where s.ComplaintID == ID
                       select s).ToList();
        lblHeading.Text = lstLiver[0].ControlName.Split('^')[1];
            if (lstLiver.Count() > 0)
            {
                List<EMRAttributeClass> drugs = (from n in lstLiver
                                                 where n.AttributeID == 28
                                                 select new EMRAttributeClass
                                                 {

                                                     AttributeName = n.AttributeName,
                                                     AttributevalueID = n.AttributevalueID,
                                                     AttributeValueName = n.AttributeValueName
                                                 }).ToList();
                //ddlLiver.DataSource = drugs.ToList();
                //ddlLiver.DataTextField = "AttributeValueName";
                //ddlLiver.DataValueField = "AttributevalueID";
                //ddlLiver.DataBind();


                {
                    DropDownList ddl = new DropDownList();
                    ddl.ID = "ddlChkList1";
                    ListItem lstItem = new ListItem();
                    ddl.Items.Insert(0, lstItem);
                    ddl.Width = new Unit(155);
                    ddl.Attributes.Add("onmousedown", "showdivonClick2()");
                    CheckBoxList chkBxLst = new CheckBoxList();
                    chkBxLst.ID = "chkLstItem";
                    chkBxLst.Attributes.Add("onmouseover", "showdiv()");
                    DataTable dtListItem = GetListItem(drugs);
                    int rowNo = dtListItem.Rows.Count;
                    string lstValue = string.Empty;
                    string lstID = string.Empty;
                    for (int i = 0; i < rowNo ; i++)
                    {

                        lstValue = dtListItem.Rows[i]["Value"].ToString();
                        lstID = dtListItem.Rows[i]["ID"].ToString();
                        lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                        lstItem.Attributes.Add("onclick", "getSelectedItem('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
                        lstItem.Value = dtListItem.Rows[i]["AttributeValue"].ToString();
                        lstItem.Text = dtListItem.Rows[i]["Value"].ToString();
                        chkBxLst.Items.Add(lstItem);
                    }
                    System.Web.UI.HtmlControls.HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                    div.ID = "divChkList";
                    div.Controls.Add(chkBxLst);
                    div.Style.Add("border", "black 1px solid");
                    div.Style.Add("width", "160px");
                    div.Style.Add("height", "180px");
                    div.Style.Add("overflow", "AUTO");
                    div.Style.Add("display", "none");
                    phDDLCHKLiver.Controls.Add(ddl);
                    phDDLCHKLiver.Controls.Add(div);
                }
            }
            rdoNo_78.ID = "rdoNo_" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoYes_78.ID = "rdoYes_" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoUnknown_78.ID = "rdoUnknown_" + Convert.ToString(lstLiver[0].ComplaintID);
            divrdoYes_78.ID = "divrdoYes_" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoYes_78.GroupName = "radioExtend" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoNo_78.GroupName = "radioExtend" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoUnknown_78.GroupName = "radioExtend" + Convert.ToString(lstLiver[0].ComplaintID);
            rdoNo_78.Checked = true;
    }
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        List<PatientHistoryAttribute> lstPHA = (from s in lsthisPHA
                                                    where s.HistoryID == ID
                                                    select s).ToList();
        lblHeading.Text = lstPHA[0].ControlName.Split('^')[1];
        if (lstPHA.Count() > 0)
        {
            List<EMRAttributeClass> drugs = (from n in lstPHA
                                             where n.AttributeID == 121
                                             select new EMRAttributeClass
                                             {

                                                 AttributeName = n.AttributeName,
                                                 AttributevalueID = n.AttributevalueID,
                                                 AttributeValueName = n.AttributeValueName
                                             }).ToList();
            //ddlLiver.DataSource = drugs.ToList();
            //ddlLiver.DataTextField = "AttributeValueName";
            //ddlLiver.DataValueField = "AttributevalueID";
            //ddlLiver.DataBind();


            {
                DropDownList ddl = new DropDownList();
                ddl.ID = "ddlChkList2";
                ListItem lstItem = new ListItem();
                ddl.Items.Insert(0, lstItem);
                ddl.Width = new Unit(155);
                ddl.Attributes.Add("onmousedown", "showdivonClick3()");
                CheckBoxList chkBxLst = new CheckBoxList();
                chkBxLst.ID = "chkLstItem2";
                chkBxLst.Attributes.Add("onmouseover", "showdiv2()");
                DataTable dtListItem = GetListItem(drugs);
                int rowNo = dtListItem.Rows.Count;
                string lstValue = string.Empty;
                string lstID = string.Empty;
                for (int i = 0; i < rowNo; i++)
                {

                    lstValue = dtListItem.Rows[i]["Value"].ToString();
                    lstID = dtListItem.Rows[i]["ID"].ToString();
                    lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                    lstItem.Attributes.Add("onclick", "getSelectedItem2('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
                    lstItem.Value = dtListItem.Rows[i]["AttributeValue"].ToString();
                    lstItem.Text = dtListItem.Rows[i]["Value"].ToString();
                    chkBxLst.Items.Add(lstItem);
                }
                System.Web.UI.HtmlControls.HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                div.ID = "divChkList2";
                div.Controls.Add(chkBxLst);
                div.Style.Add("border", "black 1px solid");
                div.Style.Add("width", "160px");
                div.Style.Add("height", "180px");
                div.Style.Add("overflow", "AUTO");
                div.Style.Add("display", "none");
                phDDLCHKLiver.Controls.Add(ddl);
                phDDLCHKLiver.Controls.Add(div);
            }
        }
        lblCheckItems.ID = "lblCheckItems2";
        rdoNo_78.ID = "rdoNo_" + Convert.ToString(lstPHA[0].HistoryID);
        rdoYes_78.ID = "rdoYes_" + Convert.ToString(lstPHA[0].HistoryID);
        rdoUnknown_78.ID = "rdoUnknown_" + Convert.ToString(lstPHA[0].HistoryID);
        divrdoYes_78.ID = "divrdoYes_" + Convert.ToString(lstPHA[0].HistoryID);
        rdoYes_78.GroupName = "radioExtend" + Convert.ToString(lstPHA[0].HistoryID);
        rdoNo_78.GroupName = "radioExtend" + Convert.ToString(lstPHA[0].HistoryID);
        rdoUnknown_78.GroupName = "radioExtend" + Convert.ToString(lstPHA[0].HistoryID);
        rdoNo_78.Checked = true;
    }
    public DataTable GetListItem(List<EMRAttributeClass> drugs)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ID", typeof(int));
        table.Columns.Add("Value", typeof(string));
        table.Columns.Add("AttributeValue", typeof(int));
        for (int i = 0; i < drugs.Count; i++)
        {
            table.Rows.Add((i + 1), drugs[i].AttributeValueName,drugs[i].AttributevalueID);
        }
        return table;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA,long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKLiver.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHKLiver.FindControl("ddlChkList1");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                for (int i = 0; i < chklist.Items.Count; i++)
                {
                    if (chklist.Items[i].Value == lstEditData[j].AttributevalueID.ToString())
                    {
                        chklist.Items[i].Selected = true;
                        cnt = cnt + 1;
                        if (text == "")
                        {
                            text = lstEditData[j].AttributeValueName;
                        }
                        else
                        text = text + "," + lstEditData[j].AttributeValueName;
                    }
                }

                ddllist.SelectedItem.Text = cnt + " items";
                lblCheckItems.Text = text;
                //if (lstEditData[j].AttributeID == 34)
                //{
                //    if (lstEditData[j].AttributeValueName != "")
                //    {
                //        chkJaundice.Checked = true;
                //    }
                //    else chkJaundice.Checked = false;
                //}
                divrdoYes_78.Style.Add("display", "block");
                rdoYes_78.Checked = true;
                rdoNo_78.Checked = false;
            }
        }
    }
    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                       where s.HistoryID == ID
                                                       select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKLiver.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHKLiver.FindControl("ddlChkList1");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].HistoryID == ID)
            {
                for (int i = 0; i < chklist.Items.Count; i++)
                {
                    if (chklist.Items[i].Value == lstEditData[j].AttributevalueID.ToString())
                    {
                        chklist.Items[i].Selected = true;
                        cnt = cnt + 1;
                        if (text == "")
                        {
                            text = lstEditData[j].AttributeValueName;
                        }
                        else
                            text = text + "," + lstEditData[j].AttributeValueName;
                    }
                }

                ddllist.SelectedItem.Text = cnt + " items";
                lblCheckItems.Text = text;
                //if (lstEditData[j].AttributeID == 34)
                //{
                //    if (lstEditData[j].AttributeValueName != "")
                //    {
                //        chkJaundice.Checked = true;
                //    }
                //    else chkJaundice.Checked = false;
                //}
                divrdoYes_78.Style.Add("display", "block");
                rdoYes_78.Checked = true;
                rdoNo_78.Checked = false;
            }
        }
    }
}
