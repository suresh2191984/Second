using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.UIControls;
public partial class Reception_Home : Attune_BasePage
{
    public Attune_IUpdatePerformer UcUpdateVisitPerformer
    {
        get;
        set;
    }
    protected void Page_Load(object sender, EventArgs e)
    {

         if (LoadControl("../PlatForm/CommonControls/UpdateVisitPerformer.ascx") != null)
        {
            Control objControl = LoadControl("../PlatForm/CommonControls/UpdateVisitPerformer.ascx");
            UcUpdateVisitPerformer = objControl as Attune_IUpdatePerformer;
            objControl.ID = "UpdateVisitPerformer";
            pContainer.Controls.Add(objControl);
            pContainer.Attributes.Add("class", "hide");
        } 
    }
    protected void btninvisible_Click(object sender, EventArgs e)
    {
        mpExtender.Show();
        pContainer.Attributes.Add("class", "show");
        if (UcUpdateVisitPerformer != null)
        {
            UcUpdateVisitPerformer.LoadPatientVisitDetails(Convert.ToInt64(hdnvid.Value), Convert.ToInt64(hdnpid.Value));
        }
    }
}
