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

                <table style="font-size:10px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="30%">

                    <tr>
                        <td align="center">
                            <table width="40%">
                                <tr>
                                    <td align="left" width="10%">
                                        <input type="image" name="imagem">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="OPBillFormat/src" />
                                            </xsl:attribute>
                                        </input>
                                    </td>
                                    <td  style="font-size:10px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" align="left" nowrap="nowrap">
                                        <center>
                                            <h5>
                                                RSPAD GATOT SOEBROTO DITKESAD
                                                <br/>
                                                JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                                                Telp.021-3441008,3840702, Fax : 021-3520619<br/>                                               

                                            </h5>

                                        </center>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%">
                            <hr></hr>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table>
                                <tr>
                                    <td>
                                        <b>
                                            TAGIHAN PASIEN RAWAT JALAN
                                        </b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <br/>
                        </td>
                    </tr>
                    <tr>
                        <td  align="center">
                            <table width="100%">
                                <tr>
                                    <td>No.RM</td>
                                    <td valign="top" >
                                        :   <xsl:value-of select="OPBillFormat/PatientNumber"/>
                                    </td>

                                    <td>TANGGAL</td>
                                    <td valign="top" >
                                        :   <xsl:value-of select="OPBillFormat/VisitDate"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>NAMA</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="OPBillFormat/PatientName"/>
                                    </td>
                                    <td>JENIS PASIEN</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="OPBillFormat/ClientName"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br/>
                        </td>
                    </tr>
                    <tr>
                        <td  align="center">
                            <table width="100%">
                                <tr>
                                    <td> No</td>
                                    <td> Nama Tindakan</td>                                    
                                    <td> Biaya</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <hr></hr>
                                    </td>
                                </tr>
                                <xsl:for-each select="OPBillFormat/Items">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="SNo" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="Item" />
                                        </td>                                       
                                        <td>
                                            <xsl:value-of select="Amount" />
                                        </td>
                                    </tr>                               
                                </xsl:for-each>
                                <tr>
                                    <td colspan="3">
                                        <hr></hr>
                                    </td>
                                </tr>

                                <tr>
                                    <td>

                                    </td>
                                    <td align="left">

                                        Total Biaya

                                    </td>
                                    <td valign="top">

                                        <xsl:value-of select="OPBillFormat/TotalAmount"/>

                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                    </td>
                                    <td  align="left">

                                        Biaya Administrasi

                                    </td>
                                    <td valign="top">

                                        <xsl:value-of select="OPBillFormat/AdministrativeCharges"/>

                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                    </td>
                                    <td  align="left">
                                        TAGIHAN

                                    </td>
                                    <td valign="top">

                                        <xsl:value-of select="OPBillFormat/NetAmount"/>

                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" colspan="2" align="left">
                                        Jakarta ,
                                        <xsl:value-of select="OPBillFormat/VisitDate"/>

                                    </td>

                                </tr>
                                <tr>
                                    <td valign="top" colspan="2" align="center">
                                            Kasir
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" colspan="2" align="left">
                                        <br />
                                        <br />
                                        <br />
                                        <br />                                       
                                        (.....................)
                                    </td>
                                </tr>
                            </table>

                        </td>

                    </tr>              

                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
