using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;

public partial class Dialysis_PendingPhysioSearch : BasePage
{

    string PatientNo = string.Empty;
    string PName = string.Empty;
    string Type = string.Empty;
    string EmpNo = string.Empty;
    string ProcedureID = string.Empty;
    string FDate = string.Empty;
    string TDate = string.Empty;
    Patient_BL objPatient_BL;
    long returnCode = -1;
    List<Patient> lstPatient;
    long VisitID = -1;
    long PatientID = -1;
    protected void Page_Load(object sender, EventArgs e)
     {
        if (isCorporateOrg != null)
        {
            hdnIsCorpOrg.Value = isCorporateOrg;

            if (RoleName == "Receptionist")
            {
                btnGo.Visible = false;
                btnConfirmVisit.Visible = true;
                Td3.Attributes.Add("Style", "display:none");
                Td4.Attributes.Add("Style", "display:none");
            }
            else
            {
                btnGo.Visible = true;
                btnConfirmVisit.Visible = false;
            }
            if (isCorporateOrg == "Y")
            {
                tdEmpNo.Attributes.Add("Style", "display:block");
                tdEmpNum.Attributes.Add("Style", "display:block");
                tdPatientNo.Attributes.Add("Style", "display:none");
                tdPatientNum.Attributes.Add("Style", "display:none");                
            }
            else
            {
                tdEmpNo.Attributes.Add("Style", "display:none");
                tdEmpNum.Attributes.Add("Style", "display:none");
                tdPatientNo.Attributes.Add("Style", "display:block");
                tdPatientNum.Attributes.Add("Style", "display:block");
            }
        }
        
        if (!IsPostBack)
        {
            SearchPendingPhysioPatient(PatientNo, PName, Type,ProcedureID,EmpNo,FDate,TDate);
           
        }
        AutoCompleteExtender3.ContextKey = "PRO" + "~" + OrgID.ToString() + "~" + "";
        Label lblDateRange = (Label)dtSearch.FindControl("Rs_BillDate");
        lblDateRange.Text = "Next Review Date";

    }


     


    private void SearchPendingPhysioPatient(string PatientNo, string PName, string Type, string Procedure, string Empno, string FDate, string TDate)
    {
        objPatient_BL = new Patient_BL(base.ContextInfo);
        lstPatient = new List<Patient>();
        List<Patient> lstPatientT=new List<Patient>();
        DateTime obj = DateTime.MinValue;
        returnCode = objPatient_BL.SearchPendingPhysio(OrgID, PatientNo, PName, Type, Procedure, Empno, FDate, TDate, out lstPatient);
        if (RoleName == "Receptionist")
        {
            lstPatientT = (from ex in lstPatient
                                    group ex by new { ex.Name, ex.PatientID, ex.Age, ex.LandLineNumber, ex.MobileNumber, ex.EmployeeNumber, ex.Address } into g
                                    select new Patient
                                    {
                                        Name = g.Key.Name,
                                        PatientID = g.Key.PatientID,
                                        Age = g.Key.Age,
                                        MobileNumber = g.Key.MobileNumber,
                                        Address = g.Key.Address,
                                        EmployeeNumber = g.Key.EmployeeNumber,
                                    }).Distinct().ToList();
            gvPendingPhysio.DataSource = lstPatientT;
        }
        else
        {
            gvPendingPhysio.DataSource = lstPatient;
        }
        gvPendingPhysio.DataBind();
    }
     

   
    protected void btnGo_Click(object sender, EventArgs e)
    {
      
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        PatientNo = "";
        PName = "";
        EmpNo = "";
        ProcedureID = "";
        if (txtPatientNo.Text.Trim() != "")
        {
            PatientNo = Convert.ToString(txtPatientNo.Text);            
        }
        if (txtName.Text.Trim() != "")
        {
            PName = txtName.Text;
        }
        if (txtEmpNo.Text.Trim() != "")
        {
            EmpNo = txtEmpNo.Text;
        }
        if (txtProcedure.Text != "")
        {
            ProcedureID = hdnProcedureID.Value.ToString();
        }
        DropDownList ddlDateRange = (DropDownList)dtSearch.FindControl("ddlRegisterDate");
        if (ddlDateRange.SelectedIndex > 0)
        {
            FDate = Convert.ToString(dtSearch.GetFromDate());
            TDate = Convert.ToString(dtSearch.GetToDate());
        }
       SearchPendingPhysioPatient(PatientNo, PName, Type, ProcedureID, EmpNo, FDate, TDate);
        
    }

    protected void gvPendingPhysio_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Delete")
            {
                long returnCode = -1;
                long VstID = -1;
                string DelValue= Convert.ToString(e.CommandArgument);
                long ProcedID = Convert.ToInt64(DelValue.Split('~')[0]);
                long PatID = Convert.ToInt64(DelValue.Split('~')[1]);
                Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                if (ProcedID > 0)
                {
                    returnCode = objPatientBL.DeletePendingProcedure(PatID, VstID, ProcedID, OrgID);
                    if (returnCode == 0)
                    {
                        Response.Redirect("../Dialysis/PendingPhysioSearch.aspx");
                    }
                }
                else 
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('You cannot delete this procedure');", true);
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Delete the proceudre in gvPendingPhysio_RowCommand", ex);
        }
    }
    protected void gvPendingPhysio_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient o = (Patient)e.Row.DataItem;
                Label lblnxtReview = (Label)e.Row.FindControl("lblNextReview");
                string strScript = "GetProcID('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + o.PatientID + "','"+ o.PatientVisitID + "','" + o.RelationTypeId + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                if (lblnxtReview.Text == DateTime.MinValue.ToString())
                {
                    lblnxtReview.Text = string.Empty;
                }
                Label lblTodaysVisit1 = (Label)e.Row.FindControl("lblTodaysVisit");
                Label lblTodaysVisitDate1 = (Label)e.Row.FindControl("lblTodaysVisitDate");
                if (lblTodaysVisit1.Text == "Y" && Convert.ToDateTime(lblTodaysVisitDate1.Text).ToString("dd/MM/yyyy") == DateTime.Today.ToString("dd/MM/yyyy") && RoleName != "Receptionist")
                {
                    e.Row.BackColor = System.Drawing.Color.BurlyWood;
                    e.Row.ToolTip = "Came for Next Sitting";
                }
                if (RoleName == "Receptionist")
                {
                    gvPendingPhysio.Columns[12].Visible = false;
                    gvPendingPhysio.Columns[6].Visible = false;
                }
                if (isCorporateOrg == "Y")
                {
                    gvPendingPhysio.Columns[2].Visible = false;
                    gvPendingPhysio.Columns[7].Visible = true;
                }
                else
                {
                    gvPendingPhysio.Columns[2].Visible = true;
                    gvPendingPhysio.Columns[7].Visible = false;
                }
                e.Row.Cells[12].ToolTip = "Delete this Pending Procedure";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying gvPendingPhysio_RowDataBound  page", ex);
        }
    }
   
    protected void gvPendingPhysio_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvPendingPhysio.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvPendingPhysio_PageIndexChanging", ex);
        }
       
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        if (Request.Form["OPid"] != null && Request.Form["OPid"].ToString() != "")
        {
            hdnPatientID.Value = Request.Form["OPid"];
        }
        string ProcID = hdnProcId.Value;
        string parentVisitID = hdnParentVisitID.Value;
        objPatient_BL = new Patient_BL(base.ContextInfo);
        returnCode = objPatient_BL.CheckVistDetails(OrgID, Convert.ToInt64(hdnPatientID.Value), out VisitID);



        //if (VisitID == 0)
        //{
            PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit pVisit = new PatientVisit();



            long phyID = -1;
            int otherID = -1;
            long referOrgID = -1;
            string feeType = String.Empty;
            string otherName = String.Empty;
            string physicianName = String.Empty;
            string referrerName = string.Empty;

            //int ClientID = 0;
            //int CorporateID = 0;
            int RateID;


          
            pVisit.VisitPurposeID = 14;
          //  pVisit.VisitPurposeID = 7;
            pVisit.PhysicianID = (int)phyID;
            pVisit.OrgID = OrgID;
            pVisit.PatientID = Convert.ToInt64(hdnPatientID.Value);
            pVisit.OrgAddressID = ILocationID;
            pVisit.SpecialityID = otherID;
            pVisit.ReferOrgID = referOrgID;
             
            pVisit.CreatedBy = LID;
            pVisit.ClientMappingDetailsID = 0;
            pVisit.VisitType = 0;
            pVisit.PhysicianName = "";
            pVisit.SecuredCode = "";
            pVisit.ParentVisitId = 0;


            long enteredPatientID = Convert.ToInt64(hdnPatientID.Value);
            int iTokenNo = 0;
            long lScheduleNo = 0;
            long lResourceTemplateNo = 0;
            string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
            DateTime dtFromTime = new DateTime();
            DateTime dtToTime = new DateTime();
            dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            int iRetTokenNumber = 0;
            string needIPNo = string.Empty;
            //List<Config> lstConfig = new List<Config>();
            //new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstConfig);
            //if (lstConfig.Count > 0)
            //    needIPNo = lstConfig[0].ConfigValue.Trim();
            needIPNo = "N";
            List<VisitClientMapping> lst = IPClientTpaInsurance1.GetClientValues(); ;
            returnCode = pvisitBL.SaveVisit(pVisit, out VisitID, enteredPatientID,
                                            iTokenNo, lScheduleNo, lResourceTemplateNo,
                                            sPassedTime, out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);




            //Response.Redirect("../InPatient/PhysiotherapyNotes.aspx?&pid=" + hdnPatientID.Value + "&page=" + "PPT" + "&vid=" + VisitID, true);

            Response.Redirect("../InPatient/PhysiotherapyNotes.aspx?&pid=" + hdnPatientID.Value + "&page=" + "PPT" + "&vid=" + VisitID + "&ProcID=" + ProcID + "&parentVID=" + parentVisitID, true);

        //}

        //else
        //{
        //    Response.Redirect("../InPatient/PhysiotherapyNotes.aspx?&pid=" + hdnPatientID.Value + "&page=" + "PPT" + "&vid=" + VisitID + "&ProcID=" + ProcID, true);

        //}




    }
    protected void btnConfirmVisit_Click(object sender, EventArgs e)
    {
        if (Request.Form["OPid"] != null && Request.Form["OPid"].ToString() != "")
        {
            hdnPatientID.Value = Request.Form["OPid"];
        }
        long ProcID = Convert.ToInt64(hdnProcId.Value);
        ProcID = 0;
        long parentVisitID = Convert.ToInt64(hdnParentVisitID.Value);
        try
        {
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            returnCode = objPatientBL.MakeVisitToPhysio(Convert.ToInt64(hdnPatientID.Value), parentVisitID, OrgID, ProcID);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Visit Confirm To Physiotherpist')", true);
            }
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error while executing MakeVisitToPhysio in PendingPhysioSearch.aspx.cs", ex);
        }
    }
}
