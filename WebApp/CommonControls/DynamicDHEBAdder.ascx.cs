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

public partial class CommonControls_DynamicDHEBAdder : BaseControl
{
    private string enteredValues = string.Empty;
    
    //Property to be set by user 
    private ViewMode adviceType;
    private string valuedispText = "Description";
    private string commentdispText = "Comments";
    private string servicemethod = string.Empty;
    private string servicepath = string.Empty;

    public ViewMode AdviceMode
    {
        get { return adviceType; }
        set { adviceType = value; }
    }

    public string DescriptionDisplayText
    {
        get { return valuedispText; }
        set 
        { 
            valuedispText = value;
            lblItemName.Text = valuedispText;
        }
    }
    
    public string CommentDisplayText
    {
        get { return commentdispText; }
        set 
        {
            commentdispText = value;
            lblCommentName.Text = commentdispText;
        }
    }

    public string ServiceMethod
    {
        set
        {
            servicemethod = value;
            AutoDescValue.ServiceMethod = servicemethod;
        }
        get { return servicemethod ; }
    }

    public string ServicePath
    {
        set
        {
            servicepath = value;
            AutoDescValue.ServicePath = servicepath;
        }
        get { return servicemethod; }
    }

    
    protected void Page_Load(object sender, EventArgs e)
    {
      //  lblValueMessage.Visible = false;
    }
    string ValueName = string.Empty;

    public List<DHEBAdder> GetValues(long patientVisitID)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        if (hdnValuesDeleted.Value != null)
        {
            dtoRemove = hdnValuesDeleted.Value.ToString();
        }
        List<DHEBAdder> advices = new List<DHEBAdder>();
        if (hdfValues.Value != null)
            prescription = hdfValues.Value.ToString();

        string sNewDatas = "";
        bool bDeleted = false;
        foreach (string row in prescription.Split('|'))
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
                DHEBAdder advice = new DHEBAdder();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    switch (colName)
                    {
                        case "VALUENAME":
                            advice.Description = colValue;
                            break;
                        case "COMMENTS":
                            advice.Comments = colValue;
                            break;
                    };
                }
                advice.PatientVisitID = patientVisitID;
                advice.CreatedBy = LID;
                advices.Add(advice);
            }

        }

        return advices;
    }

    public void SetControl(List<DHEBAdder> dhebDetails)
    {
        int rowcount = 0;
        string sValuesPresent = "";
        string sjScript = string.Empty;
        string sScrptkey = string.Empty;
        // ViewState.Remove("pre");
        foreach (DHEBAdder dhebDet in dhebDetails)
        {
            rowcount++;
            // prescription += "RID^" + rowcount.ToString() + "~DNAME^" + drgDet.DrugName + "~DFRM^" + drgDet.DrugFormulation + "~ROA^" + drgDet.ROA + "~DDOSE^" + drgDet.Dose + "~FRQ^" + drgDet.DrugFrequency + "~DURA^" + drgDet.Days + "|";
            enteredValues += "RID^0~VALUENAME^" + dhebDet.Description + "~COMMENTS^" + dhebDet.Comments + "|";
            sValuesPresent += dhebDet.Description + "|";
        }
        hdfValues.Value = enteredValues;
        hdnValueExists.Value = sValuesPresent;
        sScrptkey = "Scrpt" + DescriptionDisplayText;
        sjScript = "<script>unfCreateJavaScriptTables('" + txtDescValue.ClientID + "','" 
                                                  + txtComments.ClientID + "','" 
                                                  + hdnValuesDeleted.ClientID + "','" 
                                                  + dvTable.ClientID+ "','"
                                                  + hdfValues.ClientID+ "','" 
                                                  + hdnValueExists.ClientID+ "','"
                                                  + DescriptionDisplayText+ "','" 
                                                  + CommentDisplayText+ "') </Script>";

        this.Page.ClientScript.RegisterStartupScript(this.GetType(), sScrptkey, sjScript);
    }
    public void clearvalues()
    {
        hdfValues.Value = "";
        hdnValueExists.Value = "";
        hdnValuesDeleted.Value = "";
      string  sScrptkey = "Scrpt1" + DescriptionDisplayText;
      string sjScript = "<script>unfCreateJavaScriptTables('" + txtDescValue.ClientID + "','"
                                                  + txtComments.ClientID + "','"
                                                  + hdnValuesDeleted.ClientID + "','"
                                                  + dvTable.ClientID + "','"
                                                  + hdfValues.ClientID + "','"
                                                  + hdnValueExists.ClientID + "','"
                                                  + DescriptionDisplayText + "','"
                                                  + CommentDisplayText + "') </Script>";

        this.Page.ClientScript.RegisterStartupScript(this.GetType(), sScrptkey, sjScript);
    }
}
