using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Web.Script.Serialization;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Web.Caching;
using Attune;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Specialized;
using System.Data;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Web.UI.HtmlControls;

public partial class Investigation_SummaryReport : BasePage
{
    List<Int64> lstSelectedInvID = new List<Int64>();
    Investigation_BL objInvBL ;
    List<OrderedPatientInvs> lstOrderedPatientInvs = new List<OrderedPatientInvs>();
    List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
    List<SuggestedInvMapping> lstSuggestedInvMapping = new List<SuggestedInvMapping>();
    List<SuggestedInvMapping> lsttmpSuggestedInvMapping = new List<SuggestedInvMapping>();
    List<SuggestedInvMapping> lstFinalSuggestedInvsOfPatient = new List<SuggestedInvMapping>();
    List<SuggestedInvMapping> lstSuggInvsOfPatientWithOutOrderedInvs = new List<SuggestedInvMapping>();
    Dictionary<long, List<SuggestedInvMapping>> lstDic = new Dictionary<long, List<SuggestedInvMapping>>();
    List<SuggestedInvs> lstSuggInvs = new List<SuggestedInvs>();
    string pGender = string.Empty;
    string pAge = string.Empty;
    string pAgeType = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        objInvBL = new Investigation_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["vid"]))
                {
                    hdnVisitID.Value = Request.QueryString["vid"];
                }
                hdnOrgID.Value = Convert.ToString(OrgID);
                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");

                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath ;
                sPath = sPath + "/fckeditor/";

                FCKSection1.BasePath = sPath;
                FCKSection1.ToolbarSet = "SummaryReport";
                FCKSection1.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                FCKSection1.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblFCKSection1", String.Format("var lblFCKSection1=\"{0}\";", FCKSection1.ClientID), true);

                Page.ClientScript.RegisterOnSubmitStatement(FCKSection1.GetType(), FCKSection1.ClientID + "editor", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKSection1.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKSection1.ClientID + "').UpdateLinkedField();}}");

                FCKSection2.BasePath = sPath;
                FCKSection2.ToolbarSet = "SummaryReport";
                FCKSection2.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                FCKSection2.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblFCKSection2", String.Format("var lblFCKSection2=\"{0}\";", FCKSection2.ClientID), true);

                Page.ClientScript.RegisterOnSubmitStatement(FCKSection2.GetType(), FCKSection2.ClientID + "editor", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKSection2.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKSection2.ClientID + "').UpdateLinkedField();}}");

                FCKSection3.BasePath = sPath;
                FCKSection3.ToolbarSet = "SummaryReport";
                FCKSection3.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                FCKSection3.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblFCKSection3", String.Format("var lblFCKSection3=\"{0}\";", FCKSection3.ClientID), true);

                Page.ClientScript.RegisterOnSubmitStatement(FCKSection3.GetType(), FCKSection3.ClientID + "editor", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKSection3.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKSection3.ClientID + "').UpdateLinkedField();}}");

                FCKSection4.BasePath = sPath;
                FCKSection4.ToolbarSet = "SummaryReport";
                FCKSection4.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                FCKSection4.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblFCKSection4", String.Format("var lblFCKSection4=\"{0}\";", FCKSection4.ClientID), true);

                Page.ClientScript.RegisterOnSubmitStatement(FCKSection4.GetType(), FCKSection4.ClientID + "editor", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKSection4.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKSection4.ClientID + "').UpdateLinkedField();}}");

                ACEResultTemplate.ContextKey = OrgID + "~" + InvSummaryTemplateType.ResultSummary;
                ACEInterTemplate.ContextKey = OrgID + "~" + InvSummaryTemplateType.ClinicalInterpretation;
                ACESuggestTemplate.ContextKey = OrgID + "~" + InvSummaryTemplateType.Suggestions;
                ACETestName.ContextKey = Convert.ToString(OrgID);
                ACEComplaint.ContextKey = Convert.ToString(OrgID);

                LoadSummaryReportConfig();
                SuggedtedInvestigations();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "SetVisibleDiv", "SetVisibleContent()", true);
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = ex.Message;
            CLogger.LogError("Error in Page Load Event", ex);
        }
    }

    private void LoadSummaryReportConfig()
    {
        long returnCode = -1;
        try
        {
            List<InvSummaryReport> lstInvSummaryReport = new List<InvSummaryReport>();
            List<InvSummaryTrend> lstInvSummaryTrend = new List<InvSummaryTrend>();
            List<InvestigationMaster> lstTrendInvestigations = new List<InvestigationMaster>();
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            returnCode = objInvBL.GetSummaryReportConfig(OrgID, Convert.ToInt64(hdnVisitID.Value), out lstInvSummaryReport, out lstInvSummaryTrend, out lstTrendInvestigations);
            if (lstInvSummaryReport.Count > 0)
            {
                InvSummaryReport oInvSummaryReport = lstInvSummaryReport[0];
                FCKSection1.Value = oInvSummaryReport.ResultSummary;
                FCKSection2.Value = oInvSummaryReport.ClinicalInterpretation;
                FCKSection3.Value = oInvSummaryReport.Suggestions;
                FCKSection4.Value = oInvSummaryReport.Comments;
                chkTRF.Checked = oInvSummaryReport.ShowTRF;
            }
            
            if (lstTrendInvestigations.Count > 0)
            {
                if (lstInvSummaryTrend.Count > 0)
                {
                    string[] lstInvID;
                    foreach (InvSummaryTrend oInvSummaryReport in lstInvSummaryTrend)
                    {
                        lstInvID = oInvSummaryReport.TrendInvId.Split(',');
                        if (lstInvID != null)
                        {
                            foreach (string invId in lstInvID)
                            {
                                lstSelectedInvID.Add(Convert.ToInt64(invId));
                            }
                        }
                    }
                }
                dlPastTrend.DataSource = lstTrendInvestigations;
                dlPastTrend.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSummaryReportConfig", ex);
            throw ex;
        }
    }

    protected void dlPastTrend_ItemDataBound(Object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                InvestigationMaster objInvMaster = (InvestigationMaster)e.Item.DataItem;
                CheckBox chkPastTrend = (CheckBox)e.Item.FindControl("chkPastTrend");
                HiddenField hdnInvID = (HiddenField)e.Item.FindControl("hdnInvID");
                HiddenField hdnTestCode = (HiddenField)e.Item.FindControl("hdnTestCode");
                string[] lstInvPattern = hdnTestCode.Value.Split('~');
                if (lstSelectedInvID.Contains(Convert.ToInt64(hdnInvID.Value)))
                {
                    chkPastTrend.Checked = true;
                    ShowChart(Convert.ToInt64(lstInvPattern[0]), Convert.ToInt64(lstInvPattern[1]));
                }
                else
                {
                    chkPastTrend.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in datalist itembound", ex);
            throw ex;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            InvSummaryReport oInvSummaryReport = new InvSummaryReport();
            oInvSummaryReport.ResultSummary = FCKSection1.Value;
            oInvSummaryReport.ClinicalInterpretation = FCKSection2.Value;
            oInvSummaryReport.Suggestions = FCKSection3.Value;
            oInvSummaryReport.Comments = FCKSection4.Value;
            oInvSummaryReport.ShowTRF = chkTRF.Checked;
            oInvSummaryReport.OrgID = OrgID;
            oInvSummaryReport.VisitID = Convert.ToInt64(hdnVisitID.Value);
            oInvSummaryReport.CreatedBy = LID;

            List<InvSummaryTrend> lstInvSummaryTrend = new List<InvSummaryTrend>();
            List<string> lstSelectedInvTrend = new List<string>();
            foreach (DataListItem objItem in dlPastTrend.Items)
            {
                CheckBox chkPastTrend = (CheckBox)objItem.FindControl("chkPastTrend");
                HiddenField hdnTestCode = (HiddenField)objItem.FindControl("hdnTestCode");
                if (chkPastTrend.Checked)
                {
                    lstSelectedInvTrend.Add(hdnTestCode.Value);
                }
            }
            if (lstSelectedInvTrend.Count > 0)
            {
                string[] oInvPatternId;
                Int64 invId = 0;
                Int64 patternId = 0;
                RuntimeChart runChart;
                Chart m_chart;
                Int32 imgCount = 0;
                string trendInvIds = string.Empty;
                List<MemoryStream> lstImgFiles = new List<MemoryStream>();
                Int32 selectedInvCount = lstSelectedInvTrend.Count;
                InvSummaryTrend oInvSummaryTrend = new InvSummaryTrend();
                oInvSummaryTrend.CreatedBy = LID;
                oInvSummaryTrend.OrgId = OrgID;
                oInvSummaryTrend.VisitId = Convert.ToInt64(hdnVisitID.Value);
                MemoryStream stream = new MemoryStream();
                for (var i = 0; i < selectedInvCount; i++)
                {
                    oInvPatternId = lstSelectedInvTrend[i].Split('~');
                    invId = String.IsNullOrEmpty(oInvPatternId[0]) ? 0 : Convert.ToInt64(oInvPatternId[0]);
                    patternId = String.IsNullOrEmpty(oInvPatternId[1]) ? 0 : Convert.ToInt64(oInvPatternId[1]);

                    m_chart = new Chart();
                    stream = new MemoryStream();
                    runChart = new RuntimeChart();
                    m_chart = runChart.CreateChart(Convert.ToInt64(hdnVisitID.Value), OrgID, patternId, invId);

                    m_chart.SaveImage(stream);
                    
                    oInvSummaryTrend.Content = stream.ToArray();
                    oInvSummaryTrend.TrendInvId = invId.ToString();
                    lstInvSummaryTrend.Add(oInvSummaryTrend);
                    //lstImgFiles.Add(stream);

                    //if (trendInvIds.Length == 0)
                    //    trendInvIds = invId.ToString();
                    //else
                    //    trendInvIds = trendInvIds + "," + invId.ToString();
                    //imgCount += 1;

                    //if (imgCount == 2)
                    //{
                    //    Bitmap image = ImageMerger.Combine(lstImgFiles);
                    //    using (MemoryStream ms = new MemoryStream())
                    //    {
                    //        image.Save(ms, ImageFormat.Png);
                    //        oInvSummaryTrend.Content = ms.ToArray();
                    //    }
                    //    oInvSummaryTrend.TrendInvId = trendInvIds;
                    //    lstInvSummaryTrend.Add(oInvSummaryTrend);
                    //    trendInvIds = string.Empty;
                    //    imgCount = 0;
                    //    lstImgFiles = new List<MemoryStream>();
                    //}
                    //else if (i == selectedInvCount - 1)
                    //{
                    //    oInvSummaryTrend.Content = stream.ToArray();
                    //    oInvSummaryTrend.TrendInvId = trendInvIds;
                    //    lstInvSummaryTrend.Add(oInvSummaryTrend);
                    //}
                }
            }

            Investigation_BL oInvBL = new Investigation_BL(base.ContextInfo);
            returnCode = oInvBL.SaveInvSummaryReport(OrgID, Convert.ToInt64(hdnVisitID.Value), LID, oInvSummaryReport, lstInvSummaryTrend);

            if (returnCode == 0)
            {
                NameValueCollection lstQueryString = Request.QueryString;
                string queryString = string.Empty;
                string nameValue = string.Empty;
                foreach (string name in lstQueryString)
                {
                    nameValue = name + "=" + Request.QueryString[name];
                    if (queryString.Length == 0)
                    {
                        queryString = nameValue;
                    }
                    else
                    {
                        queryString = queryString + "&" + nameValue;
                    }
                }
                Response.Redirect("~/Investigation/InvReportsForApproval.aspx?" + queryString);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Save", "alert('There was a problem while saving summary report')", true);
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = ex.Message;
            CLogger.LogError("Error while Save summary report", ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            NameValueCollection lstQueryString = Request.QueryString;
            string queryString = string.Empty;
            string nameValue = string.Empty;
            foreach (string name in lstQueryString)
            {
                nameValue = name + "=" + Request.QueryString[name];
                if (queryString.Length == 0)
                {
                    queryString = nameValue;
                }
                else
                {
                    queryString = queryString + "&" + nameValue;
                }
            }
            Response.Redirect("~/Investigation/InvReportsForApproval.aspx?" + queryString);
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = ex.Message;
            CLogger.LogError("Error while cancel summary report", ex);
        }
    }

    //protected void chkPastTrend_CheckedChanged(object sender, System.EventArgs e)
    //{
    //    try
    //    {
    //        CheckBox chk = ((CheckBox)sender);
    //        DataListItem dlItem = ((DataListItem)chk.NamingContainer);
    //        Label lblTestCode = ((Label)dlPastTrend.Items[dlItem.ItemIndex].FindControl("lblTestCode"));
    //        string[] lstInvPattern = lblTestCode.Text.Split('~');
    //        if (chk.Checked)
    //        {
    //            ShowChart(Convert.ToInt64(lstInvPattern[0]), Convert.ToInt64(lstInvPattern[1]));
    //        }
    //        else
    //        {
    //            foreach (TableRow row in tblInvPastTrend.Rows)
    //            {
    //                if (row.Cells[0].Text == lstInvPattern[0])
    //                {
    //                    tblInvPastTrend.Rows.Remove(row);
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = ex.Message;
    //        CLogger.LogError("Error in checkbox change event", ex);
    //    }
    //}

    private void ShowChart(Int64 invId, Int64 patternId)
    {
        try
        {
            //TableRow row = new TableRow();
            //TableCell cell1 = new TableCell();
            //TableCell cell2 = new TableCell();
            //System.Web.UI.WebControls.Image image = new System.Web.UI.WebControls.Image();
            RuntimeChart runChart = new RuntimeChart();
            Chart m_chart = runChart.CreateChart(Convert.ToInt64(hdnVisitID.Value), OrgID, patternId, invId);

            String tempFileName = String.Format("TempChartImage/Chart_{0}.png", System.Guid.NewGuid().ToString());

            tempFileName = HttpContext.Current.Request.PhysicalApplicationPath + tempFileName;

            m_chart.SaveImage(tempFileName);

            String strImageSrc = @"TempChartImage/" + Path.GetFileName(tempFileName);

            ChartImageDestructor cid = new ChartImageDestructor(tempFileName);
            System.Web.Caching.CacheItemRemovedCallback onRemove = new System.Web.Caching.CacheItemRemovedCallback(cid.RemovedCallback);

            HttpContext.Current.Cache.Add(tempFileName, cid, null,
                  Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1),
                  System.Web.Caching.Cache.NoSlidingExpiration,
                  System.Web.Caching.CacheItemPriority.NotRemovable,
                  onRemove);
            HtmlGenericControl dynDiv = new  HtmlGenericControl("DIV");
            dynDiv.ID = "divColumnChart" + invId;
            dynDiv.Attributes.Add("class", "divColumn");
            HtmlImage image = new HtmlImage();
            image.Border = 0;
            image.Src = "../" + strImageSrc;
            dynDiv.Controls.Add(image);
            divRowChart.Controls.Add(dynDiv);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating delta chart", ex);
            throw ex;
        }
    }

    public void SuggedtedInvestigations()
    {
        long returnCode = -1;
        long ValueRangeMasterID = -1;
        int i = 0;
        int j = 0;
        int k = 0;
        returnCode = objInvBL.getSuggedtedInvestigations(Convert.ToInt64(hdnVisitID.Value), OrgID, out lstOrderedPatientInvs, out lstInvValueRangeMaster, out lstSuggestedInvMapping);
        for (i = 0; i < lstOrderedPatientInvs.Count; i++)
        {
            pGender = lstOrderedPatientInvs[0].PatientGender;
            pAge = lstOrderedPatientInvs[0].PatientAge;
            pAgeType = lstOrderedPatientInvs[0].PatientAgeType;
            for (j = 0; j < lstInvValueRangeMaster.Count; j++)
            {
                if (lstOrderedPatientInvs[i].InvestigationID == lstInvValueRangeMaster[j].InvestigationID)
                {
                    ValueRangeMasterID = ValidateUserResult(lstInvValueRangeMaster[j].ValueRange, lstOrderedPatientInvs[i].InvValue, lstInvValueRangeMaster[j].InvValueRangeMasterID);
                }
                if (ValueRangeMasterID > 0)
                {
                    lsttmpSuggestedInvMapping = lstSuggestedInvMapping.FindAll(P => P.InvValueRangeMasterID == ValueRangeMasterID);
                    lstDic.Add(lstOrderedPatientInvs[i].InvestigationID, lsttmpSuggestedInvMapping);
                }
            }
        }
        List<long> InvIds = new List<long>(lstDic.Keys);
        foreach (long id in InvIds)
        {
            if (lstDic.ContainsKey(id))
            {
                List<SuggestedInvMapping> Value = new List<SuggestedInvMapping>();
                Value = lstDic[id];
                foreach (SuggestedInvMapping SI in Value)
                {
                    lstFinalSuggestedInvsOfPatient.Add(SI);
                }
            }
        }
        for (k = 0; k < lstOrderedPatientInvs.Count; k++)
        {
            lstFinalSuggestedInvsOfPatient.RemoveAll(P => P.InvestigationID == lstOrderedPatientInvs[k].InvestigationID);
        }
        for (int l = 0; l < lstFinalSuggestedInvsOfPatient.Count; l++)
        {
            SuggestedInvs SuggInvs = new SuggestedInvs();
            if (lstSuggInvs.Count > 0)
            {
                for (int m = 0; m < lstSuggInvs.Count; m++)
                {
                    if (lstFinalSuggestedInvsOfPatient[l].InvestigationID != lstSuggInvs[m].InvestigationID)
                    {
                        SuggInvs.InvestigationID = lstFinalSuggestedInvsOfPatient[l].InvestigationID;
                        SuggInvs.InvestigationName = lstFinalSuggestedInvsOfPatient[l].InvestigationName;
                        lstSuggInvs.Add(SuggInvs);
                    }
                }
            }
            else
            {
                SuggInvs.InvestigationID = lstFinalSuggestedInvsOfPatient[l].InvestigationID;
                SuggInvs.InvestigationName = lstFinalSuggestedInvsOfPatient[l].InvestigationName;
                lstSuggInvs.Add(SuggInvs);
            }
        }
        if (lstSuggInvs.Count > 0)
        {
            string suggestedInv = "<ul>";
            foreach (SuggestedInvs oSuggestedInvs in lstSuggInvs)
            {
                suggestedInv = suggestedInv + "<li>" + oSuggestedInvs.InvestigationName + "</li>";
            }
            suggestedInv = suggestedInv + "</ul>";
            FCKSection3.Value = FCKSection3.Value + suggestedInv;
        }
    }
    public long ValidateUserResult(string xmlData, string Value, long ID)
    {
        string textColor = string.Empty;
        decimal rangeValue;
        decimal.TryParse(Value, out rangeValue);

        int pAgeint = Convert.ToInt32(pAge);

        if (pAgeType == "Year(s)")
        {
            pAgeType = "Years";
        }
        else if (pAgeType == "Week(s)")
        {
            pAgeType = "Weeks";
        }
        else if (pAgeType == "Month(s)")
        {
            pAgeType = "Months";
        }
        else if (pAgeType == "Day(s)")
        {
            pAgeType = "Days";
        }
        long patientAgeInDays = ConvertToDays(Convert.ToInt32(pAge), pAgeType);

        if (TryParseXml(xmlData))
        {


            XElement xe = XElement.Parse(xmlData);


            var ageRange = from age in xe.Elements("referencerange").Elements("property")
                           where (string)age.Attribute("type") == "age" && (string)age.Attribute("value") == pGender //&& (string)age.Attribute("mode") == pAgetype
                           select age;

            var ageRangeBoth = from age in xe.Elements("referencerange").Elements("property")
                               where (string)age.Attribute("type") == "age" && (string)age.Attribute("value") == "Both" //&& (string)age.Attribute("mode") == pAgetype
                               select age;


            var commonRange = from common in xe.Elements("referencerange").Elements("property")
                              where (string)common.Attribute("type") == "common" && (string)common.Attribute("value") == pGender
                              select common;

            var otherRange = from other in xe.Elements("referencerange").Elements("property")
                             where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == pGender
                             select other;



            var commonRangeBoth = from common in xe.Elements("referencerange").Elements("property")
                                  where (string)common.Attribute("type") == "common" && (string)common.Attribute("value") == "Both"
                                  select common;

            var otherRangeBoth = from other in xe.Elements("referencerange").Elements("property")
                                 where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == "Both"
                                 select other;


            if (ageRange.Count() > 0)
            {
                //textColor = "Red";

                foreach (var lst in ageRange)
                {


                    if (lst.Element("lst") != null)
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToInt32(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            switch (ConvertStringOptr(lst.Element("lst").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }


                        }


                    }

                    if (lst.Element("lsq") != null)
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToInt32(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("lsq").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }



                    }

                    if (lst.Element("eql") != null)
                    {

                        if (patientAgeInDays == ConvertToDays(Convert.ToInt32(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("eql").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }

                    }

                    if (lst.Element("grt") != null)
                    {


                        if (patientAgeInDays > ConvertToDays(Convert.ToInt32(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("grt").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }




                    }


                    if (lst.Element("grq") != null)
                    {



                        if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("grq").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }




                    }

                    if (lst.Element("btw") != null)
                    {

                        string[] between = lst.Element("btw").Value.Split('-');


                        if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToInt32(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {


                            switch (ConvertStringOptr(lst.Element("btw").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }



                    }

                }



            }


            if (ageRangeBoth.Count() > 0)
            {
                //textColor = "Red";

                foreach (var lst in ageRangeBoth)
                {


                    if (lst.Element("lst") != null)
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToInt32(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            switch (ConvertStringOptr(lst.Element("lst").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }


                        }


                    }

                    if (lst.Element("lsq") != null)
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToInt32(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("lsq").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }



                    }

                    if (lst.Element("eql") != null)
                    {

                        if (patientAgeInDays == ConvertToDays(Convert.ToInt32(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("eql").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }




                    }

                    if (lst.Element("grt") != null)
                    {


                        if (patientAgeInDays > ConvertToDays(Convert.ToInt32(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("grt").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }




                    }


                    if (lst.Element("grq") != null)
                    {



                        if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                        {

                            switch (ConvertStringOptr(lst.Element("grq").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }




                    }

                    if (lst.Element("btw") != null)
                    {

                        string[] between = lst.Element("btw").Value.Split('-');

                        if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToInt32(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {


                            switch (ConvertStringOptr(lst.Element("btw").FirstAttribute.Value))
                            {
                                case "<":

                                    if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;

                                case "<=":

                                    if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=":

                                    if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case "=>":

                                    if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case ">":

                                    if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;
                                case " ":

                                    string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                                    if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                                    {
                                        textColor = "white";
                                    }
                                    else
                                    {
                                        textColor = "Yellow";
                                    }

                                    break;


                            }
                        }



                    }

                }



            }



            if (commonRange.Count() > 0)
            {


                foreach (var lst in commonRange)
                {


                    if (lst.Element("lst") != null)
                    {
                        if (rangeValue < Convert.ToDecimal(lst.Element("lst").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }


                    }

                    if (lst.Element("lsq") != null)
                    {

                        if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }

                    }

                    if (lst.Element("eql") != null)
                    {
                        if (rangeValue == Convert.ToDecimal(lst.Element("eql").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("grt") != null)
                    {
                        if (rangeValue > Convert.ToDecimal(lst.Element("grt").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }


                    if (lst.Element("grq") != null)
                    {
                        if (rangeValue >= Convert.ToDecimal(lst.Element("grq").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');


                        if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                }


            }

            if (commonRangeBoth.Count() > 0)
            {


                foreach (var lst in commonRangeBoth)
                {


                    if (lst.Element("lst") != null)
                    {
                        if (rangeValue < Convert.ToDecimal(lst.Element("lst").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }


                    }

                    if (lst.Element("lsq") != null)
                    {

                        if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }

                    }

                    if (lst.Element("eql") != null)
                    {
                        if (rangeValue == Convert.ToDecimal(lst.Element("eql").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("grt") != null)
                    {
                        if (rangeValue > Convert.ToDecimal(lst.Element("grt").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }


                    if (lst.Element("grq") != null)
                    {
                        if (rangeValue >= Convert.ToDecimal(lst.Element("grq").Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');


                        if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                }


            }


            if (otherRange.Count() > 0)
            {
                textColor = "Blue";


                foreach (var lst in otherRange)
                {


                    if (lst.Element("lst") != null)
                    {

                        if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }



                    }

                    if (lst.Element("lsq") != null)
                    {

                        if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("eql") != null)
                    {
                        if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("grt") != null)
                    {
                        if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }


                    if (lst.Element("grq") != null)
                    {
                        if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("btw") != null)
                    {

                        string[] between = lst.Element("btw").LastAttribute.Value.Split('-');


                        if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                }

            }

            if (otherRangeBoth.Count() > 0)
            {
                textColor = "Blue";


                foreach (var lst in otherRangeBoth)
                {


                    if (lst.Element("lst") != null)
                    {

                        if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }



                    }

                    if (lst.Element("lsq") != null)
                    {

                        if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("eql") != null)
                    {
                        if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("grt") != null)
                    {
                        if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }


                    if (lst.Element("grq") != null)
                    {
                        if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                    if (lst.Element("btw") != null)
                    {

                        string[] between = lst.Element("btw").LastAttribute.Value.Split('-');


                        if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                        {
                            textColor = "white";
                        }
                        else
                        {
                            textColor = "Yellow";
                        }
                    }

                }

            }


        }
        if (textColor == "white")
        {
            return ID;
        }
        else
        {
            return 0;
        }
    }
    long ConvertToDays(int age, string agetype)
    {
        long ageInDays = 0;

        switch (agetype)
        {
            case "Weeks":
                ageInDays = age * 7;
                break;
            case "Months":
                ageInDays = age * 30;
                break;
            case "Years":
                ageInDays = age * 365;
                break;
            case "Days":
                ageInDays = age;
                break;
        }
        return ageInDays;

    }
    public string ConvertStringOptr(string symbol)
    {
        string ReturnValue = "";
        switch (symbol)
        {
            case "lst":
                ReturnValue = "<";
                break;
            case "lsq":
                ReturnValue = "<=";
                break;
            case "eql":
                ReturnValue = "=";
                break;
            case "grt":
                ReturnValue = ">";
                break;
            case "grq":
                ReturnValue = "=>";
                break;
            case "btw":
                ReturnValue = " ";
                break;

        }
        return ReturnValue;

    }
    bool TryParseXml(string xml)
    {
        try
        {
            XElement xe = XElement.Parse(xml);
            return true;
        }
        catch (XmlException e)
        {
            return false;
        }
    }
    private class SuggestedInvs
    {

        private long investigationID = 0;
        private string investigationName = String.Empty;


        public string InvestigationName
        {
            get { return investigationName; }
            set { investigationName = value; }
        }

        public long InvestigationID
        {
            get { return investigationID; }
            set { investigationID = value; }
        }

    }
}



