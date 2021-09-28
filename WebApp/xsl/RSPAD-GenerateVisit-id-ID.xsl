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
                        <td colspan="2"  align="center">
                            <table width="40%">
                                <tr>
                                    <td align="left" width="10%">
                                        <input type="image" name="imagem">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="GenerateVisit/src" />
                                            </xsl:attribute>
                                        </input>
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <center>
                                            <h5>
                                                RSPAD GATOT SOEBROTO DITKESAD
                                                <br/>
                                                JL.Abdul Rahaman Saleh No.24,Jakarta Pusat<br/>
                                                Telp.021-3441008,3840702, Fax : 021-3520619<br/>
                                                <xsl:value-of select="GenerateVisit/Department"/> -    <xsl:value-of select="GenerateVisit/Speciality"/>

                                            </h5>

                                        </center>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"  align="center">
                            <table>
                                <tr>
                                    <td>No. Registrasi</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/VisitNo"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tanggal</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/VisitDate"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>No.RM</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/PatientNumber"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nama</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/PatientName"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td >Jenis Kunjungan</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/VisitType"/>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Tgl.Lahir / Umur</td>
                                    <td valign="top">
                                        :   <xsl:value-of select="GenerateVisit/Age"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <xsl:value-of select="GenerateVisit/Insurance"/>
                                    </td>
                                    <td align="left">
                                        :   <xsl:value-of select="GenerateVisit/InsuranceName"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        Jakarta,<xsl:value-of select="GenerateVisit/CurrentDate"/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        ( <xsl:value-of select="GenerateVisit/LoginName"/> )
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
