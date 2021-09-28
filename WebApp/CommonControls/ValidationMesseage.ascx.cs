using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;

public partial class CommonControls_ValidationMesseage : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMeatData();
        }

    }

    public void LoadMeatData()
    {
        long returncode = -1;
        string domains = "MandatoryValidation";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;

        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }

        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var Single = from child in lstmetadataOutput
                         where child.Code == "0"
                         select child;

            foreach (var item in Single)
            {

                lblSingle.Text = item.DisplayText.ToString();
            }

            var Second = from child in lstmetadataOutput
                         where child.Code == "1"
                         select child;

            foreach (var item in Second)
            {

                lblDouble.Text = item.DisplayText.ToString();
            }

        }
    }

}
