<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="urn:extra-functions">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="VoucherInfo">
    <html>
      <head>
        <title>Voucher</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <style type="text/css">
          table { empty-cells: show; border-spacing: 0px; margin: 0px; padding: 0px;}
          .pagebreak {page-break-after: always;}
          .tableReportHeader{border-top: solid DarkBlue 1px; border-left: solid DarkBlue 1px; border-right: solid DarkBlue 1px; width: 645px;}
          .tabledetails{border-left: solid DarkBlue 1px; border-right: solid DarkBlue 1px;  width: 645px; }
          .tableReportFooter{bottom: 2px;border-bottom: solid DarkBlue 1px; border-left: solid DarkBlue 1px; border-right: solid DarkBlue 1px;  width: 645px;}
          .imglogo{border-style: none; vertical-align: top; border-color: White;}
          td{vertical-align: top; font-family: Arial, Helvetica, sans-serif; font-size: 9pt}
          .tdmargin{width:10px;}

          .documentheader{font-family:Arial; font-size:9pt; color:DarkBlue; font-weight:bold;}
          th{font-family:Arial; font-size:8pt; color:white; background-color: darkblue; text-align:center;border: solid 1px darkblue;}
          .tdorderHeader{border: solid 1px darkblue;}
          .blueline{border-bottom: dashed DarkBlue 1px;border-right: solid DarkBlue 1px;}
          .blueline1{border-bottom: dashed black 1px;}
          <!--.documenttotal{font-family:Arial; font-size:9pt; color:DarkBlue; font-weight:bold;border-bottom: solid DarkBlue 1px;}-->
          .documenttotal{font-family:Arial; font-size:9pt; color:DarkBlue; font-weight:bold;border-bottom: solid DarkBlue 0px;}
          .tdtotalmargin{width:515px;}
          .tdtotalmargin1{width:50px;}
          .tdtotalmargin2{width:400px;}
          .ReportBy{width:70px;}
        </style>
      </head>


      <body>
        <xsl:copy-of select="$ReportHeader"/>


        <xsl:copy-of select="$OrderRecipient"/>

        <xsl:call-template name="Filler">
          <xsl:with-param name="fillercount" select="1" />
        </xsl:call-template>

        <xsl:copy-of select="$OrderRowsHeader"/>

        <xsl:for-each select="PaymentDetails">

          <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
            <tr>

              <td class="blueline" style="width:180px" >
                <xsl:value-of select="PaymentType" />
                <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
              </td>
              <td style="width:100px" align="center" class="blueline">
                <xsl:value-of select="CardChequeNo" />
                <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
              </td>
              <td style="width:100px" align="center" class="blueline">
                <xsl:value-of select="BankCardName" />
                <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
              </td>
              <td style="width:60px" align="right" class="blueline">
                <xsl:value-of select="Amount" />
                <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
              </td>
              <td style="width:90px" align="right" class="blueline1">
                <xsl:value-of select="CardFee" />
                <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
              </td>

            </tr>
          </table>
          <xsl:if test="(position() mod 8) = 0 ">
            <!--40 rows per page-->
            <xsl:call-template name="Filler">
              <xsl:with-param name="fillercount" select="1" />
            </xsl:call-template>

            <xsl:copy-of select="$ReportFooter" />

            <br class="pagebreak" />

            <xsl:copy-of select="$ReportHeader" />

            <xsl:call-template name="Filler">
              <xsl:with-param name="fillercount" select="1" />
            </xsl:call-template>

            <!--<xsl:copy-of select="$OrderRecipient"/>-->


            <xsl:copy-of select="$OrderRowsHeader"/>

          </xsl:if>
        </xsl:for-each>



        <!--Filler -->
        <xsl:choose>
          <!-- case of only one page-->
          <xsl:when test="count(VoucherInfo/PaymentDetails) &lt;= 5">
            <xsl:call-template name="Filler">
              <xsl:with-param name="fillercount" select="1 - count(VoucherInfo/PaymentDetails)"/>
            </xsl:call-template>
          </xsl:when>
          <!-- case of more than one page-->
          <xsl:otherwise>
            <xsl:call-template name="Filler">
              <!--(Rows per page = 40) -  (Rows in current page) - (Total section rows = 1 ) + (Filler Row = 1)-->
              <xsl:with-param name="fillercount" select="1 - ( ( count(VoucherInfo/PaymentDetails) - 5 ) mod 5 ) - 3 + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>


        <!--End Filler -->
        <xsl:copy-of select="$Remarks"/>
        <xsl:copy-of select="$OrderTotals"/>
        <xsl:copy-of select="$AmountInWords"/>
        <xsl:copy-of select="$ReportBy"/>
        <table class="tabledetails" style="height:30px;">
          <tr>
            <td>

            </td>
          </tr>
        </table>
        <xsl:copy-of select="$ReportFooter"/>


      </body>
    </html>


  </xsl:template>



  <!--variable OrderRowsHeader-->
  <xsl:variable name="OrderRowsHeader">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>
        <th align="center" style="width:180px">
          Payment Type
        </th>
        <th align="center" style="width:100px">
          Card/Cheque No
        </th>
        <th align="center" style="width:100px">
          Bank/Card Name
        </th>
        <th align="center" style="width:60px">
          Amount
        </th>
        <th align="center" style="width:80px">
          Card Fee (%)
        </th>

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
          <img class="imglogo" src="../xsl/LNHLogo2.png" />
        </td>
        
      </tr>
      <tr>
        <td align="center">
          Payment Voucher
        </td>
      </tr>
    </table>
  </xsl:variable>



  <!-- variable report by-->

  <xsl:variable name="ReportBy">

    <table class="tabledetails" style="table-layout:fixed;font-weight:bold;">
      <tr>
        <td class="ReportBy">

        </td>
        <td>
          <span style="margin-left:0.2in"> PASSED BY</span>
        </td>
        <td>
          | ACCOUNTANT| DIRECTOR
        </td>

        <td>
          | RECEIVER NAME
        </td>
      </tr>
      <tr>
        <td class="ReportBy">

        </td>
        <td>
          <xsl:value-of select="concat('(',VoucherInfo/BilledBy,')')"/>
        </td>
        <td></td>
        <td>
          (with sign and Date)
        </td>
      </tr>
    </table>
  </xsl:variable>

  <!-- variable Amount in words-->

  <xsl:variable name="AmountInWords">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>

        <td class="documenttotal" align="left">
          The sum of<span style="margin-left:0.05in;">
            <span style="color:black;font-weight:normal;">
              <xsl:value-of select ="VoucherInfo/AmountInWords"/>
            </span>
          </span>
        </td>

      </tr>

    </table>
  </xsl:variable>


  <!-- variable OrderRecipient-->
  <xsl:variable name="OrderRecipient">
    <table class="tabledetails">

      <tr>
        <td class="documentheader" align="right">
          Name
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/VoucherInfo/Name"/>
        </td>
        <td class="documentheader" align="right">
          Printed Date
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/VoucherInfo/PrintedDate"/>
        </td>
      </tr>
      <tr>
        <td class="documentheader" align="right">
          Paid Date
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/VoucherInfo/PaidDate"/>
        </td>

        <td class="documentheader" align="right">
          Voucher Number
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/VoucherInfo/VoucherNumber"/>
        </td>
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

  <!-- variable Remarks-->
  <xsl:variable name="Remarks">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>

        <td align="left">
          <span style="margin-right:0.05in;" class="documenttotal">
            Remarks
            :
          </span>
          <xsl:value-of  select="/VoucherInfo/Remarks" />

        </td>

      </tr>

    </table>
  </xsl:variable>



  <!--variable OrderTotals-->
  <xsl:variable name="OrderTotals">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin" />
        <td class="documenttotal" align="right">
          Total:
        </td>
        <td>
          <xsl:value-of select="concat(/VoucherInfo/Total,' /-')" />

          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>

      </tr>


    </table>
  </xsl:variable>


  <!-- variable ReportFooter-->
  <xsl:variable name="ReportFooter">
    <table class="tableReportFooter">
      <tr>
        <td>

        </td>
      </tr>
    </table>
  </xsl:variable>


</xsl:stylesheet>









