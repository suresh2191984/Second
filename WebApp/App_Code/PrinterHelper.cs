using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;


/// <summary>
/// kutti
/// 11/07/2011
/// </summary>
public class PrinterHelper
{
    public PrinterHelper()
    {


    }

    public static void PrintStartAndEnd(ref StringBuilder objPrint, string pType)
    {
        if (pType == "S")
        {
            objPrint.Append("<html><head><link href='Themes/BB/style.css' rel='stylesheet' type='text/css' /></head><body>");
        }
        if (pType == "E")
        {
            objPrint.Append("</body></html>");
        }
    }
    public static void PrintHeader(ref StringBuilder objPrint)
    {
        objPrint.Append("<table border=0 cellspacing=0 cellpadding=0><tr><td height=0>&nbsp;</td></tr></table>");
    }
    public static void PrintPatientDetails(ref StringBuilder objPrint, string Name, string Age, string ReceiptNo,
                string IPNo, string ReceiptDate, string PatientNo)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td width=10%>Receipt No</td>" +

                "<td width=10%>" + ReceiptNo + "</td>" +
                 "<td width=40%>&nbsp; </td>" +
                "<td  width=10%> Receipt Date: </td>" +

                "<td width=10%>" + ReceiptDate + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10% >Patient Name :</td>" +

                "<td width=10%>" + Name + "</td>" + "<td width=40%>&nbsp; </td>" +
                "<td  width=10%> Patient No : </td>" +

                "<td width=10%>" + PatientNo + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10%>Age/Sex :</td>" +

                "<td width=10%>" + Age + "</td>" + "<td width=40%>&nbsp; </td>" +
                "<td  width=10%> IP No : </td>" +

                "<td width=10%>" + IPNo + "</td>" +
            "</tr>" +

           "</table>");

    }
    #region OP Patient Print Details
    //Op Patient Details
    public static void PrintOPPatientDetails(ref StringBuilder objPrint, string Name, string Age, string BillNO,
                string BillDate, string PatientNo, string LabNo)
    {
        string LabNos = string.Empty;
        if (LabNo != "" && LabNo != "-1" && LabNo.ToString() != "0")
        {
            LabNos = "<td width=15%>LabNo </td>" +
                    "<td width=15%>:" + LabNo + " </td>";
        }

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0><tr><td align=center>"+
            "<table  width=80% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td width=20%>Patient No</td>" +
                "<td width=30%>:" + PatientNo + "</td>" +
                 "<td width=20%>&nbsp; </td>" +
                "<td  width=15%> Bill Date </td>" +
                "<td width=15%>:" + BillDate + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=20% >Patient Name </td>" +
                "<td width=30%>:" + Name + "</td>" +
                "<td width=20%>&nbsp; </td>" +
                "<td  width=15%> Bill No </td>" +
                "<td width=15%>:" + BillNO + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=20%>Age/Sex </td>" +
                "<td width=30%>:" + Age + "</td>" +
                "<td width=20%>&nbsp; </td>" +
                LabNos +
            "</tr>" +
           "</table></td></tr></table>");

    }
    //Op Patient Amount Details
    public static void PrintOPAmountDetails(ref StringBuilder objPrint, string Amount, string RecAmount, string GrndTotal, string PayMode,
        string Taxamount, string Discount, string Rounopff, string SeviceTax, string discountpercent, string Due, string NetAmount,
        string strWordAmount, string OtherCurrency, string pUser, string DueamtTxt, string DueAmt, string RemainDepo, string depamt)
    {
        string Tax = string.Empty;
        string DiscountAmount = string.Empty;
        string Roundpff = string.Empty;
        string Sevicetax = string.Empty;
        string Dues = string.Empty;
        string paymentmode = string.Empty;
        string DepAmtUsed = string.Empty;
        if (Taxamount != "" && (Convert.ToDecimal(Taxamount)) > 0)
        {
            Tax = "<tr><td width=60%>&nbsp;</td><td width=10%>&nbsp;</td><td width=20% align=right>Tax Amount:</td><td  width=10% align=right>" + Taxamount + " </td></tr>";
        }
        if (Discount != "" && (Convert.ToDecimal(Discount)) > 0)
        {
            DiscountAmount = "<tr><td width=60%>&nbsp;</td><td width=10%>&nbsp; </td>" +
                    "<td width=20% align=right>" + discountpercent + " Discount(-):" + "</td>" +
                   "<td  width=10% align=right>" + Discount + " </td>" +
               "</tr>";
        }
        if (Rounopff != "" && Convert.ToDecimal(Rounopff) > 0)
        {
            Roundpff = "<tr>" +
                   "<td width=60%>&nbsp;</td>" +
                   "<td width=10%>&nbsp; </td>" +
                    "<td width=20% align=right>Round off Amount:</td>" +
                   "<td  width=10% align=right>" + Rounopff + " </td>" +
               "</tr>";
        }
        if (SeviceTax != "" && Convert.ToDecimal(SeviceTax) > 0)
        {
            Sevicetax = "<tr>" +
                    "<td width=60%>&nbsp;</td>" +
                    "<td width=10%>&nbsp; </td>" +
                     "<td width=20% align=right>SeviceTax:</td>" +
                    "<td  width=10% align=right>" + SeviceTax + " </td>" +
                "</tr>";
        }
        if (Due != "" && Convert.ToDecimal(Due) > 0)
        {
            Dues = "<tr>" +
                    "<td width=60%>&nbsp;</td>" +
                    "<td width=10%> &nbsp;  </td>" +
                     "<td width=20% align=right>Due:</td>" +
                    "<td  width=10% align=right>" + Due + " </td>" +
                "</tr>";

        }
        if (PayMode != "")
        {
            paymentmode = "<tr>" +
                    "<td width=60% style=font-weight:bold;> Pament Mode: </td>" +
                    "<td width=10%>&nbsp; </td>" +
                     "<td width=20%>&nbsp; </td>" +
                    "<td  width=10% align=right > -------- </td>" +
                "</tr>";
        }
       
        
        string DueAmts = string.Empty;
        string RemainDeposit = string.Empty;
         
        if (DueAmt != "")
        {
            DueAmts = 
                DueamtTxt + DueAmt ;
           
        }

        if (!string.IsNullOrEmpty(RemainDepo))
        {
            RemainDeposit =  
                  "Remaining Deposit Amount : (Rupees) " + RemainDepo  ;
              
        }
        if (!string.IsNullOrEmpty(depamt) && Convert.ToDecimal(depamt) > 0)
        {
            DepAmtUsed =
                  "Deposit Amount Used:(Rupees) " + depamt;

        }


        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +

            "<tr>" +
                "<td width=60%>&nbsp;</td>" +

                "<td width=10%>&nbsp;</td>" +
                 "<td width=20%>&nbsp; </td>" +
                "<td  width=10% >&nbsp;</td>" +
            "</tr>" + paymentmode +

            "<tr>" +
                "<td width=60%>" + PayMode + "</td>" +
                "<td width=10%>&nbsp; </td>" +
                 "<td width=20% align=right>Gross Amount:</td>" +
                "<td  width=10% align=right>" + GrndTotal + " </td>" +
            "</tr>" + Tax + DiscountAmount + Roundpff + SeviceTax + Sevicetax +


            "<tr>" +
                "<td width=60%>&nbsp;</td>" +
                "<td width=10%>&nbsp;</td>" +
                 "<td width=20%>&nbsp; </td>" +
                "<td  width=10% align=right> -------- </td>" +
            "</tr>" +
            "<tr>" +
                "<td width=60%>&nbsp;</td>" +

                "<td width=10%>&nbsp; </td>" +
                 "<td width=20% align=right> Grand Total:</td>" +
                "<td  width=10% align=right>" + Amount + " </td>" +
            "</tr>" +

            "<tr>" +
                "<td width=60%>" + strWordAmount + "<br/>"+DueAmts+"<br/>"+RemainDeposit+"<br/>"+DepAmtUsed+"  </td>" +
                "<td width=10%>&nbsp;</td>" +
                 "<td width=20% align=right>Net Amount :</td>" +
                "<td  width=10% align=right>" + NetAmount + "</td>" +
            "</tr>" +

            "<tr>" +
                "<td width=60%> &nbsp; </td>" +
                "<td width=10%>&nbsp;</td>" +
                 "<td width=20%> &nbsp;</td>" +
                "<td  width=10% align=right> -------- </td>" +
            "</tr>" +
                "<tr>" +
                "<td width=60%> &nbsp; </td>" +
                "<td width=10%>&nbsp;</td>" +
                "<td width=20% align=right> Amount Received :</td>" +
                "<td  width=10% align=right>" + RecAmount + "</td>" +
                "</tr>" +

             "<tr>" +
                "<td width=60%>" + OtherCurrency + "</td>" +
                "<td width=10%> &nbsp;  </td>" +
                 "<td width=20% align=right>&nbsp;</td>" +
                "<td  width=10% align=right>" + Dues + " </td>" +
            "</tr>" +


            "<tr>" +
                "<td width=60%  align=right>"+pUser +"</td>" +
                "<td width=10%>&nbsp;</td>" +
                 "<td width=20%>&nbsp; </td>" +
                "<td  width=10% align=right> -------- </td>" +
            "</tr>" +
           "</table>");

    }
     
    #endregion


    #region  IP Patient Print Details
    //Ip Make Payment Amount Details

    public static void PrintIPAmountDetails(ref StringBuilder objPrint, string Amount, string RecAmount, string GrndTotal, string PayMode, string BillDate)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>"

            + "<tr>" +
                "<td colspan=3></td>"

             + "</tr>" +

             "<tr>" +
                 "<td   style=font-weight:bold; width=70%> Pament Mode: </td>" +

                 "<td  >&nbsp; </td>" +

                 "<td align=right> ------------ </td>" +
             "</tr> " +
             "<tr>" +
                 "<td  width=70% align=left>" + PayMode + "</td>"

                 + "<td  align=right width=20%>Total: </td>" +
                 "<td   align=right width=10%>" + GrndTotal + " </td>"

             + "</tr>" +

              "<tr>" +
                 "<td>&nbsp;</td>" +
                 "<td  width=20% align=right>Amount Received: </td>" +
                 "<td   width=10% align=right >" + RecAmount + " </td>" +

             "</tr>" +

             "<tr>" +
                 "<td  >&nbsp;</td> " +

                 "<td  >&nbsp;</td>" +
                 "<td   width=10% align=right > ------------ </td> " +
             "</tr> " +

            "</table>");

    }

    //Duechart IntmAmountDetails

    public static void PrintIPInrmAmountDetails(ref StringBuilder objPrint, string Amount, string RecAmount, string GrndTotal, string PayMode, string BillDate)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0  align=right>" +

             "<tr>" +
             "<td  width=45%>&nbsp;</td>" +
                "<td  width=45% align=right>Total:</td> " +
                 "<td width=10% align=right>" + Amount + " </td>" +
            " </tr>" +
            "</table>");

    }




    public static void PrintInrmAmountFooter(ref StringBuilder objPrint, string Amount, string pUser)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td width=60%>&nbsp;</td>" +
            "</tr>" +


            "<tr>" +
                "<td>Total Amount:" + Amount + "</td>" +
            "</tr>" +
            "<tr>" +
               "<td>" + pUser + "</td>" +
            "</tr>" +
           "</table>");

    }

    public static void PrintInrmAmountFooter1(ref StringBuilder objPrint, string pUser)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td width=60%>&nbsp;</td>" +
            "</tr>" +           
            "<tr>" +
               "<td>" + pUser + "</td>" +
            "</tr>" +
           "</table>");

    }
    //Add Due Chart
    public static void InrmPrintPatientDetails(ref StringBuilder objPrint, string Name, string Age, string ReceiptNo,
                string IPNo, string ReceiptDate, string PatientNo, string RaisedDate, string LabNo, string RefPhy, string PharmacyBillNo)
    {
        string Labs = string.Empty;
        string PhyBillNo = string.Empty;

        if (PharmacyBillNo != "")
        {

            PhyBillNo = "<tr> <td width=10% >Pharmacy Bill No</td>" +
                "<td width=15% >:" + PharmacyBillNo + "</td>" +
              " <td width=40%>&nbsp; </td> <td width=40%>&nbsp; </td> </tr>";
        }
        if (LabNo != "" && LabNo.ToString() != "-1" && LabNo.ToString() != "0")
        {

            Labs = "<td width=5%>LabNo </td><td width=5%>:&nbsp;" + LabNo + "</td> ";
        }
        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=20%> Patient No </td>" +
                "<td width=30%>:&nbsp;" + PatientNo + "</td>" +
                 "<td width=10%>&nbsp; </td>" +
                "<td  width=15%>Date </td>" +
                "<td width=30% >:&nbsp;" + ReceiptDate + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=20% >Patient Name </td>" +
                "<td width=30%>:&nbsp;" + Name + "</td>" +
                "<td width=10%>&nbsp; </td>" +
                "<td width=15%>IntRef Number</td>" +
                "<td width=30%>:&nbsp;" + ReceiptNo + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10%>Age/Sex</td>" +
                "<td width=30%>:&nbsp;" + Age + "</td>" +
                "<td width=10%>&nbsp; </td>" +
                "<td width=15%>Raised Date</td>" +
                "<td width=30% >:&nbsp;" + RaisedDate + "</td>" +


            "</tr>" +

            "<tr>" +
                "<td width=10%>Referring Physician Name</td>" +
                "<td width=30%>:&nbsp;" + RefPhy + "</td>" +
                "<td width=10%>&nbsp; </td>" +
                Labs +

            "</tr>" + PhyBillNo +


           "</table>");

    }
    //Ip Make Payment
    public static void IpReceiptPrintPatientDetails(ref StringBuilder objPrint, string Name, string Age, string ReceiptNo,
             string IPNo, string ReceiptDate, string PatientNo, string paiddate, string LabNo)
    {
        string Labs = string.Empty;
        if (LabNo != "" && LabNo.ToString() != "-1" && LabNo.ToString() != "0")
        {

            Labs = "<td width=10%>LabNo </td><td width=30%>:&nbsp;" + LabNo + "</td> ";
        }

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=15%> Patient No  </td>" +
                "<td width=35%>:&nbsp;" + PatientNo + "</td>" +
                 "<td width=20%>&nbsp; </td>" +
                "<td  width=10%>Date </td>" +
                "<td width=30%>:&nbsp;" + ReceiptDate + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=15% >Patient Name </td>" +
                "<td width=35%>:&nbsp;" + Name + "</td>" +
                "<td width=20%>&nbsp; </td>" +
                "<td width=10%>Receipt No </td>" +
                "<td width=30%>:&nbsp;" + ReceiptNo + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=15%>Age/Sex </td>" +
                "<td width=35%>:&nbsp;" + Age + "</td>" +
                "<td width=20%>&nbsp; </td>" +
                Labs +
            "</tr>" +

            "<tr>" +
                "<td width=15%>Paid Date</td>" +
                "<td width=35%>:&nbsp;" + paiddate + "</td>" +
                "<td width=20%>&nbsp; </td>" +
            "</tr>" +
           "</table>");

    }

    //Ip Make Payment AmountFooter For Advance Receipt
    public static void PrintIPAmountFooter(ref StringBuilder objPrint, string Amount, string pUser)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td width=60%>" + Amount + "</td>" +
            "</tr>" +
            "<tr>" +
               "<td width=60%>" + pUser + "</td>" +
            "</tr>" +
           "</table>");

    }
    #endregion





    public static void IpPrintPatientDetails(ref StringBuilder objPrint, string Name, string Age, string ReceiptNo,
          string IPNo, string ReceiptDate, string PatientNo)
    {

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=10%> Patient No : </td>" +
                "<td width=10%>" + PatientNo + "</td>" +
                 "<td width=40%>&nbsp; </td>" +
                "<td  width=10%>Date: </td>" +
                "<td width=10%>" + ReceiptDate + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10% >Patient Name :</td>" +
                "<td width=10%>" + Name + "</td>" + "<td width=40%>&nbsp; </td>" +
                "<td width=10%>ReceiptNo</td>" +
                "<td width=10%>" + ReceiptNo + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10%>Age/Sex :</td>" +
                "<td width=10%>" + Age + "</td>" + "<td width=40%>&nbsp; </td>" +
            "</tr>" +

           "</table>");

    }


    //Op Phr PatientDetails 
    public static void OpPhrPatientDetails(ref StringBuilder objPrint, string Name, string Age, string BillNO,
          string IPNo, string ReceiptDate, string PatientNo, string DLNO, string TinNO, string Prescribed, string PharmacyBillNo)
    {
        string phy = Prescribed;
        string phyname = string.Empty;
        string PhyBillNo = string.Empty;
        if (PharmacyBillNo != "")
        {

            PhyBillNo = "<tr> <td width=10% >Pharmacy Bill No</td>" +
                "<td width=15% >:" + PharmacyBillNo + "</td>" +
              " <td width=40%>&nbsp; </td> <td width=40%>&nbsp; </td> </tr>";
        }
        if (Prescribed != "")
        {
            phyname = "<td width=15% align=right>Prescribed By:</td>" +
                     "<td width=20% align=right>" + Prescribed + "</td>";
        }
        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=10%> D.L.No </td>" +
                "<td width=15%>:" + DLNO + "</td>" +
                 "<td width=40%>&nbsp; </td>" +
                "<td  width=15% align=right>Patient Name: </td>" +
                "<td width=20% align=right>" + Name + "</td>" +
            "</tr>" +
            "<tr>" +
                "<td width=10% >TIN.NO</td>" +
                "<td width=15%>:" + TinNO + "</td>" +
                "<td width=40%>&nbsp; </td>" +
                "<td width=15% align=right>Patient NO:</td>" +
                "<td width=20% align=right>" + PatientNo + "</td>" +
            "</tr>" +
            "<tr>" +
             "<td width=10% >Bill NO</td>" +
                "<td width=15%>:" + BillNO + "</td>" +
                 "<td width=40%>&nbsp; </td>" +
                "<td width=15% align=right>Age/Sex: </td>" +
                "<td width=20% align=right>" + Age + "</td>" +
            "</tr>" +

            "<tr>" +
                "<td width=10% >Date</td>" +
                 "<td width=15% >:" + ReceiptDate + "</td>" +
                "<td width=40%>&nbsp; </td>" + phyname +

                 "</tr>" + PhyBillNo +

           "</table>");

    }

    // OP Phar AmountDetails
    public static void PrintOPPharAmountDet(ref StringBuilder objPrint, string PaidAmount, string Paymode)
    {
        string DiscountAmount = string.Empty;
        string Due = string.Empty;
        string RefundAmt = string.Empty;
        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=40% align=left >PayMent Mode: </td> " +
                  "<td  width=75% align=right > &nbsp;</td> " +
                   "<td  width=10% align=right > &nbsp;</td> " +
            " </tr>" +

             "<tr>" +
              "<td  width=40% align=left >" + Paymode + "</td> " +
                 "<td  width=50% align=right >&nbsp;</td> " +
                 "<td  width=10% align= right >&nbsp; </td>" +
            " </tr>" +
              "<tr>" +
               "<td  width=40% align=right > &nbsp;</td> " +
                 "<td  width=50% align=right>Paid Amount:  </td>" +
                 "<td   width=10% align=right >" + PaidAmount + " </td></tr></table>");

    }
    public static void PrintOPPharAmountDetails(ref StringBuilder objPrint, string subtotal, string Vat, string GrossValue,
        string NetAmount, string PaidAmount, string DiscountAmt, string discountpercent, string DueAmt, string Refund, string Paymode)
    {
        string DiscountAmount = string.Empty;
        string Due = string.Empty;
        string RefundAmt = string.Empty;
        if (DiscountAmt != "" && (Convert.ToDecimal(DiscountAmt)) > 0)
        {
            DiscountAmount = "<tr>" +
                 "<td  width=40% align=right > &nbsp;</td> " +
                    "<td width=50% align=right>" + discountpercent + "</td>" +
                   "<td  width=10% align=right>" + DiscountAmt + " </td>" +
               "</tr>";
        }
        if (DueAmt != "" && (Convert.ToDecimal(DueAmt)) > 0)
        {
            Due = "<tr>" +
                 "<td  width=40% align=right > &nbsp;</td> " +
                    "<td width=50% align=right> Due :</td>" +
                   "<td  width=10% align=right>" + DueAmt + " </td>" +
               "</tr>";
        }
        if (Refund != "" && (Convert.ToDecimal(Refund)) > 0)
        {
            RefundAmt = "<tr>" +
                 "<td  width=40% align=right > &nbsp;</td> " +
                    "<td width=50% align=right> Refund Amount:</td>" +
                   "<td  width=10% align=right>" + Refund + " </td>" +
               "</tr>";
        }
        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                 "<td  width=40% align=left >PayMent Mode: </td> " +
                  "<td  width=75% align=right > &nbsp;</td> " +
                   "<td  width=10% align=right > &nbsp;</td> " +
            " </tr>" +

             "<tr>" +
              "<td  width=40% align=left >" + Paymode + "</td> " +
                 "<td  width=50% align=right >Sub Total : </td> " +
                 "<td  width=10% align= right >" + subtotal + " </td>" +
            " </tr>" +
             "<tr>" +
              "<td  width=40% align=right > &nbsp;</td> " +
                 "<td  width=50% align=right >Vat: </td> " +
                 "<td  width=10% align= right >" + Vat + " </td>" +
            " </tr>" +
             "<tr>" +
              "<td  width=40% align=right > &nbsp;</td> " +
                 "<td  width=50% align=right >Gross Total : </td> " +
                 "<td  width=10% align= right >" + GrossValue + " </td>" +
            " </tr>" + DiscountAmount +
            "<tr>" +
             "<td  width=40% align=right > &nbsp;</td> " +
                 "<td  width=50% align=right>Net Amount:  </td>" +
                 "<td   width=10% align=right >" + NetAmount + " </td>" +
             "</tr>" +
              "<tr>" +
               "<td  width=40% align=right > &nbsp;</td> " +
                 "<td  width=50% align=right>Paid Amount:  </td>" +
                 "<td   width=10% align=right >" + PaidAmount + " </td>" +
             "</tr>" + Due + RefundAmt +
            "</table>");

    }
    //OP PhrPrint AmountFooter
    public static void OPPhrPrintAmountFooter(ref StringBuilder objPrint, string Amount, string pUser, string Refund, string Deposite)
    {
        string RefundAmt = string.Empty;
        string DepositeAmt = string.Empty;
        if (Refund != "")
        {
            RefundAmt = "<tr>" +
               "<td >" + Refund + "</td>" +
            "</tr>";
        }
        if (Deposite != "")
        {
            DepositeAmt = "<tr>" +
               "<td >" + Deposite + "</td>" +
            "</tr>";
        }

        objPrint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            "<tr>" +
                "<td >&nbsp;</td>" +
            "</tr>" +
            "<tr>" +
                "<td >" + Amount + "</td>" +
            "</tr>" + RefundAmt + DepositeAmt +
            "<tr>" +
               "<td >" + pUser + "</td>" +
            "</tr>" +
           "</table>");

    }


    public static void PrintHeaderCondant(ref StringBuilder objprint, string pCondant, string Duplicate)
    {
        if (Duplicate == "Y")
        {
            objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                 "<tr>" +
                     "<td align=center>" + pCondant + " (Duplicate Copy)" + "</td>" +
                 "</tr> </table>");
        }
        else
        {
            objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                "<tr>" +
                    "<td align=center>" + pCondant + "</td>" +
                "</tr> </table>");
        }

    }
    
    //--------------------------------------------New Hope Bill Format
    public static void NewHopePharmacyBillFormat(ref StringBuilder objStrHTML, string Name, string Age, string BillNO,
          string IPNo, string ReceiptDate, string PatientNo, string DLNO, string TinNO, string Prescribed, string Address, int OrgID)
    {
        string phy = Prescribed;
        string phyname = string.Empty;
    
        int td1 = 0;
        int td2 = 0;
        int td3 = 0;
        int td4 = 0;
        if (OrgID == 121)
        {
            td1 = 18;
            td2 = 42;
            td3 = 10;
            td4 = 30;
        }
        objStrHTML.Append("<table width=100% border=0 style='font-size: 12;font-family:Arial'>");
        objStrHTML.Append("<tr>" + "<td width='" + td1.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td2.ToString() + "'>" + Prescribed + "</td>" + "<td width='" + td3.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td4.ToString() + "'>" + BillNO + "</td></tr>");
        objStrHTML.Append("<tr>" + "<td width='" + td1.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td2.ToString() + "'>" + Name + "</td>" + "<td width='" + td3.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td4.ToString() + "'>" + ReceiptDate + "</td></tr>");
        if (OrgID == 121)
        {
            objStrHTML.Append("<tr>" + "<td width='" + td1.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td2.ToString() + "'>" + Address + "</td>" + "<td width='" + td3.ToString() + "'>" + "&nbsp" + "</td>" + "<td width='" + td4.ToString() + "'>" + "&nbsp" + "</td></tr>");
        }
        objStrHTML.Append("</table>");
        objStrHTML.Append("<table width=100% style='font-size:11px;'height=2%><tr><td>" + "&nbsp" + "</td></tr></table>");
    }

    public static void NewHopeAmountDetails(ref StringBuilder objStrHTML, string subtotal, string Vat, string GrossValue,
        string NetAmount, string PaidAmount, string DiscountAmt, string discountpercent, string DueAmt, string Refund, string Paymode, string Align)
    {
        if (Align == "N")
        {
            objStrHTML.Append("<table width=100% border=0 style='font-size: 12;font-family:Arial'>");
            //objStrHTML.Append("<tr><td width=80% align=right>Sub Total :</td><td width=20% align=right>" + subtotal + "</td></tr>");
            //objStrHTML.Append("<tr><td width=80% align=right>Vat :</td><td width=20% align=right>" + Vat + "</td></tr>");
            //objStrHTML.Append("<tr><td width=80% align=right>Gross Total :</td><td width=20% align=right>" + GrossValue + "</td></tr>");
            //objStrHTML.Append("<tr><td width=80% align=right>Net Amount  :</td><td width=20% align=right>" + NetAmount + "</td></tr>");
            objStrHTML.Append("<tr><td width=80% align=right>Paid Amount :</td><td width=20% align=right>" + PaidAmount + "</td></tr>");
            objStrHTML.Append("</table>");
        }
        if (Align == "Y")
        {
            objStrHTML.Append("<table width=100% border=0 style='font-size: 12;font-family:Arial'>");
            objStrHTML.Append("<tr><td width=60% align=right>Paid Amount :</td><td width=40% align=left>" + PaidAmount + "</td></tr>");
            objStrHTML.Append("</table>");
        }
    }

    public static void NewHopeAmountFooter(ref StringBuilder objStrHTML, string Amount, string pUser, string Refund, string Deposite)
    {
        string RefundAmt = string.Empty;
        string DepositeAmt = string.Empty;
        if (Refund != "")
        {
            RefundAmt = "<tr>" +
               "<td >" + Refund + "</td>" +
            "</tr>";
        }
        if (Deposite != "")
        {
            DepositeAmt = "<tr>" +
               "<td >" + Deposite + "</td>" +
            "</tr>";
        }

        objStrHTML.Append("<table width=100% border=0 style='font-size: 12;font-family:Arial'>" +
            "<tr>" +
                "<td align=left>" + Amount + "</td>" +
            "</tr>" + RefundAmt + DepositeAmt +
            "<tr>" +
               "<td align=left>" + pUser + "</td>" +
            "</tr>" +
           "</table>");

    }
    //------------------------------------------------------------------------------------------------
    public static void PharmacyHeaderFormat(ref StringBuilder objStrHTML, string OrgName, string OrgAddress, string LogoUrl)
    {
        string phyname = string.Empty;
        objStrHTML.Append("<table width=100% border=0 style='font-size: 12;font-family:Arial'>");
        if (LogoUrl != "")
        {
            objStrHTML.Append("<tr>" + "<td rowspan='2'><img ID='imgBillLogo' src='" + LogoUrl + "'></td><td width=95% align='Center' style='font-weight: bold;'>" + OrgName + "</td><td></td></tr>");
        }
        else
        {
            objStrHTML.Append("<tr>" + "<td rowspan='2'></td><td width=95% align='Center' style='font-weight: bold;'>" + OrgName + "</td><td></td></tr>");
        }
        objStrHTML.Append("<tr>" + "<td width=95% align='Center' style='font-weight: bold;'>" + OrgAddress + "</td><td></td></tr>");
        objStrHTML.Append("</table>");
        objStrHTML.Append("<table width=100% style='font-size:11px;'height=2%><tr><td></td><td>" + "&nbsp" + "</td><td></td></tr></table>");
    }
}