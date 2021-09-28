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
        <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">        
          <tr>
            <td colspan="2">
              <table width="100%">
                <tr>
                  <td align="left">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="Medical/src" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td align="right">
                    290 Orchard Road<br/>
                    #18-03 Paragon<br/>
                    Singapore 238859<br/>
                    Tel:6235 6697<br/>
                    Fax: 6235 6846
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="center">
              <h2>Medical Certificate</h2>
              <hr/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="right">
              <table>
                <tr>                  
                  <td align="right">
                    Date
                  </td>                 
                  <td align="right">
                    :<xsl:value-of select="Medical/Date"/>
                  </td>                
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="right">
              <table>
                <tr>
                  <td align="right">
                    MC No.
                  </td>
                  <td align="right">
                    :<xsl:value-of select="Medical/PatientNumber"/>
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="left">
              <table>
                <tr>
                  <td align="left">
                    This is to certiff that:
                  </td>
                 </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="left">
              <table>
                <tr>
                  <td align="left">
                    Name
                  </td>
                  <td align="left">
                    :<xsl:value-of select="Medical/Name"/>
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="left">
              <table>
                <tr>
                  <td align="left">
                    NRIC
                  </td>
                  <td align="left">
                    :<xsl:value-of select="Medical/NRICNo"/>
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="left">
              <table>
                <tr>
                  <td align="left">
                    is Unfit for Duty for <xsl:value-of select="Medical/NoofDays"/> days from <xsl:value-of select="Medical/FromDate"/> to   <xsl:value-of select="Medical/Todate"/>
                    inclusive.
                  </td>                 
                </tr>
              </table>
              <br/>             
          </td>
          </tr>
          <tr>
            <td colspan="2"  align="left">
              <table>
                <tr>
                  <td align="left">
                    Remarks
                  </td>
                  <td align="left">
                    :<xsl:value-of select="Medical/Remarks"/>
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
          <tr>
            <td colspan="2"  align="right">
              <table>
                <tr>
                  <td align="right">                  
                  </td>
                  <td align="right">
                    <hr />
                  </td>                  
                </tr>
                <tr>
                  <td align="right">
                  </td>
                  <td align="right">
                    <xsl:value-of select="Medical/PhysicianName"/>
                    <br/>
                    <xsl:value-of select="Medical/SpecialityName"/>
                    <br/>
                    Signature
                  </td>
                </tr>
              </table>
              <br/>
            </td>
          </tr>
        </table>        
      </body>
		</html>
	</xsl:template>
</xsl:stylesheet>
