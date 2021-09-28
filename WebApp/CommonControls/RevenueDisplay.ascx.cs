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


public partial class CommonControls_RevenueDisplay : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void ChartDraw(List<ReceivedAmount> lstINDAmtReceivedDetails, List<ReceivedAmount> lstINDIPAmtReceivedDetails)
    {
        lblType.Text = sControlType;
        if (lstINDAmtReceivedDetails.Count > 0)
        {
            double[] tempyValues = lstINDAmtReceivedDetails.Count == 0 ? new double[0] : new double[lstINDAmtReceivedDetails.Count ];
            string[] tempxValues = lstINDAmtReceivedDetails.Count == 0 ? new string[0] : new string[lstINDAmtReceivedDetails.Count ];


            int iCount = 0;

            for (int i = 0; i < lstINDAmtReceivedDetails.Count; i++)
            {
                    tempyValues[i] = Convert.ToDouble(lstINDAmtReceivedDetails[i].Amount);
                    tempxValues[i] = lstINDAmtReceivedDetails[i].Descriptions;

                if (lstINDAmtReceivedDetails[i].Descriptions == "Outstanding Amount")
                {
                    iCount = i;
                }
            }
            double[] yValues = tempyValues;
            string[] xValues = tempxValues;
            Chart1.Series[0].Points.DataBindXY(xValues, yValues);
            Chart1.Series["Series1"].ChartType = SeriesChartType.Doughnut;
            Chart1.Series["Series1"]["PieLabelStyle"] = "Inside";
            Chart1.Series["Series1"].Points[iCount]["Exploded"] = "true";
            Chart1.Series["Series1"].IsValueShownAsLabel = true;
            Chart1.Series["Series1"].XAxisType = AxisType.Primary;

            //Chart2.Height = 250;
            Chart2.Attributes.Add("vertical-align", "top");

            Chart1.Legends["legends1"].LegendStyle = LegendStyle.Column;
            Chart1.Legends["legends1"].Docking = Docking.Bottom;
            Chart1.Legends["legends1"].Alignment = StringAlignment.Near;

            Chart1.Legends["legends1"].HeaderSeparator = LegendSeparatorStyle.Line;
            Chart1.Legends["legends1"].HeaderSeparatorColor = Color.Gray;
            Chart1.Legends["legends1"].Title = "OP Collection";
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

            // Add Color column
            LegendCellColumn firstColumn = new LegendCellColumn();
            firstColumn.ColumnType = LegendCellColumnType.SeriesSymbol;
            firstColumn.HeaderText = "Color";
            firstColumn.HeaderBackColor = Color.WhiteSmoke;
            firstColumn.Alignment = ContentAlignment.TopLeft;
            Chart1.Legends["legends1"].CellColumns.Add(firstColumn);

            // Add Legend Text column
            LegendCellColumn secondColumn = new LegendCellColumn();
            secondColumn.ColumnType = LegendCellColumnType.Text;
            secondColumn.HeaderText = "Name";
            secondColumn.Alignment = ContentAlignment.TopLeft;
            secondColumn.Text = "#LEGENDTEXT";
            secondColumn.HeaderBackColor = Color.WhiteSmoke;
            Chart1.Legends["legends1"].CellColumns.Add(secondColumn);

            // Add Value cell column
            LegendCellColumn avgColumn = new LegendCellColumn();
            avgColumn.Text = "#VAL{N2}";
            avgColumn.HeaderText = "Amount";
            avgColumn.Name = "AmountColumn";
            avgColumn.Alignment = ContentAlignment.TopRight;
            avgColumn.HeaderBackColor = Color.WhiteSmoke;
            Chart1.Legends["legends1"].CellColumns.Add(avgColumn);
            
            Chart1.Legends[0].Enabled = true;

    
        }
        else
        {
            Chart1.Visible = false;
        }
        //IP Section
        if (lstINDIPAmtReceivedDetails.Count > 0)
        {
            double[] tempyValues = lstINDIPAmtReceivedDetails.Count == 0 ? new double[0] : new double[lstINDIPAmtReceivedDetails.Count];
            string[] tempxValues = lstINDIPAmtReceivedDetails.Count == 0 ? new string[0] : new string[lstINDIPAmtReceivedDetails.Count];

            for (int i = 0; i < lstINDIPAmtReceivedDetails.Count; i++)
            {
                if (lstINDIPAmtReceivedDetails[i].Descriptions != "Total Collection")
                {
                    tempyValues[i] = Convert.ToDouble(lstINDIPAmtReceivedDetails[i].Amount);
                    tempxValues[i] = lstINDIPAmtReceivedDetails[i].Descriptions;
                }
            }
            double[] yValues = tempyValues;
            string[] xValues = tempxValues;
            Chart2.Series[0].Points.DataBindXY(xValues, yValues);
            Chart2.Series["Series2"].ChartType = SeriesChartType.Pie;
            Chart2.Series["Series2"]["PieLabelStyle"] = "Inside";
            //Chart2.Series["Series2"]["PyramidLabelStyle"] = "Inside";
            Chart2.Series["Series2"].IsValueShownAsLabel = true;

            Chart2.Legends["legends2"].LegendStyle = LegendStyle.Column;
            Chart2.Legends["legends2"].Docking = Docking.Bottom;
            Chart2.Legends["legends2"].Alignment = StringAlignment.Near;

            Chart2.Legends["legends2"].HeaderSeparator = LegendSeparatorStyle.Line;
            Chart2.Legends["legends2"].HeaderSeparatorColor = Color.Gray;
            Chart2.Legends["legends2"].Title = "IP Collection";
            Chart2.ChartAreas["ChartArea2"].Area3DStyle.Enable3D = true;

            // Add Color column
            LegendCellColumn firstColumn = new LegendCellColumn();
            firstColumn.ColumnType = LegendCellColumnType.SeriesSymbol;
            firstColumn.HeaderText = "Color";
            firstColumn.Alignment = ContentAlignment.TopLeft;
            firstColumn.HeaderBackColor = Color.WhiteSmoke;
            Chart2.Legends["legends2"].CellColumns.Add(firstColumn);

            // Add Legend Text column
            LegendCellColumn secondColumn = new LegendCellColumn();
            secondColumn.ColumnType = LegendCellColumnType.Text;
            secondColumn.HeaderText = "Name";
            secondColumn.Text = "#LEGENDTEXT";
            secondColumn.HeaderBackColor = Color.WhiteSmoke;
            secondColumn.Alignment = ContentAlignment.TopLeft;
            Chart2.Legends["legends2"].CellColumns.Add(secondColumn);

            // Add AVG cell column
            LegendCellColumn avgColumn = new LegendCellColumn();
            avgColumn.Text = "#VAL{N2}";
            avgColumn.HeaderText = "Amount";
            avgColumn.Name = "AmountColumn";
            avgColumn.HeaderBackColor = Color.WhiteSmoke;
            avgColumn.Alignment = ContentAlignment.TopRight;
            Chart2.Legends["legends2"].CellColumns.Add(avgColumn);

            Chart2.Legends[0].Enabled = true;
        }
        else
        {
            Chart2.Visible = false;
        }
    }

    private string _sControlType = "";
    public string sControlType
    {
        get { return _sControlType; }
        set { _sControlType = value; }
    }
}
