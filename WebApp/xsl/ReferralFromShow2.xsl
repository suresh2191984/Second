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
          <table style="font-size:11px;font-family:verdana;border-collapse: separate;border-spacing: 2px;width:100%" >
            <!--<tr>
              <td colspan="2" align="left">
                <table width="50%">
                  <tr>
                    <td>
                       Referral From
                    </td>
                    <td>
                      :<xsl:value-of select="ReferralFromShow/Referral"/>                    
                    </td>
                  </tr>
                </table>
                <br/>
              </td>
            </tr>
              <tr>
              <td colspan="2">
                <table width="100%">
                  <tr>
                    <td align="left">
                      <input type="image" name="imagem">
                        <xsl:attribute name="src">
                          <xsl:value-of select="ReferralFromShow/src" />
                        </xsl:attribute>
                      </input>
                    </td>
                    <td align="right">
                      <input type="image" name="PatientImage1">
                        <xsl:attribute name="src">
                          <xsl:value-of select="ReferralFromShow/PatientSPcc1" />
                        </xsl:attribute>
                      </input>
                     
                    </td>
                  </tr>
                </table>
                <br/>
              </td>
                
            </tr>-->                              
            <tr>
              <td colspan="2"  align="left">
              <table>
                <tr>
                  <td>
                    <u>CLINICIAL NOTES</u>
                  </td>
                  <td>
                    
                  </td>
                  <TD>
                    <!--Date-->
                  </TD>
                  <td>
                    <!--:<xsl:value-of select="ReferralFromShow/Date"/>-->
                  </td>         
                  <TD>
                    <!--Age-->
                  </TD>
                  <td>
                    <!--:<xsl:value-of select="ReferralFromShow/Age"/>--> 
                  </td>
                </tr>
               </table> <br/>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
              <table>
                <tr>
                  <td align="left">
                    (A)CHIEF COMPLAINT
                  </td>
                </tr>
                <TR>
                  <TD>
                    <xsl:value-of select="ReferralFromShow/CHIEF"/>                   
                  </TD>
                </TR>
               </table> <br/>
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
                  <TD>
                    <xsl:value-of select="ReferralFromShow/HISTORY"/>                              
                  </TD>
                </TR>
               </table> <br/>
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
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/SPECIALIST"/>
                                
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/COMPLEMENTING"/>                           
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/MEDICAL"/>                   
                  </TD>
                </TR>
               </table> <br/>
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
               </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/SITE"/>
                    </TD>
                  </TR>
                 </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/RADIATION"/>
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/CHARACTER"/>                  
                   
                  </TD>
                </TR>
               </table> <br/>
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
                                       <xsl:value-of select="ReferralFromShow/VAS"/>
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/TEMPORAL"/>
                   
                    
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/AGGRAVATING"/>

                  </TD>
                </TR>
               </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/RELIEFFACTORS"/>

                    
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/ASSOCIATEDSYMPTIOMS"/>

                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/AFFECTEDSLEEPWORK"/>                     
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/LIMITATIONACTIVITIES"/>
                      
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/PATIENTBELIEFREGARDING"/>                      
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/PATIENTEXPECTATIONS"/>
                     
                    </TD>
                  </TR>
                 </table> <br/>
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
                 </table> <br/>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      1.DRUG ALLERGY / NKDA
                    </td>
                    <td align="right" rowspan="2">
                      <!--<input type="image" name="PatientImage2">
                        <xsl:attribute name="src">
                          <xsl:value-of select="ReferralFromShow/PatientSPcc2" />
                        </xsl:attribute>
                      </input>-->
                      <!--<image src="http://localhost:1690/WebApp/Images/Patient_SPcc.png"></image>-->
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      <xsl:value-of select="ReferralFromShow/DRUGALLERGY"/>                      
                    </TD>
                  </TR>
                  
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/CURRENT"/>
                     
                    </TD>
                    <TD>
                      <xsl:value-of select="ReferralFromShow/TRIED"/>
                      
                    </TD>
                  </TR>
                 </table> <br/>
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
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/FAMILY"/>
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/COMPENSATION"/>
                   
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/YELLOWFLAGS"/>
                   
                  </TD>
                </TR>
               </table> <br/>
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
                    <xsl:value-of select="ReferralFromShow/CLINICIALEXAMINATION"/>

                   
                  </TD>
                </TR>
               </table> <br/>
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
                 </table> <br/>
              </td>
            </tr>
            <tr>
              <td colspan="2" align="left">
                <table>
                  <tr>
                    <td align="left">
                      (H)ASSESSMENT/DIAGNOSIS
                    </td>
                    <td align="right" rowspan="2">
                      <!--<input type="image" name="PatientImage3">
                        <xsl:attribute name="src">
                          <xsl:value-of select="ReferralFromShow/PatientSPcc3" />
                        </xsl:attribute>
                      </input>-->
                      <!--<image src="http://localhost:1690/WebApp/Images/Patient_SPcc.png"></image>-->
                    </td>
                  </tr>
                  <TR>
                    <TD>
                      <xsl:value-of select="ReferralFromShow/ASSESSMENT"/>
                    </TD>
                  </TR>
                 </table> <br/>
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
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/PROCEDURES"/>
                     
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/MEDICATIONS"/>
                     
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/INVESTIGATIONS"/>
                    
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/EDUCATION"/>
                      
                    </TD>
                  </TR>
                 </table> <br/>
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
                      <xsl:value-of select="ReferralFromShow/TCU"/>
                      
                    </TD>
                  </TR>
                 </table> <br/>
              </td>
            </tr>
          </table>
        </center>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
