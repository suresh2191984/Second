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
				<div id="divContainer" style="margin-top:131px;">         
          <h2 align="center" style="line-height:0%">Rumah Sakit Sanglah</h2>
					<h3 align="center" style="line-height:0%">BUKTI REGISTRASI MASUK</h3>
					<h3 align="center" style="line-height:0%"><xsl:value-of select="GenerateVisit/Department"/></h3>
          <h3 align="center" style="line-height:0%">
            <xsl:value-of select="GenerateVisit/VisitPurpose"/> - <xsl:value-of select="GenerateVisit/Speciality"/>
          </h3>
          <div id="div0" style="margin:0;padding:0">
            <table width="100%" style="font-size:16px;border-top: 1px solid black;">
              <tr>
                <td>No. Registrasi</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/VisitNo"/>
                </td>
              </tr>
              <tr>
                <td>Tanggal</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/VisitDate"/>
                </td>
              </tr>
              <tr>
                <td>No. Urut</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/SerialNo"/>
                </td>
              </tr>
              <tr>
                <td>No. Rekam Medik</td>
                <td valign="top" style="font-family:verdana;font-size:20px;">
                  :<xsl:value-of select="GenerateVisit/MediacalRecordNo"/>
                </td>
              </tr>
              <tr>
                <td>Nama</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/PatientName"/>
                </td>
              </tr>
              <tr>
                <td >VisitType</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/VisitType"/>
                </td>

              </tr>
              <tr>
                <td>Tgl.Lahir / Umur</td>
                <td valign="top">
                  :<xsl:value-of select="GenerateVisit/Age"/>
                </td>
              </tr>
              <tr>
                <td style="width:25%">
                    <xsl:value-of select="GenerateVisit/Insurance"/>
                </td>
                <td align="left" style="width:75%">
                    :<xsl:value-of select="GenerateVisit/InsuranceName"/>
                </td>
              </tr>
<tr>
                <td >No.Peserta</td>
                <td>
                  :<xsl:value-of select="GenerateVisit/PolicyNo"/>
                </td>

              </tr>

            </table>
          </div>
					<div id="div2" style="margin-top:20px;">
						<table width="100%" style="font-size:18px;border-spacing:1px;">
						<tr>
							<td colspan="2">____________________________________________________________</td>
						</tr>

						<tr>
							<td colspan="2">TINDAKAN / PEMERIKSAAN<span style="padding-left:60px;">
								<xsl:value-of select="GenerateVisit/LoginName"/>
							</span></td>
						</tr>

						<tr>
							<td colspan="2">____________________________________________________________</td>
						</tr>

						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
              <td align="center">
                Denpasar,<xsl:value-of select="GenerateVisit/CurrentDate"/>
              </td>
            </tr>
             <tr>
							<td align="center" style="padding-top:60px;">
								 <u>( <xsl:value-of select="GenerateVisit/LoginName"/> )</u>
							</td>
						</tr>
					</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
