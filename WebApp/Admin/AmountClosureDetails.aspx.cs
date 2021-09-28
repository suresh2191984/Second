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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;


public partial class Admin_AmountClosureDetails : BasePage
{
    public Admin_AmountClosureDetails()
        : base("Admin\\AmountClosureDetails.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<AmountClosureDetails> ListAmountClosureDetails = new List<AmountClosureDetails>();
    AmountReceived_BL AmountReceived = new AmountReceived_BL();
    string GetAll = "All";
    DateTime FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSumAmountclosureDetails(GetAll, FromDate, ToDate);
        }
        txtFromDate.Focus();
        ScriptManager2.RegisterPostBackControl(btnsubmit);
    }
    public void LoadSumAmountclosureDetails(string GetAll, DateTime FromDate, DateTime ToDate)
    {
        try
        {
            AmountReceived.GetSumAmountclosureDetails(GetAll, FromDate, ToDate, out ListAmountClosureDetails);
            if (ListAmountClosureDetails.Count > 0)
            {
                grdAmountClosureDetails.Visible = true;
                grdAmountClosureDetails.DataSource = ListAmountClosureDetails;
                grdAmountClosureDetails.DataBind();
            }
            else
            {
                grdAmountClosureDetails.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSumAmountclosureDebitDetails - AmountclosureDebitDetails.aspx", ex);
        }
    }
    public void clear()
    {
        chkPending.Checked = true;
        txtFromDate.Text = "";
        txtToDate.Text = "";
        txtTotalAmount.Text = "0.00";
        txtDebitAmount.Text = "0.00";
        txtDepositDate.Text = "";
        txtDesc.Text = "";
        ChkTRFImage.Checked = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            txtTotalAmount.Text = hdnTotalAmount.Value;
            decimal TotalAmount = 0;
            decimal DebitedAmount = 0;
            if (txtTotalAmount.Text != "")
                TotalAmount = Convert.ToDecimal(txtTotalAmount.Text);
            if (txtDebitAmount.Text != "")
                DebitedAmount = Convert.ToDecimal(txtDebitAmount.Text);
            DateTime DebitedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            if (txtDepositDate.Text != "")
            {
                DebitedDate = Convert.ToDateTime(txtDepositDate.Text);
            }
            string Description = txtDesc.Text;
            int CreateBy = Convert.ToInt16(LID);
            string Attachment = "";
            long returnCode = -1;
            int GetMaxACDID = -1;
            string GetACDId = hdnACDId.Value;
            List<AmountClosureDetails> ListAmountClosureDetails = new List<AmountClosureDetails>();
            //if (DebitedAmount == 0)
            //{
            //    ChkTRFImage.Checked = false;
            //    lblmsg.ForeColor = Color.Red;
            //    lblmsg.Text = "Please check the debitamount";
            //    return;
            //}
            //else if (DebitedAmount < TotalAmount)
            //{
            //    ChkTRFImage.Checked = false;
            //    lblmsg.ForeColor = Color.Red;
            //    lblmsg.Text = "Please check the debitamount and Totalamount";
            //    return;
            //}
            //else
            //{
            //foreach (GridViewRow row in grdAmountClosureDetails.Rows)
            //{
            //    HtmlInputCheckBox htchk = (HtmlInputCheckBox)row.FindControl("chkSelect");
            //    if (htchk.Checked == true)
            //    {
            //        string GetId = grdAmountClosureDetails.DataKeys[row.RowIndex].Values[0].ToString();
            //        if (GetACDId == "")
            //        {
            //            GetACDId = GetId;
            //        }
            //        else
            //        {
            //            GetACDId = GetACDId + "," + GetId;
            //        }
            //    }
            //}
            //  }

            if (GetACDId != "")
            {
                returnCode = AmountReceived.UpdateAmountClosureDetails(GetACDId, TotalAmount, DebitedAmount, DebitedDate, Description, OrgID, CreateBy, out GetMaxACDID);
                if (returnCode == 0)
                {
                    if (ChkTRFImage.Checked == true)
                    {
                        hdnReferenceID.Value = GetMaxACDID.ToString();
                        TRFImageUpload.btnUpload_Click(sender, e);
                    }
                    lblmsg.Text = "AmountClosureDetails Added sucessfully";
                }
                else
                {
                    lblmsg.ForeColor = Color.Red;
                    lblmsg.Text = "AmountClosureDetails Added Failed";
                }

                LoadSumAmountclosureDetails(GetAll, FromDate, ToDate);
                clear();
            }
            else
            {
                clear();
                lblmsg.ForeColor = Color.Red;
                lblmsg.Text = "Please Select DepositUsers";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveAmountclosureDebitDetails - AmountclosureDebitDetails.aspx", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtFromDate.Text != "" && txtToDate.Text != "")
            {
                chkPending.Checked = false;
                FromDate = Convert.ToDateTime(txtFromDate.Text);
                ToDate = Convert.ToDateTime(txtToDate.Text);
                GetAll = "";
                LoadSumAmountclosureDetails(GetAll, FromDate, ToDate);
            }
            else
            {
                chkPending.Checked = true;
                GetAll = "All";
                LoadSumAmountclosureDetails(GetAll, FromDate, ToDate);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchAmountclosureDebitDetails - AmountclosureDebitDetails.aspx", ex);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            clear();
            lblmsg.Text = "";
            GetAll = "All";
            LoadSumAmountclosureDetails(GetAll, FromDate, ToDate);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ClearAmountclosureDebitDetails - AmountclosureDebitDetails.aspx", ex);
        }

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - AmountclosureDebitDetails.aspx", ex);
        }
        return configValue;
    }
    protected void DebitFileUpload_Click(object sender, FileUploadCollectionEventArgs e)
    {
        try
        {
            int ReferenceId = Convert.ToInt16(hdnReferenceID.Value);
            string RefFileType = "Billing";
            long returncode = -1;
            string pathname = GetConfigValue("AmountDepositDetails_TRF", OrgID);
            if (!Directory.Exists(pathname))
            {
                Directory.CreateDirectory(pathname);
            }
            HttpFileCollection oHttpFileCollection = e.PostedFiles;
            HttpPostedFile oHttpPostedFile = null;
            if (e.HasFiles)
            {
                for (int n = 0; n < e.Count; n++)
                {
                    oHttpPostedFile = oHttpFileCollection[n];
                    if (oHttpPostedFile.ContentLength <= 0)
                        continue;
                    else
                    {
                        string imagePath = pathname;
                        string FileType = string.Empty;
                        string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                        string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                        string picNameWithoutExt = ReferenceId.ToString() + '_' + +OrgID;
                        string pictureName = ReferenceId.ToString() + '_' + OrgID + '_' + Picture;
                        string NotImageFormat = ReferenceId.ToString() + '_' + OrgID + '_' + FullName;
                        string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                        string filePath = imagePath + NotImageFormat;
                        foreach (string str in hdnFileValue.Value.Trim().Split('^'))
                        {
                            string[] FileName = str.Split('~');

                            if (FullName == FileName[0])
                            {
                                FileType = FileName[1];
                            }
                        }
                        Response.OutputStream.Flush();
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        int CreateAt = Convert.ToInt32(LID);
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = pictureName + ".jpg";
                            filePath = imagePath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(oHttpPostedFile.InputStream);
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
                            bmp.Save(filePath, ImageFormat.Jpeg);
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();

                            returncode = AmountReceived.SaveInsertClosureDptAttachmentDetails(pictureName, FullName, ReferenceId, FileType, RefFileType, OrgID, CreateAt);
                        }
                        else
                        {
                            oHttpPostedFile.SaveAs(filePath);
                            returncode = AmountReceived.SaveInsertClosureDptAttachmentDetails(pictureName, FullName, ReferenceId, FileType, RefFileType, OrgID, CreateAt);

                        }

                        if (returncode >= 0)
                        {
                            divUpload.Style.Add("Display", "none");
                        }
                    }
                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UploadAmountclosureDebitDetails - AmountclosureDebitDetails.aspx", ex);
        }
    }

}
