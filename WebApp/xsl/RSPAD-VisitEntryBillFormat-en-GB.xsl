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

        <table style="font-size:10px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="30%">

          <tr>
            <td align="center">
              <table width="40%">
                <tr>
                  <td align="left" width="10%">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="GenerateVisit/src" />
                      </xsl:attribute>
                    </input>
                  </td>
                  <td align="left" nowrap="nowrap" style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">
                    <center>
                      <h5>
                        RSPAD GATOT SOEBROTO DITKESAD
                        <br/>
                          JL.Abdul Rahman Saleh No.24,Jakarta Pusat<br/>
                        Telp.021-3441008,3840702, Fax : 021-3520619<br/>
                        <xsl:value-of select="GenerateVisit/Department"/> -    <xsl:value-of select="GenerateVisit/Speciality"/>

                      </h5>

                    </center>
                  </td>
                </tr>

              </table>
            </td>
          </tr>
          <tr>
            <td width="100%">
              <hr></hr>
            </td>
          </tr>
          <tr>
            <td align="center">
              <table>
                <tr>
                  <td>
                    <b>
                      PROOF OF OUTPATIENT SERVICES
                    </b>
                  </td>
                </tr>
              </table>
            </td>

          </tr>
          <tr>
            <td>
              <br/>
            </td>
          </tr>        

          <tr>
            <td  align="center">
              <table width="100%">
                <tr>
                  <td>UHID</td>
                  <td valign="top" >
                    :   <xsl:value-of select="GenerateVisit/PatientNumber"/>
                  </td>

                  <td>DOB</td>
                  <td valign="top" >
                    :   <xsl:value-of select="GenerateVisit/DOB"/>
                  </td>
                </tr>
                <tr>
                  <td>Patient Name</td>
                  <td valign="top">
                    :   <xsl:value-of select="GenerateVisit/PatientName"/>
                  </td>
                  <td>Visit Date</td>
                  <td valign="top">
                    :   <xsl:value-of select="GenerateVisit/VisitDate"/>
                  </td>
                </tr>
                <tr>
                  <td>Name of Poly Clinic</td>
                  <td valign="top">
                    :    <xsl:value-of select="GenerateVisit/DeptName"/>
                  </td>
                  <td>Sex</td>
                  <td valign="top">
                    :     <xsl:value-of select="GenerateVisit/Gender"/>
                  </td>
                </tr>

              </table>
            </td>
          </tr>
          <tr>
            <td>
              <br/>
            </td>
          </tr>
          <tr>
            <td  align="center">
              <table width="100%">
                <tr>
                  <td> S.No</td>
                  <td> Item Name</td>
                  <td> Performing Physician Name</td>
                  <td> Amount</td>
                </tr>
                <tr>
                  <td colspan="4">
                    <hr></hr>
                  </td>
                </tr>
                <xsl:for-each select="GenerateVisit/Items">
                  <tr>
                    <td>
                      <xsl:value-of select="SNo" />
                    </td>
                    <td>
                      <xsl:value-of select="Item" />
                    </td>
                    <td>
                      <xsl:value-of select="RefPhysician" />
                    </td>
                    <td>
                      <xsl:value-of select="Amount" />
                    </td>
                  </tr>
                  <!--<tr>
                    <td colspan="4">
                      <hr></hr>
                    </td>
                  </tr>-->
                </xsl:for-each>
                <tr>
                  <td colspan="4">
                    <hr></hr>
                  </td>
                </tr>

                <tr>
                  <td colspan="2">
                    
                  </td>
                  <td  align="left">
                    
                      Total
                    
                  </td>
                  <td valign="top">

                    <xsl:value-of select="GenerateVisit/TotalAmount"/>

                  </td>
                </tr>
                  <tr>
                      <td colspan="2">

                      </td>
                      <td  align="left">

                          Administrative Charges

                      </td>
                      <td valign="top">

                          <xsl:value-of select="GenerateVisit/AdministrativeCharges"/>

                      </td>
                  </tr>
                  <tr>
                      <td colspan="2">

                      </td>
                      <td  align="left">

                          Net Amount

                      </td>
                      <td valign="top">

                          <xsl:value-of select="GenerateVisit/NetAmount"/>

                      </td>
                  </tr>

                  <tr>
                  <td valign="top" colspan="4" align="right">
                    <xsl:value-of select="GenerateVisit/LocationName"/> ,
                    <xsl:value-of select="GenerateVisit/VisitingDate"/>

                  </td>

                </tr>
                <tr>
                  <td colspan="4" align="center">
                    <table width="100%">

                      <tr>
                        <td align="right">Officer/Doctor</td>
                        <td align="right">Patient</td>
                        <td align="right">Officer In-Charge</td>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <br/>
                        </td>
                      </tr>
                      <tr>
                        <td align="right">(..................)</td>
                        <td align="right">(..................)</td>
                        <td align="right">(..................)</td>
                      </tr>
                      <tr>
                        <td></td>
                      </tr>
                      <tr>
                        <td>
                          <div style="width: 20%; padding-left: 20px;">
                          <u>
                            <b>
                              Note:
                            </b>
                          </u>
                          </div>
                        </td>

                      </tr>
                      <tr>
                        <td>
                          <div style="width: 90%; padding-left: 12px;">
                          1.White for Patients
                          </div>
                        </td>

                      </tr>
                      <tr >
                       
                        <td>
                          <div style="width: 90%; padding-left: 1px;">
                          2.Yellow for Poly
                           </div>
                        </td>

                      </tr>
                      <tr>
                        <td>
                          <div style="width: 90%; padding-left: 10px;">
                            3.Red for CheckOut
                          </div>
                        </td>

                      </tr>

                    </table>
                  </td>
                </tr>

              </table>

            </td>

          </tr>
      
          <!--<tr>
            <td  align="right">
              <table width="80%">
                <tr>
                  <td valign="top" align="center">
                    <xsl:value-of select="GenerateVisit/LocationName"/> ,
                    <xsl:value-of select="GenerateVisit/VisitingDate"/>

                  </td>
                </tr>
              </table>
            </td>

          </tr>-->
          <!--<tr>
            <td align="center">
              <table width="80%">

                <tr>
                  <td>Officer/Doctor</td>
                  <td>Patient</td>
                  <td>Officer In-Charge</td>
                </tr>
                <tr>
                  <td colspan="3">
                    <br/>
                  </td>
                </tr>
                <tr>
                  <td>(..................)</td>
                  <td>(..................)</td>
                  <td>(..................)</td>
                </tr>
                <tr>
                  <td></td>
                </tr>
                <tr>
                  <td colspan="3">
                    <u>
                      <b>
                        Note:
                      </b>
                    </u>
                  </td>

                </tr>
                <tr>
                  <td colspan="3">
                    1.White for Patients
                  </td>

                </tr>
                <tr>
                  <td colspan="3">
                    2.Yellow for Poly
                  </td>

                </tr>
                <tr>
                  <td colspan="3">
                    3.Red for CheckOut
                  </td>

                </tr>

              </table>
            </td>
          </tr>-->
        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
