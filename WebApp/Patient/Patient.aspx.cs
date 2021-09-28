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

public partial class Masters_Patient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    if (CheckView())
        //    {

        //    }
        //    if (CheckModify())
        //    {

        //    }
        //    LoadTitle();
        //}

    }
    protected void rbtnPermanent_CheckedChanged(object sender, EventArgs e)
    {
        //if (rbtnPermanent.Checked == true)
        //{
        //    pnlPermanent.Visible = true;
        //    pnlTemp.Visible = false;
        //    pnlAlternate.Visible = false;
        //}
    }
    protected void rbtnTemp_CheckedChanged(object sender, EventArgs e)
    {
        //pnlPermanent.Visible = false;
        //pnlTemp.Visible = true;
        //pnlAlternate.Visible = false;
    }
    protected void rbtnAlternate_CheckedChanged(object sender, EventArgs e)
    {
        //pnlPermanent.Visible = false;
        //pnlTemp.Visible = false;
        //pnlAlternate.Visible = true;
    }

    private bool CheckModify()
    {
        DataTable dt = (DataTable)Session["UserObj"];
        foreach (DataRow dr in dt.Select("SeqNo='" + Session["pageurlindex"].ToString() + "'"))       
        {
            if (dr["PermName"].ToString() == "Modify")
            {
                return true;
            }
        }
        return false;
    }
    private bool CheckView()
    {
        DataTable dt = (DataTable)Session["UserObj"];
        foreach (DataRow dr in dt.Select("SeqNo='" + Session["pageurlindex"].ToString() + "'"))
        {
            if (dr["PermName"].ToString() == "View")
            {
                return true;
            }
        }
        return false;
    }
    private void LoadTitle()
    {

        //DataSet ds = new DataSet();
        //DataTable dt = new DataTable();
        //Attune.Podium.BusinessEntities.Title obj = new Attune.Podium.BusinessEntities.Title();
        //Attune.Solution.BusinessComponent.Title_BL objBL = new Attune.Solution.BusinessComponent.Title_BL(base.ContextInfo);
        //ddSalutation.Items.Clear();
        //try
        //{
        //    ds = objBL.GetTitle(obj);
        //    dt = ds.Tables[0];
        //    ListItem ObjItem1 = new ListItem();
        //    ObjItem1.Text = ("Select Title");
        //    ObjItem1.Value = ("-1");
        //    ddSalutation.Items.Add(ObjItem1);
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        ListItem ObjItem = new ListItem();
        //        ObjItem.Text = (dr["TitleName"].ToString());
        //        ObjItem.Value = (dr["TitleID"].ToString());
        //        ddSalutation.Items.Add(ObjItem);
        //    }


        //}
        //catch (Exception x)
        //{
        //}
        //finally
        //{
        //}
    }
    char Martial;
    char Sex;
    char ISBit;
   
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        //if (ddMarital.SelectedValue == "Single")
        //    Martial = 'S';
        //else if (ddMarital.SelectedValue == "Married")
        //    Martial = 'M';
        //else if (ddMarital.SelectedValue == "Divorced")
        //    Martial = 'D';
        //else
        //    Martial = 'N';

        //if (ddSex.SelectedValue == "Male")
        //    Sex = 'M';
        //else if (ddMarital.SelectedValue == "Female")
        //    Sex = 'F';
        //else if (ddMarital.SelectedValue == "Others")
        //    Sex = 'O';
        //else
        //    Sex = 'N';

        //if (cbxConfidential.Checked == true)
        //    ISBit = '1';
        //else
        //    ISBit = '0';
        
       
         
        //string DOBDate = txtDOB.Text;
        //string DOBString = DOBDate + " " + "12:00:00 AM";
        //DateTime DOB = Convert.ToDateTime(DOBString);
        //int count = 0;
        
        //string Blood = string.Empty;

        //string addr1 = AlternateAddress.Get_Address1.ToString();
        //string addr2 = AlternateAddress.Get_Address2.ToString();
        //string addr3 = AlternateAddress.Get_Address3.ToString();
        //string postalcode = AlternateAddress.PostalCode.ToString();
        //string city = AlternateAddress.City.ToString();
        //string country = AlternateAddress.Country.ToString();
        //string state = AlternateAddress.State.ToString();
        //string Telephone=AlternateAddress.Telephone.ToString();
        //string Type = AlternateAddress.Type.ToString();

        //string paddr1 = PermanentAddress.Get_Address1.ToString();
        //string paddr2 = PermanentAddress.Get_Address2.ToString();
        //string paddr3 = PermanentAddress.Get_Address3.ToString();
        //string ppostalcode = PermanentAddress.PostalCode.ToString();
        //string pcity = PermanentAddress.City.ToString();
        //string pcountry = PermanentAddress.Country.ToString();
        //string pstate = PermanentAddress.State.ToString();
        //string pTelephone = PermanentAddress.Telephone.ToString();
        //string pType = PermanentAddress.Type.ToString();

        //string taddr1 = TempAddress.Get_Address1.ToString();
        //string taddr2 = TempAddress.Get_Address2.ToString();
        //string taddr3 = TempAddress.Get_Address3.ToString();
        //string tpostalcode = TempAddress.PostalCode.ToString();
        //string tcity = TempAddress.City.ToString();
        //string tcountry = TempAddress.Country.ToString();
        //string tstate = TempAddress.State.ToString();
        //string tTelephone = TempAddress.Telephone.ToString();
        //string tType = TempAddress.Type.ToString();



        //Attune.Podium.BusinessEntities.Patient obj = new Attune.Podium.BusinessEntities.Patient();
        //if (ddSalutation.SelectedIndex > 0)
        //{
        //    obj.TITLECode = Convert.ToByte(ddSalutation.SelectedItem.Text.ToString());
        //}
        //else
        //{
        //    obj.TITLECode = 0;
        //}
        //obj.Surname = txtName.Text.Trim();
        //obj.MiddleName = txtMiddleName.Text.Trim();
        //obj.Forename = txtForeName.Text.Trim();
        //obj.AliasName = txtAliasName.Text.Trim();
        //obj.AlternateContact = txtAlternamte.Text.Trim();
        //obj.DOB = DOB;
        //obj.OCCUPATION = txtOccupation.Text.Trim();
        //obj.MartialStatus = Convert.ToString(Martial);
        //obj.Religion = txtReligion.Text.Trim();
        //if (ddBloodGrp.SelectedIndex > 0)
        //{
        //    obj.BloodGroup = ddBloodGrp.SelectedItem.Text.ToString();
        //}
        //else
        //{
        //    obj.BloodGroup = "0";
        //}
        //if (ddSex.SelectedIndex > 0)
        //{
        //    obj.SEX = Convert.ToString(Sex);
        //}
        //else
        //{
        //    obj.SEX = "0";
        //}
        //obj.Comments = txtComments.Text.Trim();
        //obj.PersonalIdentification = txtPersonal.Text.Trim();
        //obj.PlaceOfBirth = txtPlaceOfBirth.Text.Trim();
        //obj.IsConfidential = ISBit.ToString();
        //obj.CreatedBy = "Admin";
        //obj.ModifiedBy = "Admin";
        //obj.ActiveStatus="1";
        //Attune.Solution.BusinessComponent.Patient_BL objBL = new Attune.Solution.BusinessComponent.Patient_BL(base.ContextInfo);
        //long ErrMsg = objBL.SavePatient(obj);
        //if (ErrMsg == 1)
        //{
        //    Session["TempMsg"] = "Successfully Registered";
        //    Response.Redirect("MsgForm.aspx");
        //}
        //else
        //{
        //    Session["TempMsg"] = "Error Occured";
        //    Response.Redirect("MsgForm.aspx");
        //}
     
    }
    protected void btnFinish_Click1(object sender, EventArgs e)
    {

    }
}
