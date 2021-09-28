using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Collections;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_FileDataViewer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            int selIDX = ddImageList.SelectedIndex;
            int lastIDX =0;

            if(hdnfileCnt.Text!="")
                 lastIDX = Convert.ToInt32(hdnfileCnt.Text);

                
            if (lastIDX > 0)
            {
                pnlNoData.Visible = false;
                pnlMain.Visible = true;
            }
            else
            {
                pnlNoData.Visible = true;
                pnlMain.Visible = false;
                //btnGo.Enabled = false;
                //btnPrev.Enabled = false;
                //btnNext.Enabled = false;
            }
        }
    }

    public void displayImage(List<Blob> lstblob)
    {
        int fileCnt = lstblob.Count;

        if(ddImageList.Items.Count>0)
            ddImageList.Items.Clear();
        
        if (fileCnt > 0)
        {
            pnlNoData.Visible = false;
            pnlMain.Visible = true;
            hdnfileCnt.Text = fileCnt.ToString();
            for (int cnt = 0; cnt < fileCnt; cnt++)
            {
                ddImageList.Items.Add(new ListItem((cnt + 1).ToString(), lstblob[cnt].FileID.ToString()));
            }
            string fileID = ddImageList.SelectedValue;
            viewData.FilePath = "../FileHandlers/ShowOldNoteImages.aspx?fileID=" + fileID;
        }
        else
        {
            pnlMain.Visible = false;
            pnlNoData.Visible = true;
            hdnfileCnt.Text = "0";
            //btnGo.Enabled = false;
            //btnPrev.Enabled = false;
            //btnNext.Enabled = false;
        }
    }


    protected void btnGo_Click(object sender, EventArgs e)
    {
        ddImageList_SelectedIndexChanged();
    }


    protected void btnPrev_Click(object sender, EventArgs e)
    {
        //if ((ddImageList.SelectedIndex + 1) == Convert.ToInt32(hdnfileCnt.Text))
        //{
        //    btnNext.Enabled = true;
        //    btnPrev.Enabled = false;
        //}
        if (ddImageList.SelectedIndex > 0)
        {
            ddImageList.SelectedIndex = ddImageList.SelectedIndex - 1;
            ddImageList_SelectedIndexChanged();
        }
        else
        {
            ddImageList_SelectedIndexChanged();
        }
        if (ddImageList.SelectedIndex == 0)
        {
            btnPrev.Enabled = false;
            btnNext.Enabled = true;
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        //if (ddImageList.SelectedIndex == 0)
        //{
        //    btnPrev.Enabled = false;
        //    btnNext.Enabled = true;
        //}

        if ((ddImageList.SelectedIndex + 1) != Convert.ToInt32(hdnfileCnt.Text))
        {
            ddImageList.SelectedIndex = ddImageList.SelectedIndex + 1;
            ddImageList_SelectedIndexChanged();
        }
        else
        {
            ddImageList_SelectedIndexChanged();
        }

        if ((ddImageList.SelectedIndex + 1) == Convert.ToInt32(hdnfileCnt.Text))
        {
            btnNext.Enabled = false;
            btnPrev.Enabled = true;
        }
    }

    private void ddImageList_SelectedIndexChanged()
    {
        string fileID = ddImageList.SelectedValue;
        viewData.FilePath = "../FileHandlers/ShowOldNoteImages.aspx?fileID=" + fileID;
    }
}
