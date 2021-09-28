<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">
    <html>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
      <body>
        <div id="divContainer">
          <h3 align="center" >MRD CARD</h3>
          <div id="div0" >
            <table border="0" width="100%" style="font-family:Verdana; font-size:14px; border-bottom: #b6a8a8 0px solid; border-left: #b6a8a8 1px solid; width: 100%; border-collapse: collapse; border-top: #b6a8a8 1px solid; border-right: #b6a8a8 1px solid;" >
              <tr align="center">
                <td align="Center"   >
                  <img style="..." alt="=">
                    <xsl:attribute name="src">
                      <xsl:value-of select="MrdCardNo/HeaderLogo" />
                    </xsl:attribute>
                  </img>
                  <br>
                    <xsl:value-of select="MrdCardNo/HeaderName"/>
                  </br>
                  <br>
                    <xsl:value-of select="MrdCardNo/HeaderAddress"/>
                  </br>
                  <br>
                    <xsl:value-of select="MrdCardNo/HeaderPhoneNo"/>
                  </br>
                  <br>
                    <xsl:value-of select="MrdCardNo/HeaderEmail"/>
                  </br>
                </td>
              </tr>
              <tr>
                <td>
                  <br>

                  </br>
                </td>
              </tr>
            </table>

            <table border="1"   width="100%" style=" border-bottom: #b6a8a8 1px solid; border-left: #b6a8a8 1px solid; width: 100%; border-collapse: collapse; border-top: #b6a8a8 0px solid; border-right: #b6a8a8 1px solid; font-family:Verdana; font-size:12px;" >
              <tr>
                <td width="35%" align="left" style="border-right: #b6a8a8 0px solid;" >
                  <table  border="0" cellpadding="1px"  cellspacing="1px" style=" font-family:Verdana; font-size:12px; " >
                    <tr>
                      <td width="20%">MRD No </td>
                      <td >
                        <xsl:value-of select="MrdCardNo/PatientNumber"/>
                      </td>
                    </tr>
                    <tr>
                      <td>Name </td>
                      <td>
                        <xsl:value-of select="MrdCardNo/PatientName"/>
                      </td>
                    </tr>
                    <tr>
                      <td valign="top" >Address </td>
                      <td>
                        <xsl:value-of select="MrdCardNo/Address"/>
                      </td>
                    </tr>
                  </table>
                </td>
                <td valign="top" width="35%" align="left" style="border-left: #b6a8a8 0px solid;" >
                  <table border="0" cellpadding="1px" cellspacing="1px" style=" font-family:Verdana; font-size:12px;" >
                    <tr>
                      <td >Ph. No </td>
                      <td >
                        <xsl:value-of select="MrdCardNo/TelephoneNo"/>
                      </td>
                    </tr>
                    <tr>
                      <td>Age/Sex </td>
                      <td>
                        <xsl:value-of select="MrdCardNo/Age"/>/
                        <xsl:value-of select="MrdCardNo/Sex"/>
                      </td>
                    </tr>
                  </table>
                </td>
                <td valign="top" align="left">
                  History :
                </td>
              </tr>
              <tr>
                <td colspan="3">
                  <xsl:value-of select="MrdCardNo/DiscountReason"/>
                </td> 
              </tr>
              
              <!--<tr>
                <td colspan="3">
                  <xsl:value-of select="MrdCardNo/Comments"/>
                </td>
              </tr>-->
              <tr>
                <td colspan="3">
                  <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid; width: 100%; border-collapse: collapse; border-top: #b6a8a8 1px Solid; border-right: #b6a8a8 1px Solid; table-layout:fixed">
                    <tr  style="border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid; border-collapse: collapse; border-top: #b6a8a8 0px Solid; border-right: #b6a8a8 1px Solid; ">
                      <td align="center" style="width:20%; border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid;  border-collapse: collapse; border-top: #b6a8a8 1px Solid; border-right: #b6a8a8 1px Solid; ">Date</td>
                      <td align="center" colspan="2">Examination</td>
                    </tr>
                    <tr style="border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid; width: 100%; border-collapse: collapse; border-top: #b6a8a8 0px Solid; border-right: #b6a8a8 1px Solid;  " >
                      <td height="500px" style="width:20%; border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid;  border-collapse: collapse; border-top: #b6a8a8 1px Solid; border-right: #b6a8a8 1px Solid;  ">
                        &#160;
                      </td>

                      <td height="500px" colspan="2" style="width:20%; border-bottom: #b6a8a8 1px Solid; border-left: #b6a8a8 1px Solid;  border-collapse: collapse; border-top: #b6a8a8 1px Solid; border-right: #b6a8a8 1px Solid; ">
                        &#160;
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <!-- <tr >
                <td colspan="3">
                  <xsl:value-of select="MrdCardNo/DiscountName"/>
                </td>

              </tr>
             <tr>
                <td colspan="3">
                  <xsl:value-of select="MrdCardNo/Comments"/>
                </td>
              </tr>-->
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
