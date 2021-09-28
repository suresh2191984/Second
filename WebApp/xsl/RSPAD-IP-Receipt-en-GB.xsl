<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
    <xsl:template match="/">
        <html>
            <body>
                <div id="divContainer" style="font-size:20px;border-top: 1px solid black;margin-top:0px;">
                    <table class="w-40p">
                        <tr>
                            <td>
                                <center>
                                    <input type="image" name="imagem">
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="OpReceipt/src" />
                                        </xsl:attribute>
                                    </input>
                                </center>
                            </td>
                            <td nowrap="nowrap">
                                <center>
                                    <h5>
                                        RSPAD GATOT SOEBROTO DITKESAD<br/>
                                        JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                                        Telp:(021)3441008,3840702, Fax : (021)3520619
                                    </h5>
                                </center>
                            </td>
                        </tr>
                    </table>                  
                    <h1 align="center"  style="font-size:20px;border-top: 1px solid black;margin-top:0px;">
                        <b>Receipt</b>
                    </h1>                    
                    <div id="div0" style="margin:0;padding:0">
                        <table width="100%" style="font-size:20px;border-top: 1px solid black;">
                            <tr>
                                <td>No.Receipt</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/ReceptNo"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Payment Collected From</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/PaymentCollectedFrom"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Patient Name</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/PatientName"/>
                                </td>
                            </tr>
                            <tr>
                                <td>No.RM</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/PatientNumber"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Client Name</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/TPAName"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Amount in Words</td>
                                <td>:</td>
                                <td valign="top">
                                    <xsl:value-of select="OpReceipt/AmountinWords"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Payment</td>
                                <td>:</td>
                                <td valign="top">
                                    Patient payment start date <xsl:value-of select="OpReceipt/DOA"/> to  <xsl:value-of select="OpReceipt/DOD"/>
                                </td>
                            </tr>
                            <tr>
                                <td Colspan="3" style ="padding-left:50px">
                                    <br />
                                    <br />
                                    <table Border="1">
                                        <tr>
                                            <td >                                                                                            
                                                Rp. <xsl:value-of select="OpReceipt/AmountReceived"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table align="right" style="font-size:20px;">
                            <tr>

                                <td align="right" colspan="2">
                                    Jakarta, <xsl:value-of select="OpReceipt/CurrentDate"></xsl:value-of> <br/>                                    
                                </td>

                            </tr>
                            <tr>

                                <td align="Center" colspan="2">                                    
                                    Receiver
                                </td>

                            </tr>
                            <tr>

                                <td align="Center" colspan="2">
                                    <br/>
                                    <br/>
                                    <br/>                                   
                                    (<xsl:value-of select="OpReceipt/LoginName"/>)
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="Center">
                                    Cashier
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
