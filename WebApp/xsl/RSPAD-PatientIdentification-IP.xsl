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
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <body>
              <div style="width:100%;float:left;letter-spacing:1px;">
                <div style="width:100%;float:left;margin-top:30px;">
                  
                  <div style="width:100%;float:left;">
                    
                    <div  style="width:50%;float:left;">
                      
                      <div id="divPatientName" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/PatientName=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/PatientName"/>
                      </div>
                    </div>
                    
                    <div  style="width:50%;float:left;">
                      <div id="divPatientNumber" style="width:47%;float:left;font-weight: bold;padding-left:53%;white-space: nowrap;">
                        <xsl:if test ="PatientIdentificationSheet/PatientNumber=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/PatientNumber"/>
                      </div>
                    </div>
                    
                  </div>

                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divDOB" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/DOB=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/DOB"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divGender" style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                        <xsl:if test ="PatientIdentificationSheet/Gender=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Gender"/>
                      </div>
                    </div>
                  </div>


                  <div style="width:100%;float:left;">
                    <div id="divAddress"  style="width:50%;float:left;">
                      <div  style="width:53.5%;float:left;padding-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/Address=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Address"/>
                      </div>
                    </div>

                    <div style="width:50%;float:left;">

                      <div id="divMobileNo"  style="width:100%;float:left;">
                        <div  style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                          <xsl:if test ="PatientIdentificationSheet/MobileNo=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/MobileNo"/>
                        </div>
                      </div>


                      <div id="divTeleNo" style="width:100%;float:left;">
                        <div style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                          <xsl:if test ="PatientIdentificationSheet/TeleNo=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/TeleNo"/>
                        </div>
                      </div>

                      <div id="divMobileNo" style="width:100%;float:left;">
                        <div style="width:46.5%;float:left;padding-left:53.5%;white-space: nowrap;">
                          <!--<xsl:if test ="PatientIdentificationSheet/MobileNo=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/MobileNo"/>-->
                          --
                        </div>
                      </div>

                    </div>
                  </div>


                  <div style="width:100%;float:left;padding-top:10px;">
                    <div  style="width:50%;float:left;">
                      <div id="divRace" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/Race=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Race"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divURNNo" style="width:47%;float:left;padding-left:53%;">
                        <xsl:if test ="PatientIdentificationSheet/URNNo=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/URNNo"/>
                      </div>
                    </div>
                  </div>


                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divCountry" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/Country=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Country"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divReligion" style="width:47%;float:left;padding-left:53%;">
                        <xsl:if test ="PatientIdentificationSheet/Religion=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Religion"/>
                      </div>
                    </div>
                  </div>

                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divPatientStatus" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/PatientStatus=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/PatientStatus"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divMaritalStatus" style="width:47%;float:left;padding-left:53%;">
                        <xsl:if test ="PatientIdentificationSheet/MaritalStatus=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/MaritalStatus"/>
                      </div>
                    </div>
                  </div>

                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divOccupation" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/Occupation=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Occupation"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divCorps" style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                        <xsl:if test ="PatientIdentificationSheet/Corps=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Corps"/>
                      </div>
                    </div>
                  </div>


                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divDesignation" style="width:53.5%;float:left;margin-left:46.5%;font-size:12px;font-family:Arial;">
                        <xsl:if test ="PatientIdentificationSheet/Designation=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/Designation"/>
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divFieldArea" style="width:47%;float:left;padding-left:53%;white-space: nowrap;font-size:12px;font-family:Arial;">
                        <xsl:if test ="PatientIdentificationSheet/FieldArea=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/FieldArea"/>
                      </div>
                    </div>
                  </div>


                  <div style="width:100%;float:left;">
                        
                            <div  style="width:50%;float:left;">
                              <div id="divVisitDate" style="width:53.5%;float:left;margin-left:46.5%;font-size:12px;font-family:Arial;">
                                <xsl:if test ="PatientIdentificationSheet/VisitDate=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
                              </div>
                            </div>
                            <div  style="width:50%;float:left;">
                              <div id="divRateCardName" style="width:47%;float:left;padding-left:53%;white-space: nowrap;font-size:12px;font-family:Arial;">
                                <xsl:if test ="PatientIdentificationSheet/RateCardName=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="PatientIdentificationSheet/RateCardName"/>
                              </div>
                            </div>
                     
                    </div>
                  
                  <div style="width:100%;float:left;">
                    <div  style="width:50%;float:left;">
                      <div id="divVisitTime" style="width:53.5%;float:left;margin-left:46.5%;font-size:12px;font-family:Arial;">
                        <xsl:if test ="PatientIdentificationSheet/VisitTime=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/VisitTime"/>
                      </div>
                    </div>
                  </div>
                  
                  

                  <div style="width:100%;float:left;margin-top:32px;">
                    <div  style="width:50%;float:left;">
                      <div id="divRelationName" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/RelationName=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelationName"/>
                      
                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divRelationShip" style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                        <xsl:if test ="PatientIdentificationSheet/RelationShip=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelationShip"/>
                      </div>
                    </div>
                  </div>
                  
                  
                  <div style="width:100%;float:left;">
                    
                    <div  style="width:50%;float:left;">
                      <div  style="width:100%;float:left;">
                        <div id="divRelAddress" style="width:53.5%;float:left;margin-left:46.5%;">
                          <xsl:if test ="PatientIdentificationSheet/RelAddress=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/RelAddress"/>

                        </div>
                      </div>
                    </div>
                    
                    
                    <div  style="width:50%;float:left;">
                      <div  style="width:100%;float:left;">
                        <div id="divRelMobNo" style="width:46.5%;float:left;padding-left:53.5%;white-space: nowrap;">
                          <xsl:if test ="PatientIdentificationSheet/RelMobNo=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/RelMobNo"/>
                        </div>
                      </div>
                      <div  style="width:100%;float:left;">
                        <div id="divRelTelNo" style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                          <xsl:if test ="PatientIdentificationSheet/RelTelNo=''">
                            &#160;&#160;
                          </xsl:if>
                          <xsl:value-of select="PatientIdentificationSheet/RelTelNo"/>
                        </div>
                      </div>
                    </div>
                    
                    
                  </div>


                  <div style="width:100%;float:left;margin-top:27px;">
                    <div  style="width:50%;float:left;">
                      <div id="divAdmissionDiagsName" style="width:53.5%;float:left;margin-left:46.5%;">
                        <xsl:if test ="PatientIdentificationSheet/AdmissionDiagsName=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/AdmissionDiagsName"/>

                      </div>
                    </div>
                    <div  style="width:50%;float:left;">
                      <div id="divAdmissionICD10" style="width:47%;float:left;padding-left:53%;white-space: nowrap;">
                        <xsl:if test ="PatientIdentificationSheet/AdmissionICD10=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/AdmissionICD10"/>
                      </div>
                    </div>
                  </div>



                </div>
              </div>
                   
            </body>
            </meta>
        </html>
    </xsl:template>
</xsl:stylesheet>
