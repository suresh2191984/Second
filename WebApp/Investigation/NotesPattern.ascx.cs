using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.ComponentModel;

public partial class Investigation_NotesPattern : BaseControl
{

    protected void Page_Load(object sender, EventArgs e)
    {


    }

    public void LoadPatientDemography(int OrgId, long PatientVisitId)
    {
        long returnCode = -1;
        List<PatientDemography> lstPatientDemoGraphy = new List<PatientDemography>();
        returnCode = new Investigation_BL(base.ContextInfo).GetPatientDemography(OrgId, PatientVisitId, out lstPatientDemoGraphy);
        if (lstPatientDemoGraphy.Count() > 0)
        {
            string patientHeader = string.Empty;


            lblPatientName.Text = lstPatientDemoGraphy[0].PatientName;
            lblVisitDate.Text = lstPatientDemoGraphy[0].VisitDate.ToString("dd/MM/yyyy hh:mm tt");
            lblPatientID.Text = lstPatientDemoGraphy[0].PatientID;
            lblCollectedOn.Text = lstPatientDemoGraphy[0].ReportedOn.ToString("dd/MM/yyyy hh:mm tt");
            lblVisitNo.Text = lstPatientDemoGraphy[0].ExternalVisitId;
            lblReportedOn.Text = lstPatientDemoGraphy[0].PrintedOn.ToString("dd/MM/yyyy hh:mm tt");
            lblAgeSex.Text = lstPatientDemoGraphy[0].Sex + "/" + lstPatientDemoGraphy[0].Age;
            lblPrintedOn.Text = lstPatientDemoGraphy[0].ClientName;// lstPatientDemoGraphy[0].PrintedOn.ToString();
            lblReferingPhysicianName.Text = lstPatientDemoGraphy[0].ReferingPhysicianName;
            lblVisitType.Text = lstPatientDemoGraphy[0].HospitalName;// lstPatientDemoGraphy[0].VisitType;


        }



    }

    public void loadText(int OrgID, long PatientVisitID, int TemplateID, long InvestigationID)
    {

        long returnCode = -1;
        List<InvestigationValues> InvestigationValues = new List<InvestigationValues>();
         List<InvReportTemplateFooter> invreportfooter = new List<InvReportTemplateFooter>();
        returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationValuesForID(OrgID, PatientVisitID, TemplateID, InvestigationID, out InvestigationValues);

        if (InvestigationValues.Count() > 0)
        {
            //lblInvestigationName.Text = InvestigationValues[0].InvestigationName;
            ltrlDescription.Text = InvestigationValues[0].Value;

        }
        else
        {
           // lblInvestigationName.Text = "";
            ltrlDescription.Text = "";
        }
        long returnCode1 = 0;

        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();

        returnCode1 = new Investigation_BL(base.ContextInfo).GetImageForApproval(OrgID, PatientVisitID, InvestigationID, out login);
        returnCode = new Investigation_BL(base.ContextInfo).GetInvreportFooter(OrgID, InvestigationValues[0].InvestigationID, out invreportfooter);
        if (login.LoginID > 0 && login.ImageSource!=null)
        {
            img1.Visible = false;
            lblTechnician.Visible = false;
            lblTechnicianTitle.Visible = true;
            lblTechnician2.Visible = false;
            img1.Src = "ImageHandler.ashx?InvID=" + InvestigationID + "&OrgId=" + OrgID + "&VisitId=" + PatientVisitID;
            lblTechnician.Text = login.Name;
            lblTechnicianTitle.Text = login.Qualification;
        }
        else
        {
            lblCollectedOn.Text = "--";
            img1.Visible = false;

            //lblTechnician.Text = invreportfooter[0].Name;
            //lblTechnician2.Text = invreportfooter[0].Title;

            lblTechnician.Visible = false;
            lblTechnician2.Visible = false;
            //if (invreportfooter.Count > 0)
            //{
            //    if (invreportfooter[0].InvestigationID > 0)
            //    {
            //        lblTechnician.Text = invreportfooter[0].Name;
            //        lblTechnician2.Text = invreportfooter[0].Title;

            //    }
            //    else 
            //    {
            //        lblTechnician.Text = invreportfooter[0].Name;
            //        lblTechnician2.Text = invreportfooter[0].Title;
            //    }
                

            //}
            //else
            //{
            //    lblTechnician.Text = "LabTechnician";
            //    lblTechnician2.Visible = false;
            //}
            //if (invreportfooter.)

            //if (OrgID == 67)
            //{
                
            //    lblTechnician.Text = "<table><tr><td>Mrs.Padhmaasree.R</td></tr><tr><td></td></tr><tr><td>Consultant Microbiologist</td></tr></table>";
            //}
            //else if (OrgID == 79)
            //{

            //    lblTechnician.Text = "<table><tr><td> </td></tr><tr><td></td></tr><tr><td>Laboratory Technologist</td></tr></table>";
            //}
            //else if (OrgID == 69)
            //{
                
            //    lblTechnician.Text = "<table><tr><td></td></tr><tr><td></td></tr><tr><td>Lab Technician</td></tr></table>";
            //}
            //else if (OrgID == 72)
            //{
            //    lblTechnician2.Visible = true;
            //    lblTechnician.Text = "<table><tr><td>Dr.Suman Roy DCP</td></tr><tr><td></td></tr><tr><td>Pathologist</td></tr><tr><td></td></tr><tr><td>KMC No: 35064</td></tr></table>";
            //    lblTechnician2.Text = "<table><tr><td>Dr. M.G. SATISH, MD(Path)</td></tr><tr><td></td></tr><tr><td>Pathologist</td></tr><tr><td></td></tr><tr><td>KMC No:49885</td></tr></table>";
            //}
            //else if (OrgID == 97)
            //{
            //    lblTechnician2.Visible = true;
            //    lblTechnician.Text = "<table><tr><td>Dr.Shashikala K,M.D(Path)</td></tr><tr><td></td></tr><tr><td>Pathologist</td></tr><tr><td></td></tr><tr><td></td></tr></table>";
            //    lblTechnician2.Text = "<table><tr><td></td></tr><tr><td></td></tr><tr><td>Technologist</td></tr><tr><td></td></tr><tr><td></td></tr></table>";
            //}
            //else if (OrgID == 92)
            //{
            //    lblTechnician2.Visible = true;
            //    lblTechnician.Text = "<table><tr><td>Dr.Rekha Radhesh,M.D(Path)</td></tr><tr><td></td></tr><tr><td>Pathologist</td></tr><tr><td></td></tr><tr><td>KMC No:27252</td></tr></table>";
            //    lblTechnician2.Text = "<table><tr><td>Dr.Sheela Praveen,DCP.</td></tr><tr><td></td></tr><tr><td>Pathologist</td></tr><tr><td></td></tr><tr><td>KMC No:28920</td></tr></table>";
            //}
            //else if (OrgID == 88)
            //{
            //    lblTechnician2.Visible = true;
            //    lblTechnician.Text = "<table><tr><td>Dr.P.T.Annamalai Ph.D</td></tr><tr><td></td></tr><tr><td>Director</td></tr><tr><td></td></tr></table>";
            //    lblTechnician2.Text = "<table><tr><td>Dr.Renji O Raphael. MD</td></tr><tr><td></td></tr><tr><td>Consultant Pathologist</td></tr><tr><td></td></tr></table>";
            //}
            //else if (OrgID ==1)
            //{
            //  lblTechnician2.Visible = true;
            //  lblTechnician.Text = "Authorized By";
                
            //}
            //else
            //{
            //    lblTechnician.Text = "Lab Technician";
            //}

        }
    }



    private System.Drawing.Image byteArrayToImage()
    {
        //long returnCode = 0;
        //GateWay gateWay = new GateWay(base.ContextInfo);
        //Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        //Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        //login.LoginName = "padhmaasree2625";
        //login.Password = "padhmaasree2625";
        //string IsLocked = "N";
        //int OrgID = OrgID;
        //returnCode = gateWay.AuthenticateUser(login, Session.SessionID, out loggedIn, out OrgID, out IsLocked);
        //byte[] byteArray = loggedIn.ImageSource;

        //if (byteArray != null)
        //{
        //    TypeConverter tc = TypeDescriptor.GetConverter(typeof(Bitmap));
        //    Bitmap b = (Bitmap)tc.ConvertFrom(byteArray);
        //    return b;
        //}
        return null;
    }

    public System.Drawing.Image BinaryToImage()
    {
        //long returnCode = 0;
        //GateWay gateWay = new GateWay(base.ContextInfo);
        //Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        //Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        //login.LoginName = "padhmaasree2625";
        //login.Password = "padhmaasree2625";
        //returnCode = gateWay.AuthenticateUser(login, Session.SessionID, out loggedIn);

        //byte[] binaryData = loggedIn.ImageSource;
        MemoryStream ms = new MemoryStream();
        System.Drawing.Image img = System.Drawing.Image.FromStream(ms);
        //img.Save("c:/image.jpg");

        return img;

    }




}
