using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;


   public class RuntimeChart{
      private Chart m_chart;

      private long lngLastVisitID;
      private Double dblLastValue;

      public RuntimeChart() {
         m_chart = new Chart();
      }

      public Chart makeChart(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
      {
          var strPV = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_21 == null ? "Patient Visit(s)" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_21;
          var strValues = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_22 == null ? "Value(s)" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_22;
          var strTN = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_23 == null ? "Test Name: " : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_23;
          var strRR = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_24 == null ? "Reference Range: " : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_24;
          var strVD = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_25 == null ? "Visit Date" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_25;
          try
          {
              System.Data.DataTable dt = GetData(VisitID, OrgID, PatternID, InvID);

              string strRefRange = dt.Rows[0]["ReferenceRange"].ToString().Trim();

              strRefRange = GetReferenceRange(strRefRange, VisitID, OrgID);

              if (strRefRange.Trim().ToString() == "")
              {
                  strRefRange = dt.Rows[0]["ReferenceRange"].ToString().Trim();
              }

              int intIndex = 0;
              Double StartRefVal = 0;
              Double EndRefVal = 0;

              try
              {
                  if (strRefRange.IndexOf("<=") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("<=");
                      StartRefVal = 0;
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 2));
                  }
                  else if (strRefRange.IndexOf("<") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("<");
                      StartRefVal = 0;
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                  }
                  else if (strRefRange.IndexOf(">=") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf(">=");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 2));
                      EndRefVal = dblLastValue;
                  }
                  else if (strRefRange.IndexOf(">") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf(">");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                      EndRefVal = dblLastValue;
                  }
                  else if (strRefRange.IndexOf("-") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("-");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(0, intIndex));
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                  }
                  else if (strRefRange.IndexOf("Negative") > -1 && strRefRange.IndexOf("<") > -1)
                  {
                      intIndex = strRefRange.IndexOf("<");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1, (strRefRange.IndexOf("<br>") - 1 - (intIndex + 1))));
                      StartRefVal = -1 * StartRefVal;
                      if (strRefRange.IndexOf("Positive") > -1)
                      {
                          intIndex = strRefRange.IndexOf(" > ");
                          EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 3));
                      }
                  }
                  //else if (strRefRange.IndexOf("Positive") > -1 && strRefRange.IndexOf(">") > -1)
                  //{

                  //}
              }
              catch (Exception ex)
              {
                  StartRefVal = 0;
                  EndRefVal = 0;
                  CLogger.LogError("Error in AppCode_RuntimeChart_makeChart()-1", ex);
              }

              m_chart.Height = Unit.Pixel(270);
              m_chart.Width = Unit.Pixel(500);
              m_chart.BorderlineColor = Color.Black;
              m_chart.BorderlineDashStyle = ChartDashStyle.Solid;
              m_chart.BorderlineWidth = 2;
              m_chart.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

              ChartArea mainArea = new ChartArea();
              mainArea.Name = "mainArea";
              mainArea.BackColor = Color.FromArgb(255, 255, 210);
              mainArea.BackGradientStyle = GradientStyle.TopBottom;
              mainArea.BorderDashStyle = ChartDashStyle.Solid;
              mainArea.AxisX.LabelStyle.Angle = 45;

              mainArea.AxisX.Title = strPV;
              mainArea.AxisY.Title = strValues;
              m_chart.ChartAreas.Add(mainArea);

              Legend mainLegend = new Legend();
              mainLegend.Name = "mainLegend";
              mainLegend.DockedToChartArea = "mainArea";
              mainLegend.Docking = Docking.Top;
              mainLegend.HeaderSeparator = LegendSeparatorStyle.Line;
              mainLegend.IsDockedInsideChartArea = false;
              m_chart.Legends.Add(mainLegend);

              Series sr = new Series();
              sr.ChartArea = "mainArea";
              sr.Legend = "mainLegend";
              sr.ChartType = SeriesChartType.Spline;
              sr.Name = strTN + dt.Rows[0]["TestName"].ToString();
              sr.MarkerStyle = MarkerStyle.Circle;
              sr.Color = Color.Blue;
              sr.IsVisibleInLegend = true;
              sr.IsValueShownAsLabel = true;

              m_chart.ChartAreas[0].AxisX.LabelStyle.Angle = -45;
              m_chart.ChartAreas["mainArea"].AxisX.LabelStyle.IsEndLabelVisible = false;

              for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
              {
                  Double x = (Double)i;
                  sr.Points.AddXY(dt.Rows[i]["PatientVisitID"], dt.Rows[i]["Value"]);
                  sr.LabelToolTip = "(" + dt.Rows[i]["PatientVisitID"].ToString() + "," + dt.Rows[i]["Value"].ToString() + ")";
              }

              m_chart.Series.Add(sr);

                  Series sr1 = new Series();
                  sr1.ChartType = SeriesChartType.Spline;
                  sr1.Color = Color.Green;
                  sr1.MarkerStyle = MarkerStyle.Circle;
                  sr1.Name = strRR + "[" + strRefRange + "]";

                  Series sr2 = new Series();
                  sr2.ChartType = SeriesChartType.Spline;
                  sr2.Color = Color.Green;
                  sr2.IsVisibleInLegend = false;
                  sr2.MarkerStyle = MarkerStyle.Circle;

              if (StartRefVal != 0 && EndRefVal != 0)
              {
                  for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
                  {
                      Double x = (Double)i;
                      sr1.Points.AddXY(dt.Rows[i]["PatientVisitID"], StartRefVal);
                  }
                  for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
                  {
                      Double x = (Double)i;
                      sr2.Points.AddXY(dt.Rows[i]["PatientVisitID"], EndRefVal);
                  }
              }
                  m_chart.Series.Add(sr1);
                  m_chart.Series.Add(sr2);
          }
          catch (Exception ex)
          {
              CLogger.LogError("Error in AppCode_RuntimeChart_makeChart()-2", ex);
          }
          return m_chart;
      }

      public System.Data.DataTable GetData(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
      {
          List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
          Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
          long returnCode = -1;
          returnCode = objInvBL.GetPatientInvestigationValuesHisiory(VisitID, OrgID, PatternID, InvID, out lstInvestigationValues);

          DataTable dtInvValues = new DataTable();
          DataColumn dcPatientVisitID = new DataColumn("PatientVisitID");
          DataColumn dcValue = new DataColumn("Value");
          DataColumn dcTestName = new DataColumn("TestName");
          DataColumn dcRefRange = new DataColumn("ReferenceRange");

          dtInvValues.Columns.Add(dcPatientVisitID);
          dtInvValues.Columns.Add(dcValue);
          dtInvValues.Columns.Add(dcTestName);
          dtInvValues.Columns.Add(dcRefRange);

          DataRow dr;
          int RowCount = 1;
          string LastVisitID = null;
          foreach (InvestigationValues InvVal in lstInvestigationValues)
          {
              dr = dtInvValues.NewRow();
              dr["PatientVisitID"] = RowCount; //InvVal.VisitID;
              RowCount = RowCount + 1;
              dr["Value"] = InvVal.Value;
              dr["TestName"] = InvVal.Name;
              dr["ReferenceRange"] = InvVal.ReferenceRange.ToString();
              //To get Last value
            
             
              LastVisitID = InvVal.VisitID;
             
              dblLastValue = Convert.ToDouble(InvVal.Value);
              //To get Last value
              dtInvValues.Rows.Add(dr);
          }

          
          //To store value 
          dr = dtInvValues.NewRow();
          dr["PatientVisitID"] = LastVisitID;
          dr["Value"] = dblLastValue;
          dr["TestName"] = "";
          dr["ReferenceRange"] = "";
          LastVisitID = LastVisitID + 1;
          dblLastValue = dblLastValue + 1;
          dtInvValues.Rows.Add(dr);
          //To store value

          return dtInvValues;
      }

      public string GetReferenceRange(string strXmlData, long VisitID, int OrgID)
      {
          List<PatientVisit> visitList = new List<PatientVisit>();
          Patient_BL patientBL = new Patient_BL(new BaseClass().ContextInfo);
          long returnCode = -1;
          string strGender = "";
          string strAge = "";
          string strGenderAge = "";
          string strResultRange = "";

          returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, "", out visitList);
          if (visitList.Count > 0)
          {
              if (visitList[0].Sex == "M")
              {
                  strGender = "Male";
              }
              else
              {
                  strGender = "Female";
              }
              strAge = visitList[0].PatientAge.ToString();
              strGenderAge = strGender + "~" + strAge.Substring(0, strAge.IndexOf(" ", 0)).Trim().ToString() + "~" + strAge.Substring(strAge.IndexOf(" ", 0)).Trim().ToString();
              strXmlData = strXmlData + "|" + strGenderAge;

              ValidateUserResult(strXmlData, out strResultRange);

          }
          return strResultRange;
      }

      public void ValidateUserResult(string xmlData, out string strRefRangeResult)
      {
          strRefRangeResult = "";

          string[] CatagoryAgeMain = xmlData.Split('|');

          Array userarr = CatagoryAgeMain[1].Split('~');
          string pGender = userarr.GetValue(0).ToString();
          string pAge = userarr.GetValue(1).ToString();
          string pAgetype = userarr.GetValue(2).ToString();
          decimal rangeValue=0;

          int pAgeint = Convert.ToInt32(userarr.GetValue(1));

          if (pAgetype == "Year(s)")
          {
              pAgetype = "Years";
          }
          else if (pAgetype == "Week(s)")
          {
              pAgetype = "Weeks";
          }
          else if (pAgetype == "Month(s)")
          {
              pAgetype = "Months";
          }
          else if (pAgetype == "Day(s)")
          {
              pAgetype = "Days";
          }
          long patientAgeInDays = ConvertToDays(Convert.ToInt32(pAge), pAgetype);

          if (TryParseXml(CatagoryAgeMain[0]))
          {
              #region CommentedForLaterUse
              //    XElement xe = XElement.Parse(CatagoryAgeMain[0]);

          //    var ageRange = from age in xe.Elements("referencerange").Elements("property")
          //                   where (string)age.Attribute("type") == "age" && (string)age.Attribute("value") == pGender //&& (string)age.Attribute("mode") == pAgetype
          //                   select age;

          //    var ageRangeBoth = from age in xe.Elements("referencerange").Elements("property")
          //                       where (string)age.Attribute("type") == "age" && (string)age.Attribute("value") == "Both" //&& (string)age.Attribute("mode") == pAgetype
          //                       select age;

          //    var commonRange = from common in xe.Elements("referencerange").Elements("property")
          //                      where (string)common.Attribute("type") == "common" && (string)common.Attribute("value") == pGender
          //                      select common;

          //    var otherRange = from other in xe.Elements("referencerange").Elements("property")
          //                     where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == pGender
          //                     select other;

          //    var commonRangeBoth = from common in xe.Elements("referencerange").Elements("property")
          //                          where (string)common.Attribute("type") == "common" && (string)common.Attribute("value") == "Both"
          //                          select common;

          //    var otherRangeBoth = from other in xe.Elements("referencerange").Elements("property")
          //                         where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == "Both"
          //                         select other;

          //    if (ageRange.Count() > 0)
          //    {
          //        //textColor = "Red";

          //        foreach (var lst in ageRange)
          //        {
          //            if (lst.Element("lst") != null)
          //            {
          //                if (patientAgeInDays < ConvertToDays(Convert.ToInt32(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("lst").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }

          //            if (lst.Element("lsq") != null)
          //            {
          //                if (patientAgeInDays <= ConvertToDays(Convert.ToInt32(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("lsq").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("eql") != null)
          //            {
          //                if (patientAgeInDays == ConvertToDays(Convert.ToInt32(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("eql").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("grt") != null)
          //            {
          //                if (patientAgeInDays > ConvertToDays(Convert.ToInt32(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("grt").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("grq") != null)
          //            {
          //                if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("grq").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("btw") != null)
          //            {
          //                string[] between = lst.Element("btw").Value.Split('-');
          //                if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToInt32(between[1]), lst.Element("btw").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("btw").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //        }
          //    }
          //    if (ageRangeBoth.Count() > 0)
          //    {
          //        //textColor = "Red";
          //        foreach (var lst in ageRangeBoth)
          //        {
          //            if (lst.Element("lst") != null)
          //            {
          //                if (patientAgeInDays < ConvertToDays(Convert.ToInt32(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("lst").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("lsq") != null)
          //            {
          //                if (patientAgeInDays <= ConvertToDays(Convert.ToInt32(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("lsq").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                    }
          //                }
          //            }
          //            if (lst.Element("eql") != null)
          //            {
          //                if (patientAgeInDays == ConvertToDays(Convert.ToInt32(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
          //                {
          //                    switch (ConvertStringOptr(lst.Element("eql").FirstAttribute.Value))
          //                    {
          //                        case "<":
          //                            if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "<=":
          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=":
          //                            if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case "=>":
          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case ">":
          //                            if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }
          //                            break;
          //                        case " ":
          //                            string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;


          //                    }
          //                }




          //            }

          //            if (lst.Element("grt") != null)
          //            {


          //                if (patientAgeInDays > ConvertToDays(Convert.ToInt32(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
          //                {

          //                    switch (ConvertStringOptr(lst.Element("grt").FirstAttribute.Value))
          //                    {
          //                        case "<":

          //                            if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;

          //                        case "<=":

          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=":

          //                            if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=>":

          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case ">":

          //                            if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case " ":

          //                            string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;


          //                    }
          //                }




          //            }


          //            if (lst.Element("grq") != null)
          //            {



          //                if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
          //                {

          //                    switch (ConvertStringOptr(lst.Element("grq").FirstAttribute.Value))
          //                    {
          //                        case "<":

          //                            if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;

          //                        case "<=":

          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=":

          //                            if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=>":

          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case ">":

          //                            if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case " ":

          //                            string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;


          //                    }
          //                }




          //            }

          //            if (lst.Element("btw") != null)
          //            {

          //                string[] between = lst.Element("btw").Value.Split('-');

          //                if (patientAgeInDays >= ConvertToDays(Convert.ToInt32(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToInt32(between[1]), lst.Element("btw").Attribute("agetype").Value))
          //                {


          //                    switch (ConvertStringOptr(lst.Element("btw").FirstAttribute.Value))
          //                    {
          //                        case "<":

          //                            if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;

          //                        case "<=":

          //                            if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=":

          //                            if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case "=>":

          //                            if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case ">":

          //                            if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;
          //                        case " ":

          //                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
          //                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
          //                            {
          //                                ////textColor = "white";
          //                            }
          //                            else
          //                            {
          //                                ////textColor = "Yellow";
          //                            }

          //                            break;


          //                    }
          //                }



          //            }

          //        }



          //    }



          //    if (commonRange.Count() > 0)
          //    {


          //        foreach (var lst in commonRange)
          //        {


          //            if (lst.Element("lst") != null)
          //            {
          //                if (rangeValue < Convert.ToDecimal(lst.Element("lst").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }


          //            }

          //            if (lst.Element("lsq") != null)
          //            {

          //                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }

          //            }

          //            if (lst.Element("eql") != null)
          //            {
          //                if (rangeValue == Convert.ToDecimal(lst.Element("eql").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("grt") != null)
          //            {
          //                if (rangeValue > Convert.ToDecimal(lst.Element("grt").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }


          //            if (lst.Element("grq") != null)
          //            {
          //                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("btw") != null)
          //            {
          //                string[] between = lst.Element("btw").Value.Split('-');

          //                strRefRangeResult = lst.Element("btw").Value.ToString();

          //                ////if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                ////{
          //                ////    ////textColor = "white";
          //                ////}
          //                ////else
          //                ////{
          //                ////    ////textColor = "Yellow";
          //                ////}
          //            }

          //        }


          //    }

          //    if (commonRangeBoth.Count() > 0)
          //    {


          //        foreach (var lst in commonRangeBoth)
          //        {


          //            if (lst.Element("lst") != null)
          //            {
          //                if (rangeValue < Convert.ToDecimal(lst.Element("lst").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }


          //            }

          //            if (lst.Element("lsq") != null)
          //            {

          //                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }

          //            }

          //            if (lst.Element("eql") != null)
          //            {
          //                if (rangeValue == Convert.ToDecimal(lst.Element("eql").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("grt") != null)
          //            {
          //                if (rangeValue > Convert.ToDecimal(lst.Element("grt").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }


          //            if (lst.Element("grq") != null)
          //            {
          //                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("btw") != null)
          //            {
          //                string[] between = lst.Element("btw").Value.Split('-');

          //                strRefRangeResult = lst.Element("btw").Value.ToString();

          //                ////if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                ////{
          //                ////    ////textColor = "white";
          //                ////}
          //                ////else
          //                ////{
          //                ////    ////textColor = "Yellow";
          //                ////}
          //            }

          //        }


          //    }


          //    if (otherRange.Count() > 0)
          //    {
          //        ////textColor = "Blue";


          //        foreach (var lst in otherRange)
          //        {


          //            if (lst.Element("lst") != null)
          //            {

          //                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }



          //            }

          //            if (lst.Element("lsq") != null)
          //            {

          //                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("eql") != null)
          //            {
          //                if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("grt") != null)
          //            {
          //                if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }


          //            if (lst.Element("grq") != null)
          //            {
          //                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("btw") != null)
          //            {

          //                string[] between = lst.Element("btw").LastAttribute.Value.Split('-');


          //                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //        }

          //    }

          //    if (otherRangeBoth.Count() > 0)
          //    {
          //        ////textColor = "Blue";
          //        foreach (var lst in otherRangeBoth)
          //        {
          //            if (lst.Element("lst") != null)
          //            {
          //                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("lsq") != null)
          //            {
          //                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("eql") != null)
          //            {
          //                if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("grt") != null)
          //            {
          //                if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }


          //            if (lst.Element("grq") != null)
          //            {
          //                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }

          //            if (lst.Element("btw") != null)
          //            {
          //                string[] between = lst.Element("btw").LastAttribute.Value.Split('-');
          //                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
          //                {
          //                    ////textColor = "white";
          //                }
          //                else
          //                {
          //                    ////textColor = "Yellow";
          //                }
          //            }
          //        }
              //    }
              #endregion
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

      public Chart CreateChart(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
      {
          var strPV = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_21 == null ? "Patient Visit(s)" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_21;
          var strValues = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_22 == null ? "Value(s)" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_22;
          var strTN = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_23 == null ? "Test Name: " : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_23;
          var strRR = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_24 == null ? "Reference Range: " : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_24;
          var strVD = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_25 == null ? "Visit Date" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_25;
          var strInv = Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_26 == null ? "Investigation" : Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_26;
          Chart m_chart = new Chart();
          try
          {
              Double dblLastValue = 0;

              RuntimeChart runChart = new RuntimeChart();
              System.Data.DataTable dt = this.GetPatientDeltaValues(VisitID, OrgID, PatternID, InvID);

              string strRefRange = dt.Rows[0]["ReferenceRange"].ToString().Trim();

              strRefRange = runChart.GetReferenceRange(strRefRange, VisitID, OrgID);

              if (strRefRange.Trim().ToString() == "")
              {
                  strRefRange = dt.Rows[0]["ReferenceRange"].ToString().Trim();
              }

              int intIndex = 0;
              Double StartRefVal = 0;
              Double EndRefVal = 0;

              try
              {
                  if (strRefRange.IndexOf("<=") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("<=");
                      StartRefVal = 0;
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 2));
                  }
                  else if (strRefRange.IndexOf("<") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("<");
                      StartRefVal = 0;
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                  }
                  else if (strRefRange.IndexOf(">=") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf(">=");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 2));
                      EndRefVal = dblLastValue;
                  }
                  else if (strRefRange.IndexOf(">") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf(">");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                      EndRefVal = dblLastValue;
                  }
                  else if (strRefRange.IndexOf("-") > -1 && !(strRefRange.IndexOf("Negative") > -1 || strRefRange.IndexOf("Positive") > -1))
                  {
                      intIndex = strRefRange.IndexOf("-");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(0, intIndex));
                      EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1));
                  }
                  else if (strRefRange.IndexOf("Negative") > -1 && strRefRange.IndexOf("<") > -1)
                  {
                      intIndex = strRefRange.IndexOf("<");
                      StartRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 1, (strRefRange.IndexOf("<br>") - 1 - (intIndex + 1))));
                      StartRefVal = -1 * StartRefVal;
                      if (strRefRange.IndexOf("Positive") > -1)
                      {
                          intIndex = strRefRange.IndexOf(" > ");
                          EndRefVal = Convert.ToDouble(strRefRange.Substring(intIndex + 3));
                      }
                  }
              }
              catch (Exception ex)
              {
                  StartRefVal = 0;
                  EndRefVal = 0;
                  CLogger.LogError("Error in AppCode_RuntimeChart_CreateChart()-1", ex);
              }

              m_chart.Height = Unit.Pixel(200);
              m_chart.Width = Unit.Pixel(550);

              m_chart.BackGradientStyle = GradientStyle.TopBottom;
              m_chart.Palette = ChartColorPalette.BrightPastel;
              m_chart.BackColor = Color.White;
              m_chart.BackSecondaryColor = Color.White;
              m_chart.BorderlineDashStyle = ChartDashStyle.Solid;
              m_chart.BorderlineWidth = 1;
              m_chart.BorderlineColor = Color.FromArgb(26, 59, 105);

              Title chartTitle = new Title();
              chartTitle.ForeColor = Color.FromArgb(26, 59, 105);
              chartTitle.Alignment = ContentAlignment.TopCenter;
              chartTitle.Font = new Font("Trebuchet MS", 9, FontStyle.Bold);
              chartTitle.Text = dt.Rows[0]["TestName"].ToString();

              m_chart.Titles.Add(chartTitle);

              ChartArea mainArea = new ChartArea();
              mainArea.Name = "mainArea";
              mainArea.BorderColor = Color.FromArgb(64, 64, 64, 64);
              mainArea.BackSecondaryColor = Color.White;
              mainArea.BackColor = Color.White;
              mainArea.ShadowColor = Color.Transparent;
              mainArea.BackGradientStyle = GradientStyle.TopBottom;
              mainArea.AxisX2.Enabled = AxisEnabled.False;

              Axis axisX = new Axis();
              axisX.IsLabelAutoFit = false;
              axisX.MajorGrid.Enabled = false;
              axisX.MinorGrid.Enabled = false;
              mainArea.AxisX = axisX;

              Axis axisY = new Axis();
              axisY.IsLabelAutoFit = false;
              axisY.MajorGrid.Enabled = false;
              axisY.MinorGrid.Enabled = false;
              mainArea.AxisY = axisY;

              Axis axisY2 = new Axis();
              axisY2.LineColor = Color.White;
              axisY2.IsLabelAutoFit = false;
              axisY2.MajorGrid.Enabled = false;
              axisY2.MinorGrid.Enabled = false;
              axisY2.Enabled = AxisEnabled.False;
              axisY2.MinorTickMark.Enabled = false;
              axisY2.MajorTickMark.Enabled = false;
              mainArea.AxisY2 = axisY2;

              mainArea.AxisX.Title = strVD;
              mainArea.AxisY.Title = strValues;
              m_chart.ChartAreas.Add(mainArea);

              Legend mainLegend = new Legend();
              mainLegend.Name = "mainLegend";
              mainLegend.IsTextAutoFit = true;
              mainLegend.DockedToChartArea = "mainArea";
              mainLegend.Docking = Docking.Top;
              mainLegend.HeaderSeparator = LegendSeparatorStyle.Line;
              mainLegend.IsDockedInsideChartArea = false;
              m_chart.Legends.Add(mainLegend);

              LegendItem legendItem = new LegendItem();
              legendItem.Name = strRR +"[" + strRefRange + "]";
              legendItem.ImageStyle = LegendImageStyle.Rectangle;
              legendItem.Color = Color.FromArgb(50, Color.Green);
              legendItem.MarkerStyle = MarkerStyle.Circle;
              m_chart.Legends["mainLegend"].CustomItems.Add(legendItem);

              Series sr = new Series();
              sr.ChartArea = "mainArea";
              sr.Legend = "mainLegend";
              sr.MarkerSize = 5;
              sr.ChartType = SeriesChartType.Spline;
              sr.BorderColor = Color.FromArgb(180, 26, 59, 105);
              sr.BorderWidth = 1;
              sr.Name = strInv;
              sr.MarkerStyle = MarkerStyle.Circle;
              sr.Color = Color.Blue;
              sr.IsVisibleInLegend = true;
              sr.IsValueShownAsLabel = true;

              for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
              {
                  Double x = (Double)i;
                  sr.Points.AddXY(dt.Rows[i]["VisitDate"], dt.Rows[i]["Value"]);
                  sr.LabelToolTip = "(" + dt.Rows[i]["VisitDate"].ToString() + "," + dt.Rows[i]["Value"].ToString() + ")";
              }

              m_chart.Series.Add(sr);

              Series sr1 = new Series();
              sr1.ChartType = SeriesChartType.Spline;
              sr1.Color = Color.FromArgb(0, Color.Green);
              sr1.ChartArea = "mainArea";
              sr1.MarkerStyle = MarkerStyle.None;
              sr1.Name = strRR +"[" + strRefRange + "]";
              sr1.IsVisibleInLegend = false;

              Series sr2 = new Series();
              sr2.ChartArea = "mainArea";
              sr2.ChartType = SeriesChartType.Spline;
              sr2.Color = Color.FromArgb(0, Color.Green);
              sr2.IsVisibleInLegend = false;
              sr2.MarkerStyle = MarkerStyle.None;

              if (StartRefVal != 0 && EndRefVal != 0)
              {
                  for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
                  {
                      Double x = (Double)i;
                      sr1.Points.AddXY(dt.Rows[i]["VisitDate"], StartRefVal);
                  }
                  for (Int32 i = 0; i < dt.Rows.Count - 1; i++)
                  {
                      Double x = (Double)i;
                      sr2.Points.AddXY(dt.Rows[i]["VisitDate"], EndRefVal);
                  }
              }
              m_chart.Series.Add(sr1);
              m_chart.Series.Add(sr2);

              //double high = EndRefVal - StartRefVal;
              //CustomLabel element = m_chart.ChartAreas["mainArea"].AxisY2.CustomLabels.Add(StartRefVal - 5, StartRefVal + 10, StartRefVal.ToString());
              //element = m_chart.ChartAreas["mainArea"].AxisY2.CustomLabels.Add(high, high + 15, EndRefVal.ToString());

              StripLine strip = new StripLine();
              strip.IntervalOffset = StartRefVal;
              strip.StripWidth = EndRefVal - StartRefVal;
              strip.BackColor = Color.FromArgb(30, Color.Green);

              StripLine stripLow = new StripLine();
              stripLow.IntervalOffset = StartRefVal - 1;
              stripLow.StripWidth = 2;
              stripLow.BackColor = Color.FromArgb(150, Color.Green);

              StripLine stripHigh = new StripLine();
              stripHigh.IntervalOffset = EndRefVal - 1;
              stripHigh.StripWidth = 3;
              stripHigh.BackColor = Color.FromArgb(150, Color.Green);

              m_chart.ChartAreas["mainArea"].AxisY.StripLines.Add(strip);
              m_chart.ChartAreas["mainArea"].AxisY.StripLines.Add(stripLow);
              m_chart.ChartAreas["mainArea"].AxisY.StripLines.Add(stripHigh);
          }
          catch (Exception ex)
          {
              CLogger.LogError("Error in AppCode_RuntimeChart_createChart()-2", ex);
          }
          return m_chart;
      }

      public DataTable GetPatientDeltaValues(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
      {
          long returnCode = -1;
          DataTable dtInvValues = new DataTable();
          DateTime lastVisitDate = new DateTime();
          double lastValues = new double();
          try
          {
              List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
              Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
              returnCode = objInvBL.GetPatientDeltaValues(VisitID, OrgID, PatternID, InvID, out lstInvestigationValues);

              DataColumn dcPatientVisitID = new DataColumn("VisitDate");
              DataColumn dcValue = new DataColumn("Value");
              DataColumn dcTestName = new DataColumn("TestName");
              DataColumn dcRefRange = new DataColumn("ReferenceRange");

              dtInvValues.Columns.Add("VisitDate", typeof(System.String));
              dtInvValues.Columns.Add("Value", typeof(System.String));
              dtInvValues.Columns.Add("TestName", typeof(System.String));
              dtInvValues.Columns.Add("ReferenceRange", typeof(System.String));

              DataRow dr;
              foreach (InvestigationValues oInvVal in lstInvestigationValues)
              {
                  dr = dtInvValues.NewRow();
                  dr["VisitDate"] = oInvVal.CreatedAt.ToString("dd/MM/yyyy");
                  dr["Value"] = oInvVal.Value;
                  dr["TestName"] = oInvVal.InvestigationName;
                  dr["ReferenceRange"] = oInvVal.ReferenceRange;
                  ////To get Last value
                  lastVisitDate = oInvVal.CreatedAt.AddDays(1);
                  lastValues = Convert.ToDouble(oInvVal.Value) + 1;
                  ////To get Last value
                  dtInvValues.Rows.Add(dr);
              }

              ////To store value 
              dr = dtInvValues.NewRow();
              dr["VisitDate"] = lastVisitDate.ToString("dd/MM/yyyy");
              dr["Value"] = lastValues;
              dr["TestName"] = "";
              dr["ReferenceRange"] = "";
              dtInvValues.Rows.Add(dr);
              ////To store value
          }
          catch (Exception ex)
          {
              CLogger.LogError("Error while getting patient delta values", ex);
              throw ex;
          }
          return dtInvValues;
      }

   }
