using System;
using System.Collections;
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
using System.Data.Odbc;
using System.Globalization;




public partial class SampleCollectionPerson_Controls_SPschedule : BaseControl

{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            {

                loadFromtime();
                loadTotime();
                loadmints();
             

            }
        
        }
    
    /// <summary>
    /// Set the Width of the CheckBoxList
    /// </summary>
    /// 

    int i = 0;
    int count = 0;
    public int WidthCheckListBox
    {
        set
        {
            chkList.Width = value;
            Panel111.Width = value + 20;
        }
    }
    /// <summary>
    /// Set the Width of the Combo
    /// </summary>
    public int Width
    {
        set { txtCombo.Width = value; }
        get { return (Int32)txtCombo.Width.Value; }
    }
    public bool Enabled
    {
        set { txtCombo.Enabled = value; }
    }
    /// <summary>
    /// Set the CheckBoxList font Size
    /// </summary>
    public FontUnit fontSizeCheckBoxList
    {
        set { chkList.Font.Size = value; }
        get { return chkList.Font.Size; }
    }
    /// <summary>
    /// Set the ComboBox font Size
    /// </summary>
    public FontUnit fontSizeTextBox
    {
        set { txtCombo.Font.Size = value; }
    }



    /// <summary>
    /// Add Items to the CheckBoxList.
    /// </summary>
    /// <param name="array">ArrayList to be added to the CheckBoxList</param>
    public void AddItems(ArrayList array)
    {
        for (int i = 0; i < array.Count; i++)
        {
            chkList.Items.Add(array[i].ToString());
        }
    }


    /// <summary>
    /// Add Items to the CheckBoxList
    /// </summary>
    /// <param name="dr"></param>
    /// <param name="nombreCampoTexto">Field Name of the OdbcDataReader to Show in the CheckBoxList</param>
    /// <param name="nombreCampoValor">Value Field of the OdbcDataReader to be added to each Field Name (it can be the same string of the textField)</param>
    public void AddItems(OdbcDataReader dr, string textField, string valueField)
    {
        ClearAll();
        int i = 0;
        while (dr.Read())
        {
            chkList.Items.Add(dr[textField].ToString());
            chkList.Items[i].Value = i.ToString();
            i++;
        }
    }


    /// <summary>
    /// Uncheck of the Items of the CheckBox
    /// </summary>
    public void unselectAllItems()
    {
        for (int i = 0; i < chkList.Items.Count; i++)
        {
            chkList.Items[i].Selected = false;
        }
    }

    /// <summary>
    /// Delete all the Items of the CheckBox;
    /// </summary>
    public void ClearAll()
    {
        txtCombo.Text = "";
        chkList.Items.Clear();
    }

    /// <summary>
    /// Get or Set the Text shown in the Combo
    /// </summary>
    public string Text
    {
        get { return hidVal.Value; }
        set { txtCombo.Text = value; }
    }

    public void loadmints()
    {
        //if (ddlFrom.Items.Count == 0)
        //{
           
        //    for (i = 0; i < 60; i++)
        //    {
        //        // ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), DateTime.Parse(dt.ToString(), new CultureInfo("en-GB")).ToString("hh:mm.FF tt")));
        //        ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), dt.ToString("hh:mm.FF tt", new CultureInfo("en-GB"))));

        //        dt = dt.AddMinutes(30);
        //    }
        //}
        var minutes  = Enumerable.Range(00, 60).Select(i => i.ToString("D2"));

        ddlmints.DataSource = minutes;
        ddlmints.DataBind();
    }
    public void loadFromtime()
    {

        hdnUserID.Value = Convert.ToString(LID) ;
        hdnOrgID.Value = Convert.ToString(OrgID);
        hdnLocName.Value = Convert.ToString(LocationName);
        if (ddlFrom.Items.Count == 0)
        {
            //DateTime dt = Convert.ToDateTime("12:00 am");
            //DateTime time = DateTime.MinValue;
            //DateTime value = DateTime.MinValue;
            //for (i = 0; i < 48; i++)
            //{
            //    // ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), DateTime.Parse(dt.ToString(), new CultureInfo("en-GB")).ToString("hh:mm.FF tt")));
            //    ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), dt.ToString("hh:mm.FF tt", new CultureInfo("en-GB"))));

            //    dt = dt.AddMinutes(30);
            DateTime dt = Convert.ToDateTime("12:00 am");
            DateTime time = DateTime.MinValue;
            DateTime value = DateTime.MinValue;
            for (i = 0; i < 48; i++)
            {
               // AddMinutes(30);
                // ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), DateTime.Parse(dt.ToString(), new CultureInfo("en-GB")).ToString("hh:mm.FF tt")));
                ddlFrom.Items.Insert(i, new ListItem(dt.ToString("HH:mm"), dt.ToString("HH:mm")));

                dt = dt.AddMinutes(30);
            }



        }
    }

    public void loadTotime()
    {
        if (ddlTo.Items.Count == 0)
        {
            DateTime dt = Convert.ToDateTime("12:30 am");
            DateTime time = DateTime.MinValue;
            DateTime value = DateTime.MinValue;
            //for (i = 0; i < 48; i++)
            //{
            //    //ddlTo.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            //    if (i < 47)
            //    {
            //        ddlTo.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), dt.ToString("hh:mm.FF tt", new CultureInfo("en-GB"))));
            //        dt = dt.AddMinutes(30);
            //    }
            //    else
            //    {
            //        ddlTo.Items.Insert(47, new ListItem("11:59 PM", "11:59 PM"));
            //    }
            //}
            for (i = 0; i < 48; i++)
            {
                // AddMinutes(30);
                // ddlFrom.Items.Insert(i, new ListItem(dt.ToString("hh:mm.FF tt"), DateTime.Parse(dt.ToString(), new CultureInfo("en-GB")).ToString("hh:mm.FF tt")));
                ddlTo.Items.Insert(i, new ListItem(dt.ToString("HH:mm"), dt.ToString("HH:mm")));

                dt = dt.AddMinutes(30);
            }
        }
    }

}
