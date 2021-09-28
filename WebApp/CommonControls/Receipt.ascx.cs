using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommonControls_Receipt : BaseControl
{
    decimal amount = 0;
    string AmtInWords = string.Empty;
    string name = string.Empty;
    string number = string.Empty;
    string complaint = string.Empty;
    ReceiptMode mode;
    // string dispText = "Received with thanks from {Name}, (Number {Number}), a sum of {AmtWords}[{AmtNo}] towards {complaint} treatment";
    string dispText = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_01 == null ? "Received with thanks from {Name}, (Number {Number}), a sum of {AmtWords}[{AmtNo}] towards {complaint} treatment" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_01;
    decimal amountReceived = 0;
    long patientVisitID;

    protected void Page_Load(object sender, EventArgs e)
    {

        string strName = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_02 == null ? "{Name}" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_02;
        string strAmtwork = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_03 == null ? "{AmtWords}" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_03;
        string strAmtno = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_04 == null ? "{AmtNo}" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_04;
        string strcomplain = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_05 == null ? "{complaint}" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_05;
        string strNum = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_06 == null ? "{Number}" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_06;


        switch (mode)
        {
            case ReceiptMode.PrintMode:
                pnlPrint.Visible = true;
                AmtInWords = GetWords(amount);
                //dispText = dispText.Replace("{Name}", name);
                //dispText = dispText.Replace("{AmtWords}", AmtInWords);
                //dispText = dispText.Replace("{AmtNo}", amount.ToString());
                //dispText = dispText.Replace("{complaint}", complaint);
                //dispText = dispText.Replace("{Number}", Number);
                dispText = dispText.Replace(strName, name);
                dispText = dispText.Replace(strAmtwork, AmtInWords);
                dispText = dispText.Replace(strAmtno, amount.ToString());
                dispText = dispText.Replace(strcomplain, complaint);
                dispText = dispText.Replace(strNum, Number);
                tCont.Text = dispText;
                break;
            
        }
    }

    public string Number
    {
        set { number = value; }
        get { return number; }
    }

    public long VisitID
    {
        set { patientVisitID = value; }
        get { return patientVisitID; }
    }

    public string Name
    {
        set { name = value; }
        get { return name; }
    }
    public decimal Amount
    {
        set { amount = value; }
        get { return amount; }
    }
    public string Complaint
    {
        set { complaint = value; }
        get { return complaint; }
    }
    public ReceiptMode Mode
    {
        set { mode = value;}
        get { return mode; }
    }

    public decimal AmountReceived
    {
        set { amountReceived = value; }
        get { return amountReceived; }
    }
    private string GetWords(decimal amt)
    {
        #region Added by GowthamRaj Localization
        string strPaiseoly = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_07 == null ? "paise only" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_07;
        string strCrore = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_08 == null ? "Crore" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_08;
        string strLakh = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_09 == null ? "Lakh" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_09;
        string strThousand = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_10 == null ? "Thousand" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_10;
        string strHundred = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_11 == null ? "Hundred" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_11;
        string strRs = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_12 == null ? "rupees and" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_12;
        string strAnd = Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_13 == null ? "and" : Resources.CommonControls_ClientDisplay.CommonControls_Receipt_ascx_13;


        #endregion
        string amtinwords = string.Empty;
        string strpaise = string.Empty;
        int tenthpaise = 0;
        int unitpaise = 0;
        decimal paise = 0;
        int rupees = 0;
        int paiseint = 0;
        string AmtInWords = string.Empty;
        string[] words1 = {"" ,"One ", "Two ", "Three ", "Four ",
"Five " ,"Six ", "Seven ", "Eight ", "Nine ","Ten ", "Eleven ", "Twelve ", "Thirteen ", "Fourteen ",
"Fifteen ","Sixteen ","Seventeen ","Eighteen ", "Nineteen "};
        string[] words2 = {"","","Twenty ", "Thirty ", "Forty ", "Fifty ", "Sixty ",
"Seventy ","Eighty ", "Ninety "};
        rupees = Convert.ToInt32(decimal.Truncate(amt));
        paise = decimal.Subtract(amt, rupees);
        paiseint = Convert.ToInt32(paise * 100);
        unitpaise = paiseint % 10;
        tenthpaise = (paiseint - unitpaise) / 10;

        if (tenthpaise > 1)
        {
            strpaise = words2[tenthpaise];
            strpaise += words1[unitpaise];
            //strpaise = strpaise + " paise only";
            strpaise = strpaise + " " + strPaiseoly;
        }
        else
        {
            strpaise = words1[tenthpaise];
            strpaise = strpaise + " " + strPaiseoly;
        }

        while (rupees > 99)
        {
            int remainder = 0;
            string suffix = string.Empty;
            if (rupees >= 10000000)
            {
                remainder = rupees % 10000000;
                rupees = rupees - remainder;
                rupees = rupees / 10000000;
                //amtinwords = amtinwords + words1[rupees] + "Crore ";
                amtinwords = amtinwords + words1[rupees] + strCrore + " ";
                rupees = remainder;
            }
            if (rupees >= 100000)
            {
                remainder = rupees % 100000;
                rupees = rupees - remainder;
                rupees = rupees / 100000;
                //amtinwords = amtinwords + words1[rupees] + "Lakh ";
                amtinwords = amtinwords + words1[rupees] + strLakh + " ";
                rupees = remainder;
            }
            if (rupees >= 1000)
            {
                remainder = rupees % 1000;
                rupees = rupees - remainder;
                rupees = rupees / 1000;
                amtinwords = amtinwords + words1[rupees] + strThousand + " ";
                rupees = remainder;
            }
            if (rupees >= 100)
            {
                remainder = rupees % 100;
                rupees = rupees - remainder;
                rupees = rupees / 100;
                //amtinwords = amtinwords + words1[rupees] + "Hundred ";
                amtinwords = amtinwords + words1[rupees] + strHundred + " ";
                rupees = remainder;
            }
        }
        amtinwords += strAnd + " ";
        if (rupees > 19)
        {
            amtinwords = amtinwords + words1[rupees % 10];
            rupees = rupees - (rupees % 10);
            rupees = rupees / 10;
            amtinwords = amtinwords + words2[rupees];
        }
        else
            amtinwords = amtinwords + words1[rupees];
        amtinwords = amtinwords + strRs + " " + strpaise;
        return amtinwords;

    }
}
