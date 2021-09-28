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
                <table>
                    <tr>
                        <td colspan="2" class="a-left">
                            <table class="panelContent">
                                <tr>
                                    <td>
                                        1.&#160;Keluhan Utama
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" >
                                        <input type ="text" id="txtSymptoms" Class="small"
                                        style="height:25px;width:700PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        2.&#160;Riwayat Psikososial dan Spiritual
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkWorry" Name="Psychosocial" />Cemas
                                        &#160;&#160;<input type ="radio"  id="chkScary" Name="Psychosocial" />Takut
                                        &#160;&#160;<input type ="radio"  id="chkSad" Name="Psychosocial" />Sedih
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        3.&#160;Kebutuhan komunikasi dan edukasi
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkComNo" Name="Education" onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');"/>Tidak
                                        &#160;&#160;<input type ="radio"  id="chkComYes" Name="Education" onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');" />Ya,Jelaskan
                                        &#160;&#160;  <input type ="text" id="txtComExplain" Class="small"
                           onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');"
             style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        4.&#160;Risiko Jatuh
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkInjNo" Name="Injury" 
                                        onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');" />Tidak
                                        &#160;&#160;<input type ="radio"  id="chkInjYes" Name="Injury"
                             onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');"  />Ya,Jelaskan
                                        &#160;&#160;  <input type ="text" id="txtInjExplain" Class="small"
                                         onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');" 
             style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        5.&#160;Status Fungsional
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkFunIndependent" Name="Functional" />Mandiri
                                        <BR/><input type ="radio" id="chkFunNeedHelp" Name="Functional" />Perlu Bantuan,Sebutkan
                                        &#160;&#160;  <input type ="text" id="txtFunExplain" Class="small"
            style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        6.&#160;Skala Nyeri
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkPainLignt" Name="PainFul" />Nyeri Ringan
                                        <BR/><input type ="radio" id="chkPainMedium" Name="PainFul" />Nyeri Sedang
                                        <BR/><input type ="radio" id="chkPainHard" Name="PainFul" />Nyeri Berat
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        7.&#160;Skor Nyeri(0-10)&#160;<input type ="text" onKeyDown="return validatenumber(event);" id="txtPainScore"
                                                                      onblur="javascript:return doValidatePainScore(this);" Class="mini"  maxlength="2"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        8.&#160;Nutrisi
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &#160;&#160;a.&#160;Apakah Pasien Mengalami penurunan berat badan yang tidak diinginkan dalam 6 bulan terakhir?<br/>
                                        &#160;&#160;<input type ="radio"  id="chkNutANo" Name="NutritionA" onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');" />Tidak
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutANotSure" Name="NutritionA"  onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');"/>Tidak yakin
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutAYes" Name="NutritionA" onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');" />Ya,Jelaskan
                                        &#160;&#160;<input type ="text" id="txtNutExp" Class="small"
                 style="width:500PX;"/><BR/>
                                        &#160;&#160;b.&#160;Apakah asupan makan berkurang karena berkurangnya nafsu makan?<br/>
                                        &#160;&#160;<input type ="radio"  id="chkNutBNo" Name="NutritionB" />Tidak
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutBYes" Name="NutritionB" />Ya
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        9.&#160;Daftar Masalah Keperawatan Prioritasi
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" >
                                        &#160;&#160;a.&#160;Masalah Keperawatan <br/>
                                        &#160;&#160; <input type ="text" id="txtNursingProblem" Class="small"
                           style="height:25px;width:700PX;"/><br/>
                                        &#160;&#160;b.&#160;Tujuan Terukur <br/>
                                        &#160;&#160;<input type ="text" id="txtNursingMeassureable" Class="small"
                            style="height:25px;width:700PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr id="trAnamnesa" style="display:none;">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td>
                                                    Anamnesa Dokter
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type ="text" id="txtAnamnesa" Class="small"
                                                    style="height:25px;width:700PX;"/>
                                                </td>
                                            </tr>
                                        </table>
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
