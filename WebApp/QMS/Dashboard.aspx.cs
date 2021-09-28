using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Xml.Linq;
using Attune.Solution.DAL;
using Attune.Podium.SmartAccessor;
using System.Collections.Specialized;
using AjaxControlToolkit;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Collections;
using System.Xml;
using System.Data;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using Attune.Podium.PerformingNextAction;
using ReportBusinessLogic;
using Attune.Podium.BusinessEntities.CustomEntities;

public partial class Dashboard : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hdnorgid.Value = OrgID.ToString();
            hdnroleid.Value = RoleID.ToString();
            hdnuserid.Value = LID.ToString();    



        }

    }


    

}
