using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class SampleCollectionPerson_SCPScheduler : BasePage
{

    public SampleCollectionPerson_SCPScheduler()
        : base("SampleCollectionPerson_SCPScheduler_aspx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {

       // SampleCollectionPerson_Controls_SPschedule objTestControl = (SampleCollectionPerson_Controls_SPschedule)Page.FindControl("hdnUserID");
        //objTestControl.Text;
       // HiddenField hdn = objTestControl.FindControl("hdnUserID");
        // objTestControl.Text  = Convert.ToString(LID);


         //HiddenField myhid = SampleCollectionPerson_Controls_SPschedule.FindControl("hdnUserID") as HiddenField;
         //myhid.Value = Convert.ToUInt64(LID);
    }
}
