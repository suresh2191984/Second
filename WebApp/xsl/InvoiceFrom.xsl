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
            <td align="Center">
              <image src="http://10.20.2.12/RSUPSanglah/Images/Logo/Header.png" width="800px" height="100px"></image>
            </td>
          </tr>
          <tr>
            <td  align="Center">
              <Table>
                <tr>
                  <td>
                    <b>
                      <h4>TAGIHAN</h4>
                    </b>
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>
                      <h5> (INVOICE)</h5>
                    </b>
                  </td>
                </tr>
              </Table>
            </td>
          </tr>
          <tr>
            <td>
              <Table>
                <tr>
                  <td>
                    Nomor Tagihan (Number of Invoice)
                  </td>
                  <td>
                    :
                  </td>
                  <TD>
                    <xsl:value-of select="InvoiceFrom/NumberOfInvoice"/>
                  </TD>
                </tr>
              </Table>
            </td >
          </tr>
          <tr>
            <td>
              <Table>
                <tr>
                  <td>
                    Tanggal Tagihan(Date of Invoice)
                  </td>
                  <td>
                    :
                  </td>
                  <TD>
                    <xsl:value-of select="InvoiceFrom/DateofInvoice"/>
                  </TD>
                </tr>
              </Table>
            </td >
          </tr>
          <tr>
            <td>
              <Table>
                <tr>
                  <td>
                    Kepada Yth.(To)
                  </td>
                  <td>
                    :
                  </td>
                  <TD>
                    <b>
                      <xsl:value-of select="InvoiceFrom/ClientName"/>
                    </b>
                  </TD>
                </tr>
              </Table>
            </td >
          </tr>
          <tr>
            <td>
              <Table>
                <tr>
                  <td>
                    Di (at)
                  </td>
                  <td>
                    :
                  </td>
                  <TD>
                    Denpasar
                  </TD>
                </tr>
              </Table>
            </td >
          </tr >
          <tr>
            <td Colspan="2">
              Bersama ini, kami kirimkan tagihan biaya perwatan dan obat – obatan bagi pasien yang dirawat di RSUP Sanglah Denpasa, sebagai berikut:
              (Herewith, we send the invoice of the medical and pharmaceuticals cost of the patients hospitalized at Sanglah Hospital, as below: )

            </td>
          </tr>
          <tr>
            <td Colspan="2">
              <table Border="1">
                <tr>
                  <td>
                    <B>PERIOD</B>
                  </td>
                  <td>
                    <B>REMARKS</B>
                  </td>
                  <td>
                    <B>AMOUNT (Rp)</B>
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="InvoiceFrom/DateRange"/>
                  </td>
                  <td>
                    Biaya perawatan dan obat-obatan
                    Sesuai rincian telampir.
                    (Medical and pharmaceuticals according to the details attached)
                  </td>
                  <td>
                    <B>
                      <xsl:value-of select="InvoiceFrom/SubTotal"/>
                    </B >
                  </td>
                </tr>
                <tr>
                  <td Colspan="2" style="padding-left:50px">
                    <B>Total</B>
                  </td>
                  <td>
                    <B>
                      <xsl:value-of select="InvoiceFrom/Total"/>
                    </B >
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <TR>
            <td cols="2">
              Pembayaran agar ditransfer ke Rekening BPD Bali Cabang Utama Denpasar Nomor:<B>011.01.0002343-7</B>, atas nama RSUP Sanglah Denpasar;
              dan bukti transfer agar difaximile ke nomor: <B>(0361) 232603 / (0361) 224206.</B>
            </td>

          </TR>
          <TR>
            <td cols="2">
              (Please transfer the payment to the BPD Bali Main Branch, account number <B>011.01.0002343-7</B>,on the account name RSUP Sanglah Denpasar and
              please send the transfer evidence to our faximile number <B> (0361) 232603 / (0361) 224206).</B>
            </td >
          </TR >
          <TR>
            <td cols="2">
              Terima kasih atas perhatian dan kerjasamanya.(Thank you for your attention and cioperation).
            </td >
          </TR >
          <TR>
            <td cols="2" style="padding-left:650px">
              <Table>
                <tr>
                  <td aligh="right">
                    Denpasar  <xsl:value-of select="InvoiceFrom/Today"/> <br/>
                  </td>
                </tr>
                <tr>
                  <td aligh="right">
                    Direktur Keuangan,
                  </td>
                </tr>
                <tr>
                  <td aligh="right">
                    Rumah Sakit Sanglah, Denpasar,
                  </td>
                </tr>
                <tr>
                  <td>
                    <br/>
                    <br/>
                  </td>
                </tr>
                <tr>
                  <td aligh="right">
                    <b>Ni Ketut Rupini,SH MARS</b>
                  </td>
                </tr>
                <tr>
                  <td aligh="right">
                    ---------------------------------
                  </td>
                </tr>
                <tr>
                  <td aligh="right">
                    NIP 196807241994032002
                  </td>
                </tr>
              </Table >
            </td >
          </TR >
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
