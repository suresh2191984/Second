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
                                    <U>LETTERS IN TREATMENT</U>
                                </h3>
                            </td >
                        </tr>
                        <tr Width="100%">
                            <td colspan="2" Width="100%">
                                <table Width="100%">
                                    <tr>
                                        <td nowrap="nowrap">Inserted into the room</td>
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
                                        <td  nowrap="nowrap">With the diagnosis fixed / temporary</td>
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
                                        <td nowrap="nowrap">Patient Name</td>
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
                                        <td  nowrap="nowrap">Sex</td>
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
                                        <td  nowrap="nowrap">Address</td>
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
                                        <td  nowrap="nowrap">Posted by</td>
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
                                        <td>
                                        </td>
                                        <td  align="left" nowrap="nowrap">
                                            Jakarta,----------------------------------------------<br />
                                            Physicians who enter.<br />
                                            Name            :   <xsl:value-of select="PatientAdmissionLetter/PhyscianName"/><br />
                                            Rank / Goals    :   <xsl:value-of select="PatientAdmissionLetter/Rank"/>

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
