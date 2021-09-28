using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using NumberToWord;


public partial class CommonControls_EsInvIntrimBill : BaseControl
{
     long patientID = 0;
                long visitID = 0;
                string LabNo = string.Empty;
                string InterimBillNo = string.Empty;
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                string PharmacyBillNoConfig = string.Empty;
                string PharmacyBillNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {

                Int64.TryParse(Request.QueryString["PID"], out patientID);
                Int64.TryParse(Request.QueryString["VID"], out visitID);
                InterimBillNo=Request.QueryString["ReferenceID"];
                LabNo=Request.QueryString["LabNo"].ToString();

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in GracePrintBill.aspx", ex);
            }
        }
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string strwords1 = string.Empty;
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
    public void SetBillDetails()
    {
        try
        {
            string strwords1 = string.Empty;
            string strwords2 = string.Empty;
            string physicianName = string.Empty;
            string discountpercent = string.Empty;
            string licenceNo = string.Empty;
            string Dlno = string.Empty;
            string tinNo = string.Empty;
            string appString = string.Empty;
            long returncode = -1;

            Int64.TryParse(Request.QueryString["PID"], out patientID);
            Int64.TryParse(Request.QueryString["VID"], out visitID);
            InterimBillNo=Request.QueryString["ReferenceID"];
            if (Request.QueryString["LabNo"] != null)
                LabNo = Request.QueryString["LabNo"];


            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            List<Patient> lstPatient = new List<Patient>();
            List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            new PatientVisit_BL(base.ContextInfo).GetInterimDueChart(out lstDueChart, out lstPatient, OrgID, patientID, visitID, InterimBillNo,"N");
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            List<Users> lstUsers = new List<Users>();
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID,ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                orgDLNoLaser.Text = "D.L.No: " + lstInventoryConfig[0].ConfigValue.ToUpper();
                Dlno = lstInventoryConfig[0].ConfigValue.ToUpper();
                trorgDLNoLaser.Style.Add("display", "block");
            }

            List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID,ILocationID, out lstInventoryConfig1);
            if (lstInventoryConfig1.Count > 0)
            {
                orgTinNoLaser.Text = "TIN No: " + lstInventoryConfig1[0].ConfigValue.ToUpper();
                trorgTinNoLaser.Style.Add("display", "block");
            }

            new GateWay(base.ContextInfo).GetInventoryConfigDetails("Show_Pharmacy_BillNo_EachReceipt_And_InterimBill", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                PharmacyBillNoConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            if (PharmacyBillNoConfig == "Y")
            {


                if (lstDueChart.Count > 0)
                {
                    PharmacyBillNo = lstDueChart[0].ReferenceType;
                    //lblPharmacybillNovalue.Text = PharmacyBillNo;
                    //lblPharmacybillNovalue.Visible = true;
                    //lblPharmacyBillNo.Visible = true;

                }

            }
            else
            {
                //lblPharmacyBillNo.Visible = false;
                //lblPharmacybillNovalue.Visible = false;
                PharmacyBillNo = "";
            }
            if (lstDueChart.Count > 0)
            {
                string RoundofQty = GetConfigValue("PharmaBillPrint", OrgID);
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (lstDueChart.Count > 0)
                {
                    int i = 0;
                    TableRow headLine1Row = new TableRow();
                    TableCell headLineCell1 = new TableCell();
                    headLineCell1.ColumnSpan = 7;
                    headLineCell1.Text = "&nbsp;";
                    headLine1Row.Cells.Add(headLineCell1);
                    TableRow headRow = new TableRow();
                    TableCell headCell1 = new TableCell();
                    TableCell headCell2 = new TableCell();
                    TableCell headCell3 = new TableCell();
                    //TableCell headCell4 = new TableCell();
                    //TableCell headCell5 = new TableCell();
                    TableCell headCell6 = new TableCell();
                    TableCell headCell7 = new TableCell();
                    headCell1.BorderWidth = 1;
                    headCell2.BorderWidth = 1;
                    headCell3.BorderWidth = 1;
                    //headCell4.BorderWidth = 1;
                    //headCell5.BorderWidth = 1;
                    headCell6.BorderWidth = 1;
                    headCell7.BorderWidth = 1;

                    headCell1.Attributes.Add("align", "center");
                    headCell1.Text = "S.No";
                    headCell1.Width = Unit.Percentage(5);
                    headCell2.Attributes.Add("align", "center");
                    headCell2.Text = "Particulars";
                    headCell3.Attributes.Add("align", "center");
                    headCell3.Text = "Quantity";
                    headCell3.Width = Unit.Percentage(10);
                    //headCell4.Attributes.Add("align", "center");
                    //headCell4.Text = "Batch";
                    //headCell4.Width = Unit.Percentage(10);
                    //headCell5.Attributes.Add("align", "center");
                    //headCell5.Text = "Exp.Date";
                    //headCell5.Width = Unit.Percentage(10);
                    headCell6.Attributes.Add("align", "center");
                    headCell6.Text = "Rate";
                    headCell6.Width = Unit.Percentage(5);

                    headCell7.Attributes.Add("align", "center");
                    headCell7.Text = "Amount";
                    headCell7.Width = Unit.Percentage(5);

                    headCell6.Width = Unit.Percentage(10);
                    headRow.Cells.Add(headCell1);
                    headRow.Cells.Add(headCell2);
                    headRow.Cells.Add(headCell3);
                    //headRow.Cells.Add(headCell4);
                    //headRow.Cells.Add(headCell5);
                    headRow.Cells.Add(headCell6);
                    headRow.Cells.Add(headCell7);
                    billDetailLaser.Rows.Add(headRow);
                    TableRow headLine2Row = new TableRow();
                    TableCell headLineCell2 = new TableCell();
                    headLineCell2.ColumnSpan = 6;
                    headLineCell2.Text = "<hr/>";
                    headLine2Row.Cells.Add(headLineCell2);
                    //billDetailLaser.Rows.Add(headLine2Row);
                    foreach (PatientDueChart objBD in lstDueChart)
                    {
                        i += 1;
                        TableRow contentRow = new TableRow();
                        TableCell contentCell1 = new TableCell();
                        TableCell contentCell2 = new TableCell();
                        TableCell contentCell3 = new TableCell();
                        //TableCell contentCell4 = new TableCell();
                        //TableCell contentCell5 = new TableCell();
                        TableCell contentCell6 = new TableCell();
                        TableCell contentCell7 = new TableCell();
                        contentCell1.BorderWidth = 0;
                        contentCell2.BorderWidth = 0;
                        contentCell3.BorderWidth = 0;
                        //contentCell4.BorderWidth = 0;
                        //contentCell5.BorderWidth = 0;
                        contentCell6.BorderWidth = 0;
                        contentCell7.BorderWidth = 0;

                        contentCell1.Attributes.Add("align", "left");
                        contentCell1.Text = i.ToString();
                        contentCell1.Style.Add("padding-right", "0px");
                        contentCell1.Width = Unit.Percentage(5);
                        contentCell2.Attributes.Add("align", "left");
                        contentCell2.Style.Add("padding-left", "15px");
                        contentCell2.Text = objBD.Description;
                        //contentCell2.Width = 50;
                        contentCell3.Attributes.Add("align", "center");
                        if (RoundofQty == "NMCPharmaBillPrint")
                        {
                            contentCell3.Text = Convert.ToInt32(objBD.Unit).ToString();
                        }
                        else
                        {
                            contentCell3.Text = objBD.Unit.ToString();
                        }
                        contentCell3.Width = Unit.Percentage(10);
                        //contentCell4.Attributes.Add("align", "left");
                        //contentCell4.Text = objBD.BatchNo;
                        //contentCell4.Width = Unit.Percentage(10);
                        //contentCell5.Attributes.Add("align", "left");
                        //if (objBD.ExpiryDate <= DateTime.Parse("01/01/1901"))
                        //{
                        //    contentCell5.Text = "--";
                        //}
                        //else
                        //{
                        //    contentCell5.Text = objBD.ExpiryDate.ToString("MMM-yyyy");
                        //}
                        ////contentCell5.Style.Add("padding-right", "0px");
                        //contentCell5.Width = Unit.Percentage(15);
                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Style.Add("padding-left", "15px");
                        contentCell6.Text = objBD.Amount.ToString();
                        contentCell6.Width = Unit.Percentage(10);

                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Style.Add("padding-left", "15px");
                        contentCell6.Text = objBD.Amount.ToString();
                        contentCell6.Width = Unit.Percentage(10);

                        contentCell7.Attributes.Add("align", "left");
                        contentCell7.Text = (objBD.Amount*objBD.Unit).ToString("0.00");
                        contentCell7.Width = Unit.Percentage(5);

                        contentRow.Cells.Add(contentCell1);
                        contentRow.Cells.Add(contentCell2);
                        contentRow.Cells.Add(contentCell3);
                        //contentRow.Cells.Add(contentCell4);
                        //contentRow.Cells.Add(contentCell5);
                        contentRow.Cells.Add(contentCell6);
                        contentRow.Cells.Add(contentCell7);
                        billDetailLaser.Rows.Add(contentRow);
                    }
                    TableRow headLine3Row = new TableRow();
                    TableCell headLineCell3 = new TableCell();
                    headLineCell3.ColumnSpan = 7;
                    headLineCell3.Text = "&nbsp;";
                    headLine3Row.Cells.Add(headLineCell3);
                    billDetailLaser.Rows.Add(headLine3Row);

                    TableRow headLine4Row = new TableRow();
                    TableCell headLineCell4 = new TableCell();
                    headLineCell4.ColumnSpan = 7;
                    headLineCell4.Text = "&nbsp;";
                    headLine4Row.Cells.Add(headLineCell4);
                    //billDetailLaser.Rows.Add(headLine4Row);

                    TableRow netTotalRow = new TableRow();
                    TableCell netTotalCell1 = new TableCell();
                    netTotalCell1.ColumnSpan = 4;
                    netTotalCell1.Attributes.Add("align", "right");
                    netTotalCell1.Style.Add("padding-right", "30px");
                    netTotalCell1.Text = "Total: ";
                    netTotalCell1.Font.Bold = true;
                    TableCell netTotalCell2 = new TableCell();
                    netTotalCell2.Attributes.Add("align", "right");
                    netTotalCell2.Style.Add("padding-left", "15px");
                    decimal Total = 0;
                    for(i=0;i<lstDueChart.Count();i++)
                    {
                        Total += lstDueChart[i].Amount * lstDueChart[i].Unit;
                    }
                    netTotalCell2.Text = Total.ToString("0.00");
                    netTotalCell2.Font.Bold = true;
                    netTotalRow.Cells.Add(netTotalCell1);
                    netTotalRow.Cells.Add(netTotalCell2);
                    billDetailLaser.Rows.Add(netTotalRow);

                    strwords1 = "Amount in Words: (" + CurrencyName + ") " + Utilities.FormatNumber2Word(num.Convert(Total.ToString())) + " " + MinorCurrencyName + " Only...";

                    TableRow headLine5Row = new TableRow();
                    TableCell headLineCell5 = new TableCell();
                    headLineCell5.ColumnSpan = 7;
                    headLineCell5.Style.Add("padding-left", "5px");
                    headLineCell5.Text = "<b>" + strwords1 + "</b>";
                    headLine5Row.Cells.Add(headLineCell5);
                    billDetailLaser.Rows.Add(headLine5Row);
                    
                    returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID,ILocationID, out lstInventoryConfig);
                    string RedirectPage = GetConfigValue("KmhPharmaBillPrint", OrgID);
                    if (RedirectPage != "KMHPharmacy")
                    {
                        RedirectPage = GetConfigValue("PharmaBillPrint", OrgID);
                        if (RedirectPage == "NMCPharmaBillPrint")
                        {
                            if (lstInventoryConfig.Count > 0)
                            {
                                orgHeadLaser.Text = lstInventoryConfig[0].ConfigValue;
                            }
                            returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyAddress", OrgID,ILocationID, out lstInventoryConfig);
                            if (lstInventoryConfig.Count > 0)
                            {
                                orgAddressLaser.Style.Add("Font-Size", "12px");
                                orgAddressLaser.Text = lstInventoryConfig[0].ConfigValue;
                            }
                        }
                        else
                        {
                            orgAddressLaser.Text = GetConfigValue("EsIpPharAddress", OrgID);
                        }
                    }
                    patientNameLaser.Text = "Patient Name: " + lstPatient[0].Name + "<br/>" + lstPatient[0].Name;
                    PatientAgeLaser.Text = "Patient Age: " + lstPatient[0].Age + "<br/>" + lstPatient[0].Comments;
                    if (lstDueChart[0].RefPhyName != "")
                    {
                        drNameLaser.Text = "Prescribed By:" + lstDueChart[0].RefPhyName;
                        physicianName = lstDueChart[0].RefPhyName;
                    }
                    if (lstPatient.Count > 0)
                    {
                        if (lstPatient[0].PatientNumber != "")
                        {
                            if (lstPatient[0].Name != null)
                            {
                                PatientNoLaser.Text = "Patient Number: " + lstPatient[0].PatientNumber + "<br/>";
                                patientNameLaser.Text = "Patient Name: " + lstPatient[0].Name + "<br/>";
                                PatientAgeLaser.Text = "Patient Age: " + lstPatient[0].Age + "<br/>";
                            }
                            else
                            {
                                PatientNoLaser.Text = "Patient Number: " + lstPatient[0].PatientNumber + "<br/>";
                                patientNameLaser.Text = "Patient Name: " + lstPatient[0].Name + "<br/>" + "Patient Number: " + lstPatient[0].PatientNumber + "<br/>" + lstPatient[0].Comments;
                            }
                        }
                        else
                        {
                            PatientNoLaser.Text = "Patient Number: " + lstPatient[0].PatientNumber + "<br/>";
                            patientNameLaser.Text = "Patient Name: " + lstPatient[0].Name + "<br/>" + lstPatient[0].Comments;
                        }
                    }

                    tdSoldByLaser.Text = "RAISED BY: " + lstDueChart[0].BilledBy;
                    billNoLaser.Text = "ReceiptNo: " + lstDueChart[0].InterimBillNo.ToString();
                    billDateLaser.Text = "Raised Date: " + lstDueChart[0].FromDate.ToString("dd/MM/yyyy hh:mm tt");
                   
                    amountInWordsLaser.Text = Total.ToString();
                    returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("Bill_Policy", OrgID,ILocationID, out lstInventoryConfig);
                    if (lstInventoryConfig.Count > 0)
                    {
                        tdBillPolicy.Text = lstInventoryConfig[0].ConfigValue;
                    }
                    returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyFooter", OrgID,ILocationID, out lstInventoryConfig);
                    if (lstInventoryConfig.Count > 0)
                    {
                        tblFottor.Text = lstInventoryConfig[0].ConfigValue;
                    }


                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            long returncode = -1;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
