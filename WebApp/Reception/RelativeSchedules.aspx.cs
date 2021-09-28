using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Attune.Podium.Common;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class Reception_RelativeSchedules :BasePage
{

 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string sIDS = "";
                sIDS = ((HiddenField)((UserControl)PreviousPage.FindControl("phySch")).FindControl("hdnSelectedID")).Value.ToString();
                rtschedules.SelIDS = sIDS;
                rtschedules.loadDatas();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing the pageload", ex);
        }
    }

  

}
