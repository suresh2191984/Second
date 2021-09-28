
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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Linq;

public partial class CommonControls_Qualification : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["PID"]))
            {
                GetGroupValues(Request.QueryString["PID"]);
            }
            else
            {
                GetGroupValues("0");
            }
        }
    }

    public void GetGroupValues(string paientID)
    {
        long returnCode = -1;
        try
        {
           
            Master_BL obj = new Master_BL(base.ContextInfo);        
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();                    
            Utilities objUt = new Utilities();        
            hdnOrginID.Value = base.OrgID.ToString();
            string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");
            returnCode = obj.GetGroupValues(base.OrgID,"DEGREE", out lstmetavalue);
            ddlQualification.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlDescriptions.Items.Insert(0, new ListItem("--Select--", "0"));
            if (lstmetavalue.Count > 0)
            {          
                ddlQualification.DataTextField = "Description";
                ddlQualification.DataValueField = "Code";
                ddlQualification.DataSource = lstmetavalue;
                ddlQualification.DataBind();
                ddlQualification.Items.Insert(0, new ListItem("--Select--", "0"));
            }          

            if (!paientID.Equals("0"))
            {
                ddlDescriptions.Items.Clear();
                List<PatientQualification> lstQualification = new List<PatientQualification>();
                Patient_BL pBL = new Patient_BL(base.ContextInfo);
                pBL.GetPatientQualification(Convert.ToInt64(paientID), out lstQualification);
                string strDescrption = string.Empty;
                foreach (PatientQualification oPatientQualification in lstQualification)
                {
                    ddlQualification.SelectedValue = oPatientQualification.MetaTypeID.ToString();
                    strDescrption = oPatientQualification.MetaValueID.ToString();
                    hdnDescriptions.Value = oPatientQualification.MetaValueID.ToString();
                    hdnQualification.Value = oPatientQualification.MetaTypeID.ToString();
                    returnCode = obj.GetGroupValues(base.OrgID, oPatientQualification.MetaTypeID.ToString(), out lstmetavalue);
                }

                if (lstmetavalue.Count > 0)
                {                
                    ddlDescriptions.DataTextField = "Description";
                    ddlDescriptions.DataValueField = "Code";
                    ddlDescriptions.DataSource = lstmetavalue;
                    ddlDescriptions.DataBind();                   
                }

                ddlDescriptions.SelectedValue = strDescrption;

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    
}
