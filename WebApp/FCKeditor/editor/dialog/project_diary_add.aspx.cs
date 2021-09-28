/***********************************************************************************************************************
// *** Author Name:Gajalakshmi
// *** Form Name:project_diary_add.aspx
// *** Created Date:
// *** Modified Date:
// *** Revision No:
************************************************************************************************************************/
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Odbc;

public partial class Source_project_diary_add1 : System.Web.UI.Page
{
    
    OdbcConnection con = new OdbcConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString.ToString());
    OdbcCommand cmd=new OdbcCommand();
    DataSet ds = new DataSet();
    OdbcDataAdapter da;
    OdbcDataReader dr;
    string id,sql;
    byte[][] pic1 = new byte[4][];
    string did = "";
    string pid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = ConfigurationManager.AppSettings["title"].ToString();
        lbl_bname.Text = "You are logged in as  <b>" + Convert.ToString(Session["user"]) + "<b>";
        did = Request.QueryString["pdc"];
        pid = Request.QueryString["pd"];
        fn_navigate();
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
        else if (role == "Admin")
        {
            Admin_menu1.Visible = true;
            Funder_menu1.Visible = false;
        }
        else if (role == "Community")
        {
            Admin_menu1.Visible = false;
            Funder_menu1.Visible = true;
            con.Open();
            sql = "select concat(firstname,' ',lastname) from tbl_bene_contact where contact_type='Main' and bene_id=(select bene_id from tbl_beneficary_dtl where mail_id=" + "'" + Session["user"] + "')";
            //sql = "select firstname+''+lastname from tbl_bene_contact where bene_id=(select bene_id from tbl_bene_contact where mail_id=" + Session["user"] + "'";
            cmd = new OdbcCommand(sql, con);
            string fullname = Convert.ToString(cmd.ExecuteScalar());
            lbl_bname.Text = "You are logged in as <b>" + fullname + "</b>";
            con.Close();

            //lbl_bname.Text = "You are logged in as "+Convert.ToString(Session["user"]);
        }
       id = Request.QueryString["id"];
       if (id != null)
       {
           ibtn_update.Attributes.Add("onclick", "return check_fields1()");
           //btn_submit.Attributes.Add("onclick", "return check_fields1()");
       }
       else
       {
           //btn_submit.Attributes.Add("onclick", "return check_fields()");
           ibtn_submit.Attributes.Add("onclick", "return check_fields()");
       }
      
        if(!Page.IsPostBack)
        {
            if (id != null)
                {
                    ibtn_submit.Visible = false;
                    ibtn_update.Visible = true;
                    fill_country();
                    DBind();
                    fn_edit_mode();
                }
                else
                {
                    lbl_proj_diary.Visible = false;
                    lbl_proj_name.Visible = false;
                    //DBind();
                    fill_country();
                }
         }
     
    }
    /*************************************************************************************************************** 
     * function name:fill_country()
     * 
     * Function description:
     * 
     * To bind the country(the country which has approved projects)  to the drop down list ddl_country.
     ***************************************************************************************************************/ 
    public void fill_country()
    {
        Support s = new Support();
        //da = new OdbcDataAdapter("select country_id,country from tbl_country where country_id in (select distinct country from tbl_project_dtl where approved='Approved') order by country", con);
        if (Convert.ToString(Session["role"]) == "Admin")
        {
            da = new OdbcDataAdapter("select country_id,country from tbl_country where country_id in (select distinct country from tbl_project_dtl where approved='Approved' and(status='Current' or status='Completed')) order by country", con);
        }
        else if (Convert.ToString(Session["role"]) == "Community")
        {
            da = new OdbcDataAdapter("select country_id,country from tbl_country where country_id in (select distinct country from tbl_project_dtl where approved='Approved' and(status='Current' or status='Completed') and com_id=" + s.GetCommunityId(Convert.ToString(Session["user"])) + ") order by country", con);
        }
        da.Fill(ds, "country");
        ddl_country.DataSource = ds.Tables["country"];
        ddl_country.DataTextField = "country";
        ddl_country.DataValueField = "country_id";
        ddl_country.DataBind();
        ddl_country.Items.Insert(0, "-----select-----");
        ddl_country.Items[0].Value = "0";
    }
   /*****************************************************************************************************************
    * function name:fn_chk_image()
    * Function description:
    * To check the image whether it is in 450* 450 pixels
    *****************************************************************************************************************/ 
    public bool fn_chk_image()
    {
        bool flg = false;
        lbl_error.Text = "";
        FileUpload fu = null;
        for (int i = 1; i < 5; i++)
        {
            fu = (FileUpload)form1.FindControl("file_img" + i);
            if (fu.PostedFile.ContentLength > 0)
            {
                pic1[i - 1] = new byte[fu.PostedFile.ContentLength];
                string tp = fu.PostedFile.ContentType.Split('/')[0];
                fu.PostedFile.InputStream.Read(pic1[i - 1], 0, fu.PostedFile.ContentLength);
                if (tp == "image")
                {
                    System.Drawing.Bitmap btmap1 = new System.Drawing.Bitmap(fu.PostedFile.InputStream);
                    if (btmap1.Width > 450 || btmap1.Height > 450)
                    {
                        lbl_error.Text += "Maximum size of image is 450*450 image " + i + " id not in that dimension<br>";
                        flg = true;
                    }
                }
                else
                {
                    lbl_error.Text += "Not a vaild Image for Image" + i + "<br>";
                    flg = true;
                }
            }
            else
            {
                pic1[i - 1] = new byte[0];
            }
        }
        return flg;
    }

   /*********************************************************************************************************************
    * Function name:name()
    * 
    * Function description:
    * 
    * To get the project  name for the project diary while editing.
    *********************************************************************************************************************/ 

     public string name()
    {
        cmd.Connection = con;
        con.Open();
        cmd.CommandText="select proj_name from tbl_project_dtl, tbl_project_diary where tbl_project_dtl.proj_id=tbl_project_diary.proj_id and diary_id="+id;
        string proj_name=Convert.ToString(cmd.ExecuteScalar());
        return proj_name;
    }
   /*********************************************************************************************************************
    * function name:fn_edit_mode()
    * 
    * Function description:
    * 
    * To retrieve the values from the tbl_project_diary based on the diary_id
    *********************************************************************************************************************/ 
    public void fn_edit_mode()
    {
        //lbl_date.Visible = false;
        //txt_date.Visible = false;
        lbl_country.Visible=false;
        ddl_country.Visible=false;
        lbl_project.Visible = false;
        lbl_proj_name.Text = name();
        btn_submit.Text = "Update";
        ddl_project_name.Visible = false;

       string sql1="select * from tbl_project_diary where diary_id=" + id;
       try
       {
           //con.Open();
           cmd=new OdbcCommand(sql1,con);
           dr=cmd.ExecuteReader();
           while(dr.Read())
           {
               txt_title.Text=Convert.ToString(dr["title"]);
               txt_content.Text = Convert.ToString(dr["content"]).ToString();
               txt_date.Text = Convert.ToString(dr["dos"]); 
               
           }
           dr.Close();
       }
        catch
       {
       }
        finally
       {
           con.Close();
       }
     

        //Retrieve the images from the table tbl_projdiary_img based on the diary_id

        //string sql="select img_description from tbl_projdiary_img where diary_id="+id;
         da = new OdbcDataAdapter("select img_description from tbl_projdiary_img where diary_id=" + id,con);
         //cmd = new OdbcCommand(sql, con);
         da.Fill(ds, "img1");
         TextBox tb = null;
         Image img = null;

         for (int i = 1; i <= ds.Tables["img1"].Rows.Count; i++)
         {
             tb = (TextBox)form1.FindControl("txt_desc" + i);
             img = (Image)form1.FindControl("img_diary" + i);
             tb.Text = Convert.ToString(ds.Tables["img1"].Rows[i - 1]["img_description"]);
             img.ImageUrl = "proj_diary_img.aspx?id=" + id + "&no=" + i;
         }

     }


     /*****************************************************************************************************************
      * Function name:DBind()
      * 
      * Function description:
      * 
      * To bind  the project name(the project status should be in current or completed). 
      *****************************************************************************************************************/ 

     public void DBind()
    {
        Support s = new Support();
        if (Convert.ToString(Session["role"]) == "Admin")
        {
            sql = "select proj_id,proj_name,status from tbl_project_dtl where country='" + ddl_country.SelectedValue + "' and approved='Approved' and(status='Current' or status='Completed') order by proj_name";
        }
        else if (Convert.ToString(Session["role"]) == "Community")
        {
            sql = "select proj_id,proj_name,status from tbl_project_dtl where country='" + ddl_country.SelectedValue + "' and approved='Approved' and(status='Current' or status='Completed') and com_id=" + s.GetCommunityId(Convert.ToString(Session["user"])) + " order by proj_name";
        }
        da = new OdbcDataAdapter(sql, con);
        da.Fill(ds, "proj_info");
        ddl_project_name.DataSource = ds.Tables["proj_info"];
        ddl_project_name.Items.Clear();
        if (ds.Tables["proj_info"].Rows.Count > 0)
        {
            ddl_project_name.DataTextField = "proj_name";
            ddl_project_name.DataValueField = "proj_id";
            ddl_project_name.DataBind();
            ddl_project_name.Items.Insert(0, "-----select-----");
            ddl_project_name.Items[0].Value = "0";
        }
        //else
        //{
        //   lbl_error.Text = "There is No Project In This Country ";
        //}
    }


    /*******************************************************************************************************************
       * function name:fn_add()
       * 
       * Function description:
       * 
       * To add the diary contents using the stored procedure proc_insert_diary to retrieve the diary id. 
       * And then add project diary information in to the tbl_project_diary with the diary id retrieve from the stored procedure.
    ********************************************************************************************************************/


    public void fn_add()
    {
        if (fn_chk_image())
        {
            return;
        }

        bool flg=false;
        bool flgdiary = false;
        cmd.Connection = con;
        con.Open();
       //// string s="select count(*) from tbl_project_diary where dos='"+DateTimeUtility.GetServerDate().ToString("MM/dd/yyyy")+ "'and proj_id='" + ddl_project_name.SelectedValue + "'";
        //string s = "select count(*) from tbl_project_diary where and proj_id='" + ddl_project_name.SelectedValue + "'";
        try
        {
            string s = "select count(*) from tbl_project_diary where dos='" + txt_date.Text + "'and proj_id='" + ddl_project_name.SelectedValue + "'";
            cmd = new OdbcCommand(s, con);
            int x = Convert.ToInt32(cmd.ExecuteScalar());
            if (x > 0)
            {
                flgdiary = true;
                lbl_error.Text = "Diary Entry for " + txt_date.Text + " already exist";
            }
            else
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "call proc_insert_diary(?,?,?,?,?)";
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.CommandText = "insert into tbl_project_diary(proj_id,dos,title,content,added_by)values(@proj_id,@dos,@title,@content,@added_by)";
                cmd.Parameters.AddWithValue("@proj_id", ddl_project_name.SelectedValue);
                cmd.Parameters.AddWithValue("@dos", Convert.ToDateTime(txt_date.Text));
                cmd.Parameters.AddWithValue("@title", txt_title.Text);
                cmd.Parameters.AddWithValue("@content", txt_content.Text);
                cmd.Parameters.AddWithValue("@added_by", Session["role"].ToString());
                //cmd.ExecuteNonQuery();
                //lbl_error.Text = "Sucessfully Added ";

                //cmd.CommandText = "select diary_id from tbl_project_diary where proj_id=" + ddl_project_name.SelectedValue;
                //int diary_id = Convert.ToInt32(cmd.ExecuteScalar());

                string diary_id = "";
                diary_id = cmd.ExecuteScalar().ToString();
                int ct = 1;
                TextBox tb = null;
                for (int i = 1; i < 5; i++)
                {
                    int len = pic1[i - 1].Length;
                    if (len > 0)
                    {
                        cmd.Parameters.Clear();
                        tb = (TextBox)form1.FindControl("txt_desc" + i);
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_projdiary_img(proj_id,diary_id,noof_img,img,img_description) values(?,?,?,?,?)";
                        //cmd.CommandText = "insert into tbl_projdiary_img(proj_id,noof_img,img,img_description) values(@proj_id,@noof_img,@img,@img_description)";
                        cmd.Parameters.AddWithValue("@proj_id", ddl_project_name.SelectedValue);
                        cmd.Parameters.AddWithValue("@diary_id", diary_id);
                        cmd.Parameters.AddWithValue("@noof_img", ct);
                        cmd.Parameters.AddWithValue("@img", pic1[i - 1]);
                        cmd.Parameters.AddWithValue("@img_description", tb.Text);
                        cmd.ExecuteNonQuery();
                        ct++;
                    }
                }

            }

        }
        catch
        {
            flg = true;
            lbl_error.Text = "Try again later";
        }
        finally
        {
            con.Close();
        }

        if (flg == false && flgdiary==false)
        {
            //Response.Redirect("Project_Diary_management.aspx");
            if (did != null && pid != null)
            {
                Response.Redirect("Project_Diary_management.aspx?dc=" + did + "&dp=" + pid);
            }
            else
            {
                Response.Redirect("Project_Diary_management.aspx");
            }
        }


           

                    //cmd.Connection = con;
        //con.Open();
        //string s = "select count(*) from tbl_project_diary where proj_id='" + ddl_project_name.SelectedValue + "'";
        //cmd = new OdbcCommand(s, con);
        //int x = Convert.ToInt32(cmd.ExecuteScalar());
        //if (x > 0)
        //{
        //    lbl_error.Text = "Project Diary already entered";
        //}
        //else
        //{
        //    try
        //    {
        //        string str = DateTimeUtility.GetServerDate().ToString("M/dd/yyyy");
        //       if (str == "06/14/2007")
        //        {
        //            cmd.Parameters.Clear();
        //            cmd.CommandText = "insert into tbl_project_diary(proj_id,dos,title,content)values(@proj_id,@dos,@title,@content)";
        //            cmd.Parameters.AddWithValue("@proj_id", ddl_project_name.SelectedValue);
        //            cmd.Parameters.AddWithValue("@dos", txt_date.Text);
        //            cmd.Parameters.AddWithValue("@title", txt_title.Text);
        //            cmd.Parameters.AddWithValue("@content", txt_content.Text);
        //            cmd.ExecuteNonQuery();
        //            lbl_error.Text = "Sucessfully Added ";
        //        }
        //    }
        //    catch
        //    {
        //        lbl_error.Text = "Try Again Later ";
        //    }

        //    finally
        //    {
        //        con.Close();
        //    }
        
    }

    /******************************************************************************************************************
       * function name:fn_edit()
       * 
       * Function description:
       * To retrieve the values  and images from the tbl_project_diary, tbl_projdiary_img based on the diary_id.
    *******************************************************************************************************************/

    public void fn_edit()
    {
      if (fn_chk_image())
        {
            return;
        }
        da = new OdbcDataAdapter("select img_description from tbl_projdiary_img where diary_id=" + id, con);
        ds.Clear();
        da.Fill(ds, "img");
        int imgct = ds.Tables["img"].Rows.Count;
        bool flg = false;
        //OdbcTransaction trans = null; 
        OdbcTransaction trans = null;
            cmd.Parameters.Clear();
            cmd.CommandText = "update tbl_project_diary set dos=?,title=?,content=? where diary_id=" + id;
            //cmd.Parameters.AddWithValue("@dos", Convert.ToDateTime(DateTime.Now).ToShortDateString());
            cmd.Parameters.AddWithValue("@dos", Convert.ToDateTime(txt_date.Text));
            cmd.Parameters.AddWithValue("@title", txt_title.Text);
            cmd.Parameters.AddWithValue("@content", txt_content.Text);
            //cmd.ExecuteNonQuery();
            //lbl_error.Text = "Sucessfully Updated ";
            try
            {
                con.Open();
                cmd.Connection = con;
                trans = con.BeginTransaction();
                cmd.Transaction = trans;
                cmd.ExecuteNonQuery();
                int ct = 1;

                TextBox tb = null;
                FileUpload fu = null;
                for (int i = 1; i <= 4; i++)
                {
                    fu = (FileUpload)form1.FindControl("file_img" + i);
                    tb = (TextBox)form1.FindControl("txt_desc" + i);
                    cmd.Parameters.Clear();
                    if (fu.PostedFile.ContentLength > 0)
                    {
                        if (i <= imgct)
                        {
                            cmd.CommandText = "update tbl_projdiary_img set img=?,img_description=? where diary_id=? and noof_img=?";
                            cmd.Parameters.AddWithValue("@img", pic1[i - 1]);
                            cmd.Parameters.AddWithValue("@desc", tb.Text);
                            cmd.Parameters.AddWithValue("@diary_id", id);
                            cmd.Parameters.AddWithValue("@no", i);
                            cmd.ExecuteNonQuery();
                            ct++;
                        }
                        else
                        {
                            cmd.CommandText = "insert into tbl_projdiary_img(diary_id,noof_img,img,img_description) values(?,?,?,?)";
                            cmd.Parameters.AddWithValue("@diary_id", id);
                            cmd.Parameters.AddWithValue("@noof_img", ct);
                            cmd.Parameters.AddWithValue("@img", pic1[i - 1]);
                            cmd.Parameters.AddWithValue("@img_description", tb.Text);
                            cmd.ExecuteNonQuery();
                            ct++;
                        }
                    }
                    else
                    {
                        if (i <= imgct)
                        {
                            cmd.CommandText = "update tbl_projdiary_img set img_description=? where diary_id=? and noof_img=?";
                            cmd.Parameters.AddWithValue("@desc", tb.Text);
                            cmd.Parameters.AddWithValue("@diary_id", id);
                            cmd.Parameters.AddWithValue("@no", i);
                            cmd.ExecuteNonQuery();
                            ct++;
                        }
                    }
                }
                trans.Commit();
            }

            catch
            {
                flg = true;
            }
        finally
        {
            con.Close();
        }
        if (flg == false)
        {
            Response.Redirect("Project_Diary_management.aspx?dc=" + did + "&dp=" + pid);
        }
    }
    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        //Response.Redirect("Project_Diary_management.aspx?dc=" + did + "&dp=" + pid);

        if (Convert.ToString(Session["role"]) == "Admin")
        {

            //if (Request.QueryString["dc"] != null && Request.QueryString["dp"] != null)
            if (Request.QueryString["pdc"] != null && Request.QueryString["pd"] != null)
            {
                Response.Redirect("Project_Diary_management.aspx?dc=" + did + "&dp=" + pid);
            }
            else
            {
                Response.Redirect("Project_Diary_management.aspx");
            }
        }
        else if (Convert.ToString(Session["role"]) == "Community")
        {
            // Response.Redirect("beneficiary_homepage.aspx");
            Response.Redirect("Project_Diary_management.aspx?dc=" + did + "&dp=" + pid);
        }
    }
    protected void ddl_project_name_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }


    protected void btn_submit_Click(object sender, EventArgs e)
    {
        if (id != null)
        {
            fn_edit();
        }
        else
        {
            fn_add();
        }
    }
    protected void ddl_country_SelectedIndexChanged(object sender, EventArgs e)
    {
        DBind();
    }
    //To handle keypress event (Enter key)
    public void fn_navigate()
    {
        ddl_project_name.Attributes.Add("onkeypress", "return onEnterKeyPress(event,'txt_title')");
        txt_title.Attributes.Add("onkeypress", "return onEnterKeyPress(event,'txt_content')");
        //txt_content.Attributes.Add("onkeypress", "return onEnterKeyPress(event,'txt_date')");
    }

    protected void ibtn_submit_Click(object sender, ImageClickEventArgs e)
    {
        //if (id != null)
        //{
        //    fn_edit();
        //}
        //else
        if(id==null)
        {
            fn_add();
        }
    }
    protected void ibtn_update_Click(object sender, ImageClickEventArgs e)
    {
        if (id != null)
        {
            fn_edit();
        }
    }
}
