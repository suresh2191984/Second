<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="urn:extra-functions">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="RefundVoucherInfo">
    <html>
      <head>
        <title>Invoice</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <style type="text/css">

          table { empty-cells: show; border-spacing: 0px; margin: 0px; padding: 0px;width:590px;}
          .pagebreak {page-break-after: always;}
          .tableReportHeader{border-top: solid black 1px; border-left: solid  black 1px; border-right: solid  black 1px; width: 590px;}
          .tabledetails{border-left: solid black 1px; border-right: solid black 1px;  width: 590px; }
          .tableReportFooter{bottom: 2px;border-bottom: solid black 1px; border-left: solid black 1px; border-right: solid black 1px;  width: 590px;}
          .imglogo{border-style: none; vertical-align: top; border-color: black;}
          td{vertical-align: top; font-family: Verdana, Helvetica, sans-serif; font-size: 9pt}
          .tdmargin{width:10px;}

          .documentheader{font-family:Verdana; font-size:14px; color:black; font-weight:bold;}
          th{font-family:Verdana; font-size:8pt; color:black; background-color: black; text-align:center;border: solid 1px black;}
          .tdorderHeader{border: solid 1px black;}
          .blueline{border-bottom: dashed black 1px;border-right: solid black 1px;}
          .blueline1{border-bottom: dashed black 1px;}
          <!--.documenttotal{font-family:Verdana; font-size:14px; color:black; font-weight:bold;border-bottom: solid black 1px;}-->
          .documenttotal{font-family:Verdana; font-size:14px; color:black; font-weight:bold;border-bottom: solid black 0px;}
          .tdtotalmargin{width:300px;}
          .tdtotalmargin1{width:1px;}
          .tdtotalmargin2{width:180px;}
          html, body, #wrapper {
          height:29%;

          }

        </style>
      </head>


      <body>





        <!--<xsl:call-template name="Filler">
          <xsl:with-param name="fillercount" select="1" />
        </xsl:call-template>-->

     


                  <xsl:copy-of select="$ReportHeader"/>


                  <xsl:copy-of select="$OrderRecipient"/>
                  <xsl:copy-of select="$OrderRowsHeaderTitle"/>
                  <xsl:copy-of select="$OrderRowsHeader"/>
                  <xsl:copy-of select="$AmountInWords"/>
                  <xsl:copy-of select="$ReportFooter"/>
                
       

      </body>
    </html>


  </xsl:template>

 

  <!--variable OrderRowsHeaderTitle-->
  <xsl:variable name="OrderRowsHeaderTitle">
    <table class="tabledetails" height="20px;" cellspacing="10" cellpadding="8" style="table-layout:fixed">
      <tr>
        <td class="tdmargin"/>

        <td align="left">
          Refund Details:

        </td>

      </tr>
    </table>
  </xsl:variable>
  <!--variable OrderRowsHeader-->
  <xsl:variable name="OrderRowsHeader">
    <table height="10px"  class="tabledetails" cellspacing="5" cellpadding="8" style="table-layout:fixed">

      <tr>
        <td class="tdmargin" />
        <td align="center">
          A sum of Rs. <b> <xsl:value-of select="RefundVoucherInfo/RefundAmount"/>
          </b> for Bill No. <b><xsl:value-of select="RefundVoucherInfo/BillNo"/>
          </b> has been refunded.
          
        </td>
        <td class="tdmargin" />
      </tr>

    
    </table>
  </xsl:variable>

  <!-- variable ReportHeader-->
  <xsl:variable name="ReportHeader">
    <table style="font-weight:medium;" class="tableReportHeader" cellspacing="0">
      <tr>
        <td align="center">
          <!--<img class="imglogo" src="../xsl/LNHLogo2.png" />-->
          <span style="font-size:14px;font-family:verdana"> Lakshmi Nursing Home
          <br/>
          No.6,Shandy Road,Pallavaram,Chennai -600043 Phone:22640883,22640724</span>
        </td>

      </tr>
      <tr>
        <td align="center">
          <u>Refund Voucher</u>
        </td>
      </tr>
    </table>
  </xsl:variable>



  <!-- variable report by-->

  <!--<xsl:variable name="ReportBy">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin2" />
        <td align="left">
          Billed By:

          <xsl:value-of select ="concat('(',ReceiptInfo/BilledBy,')')"/>
        </td>
      </tr>
    </table>
  </xsl:variable>-->

  <!-- variable Amount in words-->

  <xsl:variable name="AmountInWords">
    <table class="tabledetails" cellspacing="10" cellpadding="8" style="table-layout:fixed">
      <tr>
        <td class="tdmargin" />
        <td align="left">
          The sum of <span style="margin-left:0.05in;">

            <xsl:value-of select ="concat('Rupees.',RefundVoucherInfo/AmountInWords,' Only...')"/>
          </span>

        </td>

      </tr>

    </table>
  </xsl:variable>


  <!-- variable OrderRecipient-->
  <xsl:variable name="OrderRecipient">
    <table cellspacing="8" cellpadding="8" class="tabledetails">
      
      <tr>
        <td class="tdmargin" />
        <td align="left">
          Name
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/RefundVoucherInfo/Name"/>
        </td>
        <td align="right">
          Printed Date
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/RefundVoucherInfo/PrintedDate"/>
        </td>
      </tr>

      <tr>
        <td class="tdmargin" />
        <td align="left">
          Bill No
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/RefundVoucherInfo/BillNo"/>
        </td>

        <td align="right">
          Refund Voucher No
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>:</td>
        <td>
          <xsl:value-of select="/RefundVoucherInfo/RefundVoucherNo"/>
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

 

  <!-- variable ReportFooter-->
  <xsl:variable name="ReportFooter">
    <table cellspacing="8" cellpadding="8" class="tableReportFooter" >
      <tr style="height:25px;">
        <td class="tdmargin" />
        <td>
          <u>Disclaimer:</u> This is only an cash receipt. This receipt cannot be used for claiming purpose.
        </td>
      </tr>
    </table>
  </xsl:variable>


</xsl:stylesheet>










