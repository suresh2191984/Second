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
                    <table Width="100%" cellpadding="0" cellspacing="0" style="font-size:12px;font-family:verdana;">
                        <tr Width="100%">
                            <td nowrap="nowrap" colspan="2">
                                <table cellpadding="0" cellspacing="0" Width="20%">
                                    <tr>
                                        <td align="left" width="5%" valign ="top">
                                            <input type="image" name="imagem">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="Surgery/src" />
                                                </xsl:attribute>
                                            </input>
                                        </td>
                                        <td align="left" nowrap="nowrap" Width="5%" valign ="bottom">
                                            <h6>
                                                <br/>
                                                <br/>
                                              <xsl:value-of select="CaseSheet/OrgName"/> <br/>
                                              &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="CaseSheet/Location"/>
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
                                    LAPORAN PEMBEDAHAN
                                </h3>
                            </td >
                        </tr>
                        <tr Width="100%">
                            <td colspan="2" Width="100%">
                                <table cellpadding="0" cellspacing="0" Width="100%" border="1">
                                    <tr>
                                        <td nowrap="nowrap" align="left">Nama</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/Name" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> Jenis Kelamin</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/Sex" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> Umur</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/Age" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> No.RM</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/PatientNumber" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left">Tindakan Pembedahan</td>
                                        <td  nowrap="nowrap" align="left" colspan="7">
                                            :   <xsl:value-of select="Surgery/IPTreatmentPlanName" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Ahli Bedah</td>
                                        <td  nowrap="nowrap" align="left" colspan="7">
                                            :   <xsl:value-of select="Surgery/CheifSug" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Asisten Bedah</td>
                                        <td  nowrap="nowrap" colspan="7" align="left">
                                            :   <xsl:value-of select="Surgery/AssSug" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left">Tindakan(ICD 9)</td>
                                        <td  nowrap="nowrap" align="left" colspan="7">
                                            :   <xsl:value-of select="Surgery/ProcedureName" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Diagnosa(ICD 10)</td>
                                        <td  nowrap="nowrap" colspan="5" align="left">
                                            :   <xsl:value-of select="Surgery/Diagnosis" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> Macam Pembedahan</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/OperationType" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Diagnosa Pra Bedah</td>
                                        <td  style="word-break:break-all"  align="left" colspan="7">
                                            : <xsl:value-of select="Surgery/PreOperativeFindings" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Diagonsa Pasca Bedah</td>
                                        <td  style="word-break:break-all" align="left" colspan="7">
                                            :   <xsl:value-of select="Surgery/PostOperativeFindings " />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="left"> Ahli Bius</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/Anesthetist" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> Type Anesthesia</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/AnesthesiaType" />
                                        </td>
                                        <td nowrap="nowrap" align="left"> Lama Pembedahan</td>
                                        <td  nowrap="nowrap" align="left">
                                            :   <xsl:value-of select="Surgery/Duration" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="Left">
                                            <table Width="100%">
                                                <tr>
                                                    <td nowrap="nowrap" align="left"> Mulai</td>
                                                    <td  nowrap="nowrap" align="left">
                                                        :   <xsl:value-of select="Surgery/FromTime" />
                                                    </td>
                                                    <td nowrap="nowrap" align="left"> Selesai</td>
                                                    <td  nowrap="nowrap" align="left">
                                                        :   <xsl:value-of select="Surgery/ToTime" />
                                                    </td>
                                                    <td nowrap="nowrap" align="left"> Posisi Pasien</td>
                                                    <td  nowrap="nowrap" colspan="2" align="left" >
                                                        :   <xsl:value-of select="Surgery/Position" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap" align="left">Status</td>
                                                    <td  nowrap="nowrap" align="left">
                                                        :   <xsl:value-of select="Surgery/BodyStatus" />
                                                    </td>
                                                    <td nowrap="nowrap" align="left"> Result</td>
                                                    <td  nowrap="nowrap" align="left">
                                                        :   <xsl:value-of select="Surgery/Result" />
                                                    </td>
                                                    <td nowrap="nowrap" align="left"> Remarks</td>
                                                    <td  nowrap="nowrap" colspan="2" align="left" >
                                                        :   <xsl:value-of select="Surgery/Remarks" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="8" align="center">
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                            <br/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td  nowrap="nowrap" colspan="4" align="Left">
                                            Jaringan dikirim ke Patologi : <xsl:value-of select="Surgery/IsSample" /> <br/>
                                        </td >
                                        <td  nowrap="nowrap" colspan="4" align="Right">
                                            Ahli Bedah
                                        </td >
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" colspan="4" align="Left">
                                           Asal Jaringan : <xsl:value-of select="Surgery/SampleFrom" /> <br/>
                                        </td >
                                        <td  nowrap="nowrap" colspan="4" align="Right">
                                            Nama jelas:Prof/DR/Dr. <xsl:value-of select="Surgery/CheifSug" /> <br/>
                                        </td >
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" colspan="6" align="Right">
                                            Pangkat/Gol :<br/>
                                            NRP/NBI/NIP :<br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" colspan="8" align="Right">
                                            Rev.I/2012/RM-019/RI
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
