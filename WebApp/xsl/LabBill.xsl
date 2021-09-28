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
        <center id="centerLabBill">
          <table style="font-size:14px;font-family:verdana;border-collapse: separate;border-spacing: 2px;margin-top:50px;display:block;width:100%;">
            <tr>
              <td colspan="2" align="left">
                <table  style="font-size:14px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">
                  <tr>
                    <td>
                      <b style="font-size:14px;">
                        RUMAH SAKIT SANGLAH
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <b style="font-size:14px;">JI. KESEHATAN, DENPASAR</b>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <b style="font-size:14px;">Telp. (0361)227911-15</b>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <b style="font-size:14px;">Faks. (0361)224206</b>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <b>BUKTI TINDAKAN <xsl:value-of select="Lab/DeptName"/></b>
              </td>
            </tr>
            <tr>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td style="width:15%" nowrap="nowrap" >Kunjungan ID Pasien</td>
              <td>
                :<xsl:value-of select="Lab/PatientVisitID"/>
              </td>
            </tr>
            <tr>
              <td>Tanggal</td>
              <td>
                :<xsl:value-of select="Lab/CreatedAt"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">No Rekam Medik</td>
              <td>
                :<xsl:value-of select="Lab/MedicalRecordNo"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Nama Pasien</td>
              <td>
                <!--:<xsl:value-of select="Lab/Name"/>-->
                :<xsl:value-of select="substring-before( Lab/Name , '-' )"/><br/> 
                  <xsl:value-of select="substring-after( Lab/Name , '-' )"/>

              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Tgl Lahir / Umur</td>
              <td>
                :<xsl:value-of select="Lab/Age"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Jenis Kelamin</td>
              <td>
                :<xsl:value-of select="Lab/Sex"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Cara Bayar</td>
              <td>
                :<xsl:value-of select="Lab/Insurance"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Kunjungi Tujuan</td>
              <td>
                :<xsl:value-of select="Lab/KunjungiTujuan"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">Nama Poli</td>
              <td>
                :<xsl:value-of select="Lab/NamaPoli"/>
              </td>
            </tr>
			<tr>
				  <td  nowrap="nowrap">Nama Kamar</td>
				  <td>
					  :<xsl:value-of select="Lab/NamaKamar"/>
				  </td>
			</tr>
            <tr>
              <td>Dokter</td>
              <td>
                :<xsl:value-of select="Lab/Dokter"/>
              </td>
            </tr>
            <tr>
              <td  nowrap="nowrap">No.Telp Dokter</td>
              <td>
                :<xsl:value-of select="Lab/DokterPhNo"/>
              </td>
            </tr>
            <tr>
              <td>Diagnosa</td>
              <td>
                :<xsl:value-of select="Lab/Diagnosa"/>
              </td>
            </tr>
            <tr>
              <td>SampleID</td>
              <td>
                :<xsl:value-of select="Lab/SampleID"/>
              </td>
            </tr>
            <tr>
              <td colspan="2">____________________________________________________</td>
            </tr>
            <tr>
              <td colspan="2">
                <xsl:value-of select="Lab/ClinicName"/>
              </td>
            </tr>
            <tr>
              <td colspan="2">____________________________________________________</td>
            </tr>
            <xsl:for-each select="Lab/ClinicLab">
              <tr>
                <td>
                  <xsl:value-of select="*" />
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </center>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
