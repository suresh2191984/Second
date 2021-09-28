using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;

public partial class CommonControls_PendingICDCode : BaseControl
{
   
    public string HeaderText { get; set; }

    public string Mode { get; set; }

    

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    public void BindData(List<PatientComplaint> lstPatientComplaint)
    {
        if (lstPatientComplaint.Count > 0)
        {
            gvPendingICD.DataSource = lstPatientComplaint;
            gvPendingICD.DataBind();
            gvPendingICD.HeaderRow.Cells[0].Text = HeaderText;
        }
        else
        {
            gvPendingICD.DataSource = lstPatientComplaint;
            gvPendingICD.DataBind();
        }

        if (Mode == "View")
        {
            gvPendingICD.Columns[3].Visible = false;
           
        }
    }


    public List<PatientComplaint> GetPatientComplaint()
    {
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
      
        foreach (GridViewRow gr in gvPendingICD.Rows)
        {
            TextBox txtICDCode = (TextBox)gr.FindControl("txtICDCode");
            TextBox txtICDName = (TextBox)gr.FindControl("txtICDName");
            Label lblComplaintID = (Label)gr.FindControl("lblComplaintID");
            Label lblComplaintType = (Label)gr.FindControl("lblComplaintType");
            Label lblComplaintName = (Label)gr.FindControl("lblComplaintName");
          
            DropDownList ddlStatus = (DropDownList)gr.FindControl("ddlStatus");

           
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(lblComplaintID.Text);
            objPatientComplaint.ComplaintName = lblComplaintName.Text;
            objPatientComplaint.ICDCode = txtICDCode.Text;
            objPatientComplaint.ICDDescription =txtICDName.Text;
            objPatientComplaint.ICDCodeStatus = ddlStatus.SelectedValue;
            objPatientComplaint.ComplaintType = lblComplaintType.Text;
            lstPatientComplaintTemp.Add(objPatientComplaint);
        }
        return lstPatientComplaintTemp;
    }


    protected void gvPendingICD_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientComplaint pc = (PatientComplaint)e.Row.DataItem;

            Label lblPage = (Label)e.Row.FindControl("lblPage");
            Label lblComplaintType = (Label)e.Row.FindControl("lblComplaintType");
            DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");

            Label lblICDCode = (Label)e.Row.FindControl("lblICDCode");
            Label lblICDDescription = (Label)e.Row.FindControl("lblICDDescription");

            TextBox txtICDCode = (TextBox)e.Row.FindControl("txtICDCode");
            TextBox txtICDName = (TextBox)e.Row.FindControl("txtICDName");

            if (Mode == "View")
            {
                txtICDCode.Visible = false;
                txtICDName.Visible = false;
                lblICDCode.Visible = true;
                lblICDDescription.Visible = true;
            }
            
            if (lblComplaintType.Text == "CRC" || lblComplaintType.Text == "CRCO" || lblComplaintType.Text == "CRCB")
            {
                lblPage.Text = "Case Sheet";
                e.Row.BackColor = System.Drawing.Color.LightSlateGray;
            }
            if (lblComplaintType.Text == "CODA" || lblComplaintType.Text == "CODS" || lblComplaintType.Text == "CODP")
            {
                lblPage.Text = "Death Registration";
                e.Row.BackColor = System.Drawing.Color.Gray;
            }
            if (lblComplaintType.Text == "DSY")
            {
                lblPage.Text = "Discharge Summary";
                e.Row.BackColor = System.Drawing.Color.LightGreen;
            }

            if (lblComplaintType.Text == "PDI" || lblComplaintType.Text == "UNF" || lblComplaintType.Text == "QIC")
            {
                lblPage.Text = "Patient Diagnose";
                e.Row.BackColor = System.Drawing.Color.Pink;
            }

            if (lblComplaintType.Text == "OPRC")
            {
                lblPage.Text = "Operation Notes";
                e.Row.BackColor = System.Drawing.Color.PowderBlue;
               

            }
            if (lblComplaintType.Text == "Birth")
            {
                lblPage.Text = "Delivery Notes";
                e.Row.BackColor = System.Drawing.Color.Aqua;
            }
            if (lblComplaintType.Text == "NNN")
            {
                lblPage.Text = "Neonatal Notes";
                e.Row.BackColor = System.Drawing.Color.Cyan;
            }
            if (lblComplaintType.Text == "PHYC")
            {
                lblPage.Text = "Physiotheraphy Notes";
            }


            if (lblComplaintType.Text == "NPDI")
            {
                lblPage.Text = "-";
            }
            ddlStatus.SelectedValue = pc.ICDCodeStatus;
        }
        
    }
}
