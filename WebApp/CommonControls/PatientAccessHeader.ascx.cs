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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_PatientMainHeaderl : BaseControl
{
    public CommonControls_PatientMainHeaderl()
        : base("CommonControls_PatientMainHeaderl_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblAge.Text = Age;
            if (BloodGroup!="-1")
            {
                lblBloodGroup.Text = BloodGroup;
            }
            else
            {
                lblBloodGroup.Text = "--";
            }
            
            lblName.Text = UserName;
            lblURNo.Text = URNo;


        }
    }
}
