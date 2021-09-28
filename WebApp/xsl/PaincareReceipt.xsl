<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:cs="urn:cs" xmlns:asp="remove">
  <msxsl:script language="C#" implements-prefix="cs">
    <![CDATA[
      public string datenow()
     {
        return(DateTimeUtility.GetServerDate().ToString("dd MMMM yyyy hh':'mm tt"));
     }
     ]]>
  </msxsl:script>
  <xsl:template match="/">
    <html>
      <body>
        <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="100%">
          <tr>
            <td colspan="3">
              <table width="100%">
                <tr>
                  <td align="left">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="OpReceipt/src" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td align="right">
                    <h5> 290 Orchard Road<br/>
                    #18-03 Paragon<br/>
                    Singapore 238859<br/>
                    Tel:6235 6697<br/>
                      Fax: 6235 6846 </h5>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <TR width="100%">
            <td  Colspan="3" width="100%">
              <table width="100%">
                <tr>
                  <Td align="left" Width="20%" nowrap="nowrap">
                    <h5> GST Reg No : 53117159X </h5>
                  </Td>
                  <Td align="Center" Width="60%" nowrap="nowrap">

                  </Td>
                  <td align="Right" Width="20%" nowrap="nowrap">
                    <h5> Co Reg No : 53117159X </h5>
                  </td>
                </tr>
              </table>
            </td>
          </TR>
          <TR>
            <td Colspan="3">
              <hr/>
            </td>
          </TR>
          <TR width="100%">
            <Td align="left" Colspan="3">
              <h3>
                <B>AMOUNT RECEIPT</B>
              </h3>
            </Td>
          </TR>
          <tr>
            <td>Receipt No</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="OpReceipt/ReceiptNO"/>
            </td>
          </tr>
          <tr>
            <td>Visit Date</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="OpReceipt/VisitDate"/>
            </td>
          </tr>
          <tr>
            <td>Visit No/UHID</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="OpReceipt/VisitNo"/> / <xsl:value-of select="OpReceipt/MediacalRecordNo"/>
            </td>
          </tr>
          <tr>
            <td>Name:</td>
            <td>:</td>
            <td valign="top">
              <xsl:value-of select="OpReceipt/PatientName"/>
            </td>
          </tr>
          <tr>
            <td>AmountReceived</td>
            <td>:</td>
            <td valign="top">
              S$. <xsl:value-of select="OpReceipt/AmountReceived"/>
            </td>
          </tr>
          <tr>
            <td align="Right" Colspan="3">
              Singapore, <xsl:value-of select="cs:datenow()"></xsl:value-of>
            </td>
          </tr>
          <tr>
            <td Colspan="3">
              <br/>>
            </td>
          </tr>
          <tr>
            <td align="Right" Colspan="3">
              (<xsl:value-of select="OpReceipt/LoginName"/>)
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
