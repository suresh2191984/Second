using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Physician_PhysicianSchedule :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DoctorsScheduleControl.IDoctorID = IUserID;
        DoctorsScheduleControl.SResourceType = "P";
        if (!Page.IsPostBack)
        {
            docHeader.Name = Name;
            DoctorsScheduleControl.filldatas();
            DoctorsScheduleControl.bindDropDown();
            //<uc7:DoctorSchedule ID="DoctorsScheduleControl" runat="server" />
        }
        DoctorsScheduleControl.bindDatas();
    }
}
