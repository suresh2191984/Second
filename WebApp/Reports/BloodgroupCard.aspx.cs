using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Linq;
using ReportBusinessLogic;
using System.IO;
using System.Web;
using Attune.Podium.ExcelExportManager;


public partial class Reports_BloodgroupCard : BasePage 
{
    DataSet _dsStatics = new DataSet();
    List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
    public string DateFormat = string.Empty;
    public string TimeFormat = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        ////hdnOrgID.Value = Convert.ToString(OrgID);
        try
        {
            txtFromFormat.HRef = "javascript:NewCssCal('txtFrom'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
            txtToFormat.HRef = "javascript:NewCssCal('txtTo'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
            if (!IsPostBack)
            {
                DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
                DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
                string a = dt.ToString(DateTimeFormat);
                txtFrom.Text = a.Substring(0, 10) + " " + "00:00";
                txtTo.Text = a.ToString();
                hdnOrgID.Value = Convert.ToString(OrgID);
                modal.Visible = false;
                loadLocation();
                loadRoundName();
            }
            
            long hdnRoundID = Convert.ToInt32(ddRoundName.SelectedItem.Value);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load", ex);
        }
    }
 
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        long result = -1;
        LoginDetail objLoginDetail = new LoginDetail();
        List<BloodGroupCard> lstbldgrpcrd = new List<BloodGroupCard>();
        ReportBusinessLogic.ReportExcel_BL objReportBL = new ReportBusinessLogic.ReportExcel_BL();
        objLoginDetail.Orgid = OrgID;
        DateTime fromdate = Convert.ToDateTime(txtFrom.Text);
        DateTime todate;
        string temptodate = string.Empty;
        temptodate = Convert.ToString(txtTo.Text);
        string temp = temptodate.Split()[0] + " 23:59:59";
        todate = Convert.ToDateTime(txtTo.Text);
        int Addressid = 0;
        long RoundID = 0;
        if (ddLocation.SelectedItem.Text != "-Select-")
        { Addressid = Convert.ToInt32(ddLocation.SelectedValue); }
        if (ddRoundName.SelectedItem.Text != "-Select-")
        { RoundID = Convert.ToInt64(ddRoundName.SelectedItem.Value); }
        result = objReportBL.getBloodGrpCard(OrgID, fromdate, todate, Addressid, RoundID, out lstbldgrpcrd);
        DataTable dTable = new DataTable("blood groups");
        dTable = ConvertToUDT_Context(lstbldgrpcrd);
        DataSet ds = new DataSet();
        ds.Tables.Add(dTable);
        ds.Tables[0].TableName = "blood groups";
        
        string prefix = string.Empty;
        prefix = "blood groups ";
        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".XML";
        ExcelHelper.ToExcel(ds, rptDate, Page.Response);
      
    }
    public static System.Data.DataTable ConvertToUDT_Context(List<BloodGroupCard> lstOrdered)
    {

        System.Data.DataTable _datatable = new System.Data.DataTable();
        //
        
        _datatable.Columns.Add("Patient name", typeof(System.String));
        _datatable.Columns.Add("Patient ID", typeof(System.String));
        _datatable.Columns.Add("Result", typeof(System.String));
        _datatable.Columns.Add("Test date", typeof(System.String));
        _datatable.Columns.Add("Profiles", typeof(System.String));
        _datatable.Columns.Add("Orderer", typeof(System.String));
        _datatable.Columns.Add("Order date/time", typeof(System.String));
        _datatable.Columns.Add("Visit", typeof(System.String));
        _datatable.Columns.Add("Analyte", typeof(System.String));
        _datatable.Columns.Add("Printed", typeof(System.String));
        _datatable.Columns.Add("Order No.", typeof(System.String));
        //
        DataRow _datarow;
        foreach (BloodGroupCard _list in lstOrdered)
        {
            _datarow = _datatable.NewRow();
            _datarow["Patient name"] = (_list != null) ? _list.Patient_Name : String.Empty;
            _datarow["Patient ID"] = (_list != null) ? _list.Patient_ID : String.Empty;
            _datarow["Result"] = (_list != null) ? _list.Result : String.Empty;
            _datarow["Test date"] = (_list != null) ? _list.Test_Date : string.Empty;
            _datarow["Profiles"] = (_list != null) ? _list.Profiles : String.Empty;
            _datarow["Orderer"] = (_list != null) ? _list.Orderer : String.Empty;
            _datarow["Order date/time"] = (_list != null) ? _list.Order_date_time : String.Empty;
            _datarow["Visit"] = (_list != null) ? _list.Visit : String.Empty;
            _datarow["Analyte"] = (_list != null) ? _list.Analyte : String.Empty;
            _datarow["Printed"] = (_list != null) ? _list.Printed : String.Empty;
            _datarow["Order No."] = (_list != null) ? _list.Order_No : String.Empty;
            _datatable.Rows.Add(_datarow);
        }
        
        return _datatable;
    }

    public void  loadLocation()
    {
         List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        PatientVisit_BL PatientvisitBL = new PatientVisit_BL();
        long returnCode = -1;
        long orgID=OrgID;
        hdnRoleID.Value  = Convert.ToString(RoleID);
        hdnLID.Value = Convert.ToString(LID);
        returnCode = PatientvisitBL.GetLocation(orgID, LID, RoleID, out lstLocation);
        ddLocation.DataSource = lstLocation;
        ddLocation.DataTextField = "Location";
        ddLocation.DataValueField = "AddressID";
        ddLocation.DataBind();
        ddLocation.Items.Insert(0, new ListItem("-Select-", string.Empty));

    }
    public void loadRoundName()
    {
        long returnCode = -1;
        string prefixText = "";
        string searchType = "Round";
        List<RoundMaster> lstRound = new List<RoundMaster>();
        ReportBusinessLogic.ReportExcel_BL objReportBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
        objReportBL.GetRoundNameList("", OrgID, "", out lstRound);
        returnCode = objReportBL.GetRoundNameList(prefixText, OrgID, searchType, out lstRound);
        ddRoundName.DataSource=lstRound;
        ddRoundName.DataValueField = "RoundID";
        ddRoundName.DataTextField = "RoundName";
        ddRoundName.DataBind();
        ddRoundName.Items.Insert(0, new ListItem("-Select-", string.Empty));

    }
}
