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
                                <h3>
                                    REGISTRATION <xsl:value-of select="PatientIdentificationSheet/PatientType"/> </h3>
                            </td >
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap" colspan="2">
                                <br/>
                            </td>
                        </tr>
                        <tr Width="100%">
                            <td colspan="2" Width="100%">
                                <table Width="100%">
                                    <tr>
                                        <td nowrap="nowrap">RM.NO</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/MedicalRecordNo"/>
                                        </td>
                                        <td  nowrap="nowrap">Patient Name</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientName"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Visit Date</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
                                        </td>
                                        <td  nowrap="nowrap">Visit Time</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitTime"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                            <b>IDENTITAS</b>
                                            <br/>
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Address</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Address"/>
                                        </td>
                                        <td  nowrap="nowrap">Landline</td>
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
                                        <td nowrap="nowrap">Mobile </td>
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
                                        <td  nowrap="nowrap" >Race </td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Race"/>
                                        </td>
                                        <td  nowrap="nowrap" >Martial Status</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/MartialStatus "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Nationality</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Nationality"/>
                                        </td>
                                        <td  nowrap="nowrap" >Group</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Group"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Position</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Position"/>
                                        </td>
                                        <td  nowrap="nowrap" >Employee No</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/EmployeeNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">Corps</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Corps"/>
                                        </td>
                                        <td nowrap="nowrap">Field Army </td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/FieldArea"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                            <b>ORANG TERDEKAT</b>
                                            <br/>
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Name</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationName"/>
                                        </td>
                                        <td  nowrap="nowrap">RelationShip</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationShip"/>
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
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelAddress"/>
                                        </td>
                                        <td  nowrap="nowrap">Landline No</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelTelNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Mobile No</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelMobNo"/>
                                        </td>
                                        <td  nowrap="nowrap">Office No</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelOffNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                            <b>PERHATIAN KHUSUS</b>
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            Allergy Drugs
                                        </td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/AlergiYesNo"/>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            Yes, Means Description
                                        </td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Allergies"/>
                                        </td>
                                    </tr >
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" nowrap="nowrap">Disease ever suffered</td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            <xsl:value-of select="PatientIdentificationSheet/HistOfDise"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right" nowrap="nowrap">
                                Jakarta,----------------------------------------------------<br />
                                Signature<br />
                                <br />
                                <br />
                                <br />
                                Officer Min Patients
                            </td>
                        </tr>
                    </table>
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
