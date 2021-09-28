using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Text;
using System.Drawing;

public partial class CommonControls_OrderSurgeryPkgItems : BaseControl
{
    
    long returnCode = -1;
    long VisitID = -1;
    long PatientID = -1;
    DateTime FromDate;
    DateTime Todate;
    int TotalDays;
    int PkgDays;
    string gUID = string.Empty;
    public string save_message=Resources.AppMessages.Save_Message ;
    //protected long _VisitID = 0;
    //protected long _PatientID = 0;

    List<SurgeryPackageItems> lstSurgeryPackageItems = new List<SurgeryPackageItems>();
    List<SurgeryPackageItems> lstSelectedSurgeryPKG = new List<SurgeryPackageItems>();

    //public long VisitID
    //{
    //    get { return _VisitID; }
    //    set { _VisitID = value; }
    //}

    //public long PatientID
    //{
    //    get { return _PatientID; }
    //    set { _PatientID = value; }
    //}


    protected void Page_Load(object sender, EventArgs e)
    {
        

    }


    public void GetOrderedSurgeryPkg()
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
        GetSurgeryPackage(OrgID, VisitID);       
      
    }


    public void GetSurgeryPackage(int OrgID, long VisitID)
    {
        returnCode = -1;
        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetSurgeryPackage(OrgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);
        if (lstSelectedSurgeryPKG.Count > 0)
        {
           // lblOSP.Visible = true;
            gvOrderedSurgeryPkg.DataSource = lstSelectedSurgeryPKG;
            gvOrderedSurgeryPkg.DataBind();
        }
    }

    protected void gvOrderedSurgeryPkg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtFromDate = (TextBox)e.Row.FindControl("txtFromDate");
            TextBox txtToDate = (TextBox)e.Row.FindControl("txtToDate");
            Button btnUpdate = (Button)e.Row.FindControl("btnUpdate");
           

            LinkButton lbtnFromDate = (LinkButton)e.Row.FindControl("lbtnFromDate");
            lbtnFromDate.Attributes.Add("onclick", "NewCal('" + txtFromDate.ClientID + "','ddmmyyyy',true,12)");

            LinkButton lbtnToDate = (LinkButton)e.Row.FindControl("lbtnToDate");
            lbtnToDate.Attributes.Add("onclick", "NewCal('" + txtToDate.ClientID + "','ddmmyyyy',true,12)");


            Label lblPackageID = (Label)e.Row.FindControl("lblPackageID");

            returnCode = -1;
            returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(Convert.ToInt64(lblPackageID.Text), VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);

            //if (lstSelectedSurgeryPKG.Count > 0)
            //{
            //    btnUpdate.Enabled = false;
            //}

        }

    }
    protected void gvOrderedSurgeryPkg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
        if (e.CommandName == "OEdit")
        {
           
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            long PackageID = -1;
            PackageID = Convert.ToInt32(gvOrderedSurgeryPkg.DataKeys[RowIndex][0]);
            returnCode = -1;
            returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(PackageID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);


            for (int i = 0; i <= gvOrderedSurgeryPkg.Rows.Count - 1; i++)
            {

                if (i == RowIndex)
                {
                    Button btnEdit = (Button)gvOrderedSurgeryPkg.Rows[RowIndex].FindControl("btnEdit");
                    btnEdit.ForeColor = Color.Red;
                }
                else
                {
                    Button btnEdit = (Button)gvOrderedSurgeryPkg.Rows[i].FindControl("btnEdit");
                    btnEdit.ForeColor = Color.White;
                   
                }
            }           
           
            if (lstSurgeryPackageItems.Count > 0)
            {
                trgvOrderedSurgeryPkg.Style.Add("display", "block");
                trSPID.Style.Add("display", "block");
                gvSPID.DataSource = lstSurgeryPackageItems;
                gvSPID.DataBind();
            }
        }
        else if (e.CommandName == "OUpdate")
        {

            trgvOrderedSurgeryPkg.Style.Add("display", "block");
            long PackageID = -1;

            int RowIndex = Convert.ToInt32(e.CommandArgument);
            PackageID = Convert.ToInt32(gvOrderedSurgeryPkg.DataKeys[RowIndex][0]);

            Label lblPkgDays1 = (Label)gvOrderedSurgeryPkg.Rows[RowIndex].FindControl("lblPkgDays1");

            TextBox txtFromDate = (TextBox)gvOrderedSurgeryPkg.Rows[RowIndex].FindControl("txtFromDate");
            TextBox txtToDate = (TextBox)gvOrderedSurgeryPkg.Rows[RowIndex].FindControl("txtToDate");

            if (txtFromDate.Text != "" && txtToDate.Text != "")
            {
                PkgDays = Convert.ToInt32(lblPkgDays1.Text);
                FromDate = Convert.ToDateTime(txtFromDate.Text);
                Todate = Convert.ToDateTime(txtToDate.Text);

            }
            else
            {
                string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_1";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Enter the From and To date');", true);

            }

            TimeSpan objTimeSpan = new TimeSpan();
            objTimeSpan = Todate.Subtract(FromDate);
            TotalDays = Convert.ToInt32(objTimeSpan.TotalDays+1);

            if (TotalDays > PkgDays)
            {
                string smg = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_7";
                smg = smg.Replace("{0}", PkgDays.ToString());
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ smg +"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This package day is " + PkgDays.ToString() + " enter correct from and to date');", true);
            }
            else if (TotalDays < PkgDays)
            {
                string smg = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_7";
                smg = smg.Replace("{0}", PkgDays.ToString());
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('" + smg + "');", true);
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This package day is " + PkgDays.ToString() + " enter correct from and to date');", true);
            }

            if (TotalDays == PkgDays)
            {
                returnCode = -1;
                returnCode = new SurgeryPackage_BL(base.ContextInfo).UpdateSurgerypkgDate(VisitID,PackageID, FromDate,Todate);

                if (returnCode == 0)
                {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ save_message +"');", true);

                }
            }

        
            
        }
    }
    protected void gvSPID_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);

        //GridViewRow rw = (GridViewRow)(((Button)e.CommandSource).NamingContainer);

        //GridViewRow r = (GridViewRow)((Button)e.CommandSource).NamingContainer;

        if (e.CommandName == "OADD")
        {
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            decimal PkgQty = 0;
            decimal TotalQty = 0;
            decimal OrderQty = 0;
            long PkgDetailID = 0;
            long PkgID = 0;
            long FeeID = 0;
            string pType=string.Empty;
            string FeeType = string.Empty;
            string ItemName = string.Empty;
            PkgDetailID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][0]);
            PkgID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][1]);           
            FeeType = gvSPID.DataKeys[RowIndex][3].ToString();
            FeeID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][4]);
            ItemName = gvSPID.DataKeys[RowIndex][5].ToString();
            PkgQty=Convert.ToDecimal(gvSPID.DataKeys[RowIndex][2]);   
            TextBox txtUpdateQty = (TextBox)gvSPID.Rows[RowIndex].FindControl("txtUpdateQty");
            TextBox txtUsedQty = (TextBox)gvSPID.Rows[RowIndex].FindControl("txtUsedQty");
            TextBox txtOrderedDate = (TextBox)gvSPID.Rows[RowIndex].FindControl("txtOrderedDate");

            if (txtUsedQty.Text != "" && txtUpdateQty.Text != "")
            {
                if (Convert.ToDecimal(txtUpdateQty.Text) == 0)
                {
                    txtUpdateQty.Text = "";
                    string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('"+ sPath +"');", true);
                }               
                else
                {
                    TotalQty = Convert.ToDecimal(txtUsedQty.Text) + Convert.ToDecimal(txtUpdateQty.Text);
                    OrderQty = Convert.ToDecimal(txtUpdateQty.Text);                   
                }
            }
            else if (txtUsedQty.Text == "" && txtUpdateQty.Text == "")
            {
                string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);


            }
            else if(txtUsedQty.Text != "" && txtUpdateQty.Text == "")
            {
                string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);

            }
           
            else if (txtUsedQty.Text == "" && txtUpdateQty.Text != "")
            {
                TotalQty = Convert.ToDecimal(txtUpdateQty.Text);
                OrderQty = Convert.ToDecimal(txtUpdateQty.Text);
            }



            if (OrderQty > 0)
            {
                if (TotalQty > PkgQty)
                {
                    string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_4";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('"+ sPath +"');", true);
                }
                else
                {
                    SurgeryPackageItems objSPI = new SurgeryPackageItems();
                    objSPI.PackageDetailsID = PkgDetailID;
                    objSPI.PackageID = PkgID;
                    objSPI.Quantity = OrderQty;                    
                    objSPI.ExpiryDate = Convert.ToDateTime("01/01/1753");
                    objSPI.Feetype = FeeType;
                    objSPI.OrderedDate =Convert.ToDateTime(txtOrderedDate.Text);
                    OrderedInvestigations objInvest = new OrderedInvestigations();

                    #region Get Ordered Investigation
                    if (FeeType == "INV" || FeeType == "GRP")
                    {
                        if (Convert.ToInt32(txtUpdateQty.Text) > 1)
                        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Only One Order can be placea at a time');", true);
                            txtUpdateQty.Text = "";    
                        }
                        else
                        {
                            gUID = string.Empty;
                            gUID = Guid.NewGuid().ToString();
                            objInvest.ID = FeeID;
                            objInvest.Name = ItemName;
                            objInvest.VisitID = VisitID;
                            objInvest.OrgID = OrgID;
                            objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                            objInvest.Status = "Paid";
                            objInvest.CreatedBy = LID;
                            objInvest.Type = FeeType;
                            objInvest.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            returnCode = new SurgeryPackage_BL(base.ContextInfo).SaveSurgeryPkgInTracker(VisitID, PatientID, LID, ILocationID, objSPI, pType, objInvest, gUID);
                            txtUpdateQty.Text = "";    

                        }
                    }

                    else
                    {
                        returnCode = new SurgeryPackage_BL(base.ContextInfo).SaveSurgeryPkgInTracker(VisitID, PatientID, LID, ILocationID, objSPI, pType, objInvest, gUID);
                        txtUpdateQty.Text = "";    

                    }
                    #endregion

                    int pOrderedInvCnt = 0;
                    int referedCount = 0;
                    long returnCodeINV = -1;
                               

                    #region referred investigation
                    if (returnCode == 0)
                    {
                        returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(VisitID, out referedCount, out pOrderedInvCnt); //returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out OrderedInvCnt);

                    }
                    #endregion


                    #region collect sample task
                    if (returnCode == 0)
                    {
                      
                        List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                        List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                        List<InvestigationValues> lstInvResult = new List<InvestigationValues>();

                        long createTaskID = -1;
                        Hashtable dText = new Hashtable();
                        Hashtable urlVal = new Hashtable();
                        Tasks task = new Tasks();
                        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(VisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

                        foreach (var item in lstSampleDept1)
                        {
                            if (item.Display == "Y")
                            {
                               
                                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(VisitID, out lstPatientVisitDetails);
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                             VisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                             , out dText, out urlVal, 0, "", 0,gUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = VisitID;
                                task.PatientID = PatientID;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                //Create task               
                                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                                break;

                            }
                        }
                        foreach (var item in lstSampleDept1)
                        {
                            if (item.Display == "Y")
                            {
                                InvestigationValues inValues = new InvestigationValues();
                                inValues.InvestigationID = item.InvestigationID;
                                inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                                inValues.PackageID = item.PackageID;
                                inValues.PackageName = item.PackageName;

                                lstInvResult.Add(inValues);
                            }
                        }

                        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(VisitID, "SampleReceived", OrgID, lstInvResult);
                    }
                     #endregion


                    if (returnCode == 0)
                    {
                        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(PkgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);

                        if (lstSurgeryPackageItems.Count > 0)
                        {
                            trSPID.Style.Add("display", "block");
                            gvSPID.DataSource = lstSurgeryPackageItems;
                            gvSPID.DataBind();
                        }

                       // GetSurgeryPackage(OrgID, VisitID); 
                    }
                }
            }
        }

        #region commented by sami
        //else if (e.CommandName == "Reduce")
        //{
            

        //    int RowIndex = Convert.ToInt32(e.CommandArgument);
        //    decimal PkgQty = 0;
        //    decimal TotalQty = -1;
        //    long PkgDetailID = 0;
        //    long PkgID = 0;
        //    long FeeID = 0;
        //    string pType = string.Empty;
        //    string FeeType = string.Empty;
        //    string ItemName = string.Empty;
        //    PkgDetailID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][0]);
        //    PkgID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][1]);
        //    FeeType = gvSPID.DataKeys[RowIndex][3].ToString();
        //    FeeID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][4]);
        //    ItemName = gvSPID.DataKeys[RowIndex][5].ToString();
        //    PkgQty = Convert.ToDecimal(gvSPID.DataKeys[RowIndex][2]);
        //    TextBox txtUpdateQty = (TextBox)gvSPID.Rows[RowIndex].FindControl("txtUpdateQty");
        //    TextBox txtUsedQty = (TextBox)gvSPID.Rows[RowIndex].FindControl("txtUsedQty");


        //    if (txtUsedQty.Text != "" && txtUpdateQty.Text != "")
        //    {
        //        if (Convert.ToDecimal(txtUpdateQty.Text) == 0)
        //        {
        //            txtUpdateQty.Text = "";
                //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Value must be greater than zero');", true);
        //        }
        //        else
        //        {
        //            if (Convert.ToDecimal(txtUpdateQty.Text) > Convert.ToDecimal(txtUsedQty.Text))
        //            {
        //                txtUpdateQty.Text = "";
                //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Entered Quantity is grater than used Quantity');", true);
        //            }
        //            else
        //            {
        //                TotalQty = Convert.ToDecimal(txtUsedQty.Text) - Convert.ToDecimal(txtUpdateQty.Text);
        //                txtUpdateQty.Text = "";
        //            }
        //        }
        //    }
        //    else if (txtUsedQty.Text == "" && txtUpdateQty.Text == "")
        //    {
                //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Enter The Quantity to be reduced');", true);


        //    }
        //    else if (txtUsedQty.Text != "" && txtUpdateQty.Text == "")
        //    {
                //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Enter The Quantity to be reduced');", true);

        //    }

        //    else if (txtUsedQty.Text == "" && txtUpdateQty.Text != "")
        //    {
                //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Not Possible to reduce the Quantity');", true);
        //    }


        //    if (TotalQty >= 0)
        //    {
                
        //            SurgeryPackageItems objSPI = new SurgeryPackageItems();
        //            objSPI.PackageDetailsID = PkgDetailID;
        //            objSPI.PackageID = PkgID;
        //            objSPI.Quantity = TotalQty;
        //            objSPI.ExpiryDate = Convert.ToDateTime("01/01/1753");

        //            if (FeeType == "INV" || FeeType == "GRP")
        //            {
        //                objSPI.Feetype = FeeType;
        //            }
        //            else
        //            {
        //                objSPI.Feetype = FeeType;
        //            }
        //            OrderedInvestigations objInvest = new OrderedInvestigations();

        //            returnCode = new SurgeryPackage_BL(base.ContextInfo).SaveSurgeryPkgInTracker(VisitID, PatientID, LID, ILocationID, objSPI, pType, objInvest);

        //            if (returnCode == 0)
        //            {
        //                returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(PkgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);

        //                if (lstSurgeryPackageItems.Count > 0)
        //                {
        //                    trSPID.Style.Add("display", "block");
        //                    gvSPID.DataSource = lstSurgeryPackageItems;
        //                    gvSPID.DataBind();
        //                }
        //            }

                
        //    }

        //}
        #endregion



        else if (e.CommandName == "Change")
        {
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            long PkgDetailID = 0;
            long PkgID = 0;

            PkgDetailID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][0]);
            PkgID = Convert.ToInt64(gvSPID.DataKeys[RowIndex][1]);

           returnCode=GetSurgeryPkgItemDetail(VisitID, PkgDetailID, PkgID);
            
           if (returnCode==1)
            {
                ModelPopUpPkgDetail.Show();
            }

        }
    }

    protected long GetSurgeryPkgItemDetail(long VisitID, long PkgDetailID, long PkgID)
    {
        returnCode = -1;
        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetSurgeryPkgItemDetail(VisitID, PkgDetailID, PkgID, out lstSurgeryPackageItems);


        if (lstSurgeryPackageItems.Count > 0)
        {
            gvItemDetails.DataSource = lstSurgeryPackageItems;
            gvItemDetails.DataBind();
            returnCode = 1;


        }
        return returnCode;
    }
    
    
    protected void gvSPID_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblDetailID = (Label)e.Row.FindControl("lblDetailID");
            TextBox txtUsedQty = (TextBox)e.Row.FindControl("txtUsedQty");
            Label lblFeeType = (Label)e.Row.FindControl("lblFeeType");
            Button btnReduce = (Button)e.Row.FindControl("btnReduce");

            //if (lblFeeType.Text == "INV" || lblFeeType.Text == "GRP")
            //{
            //    btnReduce.Enabled = false;
            //}        

            TextBox txtOrderedDate = (TextBox)e.Row.FindControl("txtOrderedDate");

            txtOrderedDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss");


            LinkButton lbtnOrderedDate = (LinkButton)e.Row.FindControl("lbtnOrderedDate");
            lbtnOrderedDate.Attributes.Add("onclick", "NewCal('" + txtOrderedDate.ClientID + "','ddmmyyyy',true,12)");

            foreach (SurgeryPackageItems objOrderesSPI in lstSelectedSurgeryPKG)
            {
                if (objOrderesSPI.DetailsID == Convert.ToInt64(lblDetailID.Text))
                {

                    txtUsedQty.Text = objOrderesSPI.UsedQuantity.ToString();

                }              


            }
            

        }

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
    protected void gvItemDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);

        if (e.CommandName == "OReduce")
        {
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            long TrackerID = 0;
            TrackerID = Convert.ToInt64(gvItemDetails.DataKeys[RowIndex][0]);

            long PkgDetailID = Convert.ToInt64(gvItemDetails.DataKeys[RowIndex][1]);
            long PkgID = Convert.ToInt64(gvItemDetails.DataKeys[RowIndex][7]);           

           
            TextBox txtOrderedDateR = (TextBox)gvItemDetails.Rows[RowIndex].FindControl("txtOrderedDateR");
            TextBox txtUpdateQtyR = (TextBox)gvItemDetails.Rows[RowIndex].FindControl("txtUpdateQtyR");
            TextBox txtUsedQtyR = (TextBox)gvItemDetails.Rows[RowIndex].FindControl("txtUsedQtyR");           
            
            if (txtUpdateQtyR.Text == "")
            {
                string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_5";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('"+ sPath +"');", true);
                ModelPopUpPkgDetail.Show();
                txtUpdateQtyR.Focus();

            }
            else if (Convert.ToDecimal(txtUpdateQtyR.Text) > Convert.ToDecimal(txtUsedQtyR.Text))
            {
                string sPath = "CommonControls\\\\OrderSurgeryPkgItems.ascx.cs_6";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);
                ModelPopUpPkgDetail.Show();
               
            }
            else
            {

                returnCode = UpdateSurgeryPkgTrackerQty(TrackerID, VisitID, Convert.ToDecimal(txtUpdateQtyR.Text), Convert.ToDateTime(txtOrderedDateR.Text));

                if (returnCode == 1)
                {
                    returnCode = GetSurgeryPkgItemDetail(VisitID, PkgDetailID, PkgID);

                    if (returnCode == 1)
                    {
                        returnCode = -1;
                        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(PkgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);
                        if (lstSurgeryPackageItems.Count > 0)
                        {
                            gvSPID.DataSource = lstSurgeryPackageItems;
                            gvSPID.DataBind();
                        }
                        ModelPopUpPkgDetail.Show();                     

                    }
                }
            }



            
        }        

    }

    protected long UpdateSurgeryPkgTrackerQty(long TrackerID, long VisitID,decimal UpdateQty,DateTime OrderedDate)
    {
        returnCode = -1;
        returnCode = new SurgeryPackage_BL(base.ContextInfo).UpdateSurgeryPkgTrackerQty(TrackerID, VisitID, UpdateQty, OrderedDate);

        if (returnCode == 0)
        {
            returnCode = 1;
        }

        return returnCode;
    }

    protected void gvItemDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {           

            //TextBox txtOrderedDateR = (TextBox)e.Row.FindControl("txtOrderedDateR");  

            //LinkButton lbtnOrderedDateR = (LinkButton)e.Row.FindControl("lbtnOrderedDateR");
          

            //lbtnOrderedDateR.OnClientClick="NewCal('" + txtOrderedDateR.ClientID + "','ddmmyyyy',true,12)";
        }
    }


    public void lbtnClick(object test,EventArgs e)
    {
        ModelPopUpPkgDetail.Show();
    }
    public void GetSurgeryPackageIP(List<SurgeryPackageItems> lstSelectedSurgeryPKGIP)
    {
        if (lstSelectedSurgeryPKG.Count > 0)
        {
            gvOrderedSurgeryPkg.DataSource = lstSelectedSurgeryPKGIP;
            gvOrderedSurgeryPkg.DataBind();
        }
    }

}
