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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.FileUpload;

public partial class CommonControls_PatientOldNotesViewer : BaseControl
{
    PatientOldNotes_BL pon;
    protected void Page_Load(object sender, EventArgs e)
    {
        pon = new PatientOldNotes_BL(base.ContextInfo);
    }

    public long showOldNotes(long visitID)
    {
        
        List<Blob> lstblob = new List<Blob>();
        List<PatientOldNotes> lstOldNotes = new List<PatientOldNotes>();

       
        pon.getPatientOldNotesBlob(visitID, out lstblob, out lstOldNotes);

        if (lstOldNotes.Count > 0)
        {
            lblTitle.Text = lstOldNotes[0].DocumentTitle;

            if (lstblob.Count > 0)
            {
                viewData.displayImage(lstblob);
            }
        }
        return lstOldNotes.Count;
    }
}
