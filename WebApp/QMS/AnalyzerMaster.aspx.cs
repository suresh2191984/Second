using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Web.Services;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.Script.Serialization;
using Attune.Podium.FileUpload;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Solution.QMSBusinessLogic;
using Attune.Solution.QMSBasecClassConvert;

public partial class QMS_MasterTemplate : BasePage, IDisposable
{
    public QMS_MasterTemplate()
        : base("QMS_MasterTemplate_aspx")
    {
    }
    public string dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        //ScriptManager.GetCurrent(this).RegisterPostBackControl(this.btnUpdate);
        LoadMetaData();

        dt = OrgDateTimeZone;


    }

    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "Processingmode,Interface";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Processingmode"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlProcessingMode.DataSource = childItems;
                    ddlProcessingMode.DataTextField = "DisplayText";
                    ddlProcessingMode.DataValueField = "Code";
                    ddlProcessingMode.DataBind();
                    ddlProcessingMode.Items.Insert(0, "---select---");
                    ddlProcessingMode.Items[0].Value = "0";

                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Interface"
                                  select child;
                if (childItems1.Count() > 0)
                {
                    ddlInterface.DataSource = childItems1;
                    ddlInterface.DataTextField = "DisplayText";
                    ddlInterface.DataValueField = "Code";
                    ddlInterface.DataBind();
                    ddlInterface.Items.Insert(0, "---select---");
                    ddlInterface.Items[0].Value = "0";

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

    public void AddFileMaster_click(object sender, EventArgs e)
    {
        // string pathname = GetConfigValue("TRF_UploadPath", OrgID);

        // try
        // {
            // DateTime dt = new DateTime();
            // dt = Convert.ToDateTime(OrgDateTimeZone);

            // int Year = dt.Year;
            // int Month = dt.Month;
            // int Day = dt.Day;
            // if (FileUpload1.HasFile)
            // { }
            // //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf

            // String Root = String.Empty;
            // String RootPath = String.Empty;
            // //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            // Root = "TRF_Upload-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-";
            // Root = Root.Replace("-", "\\\\");
            // RootPath = pathname + Root;
            // //ENd///

            // HttpFileCollection hfc = TRFFiles();

            // for (int i = 0; i < hfc.Count; i++)
            // {
                // if (hfc.AllKeys[i] == "FileUpload1")
                // {
                    // HttpPostedFile hpf = hfc[i];
                    // if (hpf.ContentLength > 0)
                    // {
                        // string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                        // string fileExtension = Path.GetExtension(hpf.FileName);
                        // long  instrumentID = Convert.ToInt64(hdnInsID.Value);
                        // string NameWithoutExt = OrgID + '_' + fileName;
                        // string FileName = string.Empty;
                        // string filePath = string.Empty;
                        // //Response.OutputStream.Flush();
                        // RootPath = "D:\\Attune\\";
                        // if (!System.IO.Directory.Exists(RootPath))
                        // {
                            // System.IO.Directory.CreateDirectory(RootPath);
                        // }
                        // //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        // string[] fileNames = Directory.GetFiles(RootPath, NameWithoutExt + ".*");
                        // foreach (string path in fileNames)
                        // {
                            // File.Delete(path);
                        // }
                        // string Extension = ".txt";
                        // if (Extension.Contains(fileExtension.ToUpper()))
                        // {
                            // FileName = NameWithoutExt + ".txt";

                            // //filePath = imagePath + pictureName;
                            // filePath = RootPath + FileName;


                            // if (System.IO.Directory.Exists(RootPath))
                            // {
                                // hpf.SaveAs(filePath);
                            // }

                        // }
                        // else
                        // {
                            // FileName = NameWithoutExt + fileExtension;
                            // //filePath = imagePath + pictureName;
                            // filePath = RootPath + FileName;
                            // hpf.SaveAs(filePath);
                        // }
                        // long returncode = -1;
                        // AnalyzerMaster_BL Obj_BL = new AnalyzerMaster_BL(new QMS_Integration( new BaseClass().ContextInfo).returnContext);
                        // returncode = Obj_BL.UpdateFilepath(instrumentID, filePath);
                    // }
                // }
            // }
        // }
        // catch (Exception ex)
        // {
            // CLogger.LogError("Error while save the file", ex);
        // }
    }
    

    public  string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;

        GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = HttpContext.Current.Request.Files;
        return hfc;
    }


}
