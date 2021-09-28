using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_IPBulkBill : BaseControl 
{
    IP_BL objIPBulkBill;
     List<IPBulkBill> lstIPBulkBill = new List<IPBulkBill>();
     List<IPBulkBill> lstIPBulkBill1 = new List<IPBulkBill>();
     List<IPBulkBill> lstIPNonBill = new List<IPBulkBill>();
     List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
     List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
     List<PatientDueChart> lstNonMedicalItems = new List<PatientDueChart>();
     List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
     List<Config> lstConfig;
     decimal dDue = 0;
     long VisitID = 0;
     decimal Copercent = -1;
     decimal pPreAuthAmount = 0;
     decimal PaidAmount = 0;
     decimal GrossBillAmount = 0;
     string IsCreditBill = string.Empty;
     decimal DueAmount = 0;
     decimal dPayerTotal = 0;
     decimal dGrossAmount = 0;
     decimal dServiceCharge = 0;
     decimal dTax = 0;
     decimal dPrevAmountPaid = 0;
     decimal dPrevDue = 0;
     decimal dRoundoff = 0;

     public event EventHandler onSearchComplete;
     private long lngrateId;
     public long lngRateId
     {
         get { return lngrateId; }
         set { lngrateId = value; }
     }
     private bool gvPRMVis;

     public  bool gvPRMVisible
     {
         get { return gvPRMVis; }
         set
         {
             gvPRMVis=value;
             if (gvPRMVis == true)
             {
                 trPha.Visible = true;
                 trPRM.Visible = true;
                 tdPha.Style.Add("text-align", "left");
                 lblPhr.Text = "Pharmacy Breakup Charges - ";

             }
             else
             {
                 trPha.Visible = false;
                 trPRM.Visible = false;
                 tdPha.Style.Add("text-align", "right");
                 lblPhr.Text = "Pharmacy Charges -         ";
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
     protected string NumberConvert(object a, object b)
     {
         decimal c = 0;
         c = (decimal)a * (decimal)b;
         return c.ToString("0.00");
     }
     protected void gvIndentRoomDetails_RowDataBound(object sender, GridViewRowEventArgs e)
     {
         e.Row.Cells[1].Visible = false;
         e.Row.Cells[2].Visible = false;
         e.Row.Cells[3].Visible = false;

         e.Row.Cells[4].Visible = true;
         e.Row.Cells[9].Visible = false;
         if (e.Row.Cells[9].Text == "Pending")
         {
             e.Row.BackColor = System.Drawing.Color.Gray;
         }
         e.Row.Cells[10].Visible = false;
     }
     protected void gvIndentRoomType_RowDataBound(Object sender, GridViewRowEventArgs e)
     {
         try
         {
             if (e.Row.RowType == DataControlRowType.DataRow)
             {
                 Label lblFeeTypeDetails = (Label)e.Row.FindControl("lblFeeTypeDetails");

                 PatientDueChart BMaster = (PatientDueChart)e.Row.DataItem;

                 var childItems = from child in lstBedBooking
                                  where child.RoomTypeName == BMaster.RoomTypeName && child.IsReimbursable != "N"
                                  select child;

                 lstNonMedicalItems.AddRange((from child in lstBedBooking
                                              where child.RoomTypeName == BMaster.RoomTypeName && child.IsReimbursable == "N"
                                              select child).ToList());

                 GridView childGrid = (GridView)e.Row.FindControl("gvIndentRoomDetails");
                 if (childItems.Count() > 0)
                 {
                     childGrid.DataSource = childItems;
                     childGrid.DataBind();
                     childGrid.Visible = true;
                 }
                 else
                 {
                     childGrid.Visible = false;
                 }

                 List<PatientDueChart> lstchilddues = new List<PatientDueChart>();
                 lstchilddues = (List<PatientDueChart>)childItems.ToList();
                 var sumAmount = (from lstdues in lstchilddues
                                  select (lstdues.Amount * lstdues.Unit)).Sum();


                 if (sumAmount != decimal.Zero)
                 {
                     lblFeeTypeDetails.Visible = true;
                 }
                 else
                 {
                     lblFeeTypeDetails.Visible = false;
                 }

                 decimal dtotalAmount = 0;


                 foreach (GridViewRow row1 in childGrid.Rows)
                 {
                     Label txtUnitPrice = new Label();
                     Label txtAmount = new Label();
                     txtAmount = (Label)row1.FindControl("txtAmount");
                     dtotalAmount += Convert.ToDecimal(txtAmount.Text);
                     if (txtUnitPrice.Text == "0.00")
                     {
                         row1.BackColor = System.Drawing.Color.Gray;
                     }
                 }
             }
         }
         catch (Exception ex)
         {
             CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
         }
     }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        string IsReim = "";
            if (Request.QueryString["VID"] != null)
            {
                VisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }
            if (!Page.IsPostBack)
            {
                LoadDet(IsReim);
            }

    }
    protected string CheckNull(object objGrid) 
    { 
        if (object.ReferenceEquals(objGrid, "")) 
        { 
            return "***"; 
        } 
        else 
        { 
            return objGrid.ToString(); 
        } 
     }

    public void LoadDet(string strFlag)
    {
        long returnCode = 0;
        long VisitID = -1;
        long PatientID = -1;
        decimal pCoPayment = decimal.Zero;
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        if (Request.QueryString["VID"] != null)
        {
            VisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            PatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        decimal GrandTotal = -1;
        DateTime dtToday = Convert.ToDateTime(DateTime.Today);
        objIPBulkBill = new IP_BL(base.ContextInfo);
        returnCode = objIPBulkBill.GetIPBulkBill(VisitID, PatientID, OrgID, out GrandTotal, out lstBedBooking, out lstIPBulkBill, out lstIPBulkBill1);
        if (lstIPBulkBill.Count > 0)
        {
            var list = (from list1 in lstIPBulkBill
                        where (list1.FeeType == "ROM")
                        select list1.FeeType).Distinct();
            if (list.Count() == 0)
            {
                if (lstBedBooking.Count > 0)
                {

                    //var list = (from list1 in lstBedBooking
                    //            select list1.RoomTypeName).Distinct();

                    IEnumerable<PatientDueChart> pdcs = (from s in lstBedBooking
                                                         group s by new { s.FeeID, s.RoomTypeName, s.CreatedAt, s.Unit, s.FromDate, s.ToDate } into g
                                                         select new PatientDueChart
                                                         {
                                                             FeeID = g.Key.FeeID,
                                                             Unit = g.Key.Unit,
                                                             FromDate = g.Key.FromDate,
                                                             ToDate = g.Key.ToDate,
                                                             CreatedAt = g.Key.CreatedAt,
                                                             RoomTypeName = g.Key.RoomTypeName,
                                                             Amount = g.Sum(i => i.Amount)

                                                         }
                                                          ).Distinct().ToList();



                    //foreach (var obj in list)
                    //{
                    //    PatientDueChart pdc = new PatientDueChart();
                    //    pdc.RoomTypeName = obj;
                    //    lstBedBookingRoomType.Add(pdc);
                    //}

                    gvIndentRoomDetails.DataSource = pdcs;
                    gvIndentRoomDetails.DataBind();
                    gvIndentRoomDetails.Visible = true;
                    lblRoomHeader.Visible = true;

                }
            }

            string strConfigval = GetConfigValue("Port Trust", OrgID);
            #region Investigation
            List<IPBulkBill> lstChart = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstChart = (from listInv in lstIPBulkBill
                            orderby listInv.FeeType ascending
                            where (listInv.FeeType == "INV" || listInv.FeeType == "LAB") && listInv.IsReimbursable == strFlag
                            select listInv).Distinct().ToList();
            }
            else
            {
                lstChart = (from listInv in lstIPBulkBill
                            where listInv.FeeType == "INV" || listInv.FeeType == "LAB"
                            orderby listInv.FeeType ascending
                            select listInv).Distinct().ToList();
            }

            if (lstChart.Count() > 0)
            {
                gvInv.DataSource = lstChart;
                gvInv.DataBind();
                gvInv.Visible = true;
                dvInv.Style.Add("display", "block");
                trInv.Style.Add("Display", "block");
            }
            else
            {
                trInv.Style.Add("Display", "none");
                dvInv.Style.Add("display", "none");
                gvInv.Visible = false;
            }
            #endregion

            #region Consultation
            List<IPBulkBill> lstCons = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstCons = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "CON" && listInv.IsReimbursable == strFlag
                            orderby listInv.FeeType ascending
                            select listInv).Distinct().ToList();
            }
            else
            {
                lstCons = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "CON"
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }

            if (lstCons.Count() > 0)
            {
                gvCon.DataSource = lstCons;
                gvCon.DataBind();
                gvCon.Visible = true;
                dvCon.Style.Add("display", "block");
                trCon.Style.Add("Display", "block");
            }
            else
            {
                trCon.Style.Add("Display", "none");
                dvCon.Style.Add("display", "none");
                gvCon.Visible = false;
            }
            #endregion

            #region Procedure

            List<IPBulkBill> lstpro = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstpro = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "PRO" && listInv.IsReimbursable == strFlag
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }
            else
            {
                lstpro = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "PRO"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }

            

            if (lstpro.Count() > 0)
            {
                gvPRO.DataSource = lstpro;
                gvPRO.DataBind();
                gvPRO.Visible = true;
                dvPRO.Style.Add("display", "block");
                trPRO.Style.Add("Display", "block");
            }
            else
            {
                trPRO.Style.Add("Display", "none");
                dvPRO.Style.Add("display", "none");
                gvPRO.Visible = false;
            }
            #endregion

            #region Group Inv's
            List<IPBulkBill> lstgrp = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstgrp = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "GRP" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();

                    
            }
            else
            {
                lstgrp = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "GRP" 
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstgrp.Count() > 0)
            {
                gvGRP.DataSource = lstgrp;
                gvGRP.DataBind();
                gvGRP.Visible = true;
                dvGRP.Style.Add("display", "block");
                trGRP.Style.Add("Display", "block");
            }
            else
            {
                trGRP.Style.Add("Display", "none");
                dvGRP.Style.Add("display", "none");
                gvGRP.Visible = false;
            }

            #endregion

            #region General Bill Items
            List<IPBulkBill> lstgen = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstgen = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "GEN" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();

            }
            else
            {
                lstgen = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "GEN"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();

            }

            if (lstgen.Count() > 0)
            {
                gvGEN.DataSource = lstgen;
                gvGEN.DataBind();
                gvGEN.Visible = true;
                dvGEN.Style.Add("display", "block");
                trGEN.Style.Add("Display", "block");

            }
            else
            {
                trGEN.Style.Add("Display", "none");
                dvGEN.Style.Add("display", "none");
                gvGEN.Visible = false;
            }
            #endregion

            #region Pharmacy
            List<IPBulkBill> lstprm = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstprm = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "PRM" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();

            }
            else
            {
                lstprm = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "PRM"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }



            if (lstprm.Count() > 0)
            {
                gvPRM.DataSource = lstprm;
                gvPRM.DataBind();
                gvPRM.Visible = true;
                dvPRM.Style.Add("display", "block");
                trPRM.Style.Add("Display", "block");
            }
            else
            {
                trPRM.Style.Add("Display", "none");
                dvPRM.Style.Add("display", "none");
                trPRM.Visible = false;
                gvPRM.Visible = false;
            }

            #endregion



            #region Room
            //List<PatientDueChart> lstrom = new List<PatientDueChart>();
            //if (strFlag != "")
            //{
            //    lstrom = (from listInv in lstBedBookingRoomType
            //              where listInv.FeeType == "ROM" && listInv.IsReimbursable == strFlag
            //              orderby listInv.FeeType ascending
            //              select listInv).Distinct().ToList();

            //}
            //else
            //{
            //    lstrom = (from listInv in lstBedBookingRoomType
            //              where listInv.FeeType == "ROM"
            //              orderby listInv.FeeType ascending
            //              select listInv).Distinct().ToList();
            //}
            List<IPBulkBill> lstrom = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstrom = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "ROM" && listInv.IsReimbursable == strFlag
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();

            }
            else
            {
                lstrom = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "ROM"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }

            if (lstrom.Count() > 0)
            {
                gvROM.DataSource = lstrom;
                gvROM.DataBind();
                gvROM.Visible = true;
                dvROM.Style.Add("display", "block");
                trROM.Style.Add("Display", "block");
            }
            else
            {
                trROM.Style.Add("Display", "none");
                dvROM.Style.Add("display", "none");
                gvROM.Visible = false;
            }
            #endregion
            //#region Room
            //List<IPBulkBill> lstrom = new List<IPBulkBill>();
            //if (strFlag != "")
            //{
            //    lstrom = (from listInv in lstIPBulkBill
            //               where listInv.FeeType == "ROM" && listInv.IsReimbursable == strFlag
            //               orderby listInv.FeeType ascending
            //               select listInv).Distinct().ToList();

            //}
            //else
            //{
            //    lstrom = (from listInv in lstIPBulkBill
            //              where listInv.FeeType == "ROM"
            //              orderby listInv.FeeType ascending
            //              select listInv).Distinct().ToList();
            //}


            //if (lstrom.Count() > 0)
            //{
            //    gvROM.DataSource = lstrom;
            //    gvROM.DataBind();
            //    gvROM.Visible = true;
            //    dvROM.Style.Add("display", "block");
            //    trROM.Style.Add("Display", "block");
            //}
            //else
            //{
            //    trROM.Style.Add("Display", "none");
            //    dvROM.Style.Add("display", "none");
            //    gvROM.Visible = false;
            //}
            //#endregion

            #region Surgery Package
            List<IPBulkBill> lstspkg = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstspkg = (from listInv in lstIPBulkBill
                            where listInv.FeeType == "SPKG" && listInv.IsReimbursable == strFlag
                            orderby listInv.FeeType ascending
                            select listInv).Distinct().ToList();

                    
            }
            else
            {
                lstspkg = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "SPKG"
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }
            

            if (lstspkg.Count() > 0)
            {
                gvSPKG.DataSource = lstspkg;
                gvSPKG.DataBind();
                gvSPKG.Visible = true;
                dvSPKG.Style.Add("display", "block");
                trSPKG.Style.Add("Display", "block");
            }
            else
            {
                trSPKG.Style.Add("Display", "none");
                dvSPKG.Style.Add("display", "none");
                gvSPKG.Visible = false;
            }
            #endregion

            #region Additional
            List<IPBulkBill> lstaddi = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstaddi = (from listInv in lstIPBulkBill
                         where listInv.FeeType == "ADD" && listInv.IsReimbursable == strFlag
                         orderby listInv.FeeType ascending
                         select listInv).Distinct().ToList();

            }
            else
            {
                lstaddi = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "ADD"
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }
            

            if (lstaddi.Count() > 0)
            {
                gvADD.DataSource = lstaddi;
                gvADD.DataBind();
                gvADD.Visible = true;
                dvADD.Style.Add("display", "block");
                trADD.Style.Add("Display", "block");
            }
            else
            {
                trADD.Style.Add("Display", "none");
                dvADD.Style.Add("display", "none");
                gvADD.Visible = false;
            }
            #endregion

            #region Casuality
            List<IPBulkBill> lstcas = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstcas = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "CAS" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }
            else
            {
                lstcas = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "CAS"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstcas.Count() > 0)
            {
                gvCAS.DataSource = lstcas;
                gvCAS.DataBind();
                gvCAS.Visible = true;
                dvCAS.Style.Add("display", "block");
                trCAS.Style.Add("Display", "block");
            }
            else
            {
                trCAS.Style.Add("Display", "none");
                dvCAS.Style.Add("display", "none");
                gvCAS.Visible = false;
            }
            #endregion

            #region Due
            List<IPBulkBill> lstdue = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstdue = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "DUE" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }
            else
            {
                lstdue = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "DUE"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }



            if (lstdue.Count() > 0)
            {
                gvDUE.DataSource = lstdue;
                gvDUE.DataBind();
                gvDUE.Visible = true;
                dvDUE.Style.Add("display", "block");
                trDUE.Style.Add("Display", "block");
            }
            else
            {
                trDUE.Style.Add("Display", "none");
                dvDUE.Style.Add("display", "none");
                gvDUE.Visible = false;
            }
            #endregion

            #region Immunization
            List<IPBulkBill> lstimu = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstimu = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "IMU" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }
            else
            {
                lstimu = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "IMU"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstimu.Count() > 0)
            {
                gvIMU.DataSource = lstimu;
                gvIMU.DataBind();
                gvIMU.Visible = true;
                dvIMU.Style.Add("display", "block");
                trIMU.Style.Add("Display", "block");
            }
            else
            {
                trIMU.Style.Add("Display", "none");
                dvIMU.Style.Add("display", "none");
                gvIMU.Visible = false;
            }

            #endregion

            #region Indents
            List<IPBulkBill> lstind = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstind = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "IND" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();

            }
            else
            {
                lstind = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "IND"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }

            if (lstind.Count() > 0)
            {
                gvIND.DataSource = lstind;
                gvIND.DataBind();
                gvIND.Visible = true;
                dvIND.Style.Add("display", "block");
                trIND.Style.Add("Display", "block");
            }
            else
            {
                trIND.Style.Add("Display", "none");
                dvIND.Style.Add("display", "none");
                gvIND.Visible = false;
            }
            #endregion

            #region LCON
            List<IPBulkBill> lstlcon = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstlcon = (from listInv in lstIPBulkBill
                         where listInv.FeeType == "LCON" && listInv.IsReimbursable == strFlag
                         orderby listInv.FeeType ascending
                         select listInv).Distinct().ToList();

            }
            else
            {
                lstlcon = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "LCON" && listInv.IsReimbursable == strFlag
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }


            if (lstlcon.Count() > 0)
            {
                gvLCON.DataSource = lstlcon;
                gvLCON.DataBind();
                gvLCON.Visible = true;
                dvLCON.Style.Add("display", "block");
                trLCON.Style.Add("Display", "block");
            }
            else
            {
                trLCON.Style.Add("Display", "none");
                dvLCON.Style.Add("display", "none");
                gvLCON.Visible = false;
            }
            #endregion

            #region Miscellaneous
            List<IPBulkBill> lstmisc = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstmisc = (from listInv in lstIPBulkBill
                         where listInv.FeeType == "Miscellaneous" && listInv.IsReimbursable == strFlag
                         orderby listInv.FeeType ascending
                         select listInv).Distinct().ToList();
            }
            else
            {
                lstmisc = (from listInv in lstIPBulkBill
                           where listInv.FeeType == "Miscellaneous"
                           orderby listInv.FeeType ascending
                           select listInv).Distinct().ToList();
            }


            if (lstmisc.Count() > 0)
            {
                gvMiscellaneous.DataSource = lstmisc;
                gvMiscellaneous.DataBind();
                gvMiscellaneous.Visible = true;
                dvMiscellaneous.Style.Add("display", "block");
                trMiscellaneous.Style.Add("Display", "block");
            }
            else
            {
                trMiscellaneous.Style.Add("Display", "none");
                dvMiscellaneous.Style.Add("display", "none");
                gvMiscellaneous.Visible = false;
            }
            #endregion

            #region Othres
            List<IPBulkBill> lstoth = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstoth =(from listInv in lstIPBulkBill
                        where listInv.FeeType == "OTH" && listInv.IsReimbursable == strFlag
                        orderby listInv.FeeType ascending
                        select listInv).Distinct().ToList();
                    
            }
            else
            {
                lstoth = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "OTH"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }



            if (lstoth.Count() > 0)
            {
                gvOTH.DataSource = lstoth;
                gvOTH.DataBind();
                gvOTH.Visible = true;
                dvOTH.Style.Add("display", "block");
                trOTH.Style.Add("Display", "block");
            }
            else
            {
                trOTH.Style.Add("Display", "none");
                dvOTH.Style.Add("display", "none");
                gvOTH.Visible = false;
            }
            #endregion


            #region Health Package
            List<IPBulkBill> lstpkg = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstpkg = (from listInv in lstIPBulkBill
                        where listInv.FeeType == "PKG" && listInv.IsReimbursable == strFlag
                        orderby listInv.FeeType ascending
                        select listInv).Distinct().ToList();

            }
            else
            {
                lstpkg = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "PKG"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstpkg.Count() > 0)
            {
                gvPKG.DataSource = lstpkg;
                gvPKG.DataBind();
                gvPKG.Visible = true;
                dvPKG.Style.Add("display", "block");
                trPKG.Style.Add("Display", "block");
            }
            else
            {
                trPKG.Style.Add("Display", "none");
                dvPKG.Style.Add("display", "none");
                gvPKG.Visible = false;
            }
            #endregion

            #region Registration
            List<IPBulkBill> lstreg = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstreg = (from listInv in lstIPBulkBill
                        where listInv.FeeType == "REG" && listInv.IsReimbursable == strFlag
                        orderby listInv.FeeType ascending
                        select listInv).Distinct().ToList();

            }
            else
            {
                lstreg = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "REG"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstreg.Count() > 0)
            {
                gvREG.DataSource = lstreg;
                gvREG.DataBind();
                gvREG.Visible = true;
                dvREG.Style.Add("display", "block");
                trREG.Style.Add("Display", "block");
            }
            else
            {
                trREG.Style.Add("Display", "none");
                dvREG.Style.Add("display", "none");
                gvREG.Visible = false;
            }
            #endregion

            #region Surgery Items
            List<IPBulkBill> lstsoi = new List<IPBulkBill>();
            if (strFlag != "")
            {
                lstsoi = (from listInv in lstIPBulkBill
                        where listInv.FeeType == "SOI" && listInv.IsReimbursable == strFlag
                        orderby listInv.FeeType ascending
                        select listInv).Distinct().ToList();

            }
            else
            {
                lstsoi = (from listInv in lstIPBulkBill
                          where listInv.FeeType == "SOI"
                          orderby listInv.FeeType ascending
                          select listInv).Distinct().ToList();
            }


            if (lstsoi.Count() > 0)
            {
                gvSOI.DataSource = lstsoi;
                gvSOI.DataBind();
                gvSOI.Visible = true;
                dvSOI.Style.Add("display", "block");
                trSOI.Style.Add("Display", "block");
            }
            else
            {
                trSOI.Style.Add("Display", "none");
                dvSOI.Style.Add("display", "none");
                gvSOI.Visible = false;
            }
            #endregion
            string rval = GetConfigValue("roundoffpatamt", OrgID);
            hdnDefaultRoundoff.Value = rval == "" ? "0" : rval;

            rval = GetConfigValue("patientroundoffpattern", OrgID);
            hdnRoundOffType.Value = rval;
            lblRound.Text = lstIPBulkBill1[0].RoundOff.ToString();
            decimal deRound = getOPCustomRoundoff(Convert.ToDecimal(Convert.ToDecimal(lblGTotal.Text)));
            lblRound.Text = String.Format("{0:0.00}", deRound - Convert.ToDecimal(lblGTotal.Text));
            decimal NetAmt = Convert.ToDecimal(lblGTotal.Text.ToString()) + Convert.ToDecimal(lblRound.Text.ToString());
            // NetAmt = NetAmt + GrandTotal;
            lblNetTotal.Text = Convert.ToString(NetAmt);
            if (lblRound.Text == "0.00")
            {
                //trRoundOff.Attributes.Add("display", "none");
                trRoundOff.Visible = false;
                lblRound.Visible = false;
                lblRoundOff.Visible = false;
            }
            else
            {
                trRoundOff.Attributes.Add("display", "block");
                lblRound.Visible = true;
                lblRoundOff.Visible = true;
            }
            BillingEngine be = new BillingEngine(base.ContextInfo);

            decimal Copercent = -1;
            be.CheckIsCreditBill(VisitID, out pPreAuthAmount, out PaidAmount, out GrossBillAmount,  out IsCreditBill,out lstVisitClientMapping);
            //lblPreAutho.Text = pPreAuthAmount.ToString("0.00");
            //lblCoPayments.Text = pCoPayment.ToString("0.00");
            new GateWay(base.ContextInfo).GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
            //if (lstConfig.Count > 0)
            //{
            //    if (lstConfig[0].ConfigValue.Trim() != "")
            //    {
            //        lblCurrency.Text = lstConfig[0].ConfigValue.Trim();
            //        lblAmount.Text = lstConfig[0].ConfigValue.Trim();
            //    }
            //    else
            //    {
            //        lblCurrency.Text = CurrencyName;
            //        lblAmount.Text = lstConfig[0].ConfigValue.Trim();
            //    }
            //}
            
        }
        else
        {
            printArea1.Visible = false;
        }
    }
    public decimal getOPCustomRoundoff(decimal netRound)
    {
        decimal DefaultRound = Convert.ToDecimal(hdnDefaultRoundoff.Value);
        string RoundType = Convert.ToString(hdnRoundOffType.Value);
        decimal result;
        if (RoundType.ToString().ToLower() == "lower value")
        {
            result = (Math.Floor(netRound / DefaultRound) * (DefaultRound));
        }
        else if (RoundType.ToString().ToLower() == "upper value")
        {
            result = (Math.Ceiling(netRound / DefaultRound) * (DefaultRound));
        }
        else if (RoundType.ToString().ToLower() == "none")
        {
            result = Math.Round(netRound, 2);
        }
        else
        {
            result = Convert.ToDecimal(netRound);
        }
        result = Convert.ToDecimal(result);
        return result;
    }
    protected void gvInv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable!=null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvGRP_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvIND_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvCon_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill) e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvGEN_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvPRM_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvSPKG_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvROM_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvPRO_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable!=null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvADD_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvCAS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvDUE_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvIMU_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvLCON_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvMiscellaneous_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvOTH_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvPKG_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvREG_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
    protected void gvSOI_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPBulkBill p = (IPBulkBill)e.Row.DataItem;
            if (p.IsReimbursable != null && p.IsReimbursable.ToString() == "N")
            {
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
        }
    }
}
