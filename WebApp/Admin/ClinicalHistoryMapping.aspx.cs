using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ClinicalHistoryMapping : BasePage
{
    #region Properties
    #endregion Properties

    #region Constructors
    public Admin_ClinicalHistoryMapping()
        : base("Admin_ClinicalHistoryMapping_aspx")
    {
    }
    #endregion Constructors

    #region Methods
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hdnOrgId.Value = base.OrgID.ToString();
            InitializeAutoCompleteParameter();
        }
    }

    private void InitializeAutoCompleteParameter()
    {
        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~";
        AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~";
    }

    #endregion Methods

    
}
