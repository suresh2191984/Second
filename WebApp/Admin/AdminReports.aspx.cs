using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;


public partial class Admin_AdminReports : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }

        btnGo.Attributes.Add("onClick", "return ValidateReport()");

        chkToday.Attributes.Add("OnClick", "return setChkEnabled();");
        txtFrom.Attributes.Add("OnFocus", "return setTxtEnabled();");
        txtTo.Attributes.Add("OnFocus", "return setTxtEnabled();");
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
    }
    public void LoadData()
    {
        lblResult.Text = string.Empty;
        GridView1.Visible = true;
        Patient_BL adminReportsBL = new Patient_BL(base.ContextInfo);

        DataSet ds = new DataSet();
        List<AdminReports> lstPatient = new List<AdminReports>();
        string fromdate;
        string todate;

        if (chkToday.Checked == true)
        {
            fromdate = string.Empty;
            todate = string.Empty;
            
        }
        else 
        {
            fromdate = txtFrom.Text;
            todate = txtTo.Text;
        }

        string ddlSelectedValue = ddlReport.SelectedItem.Text;
        string[] GetSelectedValue;

        if (ddlSelectedValue.EndsWith("P"))
        {
            GetSelectedValue = ddlSelectedValue.Split('P');
        }
        else
        {
            GetSelectedValue = ddlSelectedValue.Split('V');
        }


        adminReportsBL.GetPatientDetails(ddlSelectedValue, fromdate, todate, out lstPatient);
        DataTable dt = new DataTable();

        dt.Columns.Add("Name");
        dt.Columns.Add("Age");
        dt.Columns.Add("Sex");
        dt.Columns.Add("Mobile");
        dt.Columns.Add("Phone");
        if (lstPatient.Count>0)
        {
            for (int i = 0; i < lstPatient.Count; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Name"] = lstPatient[i].Name;
                dr["Age"] = lstPatient[i].Age;
                dr["Sex"] = lstPatient[i].Sex;



                if (lstPatient[i].PhoneNumber.Length > 0)
                {
                    string[] phoneNo = lstPatient[i].PhoneNumber.Split('M');

                    if (phoneNo.Length > 0)
                    {
                        dr["Mobile"] = phoneNo[0].Substring(0, phoneNo[0].Length - 1) + "(M)";

                        dr["Phone"] = phoneNo[1].Substring(1, phoneNo[1].Length - 1);
                        dt.Rows.Add(dr);
                    }
                }
                else
                {
                    dr["Mobile"] = "";
                    dr["Phone"] = "";
                    dt.Rows.Add(dr);
                }
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        else{
        
            lblResult.Text = "No Matching Records found";
            GridView1.Visible = false;
           
        }




    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void chkToday_CheckedChanged(object sender, EventArgs e)
    {
        //if (chkToday.Checked)
        //{
        //    ImageButton1.Enabled = false;
        //    ImageButton2.Enabled = false;
        //    txtFrom.Enabled = false;
        //    txtTo.Enabled = false;
        //    txtFrom.Text = string.Empty;
        //    txtTo.Text = string.Empty;
        //}
        //else
        //{
        //    ImageButton1.Enabled = true;
        //    ImageButton2.Enabled = true;
        //    txtFrom.Enabled = true;
        //    txtTo.Enabled = true;
        //}
    }
    protected void txtFrom_TextChanged(object sender, EventArgs e)
    {

    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCategory.Text != "Select")
        {
            pnlDate.Visible = true;
            lblResult.Text = string.Empty;
        }
        else
        {
            pnlDate.Visible = false;
            lblResult.Text = string.Empty;
        }
        if (ddlCategory.Text == "Revenue")
        {
            ddlReport.Items.Clear();
            ddlReport.Items.Add("Select");
            ddlReport.Items.Add("Revenue from Dialysis");
            ddlReport.Items.Add("Revenue from ANC");
            ddlReport.Items.Add("Revenue from General OP");
            ddlReport.Items.Add("Pending Dues");
            ddlReport.Items.Add("Patients for each Doctor");

        }
        if (ddlCategory.Text == "Patient Related")
        {

            LoadPatientRelatedDetails();
        }
    }

   
    private void LoadPatientRelatedDetails()
    {
        try
        {
            long returnCode = -1;
            AdminReports_BL adminreportsBL = new AdminReports_BL(base.ContextInfo);
            List<AdminReports> adminreports = new List<AdminReports>();
            returnCode = adminreportsBL.GetVisitPurposeForReports(OrgID, out adminreports);
            if (returnCode == 0)
            {
                ddlReport.DataSource = adminreports;
                ddlReport.DataTextField = "VisitPurposeName";
                ddlReport.DataValueField = "VisitPurposeId";
                ddlReport.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading patient details", ex);
        }
        finally
        {
        }
    }
    protected void chkToday_PreRender(object sender, EventArgs e)
    {
        //if (chkToday.Checked)
        //{
        //    ImageButton1.Enabled = false;
        //    ImageButton2.Enabled = false;
        //    txtFrom.Enabled = false;
        //    txtTo.Enabled = false;
        //    txtFrom.Text = string.Empty;
        //    txtTo.Text = string.Empty;
        //}
        //else
        //{
        //    ImageButton1.Enabled = true;
        //    ImageButton2.Enabled = true;
        //    txtFrom.Enabled = true;
        //    txtTo.Enabled = true;
        //}
    }
}
