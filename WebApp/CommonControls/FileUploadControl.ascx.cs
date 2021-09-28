using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommonControls_FileUploadControl : BaseControl 
{
    #region

    private string fileName=string.Empty ;
    private string filter;
    private string path;
    private string fileExtn;


#endregion

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public long uploadFile() 
    {
        
        long retval = -1;

        try
        {
            
            
            lblFileUpload.Text = "";
            lblFile.Text = "";
            

            if (FileUpload1.HasFile)
            {

                //if(Request.ContentType="
                string fileExtn = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);
                FileExtn = fileExtn;

                {
                    if (fileExtn == ".pdf")
                    {

                        FileName = Path + FileUpload1.FileName;
                        FileUpload1.SaveAs(FileName);
                        lblFile.Text = FileName;
                        retval = 0;
                    }
                    else
                    {
                        lblFileUpload.Text = "Invalid file format";
                    }
                }
            }                   
       }
        catch (Exception ex)
        {
            lblFileUpload.Text = "Unable to upload file. " + ex.ToString();
        }
      return retval;
    }

    public void check()
    {
        if (FileUpload1.HasFile)
        { 
        }
    }
     

    #region Properties 

    public string FileName
    {
        get
        {
            return fileName;
        }
        set
        {
            fileName = value;
        }
    }
    public string Filter
    {
        get
        {
            return filter;
        }
        set
        {
            filter = value;
        }
    }
    public string Path
    {
        get
        {
            return path;
        }
        set
        {
            path = value;
        }
        
    }
    public string FileExtn
    {
        get
        {
            return fileExtn;
        }
        set
        {
            fileExtn = value;
        }
    }


    #endregion Properties

    public string getPath()
    {
        return lblFile.Text;
    }
    


}
