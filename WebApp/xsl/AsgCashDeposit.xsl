<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">
    <html>
      <body>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
        <div id="divCashDeposit" style="margin-top:10px;">
          <h3 align="center" style="line-height:0%">Cash Deposit Slip</h3>
          <div id="divHeader" style="margin:1;padding:0;">
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
                  <!--	<xsl:value-of select="Deposit/Header/@AccountNoLabel"/>-->
                </td>
                <td  align="left">
                  ASGHSPJODH
                  <!-- <xsl:value-of select="Deposit/Header/@AccountNo"/>-->
                </td>
                <td   align="left">
                  Date/Time of Generation
                </td>
                <td  align="left">
                  <xsl:value-of select="Deposit/Header/@CreatedAt"/>
                </td>
              </tr>

              <tr align="left">
                <td  rowspan="2"  >
                  Bank Name/Branch
                </td>
                <td rowspan="2">
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

            </table>
          </div>
          <div id="divCashDepositBody" style="margin:1;padding:0">
            <table border="1"  cellpadding="0.5" cellspacing="0.5" width="100%">
              <tr>
                <td  align="left">
                  Cash Closure Type
                </td>
                <td  align="left">
                  Cash Closure ID
                </td>
                <td  align="right">
                  Amount
                </td>
              </tr>
              <xsl:for-each select="Deposit/Body">
                <tr >
                  <td >
                    <xsl:value-of select="@UserName"/>

                  </td>
                  <td >
                    <xsl:value-of select="@ClosedFor"/>

                  </td>
                  <td align="right">
                    <xsl:value-of select="@AmountClosed"/>

                  </td>
                </tr>

              </xsl:for-each>
              <tr>
                <td align="right" colspan="2">
                  Total*

                </td>
                <td align="right">
                  <xsl:value-of select="Deposit/Header/@TotalAmount"/>
                </td>
              </tr>
              <tr>
                <td colspan="3"   >
                  Amount in words:


                  <xsl:value-of select="Deposit/Header/@TotalAmountText"/>
                </td>
              </tr>
              <tr>
                <td colspan="3" >

                  <xsl:value-of select="Deposit/Header/@Description"/>
                </td>
              </tr>
              <tr>
                <td  colspan="3" align="right"  >
                  <table border="1" cellpadding="0.5" cellspacing="0.5" width="50%">
                    <tr>
                      <th align="center">Denomination</th>
                      <th align="center">Nos*</th>
                      <th align="center">Rs P.</th>
                    </tr>
                   
                    <tr align="center">
                      <td>
                        1000
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        500
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        100
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        50
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        20
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        10
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                    </tr>
                    <tr align="center">
                      <td>
                        5
                      </td>
                      <td>
                        &#160;
                      </td>
                      <td>
                        &#160;
                      </td>
                      <tr align="center">
                        <td>
                          Coins
                        </td>
                        <td>
                          &#160;
                        </td>
                        <td>
                          &#160;
                        </td>
                      </tr>
                     
                    </tr>
                    <tr >
                      <th align="right" colspan="2">Total*</th>
                      <td align="right">

                        &#160;
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
                  <td align="left"  valign="bottom">Bank Receiving Stamp,Signature/date</td>
                  <td align="right" valign="bottom">Signature</td>
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
              </table>
            </div>
          </footer>

        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
