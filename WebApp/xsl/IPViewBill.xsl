<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:asp="remove"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo"
                >

  <!--<xsl:template match="Author">
    <xsl:value-of select="FirstName"/>
    <xsl:value-of select="LastName"/>
    <xsl:if test="position()!=last()">, </xsl:if>
  </xsl:template>-->
  <xsl:template match="/">
    <!--<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>-->

    <style>
      <![CDATA[
         table{clear:left;float:left;font-family:verdana;}
         b{font-family:verdana;font-size:10px;}
         .s1{clear:left;float:left;border:solid 1px black;width:1654px;margin:10px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;font-family:verdana;font-size:10px;}
         .s5{background-color:#96C4DD;}
		 
      ]]>
    </style>

    <html>

      <body>
        <div id="divDischargeSummarysheet" class="printfont">
          <div id="divDischargeSummary" class="UIfont" >
            <br></br>
            <table width="100%">
              <tr>
                <td>
                  <xsl:if test="IPViewBill/HeaderLogo!=''">
                    <input type="image" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="IPViewBill/HeaderLogo" />
                      </xsl:attribute>
                    </input>
                  </xsl:if>
                </td>
                <td>
                  <div>

                    <xsl:attribute name="Style">
                      font-family:
                      <xsl:if test="IPViewBill/HeaderFont!=''">
                        <xsl:value-of select="IPViewBill/HeaderFont"/>;
                      </xsl:if>
                      font-size:
                      <xsl:if test="IPViewBill/HeaderFontSize!=''">
                        <xsl:value-of select="IPViewBill/HeaderFontSize"/>
                      </xsl:if>
                    </xsl:attribute>

                    <xsl:if test="IPViewBill/HeaderContent!=''">
                      <xsl:value-of select="IPViewBill/HeaderContent" disable-output-escaping="yes"/>
                    </xsl:if>
                  </div>
                </td>
              </tr>
            </table>

            <div id="dvContent">
              <xsl:if test="IPViewBill/ContentFont!=''">
                <xsl:attribute name="Style">
                  font-family:<xsl:value-of select="IPViewBill/ContentFont"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="IPViewBill/ContentFontSize!=''">
                <xsl:attribute name="Style">
                  font-size:<xsl:value-of select="IPViewBill/ContentFontSize"/>
                </xsl:attribute>
              </xsl:if>

              <div id="dvPatientDtls">
                <table width="100%">
                  <tr>
                    <td colspan="7" style="text-align:center">
                      <h3>
                        <!--<xsl:value-of select="IPViewBill/BillTitle"/>-->
                        FINAL BILL
                      </h3>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      MRN
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/PatientNumber"/>
                    </td>
                    <td></td>
                    <td width="24%">Bill No.</td>
                    <td>:</td>
                    <td width="26%">
                      <xsl:value-of select="IPViewBill/BillNumber"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Patient Name
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/PatientName"/>
                    </td>
                    <td></td>
                    <td>Bill Date</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/BillDate"/>
                    </td>
                  </tr>
                  <!--<tr>
                  
                    <td></td>
                    <td>--><!--Visit No.--><!--</td>
                    <td>--><!--:--><!--</td>
                    <td>
                      --><!--<xsl:value-of select="IPViewBill/VisitNumber"/>--><!--
                    </td>
                  </tr>-->
                  <!--<tr>
                   
                    <td></td>
                    <td>--><!--Charge Class--><!--</td>
                    <td>--><!--:--><!--</td>
                    <td>
                      --><!--<xsl:value-of select="IPViewBill/RateName"/>--><!--
                    </td>
                  </tr>-->
                  <tr>
                    <td>
                      Gender / Age
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/AgeSex"/>
                    </td>
                    
                    <td></td>
                    <td>Consultant</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/PrimaryPhysician"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Contact No
                    </td>
                    <td>
                      :
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/Contact"/>
                    </td>
                    
                    <td></td>
                    <td>Admission Date</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/AdmitDate"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Address
                    </td>
                    <td>
                      :
                    </td>
                    <td rowspan="2" valign="top">
                      <xsl:value-of select="IPViewBill/Address"/>
                    </td>

                    <td></td>
                    <td>Discharge Date</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/DischargeDate"/>
                    </td>
                  </tr>
                  <tr>
                    <td>

                    </td>
                    
                    <td>

                    </td>
                    <td></td>
                    <td>Ward/Bed</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/WardBed"/>
                    </td>
                  </tr>
                  <tr>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td></td>
                    <td>Corporate Sponsor</td>
                    <td>:</td>
                    <td>
                      <xsl:value-of select="IPViewBill/TPAName"/>
                    </td>
                  </tr>
                  <!--<tr>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td></td>
                    <td>Plan Name</td>
                    <td>:</td>
                    <td>

                    </td>
                  </tr>
                  <tr>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td></td>
                    <td>Corporate Sponsor (Account Number)</td>
                    <td>:</td>
                    <td>

                    </td>
                  </tr>-->
                </table>
              </div>
              <div id="dvBillDtls" >
                <table width="100%" >
                  <tr>
                    <td colspan="5">
                      <hr size="1" color="black"></hr>
                    </td>

                  </tr>
                  <tr style="font-weight:bold">
                    <td>Description</td>
                    <td width="28%">Date</td>
                    <td width="12%" align="center">Unit Rate</td>
                    <td width="5%"  align="center">Qty</td>
                    <td width="10%"  align="center">Amount (Rs)</td>
                  </tr>
                  <tr>
                    <td colspan="5"></td>

                  </tr>
                  <xsl:for-each select="IPViewBill/BillGroup">
                    <tr>
                      <td colspan="5">
                        <b>
                          <u>
                            <xsl:value-of select="BillGroupName"/>
                          </u>
                        </b>
                      </td>
                    </tr>
                    <xsl:for-each select="BillingItem">
                      <tr>
                        <td align="left">
                          <xsl:value-of select="ItemDesc" disable-output-escaping="yes" />
                        </td>
                        <td align="left">
                          <xsl:value-of select="FromDate" />

                        </td>
                        <td align="right">
                          <xsl:value-of select="Amount" />
                        </td>
                        <td align="right">
                          <xsl:value-of select="Unit" />
                        </td>
                        <td align="right">
                          <xsl:value-of select="NetAmount" />
                        </td>
                      </tr>
                    </xsl:for-each>

                    <tr>
                      <td colspan="2"></td>
                      <td colspan="2" align="right">

                        <!--<u>-->
                        <!--<xsl:value-of select="BillGroupName"/> Total-->
                        Total
                        <!--</u>-->


                      </td>
                      <td align="right">
                        <div style="border-width: thin; border-top-color:Black; border-top-style:solid;display:inline">
                          <!--<u>-->
                          <xsl:value-of select="Total" />
                          <!--</u>-->
                        </div>

                      </td>
                    </tr>
                  </xsl:for-each>
                  <xsl:if test="IPViewBill/GroupedSum!=''">
                    <xsl:for-each select="IPViewBill/GroupedSum">
                      <tr>
                        <td colspan="5">&#160;</td>
                      </tr>
                      <tr>
                        <td colspan="4" align="left">
                          <b>
                            <u>
                              <xsl:value-of select="GroupHeader"/>
                            </u>
                          </b>
                        </td>
                        <td align="right">
                          
                            <xsl:value-of select="GroupValue" />
                           
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:if>
                  <tr>
                    <td colspan="5"></td>
                  </tr>
                  <tr>
                    <td colspan="5">
                      <hr size="1" color="black"></hr>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="5"></td>
                  </tr>
                  <tr>
                    <td colspan="4">
                      <b>
                        Total Hospital Charges for Service/Items rendred
                      </b>
                    </td>
                    <td align="right">
                      <b>
                        <xsl:value-of select="IPViewBill/GrandTotal"/>
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="5"></td>
                  </tr>
                  <tr>
                    <td align="center">
                      <b>Add:Taxes</b>
                    </td>
                    <td ></td>

                    <td colspan="2" align="right">
                      <b>Tax Amount</b>
                    </td>
                    <td ></td>
                  </tr>
                  <tr>
                    <td >
                      Tax(Applicable Amount <xsl:value-of select="IPViewBill/TaxPercent"/>% )
                    </td>
                    <td ></td>
                    <td ></td>
                    <td align="right">
                      <xsl:value-of select="IPViewBill/Tax"/>
                    </td>
                    <td ></td>
                  </tr>
                  <tr>
                    <td >

                    </td>
                    <td ></td>

                    <td colspan="2" align="right">
                      <b>Total Tax</b>
                    </td>
                    <td align="right">
                      <b>
                        <xsl:value-of select="IPViewBill/Tax"/>
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="5"></td>
                  </tr>
                  <tr>
                    <td colspan="5"></td>
                  </tr>
                  <tr>
                    <td colspan="4" align="right">
                      <div style="width:290px;text-align:left">
                        <b>
                          Total Bill Amount Including Taxes before round off
                        </b>
                      </div>
                    </td>
                    <td align="right">
                      <b>
                        <xsl:value-of select="IPViewBill/TotalWithTax"/>
                      </b>
                    </td>
                  </tr>

                  <tr>
                    <td colspan="4" align="right">
                      <div style="width:290px;text-align:left">
                        <b>
                          Sponser Amount
                        </b>
                      </div>
                    </td>
                    <td align="right">
                      <b>
                        <xsl:value-of select="IPViewBill/CoPayment"/>
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="4" align="right">
                      <div style="width:290px;text-align:left">
                        <b>
                          Discount Amount
                        </b>
                      </div>
                    </td>
                    <td align="right">
                      <b>
                        <xsl:value-of select="IPViewBill/Discount"/>
                      </b>
                    </td>
                  </tr>
                  <xsl:if test="IPViewBill/RoundOff!=''">
                    <tr>
                      <td colspan="4" align="right">
                        <div style="width:290px;text-align:left">
                          <b>
                            Round off
                          </b>
                        </div>
                      </td>
                      <td align="right">

                        (+) <xsl:value-of select="IPViewBill/RoundOff"/>

                      </td>
                    </tr>
                  </xsl:if>
                  <tr>
                    <td colspan="4" align="right">
                      <div style="width:290px;text-align:left">
                        <b>
                          Final Bill Amount including Taxes
                        </b>
                      </div>
                    </td>
                    <td align="right">

                      <xsl:value-of select="IPViewBill/NetAmount"/>

                    </td>
                  </tr>
                  <tr>
                    <td colspan="4">
                      <b>
                        Amount in words     :   <xsl:value-of select="IPViewBill/NetAmountWords"/>
                      </b>
                    </td>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="5">

                    </td>
                  </tr>
                </table>

                <table width="100%" >
                  <xsl:if test="IPViewBill/FinalBill/FinalBillItem!=''">
                    <tr style="font-weight:bold">
                      <td>Sl.No</td>
                      <td>Date</td>
                      <td>Receipt No</td>
                      <td>Description</td>
                      <td>Original Amt.</td>
                      <td  align="right" width="10%">Adjusted Amt.</td>
                    </tr>
                    <xsl:for-each select="IPViewBill/FinalBill/FinalBillItem" >
                      <tr>
                        <td>
                          <xsl:value-of select="SNo"/>
                        </td>
                        <td>
                          <xsl:value-of select="BillDate"/>
                        </td>
                        <td>
                          <xsl:value-of select="ReceiptNO"/>
                        </td>
                        <td>
                          <xsl:value-of select="BillDescription"/>
                        </td>
                        <td>
                          <xsl:value-of select="PaidAmount"/>
                        </td>

                        <td align="right">
                          <xsl:value-of select="NetAmount"/>
                        </td>
                      </tr>
                    </xsl:for-each>

                    <tr>
                      <td colspan="5">
                        <b>Total</b>
                      </td>
                      <td align="right">
                        <b>
                          <xsl:value-of select="IPViewBill/FinalBill/TotalAmtReceived"/>
                        </b>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="6"></td>
                    </tr>
                    <tr>
                      <td colspan="6"></td>
                    </tr>
                  </xsl:if>
                  <tr>
                    <td colspan="5" align="right">
                      <b>Balance Details    </b>
                    </td>
                    <td  width="10%"></td>
                  </tr>
                  <tr>
                    <td colspan="5" align="right">
                      <b>Gross bill amount    :</b>
                    </td>
                    <td align="right">
                      <xsl:value-of select="IPViewBill/GrandTotal"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="5" align="right">
                      <b>Net Amount   :</b>
                    </td>
                    <td align="right">
                      <xsl:value-of select="IPViewBill/NetAmount"/>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="5" align="right">
                      <b>Amount Paid    :</b>
                    </td>
                    <td align="right">
                      <xsl:value-of select="IPViewBill/FinalBill/TotalAmtReceived"/>
                    </td>
                  </tr>
                  <xsl:if test="IPViewBill/FinalBill/RefundAmount!=''">
                    <tr>
                      <td colspan="5" align="right">
                        <b>Refunded Amount   :</b>
                      </td>
                      <td align="right">
                        <xsl:value-of select="IPViewBill/Due"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <tr>
                    <td colspan="5" align="right">
                      <b>Balance To Pay   :</b>
                    </td>
                    <td align="right">
                      <xsl:value-of select="IPViewBill/Due"/>
                    </td>
                  </tr>
                </table>

                <table width="100%">
                  <tr>
                    <td colspan="4">
                      <hr size="1" color="black"></hr>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="4">
                    </td>
                  </tr>
                  <tr>
                    <td width="15%">
                      <b>Prepared By</b>
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/PreparedBy"/>
                    </td>
                    <td  width="15%" align="right">
                      <b>  Prepared On</b>
                    </td>
                    <td  width="15%" align="right">
                      <xsl:value-of select="IPViewBill/PreparedOn"/>
                    </td>
                  </tr>
                  <tr>
                    <td width="15%">
                      <b>Generated By</b>
                    </td>
                    <td>
                      <xsl:value-of select="IPViewBill/GeneratedBy"/>
                    </td>
                    <td  width="15%" align="right">
                      <b>Generated On</b>
                    </td>
                    <td  width="15%" align="right">
                      <xsl:value-of select="IPViewBill/GeneratedOn"/>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
          </div>
        </div>
      </body>

    </html>

  </xsl:template>
</xsl:stylesheet>
