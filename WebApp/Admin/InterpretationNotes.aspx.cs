using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using System.Xml.Linq;
using System.Web.Script.Serialization;
using System.Globalization;



public partial class Admin_InterpretationNotes : BasePage
{
    public Admin_InterpretationNotes()
        : base("Admin_InterpretationNotes_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                ACETestCodeScheme.ContextKey = Convert.ToString(OrgID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Interpretation Notes page load", ex);
        }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        string AlrtWin = Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07 == null ? "Alert" : Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07;
        string UsrMsg = Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_01 == null ? "There is no interpretation notes" : Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_01;
        try
        {
            Int32 testID = 0;
            Int32.TryParse(hdnID.Value, out testID);
            Master_BL objMasterDAL = new Master_BL(base.ContextInfo);
            List<NameValuePair> lstInterpretationNotes = new List<NameValuePair>();

            objMasterDAL.GetInterpretationNotes(testID, hdnType.Value, out lstInterpretationNotes);
            if (lstInterpretationNotes.Count > 0)
            {
                JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                string interpretation = string.Empty;
                List<InetrpretationNote> Interpretation = new List<InetrpretationNote>();

                foreach (NameValuePair attribData in lstInterpretationNotes)
                {
                    if (!String.IsNullOrEmpty(attribData.Name))
                    {
                        string typeName = attribData.Name;
                        interpretation = typeName;
                        if (interpretation.StartsWith("<Interpretation"))
                        {
                            XmlDocument xmlDoc = new XmlDocument();
                            xmlDoc.LoadXml(interpretation);
                            XmlNodeList lstLayout = xmlDoc.GetElementsByTagName("Item");
                            string layoutType = string.Empty;

                            if (lstLayout != null && lstLayout.Count > 0)
                            {

                                for (int i = 0; i < lstLayout.Count; i++)
                                {

                                    if (lstLayout[i].Attributes.Count > 0)
                                    {
                                        layoutType = lstLayout[i].Attributes[0].Value;
                                        //Interpretation.Add(new(ty))
                                        Interpretation.Add(new InetrpretationNote { Type = lstLayout[i].Attributes[0].Value, Value = lstLayout[i].Attributes[1].Value, RowNo = lstLayout[i].Attributes[2].Value, ColumnNo = lstLayout[i].Attributes[3].Value, ColumnCount = lstLayout[i].Attributes[4].Value });
                                    }

                                }




                            }



                        }

                        else
                        {
                            if (!String.IsNullOrEmpty(attribData.Name))
                            {
                                Interpretation.Add(new InetrpretationNote { Type = "text", Value = attribData.Name, RowNo = "0", ColumnNo = "0", ColumnCount = "0" });
                            }
                        }
                    }
                }
                if (Interpretation.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsg + "','" + AlrtWin + "');", true);

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('There is no interpretation notes');", true);
                }
                else
                {
                    hdnnotes.Value = oJavaScriptSerializer.Serialize(Interpretation);
                    //   hdnnotes.Value = lstInterpretationNotes[0].Name; //oJavaScriptSerializer.Serialize(Interpretation);
                   
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "str", "javascript:GetInterpretationNotes()", true);

                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "str", "javascript:GetInterpretationNotes('1')", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsg + "','" + AlrtWin + "');", true);

               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('There is no interpretation notes');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting interpretation notes", ex);
        }
    }

    public class InetrpretationNote
    {
        public string Type { get; set; }
        public string Value { get; set; }
        public string RowNo { get; set; }
        public string ColumnNo { get; set; }
        public string ColumnCount { get; set; }


    }

   


    protected void btnSave_Click(object sender, EventArgs e)
    {
        string AlrtWin = Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07 == null ? "Alert" : Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07;
        string UsrMsg1 = Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_02 == null ? "Interpretation Notes Saved Successfully" : Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_02;
        string UsrMsg2 = Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_03 == null ? "Error while saving interpretation notes" : Resources.Admin_AppMsg.Admin_InterpretationNotes_aspx_03;
        try
        {
            Int32 testID = 0;
            Int32.TryParse(hdnID.Value, out testID);
            Master_BL objMasterDAL = new Master_BL(base.ContextInfo);
            
            long returncount = objMasterDAL.SaveInterpretationNotes(testID, hdnType.Value, hdnData.Value);
            if (returncount == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsg1 + "','" + AlrtWin + "');", true);

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Interpretation Notes Saved Successfully');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsg2 + "','" + AlrtWin + "');", true);

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Error while saving interpretation notes');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving interpretation notes", ex);
        }
    }
    
    
}
