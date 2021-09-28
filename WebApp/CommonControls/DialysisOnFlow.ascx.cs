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

public partial class CommonControls_DialysisOnFlow : BaseControl
{
    DateTime OnflowTime;
    decimal tempsbp, tempdbp;
    DataSet ds1 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
          
        }
    }
   
    public void GetData(long patientVisitID,bool styleflag)
    {
        long retval = -1;

        OnFlowDialysis_BL dialysisBL = new OnFlowDialysis_BL(base.ContextInfo);
        //List<Dialysis> lstDialysis = new List<Dialysis>();
        DataSet ds1 = new DataSet();
        retval = dialysisBL.GetOnFlowDialysis((int)patientVisitID, out ds1);
       
        if (retval == -1)
        {
           
            BindData(ds1);
            if (styleflag == true)
            {
               
                this.grdOnFlowDialysis.HeaderStyle.CssClass = "subdataheader1";
            }
            else
            {
                this.grdOnFlowDialysis.HeaderStyle.CssClass = "defaultfontcolor";
            }
           
        }
       
    }
    
    private void Sample()
    {
        long retval = -1;

        OnFlowDialysis_BL dialysisBL = new OnFlowDialysis_BL(base.ContextInfo);
        List<Dialysis> lstDialysis = new List<Dialysis>();

        retval = dialysisBL.GetOnFlowDialysis1(1, out lstDialysis);
        
        List<Dialysis> finaldia = new List<Dialysis>();
        string strtemp1 = string.Empty;
        string tempvitalsname1 = string.Empty;

        
        for(int i = 0; i < lstDialysis.Count; i++) 
        {
            if (strtemp1 != lstDialysis[i].VitalsName.ToString())  //drnew["VitalsName"].ToString())
            {
                tempvitalsname1 = Server.HtmlDecode(lstDialysis[i].VitalsName[i].ToString());
                new Dialysis { VitalsName = tempvitalsname1 };
                strtemp1 = lstDialysis[i].VitalsName[i].ToString(); //lstDialysis["VitalsName"].ToString();
            }
        }

        
              
            
    }

    
    private void BindData(DataSet ds1)
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
        grdOnFlowDialysis.Visible = true;
        lblResult.Visible = false;
        lblResult.Text = "";
        ds = ds1.Tables[0];

        string strtemp = string.Empty;
        string count = string.Empty;
        string tempvitalsname = string.Empty;
        dt.Columns.Add("BP (mmHG)");
       
        foreach (DataRow drnew in ds.Select("", "VitalsName asc"))
        {
            if (strtemp != drnew["VitalsName"].ToString())
            {
                tempvitalsname = Server.HtmlDecode(drnew["VitalsName"].ToString());
                dt.Columns.Add(tempvitalsname);
                strtemp = drnew["VitalsName"].ToString();
            }

        }

        dt.Columns.Add("Remarks");
        dt.Columns.Add("Time Captured");
        string onflowid = string.Empty;
        DataRow newrow = null;
        

        foreach (DataRow dr in ds.Select("", "DialysisOnFlowID asc"))
        {

            if (onflowid != dr["DialysisOnFlowID"].ToString())
            {
                newrow = dt.NewRow();
                onflowid = dr["DialysisOnFlowID"].ToString();
            }
            foreach (DataRow dr1 in ds.Select("", "DialysisOnFlowID asc"))
            {
                if (onflowid == dr1["DialysisOnFlowID"].ToString())
                {

                    if (dr1["VitalsName"].ToString().StartsWith("SBP"))
                    {
                        tempvalue = Convert.ToDecimal(dr1["VitalsValue"].ToString());
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
                        tempvalue1 = Convert.ToDecimal(dr1["VitalsValue"].ToString());
                        tempname1 = dr1["VitalsName"].ToString();
                        if (dt.Columns.Contains(tempname1))
                        {
                            dt.Columns.Remove(tempname1);
                        }
                        ValueCount = 2;
                    }
                    if (ValueCount != 1 && ValueCount != 2)
                    {
                        newrow[Server.HtmlDecode(dr1["VitalsName"].ToString())] = dr1["VitalsValue"].ToString();
                    }

                    TempRemarks = dr1["Remarks"].ToString();
                    OnflowTime = Convert.ToDateTime(dr1["OnFlowDateTime"].ToString());

                }
                ValueCount = 0;

            }
            if (count != onflowid)
            {

                newrow["Remarks"] = TempRemarks;
                newrow["Time Captured"] = OnflowTime.ToString("hh:mm tt");
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
        grdOnFlowDialysis.DataSource = dt;
        grdOnFlowDialysis.DataBind();

    }

   

    protected void grdOnFlowDialysis_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
         //   e.Row.Height = Unit.Pixel(5);
          //  e.Row.Width = Unit.Pixel(5);

        }
    }
}
