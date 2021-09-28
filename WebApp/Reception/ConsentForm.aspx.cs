﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;

public partial class Reception_ConsentForm : BasePage
{
    long visitID = 0;
    long patientID = 0;
    long returnCode = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            GetFCKPath();
            if (!IsPostBack)
            {
                LoadConsentTemplate();
            }
            
      
    }

    public void LoadConsentTemplate()
    {
        try
        {
            List<ConsentTypeMaster> lstFormType = new List<ConsentTypeMaster>();
            new Referrals_BL(base.ContextInfo).GetConsentFormTemplate(OrgID, out lstFormType);
            ddlTemplateType.DataSource = lstFormType;
            ddlTemplateType.DataTextField = "ConsentFormTypeName";
            ddlTemplateType.DataValueField = "ConsentFormTypeID";
            ddlTemplateType.DataBind();
            ddlTemplateType.Items.Insert(0, new ListItem("--Select--", "0"));

          }

        catch (Exception ex)
        {
            CLogger.LogError("Error occured in ConsentTemplate Load", ex);
        }
    }


    protected void ddlTemplateType_SelectedIndexChanged(object sender, EventArgs e)
    {

        List<ConsentTemplateDetails> lstTemplateDetails = new List<ConsentTemplateDetails>();
        int TemplateID = Convert.ToInt16(ddlTemplateType.SelectedItem .Value);
        string TemplateName =ddlTemplateType .SelectedItem .Text ;
        new Referrals_BL(base.ContextInfo).GetConsentFormDeatils(0,TemplateID, TemplateName,OrgID, out lstTemplateDetails);
        FCKTemplate.Value = Convert.ToString(lstTemplateDetails[0].ConsentFormDetails);
        
      
       
    }


    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            FCKTemplate.ToolbarSet = "Attune";
            FCKTemplate.BasePath = sPath;
            FCKTemplate.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            FCKTemplate.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            CLogger.LogError("There is a Problem in get FCK Path", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    
    
    {
        try
        {
            List<ConsentTemplateDetails> lstTemplateDetails = new List<ConsentTemplateDetails>();
            int TemplateID = Convert.ToInt16(ddlTemplateType.SelectedItem.Value);
            string TemplateName = ddlTemplateType.SelectedItem.Text;
            new Referrals_BL(base.ContextInfo).GetConsentFormDeatils(0, TemplateID, TemplateName, OrgID, out lstTemplateDetails);
            //FCKTemplate.Value = Convert.ToString(lstTemplateDetails[0].ConsentFormDetails);
            string afterSign = FCKTemplate.Value;

            List<ConsentLetters> lstLetters = new List<ConsentLetters>();
            returnCode = new Referrals_BL(base.ContextInfo).SaveConsentletters(visitID, TemplateID, lstTemplateDetails[0].ConsentFormDetails, FCKTemplate.Value);
        }
        catch (Exception ex)
        {
            CLogger.LogError("There is a problem in saving ConsentLetters",ex);

        }


    }





    protected void btnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            //var consentformcontent = FCKTemplate.Value.ToString();
            //hdnContent.Value = consentformcontent.ToString();


            //ClientScript.RegisterStartupScript(Page.GetType(), "openPopUp", "javascript:popupprint();", true); 

            //List<ConsentLetters> lstLettres = new List<ConsentLetters>();
            //long TypeID = 0;
            //new Referrals_BL(base.ContextInfo).GetConsentletters(visitID, TypeID, out lstLettres);
            //FCKTemplate.Value = lstLettres[0].ConsentLetterAfterSign;
            Response.Redirect("../Reception/ConsentFormPrint.aspx?&vid=" + visitID +  "&pid=" + patientID , true);
           

        }
        catch (Exception ex)
        {
            CLogger.LogError("Ther is a problem in loading Consent form",ex);
        }
    }
}
