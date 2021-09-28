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
        <table>
          <tr>
            <td>
              <b>RUMAH SAKIT SANGLAH</b>
            </td>
          </tr>
          <tr>
            <td>
              <b>JI. KESEHATAN, DENPASAR</b>
            </td>
          </tr>
          <tr>
            <td>
              <b>Telp. (0361)227911-15</b>
            </td>
          </tr>
          <tr>
            <td>
              <b>Faks. (0361)224206</b>
            </td>
          </tr>
        </table>
          <h3 style="margin-left:300px;">SURAT PERNYATAAN</h3>
        <table id="tblConselForm" width="100%" style="font-size:12px;font-family:verdana" >
          <tr>
            <td>Yang bertanda tangan di bawah ini :</td>
          </tr>
          <tr>
            <td>
              <table width="100%" style="font-size:12px;font-family:verdana">
                <tr>
                  <td style="width:20%">Nama</td>
                  <td valign="top">:</td>
                  <td>
                    <xsl:value-of select="ConseltForm/RelationName"/>
                  </td>
                </tr>
                <tr>
                  <td style="width:20%">Alamat</td>
                  <td valign="top">:</td>
                  <td>
                    <xsl:value-of select="ConseltForm/RelationAddress"/>
                  </td>
                </tr>
                <tr>
                  <td style="width:20%">Pekerjaan</td>
                  <td valign="top">:</td>
                  <td>
                    <xsl:value-of select="ConseltForm/RelationWork"/>
                  </td>
                </tr>
                <tr>
                  <td style="width:20%">Tanda&#160;Pengenal</td>
                  <td valign="top">:</td>
                  <td>-----------</td>
                </tr>
                <tr>
                  <td style="width:20%">Hubungan&#160;dengan&#160;Pasien</td>
                  <td valign="top">:</td>
                  <td valign="top">
                    <xsl:value-of select="ConseltForm/RelationType"/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table style="font-size:12px;font-family:verdana" >
                <tr>
                  <td>1.Dengan ini menyatakan :</td>
                </tr>
                <tr>
                  <td>
                    <table style="font-size:12px;font-family:verdana" >
                      <tr>
                        <td>Telah melihat dan menyetujui pola tarif yang berlaku di RS. SANGLAH – Denpasar .(Tarif Rawat Inap. Tarif Penunjang Medis. Tarif Tindakan Medis dan Therapi) :</td>
                      </tr>
                      <tr>
                        <td>
                          <table style="font-size:12px;font-family:verdana" >
                            <tr>
                              <td valign="top">1.1</td>
                              <td>Apabila kami pindah kelas ke kelas perawatan yang lebih tinggi setelah mendapatkan tindakan operatif.Maka tarif tindakan operatif yang dilakukan sesuai tarif kelas perawatan yang lebih tinggi(kelas perawatan tertinggi).</td>
                            </tr>
                            <tr>
                              <td valign="top">1.2</td>
                              <td>Apabila kami pindah kelas ke kelas perawatan yang lebih tinggi sebelum mendapatkan tindakan operatif.Maka tarif tindakan operatif yang diberlakukan sesuai tarif kelas perawatan yang lebih tinggi (kelas perawatan tertinggi).</td>
                            </tr>
                            <tr>
                              <td valign="top">1.3</td>
                              <td>Apabila kami pindah kelas ke kelas perawatan yang lebih rendah setelah mendapatkan tindakan operatif.Maka tarif tindakan operatif yang diberlakukan sesuai tarif kelas perawatan yang lebih tinggi (kelas perawatan tertinggi).</td>
                            </tr>
                            <tr>
                              <td valign="top">1.4</td>
                              <td>Apabila kami pindah kelas ke kelas perawatan yang lebih rendah sebelum mendapatkan tindakan operatif dan kami menempati ruangan tersebut sampai pulang. Maka tarif tindakan operatif yang diberlakukan sesuai tarif kelas yang ditempati sekarang.</td>
                            </tr>
                            <tr>
                              <td valign="top">1.5</td>
                              <td>Sesuai ketentuan No. 1.4 apabila kami kembali naik kelas setelah mendapatkan tindakan operatif. Maka tarif tindakan operatif yang diberlakukan sesuai tarif perawatan yang lebih tinggi (kelas perawatan tertinggi).</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>2.Sanggup menjamin kelancaran pembayaran semua biaya pelayanan bagi pasien : </td>
                </tr>
                <tr>
                  <td>
                    <table style="font-size:12px;font-family:verdana">
                      <tr>
                        <td>No. Registrasi</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/PatientNumber"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Nama</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/PatientName"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Umur </td>
                        <td>: </td>
                        <td>
                          <xsl:value-of select="ConseltForm/Age"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Agama</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/Religion"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Alamat</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/PatientAddress"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Tgl. Masuk</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/DateOfRegistration"/>
                        </td>
                      </tr>
                      <tr>
                        <td>Bangsal</td>
                        <td>:</td>
                        <td>
                          <xsl:value-of select="ConseltForm/WardName"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>3. Tidak keberatan IKHTISAR PERWATAN pasien dikirim pada perusahaan yang menanggung.</td>
                </tr>
                <tr>
                  <td>
                    4. Membayar uang muka sebesar <xsl:value-of select="ConseltForm/PaidAdvance"/></td>
                </tr>
                <tr>
                  <td>5. Apabila uang biaya perawatan sudah melebihi biaya uang muka pasien / keluarga pasien menambah biaya perawatan hari berikutnya.</td>
                </tr>
                <tr>
                  <td>6. Setuju, sewaktu – waktu diberi informasi mengenai biaya perawatan yang diberikan rumah sakit pada pasien.</td>
                </tr>
                <tr>
                  <td>7. Bersedia mematuhi peraturan dan ketentuan yang berlaku di RS SANGLAH – Denpasar.</td>
                </tr>
                <tr>
                  <td>8. Kelebihan terhadap biaya yang ditanggung pihak penjamin menjadi / dibayarkan oleh pasien.</td>
                </tr>
                <tr>
                  <td>Demikian surat pernyataan ini saya buat dan tidak dibawah tekanan manapun.</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" style="font-size:12px;font-family:verdana" >
                <tr>
                  <td style="padding-top:2%">
                    <table width="100%" style="font-size:12px;font-family:verdana" >
                      <tr>
                        <td align="center">Mengetahui, </td>
                        <td align="center">
                          Denpasar, <xsl:value-of select="ConseltForm/CurrentDate"/>
                        </td>
                      </tr>
                      <tr>
                        <td align="center">
                          Petugas
                        </td>
                        <td align="center">Yang Membuat Pernyataan</td>
                      </tr>
                      <tr>
                        <td align="center" style="padding-top:80px;">
                          ( <xsl:value-of select="ConseltForm/LoginName"/> )
                        </td>
                        <td align="center" style="padding-top:80px;">
                          (   <xsl:value-of select="ConseltForm/RelationName"/>   )
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
