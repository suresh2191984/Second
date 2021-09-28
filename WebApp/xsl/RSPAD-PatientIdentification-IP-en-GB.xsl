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
                                                    <xsl:value-of select="PatientIdentificationSheet/src" />
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
                                    <!--<tr>
                                        <td nowrap="nowrap" colspan="2">
                                            <hr/>
                                        </td>
                                    </tr>-->
                                </table>
                            </td >
                        </tr>
                        <tr  Width="100%">
                            <td align="center" nowrap="nowrap" colspan="2">
                                <h3>REGISTRATION IN PATIENT</h3>
                            </td >
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap" colspan="2">
                                <br/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table Width="100%">
                                    <tr>
                                        <td  nowrap="nowrap">Patient Name</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientName"/>
                                        </td>
                                        <td nowrap="nowrap">No.RM</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientNumber"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >DOB</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DOB"/>
                                        </td>
                                        <td  nowrap="nowrap" >Sex</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Gender"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Address</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Address"/>
                                        </td>
                                        <td  nowrap="nowrap">Landline No</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/TeleNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">Mobile No</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/MobileNo"/>
                                        </td>
                                        <td nowrap="nowrap">Qualification</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Qualification"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Race</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Race"/>
                                        </td>
                                        <td  nowrap="nowrap" >No.KTP/SIM/Pasport</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/URNNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Country</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Country"/>
                                        </td>
                                        <td  nowrap="nowrap" >Religion</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Religion "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Patient Status</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientStatus"/>
                                        </td>
                                        <td  nowrap="nowrap" >Marital Status</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/MaritalStatus  "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Occupation</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Occupation"/>
                                        </td>
                                        <td  nowrap="nowrap" >Corp</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Corp "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Designation</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Designation"/>
                                        </td>
                                        <td  nowrap="nowrap" >Field Army</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/FieldArmy "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Visit Date</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
                                        </td>
                                        <td  nowrap="nowrap" >Ratecard Name</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RateCardName "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Visit Time</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitTime "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Relation Name</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Relation Ship</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationShip "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Address</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelAddress"/>
                                        </td>
                                        <td  nowrap="nowrap" >Landline No</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelTelNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" ></td>
                                        <td  nowrap="nowrap" >

                                        </td>
                                        <td  nowrap="nowrap" >Mobile No</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelMobNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Disease ever suffered</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/HistOfDise"/>
                                        </td>
                                        <td  nowrap="nowrap" >Allergy Drugs</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Allergies "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Diagnosis in</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AdmissionDiagsName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Diagnosis Code In</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AdmissionICD10 "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Doctor Name</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/PrimaryDoctor"/>
                                        </td>
                                        <td  nowrap="nowrap" >Duration</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Duration "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Diagnosis Exit</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DischargeDiagsName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Diagnosis Code Exit</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DischargeICD10 "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Surgery Type</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/SurgeryType"/>
                                        </td>
                                        <td  nowrap="nowrap" >Surgery Name</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/SurgeryName "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Operation Time</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/OperationTime "/>
                                        </td>
                                        <td  nowrap="nowrap" >Types of Anesthesia</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AnestType "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Nosocomial infection</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Infeksi "/>
                                        </td>
                                        <td  nowrap="nowrap" >Cause Infection</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Penyebab "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Treatment Radiotherapy / Radionuclide</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RadiNuk "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Circumstances Exit</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Condition "/>
                                        </td>
                                        <td  nowrap="nowrap" >Get-out</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/TypeofDischarge "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="right" nowrap="nowrap">
                                            Jakarta,----------------------------------<br />
                                            Signature<br />
                                            <br />
                                            <br />
                                            <br />
                                            Doctors who treat
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Name of Company / Person in Charge Fees</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientName "/>
                                        </td>
                                        <td  nowrap="nowrap">Responsible Address Costs</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientAddress "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Landline No</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientLandLine "/>
                                        </td>
                                        <td  nowrap="nowrap">Insurance Number</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/InsuranceNumber "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Letter of Guarantee</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientReferrelForm "/>
                                        </td>
                                        <td  nowrap="nowrap">Contacted Specification</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientRemarks "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="right" nowrap="nowrap">
                                            Jakarta,----------------------------------<br />
                                            Signature<br />
                                            <br />
                                            <br />
                                            <br />
                                            Officer Min
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr >
                    </table >
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
