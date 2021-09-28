using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;

public partial class Reception_Dispatch : BasePage
{
    public Reception_Dispatch()
        : base("Reception\\Dispatch.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long visitID = 0;
    long returnCode = -1;
    Patient_BL patientBL ;
    List<PatientVisit> lstVisitDetails = new List<PatientVisit>();
    List<PatientAddress> lstPatientAddress =  new List<PatientAddress>();
    List<ResultPublishing> lstResultPublishing = new List<ResultPublishing>();
    List<ShippingAddress> lstShippingAddress = new List<ShippingAddress>();
    List<PatientInvestigation> lstPatientInvestigation1 = new List<PatientInvestigation>();
    List<PatientInvestigation> lstPatientInvestigation2 = new List<PatientInvestigation>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
          patientBL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            int j = 0;
            for (int i = 2009; i <= 2020; i++)
            {
                ddlSearchYear.Items.Insert(j, Convert.ToString(i));
                ddlSearchYear.Items[j].Value = Convert.ToString(i);
                j += 1;
            }
            ddlSearchYear.SelectedValue = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();
        }
        if (IsPostBack)
        {
            visitID = Convert.ToInt64(txtSearchTxt.Text);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            //Statement Added to change Search by BillID and VisitID
            string year = ddlSearchYear.SelectedValue;
            patientVisitBL.GetVisitIDByBillID(visitID, OrgID, year, out visitID);
            //end of statement
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
       try{
           returnCode = patientBL.UpdateDispatchDetails(visitID, OrgID);
           if (returnCode==0)
           {
               Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
           }
      }
             catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
          CLogger.LogError("Error while Saving Dispatch Details in Dispatch.aspx", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string RPStatus = string.Empty;
        try
        {
            if (txtSearchTxt.Text != string.Empty)
            {
                visitID = Convert.ToInt64(txtSearchTxt.Text);
                PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
                //Statement Added to change Search by BillID and VisitID
                string year = ddlSearchYear.SelectedValue;
                patientVisitBL.GetVisitIDByBillID(visitID, OrgID, year, out visitID);
                //end of statement
                List<PatientVisit> visitList = new List<PatientVisit>();
                returnCode = patientBL.GetLabVisitDetails(visitID, OrgID, out visitList);
                if (visitList.Count > 0)
                {
                    dInves.Style.Add("display", "block");
                    DrName.Text = visitList[0].ReferingPhysicianName;
                    HospitalName.Text = visitList[0].HospitalName;
                    if (visitList[0].CollectionCentreName != null && visitList[0].CollectionCentreName != "")
                    {
                        trCC.Style.Add("display", "block");
                        CollectionCentre.Text = visitList[0].CollectionCentreName;
                    }
                    else
                    {
                        trCC.Style.Add("display", "none");
                    }
                    lblVisitNo.Text = visitID.ToString();
                    lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
                    lblPatientNo.Text = Convert.ToString(visitList[0].PatientID);
                    if (visitList[0].Sex == "M")
                    {
                        lblGender.Text = "[Male]";
                    }
                    else
                    {
                        lblGender.Text = "[Female]";
                    }
                    lblAge.Text = visitList[0].PatientAge.ToString();
                }
                else
                {
                    lblStatus.Visible = true;
                    dInves.Style.Add("display", "none");
                }
                returnCode = patientBL.GetDispatchDetails(visitID, OrgID, out lstVisitDetails, out lstPatientAddress, out lstResultPublishing, out lstShippingAddress, out lstPatientInvestigation1, out lstPatientInvestigation2, out lstOrderedInvSample);
                if (lstPatientAddress.Count > 0 && lstResultPublishing.Count > 0)
                {
                    string patientAddress = string.Empty;
                    foreach (PatientAddress objPA in lstPatientAddress)
                    {
                        patientAddress += "<b><u>Patient Address</u></b><br/><br/>";
                        if (objPA.Add1 != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.Add1 + ", ";
                            }
                            else
                            {
                                patientAddress += objPA.Add1;
                            }
                        }
                        if (objPA.Add2 != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.Add2 + ",<br/> ";
                            }
                            else
                            {
                                patientAddress += objPA.Add2;
                            }
                        }
                        if (objPA.Add3 != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.Add3 + ",<br/> ";
                            }
                            else
                            {
                                patientAddress += objPA.Add3;
                            }
                        }
                        if (objPA.City != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.City + ",<br/> ";
                            }
                            else
                            {
                                patientAddress += objPA.City + ",<br/> ";
                            }
                        }
                        if (objPA.StateName != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.StateName + ", <br/>";
                            }
                            else
                            {
                                patientAddress += objPA.StateName + ",<br/> ";
                            }
                        }
                        if (objPA.CountryName != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.CountryName + ",<br/> ";
                            }
                            else
                            {
                                patientAddress += objPA.CountryName + ",<br/> ";
                            }
                        }
                        if (objPA.PostalCode != "")
                        {
                            if (patientAddress != "")
                            {
                                patientAddress += objPA.PostalCode;
                            }
                            else
                            {
                                patientAddress += objPA.PostalCode;
                            }
                        }
                    }
                    tdPatientAddress.InnerHtml = patientAddress;


                    string publishingAddress = string.Empty;
                    string publishingStatus = string.Empty;
                    foreach (ResultPublishing objRP in lstResultPublishing)
                    {
                        if (objRP.Status == "Not Published")
                        {
                            publishingStatus = "<span style='color:red;'>" + objRP.Status + "</span>";
                        }
                        else
                        {
                            publishingStatus = "<span style='color:green;'>" + objRP.Status + "</span>";
                        }
                        publishingAddress += "<b><u>Result Publishing Address</u></b><br/><br/>";
                        publishingAddress += "<b>Status Of Result: " + publishingStatus + "</b><br/>";
                        RPStatus = objRP.Status;
                        publishingAddress += objRP.ModeName + "<br/>";
                        publishingAddress += objRP.Value;

                        if (objRP.ReceiverName != "" && objRP.ReceiverName != null)
                        {
                            publishingAddress += objRP.ReceiverName + ",<br/>";
                        }
                        else
                        {
                            publishingAddress += objRP.ReceiverName;
                        }
                    }
                    foreach (ShippingAddress objSA in lstShippingAddress)
                    {
                        if (objSA.Add1 != "" && objSA.Add1 != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.Add1 + ", ";
                            }
                            else
                            {
                                publishingAddress += objSA.Add1;
                            }
                        }
                        if (objSA.Add2 != "" && objSA.Add2 != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.Add2 + ",<br/> ";
                            }
                            else
                            {
                                publishingAddress += objSA.Add2;
                            }
                        }
                        if (objSA.Add3 != "" && objSA.Add3 != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.Add3 + ",<br/> ";
                            }
                            else
                            {
                                publishingAddress += objSA.Add3;
                            }
                        }
                        if (objSA.City != "" && objSA.City != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.City + ",<br/> ";
                            }
                            else
                            {
                                publishingAddress += objSA.City;
                            }
                        }
                        if (objSA.StateName != "" && objSA.StateName != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.StateName + ", <br/>";
                            }
                            else
                            {
                                patientAddress += objSA.StateName;
                            }
                        }
                        if (objSA.CountryName != "" && objSA.CountryName != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.CountryName + ",<br/> ";
                            }
                            else
                            {
                                publishingAddress += objSA.CountryName;
                            }
                        }
                        if (objSA.PostalCode != "" && objSA.PostalCode != null)
                        {
                            if (publishingAddress != "")
                            {
                                publishingAddress += objSA.PostalCode;
                            }
                            else
                            {
                                publishingAddress += objSA.PostalCode;
                            }
                        }
                    }
                    tdPublishingAddress.InnerHtml = publishingAddress;

                    if (lstPatientInvestigation1.Count > 0)
                    {
                        dlInvName.DataSource = lstPatientInvestigation1;
                        dlInvName.DataBind();
                        dlInvName.Visible = true;
                    }
                }



                if (lstOrderedInvSample.Count > 0)
                {
                    dtSample.DataSource = lstOrderedInvSample;
                    dtSample.DataBind();
                    pnlSampleList.Visible = true;
                    pnlSampleListlbl.Style.Add("display", "none");
                    lblStatus.Visible = false;
                }
                else
                {
                    pnlSampleList.Visible = false;
                    lblStatus.Visible = true;
                    pnlSampleListlbl.Style.Add("display", "block");
                }



                if (lstPatientInvestigation2.Count > 0)
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = lstPatientInvestigation2;
                    grdResult.DataBind();
                    trPendingDept.Style.Add("display", "none");
                    buttonTab.Style.Add("display", "none");
                }
                else
                {
                    grdResult.Visible = false;
                    trPendingDept.Style.Add("display", "block");
                    if (RPStatus == "Not Published")
                    {
                        buttonTab.Style.Add("display", "block");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Dispatch.aspx:Loading Dispatch Details", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
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

            if (returnCode == 0)
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
