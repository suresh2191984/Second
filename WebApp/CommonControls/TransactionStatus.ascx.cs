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

public partial class CommonControls_TransactionStatus : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblTranStatus.Text = string.Empty;
        if (Request.QueryString["TS"] == "S")
        {
            lblTranStatus.Text = "Your Last Transaction was Successfull";
        }
        else
        {
            lblTranStatus.Text = string.Empty;
        }
    }
}
