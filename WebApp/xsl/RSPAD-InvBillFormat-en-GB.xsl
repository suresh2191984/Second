<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">

    <!--<xsl:template match="Author">
    <xsl:value-of select="FirstName"/>
    <xsl:value-of select="LastName"/>
    <xsl:if test="position()!=last()">, </xsl:if>
	
	
    
  </xsl:template>-->
    <xsl:template match="/">
        <!--<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>-->
        <html>
            <body>
                <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="100%">
                    <tr>
                        <td colspan="2">
                            <table width="100%">
                                <tr>
                                    <td colspan="2"  align="center">
                                        <table width="40%">
                                            <tr>
                                                <td align="left" width="10%">
                                                    <input type="image" name="imagem">
                                                        <xsl:attribute name="src">
                                                            <xsl:value-of select="OPBillFormat/src" />
                                                        </xsl:attribute>
                                                    </input>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <center>
                                                        <h5>
                                                            RSPAD GATOT SOEBROTO DITKESAD
                                                            <br/>
                                                            JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                                                            Telp.021-3441008,3840702, Fax : 021-3520619
                                                        </h5>
                                                    </center>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr/>
                                    </td>
                                </tr>
                                <tr Width="100%">
                                    <td colspan="2" Width="100%" nowrap="nowrap">
                                        <center>
                                            <b>OUT PATIENT</b>
                                            <br/>
                                            Bill Number : <xsl:value-of select="OPBillFormat/BillNumber"/>
                                        </center>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" Width="100%">
                                        <table Width="100%">
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    COLLECTED FROM
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    :    <xsl:value-of select="OPBillFormat/PaymentCollectedFrom"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    PRESCRIPTION NUMBER
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    :    <xsl:value-of select="OPBillFormat/PrescriptionNumber"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    NO.RM
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    :  <xsl:value-of select="OPBillFormat/PatientNumber"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                 PATIENT STATUS    
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    : <xsl:value-of select="OPBillFormat/PatientStatus"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                  PATIENT NAME
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    : <xsl:value-of select="OPBillFormat/Name"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    DATE
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    : <xsl:value-of select="OPBillFormat/CreateDate"/>
                                                </td>
                                            </tr>
                                            <tr Width="100%">
                                                <td colspan="4" Width="100%">
                                                    <table>
                                                        <tr>
                                                            <td colspan="7">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="5%" nowrap="nowrap">
                                                                <B>NO</B>
                                                            </td>
                                                            <td align="left" width="10%" nowrap="nowrap">
                                                                <B>LOCATION</B>
                                                            </td>
                                                            <td align="left" width="10%" nowrap="nowrap">
                                                                <B>DATE</B>
                                                            </td>
                                                            <td align="left" width="40%" nowrap="nowrap">
                                                                <B>NAME OF DRUG</B>
                                                            </td>
                                                            <td align="right" width="10%" nowrap="nowrap">
                                                                <B>QTY</B>
                                                            </td>
                                                            <td align="right" width="10%" nowrap="nowrap">
                                                                <B>AMOUNT</B>
                                                            </td>
                                                            <td align="right" width="10%" nowrap="nowrap">
                                                                <B>TOTAL</B>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="7">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <xsl:for-each select="OPBillFormat/BillingDetails">
                                                            <tr>
                                                                <td align="left">
                                                                    <xsl:value-of select="No" />
                                                                </td>
                                                                <td align="left" nowrap="nowrap">
                                                                    <xsl:value-of select="FeeType" />
                                                                </td>
                                                                <td align="left" nowrap="nowrap">
                                                                    <xsl:value-of select="CreatedAt" />
                                                                </td>
                                                                <td align="left" nowrap="nowrap">
                                                                    <xsl:value-of select="FeeDescription" />
                                                                </td>                                                                
                                                                <td align="right" nowrap="nowrap" >
                                                                    <xsl:value-of select="Qty" />
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="Amount" />
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="NetAmount" />
                                                                </td>                                                        
                                                            </tr>
                                                        </xsl:for-each>
                                                        <tr>
                                                            <td colspan="7">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left">

                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                
                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                Gross Total :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/GrossAmount"/>
                                                            </td>
                                                        </tr>                                                      
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                              
                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                Deposit  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/Deposit "/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap"  colspan="3">
                                                                Be calculated  : <xsl:value-of select="OPBillFormat/AmountWord"/>
                                                            </td>
                                                            <td align="left" >
                                                              
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                               
                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Discount :
                                                            </td>
                                                            <td align="right">
                                                                 <xsl:value-of select="OPBillFormat/Discount"/>
                                                            </td>
                                                        </tr>
                                                        <!--<tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">

                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                Prepare Charges :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/PrepareCharges"/>
                                                            </td>
                                                        </tr>-->
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">

                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                Round -Off  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/Roundoff "/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                              
                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Net Amount   :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/NetAmount"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                              
                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Amount Received  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/AmountReceived"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">

                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Due    :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/Due"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">

                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                Amount Refund  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/AmountRefund "/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left" nowrap="nowrap">

                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                TPA Amount  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/TPAAmount "/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"  colspan="3">

                                                            </td>
                                                            <td align="left" >

                                                            </td>
                                                            <td align="left">
                                                              
                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Payment Mode  :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/PaymentMode"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td Colspan="7">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="7" align="right"  nowrap="nowrap">
                                                                Jakarta, <xsl:value-of select="OPBillFormat/CollectedDate"/>
                                                                <br/>Cashier<br/><br/>
                                                                <br/><br/>
                                                                (<xsl:value-of select="OPBillFormat/LoginName"/>)
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <br/>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
