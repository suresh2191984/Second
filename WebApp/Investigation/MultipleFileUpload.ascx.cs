using System;
using System.Data;
using System.Collections.Generic;
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
using Attune.Podium.Common;
using System.Linq;
using Attune.Solution.DAL;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Net;

public partial class Investigation_MultipleFileUpload : BaseControl
{
    public Investigation_MultipleFileUpload()
        : base("Investigation_MultipleFileUpload_ascx")
    {
    }

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData(Convert.ToInt32(Request.QueryString["pid"]), Convert.ToInt32(Request.QueryString["vid"]), OrgID, "DOCUMENT");

        }
    }
    #endregion
    #region "Events"
    protected void CommonUpload_ItemBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {



            HiddenField HiddenFileUrl = (HiddenField)e.Item.FindControl("HiddenFileUrl");
            HiddenField HiddenFileID = (HiddenField)e.Item.FindControl("HiddenFileID");
            HiddenField HiddenIdentifyingType = (HiddenField)e.Item.FindControl("HiddenIdentifyingType");
            Label FilePath = (Label)e.Item.FindControl("FilePath");
            string[] SplitPath = FilePath.Text.ToString().Split('^');
            FilePath.Text = SplitPath[1].ToString();

            HiddenField HiddenOrgID = (HiddenField)e.Item.FindControl("HiddenOrgID");
            HiddenOrgID.Value = OrgID.ToString();
            // FilePath.Text = "";
            HyperLink HyperFileDownload = (HyperLink)e.Item.FindControl("HyperFileDownload");

            HyperFileDownload.NavigateUrl = "../Reception/TRFImagehandler.ashx?MultiFile=true" + "&POrgID=" + OrgID + "&FileURL=" + HiddenFileUrl.Value + "&Type=DOCUMENT" + "&FileName=" + FilePath.Text;
            HyperFileDownload.ForeColor = System.Drawing.Color.Blue;

        }
    }

    #endregion


    #region "Methods"

    public long CommonUpload(long PatientID, long VisitID, HttpFileCollection FileCollection, int OrgID)
    {
        string AlertType = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
        string strValidation1 = Resources.Investigation_AppMsg.Investigation_MultipleFileUpload_ascx_03 == null ? "Files Saved Successfully" : Resources.Investigation_AppMsg.Investigation_MultipleFileUpload_ascx_03;
        string strValidation2 = Resources.Investigation_AppMsg.Investigation_MultipleFileUpload_ascx_04 == null ? "Files not saved try again.." : Resources.Investigation_AppMsg.Investigation_MultipleFileUpload_ascx_04;
        
        try
        {
            long returncode = 0;
            List<TRFfilemanager> TRFfilemanager = new List<TRFfilemanager>();

            string FileName = "";

            HttpFileCollection uploads = FileCollection;
            string Uploadpath = GetConfigValue("TRF_UploadPath", OrgID) + "MultiUploadDocu" + "\\";
            if (!Directory.Exists(Uploadpath))
            {
                Directory.CreateDirectory(Uploadpath);
            }

            for (int fileCount = 0; fileCount < uploads.Count; fileCount++)
            {
                if (uploads.Keys[fileCount].ToString() == "MultiFile$MutipleFileUpload")
                {
                    String guid = Guid.NewGuid().ToString();

                    HttpPostedFile uploadedFile = uploads[fileCount];
                    FileName = Path.GetFileName(uploadedFile.FileName);
                    FileName = OrgID + "_" + PatientID + "_" + VisitID + "_" + guid + "_" + fileCount + "^" + FileName;
                    string FullpathName = Uploadpath + FileName;
                    uploadedFile.SaveAs(FullpathName);
                    TRFfilemanager.Add(new TRFfilemanager { FileUrl = FileName, PatientID = PatientID, VisitID = VisitID, IdentifyingType = "Document", OrgID = OrgID });
                }

            }

            Patient_BL patientBLs = new Patient_BL(base.ContextInfo);

            returncode = patientBLs.pBulkInsertTRFDetails(TRFfilemanager);
            if (returncode == 0)
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('"+strValidation1.Trim()+"','"+AlertType.Trim()+"');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strValidation2.Trim() + "','" + AlertType.Trim() + "');", true);
            }

            return returncode;

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in CommonFormat File Upload", ex);
            return -1;

        }

    }

    public void LoadData(int PatientID, int VisitID, int OrgID, string Type)
    {
        try
        {

            List<TRFfilemanager> TRFlist = new List<TRFfilemanager>();
            long returncode = 0;
            Patient_BL patientBLs = new Patient_BL(base.ContextInfo);

            returncode = patientBLs.GetTRFimageDetails(PatientID, VisitID, OrgID, Type, out TRFlist);

            if (TRFlist.Count > 0)
            {
                tdrptUpload.Visible = true;
                rptCommonUpload.Visible = true;
                rptCommonUpload.DataSource = TRFlist;
                rptCommonUpload.DataBind();
            }
            else
            {
                rptCommonUpload.Visible = true;
                tdrptUpload.Visible = false;
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in CommonFormat File Loading", ex);
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

    #endregion



}
