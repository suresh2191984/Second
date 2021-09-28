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
using System.Text;
using System.Collections.Specialized;
using Attune.Utilitie.Helper;

public partial class Corporate_PrintBill : BasePage
{
    long visitID = -1;
    string pageid = string.Empty;
    long returncode = -1;
    string pagename = string.Empty;
    long patientID = -1;
    long dup = 0;
    string Billtype = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["dup"], out dup);
                Billtype = Request.QueryString["Billtype"];

                long FinalBillID = 0;
                Int64.TryParse(Request.QueryString["bid"], out FinalBillID);



                BillPrinting(visitID, FinalBillID);
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("Print_Align", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    //divLaser.Style.Add("text-align", lstInventoryConfig[0].ConfigValue);

                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in GracePrintBill.aspx", ex);
            }
        }
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
    public void BillPrinting(long visitID, long FinalbillID)
    {
        try
        {
            int intLines = 13;
            int intLimit = 0;
            int intCnt = 0;
            string strwords1 = string.Empty;
            string strwords2 = string.Empty;
            string physicianName = string.Empty;
            string PrescriptionNo = string.Empty;
            string Sex = string.Empty;
            string Stingheader = string.Empty;
            string VDate = string.Empty;
            string IssuedBy = string.Empty;
            string discountpercent = string.Empty;
            string licenceNo = string.Empty;
            string Dlno = string.Empty;
            string tinNo = string.Empty;
            string appString = string.Empty;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            //inventoryBL.GetInvBillPrintingDetails(visitID, out lstBillingDetail,
            //                                out lstFinalBillDetail, out lstPatientDetails,
            //                                out lstOrganization, out physicianName,
            //                                out lstDuePaidDetails, FinalbillID);
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            List<Users> lstUsers = new List<Users>();
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);

            //List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig1);

            StringBuilder objprint = new StringBuilder();
            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue >= 0)
            {
                #region header
                physicianName = physicianName == null ? "" : physicianName.ToString();
                PrescriptionNo = lstBillingDetail[0].ServiceCode.Split('~')[3].ToString();
                IssuedBy = lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name;
                if (lstPatientDetails[0].SEX == "M")
                {
                    Sex = "Male";
                }
                else
                {
                    Sex = "Female";
                }
                VDate = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                PrinterHelper.PrintStartAndEnd(ref objprint, "S");
                Stingheader = "<table width=100% border=0 cellspacing=0 cellpading=0 style='font-family: Verdana; font-size: 11px;'>"
                                + "<tr>"
                                + "<td width='8%' align='Left'>" + "Name" + "</td>"
                                + "<td width='25%' align='Left'>" + ":" + lstPatientDetails[0].Name + "</td>"
                                + "<td width='15%' align='Left'>" + "Number" + "</td>"
                                + "<td width='20%' align='Left'>" + ":" + lstPatientDetails[0].PatientNumber + "</td>"
                                + "<td width='13%' align='Left'>" + "Doctor Name" + "</td>"
                                + "<td width='17%' align='Left'>" + ":" + physicianName + "</td>"
                                + "</tr>"
                                + "<tr>"
                                + "<td width='8%' align='Left'>" + "Gender" + "</td>"
                                + "<td width='25%' align='Left'>" + ":" + Sex + "</td>"
                                + "<td width='15%' align='Left'>" + "Prescription No" + "</td>"
                                + "<td width='20%' align='Left'>" + ":" + PrescriptionNo + "</td>"
                                + "<td width='13%' align='Left'>" + "Issued By" + "</td>"
                                + "<td width='17%' align='Left'>" + ":" + IssuedBy + "</td>"
                                + "</tr>"
                                + "<tr>"
                                + "<td width='8%' align='Left'>" + "Age" + "</td>"
                                + "<td width='25%' align='Left'>" + ":" + lstPatientDetails[0].Age + "</td>"
                                + "<td width='15%' align='Left'>" + "Prescription Date" + "</td>"
                                + "<td width='20%' align='Left'>" + ":" + VDate + "</td>"
                                + "<td width='13%' align='Left'>" + "" + "</td>"
                                + "<td width='17%' align='Left'>" + "" + "</td>"
                                + "</tr>"
                                + "</table>"
                                + "<table width=100% border=1 cellspacing=0 cellpading=0 style='font-family: Verdana; font-size: 11px;'>"
                                + "<tr>"
                                + "<td width='5%' align='Left'>" + "S.No" + "</td>"
                                + "<td width='30%' align='Left'>" + "Particulars" + "</td>"
                                + "<td width='10%' align='Left'>" + "Frequency" + "</td>"
                                + "<td width='10%' align='Left'>" + "Duration" + "</td>"
                                + "<td width='10%' align='Left'>" + "Issued Qty" + "</td>"
                                + "<td width='20%' align='Left'>" + "Direction" + "</td>"
                                + "<td width='15%' align='Left'>" + "Instruction" + "</td>"
                                + "</tr>"
                                + "</table>";
                objprint.Append(Stingheader);
                #endregion
                if (lstBillingDetail.Count > 0)
                {
                    #region Content
                    foreach (BillingDetails objBD in lstBillingDetail)
                    {
                        intCnt = intCnt + 1;
                        intLimit = intCnt;
                        if (intLimit > intLines)
                        {
                            if (intLines + 1 == intLimit)
                            {
                                objprint.Append(Stingheader);
                            }
                            string[] strValue = objBD.ServiceCode.Split('~');
                            objprint.Append("<table width=100% border=0 cellspacing=0 cellpading=0 style='font-family: Verdana; font-size: 11px;'>"
                                   + "<tr>"
                                   + "<td width='5%' align='Left'>" + intCnt.ToString() + "</td>"
                                   + "<td width='30%' align='Left'>" + objBD.FeeDescription + "</td>"
                                   + "<td width='10%' align='Left'>" + strValue[1].ToString() + "</td>"
                                   + "<td width='10%' align='Left'>" + strValue[2].ToString() + "</td>"
                                   + "<td width='10%' align='Left'>" + objBD.Quantity.ToString() + "</td>"
                                   + "<td width='20%' align='Left'>" + strValue[5].ToString() + "</td>"
                                   + "<td width='15%' align='Left'>" + strValue[4].ToString() + "</td>"
                                   + "</tr>"
                                   );
                            intLimit = intLimit + 1;
                        }
                        else
                        {
                            string[] strValue = objBD.ServiceCode.Split('~');
                            objprint.Append("<table width=100% border=0 cellspacing=0 cellpading=0 style='font-family: Verdana; font-size: 11px;'>"
                                   + "<tr>"
                                   + "<td width='5%' align='Left'>" + intCnt.ToString() + "</td>"
                                   + "<td width='30%' align='Left'>" + objBD.FeeDescription + "</td>"
                                   + "<td width='10%' align='Left'>" + strValue[1].ToString() + "</td>"
                                   + "<td width='10%' align='Left'>" + strValue[2].ToString() + "</td>"
                                   + "<td width='10%' align='Left'>" + objBD.Quantity.ToString() + "</td>"
                                   + "<td width='20%' align='Left'>" + strValue[5].ToString() + "</td>"
                                   + "<td width='15%' align='Left'>" + strValue[4].ToString() + "</td>"
                                   + "</tr>"
                                   );
                            if (intLimit == intLines)
                            {
                                objprint.Append("</table><p style=\"page-break-before:always\"></p>");
                            }
                        }
                    }
                    //objprint.Append("</table><p style=\"page-break-before:always\"></p>");  
                }
                    #endregion
            }
            PrinterHelper.PrintStartAndEnd(ref objprint, "E");
            tdPrints.InnerHtml = objprint.ToString();
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