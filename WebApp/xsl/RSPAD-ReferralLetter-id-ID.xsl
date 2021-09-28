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
                                                    <xsl:value-of select="ReferralLetter/src" />
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
                                    LEMBAR KONSULTASI
                                </h3>
                            </td >
                        </tr>
                        <tr Width="100%">
                            <td colspan="2" Width="100%">
                                <table Width="100%">
                                    <tr>
                                        <td nowrap="nowrap">NAMA</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="ReferralLetter/Name" />
                                        </td>
                                        <td nowrap="nowrap">Tgl Lahir</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="ReferralLetter/DOB" />
                                        </td>
                                        <td nowrap="nowrap">Nomor Rekam Medis</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="ReferralLetter/PatientNumber" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" Width="100%" align="left">
                                            <table Width="100%">
                                                <tr>

                                                    <td nowrap="nowrap">Konsultasi kepada</td>
                                                    <td  nowrap="nowrap">
                                                        :  <input type ="text" id="txtRefPhysicanname" />
                                                    </td>
                                                    <td nowrap="nowrap">Dari</td>
                                                    <td  nowrap="nowrap">
                                                        :   <input type ="text" id="txtPhysicanname" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="left" Width="100%">
                                            <table Width="100%">
                                                <tr>
                                                    <td colspan="2">
                                                        PERMINTAAN KONSULTASI
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2">
                                                        Teman Sejawat Yth,<br/>
                                                        &#160;&#160;&#160;&#160;Sudilah kiranya memeriksa dan mengobati pasien(nama tersebut diatas) dengan kemungkinan/sangkaan

                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2">
                                                        1.Di bagian kami pasien ini diobati untuk<br/><br/>
                                                        <input type ="text" id="txtFood" style="height:25px;width:700PX;"/><br/>
                                                        Telah ditemukan kelainan-kelainan dan keadaan pasien saat ini<br/>
                                                        <input type ="text" id="txtAbnormalities" style="height:25px;width:700PX;"/>
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2">
                                                        2.Pengobatan yang telah dilakukan <br/>
                                                        <input type ="text" id="txtTreatment"  style="height:25px;width:700PX;"/>
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2">
                                                        3.Mohon perhatian khusus terhadap <br/>
                                                        <input type ="text" id="txtAttention" style="height:25px;width:700PX;"/>
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2">
                                                        4.Mohon nasehat selanjutnya <br/>
                                                        Atas bantuannya,diucapkan terima kasih
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td>
                                                        Kepala Departemen
                                                    </td>
                                                    <td>
                                                        Tanggal :  <xsl:value-of select="ReferralLetter/Date" /> <br/>
                                                        Dokter yang mengirim :
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td>
                                                        dr. <input type ="text" id="txtdr3" />
                                                    </td>
                                                    <td>
                                                        dr. <input type ="text" id="txtdr4" />
                                                    </td>
                                                </tr>
                                                <td colspan="2" align="center">
                                                    <br/>
                                                </td>
                                                <tr>
                                                    <td colspan="2" align="center">
                                                        Mengetahui/Menyetujui<BR/>
                                                        KEPALA RSPAD GATOT SOEBROTO<BR/><BR/><BR/>
                                                        dr. <input type ="text" id="txtdr5" />
                                                    </td>
                                                </tr>
                                            </table>
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
