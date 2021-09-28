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

        <table style="font-size:10px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="30%">

          <tr>
            <td align="center">
              <table width="40%">
                <tr>
                  <td align="left" width="10%">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="GenerateVisit/src" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td  style="font-size:10px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" align="left" nowrap="nowrap">
                    <center>
                      <h5>
                        RSPAD GATOT SOEBROTO DITKESAD
                        <br/>
                        JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                        Telp.021-3441008,3840702, Fax : 021-3520619<br/>
                        <xsl:value-of select="GenerateVisit/Department"/> -    <xsl:value-of select="GenerateVisit/Speciality"/>

                      </h5>

                    </center>
                  </td>
                </tr>

              </table>
            </td>
          </tr>
          <tr>
            <td width="100%">
              <hr></hr>
            </td>
          </tr>
          <tr>
            <td align="center">
              <table>
                <tr>
                  <td>
                    <b>
                      BUKTI PELAYANAN RAWAT JALAN
                    </b>
                  </td>
                </tr>
              </table>
            </td>
          </tr>        

          <tr>
            <td>
              <br/>
            </td>
          </tr>
          <tr>
            <td  align="center">
              <table width="100%">
                <tr>
                  <td>No.RM</td>
                  <td valign="top" >
                    :   <xsl:value-of select="GenerateVisit/PatientNumber"/>
                  </td>

                  <td>Tgl. Lahir</td>
                  <td valign="top" >
                    :   <xsl:value-of select="GenerateVisit/DOB"/>
                  </td>
                </tr>
                <tr>
                  <td>Nama</td>
                  <td valign="top">
                    :   <xsl:value-of select="GenerateVisit/PatientName"/>
                  </td>
                  <td>Tgl. Masuk</td>
                  <td valign="top">
                    :   <xsl:value-of select="GenerateVisit/VisitDate"/>
                  </td>
                </tr>
                <tr>
                  <td>Poli</td>
                  <td valign="top">
                    :    <xsl:value-of select="GenerateVisit/DeptName"/>
                  </td>
                  <td>Jenis Kelamin</td>
                  <td valign="top">
                    :     <xsl:value-of select="GenerateVisit/Gender"/>
                  </td>
                </tr>

              </table>
            </td>
          </tr>
          <tr>
            <td>
              <br/>
            </td>
          </tr>
          <tr>
            <td  align="center">
              <table width="100%">
                <tr>
                  <td> No</td>
                  <td> Nama Tindakan</td>
                  <td> Dokter</td>
                  <td> Biaya</td>
                </tr>
                <tr>
                  <td colspan="4">
                    <hr></hr>
                  </td>
                </tr>
                <xsl:for-each select="GenerateVisit/Items">
                  <tr>
                    <td>
                      <xsl:value-of select="SNo" />
                    </td>
                    <td>
                      <xsl:value-of select="Item" />
                    </td>
                    <td>
                      <xsl:value-of select="RefPhysician" />
                    </td>
                    <td>
                      <xsl:value-of select="Amount" />
                    </td>
                  </tr>
                  <!--<tr>
                    <td colspan="4">
                      <hr></hr>
                    </td>
                  </tr>-->
                </xsl:for-each>
                <tr>
                  <td colspan="4">
                    <hr></hr>
                  </td>
                </tr>

                <tr>
                  <td colspan="2">

                  </td>
                  <td align="left">
                    
                      Total
                    
                  </td>
                  <td valign="top">

                    <xsl:value-of select="GenerateVisit/TotalAmount"/>

                  </td>
                </tr>
                  <tr>
                      <td colspan="2">

                      </td>
                      <td  align="left">

                          Biaya Administrasi

                      </td>
                      <td valign="top">

                          <xsl:value-of select="GenerateVisit/AdministrativeCharges"/>

                      </td>
                  </tr>
                  <tr>
                      <td colspan="2">

                      </td>
                      <td  align="left">

                          Jumlah Tagihan

                      </td>
                      <td valign="top">

                          <xsl:value-of select="GenerateVisit/NetAmount"/>

                      </td>
                  </tr>

                <tr>
                  <td valign="top" colspan="4" align="right">
                    <xsl:value-of select="GenerateVisit/LocationName"/> ,
                    <xsl:value-of select="GenerateVisit/VisitingDate"/>

                  </td>

                </tr>
                <tr>
                  <td colspan="4" align="center">
                    <table width="100%">

                      <tr>
                        <td align="right">Petugas/Dr</td>
                        <td align="right">Pasien</td>
                        <td align="right" >Petugas Berwenang</td>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <br/>
                        </td>
                      </tr>
                      <tr>
                        <td align="right">(..................)</td>
                        <td align="right">(..................)</td>
                        <td align="right">(..................)</td>
                      </tr>
                      <tr>
                        <td></td>
                      </tr>
                      <tr>
                        <td style="width: 100%;">
                            <div style="width: 20%;">
                          <u>
                            <b>
                              keterangan:
                            </b>
                          </u>
                          </div>
                        </td>

                      </tr>
                      <tr>
                        <td style="width: 100%; padding-left: 2.5%;">
                            1.Putih untuk Pasien
                         
                        </td>

                      </tr>
                      <tr>
                        <td style="width: 100%;">
                          <div style="width: 100%; padding-left: 3%;">
                            2.Kuning untuk Poli
                          </div>
                        </td>

                      </tr>
                      <tr>
                        <td style="width: 100%;">
                          <div style="width: 100%; padding-left: 4%;">
                            3.Merah untuk Kasir
                          </div>
                        </td>

                      </tr>

                    </table>
                  </td>
                </tr>

              </table>

            </td>

          </tr>
        
          <!--<tr>
            <td  align="right">
              <table width="80%">
                <tr>
                  <td valign="top" align="right">
                    <xsl:value-of select="GenerateVisit/LocationName"/> ,
                    <xsl:value-of select="GenerateVisit/VisitingDate"/>

                  </td>
                </tr>
              </table>
            </td>
            
          </tr>-->
         
        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
