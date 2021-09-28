using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Globalization;
using System.Configuration;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;


using Attune.Kernel.PlatForm.Base;
public partial class PlatFormControls_Attune_Footer : Attune_BaseControl
{
    public PlatFormControls_Attune_Footer()
        : base("PlatFormControls_Attune_Footer_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //ContextDetails ContextDetails = new ContextDetails();
            if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["BuildNo"]))
            {
                string BuildNo = ConfigurationManager.AppSettings["BuildNo"];
                LtBuildNo.Text = "Version: " + BuildNo;
            }
            //LtPageId.Text = RoleDescription.ToString() + "_" + PageID.ToString();
            //  string TaskNotification = GetConfigValue("Tasknotification", OrgID);
            Utilities objUtilities = new Utilities();
            string ShowKeyValue = string.Empty;
            string hideKeyValue = string.Empty;
            objUtilities.GetApplicationValue("TaskNotificationShow", out ShowKeyValue);
            objUtilities.GetApplicationValue("TaskNotificationHide", out hideKeyValue);
            if (ShowKeyValue != "")
            {
                hdnshowintervel.Value = ShowKeyValue;
            }
            else
            {
                hdnshowintervel.Value = "60000";
            }
            if (hideKeyValue != "")
            {
                hdnhideintervel.Value = hideKeyValue;
            }
            else
            {
                hdnhideintervel.Value = "0";
            }
            if (TaskNotification == "Y")
            {
                hdnTaskNotification.Value = "Y";
            }
            else
            {
                hdnTaskNotification.Value = "N";
            }
            if (!IsPostBack)
            {
                string NeedSystemFeedback = string.Empty;
                NeedSystemFeedback = GetConfigValue("NeedSystemFeedback", OrgID);
                if (NeedSystemFeedback == "Y")
                {
                    divFBFloat.Style.Add("display", "table");
                }
                if (!isCorporateOrg.ToUpper().Equals("N"))
                    hdnIsCorpOrg.Value = "Y";
            }
            hdnFeedback.Value = GetConfigValue("IsFeedBack", OrgID);
            if (hdnFeedback.Value == "Y")
            {
                divFBFloat.Style.Add("display", "none");
            }
            ApplicationValidate av = new ApplicationValidate();
            int sExpdate = av.ApplcationExpiration(OrgID);

            if (sExpdate >= 3 && sExpdate <= 4)
            {
                appexpDate.Style.Add("display", "table");
                appexpDate.Attributes.Add("class", "warning");
                appexpDate.InnerHtml = "License will expire on " + DateTime.Now.AddDays(sExpdate).ToString("dd-MMMM-yyyy")+" ("+ sExpdate+" days)";
            }
            if (sExpdate <= 2)
            {
                appexpDate.Style.Add("display", "table");
                appexpDate.Attributes.Add("class", "error");
                appexpDate.InnerHtml = "License will expire on " + DateTime.Now.AddDays(sExpdate).ToString("dd-MMMM-yyyy")+" ("+ sExpdate+" days)";

            }

            
        }
    }
    //protected void lnkLogOut_Click(object sender, EventArgs e)
    //{
    //    LogOut();
    //}
}
