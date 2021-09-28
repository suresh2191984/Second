<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">
    <html>
      <body>
        <table width="100%" style="font-size:16px;">
         
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
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
              NOTIFICATION COSTS<br/>
              TREATMENT AND MEDICATION IN SANGLAH HOSPITAL<br/>
              UP TO  <xsl:value-of select="Notivacation/Date"/>
            </td>
          </tr>
          <tr>
            <td align="left">To</td>
          </tr>
          <tr>
            <td align="left">
              Dear <xsl:value-of select="Notivacation/Name"/>
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
              Phone : <xsl:value-of select="Notivacation/Moblieno"/>
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              Here we inform that treatment and medication cost of patient:
            </td>
          </tr>
          <tr>
            <td>UHID/ No. Registration</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/PatientNumber"/>/<xsl:value-of select="Notivacation/VisitNumber"/>
            </td>
          </tr>
          <tr>
            <td>Name</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/Name1"/>
            </td>
          </tr>

          <tr>
            <td>Client Name</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/ClientName"/>/<xsl:value-of select="Notivacation/ClientName"/>
            </td>
          </tr>
          <tr>
            <td>WardRoom / Class</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/Room"/>/<xsl:value-of select="Notivacation/RateName"/>
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              Treatment and medication cost detail up to <xsl:value-of select="Notivacation/Date1"/>
            </td>
          </tr>
          <tr>
            <td>Total Cost </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/TotalAmount"/>
            </td>
          </tr>
          <tr>
            <td>Already paid </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/RecvdAmount"/>
            </td>
          </tr>
          <tr>
            <td>Total Bill </td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="Notivacation/BalanceAmount"/>
            </td>
          </tr>         
          <tr>
            <td align="left" Colspan="3">
              To ease cost when discharge, it is expected to pay in installments in Sanglah Hospitas IP cashier 
              working day at 08.00-14.00 WITA, or can be transfered  to BPD BALI at Sanglah branch office with
              account number 011.02.52.00476-4.
            </td>
          </tr>
          <tr>
            <td align="left" Colspan="3">
              Sincerely yours.
            </td >
          </tr>
          <tr>
            <td align="right" Colspan="3">
              Denpasar, <xsl:value-of select="Notivacation/Date3"/><br/>
              Finance Directure<br/>
              <br/>
              <br/>
              <br/>
              (Ni Ketut Rupini, SH, MARS) <br/>
              NIP.196807241994032002
            </td>
          </tr>
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
          <tr>
            <Td colspan="3">
              <br/>
            </Td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
