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
        <html >
            <body>
                <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" class="dataheaderInvCtrl" Width="100%">
                    <tr Width="100%">
                        <td nowrap="nowrap" colspan="2">
                            <table Width="20%">
                                <tr>
                                    <td align="left" width="5%" valign ="top">
                                        <input type="image" name="imagem">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="CaseSheet/src" />
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
                    <tr width="100%">
                        <td colspan="2" align="left" width="100%">
                            <table width="100%">
                                <tr>
                                    <td align="center" colspan="2" width="100%">
                                        <table width="100%" border="1">
                                            <tr>
                                                <td Width="40%" valign ="top" style="font-size:20px;">
                                                    <b> CATATAN PERKEMBANGAN PASIEN TERINTEGRASI </b >
                                                    <br/>
                                                </td>
                                                <td Width="40%">
                                                    <table>
                                                        <tr>
                                                            <td align="left">
                                                                <b>Nama Pasien</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="CaseSheet/Name"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <b>NO.RM</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="CaseSheet/PatientNumber"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <b>Tanggal Lahir</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="CaseSheet/DOB"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <b>Jenis Kelamin</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="CaseSheet/Sex"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" width="100%">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <b> Tanggal Kunjungan</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="CaseSheet/VisitDate"/>
                                                            </td>
                                                            <td align="left">
                                                                <b>Jam</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="CaseSheet/VisitTime"/>
                                                            </td>
                                                            <td align="left">
                                                                <b>Ruangan/Poliklink</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="CaseSheet/SpecialityName"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                              <tr>
                                <td>
                                  <br/>
                                  <br/>
                                </td>
                              </tr>
                              <tr>
                                <td>

                                  <input type="image" name="imagBefore" Id="imagBefore">
                                    <xsl:attribute name="src">
                                      <xsl:if test="CaseSheet/Before!=''">
                                        <xsl:value-of select="CaseSheet/Before" />
                                      </xsl:if>
                                    </xsl:attribute>
                                  </input>

                                </td>
                                <td>

                                  <input type="image" name="imagAfter" Id="imagAfter">
                                    <xsl:attribute name="src">
                                      <xsl:if test="CaseSheet/After!=''">
                                        <xsl:value-of select="CaseSheet/After" />
                                      </xsl:if>
                                    </xsl:attribute>

                                  </input>

                                </td>
                              </tr>


                              <tr>
                                    <td>
                                        <br/>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b> Nama Dokter</b >
                                    </td>
                                    <td>
                                        : <xsl:value-of select="CaseSheet/Physician"/>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>ICD 10</B>
                                    </td>
                                </tr>
                                <tr>
                                    <td  colspan="2">
                                        <table>
                                            <xsl:for-each select="CaseSheet/ICD10">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="NO"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="ICDDescription"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Tindakan</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <xsl:for-each select="CaseSheet/ICD9">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="NO"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="Procedure"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>Pemeriksaan Penunjang</B>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <xsl:for-each select="CaseSheet/Investigation">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="NO"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="InvestigationName"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>   Tindakan Gawat Darurat dan General Bill Item</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <xsl:for-each select="CaseSheet/GeneralBillItem">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="NO"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="GeneralBillItemName"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td>
                                                    <B>
                                                        NO.Resep : <xsl:value-of select="CaseSheet/PrescriptionNumber"/>
                                                    </B>
                                                </td>
                                            </tr>
                                        </table >
                                    </td >
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table>
                                            <xsl:for-each select="CaseSheet/Prescription">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="NO"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="Formulation"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="BrandName"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="Dose"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="DrugFrequency"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="Duration"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="Direction"/>
                                                    </td>
                                                    <td>
                                                        &#160;&#160;<xsl:value-of select="Instruction"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr Style="display:none;">
                                    <td colspan="2">
                                        <B>Hasil Pemeriksaan,Analisa,Rencana,Penatalaksanaan Pasien</B>
                                    </td>
                                </tr>
                                <tr  Style="display:none;">
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr  Style="display:none;">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td>
                                                    <B>Subject(S)</B>
                                                </td>
                                                <td>
                                                    : <xsl:value-of select="CaseSheet/Subject"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <B>Object(O)</B>
                                                </td>
                                                <td>
                                                    : <xsl:value-of select="CaseSheet/Object"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Assessment(A)</b>
                                                </td>
                                                <td>
                                                    : <xsl:value-of select="CaseSheet/Assigment"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Planning(P)</b>
                                                </td>
                                                <td>
                                                    : <xsl:value-of select="CaseSheet/Planning"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table >
                        </td>
                    </tr>                    
                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
