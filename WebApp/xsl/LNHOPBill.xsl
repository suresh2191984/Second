<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="urn:extra-functions">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="BillingInfo">
    <html>
      <head>
        <title>Bill</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <style type="text/css">
          table { empty-cells: show; border-spacing: 0px; margin: 0px; padding: 0px;}
          .pagebreak {page-break-after: always;}
          .tableReportHeader{border-top: solid black 1px; border-left: solid black 1px; border-right: solid black 1px; width: 645px;}
          .tabledetails{border-left: solid black 1px; border-right: solid black 1px;  width: 645px; }
          .tableReportFooter{bottom: 2px;border-bottom: solid black 1px; border-left: solid black 1px; border-right: solid black 1px;  width: 645px;}
          .imglogo{border-style: none; vertical-align: top; border-color: White;}
          td{vertical-align: top; font-family: Arial, Helvetica, sans-serif; font-size: 9pt}
          .tdmargin{width:10px;}

          .documentheader{font-family:Arial; font-size:9pt; color:black; font-weight:bold;}
          th{font-family:Arial; font-size:8pt; color:white; background-color: darkblue; text-align:center;border: solid 1px darkblue;}
          .tdorderHeader{border: solid 1px darkblue;}
          .blueline{border-bottom: dashed black 1px;border-right: solid black 1px;}
          .blueline1{border-bottom: dashed black 1px;}
          <!--.documenttotal{font-family:Arial; font-size:9pt; color:black; font-weight:bold;border-bottom: solid black 1px;}-->
          .documenttotal{font-family:Arial; font-size:9pt; color:black; font-weight:bold;border-bottom: solid black 0px;}
          .tdtotalmargin{width:330px;}
          .tdtotalmargin1{width:50px;}
          .tdtotalmargin2{width:450px;}
        </style>
      </head>
      <body>
        <table style="height:567px;">
          <tr>
            <td>
              <xsl:copy-of select="$ReportHeader"/>

              <xsl:call-template name="Filler">
                <xsl:with-param name="fillercount" select="1" />
              </xsl:call-template>

              <xsl:copy-of select="$OrderRecipient"/>

              <xsl:call-template name="Filler">
                <xsl:with-param name="fillercount" select="1" />
              </xsl:call-template>

              <xsl:copy-of select="$OrderRowsHeader"/>

              <xsl:variable name="itemcount" select="count(BillingDetails)"></xsl:variable>



              <xsl:for-each select="BillingDetails">

                <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
                  <tr>

                    <td class="blueline" style="width:350px" >
                      <xsl:value-of select="Description" />
                      <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                    </td>
                    <td style="width:150px" align="right" class="blueline">
                      <xsl:value-of select="Units" />
                      <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
                    </td>
                    <td style="width:120px" align="right" class="blueline1">
                      <xsl:value-of select="Amount" />
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

                  <xsl:call-template name="Filler">
                    <xsl:with-param name="fillercount" select="1" />
                  </xsl:call-template>

                  

                  <xsl:call-template name="Filler">
                    <xsl:with-param name="fillercount" select="1" />
                  </xsl:call-template>

                  <xsl:copy-of select="$OrderRowsHeader"/>

                </xsl:if>
              </xsl:for-each>



              <!--Filler -->
              <xsl:choose>
                <!-- case of only one page-->
                <xsl:when test="count(BillingInfo/BillingDetails) &lt;= 5">
                  <xsl:call-template name="Filler">
                    <xsl:with-param name="fillercount" select="1 - (count(BillingInfo/BillingDetails))"/>
                  </xsl:call-template>
                </xsl:when>
                <!-- case of more than one page-->
                <xsl:otherwise>
                  <xsl:call-template name="Filler">
                    <!--(Rows per page = 40) -  (Rows in current page) - (Total section rows = 1 ) + (Filler Row = 1)-->
                    <xsl:with-param name="fillercount" select="1 - ( ( count(BillingInfo/BillingDetails)-5 ) mod 5 ) - 3 + 1"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              <!--End Filler -->

              <xsl:copy-of select="$OrderTotals"/>
              <xsl:copy-of select ="$AmountInWords"/>
              <xsl:copy-of select="$ReportBy"/>
              <xsl:copy-of select="$ReportFooter"/>


            </td>
          </tr>
        </table>



      </body>
    </html>
  </xsl:template>




  <!-- variable ReportHeader-->
  <xsl:variable name="ReportHeader">
    <table class="tableReportHeader" cellspacing="0">
      <tr>
        <td>
          <img class="imglogo" src="../xsl/image_header.png" />
        </td>
        <td>
          <h3 style="color:darkblue; font-family: Arial;">BILL</h3>
        </td>
      </tr>
    </table>
  </xsl:variable>



  <!-- variable report by-->

  <xsl:variable name="ReportBy">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin2" />
        <td class="documenttotal" align="left">
          Billed By:
        </td>
        <td align="left">
          <xsl:value-of select ="BillingInfo/BilledBy"/>
        </td>
      </tr>
    </table>
  </xsl:variable>

  <!-- variable Amount in words-->

  <xsl:variable name="AmountInWords">
    <table class="tabledetails" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin1" />
        <td class="documenttotal" align="left">
          Amount In Words :
          <span style="color:black;font-weight:normal;">
            <xsl:value-of select ="BillingInfo/AmountInWords"/>
          </span>
        </td>

      </tr>

    </table>
  </xsl:variable>


  <!-- variable OrderRecipient-->
  <xsl:variable name="OrderRecipient">
    <table class="tabledetails">
      <tr>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Bill No
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/BillNo"/>
        </td>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Bill Date
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/BillDate"/>
        </td>
      </tr>
      <tr>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Patient Name
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/PatientName"/>
        </td>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          UHID
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/PatientNo"/>
        </td>
      </tr>
      <tr>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Age
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/PatientAge"/>
        </td>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Gender
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/Sex"/>
        </td>
      </tr>
      <tr>
        <td class="tdmargin"/>
        <td class="documentheader" align="right">
          Physician Name
        </td>
        <td>
          :
        </td>
        <td>
          <xsl:value-of select="/BillingInfo/PhysicianName"/>
        </td>
      </tr>



    </table>
  </xsl:variable>


  <!--variable OrderRowsHeader-->
  <xsl:variable name="OrderRowsHeader">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>
        <td>
          <u>
            <b>  Billing Details</b>
          </u>
        </td>
      </tr>
      <tr>
        <td style="width:280px">
          Description
        </td>
        <td style="width:100px">
          Units
        </td>
        <td style="width:35px">
          Amount
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

  <!--variable OrderTotals-->
  <xsl:variable name="OrderTotals">
    <table class="tabledetails" cellspacing="0" style="table-layout:fixed">
      <tr>
        <td class="tdtotalmargin" />
        <td class="documenttotal" align="right">
          Gross Amount
        </td>
        <td>
          :
        </td>
        <td class="blueline1" align="right">
          <xsl:value-of select="/BillingInfo/GrossAmount" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>

      </tr>
      <xsl:if test="ServiceCharge &gt; 0">
        <tr>
          <td class="tdtotalmargin" />
          <td class="documenttotal" align="right">
            Service Charge
          </td>
          <td>
            :
          </td>
          <td class="blueline1" align="right">
            <xsl:value-of select="/BillingInfo/ServiceCharge" />
            <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
          </td>

        </tr>
      </xsl:if>
      <xsl:if test="Discount &gt; 0">
        <tr>
          <td class="tdtotalmargin" />
          <td class="documenttotal" align="right">
            Discount (-)
          </td>
          <td>
            :
          </td>
          <td class="blueline1" align="right">
            <xsl:value-of select="/BillingInfo/Discount" />
            <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
          </td>

        </tr>
      </xsl:if>
      <tr>
        <td class="tdtotalmargin" />
        <td class="documenttotal" align="right">
          Grand Total
        </td>
        <td>
          :
        </td>
        <td class="blueline1" align="right">
          <xsl:value-of select="/BillingInfo/GrandTotal" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>

      </tr>
      <xsl:if test="PreviousDue &gt; 0">
        <tr>
          <td class="tdtotalmargin" />
          <td class="documenttotal" align="right">
            Previous Due
          </td>
          <td>
            :
          </td>
          <td class="blueline1" align="right">
            <xsl:value-of select="/BillingInfo/PreviousDue" />
            <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
          </td>

        </tr>
      </xsl:if>
      <tr>
        <td class="tdtotalmargin" />
        <td class="documenttotal" align="right">
          Net Amount
        </td>
        <td>
          :
        </td>
        <td class="blueline1" align="right">
          <xsl:value-of select="/BillingInfo/NetAmount" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>

      </tr>
      <tr>
        <td class="tdtotalmargin" />
        <td class="documenttotal" align="right">
          Amount Received
        </td>
        <td>
          :
        </td>
        <td class="blueline1" align="right">
          <xsl:value-of select="/BillingInfo/AmountReceived" />
          <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
        </td>

      </tr>
      <xsl:if test="Due &gt; 0">
        <tr>
          <td class="tdtotalmargin" />
          <td class="documenttotal" align="right">
            Due
          </td>
          <td>
            :
          </td>
          <td class="blueline1" align="right">
            <xsl:value-of select="/BillingInfo/Due" />
            <xsl:value-of select="translate(' ', ' ', '&#160;')"/>
          </td>

        </tr>
      </xsl:if>
    </table>
  </xsl:variable>


  <!-- variable ReportFooter-->
  <xsl:variable name="ReportFooter">
    <table class="tableReportFooter">
      <tr>
        <td style="width:20px;"></td>
        <td>
          <table>
            <tr>
              <td style="font-size: 5pt; text-align: justify;border-top: solid black 1px;">
                <!--One Portals Way, Twin Points WA  98156 Phone: 1-206-555-1417   Fax: 1-206-555-5938-->
              </td>
            </tr>
          </table>
        </td>
        <td style="width:20px;"></td>
      </tr>
    </table>
  </xsl:variable>


</xsl:stylesheet>