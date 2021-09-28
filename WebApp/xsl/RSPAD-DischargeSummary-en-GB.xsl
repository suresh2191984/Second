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
                                                <xsl:value-of select="DischargeSummary/src" />
                                            </xsl:attribute>
                                        </input>
                                    </td>
                                    <td align="left" nowrap="nowrap" Width="5%" valign ="bottom">
                                        <h6>
                                          <br/>
                                          <br/>
                                          <xsl:value-of select="DischargeSummary/OrgName"/> <br/>
                                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="DischargeSummary/Location"/>
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
                                                <td Width="40%" valign ="top" align="center" style="font-size:20px;">
                                                    <b> Discharge Summary </b >
                                                    <br/>
                                                </td>
                                                <td Width="40%">
                                                    <table>
                                                        <tr>
                                                            <td align="left">
                                                                <b>Patient Name</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="DischargeSummary/Name"/>
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
                                                                <xsl:value-of select="DischargeSummary/PatientNumber"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <b>DOB</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="DischargeSummary/DOB"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <b>Sex</b>
                                                            </td>
                                                            <td align="left">
                                                                :
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="DischargeSummary/Sex"/>
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
                                                                <b>Admission Date</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="DischargeSummary/AdmissionDate"/>
                                                            </td>
                                                            <td align="left">
                                                                <b>Discharge Date</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="DischargeSummary/DischargeDate"/>
                                                            </td>
                                                            <td align="left">
                                                                <b>Ward</b >
                                                                &#160;&#160;
                                                                : <xsl:value-of select="DischargeSummary/WardName"/>
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
                                    <td Width="40%">
                                        <b>1.Anamnesis</b >
                                    </td>
                                    <td>
                                        : <xsl:value-of select="DischargeSummary/Anamnesis"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>2.History Journey Diseases</b >
                                    </td>
                                    <td>
                                        : <xsl:value-of select="DischargeSummary/HospitalCourse"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>3.Patient Vitals</b >
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/PatientVitals"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>4.The discovery Clinic (LAB, X-ray, ETC)</b >
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/LabDetails"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>5.Primary Diagnosis</B>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/ICD10P"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>6.Secondary Diagnosis</B>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/ICD10S"/>
                                    </td>
                                </tr>                             
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>
                                            7.Medication During Hospital <br/>
                                            (Explain that once obtained during drug treatment,<br/>
                                             and is considered essential to note)
                                        </B>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/PRM"/>
                                    </td>
                                </tr>                               
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>8.Procedure</b>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/ProcedureDesc"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>9.Condition On Discharge</b>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/ConditionOnDischarge"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>10.Recommendation / Plan / Control Next</b>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/AdviceName"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>11.Reason of Discharge</b>
                                    </td>
                                    <td >
                                        : <xsl:value-of select="DischargeSummary/TypeOfDischarge"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <B>
                                            12.Home Therapy
                                        </B>
                                    </td>
                                </tr>
                                <tr>
                                    <td  colspan="2">
                                        <table Width="100%" Border="1" >
                                            <tr Style="Font-weight:bold;">
                                                <td>
                                                    Drug
                                                </td>
                                                <td>
                                                    Qty
                                                </td>
                                                <td>
                                                    Dose
                                                </td>
                                                <td>
                                                    Frequency
                                                </td>
                                                <td>
                                                    Instruction
                                                </td>
                                                <td>
                                                    DateTime
                                                </td>
                                            </tr>
                                            <xsl:for-each select="DischargeSummary/PatientPrescription">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="BrandName"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="Qty"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="Dose"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="DrugFrequency"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="Instruction"/>
                                                    </td>
                                                    <td>
                                                        <xsl:value-of select="CreatedAt"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" colspan="2" align="Right">
                                Date : <xsl:value-of select="DischargeSummary/DateNow"/> <br/>
                                Doctors who treat
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
