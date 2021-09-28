using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ANC_ANC : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ddlMenstrualCycles.Attributes.Add("onchange", "Menstrual1DIV");
        ddlMenstrualCycles.Attributes["onchange"] = "javascript:MenstrualDIV();";
    }
    protected void ddlMenstrualCycles_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void chkPregnanacyComplicationsHistory_CheckedChanged(object sender, EventArgs e)
    {

    }
}
