/**********************************************************************************************************************
// *** Author Name: Balamurugan
// *** Form Name: Postproject4.aspx
************************************************************************************************************************/
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
using System.Text;
using System.Net.Mail;
using System.Data.Odbc;

public partial class Source_Postproject4 : System.Web.UI.Page
{
    OdbcConnection con = new OdbcConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString.ToString());
    OdbcDataAdapter da;
    OdbcCommand cmd = new OdbcCommand();
    DataSet ds = new DataSet();
    string sql,pid;
    StringBuilder sb;

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = ConfigurationManager.AppSettings["title"].ToString();
        lbl_mailid.Text = "You are logged in as  <b>" + Convert.ToString(Session["user"]) + "<b>";
        pid = Request.QueryString["pid"];
        if (Convert.ToString(Session["role"]) == "Admin")
        {
            Admin_menu1.Visible = true;
        }
        else if (Convert.ToString(Session["role"]) == "Community")
        {
            Funder_menu1.Visible = true;
        }
        else
        {
            Response.Redirect("User/user_registration.aspx");
        }
        lb_submit.Attributes.Add("onclick", "return fn_validate()");
        if (!IsPostBack)
        {
            DBind();
        }
        if (Session["pid"] == null)
        {
            chk_terms.Checked = true;
        }
    }

    /*************************************************************************************************************************
     * Function Name: DBind()
     * 
     * Function Description: Bind the contact from the tbl_bene_contact for the bene_id which passed through the querystring.
     * 
     *************************************************************************************************************************/

    public void DBind()
    {
        Support sup = new Support();
        if (Convert.ToString(Session["role"]) == "Admin")
        {
            da = new OdbcDataAdapter("select concat(firstname,' ',lastname) as cname,id from tbl_bene_contact where bene_id=" + Request.QueryString["com"], con);
        }
        else
        {
            da = new OdbcDataAdapter("select concat(firstname,' ',lastname) as cname,id from tbl_bene_contact where bene_id=" + sup.GetCommunityId(Convert.ToString(Session["user"])), con);
        }
        da.Fill(ds, "contact");
        ddl_contact.DataSource = ds.Tables["contact"];
        ddl_contact.DataTextField = "cname";
        ddl_contact.DataValueField = "id";
        ddl_contact.DataBind();
        ddl_contact.Items.Insert(0, "----------select----------");
        ddl_contact.Items[0].Value = "0";
        if (pid != null)
        {
            sql = "select proj_name,type,bene_name,location,proj_reason,proj_aim,proj_method,proj_partner,proj_phases,approved,proj_contact,proj_role from tbl_project_dtl inner join tbl_beneficary_dtl on tbl_project_dtl.proj_id=";
            sql += pid + " and tbl_project_dtl.com_id=tbl_beneficary_dtl.bene_id inner join tbl_project_type on tbl_project_dtl.proj_type=tbl_project_type.type_id";
        }
        else
        {
            sql = "select proj_name,type,bene_name,location,proj_reason,proj_aim,proj_method,proj_partner,proj_phases,approved,proj_contact,proj_role from tbl_project_dtl inner join tbl_beneficary_dtl on tbl_project_dtl.proj_id=";
            sql += Convert.ToString(Session["pid"]) + " and tbl_project_dtl.com_id=tbl_beneficary_dtl.bene_id inner join tbl_project_type on tbl_project_dtl.proj_type=tbl_project_type.type_id";
        }
        da = new OdbcDataAdapter(sql, con);
        da.Fill(ds, "proj");
        if (ds.Tables["proj"].Rows.Count > 0)
        {
            lbl_pname.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_name"]);
            lbl_ptype.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["type"]);
            lbl_comname.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["bene_name"]);
            lbl_location.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["location"]);
            lbl_reason.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_reason"]);
            lbl_aim.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_aim"]);
            lbl_method.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_method"]);
            lbl_partner.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_partner"]);
            lbl_nophase.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_phases"]);
            lbl_status.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["approved"]);
            ddl_contact.SelectedValue = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_contact"]);
            txt_crole.Text = Convert.ToString(ds.Tables["proj"].Rows[0]["proj_role"]);
            GetFund gf = new GetFund();
            if (pid != null)
            {
                lbl_pamt.Text = gf.GetTotalCost(pid);
            }
            else
            {
                lbl_pamt.Text = gf.GetTotalCost(Convert.ToString(Session["pid"]));
            }
        }
        else
        {
            lbl_error.Text = "Try Again Later ";
        }
    }
    protected void lb_editproj_Click(object sender, EventArgs e)
    {
        if (pid != null)
        {
            if (Convert.ToString(Session["role"]) == "Admin")
            {
                Response.Redirect("Postproject1.aspx?com=" + Request.QueryString["com"] + "&pid=" + pid + "&r=1");
            }
            else
            {
                Response.Redirect("Postproject1.aspx?pid=" + pid + "&r=1");
            }
        }
        else
        {
            if (Convert.ToString(Session["role"]) == "Admin")
            {
                Response.Redirect("Postproject1.aspx?com=" + Request.QueryString["com"] + "&pid=" + Convert.ToString(Session["pid"]) + "&r=1");
            }
            else
            {
                Response.Redirect("Postproject1.aspx?pid=" + Convert.ToString(Session["pid"]) + "&r=1");
            }
        }
    }
    protected void lb_editphase_Click(object sender, EventArgs e)
    {
        if (pid != null)
        {
            if (Convert.ToString(Session["role"]) == "Admin")
            {
                Response.Redirect("Postproject2.aspx?com=" + Request.QueryString["com"] + "&pid=" + pid + "&r=1");
            }
            else
            {
                Response.Redirect("Postproject2.aspx?pid=" + pid + "&r=1");
            }
        }
        else
        {
            if (Convert.ToString(Session["role"]) == "Admin")
            {
                Response.Redirect("Postproject2.aspx?com=" + Request.QueryString["com"] + "&pid=" + Convert.ToString(Session["pid"]) + "&r=1");
            }
            else
            {
                Response.Redirect("Postproject2.aspx?pid=" + Convert.ToString(Session["pid"]) + "&r=1");
            }
        }
    }
    protected void lb_submit_Click(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["pid"]) != "")
        {
            try
            {
                con.Open();
                cmd = new OdbcCommand("update tbl_project_dtl set date_submitted=?,submitted_by=?,proj_contact=?,proj_role=? where proj_id=" + Convert.ToString(Session["pid"]), con);
                cmd.Parameters.AddWithValue("@submitted", DateTimeUtility.GetServerDate().ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@submittedby", Convert.ToString(Session["user"]));
                cmd.Parameters.AddWithValue("@contact", ddl_contact.SelectedValue);
                cmd.Parameters.AddWithValue("@prole", txt_crole.Text);
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lbl_error.Text = "Try Again Later ";
            }
            finally
            {
                con.Close();
            }
        }
        //Session["pid"] = 1;
        if (Convert.ToString(Session["pid"]) != "")
        {
            sendMail();
        }
        Session["pid"] = null;
        if (Convert.ToString(Session["role"]) == "Admin")
        {
            Response.Redirect("project_management.aspx");
        }
        else if (Convert.ToString(Session["role"]) == "Community")
        {
            lbl_msg.Text = "Thank-you for submitting your project";
            string s = "<script>window.open('Successful.html', 'mywindow', 'menubar=0,resizable=no,top=250,left=250,width=330,height=50');</script>";
            Page.RegisterStartupScript("msg", s);
        }
    }
    OdbcDataAdapter ad;
    /*********************************************************************************************************************** 
     * Function Name: sendMail()
     * Function Description:
     * 
     * The system emails notifcation of this project request to the manager related to the organisation and the assessors related to the project type
     * 
     ***********************************************************************************************************************/
    private void sendMail()
    {
        sb = new StringBuilder("Select * from tbl_project_dtl where proj_id =" + Convert.ToString(Session["pid"]) + " ");

        ad = new OdbcDataAdapter(sb.ToString(), con);
        DataTable dt = new DataTable();
        ad.Fill(dt);
        if(dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            sb = new StringBuilder("Select a.manager_id,a.firstname,a.email from tbl_manager_detail a inner join tbl_org_selection b ");
            sb.Append("on a.manager_id = b.manager_id where b.organsation_id = " + Convert.ToInt32(dr["com_id"]) + " and a.isactive = 1 ");
            ad = new OdbcDataAdapter(sb.ToString(), con);
            DataTable dt1 = new DataTable();
            ad.Fill(dt1);

            sb = new StringBuilder("Select a.assessor_id,a.firstname,a.email from tbl_assessor_detail a inner join tbl_assessor_project_type b ");
            sb.Append("on a.assessor_id = b.assessor_id where b.project_type_id = " + Convert.ToInt32(dr["proj_type"]) + " and ");
            sb.Append(" a.isactive = 1 ");
            ad = new OdbcDataAdapter(sb.ToString(), con);
            DataTable dt2 = new DataTable();
            ad.Fill(dt2);

            DataTable dtFinal = new DataTable();
            dtFinal.Clear();
            dtFinal.Rows.Clear();
            dtFinal.Columns.Clear();

            dtFinal.Columns.Add("id");
            dtFinal.Columns.Add("type");
            dtFinal.Columns.Add("firstname");
            dtFinal.Columns.Add("email");
            for (int i = 0; i < dt1.Rows.Count; i++) // Manager Details
            {
                DataRow drManager = dt1.Rows[i];
                DataRow dr1 = dtFinal.NewRow();

                dr1["id"]       = drManager["manager_id"].ToString();
                dr1["type"]     = "Manager";
                dr1["firstname"] = drManager["firstname"].ToString();
                dr1["email"]    = drManager["email"].ToString();

                dtFinal.Rows.Add(dr1);
            }

            for (int i = 0; i < dt2.Rows.Count; i++) // Assessor Details
            {
                DataRow drAssessor = dt2.Rows[i];
                DataRow dr1 = dtFinal.NewRow();

                dr1["id"]            = drAssessor["assessor_id"].ToString();
                dr1["type"]         = "Assessor";
                dr1["firstname"]     = drAssessor["firstname"].ToString();
                dr1["email"]        = drAssessor["email"].ToString();

                dtFinal.Rows.Add(dr1);
            }

            // sending mail
            for (int j = 0; j < dtFinal.Rows.Count; j++)
            {
                DataRow drFinal = dtFinal.Rows[j];

                MailMessage mail = new MailMessage();
                MailAddress ma = new MailAddress(drFinal["email"].ToString());
                mail.To.Add(ma);
                //ma = new MailAddress(drFinal["email"].ToString());
                ma = new MailAddress(ConfigurationManager.AppSettings["admin"].ToString());
                mail.From = ma;
                mail.Subject = "New project to review on www.supportourproject.org";
                mail.IsBodyHtml = true;
                sb = new StringBuilder("Dear '" + drFinal["firstname"].ToString() + "' ");
                sb.Append("<br><br> A new project has been sumitted by '" + lbl_comname.Text + "' ");
                sb.Append("<br><br> Please login to your user area www.supportourproject.org and complete your review within 7 days. ");
                sb.Append("<br><br> Thank -you  ");
                sb.Append("<br><br> www.supportourproject.org Admin");
                mail.Body = sb.ToString();
                SmtpClient smtp = new SmtpClient();
                try
                {
                    smtp.Send(mail);
                }
                catch (SmtpException smtpEx)
                {
                    
                }
                finally
                {

                }

            }
            MailMessage maila = new MailMessage();
            MailAddress maa = new MailAddress(ConfigurationManager.AppSettings["admin"].ToString());
            maila.To.Add(maa);
            maa = new MailAddress(ConfigurationManager.AppSettings["admin"].ToString());
            maila.From = maa;
            
            maila.Subject = "New project to review on www.supportourproject.org";
            maila.IsBodyHtml = true;
            sb = new StringBuilder("Dear Admin,");
            //sql = new StringBuilder("Dear Admin,");
            sb.Append("<br><br> A new project has been sumitted by '" + lbl_comname.Text + "' ");
            sb.Append("<br><br> <br>Thank-you ");
            sb.Append("<br><br> www.supportourproject.org");
            maila.Body = sb.ToString();
            SmtpClient smtpa = new SmtpClient();
            try
            {
                smtpa.Send(maila);
            }
            catch (SmtpException smtpEx)
            {

            }
            finally
			{
			}
}
}
}