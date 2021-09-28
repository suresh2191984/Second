using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;

public partial class CommonControls_CODICDCode : BaseControl
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblComplaint.Text = ComplaintHeader;

    }

    #region Get and Set The AssociatedIllness
    public List<CauseOfDeath> GetCauseOfDeath(string CauseOfDeathType)
    {

        List<CauseOfDeath> lstCauseOfDeathTemp = new List<CauseOfDeath>();

        foreach (string lstCOD in hdnDiagnosisItems.Value.Split('^'))
        {

            if (lstCOD != "")
            {
                CauseOfDeath objCauseOfDeath = new CauseOfDeath();
                string[] lstChildData = lstCOD.Split('~');
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = CauseOfDeathType;
                objCauseOfDeath.ComplaintID = 0;
                objCauseOfDeath.ComplaintName = lstChildData[1];
                objCauseOfDeath.ICDCode = lstChildData[3];
                objCauseOfDeath.ICDDescription = lstChildData[4];
                if (objCauseOfDeath.ICDCode == "")
                {
                    objCauseOfDeath.ICDCodeStatus = "Pending";
                }
                else
                {
                    objCauseOfDeath.ICDCodeStatus = "Completed";
                }
                lstCauseOfDeathTemp.Add(objCauseOfDeath);
            }
        }

        return lstCauseOfDeathTemp;
    }

    public void SetCauseOfDeath(List<CauseOfDeath> lstCauseOfDeath)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (CauseOfDeath objItem in lstCauseOfDeath)
        {
            hdnDiagnosisItems.Value += i + "~" + objItem.ComplaintName + "~" + objItem.ComplaintID + "~" + objItem.ICDCode + "~" + objItem.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItemsCOD();", true);
    }


    #endregion
    public void LoadComplaintItems()
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItemsCOD();", true);

    }

    public void hdnClear()
    {
        hdnDiagnosisItems.Value = "";
    }

    public void SetComplaint()
    {
        txtCpmlaint.Text = ComplaintName;
        hdnFlag.Value = "N";

        if (AddBtnVisible == "False")
        {
            btnHistoryAdd.Visible = false;
            txtCpmlaint.ReadOnly = true;
        }
    }

    public void SetWidth(int Width)
    {
        txtCpmlaint.Width = Width;
        txtICDCode.Width = Width;
        txtICDName.Width = Width;
        
    }
}
