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

public partial class CommonControls_TRFUpload : BaseControl
{
    string pathname = string.Empty;
    long Patientid = 0;
    long visitid = 0;
    public event MultipleFileUploadClick Click;

    private int _Rows = 6;
    public int Rows
    {
        get { return _Rows; }
        set { _Rows = value < 6 ? 6 : value; }
    }

    /// <summary>
    /// The no of maximukm files to upload.
    /// </summary>
    private int _UpperLimit = 0;
    public int UpperLimit
    {
        get { return _UpperLimit; }
        set { _UpperLimit = value; }
    }

    public CommonControls_TRFUpload()
        : base("Reception_VisitDetails_aspx")
    {
    }

   

    string strTRFImage = Resources.Reception_ClientDisplay.CommonControls_TRFUpload_ascx_03 == null ? "TRF Image Upload" : Resources.Reception_ClientDisplay.CommonControls_TRFUpload_ascx_03;
    protected void Page_Load(object sender, EventArgs e)
    {
       // lblCaption.Text = _UpperLimit == 0 ? "Maximum Files: No Limit" : string.Format("Maximum Files: {0}", _UpperLimit);
        lblCaption.Text = strTRFImage.Trim();
        pnlListBox.Attributes["style"] = "overflow:auto;";
        pnlListBox.Height = Unit.Pixel(20 * _Rows - 1);
       
            visitid = Convert.ToInt64(Request.QueryString["vid"]);
            Patientid = Convert.ToInt64(Request.QueryString["pid"]);
       

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


    protected void btnUpload_Click(object sender, EventArgs e)
    {
        // Fire the event.
        Click(this, new FileCollectionEventArgs(this.Request));
    }

}

/// <summary>
/// EventArgs class that has some readonly properties regarding posted files corresponding to MultipleFileUpload control. 
/// </summary>
public class FileCollectionEventArgs : EventArgs
{
    private HttpRequest _HttpRequest;

    public HttpFileCollection PostedFiles
    {
        get
        {
            return _HttpRequest.Files;
        }
    }

    public int Count
    {
        get { return _HttpRequest.Files.Count; }
    }

    public bool HasFiles
    {
        get { return _HttpRequest.Files.Count > 0 ? true : false; }
    }

    public double TotalSize
    {
        get
        {
            double Size = 0D;
            for (int n = 0; n < _HttpRequest.Files.Count; ++n)
            {
                if (_HttpRequest.Files[n].ContentLength < 0)
                    continue;
                else
                    Size += _HttpRequest.Files[n].ContentLength;
            }

            return Math.Round(Size / 1024D, 2);
        }
    }

    public FileCollectionEventArgs(HttpRequest oHttpRequest)
    {
        _HttpRequest = oHttpRequest;
    }
}

//Delegate that represents the Click event signature for MultipleFileUpload control.
public delegate void MultipleFileUploadClick(object sender, FileCollectionEventArgs e);