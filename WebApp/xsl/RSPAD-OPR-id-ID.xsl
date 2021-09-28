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

        <table class="searchPanel w-100p Page-table">
          <!--<tr Width="100%">

                            <td class="a-left" width="5%" valign ="top">
                                <input type="image" name="imagem">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="OPR/src" />
                                    </xsl:attribute>
                                </input>
                            </td>
                            <td align="left" nowrap="nowrap" Width="5%" valign ="bottom">
                                <h6>
                                    <br/>
                                    <br/>
                                    DIREKTORAT KESEHATAN ANGKATAN DARAT  <br/>
                                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;RSPAD GATOT SOEBROTO
                                    <hr/>
                                </h6>

                            </td>
                        </tr>-->
          <tr>
            <td nowrap="nowrap" colspan="2" class="a-center bold">
              <b>
                LAPORAN PELAKSANAAN OPERASI<BR/>
                HARI/TGL : <xsl:value-of select="OPR/Day" />  ,<xsl:value-of select="OPR/Date" />
              </b>
            </td >
          </tr>
          <tr>
            <td colspan="2">
              <table class="w-100p" border="1">
                <tr class="panelHeader">
                  <td class="a-left" nowrap="nowrap">
                    <B>OK</B>
                  </td>
                  <td class="a-left" nowrap="nowrap">
                    <B>NO</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>NAMA PASIEN</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>UMUR</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>PANGKAT</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>RU</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>DIAGNOSA</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>TINDAKAN</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>SURGERY</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap" colspan="3">
                    <center>
                      <B>HADIR</B>
                    </center>
                  </td>
                  <td  class="a-left" nowrap="nowrap" colspan="2">
                    <center>
                      <B>INDUKSI</B>
                    </center>
                  </td>
                  <td  class="a-left" nowrap="nowrap" colspan="3">
                    <center>
                      <B>OPERASI</B>
                    </center>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>OPERATOR</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>HASIL PASCA OPERAS</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>KIT</B>
                  </td>
                </tr>
                <tr class="gridView">
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">
                  </td>
                  <td class="a-left" nowrap="nowrap">
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>OK</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>PRS</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>OPT</B>
                  </td>
                  <td class="a-left" nowrap="nowrap">
                    <B>MULAI</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>OLEH</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>MULAI</B>
                  </td>
                  <td class="a-left" nowrap="nowrap">
                    <B>SELESAI</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">
                    <B>KEL RR</B>
                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                  <td  class="a-left" nowrap="nowrap">

                  </td>
                </tr>
                <xsl:for-each select="OPR/BillingDetails">
                  <tr>
                    <td  class="a-left" nowrap="nowrap">
                      <xsl:value-of select="RoomName" />
                    </td>
                    <td class="a-left">
                      <xsl:value-of select="NO" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="PatientName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="AgeText" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="ClientName" />
                    </td>
                    <td class="a-left" nowrap="nowrap" >
                      <xsl:value-of select="WardName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="ComplicationName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="ProcedureName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="IPTreatmentPlanName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="FromTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="PatientArrivalTimeOT" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="SurgeonArrivalTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="AnesthesiaTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="AnesthesiastName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="OperationStartTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="OperationEndTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="ToTime" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="SurgeonName" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="SurgeryType" />
                    </td>
                    <td class="a-left" nowrap="nowrap">
                      <xsl:value-of select="Remarks" />
                    </td>
                  </tr>
                </xsl:for-each>
                <tr class="a-right">
                  <td colspan="20" class="a-right">
                    <table class="a-right w-100p">
                      <tr>
                        <td>
                          Jakarta,<xsl:value-of select="OPR/Date" />
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Kapala Instalsi Kamar Operasi
                        </td>
                      </tr>
                      <tr>
                        <br/>
                        <br/>
                        <br/>
                        <td>
                          dr.R.Bebet Prasetyo.Sp.U<br/>
                          Kolanel Ckm NRP.33564
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
