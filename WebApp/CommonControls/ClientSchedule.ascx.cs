using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Attune.Podium.Common;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using System.Web.UI.HtmlControls;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.DAL;
public partial class CommonControls_ClientSchedule : BaseControl
{
    public CommonControls_ClientSchedule()
        : base("CommonControls_ClientSchedule_ascx")
    {
    }

    DateTime FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    List<Schedulesinvoice> schedules = new List<Schedulesinvoice>();
    List<Schedulesinvoice> lstTotschedules;
    List<string> lstunchkclients = new List<string>();
    BillingEngine bill;
    int tempID = 0;
    int startRowIndex = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnIsWaters.Value = GetConfigValue("WatersMode", OrgID);
        hdnisNeedBillSupplyNumber.Value = GetConfigValue("NeedbillofSupplyNoInvoice", OrgID);
        //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        if (!IsPostBack)
        {
            GetGroupValues();
            loadClient();
            RdoNonSch.Checked = true;


            if (RdoNonSch.Checked == true)
            {
                lblPreSch.Visible = true;
                chkPreSch.Visible = true;
                chkPreSch.Checked = true;
            }
            else
            {
                chkPreSch.Visible = false;
                lblPreSch.Visible = false;
            }
        }
        txtFrom.Attributes.Add("onchange", "ValidFromDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ValidToDate('" + txtTo.ClientID.ToString() + "','',0,0);");
    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        startRowIndex = 1;
        hdnCurrent.Value = startRowIndex.ToString();
        LoadGrid(e, startRowIndex, PageSize);
        lblCurrent.Text = startRowIndex.ToString();
        ////Added by prabakar for bulk invoice generation 21-09-2013////////////////////
        long Returncode = -1;
        long ClientID = 0;
        Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
        schedules.Clear();
        int TempOrgID = OrgID;
        int LocationID = ILocationID;
        int customerTypeID;
        customerTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());
        if (hdnFromDate.Value != "")
        {
            FromDate = Convert.ToDateTime(hdnFromDate.Value.ToString());
        }
        if (hdnToDate.Value != "")
        {
            ToDate = Convert.ToDateTime(hdnToDate.Value.ToString());

            if (hdnisNeedBillSupplyNumber.Value == "Y")
            {
               
                
                 ToDate = Convert.ToDateTime(hdnToDate.Value + ' ' + "23:59:59");
            }
        }
        if (hdnClientID.Value != "")
        {
            ClientID = Convert.ToInt64(hdnClientID.Value.ToString());
        }
        lstTotschedules = new List<Schedulesinvoice>();
        // Returncode = sBL.GetClientSchedules(TempOrgID,customerTypeID,txtClientName.Text,ClientID,LocationID,Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), out lstTotschedules, PageSize, startRowIndex, out totalRows, "total");
        ViewState["ClientList"] = lstTotschedules.ToList();
        txtFrom.Text = "";
        txtTo.Text = "";
        hdnClientID.Value = "";
        txtClientName.Text = "";
        drpCustomerType.SelectedIndex = 0;
        lblClientType.Visible = false;
        drpClientType.Visible = false;
        //-----------End---------------------//
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }

    private void LoadGrid(EventArgs e, int startRowIndex, int PageSize)
    {
        string strNoRecord = Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_01 == null ? "No Matching Record Found" : Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_01;
        txtpageNo.Text = "";
        hdnCurrent.Value = "";

        try
        {
            long Returncode = -1;
            long ClientID = 0;
            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            schedules.Clear();
            GridView1.DataSource = null;
            GridView1.DataBind();

            int TempOrgID = OrgID;
            int LocationID = ILocationID;
            int customerTypeID;

            customerTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());


            if (hdnFromDate.Value != "")
            {
                FromDate = Convert.ToDateTime(hdnFromDate.Value.ToString());
            }
            if (hdnToDate.Value != "")
            {
                ToDate = Convert.ToDateTime(hdnToDate.Value.ToString());

                if (hdnisNeedBillSupplyNumber.Value == "Y")
                {
                   ToDate = Convert.ToDateTime(hdnToDate.Value + ' ' + "23:59:59");
                }
            }

            if (hdnClientID.Value != "")
            {
                ClientID = Convert.ToInt64(hdnClientID.Value.ToString());

            }
            //if (chkPreSch.Checked == true)
            //{

            //    tempID = 1;
            //}
            if (hdnIsWaters.Value != "Y")
            {

                Returncode = sBL.GetClientSchedules(TempOrgID, customerTypeID, txtClientName.Text, ClientID, LocationID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), out schedules, PageSize, startRowIndex, out totalRows, "");
            }
            else {

                Returncode = sBL.GetWatersClientSchedules(TempOrgID, customerTypeID, txtClientName.Text, ClientID, LocationID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), out schedules, PageSize, startRowIndex, out totalRows, "");
            
            
            }

            if (schedules.Count > 0)
            {
                lblerror.Text = "";
                GridView1.DataSource = schedules;
                GridView1.DataBind();
                GridView1.Visible = true;
                GrdFooter.Visible = true;

                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = startRowIndex.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    startRowIndex = Convert.ToInt32(hdnCurrent.Value);
                }
                if (startRowIndex == 1)
                {
                    Btn_Previous.Enabled = false;

                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        Btn_Next.Enabled = true;
                    }
                    else
                        Btn_Next.Enabled = false;
                }
                else
                {
                    Btn_Previous.Enabled = true;

                    if (startRowIndex == Int32.Parse(lblTotal.Text))
                        Btn_Next.Enabled = false;
                    else Btn_Next.Enabled = true;
                }
                if (RdoClient.Checked == true)
                {
                    GridView1.Columns[1].Visible = true;
                    GnereateInvoive.Visible = true;
                }
                else
                {
                    GridView1.Columns[1].Visible = false;
                    GnereateInvoive.Visible = false;
                }

            }
            else
            {
                GridView1.Visible = false;
                GnereateInvoive.Visible = false;
                lblerror.Text = strNoRecord.Trim();
                GrdFooter.Visible = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading sample", ex);
        }

    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    public void loadClient()
    {

        long Returncode = -1;

        List<InvClientType> client = new List<InvClientType>();

        Returncode = new Patient_BL(base.ContextInfo).GetInvClientType(out client);

        if (client.Count > 0)
        {
            drpClientType.DataSource = client;
            drpClientType.DataTextField = "ClientTypeName";
            drpClientType.DataValueField = "ClientTypeID";
            drpClientType.DataBind();
            drpClientType.Items.Insert(0, "Select");

        }
    }


    public void GetGroupValues()
    {
        string strAllItem = Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02 == null ? "--All--" : Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02;
        
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstmetavalue.Count > 0)
            {
                string setID = "0";
                lstmetavalue.RemoveAll(p => p.Code != "BT");
                //string getCTOrg = "";
                //getCTOrg = GetConfigValue("CTORG", OrgID);
                //if (getCTOrg == "Y")
                //{
                //    if (lstmetavalue.Exists(p => p.Value == "CLINICALTRIAL"))
                //    {
                //        setID = lstmetavalue.Find(p => p.Value == "CLINICALTRIAL").MetaValueID.ToString();
                //    }
                //}
                drpCustomerType.DataSource = lstmetavalue;
                drpCustomerType.DataTextField = "Value";
                drpCustomerType.DataValueField = "MetaValueID";
                drpCustomerType.DataBind();
                drpCustomerType.Items.Insert(0, strAllItem.Trim());
                drpCustomerType.Items[0].Value = "0";
                drpCustomerType.SelectedValue = setID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string txt = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ClientID"));
                CheckBox chkBX = (CheckBox)e.Row.FindControl("chkInvoiceItem");
                string ClientID = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ClientID"));
                string jScript = "javascript:SelectBatch('" + chkBX.ClientID.ToString() + "','" + ClientID + "');";
                string BillofSupplyNumber = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BillofSupplyNumber"));
                string ClientName = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ClientName"));
                Label lblbillSupplyNumber = (Label)e.Row.FindControl("lblBillofSupplyNumber");
                chkBX.Attributes.Add("onClick", jScript);
                if (RdoNonSch.Checked == true)
                {
                    e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                    e.Row.Cells[0].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[1].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[2].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
                }
                //else
                //{
                //    e.Row.Attributes.Add("onMouseOver", "this.style=cursor:default;");
                //    e.Row.Cells[0].Attributes.Add("onMouseOver", "this.style=cursor:default;");
                //    e.Row.Cells[1].Attributes.Add("onMouseOver", "this.style=cursor:default;");
                //    e.Row.Cells[2].Attributes.Add("onMouseOver", "this.style=cursor:default;");
                //}
                
                if (hdnisNeedBillSupplyNumber.Value == "Y")
                {
                    GridView1.Columns[11].Visible = true;
                }
                if (hdnisNeedBillSupplyNumber.Value == "Y" && BillofSupplyNumber == "")
                {
                    lblbillSupplyNumber.Text = "Bill of Supply Number is Missing";
                    e.Row.BackColor = System.Drawing.Color.Red;
                    if (hdnbillSupplyNumber.Value == "")
                    {
                        hdnbillSupplyNumber.Value = ClientName;
                    }
                    else if (hdnbillSupplyNumber.Value != "")
                    {
                        hdnbillSupplyNumber.Value = hdnbillSupplyNumber.Value + "<br/>" + ClientName;
                    }

                    chkBX.Checked = false;
                    chkBX.Enabled = false;
                }
                CheckBox chkAll = (CheckBox)e.Row.FindControl("chkInvoiceItem");

                if (hdnchkAll.Value == "")
                {
                    if (RdoNonSch.Checked == true)
                    {
                        GridView1.Columns[1].Visible = false;
                    }
                }
                else
                {
                    hdnchkAll.Value += "~" + chkAll.ClientID;
                }
                /****************Added by prabakar for bulk invoice generation**********/

                if (!string.IsNullOrEmpty(hdnUnSelectedClients.Value))
                {
                    lstunchkclients = hdnUnSelectedClients.Value.Split('~').ToList();
                    if (lstunchkclients.Contains(ClientID))
                    {
                        chkAll.Checked = false;
                    }
                }
                /****************END**********/
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Row Data bound in Client Schedules", ex);
        }
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strAlert = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03 == null ? "Alert" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03;
        string strNoBillAddToClient = Resources.CommonControls_AppMsg.CommonControls_ClientSchedule_ascx_08 == null ? "No Bills Added to this Client" : Resources.CommonControls_AppMsg.CommonControls_ClientSchedule_ascx_08;
        string strManualInvoice = Resources.CommonControls_AppMsg.CommonControls_ClientSchedule_ascx_09 == null ? "Its Only for Manual Invoice" : Resources.CommonControls_AppMsg.CommonControls_ClientSchedule_ascx_09;

        Int32 rowIndex = int.Parse(e.CommandArgument.ToString());
        GridViewRow row = GridView1.Rows[rowIndex];
        Int64 ClientID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["ClientID"]);

        if (e.CommandName == "ValueEdit")
        {
            if (RdoNonSch.Checked == true)
            {
                List<BillingDetails> lstInvoice = new List<BillingDetails>();
                List<DiscountPolicy> lstVol = new List<DiscountPolicy>();
                List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
                long InvoiceID = 0;
               

                Int64 MetaValueID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["MetaValueID"]);
                string BusinessType = Convert.ToString(GridView1.DataKeys[rowIndex]["Value"]);
               
                string ClientName = Convert.ToString(GridView1.DataKeys[rowIndex]["ClientName"]);
                Int64 ScheduleID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["ScheduleID"]);
                DateTime FromDate = Convert.ToDateTime(GridView1.DataKeys[rowIndex]["NextOccurance"]);
                DateTime ToDate = Convert.ToDateTime(GridView1.DataKeys[rowIndex]["PreviousOccurance"]);
                string ClientCode = Convert.ToString(GridView1.DataKeys[rowIndex]["ClientCode"]);
                string IsApprovalNeeded = Convert.ToString(GridView1.DataKeys[rowIndex]["ApprovalRequired"]);

                //string BillofSupplyNumber = Convert.ToString(GridView1.DataKeys[rowIndex]["BillofSupplyNumber"]);
                GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                
                Label lblbillSupplyNumber = ((Label)gvr.FindControl("lblBillofSupplyNumber"));
                string BillofSupplyNumber = string.Empty;
                if (lblbillSupplyNumber.Text != "Bill of Supply Number is Missing")
                {
               BillofSupplyNumber = lblbillSupplyNumber.Text;
                }
                else 
                {
                    BillofSupplyNumber="";
                }
              
               
                string Fdate = FromDate.ToString("dd/MM/yyyy");
                string Tdate = ToDate.ToString("dd/MM/yyyy");

                if (Tdate == "01/01/0001")
                {
                    Tdate = "01/01/1900";

                }
                if (Tdate == "01/01/1900" || Tdate == "01/01/1900 00:00:00")
                {
                    DateTime dt = Convert.ToDateTime(Fdate);
                    Tdate = dt.AddDays(1 + Convert.ToDouble(dt.DayOfWeek)).ToString("dd/MM/yyyy");

                }

                if (chkPreSch.Checked == true)
                {

                    tempID = 1;
                }
                else
                {
                    tempID = 0;
                }

                string TOdate = ToDate.ToString("dd/MM/yyyy");
                bill = new BillingEngine(base.ContextInfo);
                if (hdnIsWaters.Value != "Y")
                {

                    bill.GetInvoiceGeneration(InvoiceID, ClientID, OrgID, ILocationID, Convert.ToDateTime(Fdate), Convert.ToDateTime(Tdate), tempID, out lstInvoice, out lstVol, out lstCreditDebit);
                }

                else
                {
                    bill.GetWatersInvoiceGeneration(InvoiceID, ClientID, OrgID, ILocationID, Convert.ToDateTime(Fdate), Convert.ToDateTime(Tdate), tempID, out lstInvoice, out lstVol, out lstCreditDebit);
                
                }
                if (hdnisNeedBillSupplyNumber.Value == "Y")
                {
                    if (lstInvoice.Count > 0 && BillofSupplyNumber !="")
                    {

                        Response.Redirect("../Invoice/GenerateInvoice.aspx?CID=" + ClientID + "&CName=" + ClientName + "&SID=" + Convert.ToString(ScheduleID) + "&FDate=" + Fdate + "&TDate=" + TOdate + "&CCode=" + ClientCode + "&IsA=" + IsApprovalNeeded + "&RejBill=" + tempID + " ");


                    }
                    else
                    {
                        if (lstInvoice.Count == 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "ValidationWindow('" + strNoBillAddToClient.Trim() + "','" + strAlert.Trim() + "');", true);

                        }
                        else if (BillofSupplyNumber == "")
                        {
                            hdnbillSupplyNumber.Value = ClientName;
                            ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ValidatebillSupplyNumber();", true);

                        }

                    }
                }
                else
                {
                    if (lstInvoice.Count > 0)
                    {

                    Response.Redirect("../Invoice/GenerateInvoice.aspx?CID=" + ClientID + "&CName=" + ClientName + "&SID=" + Convert.ToString(ScheduleID) + "&FDate=" + Fdate + "&TDate=" + TOdate + "&CCode=" + ClientCode + "&IsA=" + IsApprovalNeeded + "&RejBill=" + tempID + " ");


                }
                else
                {
                    if (lstInvoice.Count == 0)
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "ValidationWindow('" + strNoBillAddToClient.Trim() + "','" + strAlert.Trim() + "');", true);

                    }

                    }
                }

            }
        }
        else if (e.CommandName == "EditBillSupplyNumber")
        {
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            TextBox tbComments = ((TextBox)gvr.FindControl("txtbillsupplynumber"));
            Label lblbillSupplyNumber = ((Label)gvr.FindControl("lblBillofSupplyNumber"));
            if (lblbillSupplyNumber.Text == "Bill of Supply Number is Missing")
            {
                tbComments.Text = "";
            }
            else
            {
                tbComments.Text = lblbillSupplyNumber.Text;
            }
            tbComments.Visible = true;
            
            Button btnsavebill = ((Button)gvr.FindControl("btnSavebillSupplyNumber"));
            btnsavebill.Visible = true;
        }
        else if (e.CommandName == "SaveUpdateBillSupplyNumber")
        {
            GridViewRow gvr = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            int RowIndexx = Convert.ToInt32(gvr.RowIndex);
            TextBox tbComments = ((TextBox)gvr.FindControl("txtbillsupplynumber"));
            
            string billofsupplynumber = tbComments.Text;
            bill = new BillingEngine(base.ContextInfo);
            Label lblbillSupplyNumber = ((Label)gvr.FindControl("lblBillofSupplyNumber"));
            
            bill.UpdateBillofSupplyNumberClientWise(ClientID,OrgID,billofsupplynumber,0,"");
            lblbillSupplyNumber.Text = tbComments.Text;
            Button btnsavebill = ((Button)gvr.FindControl("btnSavebillSupplyNumber"));
            CheckBox checkclient = ((CheckBox)gvr.FindControl("chkInvoiceItem"));

            if (tbComments.Text != "")
            {
                GridView1.Rows[RowIndexx].BackColor=System.Drawing.Color.Transparent;
                checkclient.Checked = true;
                checkclient.Enabled = true;
            }
            
            tbComments.Visible = false;
            btnsavebill.Visible = false;
           


        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "ValidationWindow('" + strManualInvoice.Trim() + "," + strAlert.Trim() + "');", true);
        }

    }

    protected void drpCustomerType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpCustomerType.SelectedIndex == 0)
        {
            txtClientName.Enabled = false;
            txtClientName.Text = "";
        }
        else
        {
            txtClientName.Enabled = true;
            int ClientTypeID = 0;
            int CustomerTypeID = Convert.ToInt32(drpCustomerType.SelectedValue.ToString());
            AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + ClientTypeID.ToString() + "~" + CustomerTypeID.ToString();
            txtClientName.Focus();
            lblClientType.Visible = false;
            drpClientType.Visible = false;
            txtClientName.Text = "";

        }
    }

    protected void GnereateInvoive_Click(object sender, EventArgs e)
    {
        try
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            string ButtonName = ((Button)sender).ID;
            string ButtonValue = ((Button)sender).Text;
            bill = new BillingEngine(base.ContextInfo);
            string fdate = string.Empty;
            string todate = string.Empty;
            string clientName = string.Empty;
            string PageValue = string.Empty;
            long InvoiceID = 0;
            long ClientID = 0;
            int Rejbills = 0;
            List<BillingDetails> lstInvoice = new List<BillingDetails>();
            List<DiscountPolicy> lstVolumediscount = new List<DiscountPolicy>();
            if (Request.QueryString["TDate"] != null)
            {
                todate = (Request.QueryString["TDate"]);
            }
            if (Request.QueryString["FDate"] != null)
            {
                fdate = (Request.QueryString["FDate"]);
            }
            if (Request.QueryString["CName"] != null)
            {
                clientName = (Request.QueryString["CName"]);
            }
            if (Request.QueryString["Pvalue"] != null)
            {
                PageValue = (Request.QueryString["Pvalue"]);
            }
            if (Request.QueryString["InvoiceID"] != null)
            {
                InvoiceID = Convert.ToInt64(Request.QueryString["InvoiceID"]);
            }
            if (Request.QueryString["RejBill"] != null)
            {
                Rejbills = Convert.ToInt32(Request.QueryString["RejBill"]);
            }

            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("ClientID");
            //add columns
            dt.Columns.Add(dbCol1);
            List<string> lstClients = new List<string>();
            List<Schedulesinvoice> lstSchedules = new List<Schedulesinvoice>();
            lstSchedules = (List<Schedulesinvoice>)ViewState["ClientList"];
            if (!string.IsNullOrEmpty(hdnUnSelectedClients.Value))
            {
                lstClients = hdnUnSelectedClients.Value.Split('~').ToList();
                for (int i = 0; i < lstClients.Count(); i++)
                {
                    lstSchedules.RemoveAll(p => p.ClientID.ToString() == lstClients[i].ToString());
                }
            }
            //
            //System.Data.DataTable dt1 = new DataTable();
            //DataColumn dbColl1 = new DataColumn("ActionType");
            //DataColumn dbCol2 = new DataColumn("Value");
            //DataColumn dbCol3 = new DataColumn("AdditionalContext");
            //DataColumn dbCol4 = new DataColumn("Category");
            //DataColumn dbCol5 = new DataColumn("version");
            //DataColumn dbCol6 = new DataColumn("Status");
            //DataColumn dbCol7 = new DataColumn("OrgID");
            //DataColumn dbCol8 = new DataColumn("OrgAddressID");
            //DataColumn dbCol9 = new DataColumn("CreatedAt");
            //DataColumn dbCol10 = new DataColumn("CreatedBy");
            //DataColumn dbCol11 = new DataColumn("Template");
            //DataColumn dbCol12 = new DataColumn("ContextType");
            //DataColumn dbCol13 = new DataColumn("IsAttachment");
            //DataColumn dbCol14 = new DataColumn("Subject");
            //DataColumn dbCol15 = new DataColumn("AttachmentName");
            ////add columns
            //dt1.Columns.Add(dbColl1);
            //dt1.Columns.Add(dbCol2);
            //dt1.Columns.Add(dbCol3);
            //dt1.Columns.Add(dbCol4);
            //dt1.Columns.Add(dbCol5);
            //dt1.Columns.Add(dbCol6);
            //dt1.Columns.Add(dbCol7);
            //dt1.Columns.Add(dbCol8);
            //dt1.Columns.Add(dbCol9);
            //dt1.Columns.Add(dbCol10);
            //dt1.Columns.Add(dbCol11);
            //dt1.Columns.Add(dbCol12);
            //dt1.Columns.Add(dbCol13);
            //dt1.Columns.Add(dbCol14);
            //dt1.Columns.Add(dbCol15);
            ////
            //for (int i = 0; i < lstSchedules.Count(); i++)
            //{
            //    //string ClntID = lstSchedules[i].ClientID.ToString();
            //    //DataRow dr;
            //    //dr = dt.NewRow();
            //    //dr["ClientID"] = ClntID;
            //    //dt.Rows.Add(dr);
            //    //PC.ID = Convert.ToInt64(ILocationID);
            //    //PC.RoleID = Convert.ToInt64(RoleID);
            //    //PC.OrgID = OrgID;
            //    //PC.PatientID = Convert.ToInt64(ClntID);//ClientID as PatientID
            //    //PC.PageID = Convert.ToInt64(PageID);
            //    //PC.ButtonName = ButtonName;
            //    //PC.ButtonValue = ButtonValue;
            //    //lstpagecontextkeys.Add(PC);
            //    //long res = -1;
            //    //res = AM.PerformingNextStepNotification(PC, hdnFromDate.Value.ToString(), hdnToDate.Value.ToString());
            //    //<?xml version="1.0" encoding="utf-16"?><ContextInfo><InvoiceID>1984</InvoiceID><ClientID>1984</ClientID><FromDate>16/03/2014</FromDate><ToDate>17/03/2014</ToDate></ContextInfo>
            //    string Additionalcontext = "<?xml version=" + "1.0" + " encoding=" + "utf-16" + "?><ContextInfo><InvoiceID>" + lstSchedules[i].ClientID.ToString() + "</InvoiceID><ClientID>" + lstSchedules[i].ClientID.ToString() + "</ClientID><FromDate>" + hdnFromDate.Value.ToString() + "</FromDate><ToDate>" + hdnToDate.Value.ToString() + "</ToDate></ContextInfo>";
            //    string AttachmentName = "Invoice-{InvoiceNumber}_" + lstSchedules[i].ClientCode + "_" + hdnFromDate.Value.ToString() + "_" + hdnToDate.Value.ToString() + ".pdf";
            //    string folderformat = "\\INVOICE\\" + OrgID + "\\" + "{pdfDate}" + "\\";
            //    DataRow dr1;
            //    dr1 = dt1.NewRow();
            //    dr1["ActionType"] = "PDF";
            //    dr1["Value"] = lstSchedules[i].ClientID.ToString();
            //    dr1["AdditionalContext"] = Additionalcontext;
            //    dr1["Category"] = "Invoice";
            //    dr1["Status"] = "";
            //    dr1["OrgID"] = OrgID;
            //    dr1["OrgAddressID"] = ILocationID;
            //    dr1["CreatedAt"] = DateTime.MinValue;
            //    dr1["CreatedBy"] = RoleID;
            //    dr1["Template"] = folderformat;
            //    dr1["ContextType"] = "INV";
            //    dr1["IsAttachment"] = "Y";
            //    dr1["Subject"] = "";
            //    dr1["AttachmentName"] = AttachmentName;
            //    dt1.Rows.Add(dr1);
            //    //

            //}

            long res1 = -1;
            Report_DAL objReportdal = new Report_DAL(base.ContextInfo);
            res1 = objReportdal.SaveInvoiceNotificationDetails(OrgID, 0, txtClientName.Text, ClientID, ILocationID, Convert.ToDateTime(hdnFromDate.Value), Convert.ToDateTime(hdnToDate.Value), PageSize, startRowIndex, totalRows, "total");
            if (res1 >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:AutoInvoice();", true);
                GridView1.DataSource = null;
                GridView1.DataBind();
                GrdFooter.Visible = false;
                GnereateInvoive.Visible = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to Invoive Schedule", ex);
        }
    }

    protected void RdoNonSch_CheckedChanged(object sender, EventArgs e)
    {
        chkPreSch.Visible = true;
        lblPreSch.Visible = true;
        lblClientType.Visible = false;
        drpClientType.Visible = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
        GrdFooter.Visible = false;
        GnereateInvoive.Visible = false;
    }

    protected void RdoClient_CheckedChanged(object sender, EventArgs e)
    {
        chkPreSch.Visible = false;
        lblPreSch.Visible = false;
        lblClientType.Visible = false;
        drpClientType.Visible = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
        GrdFooter.Visible = false;
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
}
