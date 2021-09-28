using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_PendingInvestigation : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loaddate();
    }

    protected void loaddate()
    {
        long retval = -1;
        long patientId=2;
        Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
        List<PendingInvestigation> lstPenInv = new List<PendingInvestigation>();
        retval = invBL.getPendingInvestigation(patientId, out lstPenInv);
        long tempvisitid=0;

        Table tb = new Table();
        TableCell tc = null;
        TableRow tr = null;
        Panel pn = null;
        Button btnStoreInfo = null;

        for (int i = 0; i < lstPenInv.Count; i++)
        {
            
            if (tempvisitid != lstPenInv[i].PatientVisitId)
            {
                 tc = new TableCell();
                 tr = new TableRow(); 
                 pn = new Panel();
                 btnStoreInfo = new Button();
            }

            tempvisitid = lstPenInv[i].PatientVisitId;
            //tc.BorderWidth = 1;
            //tr.BorderWidth = 1;
            pn.GroupingText = lstPenInv[i].VisitDate.ToShortDateString().ToString();
            Label lbname = new Label();
            Label lbvalue = new Label();
           
            btnStoreInfo.Text = "Store Information";
            lbname.Text = lstPenInv[i].InvestigationName+":  ";
            lbvalue.Text = lstPenInv[i].Value;
            Table tbl = new Table();
            TableCell cell = new TableCell();
            TableRow row = new TableRow();
            cell.Controls.Add(lbname);
            cell.Controls.Add(lbvalue);
            cell.Controls.Add(btnStoreInfo);
            row.Controls.Add(cell);
            tbl.Rows.Add(row);
            pn.Controls.Add(tbl);
           
            tc.Controls.Add(pn); 
          
            tr.Controls.Add(tc);
            tb.Controls.Add(tr);           
        }

       
        
        Panel4.Controls.Add(tb);

    }
}
