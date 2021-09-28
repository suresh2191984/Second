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
        <div style="font-size:20px;">
          <table width="100%">
            <tr>
              <td valign="top" style="width:100%" align="left">
                <table>
                  <tr>
                    <td width="60%">
                      <input type="image" style="height:80px;" name="imagem">
                        <xsl:attribute name="src">
                          <xsl:value-of select="GenerateVisit/HeaderLogo"/>
                        </xsl:attribute>
                      </input>
                    </td>
                    <td align="a-left">
                      SURAT ELIGIBILITAS PESERTA <br/>
                      <xsl:value-of select="GenerateVisit/OrgName"/>  <xsl:value-of select="GenerateVisit/Location"/> 
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <table align="center" style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="100%">
            <tr>
              <td style="width:50%" align="left">
                <table width="100%">
                  <tr>
                    <td style="width:27%">SEP No</td>
                    <td style="width:1%">:</td>
                    <td valign="top">
                      <b>
                        <xsl:value-of select="GenerateVisit/SEPNo"/>
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td>SEP Date</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/VisitDate"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Policy No
                    </td>
                    <td>:</td>
                    <td align="left">
                      <b>
                        <xsl:value-of select="GenerateVisit/InsuranceNo"/>
                      </b> 
                    </td>
                  </tr>
                  <tr>
                    <td>
                      No.RM
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/PatientNumber"/>
                    </td>
                  </tr>
                  <tr>
                    <td>Patient Name</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/PatientName"/>
                    </td>
                  </tr>
                  <tr>
                    <td>DOB</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/DOB"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Gender
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/Sex"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Department Name
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/EmpDeptCode"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Refferal Hospital
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/RefferalName"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Primary Diagnose
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/ICD10"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Note
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/Accident"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Print
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/Print"/>
                    </td>
                  </tr>
                  <tr style="display:none;">
                    <td>
                      Accident
                    </td>
                    <td>:</td>
                    <td align="left">
                      <xsl:value-of select="GenerateVisit/Remarks"/>
                    </td>
                  </tr>
                </table>
              </td>
              <td style="width:50%">
                <table width="100%">
                  <tr>
                    <td style="width:16%">BPJS Type</td>
                    <td style="width:1%">:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/ClientName"/>
                    </td>
                  </tr>
                  <tr>
                    <td>COB</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/COB"/>
                    </td>
                  </tr>
                  <tr>
                    <td>Visit Type</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/VisitType"/>
                    </td>
                  </tr>
                  <tr>
                    <td>Rate Card</td>
                    <td>:</td>
                    <td valign="top">
                      <xsl:value-of select="GenerateVisit/RateCard"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="3">
                      <span style="float:Left">Pasien/Keluarga&#160;Pasien</span>
                      <span style="float:Left;padding-left:10%">Petugas&#160;BPJS&#160;Kesehatan</span>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <table width="100%">
            <tr>
              <td>*Saya&#160;menyetujui&#160;BPJS&#160;kesehatan&#160;mengunakan&#160;informasi&#160;Medis&#160;Pasien&#160;Jika&#160;diperlukan.</td>
            </tr>
            <tr>
              <td>*SEP&#160;bukan&#160;sebagai&#160;bukti&#160;penjaminan&#160;peserta.</td>
              <td rowspan="2">
                _____________________________&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;_____________________________
              </td>
            </tr>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
