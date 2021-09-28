<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">
    <html>
      <body>
        <table width="100%" style="font-size:16px;">
          <tr>
            <td colspan="3" align="center">
              <table style="font-size:12px;font-family:verdana;">
                <tr>
                  <td align="center">
                    <image src="http://10.20.2.12/RSUPSanglah/Images/Logo/Sanglah.png" align="center"></image>
                  </td>
                </tr>
                <tr>
                  <td  align="center">
                    RUMAH SAKIT SANGLAH <br/>
                    JI. KESEHATAN, DENPASAR <br/>
                    Telp. (0361)227911-15<br/>
                    Faks. (0361)224206
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td Colspan="3" align="center">
              PEMBERITAHUAN BIAYA<br/>
              PERAWATAN DAN PENGOBATAN DI RUMAH SAKIT SANGLAH<br/>
              SAMPAI DENGAN TANGGAL : <xsl:value-of select="Notivacation/Date"/>
            </td>
          </tr>
          <tr>
            <td align="left">
              <br/>Kepada
            </td>
          </tr>
          <tr>
            <td align="left">
              Yth. <xsl:value-of select="Notivacation/Name"/>
            </td>
          </tr>
          <tr>
            <td align="left">
              <xsl:value-of select="Notivacation/Address"/>
            </td>
          </tr>
          <tr>
            <td align="left">
              <xsl:value-of select="Notivacation/City"/>
            </td>
          </tr>
          <tr>
            <td align="left">
              <xsl:value-of select="Notivacation/State"/>
            </td>
          </tr>
          <tr>
            <td align="left">
              Telp : <xsl:value-of select="Notivacation/MobileNo"/>
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              <br/>
              <br/> Dengan hormat,
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              Bersama ini,kami informasikan biaya perawatan dan pengobatan pasien atas nama :
            </td>
          </tr>
          <tr>
            <td>No. RM/ No. Registrasi</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/PatientNumber"/>/<xsl:value-of select="Notivacation/VisitNumber"/>
            </td>
          </tr>
          <tr>
            <td>Nama</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/Name1"/>
            </td>
          </tr>
          <tr>
            <td>cara bayar</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/ClientName"/>/<xsl:value-of select="Notivacation/RateName"/>
            </td>
          </tr>
          <tr>
            <td>Ruang Rawat / Kelas</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/Room"/>/<xsl:value-of select="Notivacation/RateName"/>
            </td>
          </tr>

          <tr>
            <td align="left" Colspan="3">
              <br/>
              <br/>Rincian biaya sampai dengan tanggal : <xsl:value-of select="Notivacation/Date1"/>
            </td>
          </tr>
          <tr>
            <td>Total Biaya </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/TotalAmount"/>
            </td>
          </tr>
          <tr>
            <td>Yang sudah dibayarkan </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/RecvdAmount"/>
            </td>
          </tr>
          <tr>
            <td>Sisa biaya yang belum dibayar </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/BalanceAmount"/>
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              <br/>
              <br/>Untuk meringankan beban biaya pada saat pulang maka diharapkan agar saudara/i mengangsur biaya dimaksud melalui kasir
              rawat inap RSUP Sanglah pada hari kerja jam 08.00 s.d. 14.00 WITA, atau dapat ditransfer ke BPD BALI Cabang Utama
              Denpasar Kantor Kas RS SANGLAH dengan nomor rekening  011.02.52.00476-4.
            </td>
          </tr>
          <tr >
            <td align="left" Colspan="3">
              <br/>
              <br/>Atas perhatian Saudara/i, kami ucapkan terima kasih.
            </td>

          </tr>
          <tr>
            <td align="right" Colspan="3">
              
              Denpasar, <xsl:value-of select="Notivacation/Date3"/><br/>
              Direktur Keuangan<br/>
              <br/>
              <br/>
              <br/>
              (Ni Ketut Rupini, SH, MARS) <br/>
              NIP.196807241994032002
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
