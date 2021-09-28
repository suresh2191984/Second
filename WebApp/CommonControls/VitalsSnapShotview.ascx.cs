using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_VitalsSnapShotview : BaseControl
{
    DateTime VisitDate;
    decimal tempsbp, tempdbp;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void LoadSnapShotview(DataSet ds1, List<PatientFetalFindings> lstPFF, List<ANCPatientObservation> lstANCPatientObservation)
    {
        try
        {
            if (lstANCPatientObservation.Count > 0)
            {
                gvPatientObservation.DataSource = lstANCPatientObservation;
                gvPatientObservation.DataBind();

            }
            BindData(ds1, lstPFF);
            grdSnapShotView.HeaderStyle.CssClass = "subdataheader1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSnapShotview", ex);
        }
    }
    private void BindData(DataSet ds1, List<PatientFetalFindings> pff)
    {
        try
        {
            string TempRemarks = string.Empty;
            int ValueCount = 0;
            decimal tempvalue = 0.0m;
            string tempname = string.Empty;
            decimal tempvalue1 = 0.0m;
            string tempname1 = string.Empty;
            string UOMCode = string.Empty;
            DataTable ds = new DataTable();
            DataTable dt = new DataTable();
            grdSnapShotView.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            ds = ds1.Tables[0];

            string strtemp = string.Empty;
            string count = string.Empty;
            string tempvitalsname = string.Empty;
            dt.Columns.Add("Visit Date");
            dt.Columns.Add("BP (mmHG)");

            foreach (DataRow drnew in ds.Select("", "DisplayOrder"))
            {
                if (strtemp != drnew["VitalsName"].ToString() && !dt.Columns.Contains(Server.HtmlDecode(drnew["VitalsName"].ToString())))
                {
                    tempvitalsname = Server.HtmlDecode(drnew["VitalsName"].ToString());
                    dt.Columns.Add(tempvitalsname);
                    strtemp = drnew["VitalsName"].ToString();
                }

            }

            //dt.Columns.Add("Remarks");
            //dt.Columns.Add("Visit Date");
            string onflowid = string.Empty;
            DataRow newrow = null;


            //foreach (DataRow dr in ds.Select("", "PatientVisitID asc"))
            foreach (DataRow dr in ds.Select("", "PatientVisitID"))
            {

                if (onflowid != dr["PatientVisitID"].ToString())
                {
                    newrow = dt.NewRow();
                    onflowid = dr["PatientVisitID"].ToString();
                }
                foreach (DataRow dr1 in ds.Select("", "PatientVisitID"))
                {
                    if (onflowid == dr1["PatientVisitID"].ToString())
                    {

                        if (dr1["VitalsName"].ToString().StartsWith("SBP"))
                        {
                            tempvalue = Convert.ToDecimal(dr1["Value"].ToString());
                            tempname = dr1["VitalsName"].ToString();
                            UOMCode = dr1["UOMCode"].ToString();
                            if (dt.Columns.Contains(tempname))
                            {
                                dt.Columns.Remove(tempname);
                            }
                            ValueCount = 1;
                        }
                        if (dr1["VitalsName"].ToString().StartsWith("DBP"))
                        {
                            tempvalue1 = Convert.ToDecimal(dr1["Value"].ToString());
                            tempname1 = dr1["VitalsName"].ToString();
                            if (dt.Columns.Contains(tempname1))
                            {
                                dt.Columns.Remove(tempname1);
                            }
                            ValueCount = 2;
                        }
                        if (ValueCount != 1 && ValueCount != 2)
                        {
                            newrow[Server.HtmlDecode(dr1["VitalsName"].ToString())] = dr1["Value"].ToString();
                        }

                        //TempRemarks = dr1["Remarks"].ToString();
                        VisitDate = Convert.ToDateTime(dr1["CreatedAt"].ToString());

                    }
                    ValueCount = 0;

                }
                if (count != onflowid)
                {

                    //newrow["Remarks"] = TempRemarks;
                    newrow["Visit Date"] = VisitDate.ToString("dd/MM/yyy");
                    dt.Rows.Add(newrow);
                    count = onflowid;

                    if (tempvalue != 0 && tempvalue1 != 0)
                    {
                        tempsbp = decimal.Parse(tempvalue.ToString());
                        tempsbp = Math.Ceiling(tempsbp);

                        tempdbp = decimal.Parse(tempvalue1.ToString());
                        tempdbp = Math.Ceiling(tempdbp);

                        newrow["BP (mmHG)"] = tempsbp.ToString() + '/' + tempdbp.ToString();
                    }
                    else if (tempvalue != 0 && tempvalue1 <= 0)
                    {
                        tempsbp = decimal.Parse(tempvalue.ToString());
                        tempsbp = Math.Ceiling(tempsbp);

                        newrow["BP (mmHG)"] = tempsbp.ToString() + "(SBP)";
                    }
                    else if (tempvalue == 0 && tempvalue1 != 0)
                    {
                        tempdbp = decimal.Parse(tempvalue1.ToString());
                        tempdbp = Math.Ceiling(tempdbp);

                        newrow["BP (mmHG)"] = tempdbp.ToString() + "(DBP)";
                    }
                    else
                    {
                        newrow["BP (mmHG)"] = string.Empty;
                    }

                }

                tempvalue = 0;
                tempvalue1 = 0;
            }
            grdSnapShotView.DataSource = dt;
            grdSnapShotView.DataBind();

            grdFetals.DataSource = pff;
            grdFetals.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSnapShotview", ex);
        }

    }
    protected void grdSnapShotView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //   e.Row.Height = Unit.Pixel(5);
            //  e.Row.Width = Unit.Pixel(5);

        }
    }
}
