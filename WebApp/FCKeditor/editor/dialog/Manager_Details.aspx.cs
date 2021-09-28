/********************************************************************************************************************
// *** Author Name:Baskar
// *** Form Name:Manager_Details.aspx
// *** Created Date:
// *** Modified Date:
// *** Revision No:
**********************************************************************************************************************/
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Odbc;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    OdbcConnection con = new OdbcConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString.ToString());
    OdbcCommand cmd = new OdbcCommand();
    DataSet ds = new DataSet();
    OdbcDataAdapter da = new OdbcDataAdapter();
    OdbcDataReader dr;
    string id, sql;
    string s,user;
    StringBuilder sqlText;

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = ConfigurationManager.AppSettings["title"].ToString();
        lbl_name.Text = "";
        user = Convert.ToString(Session["user"]);
        if (user != "")
        {
            lbl_name.Text = "You are logged in as  <b>" + Convert.ToString(Session["user"]) + "<b>";
        }
        s = Request.Url.AbsolutePath.ToString();
        if (Request.QueryString["id"] == null)
        {
            //btn_submit.Attributes.Add("onclick", "return check_fields()");
            ibtn_submit.Attributes.Add("onclick", "return check_fields()");
            Admin_user1.Visible = false;
        }
        else
        {
            ibtn_update.Attributes.Add("onclick", "return check_fieldsUpdate()");
            //btn_submit.Attributes.Add("onclick", "return check_fieldsUpdate()");
        }

        string role = "";
        if (Session["role"] == null)
        {
            role = "";
        }
        else
        {
            role = Session["role"].ToString();
        }

        if (role == "")
        {
            Response.Redirect("../source/user/user_registration.aspx");
        }

        if (role == "Admin")
        {
            Admin_menu1.Visible = true;
            Funder_menu1.Visible = false;
        }
        else
        {
            Admin_menu1.Visible = false;
            Funder_menu1.Visible = true;
            if (role == "Manager")
            {
                btn_submit.Visible = false;
                btn_back.Visible = false;
            }
            else
            {
                Response.Redirect("../source/user/user_registration.aspx");
            }
        }

        if (Session["chk"] == "1")
        {
            btn_back.Visible = false;
            btn_submit.Visible = false;
        }
        Session["chk"] = null;

        if (!Page.IsPostBack)
        {
            con.Open();
            try
            {
                //string sql = "select bene_id,bene_name from tbl_beneficary_dtl where dos is not null";
                string sql = "select b.bene_id,b.bene_name from tbl_beneficary_dtl as b,tbl_bene_contact as con,tbl_country  as c where b.bene_id=con.bene_id and c.country_id=b.country and con.contact_type='Main' and b.appli_status is not null order by b.bene_name,c.country";
                da = new OdbcDataAdapter(sql, con);
                da.Fill(ds);
                lstorg.DataSource = ds;
                lstorg.DataTextField = "bene_name";
                lstorg.DataValueField = "bene_id";
                lstorg.DataBind();

                ds.Clear();
                sql = "select country_id,country from tbl_country";
                da = new OdbcDataAdapter(sql, con);
                da.Fill(ds);
                ddl_country.DataSource = ds;
                ddl_country.DataTextField = "country";
                ddl_country.DataValueField = "country_id";
                ddl_country.DataBind();
                ddl_country.Items.Insert(0, "-Select-");

                if (Request.QueryString["id"] != null)
                {
                    ibtn_submit.Visible = false;
                    ibtn_update.Visible = true;
                    int cid = 0;
                    lbldisp1.Visible = false;
                    lbldisp2.Visible = false;
                    //Label2.Visible = false;
                    Label5.Visible = false;
                    lbl_req2.Visible = false;
                    //txt_password.Visible = false;
                    //txt_confirm_password.Visible = false;
                    //txt_email_address.Visible = false;
                    txt_email_address.ReadOnly = true;
                    txt_confirm_email_address.Visible = false;
                    lbltitle.Visible = false;
                    ddl_title.Visible = false;
                    cmd.Parameters.Clear();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select a.*,b.country from tbl_manager_detail a inner join tbl_country b on a.country_id=b.country_id where manager_id = '" + Request.QueryString["id"] + "' and isactive=1";
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        //ddl_title.SelectedItem.Value = Convert.ToString(dr["title"]);
                        txt_firstname.Text       = Convert.ToString(dr["firstname"]);
                        txt_lastname.Text        = Convert.ToString(dr["lastname"]);
                        txt_telephone.Text       = Convert.ToString(dr["phone"]);
                        txt_other_telephone.Text = Convert.ToString(dr["otherphone"]);
                        txt_position_role.Text   = Convert.ToString(dr["positions"]);
                        txt_qualifications.Text  = Convert.ToString(dr["qualification"]);
                        txt_organisation.Text    = Convert.ToString(dr["organisation"]);
                        txt_email_address.Text   = Convert.ToString(dr["email"]);
                        txt_confirm_email_address.Text = Convert.ToString(dr["email"]);
                        //txt_password.Text = Convert.ToString(dr["pass"]);
                        //txt_confirm_password.Text = Convert.ToString(dr["pass"]);
                        txt_address1.Text = Convert.ToString(dr["address1"]);
                        txt_address2.Text = Convert.ToString(dr["address2"]);
                        txt_city.Text = Convert.ToString(dr["city"]);
                        txt_state_region.Text = Convert.ToString(dr["state_region"]);
                        txt_post_box_no.Text = Convert.ToString(dr["pobox"]);
                        
                        //ddl_country.SelectedItem.Value = Convert.ToString(dr["country_id"]);
                        ddl_country.SelectedItem.Text = Convert.ToString(dr["country"]);
                        ddl_country.SelectedItem.Value = Convert.ToString(dr["country_id"]);

                        cid = Convert.ToInt32(dr["country_id"]);
                        txt_postcode.Text = Convert.ToString(dr["postcode"]);
                        txt_mainphone.Text = Convert.ToString(dr["mainphone"]);
                        txt_faxno.Text = Convert.ToString(dr["fax"]);
                        txt_website.Text = Convert.ToString(dr["website"]);
                        btn_submit.Text = "Update";
                    }
                    
                    dr.Close();
                    cmd.Parameters.Clear();
                    cmd.CommandText = "select email from tbl_manager_detail where manager_id='" + Request.QueryString["id"] + "'";
                    string email = Convert.ToString(cmd.ExecuteScalar());
                    cmd.CommandText = "select pwd from tbl_user_login where uid='" + email + "'";
                    byte[] pwd = (byte[])cmd.ExecuteScalar();
                    System.Text.ASCIIEncoding en = new System.Text.ASCIIEncoding();
                    string password = en.GetString(pwd);
                    txt_password.Text = Convert.ToString(password);
                    txt_confirm_password.Text = Convert.ToString(password);
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from tbl_org_selection where manager_id = '" + Request.QueryString["id"] + "' order by manager_id,organsation_count";
                    dr = cmd.ExecuteReader();
                    while(dr.Read())
                    {
                        for (int j = 0; j < lstorg.Items.Count; j++)
                        {
                            if (lstorg.Items[j].Value == Convert.ToString(dr["organsation_id"]))
                            {
                                lstorg.Items[j].Selected = true;
                                break;
                            }
                        }
                    }

                }
            }
            catch(Exception ex)
            {
                btn_submit.Text = "Submit";
            }
            finally
            { con.Close(); }
        }
    }

    protected void btn_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("manager_management.aspx");
    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        int scnt = 0;
        con.Open();
        bool tflg = false;
        cmd = new OdbcCommand();
        cmd.Connection = con;
        OdbcTransaction trans = null;
        trans = con.BeginTransaction(IsolationLevel.Serializable);
        cmd.Transaction = trans;
        try
        {
            if (btn_submit.Text == "Update")
            {
                //int cnt = 1;
                int cnt1 = Convert.ToInt32(Request.QueryString["id"]);
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "update tbl_manager_detail set title=@title,firstname=@firstname,lastname=@lastname,phone=@phone,otherphone=@otherphone,positions=@positions,qualification=@qualification,organisation=@organisation,email=@email,pass=@pass,address1=@address1,address2=@address2,city=@city,state_region=@state_region,pobox=@pobox,country_id=@country_id,postcode=@postcode,mainphone=@mainphone,fax=@fax,website=@website where manager_id = '" + Request.QueryString["id"] + "'";
                sqlText = new StringBuilder("update tbl_manager_detail set firstname=?,lastname=?,");
                sqlText.Append("phone=?,otherphone=?,positions=?,qualification=?,organisation=?,");
                sqlText.Append("address1=?,address2=?,city=?,state_region=?,");
                sqlText.Append("pobox=?,country_id=?,postcode=?,mainphone=?,");
                sqlText.Append("fax=?,website=? where manager_id = '" + Request.QueryString["id"] + "'");
                cmd.CommandText = sqlText.ToString();
                //cmd.Parameters.AddWithValue("@title", ddl_title.SelectedValue);
                cmd.Parameters.AddWithValue("@firstname", txt_firstname.Text);
                cmd.Parameters.AddWithValue("@lastname", txt_lastname.Text);
                cmd.Parameters.AddWithValue("@phone", txt_telephone.Text);
                cmd.Parameters.AddWithValue("@otherphone", txt_other_telephone.Text);
                cmd.Parameters.AddWithValue("@positions", txt_position_role.Text);
                cmd.Parameters.AddWithValue("@qualification", txt_qualifications.Text);
                cmd.Parameters.AddWithValue("@organisation", txt_organisation.Text);
                //cmd.Parameters.AddWithValue("@", txt_password.Text);
                //cmd.Parameters.AddWithValue("@email", txt_email_address.Text);
                //cmd.Parameters.AddWithValue("@pass", txt_password.Text);
                cmd.Parameters.AddWithValue("@address1", txt_address1.Text);
                cmd.Parameters.AddWithValue("@address2", txt_address2.Text);
                cmd.Parameters.AddWithValue("@city", txt_city.Text);
                cmd.Parameters.AddWithValue("@state_region", txt_state_region.Text);
                cmd.Parameters.AddWithValue("@pobox", txt_post_box_no.Text);
                cmd.Parameters.AddWithValue("@country_id", ddl_country.SelectedValue);
                cmd.Parameters.AddWithValue("@postcode", txt_postcode.Text);
                cmd.Parameters.AddWithValue("@mainphone", txt_mainphone.Text);
                cmd.Parameters.AddWithValue("@fax", txt_faxno.Text);
                cmd.Parameters.AddWithValue("@website", txt_website.Text);
                //cmd.Parameters.AddWithValue("@isactive", cnt);
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "delete from tbl_org_selection where manager_id = '" + cnt1 + "'";
                cmd.ExecuteNonQuery();

                scnt = 0;
                for (int i = 0; i < lstorg.Items.Count; i++)
                {
                    if (lstorg.Items[i].Selected == true)
                    {
                        scnt = scnt + 1;
                        //cmd.CommandText = "update tbl_org_selection set id=" + cnt1 + ",sno=" + (i + 1) + ",orgid=" + lstorg.Items[i].Value;
                        cmd.CommandText = "insert into tbl_org_selection(manager_id,organsation_count,organsation_id) values(" + cnt1 + "," + scnt + "," + lstorg.Items[i].Value + ")";
                        cmd.ExecuteNonQuery();
                    }
                }
                cmd.Parameters.Clear();
                cmd.CommandText = "select email from tbl_manager_detail where manager_id='" + Request.QueryString["id"] + "'";
                string email = Convert.ToString(cmd.ExecuteScalar());
                //cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_user_login set pwd='" + txt_password.Text + "' where uid='" + email + "'";
                cmd.ExecuteNonQuery();
                trans.Commit();
                tflg = true;
                Response.Redirect("manager_management.aspx");
                //lbldisp.Text = "Data inserted successfully";
            }
            else
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select count(*) from tbl_user_login where uid = ?";
                cmd.Parameters.AddWithValue("@uid", txt_email_address.Text);
                if (Convert.ToInt32(cmd.ExecuteScalar()) == 0)
                {
                    int cnt = 1;
                    int cnt1 = 0;
                    cmd.Parameters.Clear();
                    //cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "insert into tbl_manager_detail(title,firstname,lastname,phone,otherphone,positions,qualification,organisation,email,pass,address1,address2,city,state_region,pobox,country_id,postcode,mainphone,fax,website) values(@title,@firstname,@lastname,@phone,@otherphone,@positions,@qualification,@organisation,@email,@pass,@address1,@address2,@city,@state_region,@pobox,@country_id,@postcode,@mainphone,@fax,@website)";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "call proc_insert_manager(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    cmd.Parameters.AddWithValue("@title", ddl_title.SelectedValue);
                    cmd.Parameters.AddWithValue("@firstname", txt_firstname.Text);
                    cmd.Parameters.AddWithValue("@lastname", txt_lastname.Text);
                    cmd.Parameters.AddWithValue("@phone", txt_telephone.Text);
                    cmd.Parameters.AddWithValue("@otherphone", txt_other_telephone.Text);
                    cmd.Parameters.AddWithValue("@positions", txt_position_role.Text);
                    cmd.Parameters.AddWithValue("@qualification", txt_qualifications.Text);
                    cmd.Parameters.AddWithValue("@organisation", txt_organisation.Text);
                    cmd.Parameters.AddWithValue("@email", txt_email_address.Text);
                    cmd.Parameters.AddWithValue("@pass", txt_password.Text);
                    cmd.Parameters.AddWithValue("@address1", txt_address1.Text);
                    cmd.Parameters.AddWithValue("@address2", txt_address2.Text);
                    cmd.Parameters.AddWithValue("@city", txt_city.Text);
                    cmd.Parameters.AddWithValue("@state_region", txt_state_region.Text);
                    cmd.Parameters.AddWithValue("@pobox", txt_post_box_no.Text);
                    cmd.Parameters.AddWithValue("@country_id", ddl_country.SelectedValue);
                    cmd.Parameters.AddWithValue("@postcode", txt_postcode.Text);
                    cmd.Parameters.AddWithValue("@mainphone", txt_mainphone.Text);
                    cmd.Parameters.AddWithValue("@fax", txt_faxno.Text);
                    cmd.Parameters.AddWithValue("@website", txt_website.Text);
                    cmd.Parameters.AddWithValue("@isactive", cnt);
                    cnt1 = Convert.ToInt32(cmd.ExecuteScalar());
                    //lbldisp.Text = "Data inserted successfully";

                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    scnt = 0;
                    for (int i = 0; i < lstorg.Items.Count; i++)
                    {
                        if (lstorg.Items[i].Selected == true)
                        {
                            scnt = scnt + 1;
                            //cmd.CommandText = "update tbl_org_selection set id=" + cnt1 + ",sno=" + (i + 1) + ",orgid=" + lstorg.Items[i].Value;
                            cmd.CommandText = "insert into tbl_org_selection(manager_id,organsation_count,organsation_id) values(" + cnt1 + "," + scnt + "," + lstorg.Items[i].Value + ")";
                            cmd.ExecuteNonQuery();
                        }
                    }
                    trans.Commit();
                    tflg = true;
                    Response.Redirect("manager_management.aspx");
                }
                else
                {
                    lbldisp.Text = "Email id already exists. Please enter new email id";
                }

            }
        }
        catch (Exception ex)
        {
            if (tflg == false)
            {
                lbldisp.Text = "Please try again later!...";
                trans.Rollback();
            }
        }
        finally
        { con.Close(); }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Assessor_project_app_status.aspx");
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect("beneapplicationstatus.aspx");
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        int nid = 0;
        if (Session["role"] == "Assessor")
        {
            Session["chk"] = "1";
            string sq = "select firstname,lastname,assessor_id from tbl_assessor_detail where email='" + Session["user"] + "'";
            OdbcDataAdapter daa = new OdbcDataAdapter(sq, con);
            DataTable dtt1 = new DataTable();
            daa.Fill(dtt1);
            if (dtt1.Rows.Count > 0)
            {
                DataRow dd1 = dtt1.Rows[0];
                nid = Convert.ToInt32(dd1["assessor_id"]);
            }
            Response.Redirect("Assessor_Details.aspx?id=" + nid);
        }
        else if (Session["role"] == "Manager")
        {
            Session["chk"] = "1";
            string sq = "select firstname,lastname,manager_id from tbl_manager_detail where email='" + Session["user"] + "'";
            OdbcDataAdapter daa = new OdbcDataAdapter(sq, con);
            DataTable dtt1 = new DataTable();
            daa.Fill(dtt1);
            if (dtt1.Rows.Count > 0)
            {
                DataRow dd1 = dtt1.Rows[0];
                nid = Convert.ToInt32(dd1["manager_id"]);
            }
            Response.Redirect("Manager_Details.aspx?id=" + nid);
        }
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            Session.Clear();
        }
        if (s.Contains("/User/") || s.Contains("/user/"))
        {
            Response.Redirect("user_registration.aspx");
        }
        else
        {
            Response.Redirect("user/user_registration.aspx");
        }
    }
    protected void ibtn_submit_Click(object sender, ImageClickEventArgs e)
    {
        int scnt = 0;
        con.Open();
        bool tflg = false;
        cmd = new OdbcCommand();
        cmd.Connection = con;
        OdbcTransaction trans = null;
        trans = con.BeginTransaction(IsolationLevel.Serializable);
        cmd.Transaction = trans;
        try
        {
            //if (btn_submit.Text == "Update")
            //{
            //    //int cnt = 1;
            //    int cnt1 = Convert.ToInt32(Request.QueryString["id"]);
            //    cmd.Parameters.Clear();
            //    cmd.CommandType = CommandType.Text;
            //    //cmd.CommandText = "update tbl_manager_detail set title=@title,firstname=@firstname,lastname=@lastname,phone=@phone,otherphone=@otherphone,positions=@positions,qualification=@qualification,organisation=@organisation,email=@email,pass=@pass,address1=@address1,address2=@address2,city=@city,state_region=@state_region,pobox=@pobox,country_id=@country_id,postcode=@postcode,mainphone=@mainphone,fax=@fax,website=@website where manager_id = '" + Request.QueryString["id"] + "'";
            //    cmd.CommandText = "update tbl_manager_detail set firstname=@firstname,lastname=@lastname,phone=@phone,otherphone=@otherphone,positions=@positions,qualification=@qualification,organisation=@organisation,address1=@address1,address2=@address2,city=@city,state_region=@state_region,pobox=@pobox,country_id=@country_id,postcode=@postcode,mainphone=@mainphone,fax=@fax,website=@website where manager_id = '" + Request.QueryString["id"] + "'";
            //    //cmd.Parameters.AddWithValue("@title", ddl_title.SelectedValue);
            //    cmd.Parameters.AddWithValue("@firstname", txt_firstname.Text);
            //    cmd.Parameters.AddWithValue("@lastname", txt_lastname.Text);
            //    cmd.Parameters.AddWithValue("@phone", txt_telephone.Text);
            //    cmd.Parameters.AddWithValue("@otherphone", txt_other_telephone.Text);
            //    cmd.Parameters.AddWithValue("@positions", txt_position_role.Text);
            //    cmd.Parameters.AddWithValue("@qualification", txt_qualifications.Text);
            //    cmd.Parameters.AddWithValue("@organisation", txt_organisation.Text);
            //    //cmd.Parameters.AddWithValue("@", txt_password.Text);
            //    //cmd.Parameters.AddWithValue("@email", txt_email_address.Text);
            //    //cmd.Parameters.AddWithValue("@pass", txt_password.Text);
            //    cmd.Parameters.AddWithValue("@address1", txt_address1.Text);
            //    cmd.Parameters.AddWithValue("@address2", txt_address2.Text);
            //    cmd.Parameters.AddWithValue("@city", txt_city.Text);
            //    cmd.Parameters.AddWithValue("@state_region", txt_state_region.Text);
            //    cmd.Parameters.AddWithValue("@pobox", txt_post_box_no.Text);
            //    cmd.Parameters.AddWithValue("@country_id", ddl_country.SelectedValue);
            //    cmd.Parameters.AddWithValue("@postcode", txt_postcode.Text);
            //    cmd.Parameters.AddWithValue("@mainphone", txt_mainphone.Text);
            //    cmd.Parameters.AddWithValue("@fax", txt_faxno.Text);
            //    cmd.Parameters.AddWithValue("@website", txt_website.Text);
            //    //cmd.Parameters.AddWithValue("@isactive", cnt);
            //    cmd.ExecuteNonQuery();

            //    cmd.Parameters.Clear();
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "delete from tbl_org_selection where manager_id = '" + cnt1 + "'";
            //    cmd.ExecuteNonQuery();

            //    scnt = 0;
            //    for (int i = 0; i < lstorg.Items.Count; i++)
            //    {
            //        if (lstorg.Items[i].Selected == true)
            //        {
            //            scnt = scnt + 1;
            //            //cmd.CommandText = "update tbl_org_selection set id=" + cnt1 + ",sno=" + (i + 1) + ",orgid=" + lstorg.Items[i].Value;
            //            cmd.CommandText = "insert into tbl_org_selection(manager_id,organsation_count,organsation_id) values(" + cnt1 + "," + scnt + "," + lstorg.Items[i].Value + ")";
            //            cmd.ExecuteNonQuery();
            //        }
            //    }
            //    cmd.Parameters.Clear();
            //    cmd.CommandText = "select email from tbl_manager_detail where manager_id='" + Request.QueryString["id"] + "'";
            //    string email = Convert.ToString(cmd.ExecuteScalar());
            //    //cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "update tbl_user_login set pwd='" + txt_password.Text + "' where uid='" + email + "'";
            //    cmd.ExecuteNonQuery();
            //    trans.Commit();
            //    tflg = true;
            //    Response.Redirect("manager_management.aspx");
            //    //lbldisp.Text = "Data inserted successfully";
            //}
            //else
            if (btn_submit.Text == "Submit")
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select count(*) from tbl_user_login where uid = ?";
                cmd.Parameters.AddWithValue("@uid", txt_email_address.Text);
                if (Convert.ToInt32(cmd.ExecuteScalar()) == 0)
                {
                    int cnt = 1;
                    int cnt1 = 0;
                    cmd.Parameters.Clear();
                    //cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "insert into tbl_manager_detail(title,firstname,lastname,phone,otherphone,positions,qualification,organisation,email,pass,address1,address2,city,state_region,pobox,country_id,postcode,mainphone,fax,website) values(@title,@firstname,@lastname,@phone,@otherphone,@positions,@qualification,@organisation,@email,@pass,@address1,@address2,@city,@state_region,@pobox,@country_id,@postcode,@mainphone,@fax,@website)";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "call proc_insert_manager(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    cmd.Parameters.AddWithValue("@title", ddl_title.SelectedValue);
                    cmd.Parameters.AddWithValue("@firstname", txt_firstname.Text);
                    cmd.Parameters.AddWithValue("@lastname", txt_lastname.Text);
                    cmd.Parameters.AddWithValue("@phone", txt_telephone.Text);
                    cmd.Parameters.AddWithValue("@otherphone", txt_other_telephone.Text);
                    cmd.Parameters.AddWithValue("@positions", txt_position_role.Text);
                    cmd.Parameters.AddWithValue("@qualification", txt_qualifications.Text);
                    cmd.Parameters.AddWithValue("@organisation", txt_organisation.Text);
                    cmd.Parameters.AddWithValue("@email", txt_email_address.Text);
                    cmd.Parameters.AddWithValue("@pass", txt_password.Text);
                    cmd.Parameters.AddWithValue("@address1", txt_address1.Text);
                    cmd.Parameters.AddWithValue("@address2", txt_address2.Text);
                    cmd.Parameters.AddWithValue("@city", txt_city.Text);
                    cmd.Parameters.AddWithValue("@state_region", txt_state_region.Text);
                    cmd.Parameters.AddWithValue("@pobox", txt_post_box_no.Text);
                    cmd.Parameters.AddWithValue("@country_id", ddl_country.SelectedValue);
                    cmd.Parameters.AddWithValue("@postcode", txt_postcode.Text);
                    cmd.Parameters.AddWithValue("@mainphone", txt_mainphone.Text);
                    cmd.Parameters.AddWithValue("@fax", txt_faxno.Text);
                    cmd.Parameters.AddWithValue("@website", txt_website.Text);
                    cmd.Parameters.AddWithValue("@isactive", cnt);
                    cnt1 = Convert.ToInt32(cmd.ExecuteScalar());
                    //lbldisp.Text = "Data inserted successfully";

                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    scnt = 0;
                    for (int i = 0; i < lstorg.Items.Count; i++)
                    {
                        if (lstorg.Items[i].Selected == true)
                        {
                            scnt = scnt + 1;
                            //cmd.CommandText = "update tbl_org_selection set id=" + cnt1 + ",sno=" + (i + 1) + ",orgid=" + lstorg.Items[i].Value;
                            cmd.CommandText = "insert into tbl_org_selection(manager_id,organsation_count,organsation_id) values(" + cnt1 + "," + scnt + "," + lstorg.Items[i].Value + ")";
                            cmd.ExecuteNonQuery();
                        }
                    }
                    trans.Commit();
                    tflg = true;
                    Response.Redirect("manager_management.aspx");
                }
                else
                {
                    lbldisp.Text = "Email id already exist. Please enter new email id";
                    txt_email_address.Text = "";
                    txt_confirm_email_address.Text = "";
                    Response.Write("<script>document.getElementById('txt_email_address').focus();</script>");
                    txt_email_address.Focus();
                }

            }
        }
        catch (Exception ex)
        {
            if (tflg == false)
            {
                lbldisp.Text = "Please Try Again Later";
                trans.Rollback();
            }
        }
        finally
        { con.Close(); }
    }
    protected void ibtn_update_Click(object sender, ImageClickEventArgs e)
    {
        int scnt = 0;
        con.Open();
        bool tflg = false;
        cmd = new OdbcCommand();
        cmd.Connection = con;
        OdbcTransaction trans = null;
        trans = con.BeginTransaction(IsolationLevel.Serializable);
        cmd.Transaction = trans;
        try
        {
            if (btn_submit.Text == "Update")
            {
                //int cnt = 1;
                int cnt1 = Convert.ToInt32(Request.QueryString["id"]);
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "update tbl_manager_detail set title=@title,firstname=@firstname,lastname=@lastname,phone=@phone,otherphone=@otherphone,positions=@positions,qualification=@qualification,organisation=@organisation,email=@email,pass=@pass,address1=@address1,address2=@address2,city=@city,state_region=@state_region,pobox=@pobox,country_id=@country_id,postcode=@postcode,mainphone=@mainphone,fax=@fax,website=@website where manager_id = '" + Request.QueryString["id"] + "'";
                sqlText = new StringBuilder("update tbl_manager_detail set firstname=?,lastname=?,phone=?,otherphone=?,");
                sqlText.Append("positions=?,qualification=?,organisation=?,address1=?,address2=?,city=?,");
                sqlText.Append("state_region=?,pobox=?,country_id=?,postcode=?,mainphone=?,fax=?,website=? ");
                sqlText.Append("where manager_id = '" + Request.QueryString["id"] + "'");
                cmd.CommandText = sqlText.ToString();
                //cmd.Parameters.AddWithValue("@title", ddl_title.SelectedValue);
                cmd.Parameters.AddWithValue("@firstname", txt_firstname.Text);
                cmd.Parameters.AddWithValue("@lastname", txt_lastname.Text);
                cmd.Parameters.AddWithValue("@phone", txt_telephone.Text);
                cmd.Parameters.AddWithValue("@otherphone", txt_other_telephone.Text);
                cmd.Parameters.AddWithValue("@positions", txt_position_role.Text);
                cmd.Parameters.AddWithValue("@qualification", txt_qualifications.Text);
                cmd.Parameters.AddWithValue("@organisation", txt_organisation.Text);
                //cmd.Parameters.AddWithValue("@", txt_password.Text);
                //cmd.Parameters.AddWithValue("@email", txt_email_address.Text);
                //cmd.Parameters.AddWithValue("@pass", txt_password.Text);
                cmd.Parameters.AddWithValue("@address1", txt_address1.Text);
                cmd.Parameters.AddWithValue("@address2", txt_address2.Text);
                cmd.Parameters.AddWithValue("@city", txt_city.Text);
                cmd.Parameters.AddWithValue("@state_region", txt_state_region.Text);
                cmd.Parameters.AddWithValue("@pobox", txt_post_box_no.Text);
                cmd.Parameters.AddWithValue("@country_id", ddl_country.SelectedValue);
                cmd.Parameters.AddWithValue("@postcode", txt_postcode.Text);
                cmd.Parameters.AddWithValue("@mainphone", txt_mainphone.Text);
                cmd.Parameters.AddWithValue("@fax", txt_faxno.Text);
                cmd.Parameters.AddWithValue("@website", txt_website.Text);
                //cmd.Parameters.AddWithValue("@isactive", cnt);
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "delete from tbl_org_selection where manager_id = '" + cnt1 + "'";
                cmd.ExecuteNonQuery();

                scnt = 0;
                for (int i = 0; i < lstorg.Items.Count; i++)
                {
                    if (lstorg.Items[i].Selected == true)
                    {
                        scnt = scnt + 1;
                        //cmd.CommandText = "update tbl_org_selection set id=" + cnt1 + ",sno=" + (i + 1) + ",orgid=" + lstorg.Items[i].Value;
                        cmd.CommandText = "insert into tbl_org_selection(manager_id,organsation_count,organsation_id) values(" + cnt1 + "," + scnt + "," + lstorg.Items[i].Value + ")";
                        cmd.ExecuteNonQuery();
                    }
                }
                cmd.Parameters.Clear();
                cmd.CommandText = "select email from tbl_manager_detail where manager_id='" + Request.QueryString["id"] + "'";
                string email = Convert.ToString(cmd.ExecuteScalar());
                //cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_user_login set pwd='" + txt_password.Text + "' where uid='" + email + "'";
                cmd.ExecuteNonQuery();
                trans.Commit();
                tflg = true;
                Response.Redirect("manager_management.aspx");
                //lbldisp.Text = "Data inserted successfully";
            }
        }
        catch (Exception ex)
        {
            if (tflg == false)
            {
                lbldisp.Text = "Please Try Again Later";
                trans.Rollback();
            }
        }
        finally
        { con.Close(); }
    }
}
        
    
