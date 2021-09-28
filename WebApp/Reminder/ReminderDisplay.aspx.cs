using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class Reminder_ReminderDisplay : System.Web.UI.Page
{
   
       


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
//            RemainderDisplay1.LoadData();
            
            GetRemainderDetail();
        }
    }

    //public void remainder_rowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "ok")
    //    {

    //    }
    //}

    private void GetRemainderDetail()
    {
       

        
        
    }
}
