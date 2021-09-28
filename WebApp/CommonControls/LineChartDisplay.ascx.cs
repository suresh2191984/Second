using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.DataVisualization.Charting.Utilities;
using System.Drawing;


public partial class CommonControls_LineChartDisplay : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void ChartDraw(List<ReceivedAmount> lstINDAmtReceivedDetails)
    {
        lblType.Text = sControlType;


        if (lstINDAmtReceivedDetails.Count > 0)
        {


            double[] tempyValues = lstINDAmtReceivedDetails.Count == 0 ? new double[0] : new double[lstINDAmtReceivedDetails.Count];
            string[] tempxValues = lstINDAmtReceivedDetails.Count == 0 ? new string[0] : new string[lstINDAmtReceivedDetails.Count];

            for (int i = 0; i < lstINDAmtReceivedDetails.Count; i++)
            {
                tempyValues[i] = Convert.ToDouble(lstINDAmtReceivedDetails[i].Amount);
                tempxValues[i] = lstINDAmtReceivedDetails[i].Descriptions;
            }
            double[] yValues = tempyValues;
            string[] xValues = tempxValues;
            Chart1.Series[0].Points.DataBindXY(xValues, yValues);
            Chart1.Series["Series1"].ChartType = SeriesChartType.Column;
            Chart1.Series["Series1"]["PointWidth"] = "0.7";
            Chart1.Series["Series1"].IsValueShownAsLabel = true;
            Chart1.Series["Series1"]["BarLabelStyle"] = "Center";
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
            //Chart1.Series["Series1"]["DrawingStyle"] = "Cylinder";
            Chart1.ChartAreas["ChartArea1"].AxisX.LabelAutoFitStyle = 
                LabelAutoFitStyles.DecreaseFont | LabelAutoFitStyles.IncreaseFont | LabelAutoFitStyles.WordWrap;
            //Chart1.Series["Series1"].Color = Color.YellowGreen;
            //Chart1.Series["Series1"].BackSecondaryColor = Color.SteelBlue;

           
            Chart1.Series["Series2"].XAxisType = AxisType.Primary;

            Chart1.Series[1].Points.DataBindXY(xValues, yValues);
            Chart1.Series["Series2"].ChartType = SeriesChartType.Spline;
            Chart1.Series["Series2"].Color = Color.Red;
            Chart1.Series["Series2"].MarkerBorderWidth = 2;
            Chart1.Series["Series2"].IsValueShownAsLabel = false;
            Chart1.Series["Series2"]["ShowMarkerLines"] = "False";

            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
            Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;

            Chart1.ChartAreas["ChartArea1"].BackColor = Color.Transparent;
            Chart1.ChartAreas["ChartArea1"].BackHatchStyle = ChartHatchStyle.OutlinedDiamond;
            Chart1.ChartAreas["ChartArea1"].BackGradientStyle = GradientStyle.TopBottom;
            Chart1.ChartAreas["ChartArea1"].BorderColor = Color.Black;
            Chart1.ChartAreas["ChartArea1"].BorderDashStyle = ChartDashStyle.DashDotDot;
            Chart1.ChartAreas["ChartArea1"].BorderWidth = 1;

            Chart1.Legends[0].Enabled = false;
        }
        else
        {
            Chart1.Visible = false;
        }

    }

    private string _sControlType = "";
    public string sControlType
    {
        get { return _sControlType; }
        set { _sControlType = value; }
    }
    
}
