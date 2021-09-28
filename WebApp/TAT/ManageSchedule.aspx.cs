using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class Admin_ManageSchedule : BasePage
{
    string defaultTextHH = "HH";
    string defaultTextMM = "MM";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnorgid.Value = Convert.ToString(OrgID);
            LoadMetaData();
            txtwatermark();
            LoadTransitTimeType();
        }
    }
    protected void LoadTransitTimeType()
    {
        try
        {

            long returncode = -1;
            string domains = "TransitTime";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new TAT_BL(base.ContextInfo).LoadMetaDataOrgMappingTAT(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItemsTAT = from child in lstmetadataOutput
                                    where child.Domain == "TransitTime"
                                    select child;

                if (childItemsTAT.Count() > 0)
                {
                    ddlTransitTime.DataSource = childItemsTAT;
                    ddlTransitTime.DataTextField = "DisplayText";
                    ddlTransitTime.DataValueField = "Code";
                    ddlTransitTime.DataBind();
                    ddlTransitTime.Items.Insert(0, "--Select--");
                    ddlTransitTime.Items[0].Value = "0";
                    ddlTransitTime.SelectedValue = "0";
                }



            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadTransitTimeType() Method in TAT Manage Logistics", ex);

        }
    }
    public void txtwatermark()
    {
        if (txtProcessingHours.Text.Trim() != defaultTextHH.Trim() && txtProcessingMins.Text.Trim() != defaultTextMM.Trim())
        {
            txtProcessingHours.Attributes.Add("style", "color:black");
            txtProcessingMins.Attributes.Add("style", "color:black");
        }
        if (txtProcessingHours.Text == "" && txtProcessingHours.Text == "")
        {
            txtProcessingHours.Text = defaultTextHH;
            txtProcessingHours.Attributes.Add("style", "color:gray");
            txtProcessingMins.Text = defaultTextMM;
            txtProcessingMins.Attributes.Add("style", "color:gray");
        }
        txtProcessingHours.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultTextHH + "');");
        txtProcessingHours.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultTextHH + "');");

        txtProcessingMins.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultTextMM + "');");
        txtProcessingMins.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultTextMM + "');");

    }


    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "Tatcalculationbase,Tatmode,Tatprocesstype,WeekDay,WeekNumber";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new TAT_BL(base.ContextInfo).LoadMetaDataOrgMappingTAT(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItemsTAT= from child in lstmetadataOutput
                                  where child.Domain == "Tatcalculationbase"
                                  select child;

                if (childItemsTAT.Count() > 0)
                {
                    ddlTATDate.DataSource = childItemsTAT;
                    ddlTATDate.DataTextField = "DisplayText";
                    ddlTATDate.DataValueField = "Code";
                    ddlTATDate.DataBind();
                    ddlTATDate.Items.Insert(0, "--Select--");
                    ddlTATDate.Items[0].Value = "0";
                    ddlTATDate.SelectedValue = "0";
                }

                var childItemsTatmode = from child in lstmetadataOutput
                                  where child.Domain == "Tatmode"
                                  select child;

                if (childItemsTatmode.Count() > 0)
                {
                    ddlTATMode.DataSource = childItemsTatmode;
                    ddlTATMode.DataTextField = "DisplayText";
                    ddlTATMode.DataValueField = "Code";
                    ddlTATMode.DataBind();
                    ddlTATMode.Items.Insert(0, "--Select--");
                    ddlTATMode.Items[0].Value = "0";
                    ddlTATMode.SelectedValue = "0";
                }
                var childItemsTATProcessType = from child in lstmetadataOutput
                                               where child.Domain == "Tatprocesstype"
                                    select child;

                if (childItemsTATProcessType.Count() > 0)
                {
                    ddlTATProcessType.DataSource = childItemsTATProcessType;
                    ddlTATProcessType.DataTextField = "DisplayText";
                    ddlTATProcessType.DataValueField = "Code";
                    ddlTATProcessType.DataBind();
                    ddlTATProcessType.Items.Insert(0, "--Select--");
                    ddlTATProcessType.Items[0].Value = "0";
                    ddlTATProcessType.SelectedValue = "0";
                }
                var childItemsWeekNumber = from child in lstmetadataOutput
                                           where child.Domain == "WeekNumber"
                                        select child;

                if (childItemsWeekNumber.Count() > 0)
                {
                    ddlScheduleMonthly.DataSource = childItemsWeekNumber;
                    ddlScheduleMonthly.DataTextField = "DisplayText";
                    ddlScheduleMonthly.DataValueField = "Code";
                    ddlScheduleMonthly.DataBind();
                    ddlScheduleMonthly.Items.Insert(0, "--Select--");
                    ddlScheduleMonthly.Items[0].Value = "0";
                    ddlScheduleMonthly.SelectedValue = "0";
                }

                var childItemsWeekDay = from child in lstmetadataOutput
                                        where child.Domain == "WeekDay"
                                    select child;

                if (childItemsWeekDay.Count() > 0)
                {
                    ddlScheduleDaily.DataSource = childItemsWeekDay;
                    ddlScheduleDaily.DataTextField = "DisplayText";
                    ddlScheduleDaily.DataValueField = "Code";
                    ddlScheduleDaily.DataBind();
                    ddlScheduleDaily.Items.Insert(0, "--Select--");
                    ddlScheduleDaily.Items[0].Value = "0";
                    ddlScheduleDaily.SelectedValue = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMetaData() Method in Manage Schedule", ex);

        }
    }

}
