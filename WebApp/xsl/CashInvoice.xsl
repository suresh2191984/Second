<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:asp="remove"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo"
                >

  <!--<xsl:template match="Author">
    <xsl:value-of select="FirstName"/>
    <xsl:value-of select="LastName"/>
    <xsl:if test="position()!=last()">, </xsl:if>
  </xsl:template>-->
  <xsl:template match="/">
    <!--<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>-->

    <style>
      <![CDATA[
         table{clear:left;float:left;font-family:verdana;}
         b{font-family:verdana;font-size:10px;}
         .s1{clear:left;float:left;border:solid 1px black;width:1654px;margin:10px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;font-family:verdana;font-size:10px;}
         .s5{background-color:#96C4DD;}
		 
      ]]>
    </style>

    <html>

      <body>
        <div id="div" class="printfont">
          <div id="divOP" class="UIfont" >
            <br></br>

            <div id="dvContent">

              <div id="dvPatientDtls" style="padding:5px;">
                <table width="100%">
                  <tr>
                    <td width="60%">
                      <table width="100%">
                        <tr>
                          <td width="80px">

                            Reg.No
                          </td>
                          <td width="4px">:</td>
                          <td >
                            <xsl:value-of select="CashBill/RegNumber"/>
                          </td>
                        </tr>
                        <tr>
                          <td>Patient Name</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CashBill/PatientName" />
                          </td>
                        </tr>
                        <tr>

                          <td>
                            Doctor
                          </td>
                          <td>
                            :
                          </td>
                          <td>
                            <xsl:value-of select="CashBill/Physician"/>
                          </td>
                        </tr>
                      </table>

                    </td>
                    <td width="40%"  valign="top" style="vertical-align: top;">
                      <table width="100%">
                        <tr>
                          <td></td>
                          <td width="80px" align="left">
                            Invoice No
                          </td>
                          <td width="4px">
                            :
                          </td>
                          <td width="80px">
                            <xsl:value-of select="CashBill/InvoiceNumber"/>
                          </td>

                        </tr>
                        <tr>
                          <td></td>
                          <td width="80px" align="left">Date</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CashBill/InvoiceDate"/>
                          </td>
                          <!--<td colspan="3"></td>-->
                        </tr>
                      </table>
                    </td>



                  </tr>

                </table>
              </div>
              <br></br>


              <div id="dvBillingDetails"  style="border-width: thin; border-top-color:Black; border-top-style:solid;display:inline">
                <table width="100%" style="border:1px solid #ccc;border-collapse: collapse;border-spacing: 0;margin:0;padding:0;">

                  <tr style="border:1px solid #ccc;">
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="10%">SI NO</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="10%">Code</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="35%">Service Description</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="15%">Price</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="15%">Discount</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="15%">Amount</td>
                  </tr>

                  <xsl:for-each select="CashBill/BillingItem">
                    <tr style="border:1px solid #ccc;">
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="SNo" />

                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="Code" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="ServiceDesc" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Price" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Discount" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Amount" />
                      </td>
                    </tr>
                  </xsl:for-each>
                  <tr style="border:1px solid #ccc;">
                    <td style="border:1px solid #ccc;" align="right" colspan="5">Total</td>
                    <td style="border:1px solid #ccc;" align="right">
                      <xsl:value-of select="CashBill/Total" />
                    </td>
                  </tr>
                  <tr style="border:1px solid #ccc;">
                    <td style="border:1px solid #ccc;" align="right" colspan="5">Discount</td>
                    <td style="border:1px solid #ccc;" align="right">
                      <xsl:value-of select="CashBill/Discount" />
                    </td>
                  </tr>
                  <tr>
                    <td style="border:1px solid #ccc;" align="right" colspan="5">Net Amount</td>
                    <td style="border:1px solid #ccc;" align="right">
                      <xsl:value-of select="CashBill/NetAmount" />
                    </td>
                  </tr>
                </table>
              </div>
              <div style="width:100%;height:20px;display:inline-block;">

              </div>
              <div id="dvDueDetails=">
                <table width="100%">
                  <tr>
                    <td  width="50%">
                      <table width="100%" align="left"  style="margin:0;padding:0; vertical-align:top;" >
                        <xsl:if test="CashBill/PaymentType !=''">
                        <tr>
                          <td width="30%" style="font-weight:bold">
                            Payment Mode:
                          </td> 
                        </tr>
                        </xsl:if>
                        <tr >
                          <td>
                            <xsl:value-of select="CashBill/PaymentType" disable-output-escaping="yes"/>
                          </td>
                        </tr>
                      
                        <xsl:if test ="CashBill/DepositUsed!='0'">
                          <tr>
                            <td>
                              Deposit amount Used - <xsl:value-of select="CashBill/DepositUsed"/>
                            </td>
                          </tr>
                        </xsl:if>
                      </table>
                    </td>
                    <td  width="50%">
                      <table width="100%" style="border-collapse: collapse;border-spacing: 0;margin:0;padding:0;">
                        <tr>
                          <td  align="right">
                            Previous Due
                          </td>
                          <td style="border:1px solid #ccc;" align="right" width="30%">
                            <xsl:value-of select="CashBill/PreDue"/>
                          </td>
                        </tr>
                        <tr>
                          <td align="right">
                            Total
                          </td>
                          <td style="border:1px solid #ccc;" align="right" width="30%">
                            <xsl:value-of select="CashBill/DueTotal"/>
                          </td>
                        </tr>
                        <tr>
                          <td  align="right">
                            Paid Amount
                          </td>
                          <td style="border:1px solid #ccc;" align="right" width="30%">
                            <xsl:value-of select="CashBill/PaidAmount"/>
                          </td>
                        </tr>
                        <tr>
                          <td align="right">
                            Balance Due
                          </td>
                          <td style="border:1px solid #ccc;" align="right" width="30%">
                            <xsl:value-of select="CashBill/BalanceDue"/>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </div>

              <div id="Div1">
                <table width="100%" align="left"  style="margin:0;padding:0;font-weight:bold" >
                  <xsl:if test="CashBill/PaymentMode!=''">
                  <tr>
                    <td width="165px">
                      Amount Received in Words:
                    </td>
                    <td>
                      (<xsl:value-of select="CashBill/BaseCurrency"/>)
                    </td>
                  </tr>
                  </xsl:if>
                </table>
                <table width="100%" align="left"  style="margin:0;padding:0;font-weight:bold" >
                  <xsl:if test="CashBill/PaymentMode!=''">
                  <tr style="height:15px;">
                    <td>
                      <xsl:value-of select="CashBill/BaseAmountInWords"/>
                    </td>
                  </tr>
                  </xsl:if>
                </table>
                <table width="100%" align="left"  style="margin:0;padding:0;font-weight:bold" >
                  <xsl:if test="CashBill/PaymentMode!=''">
                  <tr>
                    <td width="105px">
                      Paying Currency:
                    </td>
                    <td>
                      (<xsl:value-of select="CashBill/PaymentMode"/>)
                    </td>
                  </tr>
                  </xsl:if>
                </table>
                <table width="100%" align="left"  style="margin:0;padding:0;font-weight:bold" >
                  <xsl:if test="CashBill/PaymentMode!=''">
                  <tr style="height:15px;">
                    <td>
                      <xsl:value-of select="CashBill/AmountInWords"/>
                    </td>
                  </tr>
                  </xsl:if>
                </table>
              </div>
              <div id="dvOtherDetails">
                <table width="100%" align="left" >
                  <xsl:if test ="CashBill/Remarks!=''">
                    <tr>

                      <td width="5%">
                        Remarks
                      </td>
                      <td>:</td>
                      <td>
                        <xsl:value-of select="CashBill/Remarks"/>
                      </td>

                    </tr>
                  </xsl:if>
                  <tr style="height:20px;">
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      <table width="100%" style="font-weight:bold" >
                        <tr>

                          <td width="85%" align="left">SEAL</td>
                          <td width="50%" align="right">
                            <xsl:value-of select="CashBill/CreatedBy"/>
                          </td>

                        </tr>
                        <tr>
                          <td colspan="2"  align="right">
                            <xsl:value-of select="CashBill/CreatedAt"/>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </div>


            </div>



          </div>
        </div>

      </body>

    </html>

  </xsl:template>
</xsl:stylesheet>
