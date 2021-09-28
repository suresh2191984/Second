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
        <center>
          <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">
            <tr width="100%">
              <td colspan="2" align="left">
                <table width="100%">
                  <tr>
                    <td align="left">
                      Referral From :
                    </td>
                    <td>
                      <input type="text" id="Referral" />
                    </td>
                    <TD>
                      Date and Time :
                    </TD>
                    <td>
                      <input type="text" id="txtDate" Class="smaller datePicker" />                      
                    </td>
                    <TD>
                      Age :
                    </TD>
                    <td>
                      <input type="text" id="txtAge" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <!--<tr>
              <td colspan="2"  align="left">
                <table>
                  <tr>
                    <td>
                      <u>CLINICIAL NOTES</u>
                    </td>
                    <td>

                    </td>
                    <TD>
                      Date and Time :
                    </TD>
                    <td>
                      <input type="text" id="txtDate" />
                      <a id="ahrImgBtn" href="javascript:NewCal('txtDate','ddmmyyyy',true,12);">
                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" />
                      </a>
                    </td>
                    <TD>
                      Age :
                    </TD>
                    <td>
                      <input type="text" id="txtAge" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>-->
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (A)CHIEF COMPLAINT
                    </td>
                  </tr>
                  <TR>
                    <TD align="left">
                      <!--<textarea id="CHIEF" style="height:25px;width:700PX;"/>-->
                      <input type="text" id="CHIEF" style="height:25px;width:700PX;"/>
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (B)HISTORY OF PRESENTING COMPLAINT
                    </td>
                  </tr>
                  <TR>
                    <TD align="left">
                      <input type="text" id="HISTORY" style="height:25px;width:700PX;"/>
                      <!--<textarea id="HISTORY" style="height:25px;width:700PX;"/>-->
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (C)TREATMENT RECEIVED
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1.SPECIALIST/INVESTIGATION/IMAGING
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="SPECIALIST" style="height:25px;width:700PX;" align="left"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      2.COMPLEMENTING MEDICINE
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="COMPLEMENTING" style="height:25px;width:700PX;"/>
                      
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      3.PAST MEDICAL HISTORY
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="MEDICAL" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (D)PAIN HISTORY
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1. SITE
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="SITE" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr >
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      2.RADIATION OF PAIN
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="RADIATION" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      3.CHARACTER OF PAIN
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="CHARACTER" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      4.VAS(Least/Most/Current)(Reset and Dynamic)
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="VAS" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      5.TEMPORAL RELATIONSHIP(Intermittent,Paroxysmal)
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="TEMPORAL" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      6.AGGRAVATING TRIGGERS(Claudiction)
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="AGGRAVATING" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      7.RELIEF FACTORS
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="RELIEFFACTORS" style="height:25px;width:700PX;"/>
                     

                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      8.ASSOCIATED SYMPTIOMS(Spasticity)
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="ASSOCIATEDSYMPTIOMS" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      9.AFFECTED SLEEP,WORK
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="AFFECTEDSLEEPWORK" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      10.LIMITATION OF ACTIVITIES/FUNCTIONS
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="LIMITATIONACTIVITIES" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      11.PATIENT'S BELIEF REGARDING THE PAIN
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="PATIENTBELIEFREGARDING" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      12.PATIENT'S EXPECTATIONS/FEELING REGARDING PAIN
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="PATIENTEXPECTATIONS" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (E)MEDICATIONS
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1.DRUG ALLERGY / NKDA
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="DRUGALLERGY" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      2. A)CURRENT
                    </td>
                    <td align="left">
                      B)TRIED
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="CURRENT" style="height:25px;width:250px;"/>
                     
                    </TD>
                    <TD>
                      
                        <input type="text" id="TRIED" style="height:25px;width:250px;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (F)PSYCHO / SOCIAL HISTORY
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1.FAMILY
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="FAMILY" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      2.COMPENSATION/WORKING/INCOME
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="COMPENSATION" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      3.YELLOW FLAGS/COPING MECHANISM
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="YELLOWFLAGS" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (G)CLINICIAL EXAMINATION
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="CLINICIALEXAMINATION" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table style="font-size:12px;font-family:verdana;">
                  <tr>
                    <td align="center">
                    </td>
                    <td>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (H)ASSESSMENT/DIAGNOSIS
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="ASSESSMENT" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (I)MANAGEMENT PLAN
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1.PROCEDURES
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="PROCEDURES" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      2.MEDICATIONS
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="MEDICATIONS" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      3.INVESTIGATIONS
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="INVESTIGATIONS" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      4.EDUCATION/LIFESTYLE/EXERCISE/PHYSIO
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      
                        <input type="text" id="EDUCATION" style="height:25px;width:700PX;"/>
                      
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      5.TCU
                    </td>
                  </tr>
                  <TR>
                    <TD>

                      <input type="text" id="TCU" style="height:25px;width:700PX;"/>
                     
                    </TD>
                  </TR>
                </table>
              </td>
            </tr>
          </table>
        </center>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
