﻿using System;
using System.Collections.Generic;
using System.Web.UI;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_Topheader :BaseControl
{
    public CommonControls_Topheader()
        : base("CommonControls_Topheader_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sCurrentPage = Request.AppRelativeCurrentExecutionFilePath;
            // 
            //System.Resources.ResourceManager obj = new System.Resources.ResourceManager(typeof("Resource.resx"
            //obj.GetString("/Reception/Home.aspx");
          
          
            string sHeaderText = (string)GetGlobalResourceObject("Resource", sCurrentPage);
            if (sCurrentPage == "~/Patient/RefundtoPatient.aspx")
            {
                //if (Request.QueryString["btype"] == "CAN")
                //{
                //    lblvalue.Text = Resources.ClientSideDisplayTexts.Refund_CancelBillHeader;
                //}
                //else
                //{
                    lblvalue.Text = sHeaderText;
                //}
            }
            else if (sCurrentPage == "~/Inventory/InvOpticalBilling.aspx")
            {
                //if (Request.QueryString["IsPharmacy"] == "Y")
                //{
                   // lblvalue.Text = Resources.ClientSideDisplayTexts.Inventory_InvOpticalOpBilling;
                //}
                //else
                //{
                    int endPosition = sCurrentPage.IndexOf('.');
                    int startingPosition = sCurrentPage.LastIndexOf('/');
                    string s = sCurrentPage.Substring(startingPosition + 1, endPosition - startingPosition - 1);

                    lblvalue.Text = s.ToString();
                //}
            }

            else if (!String.IsNullOrEmpty(sHeaderText))
            {
                lblvalue.Text = sHeaderText;
            }
           
            else
            {
                int endPosition = sCurrentPage.IndexOf('.');
                int startingPosition = sCurrentPage.LastIndexOf('/');
                string s = sCurrentPage.Substring(startingPosition + 1, endPosition - startingPosition - 1);

                lblvalue.Text = s.ToString(); 

            }
        }
    }
    
    protected void ImgBtnHome_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode >= 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}
