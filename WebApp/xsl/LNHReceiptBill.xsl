<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="urn:extra-functions">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="ReceiptInfo">
    <html>
      <head>
        <title>Invoice</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <style type="text/css">

          table { empty-cells: show; border-spacing: 0px; margin: 0px; padding: 0px;width:590px;}
          .pagebreak {page-break-after: always;}
          .tableReportHeader{border-top: solid black 1px; border-left: solid black 1px; border-right: solid black 1px; width: 590px;}
          .tabledetails{border-left: solid black 1px; border-right: solid black 1px;  width: 590px; }
          .tableReportFooter{bottom: 2px;border-bottom: solid black 1px; border-left: solid black 1px; border-right: solid black 1px;  width: 590px;}
          .imglogo{border-style: none; vertical-align: top; border-color: White;}
          td{vertical-align: top; font-family: Arial, Helvetica, sans-serif; font-size: 9pt}
          .tdmargin{width:10px;}

          .documentheader{font-family:Arial; font-size:9pt; color:black; font-weight:bold;}
          th{font-family:Arial; font-size:8pt; color:white; background-color: black; text-align:center;border: solid 1px black;}
          .tdorderHeader{border: solid 1px black;}
          .blueline{border-bottom: dashed black 1px;border-right: solid black 1px;}
          .blueline1{border-bottom: dashed black 1px;}
          <!--.documenttotal{font-family:Arial; font-size:9pt; color:black; font-weight:bold;border-bottom: solid black 1px;}-->
          .documenttotal{font-family:Arial; font-size:9pt; color:black; font-weight:bold;border-bottom: solid black 0px;}
          .tdtotalmargin{width:300px;}
          .tdtotalmargin1{width:1px;}
          .tdtotalmargin2{width:180px;}
        </style>
      </head>


      <body>
        

              <xsl:copy-of select="$ReportHeader"/>


              <xsl:copy-of select="$OrderRecipient"/>

              <!--<xsl:call-template name="Filler">
          <xsl:with-param name="fillercount" select="1" />
        </xsl:call-template>-->

              <xsl:if test ="count(ReceiptDetails) &lt;=0">
                <xsl:copy-of select="$AdvancePayment"/>
              </xsl:if>


              <xsl:if test ="count(ReceiptDetails) &gt;= 1">
                <xsl:copy-of select="$OrderRowsHeaderTitle"/>
                <xsl:copy-of select="$OrderRowsHeader"/>
                
                <xsl:for-each select="ReceiptDetails">

                  <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
                    <tr>
                      <td class="tdmargin" />
                      <td style="width:250px" >
                        <xsl:value-of select="Description" />
                        <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                      </td>
                      <td style="width:60px" align="right">
                        <xsl:value-of select="Date" />
                        <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                      </td>
                      <td style="width:70px" align="right">
                        <xsl:value-of select="UnitPrice" />
                        <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                      </td>
                      <td style="width:60px" align="right">
                        <xsl:value-of select="Quantity" />
                        <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                      </td>
                      <td style="width:90px" align="right">
                        <xsl:value-of select="Amount" />
                        <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                      </td>
                      <td class="tdmargin" />
                    </tr>
                  </table>


                  <xsl:choose>
                    <!-- case of only one page-->
                    <xsl:when test="(position() mod 12 = 0 and position() = 12)">
                      <!--40 rows per page-->
                      <!--<xsl:call-template name="Filler">
                        <xsl:with-param name="fillercount" select="1" />
                      </xsl:call-template>-->

                      <xsl:copy-of select="$ReportFooter" />

                      <br class="pagebreak" />

                      <xsl:copy-of select="$ReportHeader" />

                      <!--<xsl:call-template name="Filler">
                        <xsl:with-param name="fillercount" select="2" />
                      </xsl:call-template>-->
                      <xsl:copy-of select="$OrderRowsHeaderTitle"/>
                      <xsl:copy-of select="$OrderRowsHeader"/>

                    </xsl:when>
                    <!-- case of more than one page-->
                    <xsl:otherwise>
                      <xsl:if test="(12 - position() mod 20) = 0 and position() &gt; (12 + position() mod 20)">
                        <!--46 rows per page-->
                        <!--<xsl:call-template name="Filler">
                          <xsl:with-param name="fillercount" select="1" />
                        </xsl:call-template>-->

                        <xsl:copy-of select="$ReportFooter" />

                        <br class="pagebreak" />

                        <xsl:copy-of select="$ReportHeader" />

                        <!--<xsl:call-template name="Filler">
                          <xsl:with-param name="fillercount" select="2" />
                        </xsl:call-template>-->
                        <xsl:copy-of select="$OrderRowsHeaderTitle"/>
                        <xsl:copy-of select="$OrderRowsHeader"/>

                      </xsl:if>

                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>

              </xsl:if>

              <!--Filler -->
              <xsl:choose>
                <!-- case of only one page-->
                <xsl:when test="count(ReceiptDetails) &lt;= 12">
                  <!--<xsl:call-template name="Filler">
                <xsl:with-param name="fillercount" select="12 - (count(ReceiptDetails))"/>
              </xsl:call-template>-->
                </xsl:when>
                <!-- case of more than one page-->
                <xsl:otherwise>
                  <xsl:call-template name="Filler">
                    <!--(Rows per page = 46) -  (Rows in current page) - (OrderTotals section rows = 1 ) - (Filler = 1) - (Page Footer = 1) -->
                    <xsl:with-param name="fillercount" select="20 - ((count(ReceiptDetails) - 12 ) mod 20) - 3 - 1 - 1"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              <!--End Filler -->

              <xsl:copy-of select="$OrderTotals"/>

              <xsl:copy-of select="$AmountInWords"/>
              <xsl:copy-of select="$ReportBy"/>

              <xsl:copy-of select="$ReportFooter"/>



      </body>
    </html>


  </xsl:template>

  <!--variable OrderRowsHeader-->
  <xsl:variable name ="AdvancePayment">
    <table class="tabledetails" cellspacing="0" style="height:40px;table-layout:fixed">
      <tr>
        <td class="tdmargin"/>
        <td>
          Payment Details
        </td>
      </tr>
      <tr>
        <td class="tdmargin"/>
        <td align="center" valign="middle">
          Advance Payment
        </td>
      </tr>
    </table>
  </xsl:variable>

  <!--variable OrderRowsHeaderTitle-->
  <xsl:variable name="OrderRowsHeaderTitle">
    <table class="tabledetails" height="20px;" cellspacing="0" style="table-layout:fixed">

      <tr>
        

        <td align="left">
          <span style="margin-left:0.05in;"> Payment Details:</span>

        </td>

      </tr>
    </table>
  </xsl:variable>
  <!--variable OrderRowsHeader-->
  <xsl:variable name="OrderRowsHeader">
    <table height="10px"  class="tabledetails" cellspacing="0" style="font-weight:bold;table-layout:fixed">

      <tr>
        <td class="tdmargin" />
        <td align="center" style="width:250px">
          Description
        </td>
        <td align="center" style="width:60px">
          Date
        </td>
        <td align="center" style="width:70px">
          Unit Price
        </td>
        <td align="center" style="width:60px">
          Quantity
        </td>
        <td align="center" style="width:90px">
          Amount
        </td>
        <td class="tdmargin" />
      </tr>

      <!--<tr>
        <td>
          <u>
            <b> Payment Details</b>
          </u>
        </td>
      </tr>
      <tr>
        <td align="center" style="width:245px">
          Description
        </td>
        <td align="center" style="width:100px">
          Date
        </td>
        <td align="center" style="width:100px">
          Unit Price
        </td>
        <td align="center" style="width:100px">
          Quantity
        </td>
        <td align="center" style="width:100px">
          Amount
        </td>
      </tr>-->
    </table>
  </xsl:variable>

  <!-- variable ReportHeader-->
  <xsl:variable name="ReportHeader">
    <table class="tableReportHeader" cellspacing="0">
      <tr>
        <td>
          <img class="imglogo" src="../xsl/LNHlogo1.png" />
        </td>

      </tr>
    </table>
  </xsl:variable>



  <!-- variable report by-->

  <xsl:variable name="ReportBy">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin2" />
        <td align="left">
          Billed By:

          <xsl:value-of select ="concat('(',ReceiptInfo/BilledBy,')')"/>
        </td>
      </tr>
    </table>
  </xsl:variable>

  <!-- variable Amount in words-->

  <xsl:variable name="AmountInWords">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>
        <td class="tdmargin" />
        <td align="left">
          The sum of<span style="margin-left:0.05in;">

            <xsl:value-of select ="concat(ReceiptInfo/AmountInWords,' Only...')"/>
          </span>

        </td>

      </tr>

    </table>
  </xsl:variable>


  <!-- variable OrderRecipient-->
  <xsl:variable name="OrderRecipient">
    <table class="tabledetails">
      <tr>
        <td class="tdmargin" />
        <td></td>
        <td></td>
        <td></td>
        <td align="right">
          Date
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/ReceiptInfo/Date"/>
        </td>
      </tr>
      <tr>
        <td class="tdmargin" />
        <td align="left">
          Received From
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/ReceiptInfo/ReceivedFrom"/>
        </td>
        <td align="right">
          Receipt Number
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/ReceiptInfo/ReceiptNumber"/>
        </td>
      </tr>

      <tr>
        <td class="tdmargin" />
        <td align="left">
          Paid Date
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/ReceiptInfo/PaidDate"/>
        </td>

        <td></td>
        <td></td>
        <td></td>
      </tr>
    </table>
  </xsl:variable>





  <!-- Template Filler-->
  <xsl:template name="Filler">
    <xsl:param name="fillercount" select="1"/>
    <xsl:if test="$fillercount > 0">
      <table class="tabledetails">
        <tr>
          <td>
            <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
          </td>
        </tr>
      </table>
      <xsl:call-template name="Filler">
        <xsl:with-param name="fillercount" select="$fillercount - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--variable OrderTotals-->
  <xsl:variable name="OrderTotals">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>

        <td  align="right">
          Total:

          <xsl:value-of select="concat(/ReceiptInfo/Total,' /-')" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td style="width:1%"/>
      </tr>
      <tr>

        <td align="right">
          Amount Received
          :

          <xsl:value-of select="concat(ReceiptInfo/AmountReceived,' /-')" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td style="width:1%"/>
      </tr>


    </table>
  </xsl:variable>


  <!-- variable ReportFooter-->
  <xsl:variable name="ReportFooter">
    <table class="tableReportFooter" >
      <tr style="height:25px;">
        <td class="tdmargin" />
        <td>
          <u>Disclaimer:</u> This is only an cash receipt. This receipt cannot be used for claiming purpose.
        </td>
      </tr>
    </table>
  </xsl:variable>


</xsl:stylesheet>










