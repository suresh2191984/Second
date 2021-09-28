using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;


public partial class Investigation_HematPattern9 :BaseControl
{
    private string name = string.Empty;
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
    private int i = 0;
    private int groupID = 0;
    private string groupName = string.Empty;

    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
        }
    }

    public string GroupName
    {
        get { return groupName; }
        set
        {
            groupName = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        chkName.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txtValue.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
    }
    /// <summary>
    /// Get and Set the Investigation Name
    /// </summary>
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            chkName.Text = name;
        }
    }

    /// <summary>
    /// Assign the ControlID to hidden field
    /// </summary>
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }
    private int packageID = 0;
    private string packageName = string.Empty;

    public int PackageID
    {
        get { return packageID; }
        set
        {
            packageID = value;
        }
    }


    public string PackageName
    {
        get { return packageName; }
        set
        {
            packageName = value;
        }
    }
    /// <summary>
    /// Get the Value from Controls
    /// </summary>
    /// <param name="VID"></param>
    /// <returns></returns>

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;


        if (chkName.Checked)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = chkName.Text;
            obj.Value = "Present";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = txtValue.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        else
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = chkName.Text;
            obj.Value = "Absent";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        return lstInvestigationVal;

    }
    protected void chkName_CheckedChanged(object sender, EventArgs e)
    {
        if (chkName.Checked)
        {
            dShow.Visible = true;
        }
        else
        {
            dShow.Visible = false;
        }
    }
    
    //public void loadStatus(List<InvestigationStatus> lstStatus)
    //{
    //    ddlstatus.DataSource = lstStatus;
    //    ddlstatus.DataTextField = "Status";
    //    ddlstatus.DataBind();
    //}
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
           // txtReason.Enabled = value;
           // txtRefRange.Enabled = value;
            //txtValue.Enabled = value;
            txtValue.ReadOnly = value == false ? true : false;
            //lnkEdit.Visible = true;

        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["test"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    string isEdit = "false";
    public string IsEdit
    {
        get
        {
            if (ViewState["isEdit"] != null)
            {
                isEdit = ViewState["isEdit"].ToString();
            }
            else
            {
                isEdit = "false";
            }
            return isEdit;
        }

    }
}
