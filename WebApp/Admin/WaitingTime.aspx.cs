using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
//using System.Reflection;
//using System.Collections;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Admin_WaitingTime : BasePage
{
    //protected Hashtable htControls = new Hashtable();
    #region pageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            btnViewDetails_Click(sender, e);
        }
    }
    #endregion
    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        List<PatientWaitTime> lstwaittime = new List<PatientWaitTime>();
        PatientVisit_BL objvisitBl = new PatientVisit_BL(base.ContextInfo);
        DateTime dFromDate = new DateTime();
        DateTime dtodate = new DateTime();

        dFromDate = Convert.ToDateTime(txtFromDate.Text);
        dtodate = Convert.ToDateTime(txtToDate.Text);

        objvisitBl.GetPatientWaitTime(dFromDate, dtodate, OrgID, out lstwaittime);
        if (lstwaittime.Count > 0)
        {
            var list = (from list1 in lstwaittime
                        orderby list1.ElapsedTime ascending
                        select list1).Take(5);

            var list12 = (from list1 in lstwaittime
                          orderby list1.ElapsedTime ascending
                          select new
                          {
                              list1.ElapsedTime
                          }).Take(5);

            var list3 = (from list2 in lstwaittime
                         orderby list2.ElapsedTime descending
                         select list2).Take(5);

            var list31 = (from list2 in lstwaittime
                          orderby list2.ElapsedTime descending
                          select new { list2.ElapsedTime }).Take(5);

            var list41 = (from list2 in lstwaittime
                          orderby list2.ElapsedTime descending
                          select new { list2.ElapsedTime });


            var listavg = list12.Average(s => s.ElapsedTime);
            var listavgMax = list31.Average(s => s.ElapsedTime);
            var listAllavg = list41.Average(s => s.ElapsedTime);

            //decimal dq =  (decimal)listavg.;

            lblMinWaitTime.Text = listavg.ToString() + " Min(s)";
            lblMaxWaitTime.Text = listavgMax.ToString() + " Min(s)";
            lblAllWaitTime.Text = listAllavg.ToString() + " Min(s)";

            gvMaxWaitTime.Visible = true;
            gvMaxWaitTime.DataSource = list3;
            gvMaxWaitTime.DataBind();

            gvMinWaitTime.Visible = true;
            gvMinWaitTime.DataSource = list;
            gvMinWaitTime.DataBind();

            gvWaitingDetails.Visible = true;
            gvWaitingDetails.DataSource = lstwaittime;
            gvWaitingDetails.DataBind();

            btnExportToExcel.Visible = true;
        }
        else
        {
            lblMinWaitTime.Text = "0 Min(s)";
            lblMaxWaitTime.Text = "0 Min(s)";
            lblAllWaitTime.Text = "0 Min(s)";

            gvMaxWaitTime.Visible = false;
            gvMinWaitTime.Visible = false;
            gvWaitingDetails.Visible = false;
            btnExportToExcel.Visible = false;
        }
    }
    protected void btnExportToExcel_Click(object sender,ImageClickEventArgs e)
    {
        ////export to excel
        string attachment = "attachment; filename=Reports.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        //gvMaxWaitTime.RenderControl(oHtmlTextWriter);
        //Response.Write(oStringWriter.ToString());
        //gvMinWaitTime.RenderControl(oHtmlTextWriter);
        //Response.Write(oStringWriter.ToString());
        gvWaitingDetails.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }


    //private void ExportGridView()
    //{
    //    string attachment = "attachment; filename=Contacts.xls";
    //    Response.ClearContent();
    //    Response.AddHeader("content-disposition", attachment);
    //    Response.ContentType = "application/ms-excel";
    //    System.IO.StringWriter sw = new System.IO.StringWriter();
    //    HtmlTextWriter htw = new HtmlTextWriter(sw);
    //    pnlExam.RenderControl(htw);
    //    Response.Write(sw.ToString());
    //    Response.End();
    //}

    //private void PrepareGridViewForExport(Control gv)
    //{
    //    Literal l = new Literal();
    //    for (int i = 0; i < gv.Controls.Count; i++)
    //    {
    //        if ((null != htControls[gv.Controls[i].GetType().Name]) || (null != htControls[gv.Controls[i].GetType
    //           ().BaseType.Name]))
    //        {
    //            l.Text = GetControlPropertyValue(gv.Controls[i]);
    //            gv.Controls.Remove(gv.Controls[i]);
    //            gv.Controls.AddAt(i, l);
    //        }
    //        if (gv.Controls[i].HasControls())
    //        {
    //            PrepareGridViewForExport(gv.Controls[i]);
    //        }
    //    }
    //}

    //private string GetControlPropertyValue(Control control)
    //{
    //    Type controlType = control.GetType();
    //    string strControlType = controlType.Name;
    //    string strReturn = "Error";
    //    bool bReturn;

    //    PropertyInfo[] ctrlProps = controlType.GetProperties();
    //    string ExcelPropertyName = (string)htControls[strControlType];
    //    if (ExcelPropertyName == null)
    //    {
    //        ExcelPropertyName = (string)htControls[control.GetType().BaseType.Name];
    //        if (ExcelPropertyName == null)
    //            return strReturn;
    //    }

    //    foreach (PropertyInfo ctrlProp in ctrlProps)
    //    {
    //        if (ctrlProp.Name == ExcelPropertyName &&
    //        ctrlProp.PropertyType == typeof(String))
    //        {
    //            try
    //            {
    //                strReturn = (string)ctrlProp.GetValue(control, null);
    //                break;
    //            }
    //            catch
    //            {
    //                strReturn = "";
    //            }
    //        }
    //        if (ctrlProp.Name == ExcelPropertyName &&
    //        ctrlProp.PropertyType == typeof(bool))
    //        {
    //            try
    //            {
    //                bReturn = (bool)ctrlProp.GetValue(control, null);
    //                strReturn = bReturn ? "True" : "False";
    //                break;
    //            }
    //            catch
    //            {
    //                strReturn = "Error";
    //            }
    //        }
    //        if (ctrlProp.Name == ExcelPropertyName &&
    //        ctrlProp.PropertyType == typeof(ListItem))
    //        {
    //            try
    //            {
    //                strReturn = ((ListItem)(ctrlProp.GetValue(control, null))).Text;
    //                break;
    //            }
    //            catch
    //            {
    //                strReturn = "";
    //            }
    //        }
    //    }
    //    return strReturn;
    //}
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }

    }
}
