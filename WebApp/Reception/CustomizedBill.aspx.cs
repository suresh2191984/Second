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

public partial class Reception_CustomizedBill : BasePage
{
    string pBillID;
    int pOrgID;
    decimal pPreviousDue = 0;
    string pDrName = string.Empty;
    string pHospitalName = string.Empty;
    string pCCName = string.Empty;
    string pPatientName = string.Empty;
    string PrintString = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pBillID=Request.QueryString["billNo"].ToString();
            if (!IsPostBack)
            {
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void LoadBillDetails()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<BillMaster> billMaster = new List<BillMaster>();
            List<BillLineItems> billLineItems = new List<BillLineItems>();
            List<PatientVisit> labVisitDetails = new List<PatientVisit>();
            string pAge = string.Empty;
            string pSex = string.Empty;
            retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out labVisitDetails);
            BillNo.Text = pBillID.ToString();
            VisitNo.Text = billMaster[0].VisitID.ToString();
            BillDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
            PatientName.Text = labVisitDetails[0].PatientName + " " + labVisitDetails[0].PatientAge + " " + labVisitDetails[0].Sex;
            DrName.Text = labVisitDetails[0].ReferingPhysicianName;
   
            if (labVisitDetails[0].CollectionCentreName != null)
            {
                trCC.Style.Add("Display", "block");
                CollectionCentre.Text = labVisitDetails[0].CollectionCentreName;
            }
            //ltSignature.Text = "<b>Authorised Signature(for " + OrgName + ")</b>";
            if (billMaster[0].IsCredit == "Y")
            {
                lblBillType.Text = "Credit Bill";
            }
            if (billMaster[0].Status != null)
            {
                if (billMaster[0].Status.Trim() == "C")
                {
                    //    referenceIndicator.Style.Add("display", "block");
                    //    litReferenceIndicator.Text = billMaster[0].Comments;
                    lblBillType.Text = "Cancelled Bill";
                }
            }

            if (billLineItems.Count > 0)
            {
                //dtBillitems.DataSource = billLineItems;
                //dtBillitems.DataBind();
            }
           
            Table tableParent = new Table();
            TableRow trParent = new TableRow();
            TableCell tcParent = new TableCell();
            Table tableChild = new Table();
            tableParent.Width = Unit.Pixel(720);
            //tableParent.BorderStyle = BorderStyle.Dashed;
            //tableParent.BorderWidth = Unit.Pixel(2);
            tableParent.Width = Unit.Percentage(100.00);
            tcParent.Width = Unit.Percentage(50.00);
            //table.BorderStyle = BorderStyle.Dashed;
            //tableChild.BorderWidth = Unit.Pixel(3);
            tableChild.Width = Unit.Percentage(100.00);
            int i = 0;
            foreach (var item in billLineItems)
            {
                TableRow chdTblRow = new TableRow();
                TableCell ChTblCellItemName = new TableCell();
                TableCell ChTblCellItemRate = new TableCell();
                TableCell ChTblCellEmpty = new TableCell();
                TableCell ChTblCell4 = new TableCell();
                TableCell ChTblCell5 = new TableCell();
                //ChTblCellItemName.BorderWidth = Unit.Pixel(1);
                //ChTblCellItemRate.BorderWidth = Unit.Pixel(1);
                //ChTblCellEmpty.BorderWidth = Unit.Pixel(1);
                //ChTblCell4.BorderWidth = Unit.Pixel(1);
                //ChTblCell5.BorderWidth = Unit.Pixel(1);

                ChTblCellItemName.Width = Unit.Percentage(25);
                ChTblCellItemName.Attributes.Add("valign", "top");
                ChTblCellItemRate.Width = Unit.Percentage(18.84);
                ChTblCellEmpty.Width = Unit.Percentage(11.46);
                ChTblCell4.Width = Unit.Percentage(26.72);
                ChTblCell5.Width = Unit.Percentage(18.4);
                ChTblCellItemName.Attributes.Add("align", "left");
                
                ChTblCellItemRate.Attributes.Add("align", "right");

                ChTblCell5.Attributes.Add("align", "right");
                //width="22%" valign=top style='width:22.9%;padding:.75pt .75pt .75pt .75pt'

                if (tableChild.Rows.Count >=9)
                {
                 
                    //tcParent = new TableCell();
                    //tcParent.Width = Unit.Percentage(50.00);
                    //tableChild = new Table();
                    //tableChild.Width = Unit.Percentage(100.00);
                    //chdTblRow = new TableRow();
                    

                    tableChild.Rows[i].Cells[3].Text = item.ItemName.ToString().ToLower();
                    tableChild.Rows[i].Cells[4].Text = item.Amount.ToString();
                    //ChTblCell4.Text = 
                    //ChTblCell5.Text = item.Amount.ToString();
                    //ChTblCellEmpty.Text = "&nbsp";
                    //chdTblRow.Cells.Add(ChTblCell4);
                    //chdTblRow.Cells.Add(ChTblCell5);
                   // chdTblRow.Cells.Add(ChTblCellEmpty);
                    i = i + 1;

                }
                if (tableChild.Rows.Count <=8)
                {
                    ChTblCellItemName.Text = item.ItemName.ToString().ToLower();
                    ChTblCellItemRate.Text = item.Amount.ToString();
                    ChTblCellEmpty.Text = "&nbsp";
                    chdTblRow.Cells.Add(ChTblCellItemName);
                    chdTblRow.Cells.Add(ChTblCellItemRate);
                    chdTblRow.Cells.Add(ChTblCellEmpty);
                    chdTblRow.Cells.Add(ChTblCell4);
                    chdTblRow.Cells.Add(ChTblCell5);
                    
                }
                tableChild.Rows.Add(chdTblRow);
                tcParent.Controls.Add(tableChild);
                trParent.Cells.Add(tcParent);
                tableParent.Rows.Add(trParent);
             
            }
            //if (billLineItems.Count <= 8)
            //{
            //    tcParent = new TableCell();
            //    tcParent.Width = Unit.Percentage(50.00);
            //    tableChild = new Table();
            //    tableChild.Width = Unit.Percentage(100.00);
            //    TableRow chdTblRow = new TableRow();
            //    TableCell ChTblCellItemRate = new TableCell();
            //    ChTblCellItemRate.Text = "&nbsp;";
            //    chdTblRow.Cells.Add(ChTblCellItemRate);
            //    tableChild.Rows.Add(chdTblRow);
            //    tcParent.Controls.Add(tableChild);
            //    trParent.Cells.Add(tcParent);
            //    tableParent.Rows.Add(trParent);
            //}
            pnlTst.Controls.Add(tableParent);

            lblTot.Text = billMaster[0].NetAmount.ToString();
            lblPaidAmt.Text = billMaster[0].AmountReceived.ToString();
            lblDueAmt.Text = billMaster[0].AmountDue.ToString();
            if (billMaster[0].Comments != "")
            {
                //referenceIndicator.Style.Add("display", "block");
                //litReferenceIndicator.Text = billMaster[0].Comments;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
  
}
