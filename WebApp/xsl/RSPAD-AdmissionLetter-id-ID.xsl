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
                <center>
                    <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">
                        <tr Width="100%">
                            <td nowrap="nowrap" colspan="2">
                                <table Width="20%">
                                    <tr>
                                        <td align="left" width="5%" valign ="top">
                                            <input type="image" name="imagem">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="PatientAdmissionLetter/src" />
                                                </xsl:attribute>
                                            </input>
                                        </td>
                                        <td align="left" nowrap="nowrap" Width="5%" valign ="bottom">
                                            <h6>
                                                <br/>
                                                <br/>
                                                DIREKTORAT KESEHATAN ANGKATAN DARAT  <br/>
                                                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;RSPAD GATOT SOEBROTO
                                                <hr/>
                                            </h6>

                                        </td>
                                    </tr>
                                </table>
                            </td >
                        </tr>
                        <tr  Width="100%">
                            <td align="center" nowrap="nowrap" colspan="2">
                                <h3>
                                    <U>SURAT MASUK PERAWATAN</U>
                                </h3>
                            </td >
                        </tr>                        
                        <tr Width="100%">
                            <td colspan="2" Width="100%">
                                <table Width="100%">
                                    <tr>
                                        <td nowrap="nowrap">Dimasukkan ke ruangan</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/Ward" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Dengan diagnosa tetap/sementara</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/ICDCODE10"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">Name Pasien</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/Name" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Jenis Kelamin</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/Sex"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Alamat</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/Address"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Dikirim Oleh</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientAdmissionLetter/SentBy"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>                                    
                                        <td  align="left" nowrap="nowrap">
                                            Jakarta,--------------------------------------<br />
                                            Dokter yang memasukkan,<br />
                                            Nama        :   <xsl:value-of select="PatientAdmissionLetter/PhyscianName"/><br />
                                            Pangkat/Gol :   <xsl:value-of select="PatientAdmissionLetter/Rank"/>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                    </table>
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
