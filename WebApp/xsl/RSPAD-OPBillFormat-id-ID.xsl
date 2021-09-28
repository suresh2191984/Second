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
                <table  class="w-100p">
                    <tr>
                        <td>
                            <center>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <center>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <center>
                                                                <input type="image" name="imagem">
                                                                    <xsl:attribute name="src">
                                                                        <xsl:value-of select="OPBillFormat/src" />
                                                                    </xsl:attribute>
                                                                </input>
                                                            </center>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <center>
                                                                <h5>
                                                                  <xsl:value-of select="OPBillFormat/OrgName"/>
                                                                  <br/>
                                                                  <xsl:value-of select="OPBillFormat/Address"/>
                                                                  <br/>
                                                                  <xsl:value-of select="OPBillFormat/Location"/>
                                                                </h5>
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </center>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <hr/>
                                        </td>
                                    </tr>
                                    <tr class="w-100p mediumfon">
                                        <td>
                                            <center>
                                                <b>
                                                    <xsl:value-of select="OPBillFormat/BillName"/>
                                                </b>
                                                <br/>
                                                <xsl:if test="OPBillFormat/BillNumber!=''">
                                                    Nomor :
                                                </xsl:if>
                                                <xsl:value-of select="OPBillFormat/BillNumber"/>
                                            </center>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-100p">
                                            <table class="w-100p">
                                                <tr>
                                                    <!--<td class="w-20p"></td>
                                                <td></td>-->
                                                    <td class="a-left" nowrap="nowrap">
                                                        TERIMA DARI
                                                    </td>
                                                    <td>: </td>
                                                    <td class="a-left" nowrap="nowrap" colspan="3">
                                                        <xsl:value-of select="OPBillFormat/PaymentCollectedFrom"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <!--<td></td>
                                                <td></td>-->
                                                    <td class="a-left" nowrap="nowrap">
                                                        NOMOR RM
                                                    </td>
                                                    <td> :</td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <xsl:value-of select="OPBillFormat/PatientNumber"/>
                                                    </td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        JENIS PASIEN
                                                    </td>
                                                    <td> :</td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <xsl:value-of select="OPBillFormat/PatientStatus"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <!--<td></td>
                                                <td></td>-->
                                                    <td class="a-left" nowrap="nowrap">
                                                        NAMA PASIEN
                                                    </td>
                                                    <td> :</td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <xsl:value-of select="OPBillFormat/Name"/>
                                                    </td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        TGL.MASUK
                                                    </td>
                                                    <td> :</td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <xsl:value-of select="OPBillFormat/CreateDate"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td colspan="7">
                                                                    <hr/>
                                                                </td>
                                                            </tr>
                                                            <tr class="bold">
                                                                <td class="a-left" nowrap="nowrap">
                                                                    <B>NO</B>
                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">
                                                                    <B>
                                                                        <xsl:if test="OPBillFormat/BillNumber=''">
                                                                            Nomor
                                                                        </xsl:if>
                                                                    </B>
                                                                </td>
                                                                <td class="a-left" nowrap="nowrap" style="display:none;">
                                                                    <B>NAMA POLI</B>
                                                                </td>
                                                                <!--<td class="a-left"  nowrap="nowrap">
                                                                    <B>TGL.PELAYANAN</B>
                                                                </td>-->
                                                                <td class="a-left"  nowrap="nowrap" colspan="2">
                                                                    <B>NAMA TINDAKAN</B>
                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    <B>VOLUME</B>
                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    <B>JUMLAH</B>
                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    <B>BIAYA</B>
                                                                </td>
                                                            </tr>
                                                            <!--<tr>
                                                            <td colspan="7">
                                                                <hr/>
                                                            </td>
                                                        </tr>-->
                                                            <xsl:for-each select="OPBillFormat/BillingDetails">
                                                                <tr class="panelFooter">
                                                                    <td class="a-left">
                                                                        <xsl:value-of select="No" />
                                                                    </td>
                                                                    <td class="a-left" nowrap="nowrap">
                                                                        <xsl:value-of select="BillNumber" />
                                                                    </td>
                                                                    <td class="a-left hide" style="display:none;" nowrap="nowrap">
                                                                        <xsl:value-of select="FeeType" />
                                                                    </td>
                                                                    <!--<td class="a-left" nowrap="nowrap">
                                                                        <xsl:value-of select="CreatedAt" />
                                                                    </td>-->
                                                                    <td class="a-left" style="white-space:normal" colspan="2">
                                                                        <xsl:value-of select="FeeDescription" />
                                                                        <br/>
                                                                        <xsl:value-of select="HealthPackage" />
                                                                    </td>
                                                                    <td class="a-right" nowrap="nowrap" >
                                                                        <xsl:value-of select="Qty" />
                                                                    </td>
                                                                    <td class="a-right" nowrap="nowrap">
                                                                        <xsl:value-of select="Amount" />
                                                                    </td>
                                                                    <td class="a-right" nowrap="nowrap">
                                                                        <xsl:value-of select="NetAmount" />
                                                                    </td>
                                                                </tr>
                                                            </xsl:for-each>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <hr/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left">

                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    Sub-Total :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/GrossAmount"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                              <!--  <td class="a-right" nowrap="nowrap">

                                                                    Biaya Administrasi  :

                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/AdministrativeCharges"/>
                                                                </td>-->
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left" nowrap="nowrap"  colspan="3">
                                                                    <xsl:value-of select="OPBillFormat/AmountWord"/>
                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right"  nowrap="nowrap">
                                                                    Diskon :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/Discount"/>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    Round -Off  :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/Roundoff "/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right"  nowrap="nowrap">
                                                                    Jumlah Tagihan   :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/NetAmount"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                              <!--/sabari changes due in words(indonesia)/-->
                                                                <!--<td class="a-left"  colspan="3">

                                                                </td>-->
                                                              <!--//-->
                                                              <td class="a-left" nowrap="nowrap" colspan="3">
                                                                <xsl:if test ="OPBillFormat/Due!='0'">
                                                                  <xsl:value-of select="OPBillFormat/DueAmountinw"/>
                                                                </xsl:if>
                                                              </td>
                                                              <!--/sabari changes end/-->
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right"  nowrap="nowrap">
                                                                    Jumlah Bayar  :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/AmountReceived"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">
                                                                    Jakarta, <xsl:value-of select="OPBillFormat/CollectedDate"/>
                                                                    <br/>Kasir

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                              <!--/sabari changes start due(indonesia)/-->
                                                              
                                                              
                                                                <!--<td class="a-right"  nowrap="nowrap">
                                                                    Piutang    :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/Due"/>
                                                                </td>-->
                                                              
                                                              <td class="a-right"  nowrap="nowrap">
                                                                <xsl:if test ="OPBillFormat/Due!='0'">
                                                                  Piutang(sabari)   :
                                                                </xsl:if>
                                                              </td>
                                                              <td class="a-right" >
                                                                <xsl:if test ="OPBillFormat/Due!='0'">
                                                                  <xsl:value-of select="OPBillFormat/Due"/>
                                                                </xsl:if>
                                                               </td>
                                                              <!--/sabari changes end/-->
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    Dibayar Penjamin  :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/TPAAmount "/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">

                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left" nowrap="nowrap">

                                                                </td>
                                                                <td class="a-right" nowrap="nowrap">
                                                                    Jumlah Refund  :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/AmountRefund "/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                              <td class="a-left"  colspan="3">

                                                              </td>
                                                              <td class="a-left" >

                                                              </td>
                                                              <td class="a-left" nowrap="nowrap">

                                                              </td>
							<!--									                          <td class="a-right" nowrap="nowrap">
                                                              Poin Hadiah  :
                                                            </td>
                                                            <td class="a-right">
                                                              <xsl:value-of select="OPBillFormat/RewardPoints "/>
                                                            </td>-->
                                                            </tr>
                                                            <tr>
                                                                <td class="a-left"  colspan="3">
                                                                    (<xsl:value-of select="OPBillFormat/LoginName"/>)
                                                                </td>
                                                                <td class="a-left" >

                                                                </td>
                                                                <td class="a-left">

                                                                </td>
                                                                <td class="a-right"  nowrap="nowrap">
                                                                    Jenis Pembayaran  :
                                                                </td>
                                                                <td class="a-right">
                                                                    <xsl:value-of select="OPBillFormat/PaymentMode"/>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br/>
                            </center >
                        </td>
                    </tr>

                  <tr>

                    <td class="a-left"  nowrap="nowrap">
                      <table>
                        <tr>
                          <td>
                            Keterangan lebih lanjut silahkan mengunjungi :
                          </td>
                          <td>
                            <xsl:value-of select="OPBillFormat/PatientPortal"/>
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
