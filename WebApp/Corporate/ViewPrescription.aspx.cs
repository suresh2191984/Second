using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;

public partial class Corporate_ViewPrescription : BasePage
{

    public Corporate_ViewPrescription()
        : base("Corporate\\ViewPrescription.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long PatientVisitID = 0;
    long PatientID = 0;
    string pPrescriptionNo  = "";
    List<Config> lstconfig = new List<Config>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            new GateWay(base.ContextInfo).GetConfigDetails("IsCorporateOrg", OrgID, out lstconfig);
            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
            {
                //lblNumber.Text = "Number";
                //lblName.Text = "Name";
                lblNumber.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_lblNumber;
                lblName.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_lblName;
               
            }
            else
            {
                //lblNumber.Text = "Patient Number";
                //lblName.Text = "Patient Name";
                lblNumber.Text = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblpatientnumber;
                lblName.Text = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblpatientname;
               
            }
            
            PatientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            PatientID = Convert.ToInt64(Request.QueryString["PatientID"]);
            pPrescriptionNo = Request.QueryString["PreNo"] == null ? "" : Request.QueryString["PreNo"];
            List<Patient> lstPatient = new List<Patient>();
            List<Physician> lstPhysician = new List<Physician>();
            List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
            Investigation_BL InvestionBL = new Investigation_BL(base.ContextInfo);
            InvestionBL.getPrintPrescription(PatientVisitID,pPrescriptionNo, out lstPatient, out lstPhysician, out lstPatientPrescription);

            if (lstPatient.Count() > 0)
            {
                lblPNumber.Text = ":" + lstPatient[0].PatientNumber;
                lblPname.Text = ":" + lstPatient[0].TitleName + lstPatient[0].Name;
                if (lstPatient[0].SEX == "M")
                {
                   // lblGender.Text = ":" + "Male" ;
                    lblGender.Text =":"+ Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_lblGenMale;
                }
                else
                {
                    //lblGender.Text = ":" + "Female";
                    lblGender.Text = ":" + Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_lblGenFemale;
                }
                lblAge.Text = ":" + lstPatient[0].Age;
                lblVoucherDtae.Text = ":" + lstPatient[0].DOB.ToString();
                if(lstPhysician.Count>0)
                lblDoctorname.Text = ":" + lstPhysician[0].PhysicianName;
            }
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<Patient> patients = new List<Patient>();
            //List<Patient> patient = new List<Patient>();
            //pBL.GetPatientDetailsPassingVisitID(PatientVisitID, out patient);
            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
            {
                pBL.GetEmployeeDemoandAddress(PatientID, out patients);
                if (patients.Count() > 0)
                {
                    lblPNumber.Text = ":" + patients[0].PatientNumber.ToString();
                }
                else lblPNumber.Text = "";
            }
            if (lstPatientPrescription.Count() > 0)
            {
                int i = 0;
                    TableRow headLine1Row = new TableRow();
                    TableCell headLineCell1 = new TableCell();
                    headLineCell1.ColumnSpan = 9;
                    headLineCell1.Text = "&nbsp;";
                    headLine1Row.Cells.Add(headLineCell1);

                    TableRow headRow = new TableRow();
                    TableCell headCell1 = new TableCell();
                    TableCell headCell2 = new TableCell();
                    TableCell headCell3 = new TableCell();
                    TableCell headCell4 = new TableCell();
                    TableCell headCell5 = new TableCell();
                    TableCell headCell6 = new TableCell();
                    TableCell headCell7 = new TableCell();
                    TableCell headCell8 = new TableCell();
                    TableCell headCell9 = new TableCell();
                       
                    headCell1.BorderWidth = 1;
                    headCell2.BorderWidth = 1;
                    headCell3.BorderWidth = 1;
                    headCell4.BorderWidth = 1;
                    headCell5.BorderWidth = 1;
                    headCell6.BorderWidth = 1;
                    headCell7.BorderWidth = 1;
                    headCell8.BorderWidth = 1;
                    headCell9.BorderWidth = 1;
                    headCell1.Attributes.Add("align", "left");
                    headCell1.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_sno;
                    headCell1.Width = Unit.Percentage(5);
                    headCell2.Attributes.Add("align", "left");
                    headCell2.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Particulars;
                    //headCell1.Width = Unit.Percentage(30);

                    headCell3.Attributes.Add("align", "left");
                    headCell3.Attributes.Add("style", "display:none");
                    headCell3.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Number;
                    headCell3.Width = Unit.Percentage(5);
                    headCell4.Attributes.Add("align", "left");
                    headCell4.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Frequency;
                    headCell4.Width = Unit.Percentage(10);
                    headCell5.Attributes.Add("align", "left");
                    headCell5.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Duration;
                    headCell5.Width = Unit.Percentage(6);
                    headCell6.Attributes.Add("align", "left");
                    headCell6.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Totalqty;
                    headCell6.Width = Unit.Percentage(5);
                    headCell7.Attributes.Add("align", "left");
                    headCell7.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Direction;
                    headCell7.Width = Unit.Percentage(15);
                    headCell8.Attributes.Add("align", "left");
                    headCell8.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Instruction;
                    headCell8.Width = Unit.Percentage(15);

                    headCell9.Attributes.Add("align", "left");
                    headCell9.Text = Resources.ClientSideDisplayTexts.Corporate_ViewPrescriptionSearch_ascx_cs_Comment;
                    headCell9.Width = Unit.Percentage(15);

                    headRow.Cells.Add(headCell1);
                    headRow.Cells.Add(headCell2);
                    headRow.Cells.Add(headCell3);
                    headRow.Cells.Add(headCell4);
                    headRow.Cells.Add(headCell5);
                    headRow.Cells.Add(headCell6);
                    headRow.Cells.Add(headCell7);
                    headRow.Cells.Add(headCell8);
                    headRow.Cells.Add(headCell8);
                    headRow.Cells.Add(headCell9);

                    billDetailLaser.Rows.Add(headRow);
                    TableRow headLine2Row = new TableRow();
                    TableCell headLineCell2 = new TableCell();
                    headLineCell2.ColumnSpan = 9;
                    headLineCell2.Text = "<hr/>";
                    headLine2Row.Cells.Add(headLineCell2);
                  
                    foreach (PatientPrescription objBD in lstPatientPrescription)
                    {
                        i += 1;
                        TableRow contentRow = new TableRow();
                        TableCell contentCell1 = new TableCell();
                        TableCell contentCell2 = new TableCell();
                        TableCell contentCell3 = new TableCell();
                        TableCell contentCell4 = new TableCell();
                        TableCell contentCell5 = new TableCell();
                        TableCell contentCell6 = new TableCell();
                        TableCell contentCell7 = new TableCell();
                        TableCell contentCell8 = new TableCell();
                        TableCell contentCell9 = new TableCell();
                        contentCell1.BorderWidth = 0;
                        contentCell2.BorderWidth = 0;
                        contentCell3.BorderWidth = 0;
                        contentCell4.BorderWidth = 0;
                        contentCell5.BorderWidth = 0;
                        contentCell6.BorderWidth = 0;
                        contentCell7.BorderWidth = 0;
                        contentCell8.BorderWidth = 0;
                        contentCell9.BorderWidth = 0;

                        contentCell1.Attributes.Add("align", "left");
                        contentCell1.Text = i.ToString();
                        contentCell1.Style.Add("padding-right", "1px");
                        contentCell1.Width = Unit.Percentage(5);

                        contentCell2.Attributes.Add("align", "left");
                        contentCell2.Style.Add("padding-left", "3px");
                        contentCell2.Text = objBD.BrandName;
                        contentCell2.Width = Unit.Percentage(30);
                        //-----------------------------------------------------------------------
                        //string[] strValue = objBD.ServiceCode.Split('~'); 
                        contentCell3.Attributes.Add("align", "left");
                        contentCell3.Attributes.Add("style", "display:none");
                        contentCell3.Text = objBD.DrugSource;
                        contentCell3.Width = Unit.Percentage(10);

                        contentCell4.Attributes.Add("align", "left");
                        contentCell4.Text = objBD .DrugFrequency;
                        contentCell4.Width = Unit.Percentage(10);

                        contentCell5.Attributes.Add("align", "left");
                        contentCell5.Text = objBD.Duration;
                        contentCell5.Width = Unit.Percentage(10);
                        //---------------------------------------------------------------------
                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Text = objBD.TotalQty.ToString();
                        contentCell6.Width = Unit.Percentage(10);

                        contentCell7.Attributes.Add("align", "left");
                        contentCell7.Text = objBD.Direction;
                        contentCell7.Width = Unit.Percentage(15);

                        contentCell8.Attributes.Add("align", "left");
                        contentCell8.Text = objBD.Instruction;
                        contentCell8.Width = Unit.Percentage(15);


                        contentCell9.Attributes.Add("align", "left");
                        contentCell9.Text = objBD.DrugStatus;
                        contentCell9.Width = Unit.Percentage(15);


                        contentRow.Cells.Add(contentCell1);
                        contentRow.Cells.Add(contentCell2);
                        contentRow.Cells.Add(contentCell3);
                        contentRow.Cells.Add(contentCell4);
                        contentRow.Cells.Add(contentCell5);
                        contentRow.Cells.Add(contentCell6);
                        contentRow.Cells.Add(contentCell7);
                        contentRow.Cells.Add(contentCell8);
                        contentRow.Cells.Add(contentCell9);
                        billDetailLaser.Rows.Add(contentRow);
                    }
                    TableRow headLine3Row = new TableRow();
                    TableCell headLineCell3 = new TableCell();
                    headLineCell3.ColumnSpan = 9;
                    headLineCell3.Text = "&nbsp;";
                    headLine3Row.Cells.Add(headLineCell3);
                    billDetailLaser.Rows.Add(headLine3Row);
                    lblVoucherno.Text = ":" + lstPatientPrescription[0].PrescriptionNumber;
                }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Corporate/PrescriptionSearch.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
