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

            <div>
              <table width="100%">

                <tr>
                  <td style="text-align:center">
                    <h3>

                      CREDIT INVOICE
                    </h3>
                  </td>
                </tr>

              </table>
            </div>
            <div id="dvContent">

              <div id="dvPatientDtls">
                <table width="100%" style="border:1px solid #ccc;border-bottom:0 none;">
                  <tr>
                    <td width="73%">
                      <table width="100%">
                        <tr>
                          <td width="20%">

                            Reg.No
                          </td>
                          <td>:</td>
                          <td width="80%">
                            <xsl:value-of select="CreditBill/RegNumber"/>
                          </td>
                        </tr>
                        <tr>
                          <td>Patient Name</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CreditBill/PatientName"/>
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
                            <xsl:value-of select="CreditBill/Physician"/>
                          </td>
                        </tr>
                        <tr>

                          <td>
                            Insurance Company
                          </td>
                          <td>
                            :
                          </td>
                          <td>
                            <xsl:value-of select="CreditBill/Insurance"/>
                          </td>
                        </tr>
                        <tr>

                          <td>
                            Card No/Policy No
                          </td>
                          <td>
                            :
                          </td>
                          <td>
                            <xsl:value-of select="CreditBill/PolicyNo"/>
                          </td>
                        </tr>
                      </table>

                    </td>
                    <td width="27%" valign="top">
                      <table width="100%">
                        <tr>
                          <td width="40%">
                            Invoice No
                          </td>
                          <td>
                            :
                          </td>
                          <td width="60%">
                            <xsl:value-of select="CreditBill/InvoiceNumber"/>
                          </td>

                        </tr>
                        <tr>
                          <td>Invoice Date</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CreditBill/InvoiceDate"/>
                          </td>

                        </tr>
                        <tr>
                          <td>Department</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CreditBill/Dept"/>
                          </td>

                        </tr>
                        <tr>
                          <td colspan="3"></td>

                        </tr>
                        <tr>
                          <td colspan="3"></td>

                        </tr>
                        <tr>
                          <td colspan="3"></td>

                        </tr>

                        <tr>
                          <td colspan="3"></td>
                        </tr>
                        <tr>
                          <td>Provider</td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="CreditBill/Provider"/>
                          </td>

                        </tr>

                      </table>
                    </td>



                  </tr>

                </table>
              </div>

              <div id="dvBillingDetails"  style="border-width: thin; border-top-color:Black; border-top-style:solid;display:inline">
                <table width="100%" style="border:1px solid #ccc;border-collapse: collapse;border-spacing: 0;margin:0;padding:0;">

                  <tr style="border:1px solid #ccc;">
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="5%">S NO</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="40%">Service Description</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="5%">Qty</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc; text-align:right;" width="10%">Gross</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;text-align:right;" width="10%">Discount</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;text-align:right;" width="10%">Co Pay</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;text-align:right;" width="10%">Ded</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;text-align:right;" width="10%">Net Amt</td>
                  </tr>

                  <xsl:for-each select="CreditBill/BillingItem">
                    <tr style="border:1px solid #ccc;">
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="SNo" />

                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="ServiceDesc" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="Qty" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="Gross" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Discount" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="CoPay" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Deduction" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="NetAmount" />
                      </td>
                    </tr>
                  </xsl:for-each>
                  <tr style="border:1px solid #ccc;">
                    <td style="border:1px solid #ccc; font-weight:bold; "  align="right" colspan="7">Net Claim Amount</td>
                    <td style="border:1px solid #ccc;" align="right">
                      <xsl:value-of select="CreditBill/NetClaimAmount" />
                    </td>
                  </tr>
                  <tr style="border:1px solid #ccc;">
                    <td style="border:1px solid #ccc;" align="left" colspan="8">
                      AED :

                      <xsl:value-of select="CreditBill/AmountInWords" />
                    </td>
                  </tr>

                </table>
              </div>
              <br />

              <div id="dvOtherDetails">
                <table width="100%" align="left" >

                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      <table width="100%" style="font-weight:bold" >
                        <tr>

                          <td width="85%" align="left">SEAL</td>
                          <td width="50%" align="right">
                            <xsl:value-of select="CreditBill/CreatedBy"/>
                          </td>

                        </tr>
                        <tr>
                          <td colspan="2"  align="right">
                            <xsl:value-of select="CreditBill/CreatedAt"/>
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
