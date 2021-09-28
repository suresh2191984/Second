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
                <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" class="dataheaderInvCtrl" Width="100%">
                    <tr Width="100%">
                        <td nowrap="nowrap" colspan="2" Width="100%">
                            <table Width="20%">
                                <tr>
                                    <td align="left" width="5%" valign ="top">
                                        <input type="image" name="imagem">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="Capture/src" />
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
                    <tr width="100%">
                        <td colspan="2" align="left" Width="100%">
                            <table width="100%" Border="1">
                                <tr>
                                    <td Width="40%" valign ="top" style="font-size:20px;">
                                        <b> PRELIMINARY ASSESSMENT OF OUTPATIENT NURSING (General) </b >
                                        <br/>
                                    </td>
                                    <td Width="60%">
                                        <table Width="100%">
                                            <tr>
                                                <td align="left">
                                                    Name                                                     
                                                </td>
                                                <td>
                                                :</td>
                                                <td>
                                                    <xsl:value-of select="Capture/Name"/>
                                                </td>
                                            </tr><tr>
                                                <td align="left">
                                                    UHID
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <xsl:value-of select="Capture/PatientNumber"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    DOB
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <xsl:value-of select="Capture/DOB"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Sex
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <xsl:value-of select="Capture/Sex"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <table width="100%">
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    <b> Visit Date</b >
                                                    &#160;&#160;
                                                    : <xsl:value-of select="Capture/VisitDate"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <b>Visit Time</b >
                                                    &#160;&#160;
                                                    : <xsl:value-of select="Capture/VisitTime"/>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <b>Speciality</b >
                                                    &#160;&#160;
                                                    : <xsl:value-of select="Capture/SpecialityName"/>
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
                        </td >
                    </tr>
                    <tr width="100%">
                        <td colspan="2" align="left" Width="100%">
                            <table width="100%">
                                <tr>
                                    <td colspan="3" align="left">
                                        <b>1. &#160;Vitals</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left">
                                        <table>
                                            <tr>
                                                <td align="left">
                                                    Temp
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/Temp"/>
                                                </td>
                                                <td align="left">
                                                    Pluse
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/Pluse"/>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Height
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/Height"/>
                                                </td>
                                                <td align="left">
                                                    Weight
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/Weight"/>
                                                </td>
                                                <td align="left">
                                                    BMI
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/BMI"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    SpO2
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/SpO2"/>
                                                </td>
                                                <td align="left">
                                                    RR
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/RR"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Weist Circ
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/WeistCirc"/>
                                                </td>
                                                <td align="left">
                                                    Hip
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                     <xsl:value-of select="Capture/Hip"/>
                                                </td>
                                                <td align="left">
                                                    Ratio
                                                </td>
                                                <td>:</td>
                                                <td align="left">
                                                    <xsl:value-of select="Capture/HIPValue"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="left">
                                        <b>2. &#160;Blood Pressure</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/SBP"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td align="left">
                                        <b>3. &#160;Symptoms</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/Symptoms"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td align="left">
                                        <b>4. &#160;Psychosocial and Spiritual History</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/PSO"/>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td align="left">
                                        <b>5. &#160;Communication and Education Demand</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/Education"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td align="left">
                                        <b>6. &#160;Injury / Fall risk</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/Injury"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td align="left">
                                        <b>7. &#160;Functional Status</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/StatusFunction"/>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td align="left">
                                        <b>8. &#160;PainFul Scale</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/PainLevel"/>
                                    </td>
                                </tr>                              
                                <tr>
                                    <td align="left">
                                        <b>9. &#160;Pain Score(0-10)</b>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td align="left" >
                                        <xsl:value-of select="Capture/PainScore"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td align="left" colspan="3" >
                                        <b>10. &#160;Nutrition</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left">
                                        &#160;&#160;&#160;a.&#160; Did the Patient have a weight decreasing in past 6 Month?&#160;<xsl:value-of select="Capture/NurA"/><br/>
                                        &#160;&#160;&#160;a.&#160; Is the patient have lost appetite because the appetite was decreasing?&#160;<xsl:value-of select="Capture/NurB"/><br/>
                                    </td >
                                </tr>                               
                                <tr>
                                    <td align="left" colspan="3" >
                                        <b>11. &#160;List of Nursing Priority Problem</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="left">
                                        &#160;&#160;&#160;a.&#160; Nursing Problem <br/><xsl:value-of select="Capture/NurseA"/><br/>
                                        &#160;&#160;&#160;a.&#160; Meassureable Goals <br/><xsl:value-of select="Capture/NurseB"/><br/>
                                    </td >
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" colspan="2" align="Right">
                            Date____________Time_______<BR/>
                            &#160;Nurses Conducting Assessment&#160;<BR/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            (________________________________)
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" colspan="2" align="Right">
                            REV.II/II/2014/RM-002/RJ
                        </td >
                    </tr>
                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
