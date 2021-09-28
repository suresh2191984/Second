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
    <html xmlns="http://www.w3.org/1999/xhtml" encoding="utf-8">

      <body>

        <table style="font-size:12px;font-family:Arial;border-collapse: separate;border-spacing: 2px;" class="dataheaderInvCtrl" Width="100%">
          <tr Width="100%">
            <td nowrap="nowrap" colspan="2">
              <table Width="50%">
                <tr>
                  <td align="left" width="5%" valign ="top">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="CaseSheet/src" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td align="left" nowrap="nowrap" Width="50%" valign ="bottom">
                    <h4 style="font-weight:bold;font-size:18px;width:100%;">
                      <br/>
                      <xsl:value-of select="CaseSheet/OrgName"/>,
                    </h4>
                    <h5 style="font-weight:bold;font-size:16px;">
                      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="CaseSheet/Location"/>
                    </h5>
                  </td>
                </tr>
              </table>
            </td >
          </tr>
          <tr width="100%">
            <td colspan="2" align="left" width="100%">
              <table width="100%">
                <tr>
                  <td align="center" colspan="2" width="100%">
                    <table width="100%" border="1">
                      <tr>
                        <td Width="40%" valign ="top" align="center" >
                          <h4 style="font-weight:bold;font-size:20px;"> Aesthetic Case Sheet </h4>
                          <br/>
                        </td>
                        <td Width="40%">
                          <table>
                            <tr>
                              <td style="font-weight:bold;" align="left">
                                <b>Patient Name</b>
                              </td>
                              <td style="font-weight:bold;" align="left">
                                :
                              </td>
                              <td align="left">
                                <xsl:value-of select="CaseSheet/Name"/>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <br/>
                              </td>
                            </tr>
                            <tr>
                              <td style="font-weight:bold;" align="left">
                                <b>NO.RM</b>
                              </td>
                              <td style="font-weight:bold;" align="left">
                                :
                              </td>
                              <td align="left">
                                <xsl:value-of select="CaseSheet/PatientNumber"/>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <br/>
                              </td>
                            </tr>
                            <tr>
                              <td style="font-weight:bold;" align="left">
                                <b>DOB</b>
                              </td>
                              <td style="font-weight:bold;" align="left">
                                :
                              </td>
                              <td align="left">
                                <xsl:value-of select="CaseSheet/DOB"/>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <br/>
                              </td>
                            </tr>
                            <tr>
                              <td style="font-weight:bold;" align="left">
                                <b>Sex</b>
                              </td>
                              <td style="font-weight:bold;" align="left">
                                :
                              </td>
                              <td align="left">
                                <xsl:value-of select="CaseSheet/Sex"/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" width="100%">
                          <table width="100%">
                            <tr>
                              <td align="left">
                                <span  style="font-weight:bold;">Visit Date</span >
                                &#160;&#160;
                                : <xsl:value-of select="CaseSheet/VisitDate"/>
                              </td>
                              <td align="left">
                                <span  style="font-weight:bold;">Time</span >
                                &#160;&#160;
                                : <xsl:value-of select="CaseSheet/VisitTime"/>
                              </td>
                              <td align="left">
                                <xsl:if test ="CaseSheet/SpecialityName!=''">
                                  <span  style="font-weight:bold;">Speciality</span > :
                                </xsl:if>
                                <xsl:value-of select="CaseSheet/SpecialityName"/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <xsl:if test ="CaseSheet/After!='' or CaseSheet/Before!=''">
                  <tr>
                    <xsl:if test ="CaseSheet/Before!=''">
                      <td>
                        <input type="image" name="imagBefore" Id="imagBefore">
                          <xsl:attribute name="src">
                            <xsl:if test="CaseSheet/Before!=''">
                              <xsl:value-of select="CaseSheet/Before" />
                            </xsl:if>
                          </xsl:attribute>
                        </input>
                      </td>
                    </xsl:if>
                    <xsl:if test ="CaseSheet/After!=''">
                      <td>
                        <input type="image" name="imagAfter" Id="imagAfter">
                          <xsl:attribute name="src">
                            <xsl:if test="CaseSheet/After!=''">
                              <xsl:value-of select="CaseSheet/After" />
                            </xsl:if>
                          </xsl:attribute>
                        </input>
                      </td>
                    </xsl:if>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/Physician!=''">
                  <tr>
                    <td align="left" colspan="2">

                      <span style="font-weight:bold;">Physician Name </span>
                      :
                      <xsl:value-of select="CaseSheet/Physician"/>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/Complaint!='' or  CaseSheet/Expected!='' or  CaseSheet/HistCus!='' or  CaseSheet/RoutDrug!='' or  CaseSheet/KB!='' or  CaseSheet/PrevHist!='' or  CaseSheet/ProcedureNotes!=''  or  CaseSheet/Anesthesia!='' or  CaseSheet/PrevFood!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table class="w-100p searchPanel" width="100%" style="background: #fff;border: 1px solid #ccc;border-top: 1px solid #3B90D0;">
                        <tr class="gridHeader">
                          <td style="    border-bottom: 1px dotted #ccc;color: #3B90D0;background-color: #f0f0f0;">
                            <span style="font-weight:bold;">Histroy</span >
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table class="w-50p gridView" width="50%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                              <xsl:if test ="CaseSheet/Complaint!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Complaint
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Complaint"/>
                                  </td>

                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Expected!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Expected  Result
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Expected"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/HistCus!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    History of Customer
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/HistCus"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/RoutDrug!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Routine Drugs
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/RoutDrug"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/DrugAllergy!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Drug / Food Allergy
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/DrugAllergy"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/KB!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    KB
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/KB"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/PrevHist!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Previous History
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/PrevHist"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/ProcedureNotes!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Procedure Notes
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/ProcedureNotes"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Anesthesia!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Name of the Anesthesia
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Anesthesia"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/PrevFood!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Food taken Previously
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/PrevFood"/>
                                  </td>
                                </tr>
                              </xsl:if>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </xsl:if>                
                <tr>
                  <td>
                    <table class="w-100p searchPanel" width="100%" style="background: #fff;border: 1px solid #ccc;border-top: 1px solid #3B90D0;">
                      <tr class="gridHeader">
                        <td style="border-bottom: 1px dotted #ccc;color: #3B90D0;background-color: #f0f0f0;">
                          <span style="font-weight:bold;">Vitals</span>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <table class="w-100p gridView" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                            <xsl:if test ="CaseSheet/CaptureDate!=''">
                              <tr>
                                <td colspan="4"  style="font-weight:bold;text-align:left;">
                                  Capture Date : <xsl:value-of select="CaseSheet/CaptureDate"/>
                                </td>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/Temp!='' or CaseSheet/Pulse!=''">
                              <tr>
                                <xsl:if test ="CaseSheet/Temp!=''">
                                  <td  style="font-weight:bold;text-align:left;">
                                    Temp
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Temp"/>
                                  </td>
                                </xsl:if>
                                <xsl:if test ="CaseSheet/Pulse!=''">
                                  <td  style="font-weight:bold;text-align:left;">
                                    Pulse
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Pulse"/>
                                  </td>
                                </xsl:if>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/Height!='' or CaseSheet/Weight!=''">
                              <tr>
                                <xsl:if test ="CaseSheet/Height!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Height
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Height"/>
                                  </td>
                                </xsl:if>
                                <xsl:if test ="CaseSheet/Weight!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    Weight
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Weight"/>
                                  </td>
                                </xsl:if>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/SpO2!='' or CaseSheet/RR!=''">
                              <tr>
                                <xsl:if test ="CaseSheet/SpO2!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    SpO2
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/SpO2"/>
                                  </td>
                                </xsl:if>
                                <xsl:if test ="CaseSheet/RR!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    RR
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/RR"/>
                                  </td>
                                </xsl:if>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/WC!='' or CaseSheet/HC!=''">
                              <tr>
                                <xsl:if test ="CaseSheet/WC!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    WC
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/WC"/>
                                  </td>
                                </xsl:if>
                                <xsl:if test ="CaseSheet/HC!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    HC
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/HC"/>
                                  </td>
                                </xsl:if>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/SBP!='' or CaseSheet/DBP!=''">
                              <tr>
                                <xsl:if test ="CaseSheet/SBP!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    SBP
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/SBP"/>
                                  </td>
                                </xsl:if>
                                <xsl:if test ="CaseSheet/DBP!=''">
                                  <td  style="font-weight:bold;text-align:left;" >
                                    DBP
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/DBP"/>
                                  </td>
                                </xsl:if>
                              </tr>
                            </xsl:if>
                            <xsl:if test ="CaseSheet/BMI!=''">
                              <tr>
                                <td  style="font-weight:bold;text-align:left;" >
                                  BMI
                                </td>
                                <td>
                                  <xsl:value-of select="CaseSheet/BMI"/>
                                </td>
                              </tr>
                            </xsl:if>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <xsl:if test ="CaseSheet/Head!='' or  CaseSheet/Neck!='' or  CaseSheet/Thorax!='' or  CaseSheet/Pulmonary!='' or  CaseSheet/Coronary!='' or  CaseSheet/Abdomen!='' or  CaseSheet/Genetalia!=''  or  CaseSheet/UpperLimbs!='' or  CaseSheet/LowerLimbs!=''">

                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table class="w-100p searchPanel" width="100%" style="background: #fff;border: 1px solid #ccc;border-top: 1px solid #3B90D0;">
                        <tr class="gridHeader">
                          <td style="    border-bottom: 1px dotted #ccc;color: #3B90D0;background-color: #f0f0f0;">
                            <span style="font-weight:bold;">General Status</span>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table class="w-50p gridView" width="50%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                              <xsl:if test ="CaseSheet/Head!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Head
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Head"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Neck!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Neck
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Neck"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Thorax!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Thorax
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Thorax"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Pulmonary!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Pulmonary
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Pulmonary"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Coronary!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Coronary
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Coronary"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Abdomen!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Abdomen
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Abdomen"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/Genetalia!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Genetalia
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/Genetalia"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/UpperLimbs!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Upper Limbs
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/UpperLimbs"/>
                                  </td>
                                </tr>
                              </xsl:if>
                              <xsl:if test ="CaseSheet/LowerLimbs!=''">
                                <tr>
                                  <td  style="font-weight:bold;text-align:left;">
                                    Lower Limbs
                                  </td>
                                  <td>
                                    <xsl:value-of select="CaseSheet/LowerLimbs"/>
                                  </td>
                                </tr>
                              </xsl:if>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/ICD9!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span style="font-weight:bold;">Procedure</span >
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p gridView" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                          <th align="left" class="w-5p">Sl.No</th>
                          <th align="left">Procedure</th>
                        </tr>
                        <xsl:for-each select="CaseSheet/ICD9">
                          <tr>
                            <td>
                              <xsl:value-of select="NO"/>
                            </td>
                            <td>
                              <xsl:value-of select="Procedure"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/Investigation!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span style="font-weight:bold;">Investigation</span >
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p gridView" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                          <th align="left" class="w-5p">Sl.No</th>
                          <th align="left">Investigation Name</th>
                          <th align="left">Value</th>
                        </tr>
                        <xsl:for-each select="CaseSheet/Investigation">
                          <tr>
                            <td>
                              <xsl:value-of select="NO"/>
                            </td>
                            <td>
                              <xsl:value-of select="InvestigationName"/>
                            </td>
                            <td>
                              <xsl:value-of select="Value"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/PrescriptionNumber!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p">
                        <tr>
                          <td >
                            <span style="font-weight:bold;">Prescription Number </span >
                            : <xsl:value-of select="CaseSheet/PrescriptionNumber"/>
                          </td>
                        </tr>
                      </table >
                    </td >
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="gridView w-100p" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                          <th align="left" class="w-5p">Sl.No</th>
                          <th align="left">BrandName</th>
                          <th align="left">Formulation</th>
                          <th align="left">Duration</th>
                          <th align="left">Direction</th>
                          <th align="left">Instruction</th>
                        </tr>
                        <xsl:for-each select="CaseSheet/Prescription">
                          <tr>
                            <td>
                              <xsl:value-of select="NO"/>
                            </td>
                            <td>
                              &#160;&#160;<xsl:value-of select="BrandName"/>
                            </td>
                            <td>
                              &#160;&#160;<xsl:value-of select="Formulation"/>
                            </td>

                            <td>
                              &#160;&#160;<xsl:value-of select="Duration"/>
                            </td>
                            <td>
                              &#160;&#160;<xsl:value-of select="Direction"/>
                            </td>
                            <td>
                              &#160;&#160;<xsl:value-of select="Instruction"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/GeneralAdvice!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span style="font-weight:bold;">General Advice</span >
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p gridView" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                          <th class="w-5p">Sl.No</th>
                          <th align="left">Description</th>
                        </tr>
                        <xsl:for-each select="CaseSheet/GeneralAdvice">
                          <tr>
                            <td>
                              <xsl:value-of select="NO"/>
                            </td>
                            <td>
                              <xsl:value-of select="Description"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/Others!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span style="font-weight:bold;">Others</span >
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p gridView" width="100%" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                        <tr>
                          <th class="w-5p">Sl.No</th>
                          <th align="left">Description</th>
                        </tr>
                        <xsl:for-each select="CaseSheet/Others">
                          <tr>
                            <td>
                              <xsl:value-of select="NO"/>
                            </td>
                            <td>
                              <xsl:value-of select="HistoryName"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:if test ="CaseSheet/NextReViewDate!=''">
                  <tr>
                    <td>
                      <br/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <table class="w-100p" width="100%">
                        <tr>
                          <td>
                            <span style="font-weight:bold;">Next Review Date </span >
                            : <xsl:value-of select="CaseSheet/NextReViewDate"/>
                          </td>
                          <td align="right" colspan="2">
                            <span style="font-weight:bold;margin-right:5%" >Doctor's Signature </span >
                           </td>
                          </tr>
                        <tr>
                          <td colspan="2"></td>
                          <td colspan="2" align="right">
                        <input type="image" name="imgview" id="imgview" style="width:200px;height:75px;">
                          <xsl:attribute name="src">
                            <xsl:value-of select="CaseSheet/LoginSign" />
                          </xsl:attribute>
                        </input>
                          </td>
                        </tr>


                      </table >
                      
                    </td >
                  </tr>
                </xsl:if>
              </table>
            </td>
          </tr>
        </table>

       
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
