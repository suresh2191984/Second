using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;


public partial class Corporate_AssistantPhysicianName :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Loadphysician();
    }
    public void Loadphysician()
    {
        try
        {
            List<Physician> lstroom = new List<Physician>();
            new Physician_BL(base.ContextInfo).GetPhysicianList(OrgID, out lstroom);
            drpPhysician.DataSource = "lstroom";
            drpPhysician.DataTextField = "PhysicianName";
            drpPhysician.DataValueField = "PhysicianID";
            drpPhysician.DataBind();
            foreach (Physician str in lstroom)
            {
                hdnphysician.Value += str.PhysicianID + "~" + str.PhysicianName + "~" + str.SpecialityID + "~" + str.SpecialityName + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Physician Load", ex);
        }
    }
}
