using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class DischargeSummary_SurgeryDetails : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindSurgeryDetails(List<OperationNotes> lstOperationNotesForDS, string HeaderName)
    {
        lblSD.Text = HeaderName;
        repTreatmentPlan.DataSource = lstOperationNotesForDS;
        repTreatmentPlan.DataBind();
    }

    protected void repTreatmentPlan_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            OperationNotes OPN = (OperationNotes)e.Item.DataItem;
            Table tblSOI = (Table)e.Item.FindControl("tblSOI");


            Label lblTreatmentName = (Label)e.Item.FindControl("lblTreatmentName");
            Label lblTreatmentNameT = (Label)e.Item.FindControl("lblTreatmentNameT");

            if (OPN.TreatmentName == "")
            {
                tblSOI.Rows[0].Style.Add("display", "none");
            }

            if (OPN.TreatmentName == null)
            {
                tblSOI.Rows[0].Style.Add("display", "none");
            }

            Label lblFromTime = (Label)e.Item.FindControl("lblFromTime");
            Label lblFromTimeT = (Label)e.Item.FindControl("lblFromTimeT");

            if (OPN.FromTime == DateTime.MinValue)
            {
                tblSOI.Rows[1].Style.Add("display", "none");
            }
            else
            {
                lblFromTime.Text = OPN.FromTime.ToString("dd/MM/yyyy hh:mm tt");
            }

            Label lblAnesthesiaTypeT = (Label)e.Item.FindControl("lblAnesthesiaTypeT");
            Label lblAnesthesiaType = (Label)e.Item.FindControl("lblAnesthesiaType");

            if (OPN.AnesthesiaType == "")
            {
                tblSOI.Rows[2].Style.Add("display", "none");
            }

            if (OPN.AnesthesiaType == null)
            {
                tblSOI.Rows[2].Style.Add("display", "none");
            }

            Label lblSurgeryTypeT = (Label)e.Item.FindControl("lblSurgeryTypeT");
            Label lblSurgeryType = (Label)e.Item.FindControl("lblSurgeryType");

            if (OPN.SurgeryType == "")
            {
                tblSOI.Rows[3].Style.Add("display", "none");
            }

            if (OPN.SurgeryType == null)
            {
                tblSOI.Rows[3].Style.Add("display", "none");
            }

            Label lblOperationTypeT = (Label)e.Item.FindControl("lblOperationTypeT");
            Label lblOperationType = (Label)e.Item.FindControl("lblOperationType");


            if (OPN.OperationType == "")
            {
                tblSOI.Rows[4].Style.Add("display", "none");
            }
            if (OPN.OperationType == null)
            {
                tblSOI.Rows[4].Style.Add("display", "none");
            }

            Label lblOperationFindingsT = (Label)e.Item.FindControl("lblOperationFindingsT");
            Label lblOperationFindings = (Label)e.Item.FindControl("lblOperationFindings");

            if (OPN.OperativeFindings == "")
            {
                tblSOI.Rows[5].Style.Add("display", "none");
            }
            if (OPN.OperativeFindings == null)
            {
                tblSOI.Rows[5].Style.Add("display", "none");
            }


            Label lblOperativeTechniqueT = (Label)e.Item.FindControl("lblOperativeTechniqueT");
            Label lblOperativeTechnique = (Label)e.Item.FindControl("lblOperativeTechnique");

            if (OPN.OperativeTechnique == "")
            {
                tblSOI.Rows[6].Style.Add("display", "none");
            }

            if (OPN.OperativeTechnique == null)
            {
                tblSOI.Rows[6].Style.Add("display", "none");
            }


        }
    }
}
