<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <!--<xsl:template match="Author">      
<xsl:value-of select="FirstName"/>      
<xsl:value-of select="LastName"/>      
<xsl:if test="position()!=last()">, 
</xsl:if>    </xsl:template>-->
  <xsl:template match="/">
    <!--<xsl:copy>              
<xsl:apply-templates select="@* | node()"/>          
</xsl:copy>-->

    <html id="htmlOP">
      <head>
        <style type="text/css">
          .pagebreak {page-break-after: before; height:0;}
          .divfont{font-family: Arial;font-size: 10pt; white-space: nowrap;}
          .tdtotalmargin{width:515px;}
          .divWidth{width: 850px;margin-top:0px}
          .lineHeight{line-height:2em;}
          .OrgFontSize{font-size: 14pt;}
          table{font-size: 10pt;}
          div{font-size: 10pt;}
        </style>

      </head>
      <body style="margin:0px;font-size: 10pt">

        <div  style="margin:0 auto;height:21cm; width:15cm;">
          <div align="Center" style="width: 100%; white-space: nowrap; margin-top: 4px; font-size:10pt;font-weight:bold;">
            <br />
            <br />
            
            INVOICE
            <br />
          </div>
          <div style="width: 100% ;float:left;">

            <div style="height:15px"> &#160;&#160;</div>
            <div style="float:left;width:100%;">
              <table width="100%" >
                <tr>
                  <td width="20%">Patient Name </td>
                  <td width="1%">:</td>
                  <td width="43%">
                    <xsl:if test="InventoryOPBill/PatientName=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/PatientName"/>
                  </td>
                  <td align="right" width="10%">Bill No</td>
                  <td align="right" width="1%">:</td>
                  <td align="left" width="10%">
                    <xsl:if test="InventoryOPBill/BillNo=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/BillNo"/>
                  </td>
                </tr>
                <tr>
                  <td>Age</td>
                  <td>:</td>
                  <td>
                    <xsl:if test="InventoryOPBill/Age=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/Age"/>
                  </td>
                  <td align="right">Date</td>
                  <td align="right">:</td>
                  <td align="left">
                    <xsl:if test="InventoryOPBill/Date=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/Date"/>
                  </td>
                </tr>
                <tr>
                  <td>UHID </td>
                  <td>:</td>
                  <td>
                    <xsl:if test="InventoryOPBill/PatientNo=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/PatientNo"/>
                  </td>
                </tr>
                <xsl:if test="InventoryOPBill/InsuranceProvider !=''">
                <tr>
                  <td>Insurance Provider</td>
                  <td>:</td>
                  <td>
                    <xsl:value-of select="InventoryOPBill/InsuranceProvider"/>
                  </td>

                </tr>
                </xsl:if>
                <xsl:if test="InventoryOPBill/SubInsuranceProvider !=''">
                <tr>
                  <td>Sub Insurance</td>
                  <td>:</td>
                  <td>
                    <xsl:if test="InventoryOPBill/SubInsuranceProvider=''">
                    </xsl:if>
                    <xsl:value-of select="InventoryOPBill/SubInsuranceProvider"/>
                  </td>
                </tr>
                </xsl:if>
              </table>
            </div>
            <br />
            <br />
          </div>

          <div style="Height:25px;margin-top: 16%;">
            <br />
            <br />
            <br />
          </div>

          <div style="float:left;width:100%;">
            <table cellpadding="2" cellspacing="0" width="100%" border="1" frame="void" >
              <tr>
                <td  align="left">
                  S.No
                </td>
                <td  align="left">
                  Particulars
                </td>
                <td  align="left">
                  Quantity
                </td>
                <td  align="left">
                  Batch
                </td>
                <td  align="left">
                  Exp.Date
                </td>
                <td  align="left">
                  Rate
                </td>
                <td  align="left">
                  Amount
                </td>
              </tr>


              <xsl:for-each select="InventoryOPBill/OrderedItems">
                <tr >
                  <td >
                    <xsl:value-of select="SNo"/>
                  </td>
                  <td >
                    <xsl:value-of select="Description"/>
                  </td>
                  <td >
                    <xsl:value-of select="Quantity"/>
                  </td>
                  <td >
                    <xsl:value-of select="BatchNo"/>
                  </td>
                  <td >
                    <xsl:value-of select="ExpiryDate"/>
                  </td>
                  <td >
                    <xsl:value-of select="Rate"/>
                  </td>
                  <td >
                    <xsl:value-of select="Amount"/>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div>

          <div style="Height:25px;margin-top: 16%;">
            <br />
            <br />
            <br />
          </div>

          <div style="float:left;">
            <table width="100%">
              <tr>

                <xsl:choose>
                  <xsl:when test="InventoryOPBill/GrandTotal=''">
                  </xsl:when>
                  <xsl:otherwise>
                    <td align="left" style="width:22%">Amount in Words</td>
                    <td style="width:1%">:</td>
                    <td align="left" style="width:35%">
                      <xsl:value-of select="InventoryOPBill/AmountInWords"/>
                    </td>
                    <td colspan="3" width="90%" align="right">Gross Total </td>
                    <td width="1%">:</td>
                    <td>
                      <xsl:value-of select="InventoryOPBill/GrandTotal"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>

              <tr>
                <xsl:choose>
                  <xsl:when test="InventoryOPBill/NetValue=''">
                  </xsl:when>
                  <xsl:otherwise>
                    <td style="width:22%">Payment Mode</td>
                    <td style="width:1%">:</td>
                    <td style="width:35%">
                      <xsl:if test="InventoryOPBill/PaymentMode=''">
                      </xsl:if>
                      <xsl:value-of select="InventoryOPBill/PaymentMode"/>
                    </td>
                    <td colspan="3" align="right">Net Amount</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="InventoryOPBill/NetValue"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
              <tr>
                <xsl:choose>
                  <xsl:when test="InventoryOPBill/NetValue=''">
                  </xsl:when>
                  <xsl:otherwise>
                    <td style="width:22%" align="left">Billed By</td>
                    <td style="width:1%">:</td>
                    <td style="width:35%">
                      <xsl:if test="InventoryOPBill/BilledBy=''">
                      </xsl:if>
                      <xsl:value-of select="InventoryOPBill/BilledBy"/>
                    </td>
                    <!--<td align="right">Total Amount</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="InventoryOPBill/NetValue"/>
                    </td>-->

                    <td colspan="3" align="right">Amount Received</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="InventoryOPBill/PaidAmount"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
              <xsl:if test="InventoryOPBill/DueAmount != '' and InventoryOPBill/DueAmount != 0.00 ">
              <tr>
                <td colspan="6"  align="right">Due</td>
                <td>:</td>
                <td>
                  <xsl:value-of select="InventoryOPBill/DueAmount"/>
                </td>
              </tr>
              </xsl:if>
              <tr>
                <xsl:choose>
                  <xsl:when test="InventoryOPBill/PaidAmount=''">
                  </xsl:when>
                  <xsl:otherwise>


                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </table>
            <table width="97%">
              <tr>
              </tr>
              <tr>
                <xsl:choose>
                  <xsl:when test="InventoryOPBill/AmountInWords=''">
                  </xsl:when>
                  <xsl:otherwise>

                  </xsl:otherwise>
                </xsl:choose>
              </tr>
              <tr>

              </tr>
            </table>
          </div>
          <!--<div style="page-break-after : always; "></div>-->

        </div>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
