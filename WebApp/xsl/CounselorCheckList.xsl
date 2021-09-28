<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="i" select="0"></xsl:variable>
  <xsl:template match="/">
    <style>
      <![CDATA[
         table{clear:left;float:left;font-family:verdana;}
         b{font-family:verdana;font-size:12px;}
         .s1{clear:left;float:left;border:solid 1px black;width:1000px;margin:15px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;}
         .s5{background-color:#96C4DD;}
		 
      ]]>
    </style>
    <html>
      <body>
        <div id="dvCounselorCheckList" class="printfont">
          <div id="dvCounselorCheckListSummary" class="UIfont">
            <br></br>
            <br></br>

            <center>
              <u>
                <b>Counselor Check List</b>
              </u>
            </center>
          </div>
          <div class="s1" align="center">
            <table width="74%" border="1" style="border-collapse:collapse">
              <tr>
                <td>
                  <b>UHID</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorCheckList/PatientDetails/Patient/PatientNo"/>
                </td>
                <td>
                  <b>Patient Name</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorCheckList/PatientDetails/Patient/PatientName"/>
                </td>
              </tr>
              <tr>
                <td>
                  <b>Age</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorCheckList/PatientDetails/Patient/Age"/>
                </td>
                <td>
                  <b>Doctor</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorCheckList/PatientDetails/Patient/Doctor"/>
                </td>
              </tr>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td>
                  <b>Date</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorCheckList/PatientDetails/Patient/Date"/>
                </td>
              </tr>
            </table>
          </div>
          <div>
            <table width="74%" border="1" style="border-collapse:collapse">
              <tr>
                <th>
                  <b>S.No</b>
                </th>
                <th>
                  <b>Check list</b>
                </th>
                <th>
                  <b>Status/Description</b>
                </th>
              </tr>
              
              <xsl:for-each select="CounselorCheckList/CheckList">
                <xsl:if test="Description!='REMARKS'">
                  
                  <tr>
                    <td>

                      <xsl:variable name="i" select="position()" />
                      <xsl:value-of select="$i"/>
                      
                    </td>
                    <td>
                      <xsl:value-of select="Description"/>
                    </td>
                    <td>
                      <xsl:value-of select="AttributeVaueName"/>
                    </td>
                  </tr>
                </xsl:if>
              </xsl:for-each>
              <xsl:for-each select="CounselorCheckList/CheckList">
                <xsl:if test="Description = 'REMARKS'">
                  <tr>
                    <td>
                      <xsl:value-of select="last()+1"/>
                      
                    </td>
                    <td>
                      <xsl:value-of select="Description"/>
                    </td>
                    <td>
                      <xsl:value-of select="AttributeVaueName"/>
                    </td>
                  </tr>
                </xsl:if>
              </xsl:for-each>
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
