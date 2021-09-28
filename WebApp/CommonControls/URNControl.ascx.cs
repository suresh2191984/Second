using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_URNControl : BaseControl
{
    List<URNTypes> objURNTypes = new List<URNTypes>();
    List<URNof> objURNof = new List<URNof>();
    Patient_BL pBL;
    string tabIndex = string.Empty;
    public string StrUrn = "";
    public short tIndex = 0;
    public string StartIndex
    {
        get
        {
            return tabIndex;
        }
        set
        {
            tabIndex = value;

            tIndex = Convert.ToInt16(tabIndex);
            ddlUrnType.TabIndex = tIndex++;
            ddlUrnoOf.TabIndex = tIndex++;
            txtURNo.TabIndex = tIndex++;
            txtValidate.TabIndex = tIndex++;
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //LoadURNtype();

    }
    public void LoadURNtype()
    {
        try
        {
            long returnCode = -1;
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            Salutation selectedSalutation = new Salutation();

            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();

                ddlUrnType.Items.Insert(0, "--Select--");
                ddlUrnType.Items[0].Value = "0";

                ddlUrnoOf.DataSource = objURNof;
                ddlUrnoOf.DataTextField = "URNOf";
                ddlUrnoOf.DataValueField = "URNOfId";
                ddlUrnoOf.DataBind();

                ddlUrnoOf.Items.Insert(0, "--Select--");
                ddlUrnoOf.Items[0].Value = "0";
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading URNtype", ex);
        }

    }

    public void SetURN(URNTypes objURNTypes)
    {
        if (StrUrn != "")
            hdnUrn.Value = objURNTypes.URN;
        txtURNo.Text = objURNTypes.URN;
        ddlUrnoOf.SelectedValue = objURNTypes.URNof.ToString();
        ddlUrnType.SelectedValue = objURNTypes.URNTypeId.ToString();
        string lstDate = "";
        lstDate = Convert.ToString(objURNTypes.ExpDate).Substring(0, 10).ToString();
        if (lstDate =="01/01/0001" || lstDate == "01/01/1901")
        {
            txtValidate.Text = "";
        }
        else
        {
            txtValidate.Text = objURNTypes.ExpDate.ToShortDateString().ToString();
        }


    }

    public URNTypes GetURN()
    {
        URNTypes objURNTypes = new URNTypes();
        objURNTypes.URN = txtURNo.Text;
        objURNTypes.URNof = Int64.Parse(ddlUrnoOf.SelectedValue);
        objURNTypes.URNTypeId = Int64.Parse(ddlUrnType.SelectedValue);
        DateTime URNTime = DateTime.MaxValue;
        if (txtValidate.Text.Trim() != "")
        {
            DateTime.TryParse(txtValidate.Text.Trim(), out URNTime);
        }
        objURNTypes.ExpDate = URNTime;

        return objURNTypes;
    }
    public void display()
    {
        ddlUrnoOf.Enabled = false;
        ddlUrnType.Enabled = false;
        txtURNo.Enabled = false;
    }

}
