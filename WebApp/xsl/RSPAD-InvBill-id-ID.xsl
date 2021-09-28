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
                                                <td align="left" nowrap="nowrap">
                                                    <center>
                                                        <h5>
                                                            RSPAD GATOT SOEBROTO DITKESAD
                                                            <br/>
                                                            JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                                                            Telp.021-3441008,3840702, Fax : 021-3520619<br/>
                                                            INSTALASI FARMASI
                                                        </h5>
                                                    </center>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>                              
                                <tr>
                                    <td colspan="2" Width="100%">
                                        <table Width="100%">
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    # Tran :
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    :    <xsl:value-of select="OPBillFormat/BillNumber"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    Nama Pasien
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    : <xsl:value-of select="OPBillFormat/Name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    #Res
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    :    <xsl:value-of select="OPBillFormat/PrescriptionNumber"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    Nama Dokter
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    : <xsl:value-of select="OPBillFormat/PhysName"/>
                                                </td>
                                            </tr>
                                            <tr Width="100%">
                                                <td colspan="4" Width="100%">
                                                    <table Width="100%">
                                                        <tr>
                                                            <td colspan="4">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <xsl:for-each select="OPBillFormat/BillingDetails">
                                                            <tr>
                                                                <td align="left" nowrap="nowrap" colspan="2">
                                                                    <xsl:value-of select="FeeDescription" />
                                                                </td>
                                                                <td align="left" nowrap="nowrap" >
                                                                    <xsl:value-of select="Qty" />
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="NetAmount" />
                                                                </td>
                                                            </tr>
                                                        </xsl:for-each>
                                                        <tr>
                                                            <td colspan="4">
                                                                <hr/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" colspan="2">

                                                            </td>
                                                            <td align="right"  nowrap="nowrap">
                                                                Total :
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="OPBillFormat/NetAmount"/>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="4" align="right"  nowrap="nowrap">
                                                                <br/>Jakarta, <xsl:value-of select="OPBillFormat/CollectedDate"/>
                                                                <br/>Kasier<br/><br/>
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
