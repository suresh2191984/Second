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

public partial class CommonControls_ViewTRFImage : BaseControl
{
public CommonControls_ViewTRFImage()
        : base("CommonControls_ViewTRFImage_ascx")
    {
    }
    List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    long pVisitID = 0;
    long pPatientID = 0;
    string PictureName = string.Empty;
    string FileName = string.Empty;
    int patientid = 0;
    int visitid = 0;
    String IsFromDefaultPath = string.Empty;
    List<InvestigationValues> lstDeviceValue = new List<InvestigationValues>();
    List<InvestigationValues> lstDeviceValue1 = new List<InvestigationValues>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out pVisitID);
        Int64.TryParse(Request.QueryString["pid"], out pPatientID);
        string ViewClinicalhistory = GetConfigValue("EnablehistoryforTest", OrgID);
        if (ViewClinicalhistory == "Y")
        {
            divLnkTestPatientHistory.Visible = true;
        }
        else
        {
            divLnkTestPatientHistory.Visible = false;
        }
        patientid = int.Parse(pPatientID.ToString());
        visitid = int.Parse(pVisitID.ToString());
        hdnVisitID.Value = Convert.ToInt32(visitid).ToString();
        hdnOrgID.Value = OrgID.ToString();
        if (!IsPostBack)
        {
            ddlFileList.Attributes.Add("onchange","return onChangeFile('" + ddlFileList.ClientID + "');");
            LnkTRF.Attributes.Add("onclick", "return onClickLnkTRF('" + ddlFileList.ClientID + "');");
            ddlOutsourceDocList.Attributes.Add("onchange", "return onChangeFile1('" + ddlOutsourceDocList.ClientID + "');");
            LnkOutDoc.Attributes.Add("onclick", "return onClickLnkOutDoc('" + ddlOutsourceDocList.ClientID + "');");
			LnkSensitiveRemarks.Attributes.Add("onclick", "return onClickLnkSensitiveRemarks('" + visitid + "');");
            LnkTestPatientHistory.Attributes.Add("onclick", "return OnClickTestHistory('" + visitid + "');");
            loadimage(patientid, visitid);
            loadphoto(patientid);
            loadOutSourceDoc(patientid, visitid);
            UcHistory.ViewHistoryData(visitid);
            
        }
    }
    protected void Devicevalues_Click(object sender, EventArgs e)
    {
        Onchange();
        long InvestigationID = -1;
        string Guid = string.Empty;
        string strObj = string.Empty;  
        Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
        invesBL.GetDeviceValue(OrgID, visitid, InvestigationID, Guid, out lstDeviceValue);
        if (lstDeviceValue.Count > 0)
        {
        if (!String.IsNullOrEmpty(lstDeviceValue[0].GroupName))
        {

            var dwcr = (from dw in lstDeviceValue
                        select new { dw.Orgid, dw.GroupName }).Distinct();
            foreach (var obj in dwcr)
            {
                InvestigationValues pdc = new InvestigationValues();
                pdc.Orgid = obj.Orgid;
                pdc.GroupName = obj.GroupName;
                lstDeviceValue1.Add(pdc);
            }

            grdDevicegroupname.DataSource = lstDeviceValue1;
            grdDevicegroupname.DataBind();
        }
        else
        {
            grdDeviceinvname.DataSource = lstDeviceValue;
            grdDeviceinvname.DataBind();
        }

        
            if (!String.IsNullOrEmpty(lstDeviceValue[0].GroupName))
            {
                ModalPopupExtender1.Show();
            }
            else
            {
                ModalPopupExtender2.Show();
            }
        }
        else
        {
       
          //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('No Matching Records Found');", true);
            string headLogin = Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_10;
            string aInformation1 = Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_09 == null ? "No Matching Records Found" : Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_09;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + aInformation1 + "','" + headLogin + "');", true);

        }
    }
    protected void grdDevicegroupname_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            Onchange();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<InvestigationValues> lastDevice = new List<InvestigationValues>();
                Label lblOrgID = (Label)e.Row.FindControl("lblOrgID");
                 Label lblGroupNames = (Label)e.Row.FindControl("lblGroupNames");
                
                GridView grdDevicevalues = (GridView)e.Row.FindControl("grdDevicevalues");
                var dwcr = (from dw in lstDeviceValue
                            where dw.GroupName == lblGroupNames.Text
                            select new { dw.GroupName,dw.Name,dw.Value,dw.DeviceID,dw.DeviceValue }).Distinct();
                foreach (var obj in dwcr)
                {
                    InvestigationValues pdc = new InvestigationValues();
                    pdc.GroupName = obj.GroupName;
                    pdc.Name = obj.Name;
                    pdc.Value = obj.Value;
                    pdc.DeviceValue = obj.DeviceValue;
                    pdc.DeviceID = obj.DeviceID;
                    lastDevice.Add(pdc);
                }
                
                grdDevicevalues.DataSource = lastDevice;
                grdDevicevalues.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvOrgwisePatientSummary_RowDataBound  CollectionReport", ex);
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
    public void loadphoto(int patientid)
    {
        Onchange();
        long returncode = -1;
        List<Patient> lstpat = new List<Patient>();
        try
        {
            returncode = new Patient_BL(base.ContextInfo).Viewpatientphoto(patientid, out lstpat);

            if (lstpat.Count > 0)
            {
                if (lstpat.Count == 1)
                {
                    FileName = lstpat[0].PictureName;

                    if (!string.IsNullOrEmpty(FileName))
                    {
                        if (!String.IsNullOrEmpty(FileName))
                        {
                            string pathname = GetConfigValue("TRF_UploadPath", OrgID);
                            //string imagePathname = ConfigurationManager.AppSettings["PatientPhotoPath"];

                            //if (File.Exists(imagePathname + FileName))
                            if (File.Exists(pathname + FileName))
                            {
                                //FileName = pathname + FileName;
                                //imgPatientphoto.Src = "../Reception/PatientImageHandler.ashx?FileName=" + FileName; "&OrgID=" + OrgID
                                imgPatientphoto.Src = "../Reception/PatientImageHandler.ashx?FileName=" + FileName+"&OrgID=" + OrgID;

                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadingImage", ex);
        }
    }
    public void loadimage(int patientid, int visitid)
    {
CLogger.LogWarning("Start 05/12/2020 public void loadimage(int patientid, int visitid)");
        Onchange();
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        string HCTechScheduler = GetConfigValue("IsHCSchedulerWorkflow", OrgID);
        long returncode = -1;
        List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
        List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();

        try
        {
            string Type = "";
            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID, Type, out lstFiles);
            if (lstFiles.Count > 0)
            {
                if (HCTechScheduler == "Y")
                {
                    lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "TRF_Upload_LISWeb_Home_Collection");
                }else {
                    lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "TRF_Upload");
                }
            }
            if (lstTRF.Count > 0)
            {
                if (lstTRF.Count == 1)
                {
                    trDropDown.Style.Add("display", "none");
                    PictureName = lstTRF[0].FileName;
                    string fileName = Path.GetFileNameWithoutExtension(PictureName);
                    string fileExtension = Path.GetExtension(PictureName);
                   // string PDFFile = pathname + PictureName;
                                //Get Root Folder path
                                //Check File Availble or not
                                //if ok return PictureName ,IsFromDefaultPath="N";
                                //else Get Default File path from We config 
                                //and assign PictureName=Ne file path
                                //IsFromDefaultPath="Y";
                    if (!string.IsNullOrEmpty(PictureName))
                    {
                        
                        //if (System.IO.File.Exists(pathname + PictureName))
                        //{
                        //  IsFromDefaultPath = "N";
                           
                        //}
                        //else 
                        //{
                        //  IsFromDefaultPath = "Y";
                        //}
                                
                        
                        if (PictureName != "" && fileExtension != ".pdf")
                        {
                            if (!String.IsNullOrEmpty(PictureName))
                            {
                                trPicPatient.Style.Add("display", "block");
                                trPDF.Style.Add("display", "none");
                                imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;
                                //imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID + "&IsFromDefaultPath=" + IsFromDefaultPath;
                            }
                        }
                        else
                        {
                            trPicPatient.Style.Add("display", "none");
                            trPDF.Style.Add("display", "block");
                            ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                            //ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID + "&IsFromDefaultPath=" + IsFromDefaultPath);
                        }
                    }
                    else
                    {
                        trPicPatient.Style.Add("display", "none");
                        trPDF.Style.Add("display", "none");
                    }
                }
                else if (lstTRF.Count > 1)
                {
                    trDropDown.Style.Add("display", "block");
                    List<NameValuePair> lstFile = new List<NameValuePair>();
                    string[] fileName;
                    NameValuePair objNameValuePair;
                    foreach (TRFfilemanager obj in lstTRF)
                    {
                        fileName = obj.FileName.Substring(obj.FileName.LastIndexOf('_') + 1).Split('.');
                        if (fileName != null && fileName.Length > 1)
                        {
                            objNameValuePair = new NameValuePair();
                            objNameValuePair.Name = fileName[0];
                            objNameValuePair.Value = obj.FileName;
                            lstFile.Add(objNameValuePair);
                        }
                    }
                    hdnOrgID.Value = Convert.ToString(OrgID);
                    ddlFileList.DataSource = lstFile;
                    ddlFileList.DataTextField = "Name";
                    ddlFileList.DataValueField = "Value";
                    ddlFileList.DataBind();

                    ddlFileList.Items.Insert(0, new ListItem("----Select----", "0"));
                    PictureName = lstTRF[0].FileName;
                   // string fileName = Path.GetFileNameWithoutExtension(PictureName);
                    string fileExtension = Path.GetExtension(PictureName);
                    string PDFFile = pathname + PictureName;

                    if (PictureName != "")
                    {

                        //if (System.IO.File.Exists(pathname + PictureName))
                        //{
                        //    IsFromDefaultPath = "N";

                        //}
                        //else
                        //{
                        //    IsFromDefaultPath = "Y";
                        //}
                        

                        if (PictureName != "" && fileExtension != ".pdf")
                        {
                            if (!String.IsNullOrEmpty(PictureName))
                            {
                                trPicPatient.Style.Add("display", "block");
                                trPDF.Style.Add("display", "none");
                                imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID ;
                            }
                        }
                        else
                        {
                            trPicPatient.Style.Add("display", "none");
                            trPDF.Style.Add("display", "block");
                            ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID );
                        }
                    }
                    else
                    {
                        trPicPatient.Style.Add("display", "none");
                        trPDF.Style.Add("display", "none");
                    }
                }
            }
            else
            {
                trPicPatient.Style.Add("display", "none");
                trPDF.Style.Add("display", "none");
                trDropDown.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadingImage", ex);
        }
    }
    public void loadOutSourceDoc(int patientid, int visitid)
    {
        Onchange();
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
        List<TRFfilemanager> lstOutSourceDoc = new List<TRFfilemanager>();
        try
        {
            string Type = "";
            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID, Type, out lstFiles);
            if (lstFiles.Count > 0)
            {
                lstOutSourceDoc = lstFiles.FindAll(P => P.IdentifyingType == "Outsource_Docs");
            }
            if (lstOutSourceDoc.Count > 0)
            {
                if (lstOutSourceDoc.Count == 1)
                {
                    trddlOutsourceDoc.Style.Add("display", "none");
                    PictureName = lstOutSourceDoc[0].FileName;
                    string fileName = Path.GetFileNameWithoutExtension(PictureName);
                    string fileExtension = Path.GetExtension(PictureName);
                    string PDFFile = pathname + PictureName;

                    if (PictureName != "")
                    {

                        //if (System.IO.File.Exists(pathname + PictureName))
                        //{
                        //    IsFromDefaultPath = "N";

                        //}
                        //else
                        //{
                        //    IsFromDefaultPath = "Y";
                        //}
                        
                        if (PictureName != "" && fileExtension != ".pdf")
                        {
                            if (!String.IsNullOrEmpty(PictureName))
                            {
                                trPicPatient1.Style.Add("display", "block");
                                trPDF1.Style.Add("display", "none");
                                imgPatient1.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID ;
                            }
                        }
                        else
                        {
                            trPicPatient1.Style.Add("display", "none");
                            trPDF1.Style.Add("display", "block");
                            ifPDF1.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID );
                        }
                    }
                    else
                    {
                        trPicPatient1.Style.Add("display", "none");
                        trPDF1.Style.Add("display", "none");
                    }
                }
                else if (lstOutSourceDoc.Count > 1)
                {
                    trPicPatient1.Style.Add("display", "none");
                    trddlOutsourceDoc.Style.Add("display", "block");
                    List<NameValuePair> lstFile = new List<NameValuePair>();
                    string[] fileName;
                    NameValuePair objNameValuePair;
                    PictureName = lstOutSourceDoc[0].FileName;
                    string fileName1 = Path.GetFileNameWithoutExtension(PictureName);
                    string fileExtension = Path.GetExtension(PictureName);
                    string PDFFile = pathname + PictureName;

                    if (PictureName != "")
                    {

                        //if (System.IO.File.Exists(pathname + PictureName))
                        //{
                        //    IsFromDefaultPath = "N";

                        //}
                        //else
                        //{
                        //    IsFromDefaultPath = "Y";
                        //}
                        
                        if (PictureName != "" && fileExtension != ".pdf")
                        {
                            if (!String.IsNullOrEmpty(PictureName))
                            {
                                trPicPatient1.Style.Add("display", "block");
                                trPDF1.Style.Add("display", "none");
                                imgPatient1.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID ;
                            }
                        }
                        else
                        {
                            trPicPatient1.Style.Add("display", "none");
                            trPDF1.Style.Add("display", "block");
                            ifPDF1.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID );
                        }
                    }
                    else
                    {
                        trPicPatient1.Style.Add("display", "none");
                        trPDF1.Style.Add("display", "none");
                    }
                    foreach (TRFfilemanager obj in lstOutSourceDoc)
                    {
                        fileName = obj.FileName.Substring(obj.FileName.LastIndexOf('_') + 1).Split('.');
                        if (fileName != null && fileName.Length > 1)
                        {
                            objNameValuePair = new NameValuePair();
                            objNameValuePair.Name = fileName[0];
                            objNameValuePair.Value = obj.FileName;
                            lstFile.Add(objNameValuePair);
                        }
                    }
                    hdnOrgID.Value = Convert.ToString(OrgID);
                    ddlOutsourceDocList.DataSource = lstFile;
                    ddlOutsourceDocList.DataTextField = "Name";
                    ddlOutsourceDocList.DataValueField = "Value";
                    ddlOutsourceDocList.DataBind();

                    ddlOutsourceDocList.Items.Insert(0, new ListItem("----Select----", "0"));
					trddlOutsourceDoc.Style.Add("display", "block");
                    //PictureName = lstTRF[0].FileUrl.ToString();
                    //string fileName = Path.GetFileNameWithoutExtension(PictureName);
                    //string fileExtension = Path.GetExtension(PictureName);
                    //string PDFFile = pathname + PictureName;

                    //if (PictureName != "")
                    //{
                    //    if (PictureName != "" && fileExtension != ".pdf")
                    //    {
                    //        if (!String.IsNullOrEmpty(PictureName))
                    //        {
                    //            trPicPatient.Visible = true;
                    //            trPDF.Visible = false;
                    //            imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;
                    //        }
                    //    }
                    //    else
                    //    {
                    //        trPicPatient.Visible = false;
                    //        trPDF.Visible = true;
                    //        ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                    //    }
                    //}
                    //else
                    //{
                    //    trPicPatient.Visible = false;
                    //    trPDF.Visible = false;
                    //}
                }
            }
            else
            {
                trPicPatient1.Style.Add("display", "none");
                trPDF1.Style.Add("display", "none");
                trddlOutsourceDoc.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadingImage", ex);
        }
    }


    public bool ShowPhoto
    {
        set { LnkPhoto.Visible = value; }
    }
    public void LoadUcHistory(int visitid)
    {
        Onchange();
        UcHistory.ViewHistoryData(visitid);
    }
    public void Onchange()
    {
        ddlFileList.Attributes.Add("onchange", "return onChangeFile('" + ddlFileList.ClientID + "');");
        LnkTRF.Attributes.Add("onclick", "return onClickLnkTRF('" + ddlFileList.ClientID + "');");
        ddlOutsourceDocList.Attributes.Add("onchange", "return onChangeFile1('" + ddlOutsourceDocList.ClientID + "');");
        LnkOutDoc.Attributes.Add("onclick", "return onClickLnkOutDoc('" + ddlOutsourceDocList.ClientID + "');");
        LnkSensitiveRemarks.Attributes.Add("onclick", "return onClickLnkSensitiveRemarks('" + visitid + "');");
    }
}