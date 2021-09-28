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
        <!--<link rel="stylesheet" type="text/css" href="table.css"
             title="Style"/>-->
    

        <body>
          <div style="width:100%;float:left;letter-spacing: 1px;">
            <div style="width:100%;float:left;margin-top:47px;">
              <!-- CaptureName And RM Number-->
              <div id="divNameRmNo" style="width:100%;float:left;">
                <div  id="divHospitalNames" style="width:50%;float:left;">
                  <div id="divHospitalName" style="width:100%;float:left;">
					  &#160;&#160;
                  </div>
                </div>
                <div id="divnamermsex"  style="width:50%;float:left;">
                  <div id="divPatientName" style="font-size:12px;font-family:Arial;width:76%;float:left;white-space: nowrap;padding-left:24%;">
                    <xsl:if test ="PatientIdentificationSheet/PatientName=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/PatientName"/>
                  </div>
                  <div id="divRMNo" style="width:100%;float:left;padding-top:2.2%;" >
                    <div id="divMedicalRecordNo" style="width:76%;float:left;font-size:26px;font-family:Times New Roman;font-weight: bold;padding-left:24%;">
                      <xsl:if test ="PatientIdentificationSheet/MedicalRecordNo=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/MedicalRecordNo"/>
                    </div>
                  </div>
                  <div id="divDOBSex" style="width:100%;float:left;font-size:12px;font-family:Arial;padding-top:1.78%;" >
                    <div  style="width:80%;float:left;white-space: nowrap;">
                    <div  style="width:80%;float:left;white-space: nowrap;padding-left:30%;">
                      <xsl:if test ="PatientIdentificationSheet/DOB=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/DOB"/>
                    </div>
                    </div>
                    <div id="divSex" style="width:20%;float:left;">
                      <div id="divmale" class="plus" style ="width:25%;float:left;">
                        <!--<input type="image" name="imagem">
                          <xsl:attribute name="src">
                            <xsl:value-of select="PatientAdmissionLetter/src" />
                          </xsl:attribute>
                        </input>-->
                      </div>
                      <div id="divfemale" class="ui-icon ui-icon-plus b-none" style ="width:25%;float:left;">
                        <!--<input type="image" name="imagem">
                          <xsl:attribute name="src">
                            <xsl:value-of select="PatientAdmissionLetter/src" />
                          </xsl:attribute>
                        </input>-->
                      </div>
                    </div>
                  </div>
                  
                </div>
              </div>


              <!-- Visit Date And Time-->

              <div id="divVisitAndTime" style="width:100%;float:left;padding-top:3.1%;">
                <div id="divVisitDate"  style="width:50%;float:left;">
                  <div style="width:66%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:34%;">
                    <xsl:if test ="PatientIdentificationSheet/VisitDate=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
                  </div>
                </div>
                <div id="divVisitTime" style="width:50%;float:left;">
                  <div style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
                    <xsl:if test ="PatientIdentificationSheet/VisitTime=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/VisitTime"/>
                  </div>
                </div>
              </div>

              <!-- Education Details-->

              <div id="divEducDetails" style="width:100%;float:left;padding-top:4.4%;">
                <div id="divEducation" style="width:100%;float:left;font-size:12px;font-family:Arial;">
                  <div id="divEducDetails" style="width:80%;float:left;font-size:12px;font-family:Arial;padding-left:20%;">
                    <xsl:if test ="PatientIdentificationSheet/Qualification=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/Qualification"/>
                  </div>
                </div>
                <div id="divOccuptionArmy"  style="width:100%;float:left;padding-top:2.7%;">
                  <div id="divOccuptiondec" style="width:50%;float:left;">
                    <div id="divOccuptionde" style="width:100%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                    <xsl:if test ="PatientIdentificationSheet/OCCUPATION=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/OCCUPATION"/>
                      </div>
                  </div>
                  <div id="divCorps" style="width:50%;float:left;">
                    <div  style="width:55%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:45%;">
                      <xsl:if test ="PatientIdentificationSheet/Corps=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/Corps"/>
                    </div>
                  </div>
                </div>

                <div id="divTileandNRP" style="width:100%;float:left;padding-top:2.4%;">

                  <div id="divDesignation" style="width:50%;float:left;">
                    <div style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                      <xsl:if test ="PatientIdentificationSheet/Designation=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/Designation"/>
                    </div>
                  </div>


                  <div id="divEmployeeNo" style="width:50%;float:left;">
                    <div style="width:55%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:45%;">
                      <xsl:if test ="PatientIdentificationSheet/EmployeeNo=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/EmployeeNo"/>
                    </div>
                  </div>

                </div>
                
                <div id="divRaceNation" style="width:100%;float:left;padding-top:2.8%;">
                  <div id="divRace"  style="width:50%;float:left;">
                    <div  style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                      <xsl:if test ="PatientIdentificationSheet/Race=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/Race"/>
                    </div>
                  </div>
                  <div id="divNationality" style="width:50%;float:left;">
                    <div style="width:55%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:45%;">
                      <xsl:if test ="PatientIdentificationSheet/Nationality=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/Nationality"/>
                    </div>
                  </div>
                </div>
                <div id="divReligionmaritial" style="width:100%;float:left;padding-top:2.6%;">
                  <div id="divReligion" style="width:50%;float:left;">
                    <div style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                      <xsl:if test ="PatientIdentificationSheet/Religion=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/Religion"/>
                    </div>
                  </div>
                  <div id="divMartialStatus" style="width:50%;float:left;">
                    <div style="width:55%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:45%;">
                      <xsl:if test ="PatientIdentificationSheet/MartialStatus=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/MartialStatus"/>
                    </div>
                  </div>
                </div>
              
              </div>

              <!-- Main Address Details-->
              
              <div id="divMainAddressDetails" style="width:100%;float:left;padding-top:4.7%;">
                <div id="divAddress"  style="width:100%;float:left;">
                  <div  style="width:80%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:18%;">
                    <xsl:if test ="PatientIdentificationSheet/Address=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/Address"/>
                  </div>
                </div>
                <div id="divTelephonedetails" style="width:100%;float:left;padding-top:6.7%;">
                  <div id="divTelephonedetails50" style="width:50%;float:left;">
                  <div id="divTelephoneNo" style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                    <xsl:if test ="PatientIdentificationSheet/MobileNo=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/MobileNo"/>
                  </div>
                  </div>
                  <div id="divHphone" style="width:50%;float:left;white-space: nowrap;">
                    <div id="divHphone" style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
                    <xsl:if test ="PatientIdentificationSheet/TeleNo=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="PatientIdentificationSheet/TeleNo"/>
                  </div>
                 </div>
                </div>
              </div>

              <!-- Relationship Address Details-->

              <div id="NameAddress1details" style="width:100%;float:left;padding-top:7.05%;">
                
                
                <div id="divName1Phone1"  style="width:100%;float:left;">
                  <div id="divName1Phone1c"  style="width:50%;float:left;">
                      <div id="divRelationName1"  style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                        <xsl:if test ="PatientIdentificationSheet/RelationName=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelationName"/>
                      </div>
                   </div>
                  <div id="divPhone1c"  style="width:50%;float:left;">
                    <div id="divPhone1"  style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
                      <xsl:if test ="PatientIdentificationSheet/RelationShip=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="PatientIdentificationSheet/RelationShip"/>
                    </div>
                  </div>
                </div>
                
                
                
                <div id="divAddress1Mobile1" style="width:100%;float:left;padding-top:2%;">
                  <div id="divAddress1Mobile1C" style="width:50%;float:left;">
                      <div id="divAddress1" style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                        <xsl:if test ="PatientIdentificationSheet/RelAddress=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelAddress"/>
                      </div>
                  </div>
                  <div id="divTelephone1c" style="width:50%;float:left;">
                      <div id="divTelephone1" style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
                        <xsl:if test ="PatientIdentificationSheet/RelTelNo=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelTelNo"/>
                      </div>
                  </div>
                </div>
                
                
                <div id="divPhoneHp" style="width:100%;float:left;padding-top:2%;">
                  <div id="divPhoneHpc" style="width:50%;float:left;">
                  <div id="divTelephoneemptyspace" style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
                 
                   </div>
                  </div>
                  <div id="divTelephoneHp" style="width:50%;float:left;white-space: nowrap;">
                    
                      <div style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
                        <xsl:if test ="PatientIdentificationSheet/RelOffNo=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="PatientIdentificationSheet/RelOffNo"/>
                      
                    </div>
                  </div>
                </div>

                <div id="divName2Phone2"  style="width:100%;float:left;padding-top:3.8%;">
                  <div id="divName2Phone2"  style="width:50%;float:left;">
                      <div id="divName2"  style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
						  &#160;&#160;
                      </div>
                  </div>
                  <div id="divName2Phone2"  style="width:50%;float:left;">
                       <div id="divPhone2"  style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
						   &#160;&#160;
                       </div>
                  </div>
                  
                </div>
                <div id="divAddress2Mobile2" style="width:100%;float:left;padding-top:2%;">
                  <div id="divAddress2Mobilec"  style="width:50%;float:left;">
                    <div id="divAddress2Mobilecc"  style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
						&#160;&#160;
                     </div>
                 </div>
                  <div id="divAddress2Mobilecc"  style="width:50%;float:left;">
                  <div id="divTelephone2" style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
					  &#160;&#160;
				  </div>
			  </div>
		  </div>
		  <div id="divPhoneHp2" style="width:100%;float:left;padding-top:2%;">
			  <div id="divPhoneHp2c" style="width:50%;float:left;">
				  <div id="divTelephoneemptyspace2" style="width:60%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:40%;">
					  &#160;&#160;
				  </div>
			  </div>
			  <div id="divPhoneHp2c" style="width:50%;float:left;">
				  <div id="divTelephoneHp2" style="width:45%;float:left;white-space: nowrap;font-size:12px;font-family:Arial;padding-left:55%;">
						  &#160;&#160;
                      </div>
                  </div>
                </div>
				<!--<div id="divPhoneHp2" style="width:100%;float:left;padding-top:70%;">
					end of print
			    </div>-->
                
                
                
                
              </div>
            </div>
          </div>
        </body>
      </meta>
    </html>
  </xsl:template>
</xsl:stylesheet>
