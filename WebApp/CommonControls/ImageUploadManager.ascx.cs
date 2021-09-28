/*
Copyright (c) 2009 Butov, Oleg N. O&B Development

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
using System;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using Attune.Podium.FileUpload;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;


public partial class ImageUploadManager : BaseControl, ICallbackEventHandler
{
    private string strFormID;
    public string TargetFormID
    {
        get { return strFormID; }
        set { strFormID = value; }
    }

    private int maxFileSize; //= 5242880; //5mb
    public int MaxImageSize
    {
        get { return maxFileSize; }
        set { maxFileSize = value; }
    }    
    private string returnValue = String.Empty;

    private static string imgUploadFolder;
    public string TempUploadPath
    {
        get { return imgUploadFolder; }
        set { imgUploadFolder = value + "/"; }
    }
    protected string defaultImage = imgUploadFolder + "default.gif";

    private int intBatchID;
    public int BatchID
    {
        get { return intBatchID; }
        set { intBatchID = value; }
    }

    private int imgWidth;
    public int IconWidth
    {
        get { return imgWidth; }
        set { imgWidth = value; }
    }
    
    private long patientNotesID;
    public long PatientNotesID
    {
        set
        {
            patientNotesID = value;
            hidNotesid.Value = patientNotesID.ToString();
        }
    }

    private bool enableState;

    public bool EnableState
    {
        set
        {
            enableState = value;
            imgUpload.Disabled = enableState;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
             Session["ImagesList"] = null;
            //ViewState["ImagesList"] = null;
        }

        //string srt = ViewState["ImagesList"].ToString();
        string sbReference = Page.ClientScript.GetCallbackEventReference(this, "arg", "ReceiveServerData", "context");
        string cbScript = String.Empty;
        if (!Page.ClientScript.IsClientScriptBlockRegistered("CallServer"))
        {
            cbScript = @" function CallServer(arg,context) { " + sbReference + "}";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "CallServer", cbScript, true);
        }
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "ImageWidth", String.Format("var ImageWidth={0};", imgWidth), true);
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "LblMessageID", String.Format("var lblMessageId=\"{0}\";", lblMessage.ClientID), true);


        //btnSave.PostBackUrl = Request.CurrentExecutionFilePath + String.Format("?save=true&uid={0}", BatchID);
        WriteJavascript();
        //postback with upload = true should only be fired by imgUpload drop down, when image file is being selected
        if (Request.QueryString["upload"] != null && Request.QueryString["upload"] != "")
        {
            if (Request.QueryString["uid"] != null && Request.QueryString["uid"] != "")
                UploadImageInit(Request.QueryString["uid"]); //upload image, and store image "local" URL in hashtable, with index = uid
            else
                UploadImageInit("Error:Image ID is missing."); //when image ID query string is empty - flag error
        }

    }
    
    /// <summary>
    ///This method is used to dynamicaly write Javascript function into client page,
    ///Javascript is used to do a "hidden" postback in the iFrame on the page
    /// </summary>
    protected void WriteJavascript()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("function submitUpload(frameName)");
        sb.Append("{");
        sb.Append(String.Format("var hform = parent.document.getElementById('{0}');", TargetFormID)); //get Traget Form id from Control Parameters
        sb.Append(String.Format("hform.action = \"{0}?upload=true&uid=\"+counter;", Request.CurrentExecutionFilePath));
        sb.Append("hform.target = frameName;");
        sb.Append("hform.submit();");
        sb.Append("hform.action = document.URL;");
        sb.Append("hform.target = \"_self\";");
        sb.Append("}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "submitUpload", sb.ToString(), true);
    }



    /// <summary>
    ///This method is a wrapper around DoFileUpload method
    /// </summary>
    protected void UploadImageInit(string uid)
    {
        string uploadContext = "Error~Preview Image Init Generic Exception.";
        try
        {
            if (!uid.Contains("Error")) //perform upload only if no errors were flagged earlier
            {
                Hashtable list; //hashtable to store Images' paths
             
                //if (ViewState["ImagesList"] != null)
                if (Session["ImagesList"] != null)
                {
                    list = (Hashtable)Session["ImagesList"];
                }
                else
                {
                    list = new Hashtable();
                }
                uploadContext = DoFileUpload(); //do image upload
                if (uploadContext.Contains("Success")) //on success
                {
                    string path = uploadContext;//;//parse image path from the string returned by upload
                    list.Add(uid, path);    //store image path for future reference
                    //ViewState["ImagesList"] = uploadContext; //save list
                    Session["ImagesList"] = list; //save list
                }
            }
            else //error was flagged earlier in processing
            {
                uploadContext = uid; //reassign returned error message -format should be "Error:Message"
            }
        }
        catch (Exception ex)
        {
            uploadContext = String.Format("Error~{0}", ex.Message);
        }
        //Call javascript function in the parent page (since this upload was posted in the child iFrame control)
        //Pass path to the freshly uploaded image on the server
        Response.Write("<script type='text/javascript' language='javascript'>");
        Response.Write(String.Format("parent.FinishImagePreview('{0}');", uploadContext));
        Response.Write("</script>");

    }

    protected void DeleteImageFile(string url)
    {
        FileUploadManager objFileUploadManager = new FileUploadManager(base.ContextInfo);
        objFileUploadManager.DeleteFromDisk(UploadPath + url);
    }



    /// <summary>
    /// Fired when CallServer is executed on the client
    /// Deletes file from the Hashtable, as well as server's ImageUpload folder
    /// </summary>
    /// <returns></returns>
    public string GetCallbackResult() //fired by client on Image Deletion
    {
        string result = "";
        try
        {
            Hashtable list;
            //if (ViewState["ImagesList"] != null)
            if (Session["ImagesList"] != null)
            {
                list = (Hashtable)Session["ImagesList"];
            }
            else
            {
                list = new Hashtable();
            }
            DeleteImageFile(((string)list[returnValue]).Split('~')[1]);
            list.Remove(returnValue);
            result = "Success~Deleted";
            //ViewState["ImagesList"] = list;
            Session["ImagesList"] = list;
        }
        catch (Exception ex)
        {
            result = String.Format("Error~{0}", ex.Message);
        }

        return result; //result is returned to the client to ReceiveServerData(rValue) 
    }
    /// <summary>
    ///This method is fired by the CallBack event, when CallServer is executed on the client
    /// returnValue is being assigned the name of the file, that needs to be deleted
    /// </summary>
    public void RaiseCallbackEvent(string eventArgument) //fired by client on Image Deletion - CallServer
    {
        if (!String.IsNullOrEmpty(eventArgument))
        {
            returnValue = eventArgument;
        }

    }

    #region Process Image Upload for Preview
    /// <summary>
    ///This method is used to upload physical file on the server through the "hidden" postback,
    ///upon finish Upload Status string is returned to the parent page, by invoking a javascript function
    /// </summary>
    /// 

    protected string DoFileUpload()
    {
        List<Attune.Podium.BusinessEntities.Config> lConfig = new List<Config>();
        string result = "";
        string SelectedFileName = string.Empty;
        string path = string.Empty;
        string Filename = string.Empty;
        string FormattedFileName = string.Empty;
        string fileTosave = string.Empty;
        string ImageDescription = string.Empty;
        long returnCode = -1;
        FileUploadManager objFileUploadManager = new FileUploadManager(base.ContextInfo);
        try
        {
            if (imgUpload.PostedFile != null)//make sure posted file is NOT null
            {
                if (imgUpload.PostedFile.FileName != null && imgUpload.PostedFile.FileName != "") //check for filename
                {
                    
                    path = UploadPath + imgUploadFolder;
                    SelectedFileName = System.IO.Path.GetFileName(imgUpload.PostedFile.FileName);
                    Filename = "_PNID_" + hidNotesid.Value + "_" + SelectedFileName;
                    HttpPostedFile File = imgUpload.PostedFile; //posted file handle
                    FormattedFileName = objFileUploadManager.GetFilename(Filename);
                    fileTosave = path + FormattedFileName;
                    //ImageDescription = txtImgDesc.Text;
                    returnCode = objFileUploadManager.WriteToDisk(File, fileTosave);
                    if (returnCode == 0)
                    {
                        //result = String.Format("Success~{0}~{1}~{2}", imgUploadFolder + UNCPath, File.ContentType, 1); ;
                        result = String.Format("Success~{0}~{1}~{2}", imgUploadFolder + FormattedFileName, File.ContentType, SelectedFileName); 
                    }
                }
            }
        }
        catch (Exception ex)
        {
            result = String.Format("Error~{0}", "Error while Upload File");
        }
        finally
        {

        }
        return result;


    }
    #endregion

    public Hashtable GetFileURL()
    {
        Hashtable list =  new Hashtable();

        //if (ViewState["ImagesList"] != null)
        if (Session["ImagesList"] != null)
        {
            list = (Hashtable)Session["ImagesList"];
            Session["ImagesList"] = null;
        }
        return list;
    }
}
