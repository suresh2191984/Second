using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using Attune.Podium.BusinessEntities.CustomEntities;
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;
using Microsoft.Reporting.WebForms;

public partial class Waters_QuotationMaster : BasePage
{

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    public Waters_QuotationMaster()
        : base("Waters_QuotationMaster_aspx")
    {
    }



    string sSlabDiscount = string.Empty;
    string pathname = string.Empty;


    long returncode = -1;
    string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03;
    string WinAlert = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10 == null ? "Alert" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10;

    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString();
        if (!IsPostBack)
        {
            Loadcountries();
            hndLocationID.Value = ILocationID.ToString();
            AutoAuthorizer.ContextKey = OrgID.ToString();
            
            LoadQuotationDiscount();
            LoadReasonList();
            LoadTax();
            LoadMeatData();

            sSlabDiscount = GetConfigValue("IsSlabDiscount", OrgID);
            if (sSlabDiscount != "")
            {
                hdnIsSlabDiscount.Value = sSlabDiscount;


            }

            hdnCurrentDate.Value = DateTime.Today.ToString("dd/MM/yyyy");
            txtValidityPeriod.Text = DateTime.Today.AddDays(+30).ToString("dd/MM/yyyy");
            hdnFutureDate.Value = txtValidityPeriod.Text;
            chkSameAddress.Checked = true;
           hdnDefaultRoundoff.Value=GetConfigValue("RoundOffTPAAmt", OrgID);
           hdnRoundOffType.Value=GetConfigValue("TPARoundOffPattern", OrgID);
            trSameBIllingAddrOne.Style.Add("display", "none");
            trSameBIllingAddrTwo.Style.Add("display", "none");
            txtTestName.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
            txtClientName.Attributes.Add("onkeydown", "return (event.keyCode!=13);");






        }
        string gender = "M";
        string FeeType = "COM";
        AutoCompleteExtenderClientName.ContextKey = OrgID.ToString();
        AutoCompleteExtender3.ContextKey = FeeType + "~" + OrgID.ToString() + "~" + 0.ToString() + "~" + hndLocationID.Value.ToString() + "~" + gender;
        AutoCompleteExtenderQuotationNo.ContextKey = OrgID.ToString() + "~" +"QUO";

    }


    private void LoadQuotationDiscount()
    {
        long retcode = -1;
        Patient_BL paBL = new Patient_BL(base.ContextInfo);
        List<DiscountMaster> getDiscount = new List<DiscountMaster>();
        retcode = paBL.GetLabDiscount(OrgID, out getDiscount);
        if (retcode == 0)
        {
            var lstDiscount = from n in getDiscount
                              select new
                              {  //DiscountName = n.DiscountName + "~" + n.Discount,
                                  //DiscountPercentage = n.DiscountPercentage,
                                  DiscountName = n.DiscountName,
                                  Discount = n.Discount,
                                  DiscountReason = n.DiscountReason
                              };
            ddDiscountPercent.DataSource = lstDiscount;
            ddDiscountPercent.DataTextField = "DiscountName";
            ddDiscountPercent.DataValueField = "DiscountReason";
            ddDiscountPercent.DataBind();
            ddDiscountPercent.Items.Insert(0, strSelect);
            ddDiscountPercent.Items[0].Value = "0";

        }




    }
    private void LoadReasonList()
    {
        try
        {
            long returnCode = -1;
            List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
            Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
            returnCode = objReasonMaster.GetReasonMaster(0, 0, "DIS", out lstReasonMaster);
            if (hdnIsSlabDiscount.Value == "Y")
            {
                ddlDiscountReason.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));

            }
            else
            {
                if (lstReasonMaster.Count > 0)
                {
                    ddlDiscountReason.DataSource = lstReasonMaster;
                    ddlDiscountReason.DataTextField = "Reason";
                    ddlDiscountReason.DataValueField = "ReasonCode";
                    ddlDiscountReason.DataBind();
                    ddlDiscountReason.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
                    ddlDiscountReason.Items[0].Value = "0";
                }
                else
                {
                    ddlDiscountReason.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LabQuickBilling_ReasonMaster LoadReasonList()", ex);
        }
    }
    private void LoadTax()
    {

        long returnCode = -1;
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        Master_BL masterBL = new Master_BL(base.ContextInfo);
        returnCode = masterBL.GetTaxMaster(OrgID, out lstTaxmaster);
        if (lstTaxmaster.Count > 0)
        {
            lstTaxmaster.RemoveAll(p => p.ReferenceName != "Bill");
            var lstTax = from n in lstTaxmaster
                         select new
                         {
                             TaxName = n.TaxName + "~" + n.TaxPercent,
                             TaxPercent = n.TaxPercent
                         };

            ddlTaxPercent.DataSource = lstTax;
            ddlTaxPercent.DataTextField = "TaxName";
            ddlTaxPercent.DataValueField = "TaxPercent";
            ddlTaxPercent.DataBind();
            ddlTaxPercent.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
            ddlTaxPercent.Items[0].Value = "0";
        }
        else
        {
            ddlTaxPercent.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
        }
    }

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DiscountType,ClientSource,ProtocalGroup_Based";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DiscountType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDiscountType.DataSource = childItems;
                    ddlDiscountType.DataTextField = "DisplayText";
                    ddlDiscountType.DataValueField = "Code";
                    ddlDiscountType.DataBind();
                    ddlDiscountType.Items.Insert(0, strSelect);
                    ddlDiscountType.Items[0].Value = "0";
                    PopupDiscountType.DataSource = childItems;
                    PopupDiscountType.DataTextField = "DisplayText";
                    PopupDiscountType.DataValueField = "Code";
                    PopupDiscountType.DataBind();
                    PopupDiscountType.Items.Insert(0, strSelect);
                    PopupDiscountType.Items[0].Value = "0";

                }
                var childItems1 = from child in lstmetadataOutput
                                 where child.Domain == "ClientSource"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    ddlClientSource.DataSource = childItems1;
                    ddlClientSource.DataTextField = "DisplayText";
                    ddlClientSource.DataValueField = "Code";
                    ddlClientSource.DataBind();
                    ddlClientSource.Items.Insert(0, strSelect);
                    ddlClientSource.Items[0].Value = "0";

                }
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "ProtocalGroup_Based" && child.Code == "Water" || child.Code == "Food"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddSampleType.DataSource = childItems2;
                    ddSampleType.DataTextField = "DisplayText";
                    ddSampleType.DataValueField = "Code";
                    ddSampleType.DataBind();
                    ddSampleType.Items.Insert(0, strSelect);
                    ddSampleType.Items[0].Value = "0";

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {

        string ClientName = "";
        string ClientSource = "";
        string Others = "";
        string SameBillingAddress = "";
        string SalesPerson = "";
        string branch = "";
        string Remarks = "";
        string Mobile = txtMobileNo.Text;
        string Phone = txtTelephoneNo.Text;
        string Sms = "";
        string Email = "";
        int Orgid = OrgID;
        string ClientID = "";
        string TRF = "";
        string IsFileUpload;
        DateTime Validity;
        DateTime ValidTo;    
        ValidTo = (txtValidityPeriod.Text.Trim().ToLower() == "dd/mm/yyyy" || txtValidityPeriod.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtValidityPeriod.Text.Trim()); 
        Validity = DateTime.Today;
        string Address = "";
        string Suburb = "";
        string City = "";
        string State = "";
        string Country = "";
        string Pincode = "";
        string TempAddress = "";
        string TempSuburb = "";
        string TempCity = "";
        string TempState = "";
        string TempCountry = "";
        string TempPincode = "";
        string EmailID = "";
        string IsExpired = "";
        if (!String.IsNullOrEmpty(txtClientName.Text) && txtClientName.Text.Length > 0)
        {
            ClientName = txtClientName.Text;
        }
        ClientSource = ddlClientSource.SelectedItem.Value;
        Others = txtOthers.Text;
        SalesPerson = txtSalesPerson.Text;
        branch = txtBranch.Text;
        Remarks = txtRemarks.Text;
        ClientID = hdnSelectedClientClientID.Value;
        Address = txtAddress.Text;
        Suburb = txtSuburb.Text;
        City = txtCity.Text;
        State = ddState.Value;
        Country = ddCountry.SelectedItem.Value;
        Pincode = txtPincode.Text;
        EmailID = txtEmailID.Text;
        if (FileUpload1.HasFile)
        {
            IsFileUpload = "Y";

        }
        else
        {

            IsFileUpload = "N";

        }

        if (chkSameAddress.Checked)
        {

            SameBillingAddress = "Y";
            TempAddress = Address;
            TempSuburb = Suburb;
            TempCity = City;
            TempState = State;
            TempCountry = Country;
            TempPincode = Pincode;


        }
        else
        {

            SameBillingAddress = "N";
            TempAddress = txtAddress1.Text;
            TempSuburb = txtSuburb1.Text;
            TempCity = txtCity1.Text;
            TempState = ddState1.Value;
            TempCountry = ddCountry1.SelectedItem.Value;
            TempPincode = txtPincode1.Text;

        }

        if (chkSMS.Checked == true)
        {
            Sms = "Y";

        }
        else
        {

            Sms = "N";

        }


        if (chkEmail.Checked == true)
        {
            Email = "Y";

        }
        else
        {

            Email = "N";

        }

        long QuotationID=0 ;
        string QuotationNo="";
        if (hdnPendingQuotation.Value == "Y" && hdnIsExpired.Value!="Y")
        {
            QuotationID = Convert.ToInt64(hdnSelectedQuotationID.Value);
            QuotationNo = hdnSelectedQuotationNo.Value;
        
        
        }
        if (hdnPendingQuotation.Value != "Y" || hdnIsExpired.Value == "Y")
        {
            QuotationID = 0;
            QuotationNo = "";
            Waters_BL waterBL = new Waters_BL(base.ContextInfo);

            if (hdnTempTest.Value != "")
            {
                returncode = waterBL.SaveQuotationMasterDetails(ClientID, ClientName, ClientSource, SameBillingAddress, SalesPerson, branch, Remarks, Sms, Email, IsFileUpload, OrgID, Validity, Address, Suburb, City, State, Country, Pincode, TempAddress, TempSuburb, TempCity, TempState, TempCountry, TempPincode, ValidTo, Mobile, Phone, Others, EmailID, out QuotationID, out  QuotationNo);
            }
            if (QuotationID == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Error While Saving..." + QuotationNo + "','" + WinAlert + "');", true); 
            
            }

            if (QuotationID != 0)
            {
                SaveTRFPicture(QuotationID, QuotationNo);
            }
            if (chkEmail.Checked == true && EmailID !="")
            {
                SendEmail(QuotationID);
            }

            if (chkSMS.Checked == true && Mobile !="")
            {
                SendSms(QuotationID);

            }


        }

        if (QuotationID != 0)
        {
            SaveQuotationBill(QuotationID, QuotationNo);
            SavePreQuotationInvestigations(QuotationID);
            if(hdnIsExpired.Value =="Y")
            {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Quotation Generated.Quotation Number:" + QuotationNo + "','" + WinAlert + "');", true);
            }
            else if (hdnIsExpired.Value == "N")
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Quotation is Updated.Quotation Number:" + QuotationNo + "','" + WinAlert + "');", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Quotation Generated.Quotation Number:" + QuotationNo + "','" + WinAlert + "');", true);
            }
            
        }
        clearitems();

        string sPage12 = string.Empty;
       

        //sPage12 = "../Waters/QuotationFormat.aspx?Qid=" + QuotationID.ToString()
        //            + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=../Waters/QuotationMaster.aspx"; 

        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint('" + sPage12 + "');", true);
        //Response.Redirect(Request.ApplicationPath + sPage12, true);

        long loginID =  Convert.ToInt64(LID);
       int AddressID = Convert.ToInt32(ILocationID);

        //long visitID, int pOrgid, long loginID, int AddressID
        ShowBill(QuotationID,OrgID,loginID,AddressID);
        ModalPopupExtenderBill.Show();

    }


    private long SaveTRFPicture(long QuotationID, String QuotationNo)
    {
        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        try
        {
            //Modified / By Arivalagan K//

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;

            //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf

            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root = "TRF_Upload-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + QuotationNo + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///


            HttpFileCollection hfc = TRFFiles();

            for (int i = 0; i < hfc.Count; i++)
            {
                if (hfc.AllKeys[i] == "FileUpload1")
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                        string fileExtension = Path.GetExtension(hpf.FileName);
                        //string imagePathname = ConfigurationManager.AppSettings["UploadPath"];
                        //string imagePath = imagePathname + pathname;
                        //string imagePath = pathname;
                        string picNameWithoutExt = 0 + '_' + QuotationID + '_' + OrgID + '_' + fileName;
                        string pictureName = string.Empty;
                        string filePath = string.Empty;
                        Response.OutputStream.Flush();
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        string[] fileNames = Directory.GetFiles(RootPath, picNameWithoutExt + ".*");
                        foreach (string path in fileNames)
                        {
                            File.Delete(path);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = picNameWithoutExt + ".jpg";

                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;

                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(hpf.InputStream);
                            int srcWidth = image.Width;
                            int srcHeight = image.Height;
                            if (thumbWidth > srcWidth)
                                thumbWidth = srcWidth;
                            if (thumbHeight > srcHeight)
                                thumbHeight = srcHeight;
                            Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                            System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                            System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                            gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                            //bmp.Save(filePath, ImageFormat.Jpeg);

                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            // hpf.SaveAs(filePath,ImageFormat.Jpeg);
                            //hdnPatientImageName.Value = pictureName;
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                        }
                        else
                        {
                            pictureName = picNameWithoutExt + fileExtension;
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            hpf.SaveAs(filePath);
                        }
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = 0;
                        int Vid = unchecked((int)QuotationID);//Int32.Parse(QuotationID);
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload", Root, LID, dt, "Y",0);
                        //hdnPatientImageName.Value = pictureName;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveTRFPicture() in Lab Quick Billing", ex);

        }
        return returncode;

    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }

    public void SendSms(long QuotationID)
    {
        try
        {

            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
            PC.ButtonName = "SendQRegSms";
            PC.ButtonValue = "SendQRegSms";
            PC.PatientVisitID = QuotationID;
            lstpagecontextkeys.Add(PC);
            long res = -1;

            res = AM.PerformingNextStepNotification(PC, "", "");


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Send SendSms", ex);
        }

    }

    public void SendEmail(long QuotationID)
    {
        try
        {          
            
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
            PC.ButtonName = "SendQRegMail";
            PC.ButtonValue = "SendQRegMail";
            PC.PatientVisitID = QuotationID;
            lstpagecontextkeys.Add(PC);
            long res = -1;

            res = AM.PerformingNextStepNotification(PC, "", "");              

           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Send SendMail", ex);
        }
    }

    public void SaveQuotationBill(long QuotationID, String QuotationNo)
    {
        string IsPendingQuotation = hdnPendingQuotation.Value;
        string IsExpired = hdnIsExpired.Value;
        string isFOC = string.Empty;
        decimal DiscountAmt;
        string PreDiscountCode;
        string[] Discount=null;
        string DiscountCode = "";
        if (hdnTotalDiscount.Value != "")
        {
            DiscountAmt = decimal.Parse(hdnTotalDiscount.Value);
        }
        else
        { DiscountAmt = 0; }

        if (ddDiscountPercent.SelectedItem.Text != strSelect)
        {

            PreDiscountCode = ddDiscountPercent.SelectedItem.Value;
            Discount = PreDiscountCode.Split('~');
            DiscountCode = Discount[2];

        }
        else
        { DiscountCode = "0"; }
        string DiscountReason = ddlDiscountReason.SelectedItem.Value;
        string AuthorizeBy = hdnDiscountApprovedBy.Value;
        string TaxDetails = string.Empty;
        string[] Tax = null;
        string TaxName = string.Empty;
        if (ddlTaxPercent.SelectedItem.Text != strSelect)
        {
            TaxDetails = ddlTaxPercent.SelectedItem.Text;
            Tax = TaxDetails.Split('~');
            TaxName = Tax[0];
        }
        else
        {
            TaxName = "";

        }
        decimal DiscountPercent;
        if (hdnTotalDiscount.Value != "")
        {
            DiscountPercent = decimal.Parse(hdnDiscountPercent.Value);
        }
        else
        { DiscountPercent = 0; }


        string FOCRemark = txtFoc.Text;
        decimal Gross = decimal.Parse(txtGross.Text);
        decimal TaxAmt = decimal.Parse(txtTax.Text);
        decimal RoundOff = decimal.Parse(txtRoundoffAmt.Text);
        decimal NetAmt = decimal.Parse(txtNetAmount.Text);
        string Status = "Pending";
        Waters_BL waterBL = new Waters_BL(base.ContextInfo);

        if (chkFoc.Checked == true)
        {
            isFOC = "Y";


        }
        else
        {

            isFOC = "N";
        }
        returncode = waterBL.SaveQuotationBill(QuotationID, isFOC, FOCRemark, DiscountCode, DiscountAmt, DiscountPercent, DiscountReason, AuthorizeBy, TaxName, Gross, TaxAmt, RoundOff, NetAmt, Status, IsPendingQuotation, IsExpired);

    }

    public void SavePreQuotationInvestigations(long QuotationID)
    {

        List<PreQuotationInvestigationsCustom> Prelist = new List<PreQuotationInvestigationsCustom>();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        if (hdnTempTest.Value != "")
        {
            string Testlist = hdnTempTest.Value;
            Prelist = serializer.Deserialize<List<PreQuotationInvestigationsCustom>>(Testlist);
            Waters_BL waterBL = new Waters_BL(base.ContextInfo);
            returncode = waterBL.SavePreQuotationInvestigations(QuotationID, Prelist);
        }





    }

    public void clearitems()
    {
        hdnPendingQuotation.Value = "";
        hdnAppendTest.Value = "";
        txtClientName.Text = "";
        txtAddress.Text = "";
        divGrid.InnerHtml = "";
        hdnTempTest.Value = "";
        ddlClientSource.SelectedValue = "0";
        txtSuburb.Text = "";
        txtEmailID.Text = "";
        txtMobileNo.Text = "";
        txtTelephoneNo.Text = "";
        txtAddress.Text = "";
        txtCity.Text = "";
        txtAddress1.Text = "";
        txtCity1.Text = "";
        txtSuburb1.Text = "";
        txtPincode1.Text = "";
        txtPincode.Text = "";
        txtSalesPerson.Text = "";
        txtBranch.Text = "";
        txtRemarks.Text = "";
        ddDiscountPercent.SelectedValue = "0";
        ddlTaxPercent.SelectedValue = "0";
        ddlDiscountReason.SelectedValue = "0";
        txtQuotationNumber.Text = "";
        hdnTestQuotationList.Value = "";
        txtGross.Text = "0.00";
        txtNetAmount.Text = "0.00";
        txtTax.Text = "0.00";
        txtRoundoffAmt.Text = "0.00";
        ddCountry.SelectedValue = "75";
        ddCountry1.SelectedValue = "75";
        ddState.Value = "31";
        ddState1.Value = "31";
        hdnSelectedClientClientID.Value = "0";
        hdnIsExpired.Value = "";
        hdnPKGUpdateList.Value = "";
        hdnOrdereditems.Value = "";
        // document.getElementById('divGrid').innerHTML="";
        divGrid.InnerHtml="";
        hdnID.Value = "";
        hdnName.Value = "";
        hdnFeeTypeSelected.Value = "";
        hdnInvCode.Value = "";
        hdnIsOutSource.Value = "";
        hdnoutsourcelocation.Value = "";
        hdnNewAmount.Value = "";
        hdnLoadPkgID.Value = "";
        hdnPopUpPkgID.Value = "";
        txtValidityPeriod.Text = DateTime.Today.AddDays(+15).ToString("dd/MM/yyyy");
        txtFoc.Text = "";
        btnFinish.Text = "Generate Quotation";
        chkFoc.Checked = false;
        chkSameAddress.Enabled = true;
        chkSameAddress.Checked = true;
    }

    public void Loadcountries()
    {
        List<Country> lstCountries = new List<Country>();
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        int countryID = 0;
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        
        try
        {
            ddCountry.DataSource = lstCountries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            ddCountry.Items.Insert(0, strSelect);
            ddCountry.Items[0].Value = "0";
            selectedCountry = lstCountries.Find(FindCountry);
            

            if (CountryID > 0)
            {
                ddCountry.SelectedValue = CountryID.ToString();
            }
            else
            {
                ddCountry.SelectedItem.Value = selectedCountry.CountryID.ToString();
            }
            //ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            
            ddCountry1.DataSource = lstCountries;
            ddCountry1.DataTextField = "CountryName";
            ddCountry1.DataValueField = "CountryID";
            ddCountry1.DataBind();
            ddCountry1.Items.Insert(0, strSelect);
            ddCountry1.Items[0].Value = "0";
            //selectedCountry = lstCountries.Find(FindCountry);


            if (CountryID > 0)
            {
                ddCountry1.SelectedValue = CountryID.ToString();
            }
            else
            {
                ddCountry1.SelectedItem.Value = selectedCountry.CountryID.ToString();
            }
            //ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            Int32.TryParse(ddCountry1.SelectedItem.Value, out countryID);
            LoadState(countryID);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }



    }
    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);

            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName, st.StateID.ToString()));

                ddState1.Items.Add(new ListItem(st.StateName, st.StateID.ToString()));
            }

            selectedState = states.Find(FindState);
            if (StateID > 0)
            {
                ddState.Value = StateID.ToString();
                ddState1.Value = StateID.ToString();
            }
            else
            {
                ddState.Value = selectedState.StateID.ToString();
                ddState1.Value = selectedState.StateID.ToString();
            }
            Int32.TryParse(ddState.Value, out stateID);
            Int32.TryParse(ddState1.Value, out stateID);
            hdnPatientStateID.Value = StateID.ToString();
            hdnPatientStateID1.Value = StateID.ToString();
            //hdnDefaultStateID.Value = selectedState.StateID.ToString();
            //Int32.TryParse(, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }
    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {

            return true;
        }
        return false;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {




        clearitems();
    
    
    
    }

    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            //else
            //    CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void ShowBill(long visitID, int pOrgid, long loginID, int AddressID)
    {
        try
        {

            rReportViewer.Visible = false;
            int PatientId = -1;
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = GetConfigValue("WatersReportPath", OrgID); 
            rReportViewer.ShowParameterPrompts = false;
            {
                rReportViewer.ShowPrintButton = true;
            }



            connectionString = Utilities.GetConnectionString();

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(pOrgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(AddressID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("pLoginID", Convert.ToString(loginID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            //reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            //reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            //reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = rReportViewer.ServerReport.GetParameters();
            
            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();
            
            //rReportViewer.ServerReport.SetParameters(lstParameter);
            rReportViewer.ServerReport.SetParameters(reportParameterList);
           // rReportViewer.AsyncRendering = false;
            //rReportViewer.ServerReport.Refresh();
            rReportViewer.Visible = true;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
}
