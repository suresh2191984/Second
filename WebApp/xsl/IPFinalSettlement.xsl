<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>

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
        <div id="divDischargeSummarysheet" class="printfont">
          <div id="divDischargeSummary" class="UIfont">
            <br></br>
            <table width="100%" class="w-100p a-center">
              <tr>
                <td align="center">
                  <xsl:if test="IPViewBill/HeaderLogo!=''">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="IPViewBill/HeaderLogo" />
                      </xsl:attribute>
                    </input>
                  </xsl:if>
                  <br></br>
                  <br></br>
                  <br></br>
                  <br></br>
                  <br></br>
                  <br></br>
                </td>
              </tr>             
              <tr>
                <td colspan="7" align="center">
                  <xsl:if test="IPViewBill/HeaderContent!=''">
                    <xsl:value-of select="IPViewBill/HeaderContent" disable-output-escaping="yes"/>
                  </xsl:if>
                </td>
              </tr>
            </table>
            <div id="dvContent">
              <xsl:if test="IPViewBill/ContentFont!=''">
                <xsl:attribute name="Style">
                  font-family:<xsl:value-of select="IPViewBill/ContentFont"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="IPViewBill/ContentFontSize!=''">
                <xsl:attribute name="Style">
                  font-size:<xsl:value-of select="IPViewBill/ContentFontSize"/>
                </xsl:attribute>
              </xsl:if>
              <div id="dvPatientDtls">
                <table width="100%">
                  <tr>
                    <td colspan="7" align="center">
                      <h3>
                        <!--<xsl:value-of select="IPViewBill/BillTitle"/>-->
                        FINAL BILL
                      </h3>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      UHID
                    </td>
                    <td>
                      :
                    </td>
                    <td align="left">
                      <xsl:value-of select="IPViewBill/PatientNumber" />
                    </td>
                    <td>
                    </td>
                    <td width="24%">
                      Bill Date
                    </td>
                    <td>
                      :
                    </td>
                    <td width="26%"  align="left">
                      <xsl:value-of select="IPViewBill/BillDate" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Patient Name
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/PatientName" />
                    </td>
                    <td>
                    </td>
                    <td>
                      Bill No
                    </td>
                    <td>
                      :
                    </td>
                    <td align="left">
                      <xsl:value-of select="IPViewBill/BillNumber" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Age
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/Age" />
                    </td>
                    <td>
                    </td>
                    <td>
                      Sex
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/Sex" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Primary Physician
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/PrimaryPhysician" />
                    </td>
                    <td>
                    </td>
                    <td>
                      IP No
                    </td>
                    <td>
                      :
                    </td>
                    <td align="left">
                      <xsl:value-of select="IPViewBill/IPNo" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Date of Admission
                    </td>
                    <td>
                      :
                    </td>
                    <td rowspan="2" valign="top">
                      <xsl:value-of select="IPViewBill/AdmitDate" />
                    </td>
                    <td>
                    </td>
                    <td>
                      Date of Discharge
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/DischargeDate" />
                    </td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
            <table>
              <tr>
                <td>
                  <b>
                    Client / Insurance Provider: <xsl:value-of select="IPViewBill/TPAName" />
                  </b>
                </td>
              </tr>
            </table>
          </div>
          <div class="show w-100p a-left">
            <span id="Rs_TreatmentCharges">Treatment Charges</span>           
          </div>
          <div class="show w-100p a-left">
            <span>Consultation :</span>
            <span>
              <xsl:value-of select="IPViewBill/DisplayCurrencyFormatReceived" />
            </span>
            <span>
              <xsl:value-of select="IPViewBill/ConsultationFee" />
            </span>
          </div>          
          <table>            
            <tr style="font-weight: bold">
              <td>
                Description
              </td>
              <td width="28%">
                Date
              </td>
              <td width="5%" align="center">
                Qty
              </td>
              <td width="12%" align="center">
                Unit Price
              </td>
              <td width="10%" align="center">
                Amount (Rs)
              </td>
            </tr>
            <xsl:for-each select="IPViewBill/FinalBill/FinalBillItem" >              
              <tr>
                <td>
                  <xsl:value-of select="Description"/>
                </td>
                <td>
                  <xsl:value-of select="Date"/>
                </td>
                <td align="center">
                  <xsl:value-of select="Qty"/>
                </td>
                <td>
                  <xsl:value-of select="UnitPrice"/>
                </td>
                <td>
                  <xsl:value-of select="Amount"/>
                </td>
              </tr>
            </xsl:for-each>
            <tr>
              <td></td>
            </tr>
            <tr>
              <td colspan="4" align="right">
                Gross bill amount :
              </td>
              <td align="right">
                <b>
                  <xsl:value-of select="IPViewBill/GrandTotal"/>
                </b>
              </td>
            </tr>
            <tr>
              <td colspan="4" align="right">
                Net Amount :
              </td>
              <td align="right">
                <b>
                  <xsl:value-of select="IPViewBill/NetAmount"/>
                </b>
              </td>
            </tr>
            <tr>
              <td colspan="4" align="right">
                Amount Received from Patient :
              </td>
              <td align="right">
                <b>
                  <xsl:value-of select="IPViewBill/FinalBill/TotalAmtReceived" />
                </b>
              </td>
            </tr>
            <tr>
              <td colspan="4" align="right">
                Due :
              </td>
              <td align="right">
                <b>
                  <xsl:value-of select="IPViewBill/Due" />
                </b>

              </td>
            </tr>
            <tr class="panelContent" id="trAmountInWords" runat="server">
              <td class="a-left">
                Amount received in Words:
              </td>
              <td>
                <xsl:value-of select="IPViewBill/DisplayCurrencyFormatReceived" />
              </td>
              <td>
                -
                <xsl:value-of select="IPViewBill/OnlyReceived"/>
              </td>
            </tr>
            <tr runat="server" id="tdDueAmount" class="hide">
              <td class="a-left">
                Due Amount in Words:
              </td>
              <td>
                <xsl:value-of select="IPViewBill/DisplayCurrencyFormatDue" />
              </td>
              <td>
                -
                <xsl:value-of select="IPViewBill/OnlyDue"/>
              </td>
            </tr>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
