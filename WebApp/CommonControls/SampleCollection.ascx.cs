using System;
using System.Collections.Generic;
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
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;

public partial class CommonControls_SampleCollection : BaseControl
{
    long pVisitID = -1;
    Investigation_BL investigationBL;
    List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
    List<PatientInvestigation> lstOrderedInvestigations = new List<PatientInvestigation>();
    List<PatientInvSample> lstPatientInvSample1 = new List<PatientInvSample>();
    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
    List<PatientInvSampleMapping> lstPatientInvSampleMappingTemp = new List<PatientInvSampleMapping>();
    List<PatientInvSampleResults> lstPatientInvSampleResultsTemp = new List<PatientInvSampleResults>();
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        if (IsPostBack)
        {
            if (hdnSample.Value != "")
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "showOrdSampleTab", "CreateJavaScriptTables();", true);
            }
        }
    }
    public void LoadPatientInvSample(List<PatientInvSample> lstPatientInvSample, List<SampleAttributes> lstSampleAttributes)
    {
        lstPatientInvSample1 = lstPatientInvSample;
        if (lstPatientInvSample.Count > 0)
        {
            ddlSamples.Items.Clear();
            ddlSamples.DataSource = lstPatientInvSample;
            ddlSamples.DataTextField = "SampleDesc";
            ddlSamples.DataValueField = "SampleID";

            ddlSamples.DataBind();
            ddlSamples.Items.Insert(0, new ListItem("Select", "0"));
        }
        if (lstSampleAttributes.Count > 0)
        {
            ddlAttributes.Items.Clear();
            ddlAttributes.DataSource = lstSampleAttributes;
            ddlAttributes.DataTextField = "AttributesName";
            ddlAttributes.DataValueField = "AttributesID";
            ddlAttributes.DataBind();
            ddlAttributes.Items.Insert(0, new ListItem("Select", "0"));
        }
    }
    public void GetPatientInvestigationSampleResults(long patientVisitID,int deptID)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        pVisitID = patientVisitID;
        hdnSampleInvMapping.Value = "";
        int showMappingTab = 0;
        investigationBL.GetOrderedInvestigations(patientVisitID, OrgID, out lstOrderedInvestigations, out lstPatientInvSampleMappingTemp, out lstPatientInvSampleResultsTemp);
        if (!IsPostBack)
        {
            if (lstPatientInvSampleResultsTemp.Count > 0)
            {
                hdnSample.Value = "";
                int i = 0;
                foreach (PatientInvSampleResults objSR in lstPatientInvSampleResultsTemp)
                {
                    hdnSample.Value += "RID^" + i + "~SNC^" + objSR.SampleCode + "~SN^" + objSR.SampleName + "~SAC^" + objSR.AttributesID + "~SA^" + objSR.AttributesName + "~SV^" + objSR.SampleValues + "~SD^" + objSR.SampleDesc + "|";
                    i += 1;
                }
            }
        }
        if (lstOrderedInvestigations.Count > 0)
        {
            string strConfigKey = "SampleMapping";
            string configValue = GetConfigValueForSampleMapping(strConfigKey, OrgID);
            int tempK = 0;
            foreach (PatientInvSample obj in lstPatientInvSample1)
            {
                tempK += 1;
            TableRow row1 = new TableRow();
            TableCell cell = new TableCell();
            TableCell cell1 = new TableCell();
            cell.Attributes.Add("align", "left");
            cell.Text = obj.SampleDesc;
            row1.Cells.Add(cell);
            cell1.Attributes.Add("align", "left");
            cell1.Text = " - (Sample Used For) ";
            row1.Cells.Add(cell1);
            row1.Font.Bold = true;
            row1.Font.Size = 8;
            row1.CssClass = "Duecolor";
            //row1.Style.Add("background-color", "#");
            row1.Style.Add("height", "20px");
            //row1.Style.Add("color", "#ffffff");
            sampleInvMappingTab.Rows.Add(row1);
            foreach (PatientInvestigation obj1 in lstOrderedInvestigations)
                {
                    int chk = 0;
                    var exist = from mapList in lstPatientInvSampleMappingTemp
                                where mapList.DeptID == deptID && mapList.ID == obj1.InvestigationID && mapList.SampleID == obj.SampleID
                                select mapList;
                    if (exist.Count() > 0)
                    {
                        chk = 1;
                    }

                   
                    //if (deptID == obj1.DeptID)
                    if (configValue == "Y")
                    {
                        TableRow row2 = new TableRow();
                        TableCell cel2 = new TableCell();
                        TableCell cel3 = new TableCell();
                        CheckBox chkBox = new CheckBox();
                        cel2.Attributes.Add("align", "left");
                        chkBox.ID = "chkBox" + obj.SampleID + obj1.InvestigationID + obj1.Type + tempK;
                        hdnSampleInvMapping.Value += "chkBox" + obj.SampleID + obj1.InvestigationID + obj1.Type + tempK + "~" + obj.SampleID + "~" + obj1.InvestigationID + "~" + obj1.Type + "^";
                        //hdnSampleInvMappingTemp.Value += "chkBox" + obj.SampleCode + obj1.InvestigationID + obj1.Type + "~" + obj.SampleID + "~" + obj1.InvestigationID + "~" + obj1.Type + "^";
                        if (chk == 1)
                        {
                            chkBox.Checked = true;
                        }
                        chkBox.Attributes.Add("onclick", "javascript:mapSample(this.id);");
                        cel2.Controls.Add(chkBox);
                        row2.Cells.Add(cel2);
                        cel3.Attributes.Add("align", "left");
                        cel3.Text = obj1.InvestigationName.ToString();
                        row2.Cells.Add(cel3);
                        row2.Font.Bold = true;
                        row2.Font.Size = 8;
                        //row1.Style.Add("background-color", "#");
                        row2.CssClass = "colorpaytype1";
                        //row2.Style.Add("color", "#000000");
                        sampleInvMappingTab.Rows.Add(row2);
                        showMappingTab = 1;
                   }
                }
            }
            if (showMappingTab == 1)
            {
                ACX2minus3.Style.Add("display", "block");
                sampleInvMappingTab.Style.Add("display", "block");
            }
            else
            {
                ACX2minus3.Style.Add("display", "none");
                sampleInvMappingTab.Style.Add("display", "none");
            }
        }
    }

    public string GetConfigValueForSampleMapping(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    public List<PatientInvSampleMapping> GetSampleInvMapping()
    {
        foreach (string id in hdnSampleInvMapping.Value.Split('^'))
        {
            if (id != "")
            {
                string[] strTemp = id.Split('~');
                PatientInvSampleMapping objMapp = new PatientInvSampleMapping();
                CheckBox chkBoxTemp = FindControl(strTemp[0]) as CheckBox;
                if (chkBoxTemp.Checked)
                {
                objMapp.VisitID = pVisitID;
                objMapp.OrgID = OrgID;
                objMapp.SampleID = Convert.ToInt32(strTemp[1]);
                objMapp.ID = Convert.ToInt64(strTemp[2]);
                objMapp.Type = strTemp[3];
                lstPatientInvSampleMapping.Add(objMapp);
                }
            }
        }
       
        return lstPatientInvSampleMapping;
    }

    public List<PatientInvSampleResults> GetPInvSampleResults(long patientVisitID)
    {
        string psample = string.Empty;
        string newpsample = string.Empty;
        string dtoRemove = string.Empty;

        if (hdnSampleDeleted.Value != null)
        {
            dtoRemove = hdnSampleDeleted.Value.ToString();
        }
        List<PatientInvSampleResults> pinvr = new List<PatientInvSampleResults>();
        if (hdnSample.Value != null)
            psample = hdnSample.Value.ToString();

        string sNewDatas = "";
        bool bDeleted = false;
        foreach (string row in psample.Split('|'))
        {
            bDeleted = false;
            foreach (string removedrow in dtoRemove.Split('|'))
            {
                if (row.Trim() == removedrow.Trim())
                {
                    bDeleted = true;
                }
            }
            if (bDeleted != true)
            {
                sNewDatas += row.ToString() + "|";
            }
        }

        did.Value = "";

        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                PatientInvSampleResults epinvr = new PatientInvSampleResults();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    long drugID = 0;
                    short dFrqID = 0;
                    switch (colName)
                    {
                        case "SNC":
                            epinvr.SampleCode = Convert.ToInt32(colValue);
                            break;
                        //case "SN":
                        //    epinvr.AttributesID = Convert.ToInt32(colValue);
                        //    break;
                        case "SAC":
                            epinvr.AttributesID = Convert.ToInt32(colValue);
                            break;
                        case "SV":
                            epinvr.SampleValues = colValue;
                            break;
                        case "SD":
                            epinvr.SampleDesc = colValue;
                            break;
                    };
                }
                epinvr.VisitID = patientVisitID;
                epinvr.OrgID = OrgID;
                epinvr.CreatedBy = LID;
                pinvr.Add(epinvr);
            }

        }

        return pinvr;
    }
}
