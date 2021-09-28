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
         b{font-size:11px;}
         .boldfont{font-size:16px;}
         .s1{clear:left;float:left;border:solid 1px black;width:1000px;margin:15px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;}
         .s5{background-color:#96C4DD;}
		    .u {    
       border-bottom: 1px dotted #000;
       text-decoration: none;
      }
      ]]>
    </style>
    <html>
      <body>
        <div id="dvEstimate" class="printfont">
          <div id="dvEstimateSummary" class="UIfont">
            <br></br>
            <center>
              <u>
                <b class="boldfont">ESTIMATED LETTER</b>
              </u>
              <br></br>
              <u>
                <b class="boldfont">TO WHOMSOEVER IT MAY CONCERN</b>
              </u>
            </center>
          </div>
          <div align="center">
            <table width="100%">
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td>
                  <b>Date</b>
                </td>
                <td>:</td>
                <td colspan="4">
                  <xsl:value-of select="CounselorEstimate/PatientDetails/Patient/Date"/>
                </td>
              </tr>
              <tr>
                <td style="width: 20%;">
                  <b>Name of the Patient</b>
                </td>
                <td>:</td>
                <td style="width: 40%;">
                  <xsl:value-of select="CounselorEstimate/PatientDetails/Patient/PatientName"/>
                </td>
                <td style="width: 5%;">
                  <b>Age</b>
                </td>
                <td>:</td>
                <td style="width: 13%;">
                  <xsl:value-of select="CounselorEstimate/PatientDetails/Patient/Age"/>
                </td>
                <td>
                  <b>UID</b>
                </td>
                <td>:</td>
                <td>
                  <xsl:value-of select="CounselorEstimate/PatientDetails/Patient/PatientNo"/>
                </td>
              </tr>
              <tr>
                <td>
                  <b>Diagnosis</b>
                </td>
                <td>:</td>
                <td colspan="7">
                  Anterior Wall Myocardial Infarction, Triple Vessel Disease
                </td>
              </tr>
              <tr>
                <td>
                  <b>Treatment Advised</b>
                </td>
                <td>:</td>
                <td colspan="7">
                  <xsl:for-each select="CounselorEstimate/Estimate">
                    <xsl:value-of select="ServiceName"/>
                  </xsl:for-each>
                </td>
              </tr>
              <tr>
                <td>
                  <b>Doctor</b>
                </td>
                <td>:</td>
                <td colspan="7">
                  <xsl:value-of select="CounselorEstimate/PatientDetails/Patient/Doctor"/>
                </td>
              </tr>
            </table>
          </div>
          <div>
            <table>
              <tr>
                <td class=".s2" colspan="8">
                  Cost Estimation for
                  <span class="u">
                    <xsl:for-each select="CounselorEstimate/Estimate">
                      <xsl:value-of select="ServiceName"/>
                    </xsl:for-each>
                  </span>
                </td>
                <td align="right">
                  <xsl:value-of select="CounselorEstimate/TotalAmount"/>
                </td>
              </tr>
              <tr>
                <td colspan="8" class=".s2">Special Discount given for</td>
                <span class="u">
                </span>
                <td align="right">
                  <xsl:value-of select="CounselorEstimate/TotalDisCount"/>
                </td>
              </tr>
              <tr>
                <td colspan="8" class=".s2">Total Cost for</td>
                <span class="u">
                </span>
                <td align="right">
                  <xsl:value-of select="CounselorEstimate/NetAmount"/>
                </td>
              </tr>
              <br></br>
              <tr>
                <td colspan="9" class=".s2">
                  <b>Note:</b>
                  <p class=".s2">This cost is a subsidized price after special consideration and cannot be applicable to anyone else. This cost estimate is been issued upon the request of the patient.</p>
                </td>
              </tr>
              <tr>
                <td colspan="4">
                  <xsl:value-of select="CounselorEstimate/DocSig"/>
                </td>
                <td></td>
                <td colspan="4">
                  <xsl:value-of select="CounselorEstimate/CounSig"/>
                </td>
              </tr>
              <tr>
                <td colspan="4">
                  <span>Doctor Signature</span>
                </td>
                <td></td>
                <td colspan="4">
                  <span>Counselor Signature</span>
                </td>

              </tr>
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
