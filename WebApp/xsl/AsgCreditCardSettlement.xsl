<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">
    <html>
      <body>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
        <div id="divCreditCardSettlement" style="margin-top:10px; " >
          <h3 align="center" style="line-height:0%">Credit Card Settlement Form</h3>
          <div id="divHeader" style="margin:1;padding:0; ">
            <table border="1"  cellpadding="0" cellspacing="0" width="100%">
              <tr align="center">
                <td align="center" colspan="4">
                  <xsl:value-of select="Deposit/Header/@orgDetails"/>
                </td>
              </tr>

              <tr align="center">
                <td align="center" colspan="4">
                  <xsl:value-of select="Deposit/Header/@OrgAddress"/>
                </td>
              </tr>


              <tr>
                <td   align="left">
                  CMS Client Code
                </td>
                <td  align="left">
                  ASGHSPJODH
                  <!--  <xsl:value-of select="Deposit/Header/@AccountNo"/>-->
                </td>
                <td   align="left">
                  Date/Time of Generation
                </td>
                <td  align="left">
                  <xsl:value-of select="Deposit/Header/@CreatedAt"/>
                </td>
              </tr>

              <tr align="left">
                <td  rowspan="5" valign="top" align="left"  >
                  Bank Name/Branch
                </td>
                <td rowspan="5" valign="top" align="left" >
                  <xsl:value-of select="Deposit/Header/@HeaderBankName"/>
                </td>
                <td>
                  Deposit Form No.
                </td>
                <td align="left">
                  <xsl:value-of select="Deposit/Header/@DepositedRefNo"/>
                </td>
              </tr>
              <tr>
                <td  align="left">
                  Clearing Type
                </td>
                <td align="left">
                  <xsl:value-of select="Deposit/Header/@paymentType"/>
                </td>              
               
              </tr>
              <tr>
                <td  align="left">
                  Settlement Number:
                </td>
                <td align="left">
                  <xsl:value-of select="Deposit/Header/@SettlementNo"/>
                </td>
              </tr>
              <tr>
               
                <td   align="left">
                  MID Number:
                </td>
              </tr>
             
              <tr>
               
                <td  align="left">
                  Batch No.
                </td>
                
              </tr>
            </table>
          </div>

          <div id="divCreditCardBody" style="margin:1;padding:0">
            <table  cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td align="left">
                  <table border="1" cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed">
                    <tr>
                      <th align="center" >Serial No.</th>
                      <th align="center" >Transaction ID</th>
                      <th align="center" >Date</th>
                      <!--<th align="center"  visible="false">Patient Name</th>-->
                      <th align="center" colspan="2">Rs P.</th>
                    </tr>
                    <xsl:for-each select="Deposit/Body">
                      <tr>
                        <td align="center" >
                          <xsl:value-of select="@SerialNo"/>
                        </td>
                        <td >
                          <xsl:value-of select="@TransactionID"/>&#160;
                        </td>
                        <td >
                          <xsl:value-of select="@ChequeValidDate"/>&#160;
                        </td>
                        <!--<td >
                          <xsl:value-of select="@UserName"/>&#160;
                        </td>-->

                        <td  align="right" colspan="2">
                          <xsl:value-of select="@AmtReceived"/>
                        </td>
                      </tr>
                    </xsl:for-each>
                    <tr>
                      <td colspan="4" align="right">Total</td>
                      <td align="right">
                        <xsl:value-of select="Deposit/Header/@TotalAmount"/>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5" align="left" valign="top">
                        Amount in Words:(<xsl:value-of select="Deposit/Header/@TotalAmountText"/>)

                      </td>
                    </tr>
                    <tr>
                      <td  colspan="5" align="left" valign="top">
                        <xsl:value-of select="Deposit/Header/@Description"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </div>
          <footer>
            <div id="divFooter" style="margin:1;padding:0">
              <table border="1" cellpadding="0.5" cellspacing="0.5" width="100%" style="table-layout:fixed">
                <tr height="50px">
                  <td colspan="2" rowsapn="2" align="right" valign="bottom">Prepared by</td>
                </tr>
                <tr height="50px">
                  <!--<td align="left"  valign="bottom">Bank Receiving Stamp,Signature/date</td>
                  <td align="right" valign="bottom">Signature</td>-->
                </tr>
                <tr>
                  <td>
                  </td>
                  <table border="1" cellpadding="0.5" cellspacing="0.5" width="100%" style="table-layout:fixed">
                    <tr>
                      <td align="right"  colspan="3">
                        UserID: <xsl:value-of select="Deposit/Header/@FUserName"/>
                      </td>
                    </tr>
                  </table>
                  <td>

                  </td>
                </tr>
                <tr>
                  <td colspan="2">
                    <!--<br></br>
                    *IN CASE DEPOSIT FORM SPILLS OVER TO ANOTHER PAGE TOTAL WOULD BE SHOWN AS TOTAL C/F
                    IN THE NEXT PAGE THE RED SHADED AREAS WOULD APPEAR AGAIN AND THE FIRST ROW AFTER SERIAL NO. HEADER
                    SHALL BE BALANCE B/F-->


                  </td>
                </tr>
              </table>
            </div>
          </footer>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
