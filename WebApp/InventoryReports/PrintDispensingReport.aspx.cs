using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PrintDispensingReport : Attune_BasePage
{
    public InventoryReports_PrintDispensingReport()
        : base("InventoryReports_PrintDispensingReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<BillingDetails> lstHeadBillingDetails = new List<BillingDetails>();
    long returnCode = -1;
    int totalRows = 0;
     string strBillNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_01 == null ? "Bill No" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_01;
    string strDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_02 == null ? "Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_02;
    string strName = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_03 == null ? "Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_03;
    string strAge = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_04 == null ? "Age/sex" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_04;
    string strAddress = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_05 == null ? "Address" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_05;
    string strDetails = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_06 == null ? "Details" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintDispensingReport_aspx_06;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                LoadVisitType();
                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                int DepartmentID = Convert.ToInt16(Request.QueryString["pdeID"]) > 0 ? Convert.ToInt16(Request.QueryString["pdeID"]) : 0;

                int visitType;

                if (rblVisitType.SelectedItem.Value != "")
                {
                    visitType = Convert.ToInt16(rblVisitType.SelectedItem.Value);
                }

                else
                {
                    visitType = -1;
                }
                string Billno = Convert.ToString(Request.QueryString["Bno"]!= null && Request.QueryString["Bno"].Trim() == "" ? "-1" : Request.QueryString["Bno"]) ;
                string PName = Request.QueryString["pnme"] != null && Request.QueryString["pnme"].Trim() == "" ? "" : Request.QueryString["pnme"];
                string Product = Request.QueryString["pro"] != null && Request.QueryString["pro"].Trim() == "" ? "" : Request.QueryString["pro"];
                int pdeID = Convert.ToInt32(Request.QueryString["pdeID"] != null && Request.QueryString["pdeID"].Trim() == "" ? "0" : Request.QueryString["pdeID"]);
                fromToDispensingRecords.Text = "Dispensing Records &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From &nbsp;&nbsp;" + fromDate.ToString("dd/MM/yyyy") + " &nbsp;&nbsp;&nbsp;&nbsp; To &nbsp;&nbsp;" + toDate.ToString("dd/MM/yyyy");
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderDispensingRecords.Text = "DISPENSING REC";
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;


                returnCode = new InventoryReports_BL(base.ContextInfo).GetDispensingReport(fromDate, toDate, OrgID, Billno, PName, ILocationID, Product, 0,visitType, 0, out totalRows, pdeID, out lstHeadBillingDetails, out lstBillingDetails);

                lstHeadBillingDetails = (from S in lstBillingDetails
                                         join T in lstHeadBillingDetails on S.FinalBillID equals T.FinalBillID
                                         select T).Distinct().ToList();
                
                LoadDispensingReportHeaders();


            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in PrintDispensingReport.aspx", ex);
            }
        }
    }
    public void LoadVisitType()
    {
        string domains = "VisitType,";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }
        returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, languageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "VisitType"
                             orderby child.DisplayText descending
                             select child;
            if (lstmetadataOutput.Count > 0)
            {
                rblVisitType.DataSource = childItems;
                rblVisitType.DataTextField = "DisplayText";
                rblVisitType.DataValueField = "Code";
                rblVisitType.DataBind();
            }
        }
    }
   
    private void LoadDispensingReportHeaders()
    {


        if (lstHeadBillingDetails.Count > 0)
        {

            TableRow headRow = new TableRow();
            TableCell hBillNo = new TableCell();
            TableCell hDate = new TableCell();
            TableCell hName = new TableCell();
            TableCell hAge = new TableCell();
            TableCell hAddress = new TableCell();
            TableCell hDetails = new TableCell();
            hBillNo.Attributes.Add("align", "left");
            hBillNo.Text = strBillNo;
            hBillNo.Width = Unit.Percentage(8);

            hDate.Attributes.Add("align", "left");
            hDate.Text = strDate;
            hDate.Width = Unit.Percentage(8);

            hName.Attributes.Add("align", "left");
            hName.Text = strName;
            hName.Width = Unit.Percentage(20);

            hAge.Attributes.Add("align", "left");
            hAge.Text = strAge;
            hAge.Width = Unit.Percentage(10);

            hAddress.Attributes.Add("align", "left");
            hAddress.Text = strAddress;
            hAddress.Width = Unit.Percentage(25);

            hDetails.Attributes.Add("align", "left");
            hDetails.Text = strDetails;
            hDetails.Width = Unit.Percentage(40);


            headRow.Cells.Add(hBillNo);
            headRow.Cells.Add(hDate);
            headRow.Cells.Add(hName);
            headRow.Cells.Add(hAge);
            headRow.Cells.Add(hAddress);
            headRow.Cells.Add(hDetails);
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 6;
            headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);


            foreach (BillingDetails item in lstHeadBillingDetails)
            {
                
                TableRow deadRow = new TableRow();
                TableRow cchildRow = new TableRow();

                TableCell dBillNo = new TableCell();
                TableCell dDate = new TableCell();
                TableCell dName = new TableCell();
                TableCell dAge = new TableCell();
                TableCell dAddress = new TableCell();
                TableCell dDetails = new TableCell();

                TableCell dchild = new TableCell();
                

                dBillNo.Attributes.Add("align", "left");
                dBillNo.Text = item.FinalBillID.ToString();

                dDate.Attributes.Add("align", "left");
                dDate.Text = item.CreatedAt.ToString("dd/MM/yyyy");

                dName.Attributes.Add("align", "left");
                dName.Text = item.Name;

                dAge.Attributes.Add("align", "left");
                dAge.Text = item.Age;

                dAddress.Attributes.Add("align", "left");
                dAddress.Text = item.Address;

                deadRow.Cells.Add(dBillNo);
                deadRow.Cells.Add(dDate);
                deadRow.Cells.Add(dName);
                deadRow.Cells.Add(dAge);
                deadRow.Cells.Add(dAddress);
               
                Table childTable = new Table();
                foreach (BillingDetails child in lstBillingDetails.FindAll(p => p.FinalBillID  == item.FinalBillID))
                {
                    TableRow childRow = new TableRow();
                    TableCell cProductName = new TableCell();
                    TableCell cQty = new TableCell();
                    TableCell cUnit = new TableCell();
                    TableCell cUnit1 = new TableCell();
                    TableCell cEmpDate = new TableCell();
                    TableCell cBatch = new TableCell();
                    cProductName.Attributes.Add("align", "left");
                    cProductName.Text = child.FeeDescription.ToString();
                    cProductName.Width = Unit.Percentage(60);

                    cQty.Attributes.Add("align", "left");
                    cQty.Text = String.Format("{0:0}", child.Quantity);
                    cQty.Width = Unit.Percentage(2);

                    cUnit.Attributes.Add("align", "left");
                    cUnit.Text = child.SellingUnit.ToString();
                    cUnit.Width = Unit.Percentage(2);

                    cEmpDate.Attributes.Add("align", "left");
                    cEmpDate.Text = SetExpDateIn(child.ExpiryDate.ToString());
                    cEmpDate.Width = Unit.Percentage(4);

                    cBatch.Attributes.Add("align", "left");
                    cBatch.Text = child.BatchNo.ToString();
                    cBatch.Width = Unit.Percentage(4);


                    childRow.Cells.Add(cProductName);
                    childRow.Cells.Add(cQty);
                    childRow.Cells.Add(cUnit);
                    childRow.Cells.Add(cUnit1);
                    childRow.Cells.Add(cBatch);
                    childRow.Cells.Add(cEmpDate);
                    childTable.Rows.Add(childRow);
                }
                dDetails.Attributes.Add("align", "left");
                dDetails.Controls.Add(childTable);
                deadRow.Cells.Add(dDetails);

                DataHeaders.Rows.Add(deadRow);
                DataHeaders.Rows.Add(cchildRow);

            }
        }
    }
    public string SetExpDateIn(string input)
    {
        if (DateTime.Parse(input) <= DateTime.Parse("01/01/1901"))
        {
            return "--";
        }
        else
        {
            return input;
        }
    }
}
