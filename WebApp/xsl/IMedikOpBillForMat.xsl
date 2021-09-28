<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <xsl:template match="/">

    
    <html>
      <head>
        <link href="../PlatForm/StyleSheets/Common.css" runat="server" id="lnkCommon_css"
    rel="stylesheet" type="text/css" media="all" />
      </head>
        <body>
          <div id="diviMedicBillPrint"  style="width:100%;float:left;letter-spacing: 1px;">
            <div style="width:100%;float:left;margin-top:47px;">
                <!-- Capture logo And Address Details-->
                <div id="divLogoWithpatientHeaderWithAddress" style="width:100%;float:left;">
                  <div id="divLogoWithpatientHeader" style="width:18%;float:left;">
                    <input type="image" name="imagem">
                    <xsl:attribute name="src">
                      <xsl:value-of select="OPBillFormat/src" />
                    </xsl:attribute>
                    </input>
                    &#160;&#160;
                  </div>
                  <div id="divLogoWithpatientHeader" style="width:70%;float:left;">
                      <div id="divOrgHeader" style="width:100%;float:left;">
                        <xsl:if test ="OPBillFormat/OrgName=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="OPBillFormat/OrgName"/>
                        
                      </div>
                      <div id="divAddress" style="width:100%;float:left;margin-top:13px;">
                        <xsl:if test ="OPBillFormat/Address=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="OPBillFormat/Address"/>
                        <!--Số 10 Lê Quý Đôn – phường Bạch Đằng – quận Hai Bà Trưng – Hà Nội-->

                      </div>
                      <!--<div id="divLocation" style="width:100%;float:left;">
                        --><!--<xsl:if test ="OPBillFormat/Location=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="OPBillFormat/Location"/>--><!--

                        Số 10 Lê Quý Đôn – phường Bạch Đằng – quận Hai Bà Trưng – Hà Nội
                      </div>-->

                    <div id="divMobileNumber" style="width:100%;float:left;margin-top:13px;">
                      <!--<xsl:if test ="OPBillFormat/MobileNo=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/MobileNo"/>-->

                      Hotline: (+ 84) 4 668 19 777 -  (+ 84) 4 629 20 077

                    </div>
                    
                  </div>
                  
                </div>

                <!-- Capture Patient Id And Bill Date-->
                <div id="divPatientWithBillDate" style="width:100%;float:left;margin:15px 0;">
                  <div id="divPatientNumber" style="width:50%;float:left;">
                    <div id="divPatientNumberText" style="width:54%;float:left;">
                        Mã bệnh nhân ( Patient ID):
                    </div>
                    <div id="divPatientNumberVal" style="float:left;">
                        <xsl:if test ="OPBillFormat/PatientNumber=''">
                          &#160;&#160;
                        </xsl:if>
                        <xsl:value-of select="OPBillFormat/PatientNumber"/>
                    </div>
                  </div>
                  <div id="divCreateDate" style="width:50%;float:left;">
                    <div id="divCreateDateText" style="width:59%;float:left;">
                      Ngày thanh toán ( Bill Date):
                    </div>
                    <div id="divCreateDateText" style="float:left;">
                      <xsl:if test ="OPBillFormat/CreateDate=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/CreateDate"/>
                    </div>
                  </div>
                  
                </div>
             
                <!-- Capture Patient Name And Bill Number-->
                <div id="divPatientNameWithBillNumber" style="width:100%;float:left;margin:9px 0;">
                  <div id="divPatientName" style="width:50%;float:left;">
                    <div id="divPatientNameText" style="width:54%;float:left;">
                      Tên BN( Name):
                    </div>
                  
                    <div id="divPatientNameVal" style="float:left;">

                      <xsl:if test ="OPBillFormat/TitleName=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/TitleName"/>
                      
                      <xsl:if test ="OPBillFormat/Name=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/Name"/>
                    </div>
                  </div>
                  
                  <div id="divBillNumber" style="width:50%;float:left;">
                    <div id="divBillNumberText" style="width:59%;float:left;">
                      Số PT ( Bill No):
                    </div>
                    <div id="divBillNumberText" style="float:left;">
                      <xsl:if test ="OPBillFormat/BillNumber=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/BillNumber"/>
                    </div>
                  </div>

                </div>
              
                <!-- Capture DOB And Phone Number-->
                <div id="divDOBWithPhoneNumber" style="width:100%;float:left;margin:9px 0;">
                  <div id="divDOBWithPhoneNumbe" style="width:50%;float:left;">
                  <div id="divDOB" style="width:54%;float:left;">
                      Năm sinh ( birth of year):
                    </div>
                    <div id="divDOBVal" style="float:left;">
                      <xsl:if test ="OPBillFormat/DOB=''">
                        &#160;&#160;
                      </xsl:if>
                      <xsl:value-of select="OPBillFormat/DOB"/>
                    </div>
                  </div>
                  <div id="divMobileNo" style="width:50%;float:left;">
                    <div id="divMobileNoText" style="width:59%;float:left;">
                      SĐT ( Phone No of Patient):
                    </div>
                    <div id="divMobileNoVal" style="float:left;">
                    <xsl:if test ="OPBillFormat/MobileNumber=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="OPBillFormat/MobileNumber"/>
                    </div>
                  </div>

                </div>
              
                <!-- Capturec Client Name-->
              <div id="divClientName" style="width:100%;float:left;margin:9px 0;">
                <div id="divClientName" style="width:100%;float:left;">
                  <div id="divClientNameText" style="width:40%;float:left;">
                    Dịch vụ (Client/ Insurance Provider):
                  </div>
                  <div id="divClientNameVal" style="float:left;">
                    <xsl:if test ="OPBillFormat/ClientName=''">
                      &#160;&#160;  
                    </xsl:if>
                    <xsl:value-of select="OPBillFormat/ClientName"/>
                  </div>
                </div>
              </div>

              <!-- Capturec the table detail-->
              <div id="divBillingItems" style="width:100%;float:left;margin:8px 0;">
                <div class="Table1" style="width:100%;display:table;">
                  <div class="Heading" style="display: table-row;font-weight: bold;text-align: center;">
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>STT</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Nội dung</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Số lượng</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Đơn giá</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Số tiền</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Chiết khấu</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Lý do</p>
                    </div>
                    <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                      <p>Ghi chú</p>
                    </div>
                  </div>
                  
                          <xsl:for-each select="OPBillFormat/BillingDetails">
                            <div class="Row" style="display: table-row;">

                              <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                                <xsl:if test ="No=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="No"/>
                              </div>
                              <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                                <xsl:if test ="FeeDescription=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="FeeDescription"/>
                              </div>
                              <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;text-align:right;">
                                <xsl:if test ="Qty=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="Qty"/>
                              </div>
                              <div  class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;text-align:right;">
                                <xsl:if test ="Amount=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="Amount"/>
                              </div>
                              <div  class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;text-align:right;">
                                <xsl:if test ="NetAmount=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="NetAmount"/>
                              </div>
                              <div  class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;text-align:right;">
                                <xsl:if test ="Discount=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="Discount"/>
                              </div>
                              <div class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                                <xsl:if test ="DiscountReason=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="DiscountReason"/>
                              </div>
                              <div  class="Cell" style="display: table-cell;border: solid;border-width: thin;padding-left: 5px;padding-right: 5px;">
                                <!--<xsl:if test ="Amount=''">
                                  &#160;&#160;
                                </xsl:if>
                                <xsl:value-of select="Amount"/>-->
                                --
                              </div>

                          
                            </div>
                          </xsl:for-each>
                
                </div>
              </div>
              <!-- Capturec the Total Amount-->
              <div id="divBillingItems" style="width:100%;float:left;">
                <div id="divGrossAmountText" style="width:87%;text-align:right;float:left;">
                  (1)  Tổng cộng :
                </div>
                <div id="divGrossAmountVal" style="text-align:left;float:right;">
                  <xsl:if test ="OPBillFormat/GrossAmount=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="OPBillFormat/GrossAmount"/>
                </div>
              </div>

              <!-- Capturec the Discount Amount-->
              <div id="divDiscount" style="width:100%;float:left;">
                <div id="divDiscountText" style="width:87%;text-align:right;float:left;">
                  (2) Giảm trừ   :
                </div>
                <div id="divDiscountVal" style="text-align:left;float:right;">
                  <xsl:if test ="OPBillFormat/TotalDiscountAmount=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="OPBillFormat/TotalDiscountAmount"/>
                </div>
              </div>
              <!-- Capturec the Under Line-->
                <div id="divLineNumber" style="width:100%;float:left;border-top:1px dotted #000;margin:3px 0;">
              </div>

              <!-- Capturec the Net Amount-->
                <div id="divTotalNetAmount" style="width:100%;float:left;margin:3px 0;">
                <div id="divTotalNetAmountText" style="width:87%;text-align:right;float:left;">
                  (3)= (1) – (2) Phải thanh toán :
                </div>
                <div id="divNetAmountVal" style="text-align:left;float:right;">
                  <xsl:if test ="OPBillFormat/TotalNetAmount=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="OPBillFormat/TotalNetAmount"/>
                </div>
              </div>

              <!-- Capturec the Amount In Words-->
              <div id="divAmountWord" style="width:100%;float:left;margin:3px 0;">
                <div id="divAmountWordText" style="width:25%;float:left;">
                  Số tiền bằng chữ :
                </div>
                <div id="divAmountWordVal" style="width:75%;float:left;">
                  <xsl:if test ="OPBillFormat/AmountWord=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="OPBillFormat/AmountWord"/>
                </div>
              </div>

              <!-- Capturec the Location and date formate-->

              <div id="divLocationWithCurrentDate" style="width:100%;float:left;">
                <div id="divLocation" style="width:80%;float:left;text-align:right;">
                  <xsl:if test ="OPBillFormat/Location=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="OPBillFormat/Location"/>
                </div>
                <div id="divLocationWithCurrentDate" style="width:20%;float:left;">
                  <xsl:if test ="OPBillFormat/CurrentDate=''">
                    &#160;&#160;
                  </xsl:if>
                  ,<xsl:value-of select="OPBillFormat/CurrentDate"/>
                </div>
              </div>

              <!-- Capturec The Signature-->
              <div id="divSignature" style="width:100%;float:left;margin:13px 0;">
                <div id="divSignatureDetail" style="width:100%;float:left;">
                  <div id="divSignature1" style="width:25%;float:left;">
                    Giám đốc
                  </div>
                  <div id="divSignature2" style="width:25%;float:left;">
                    Kế toán trưởng
                  </div>
                  <div id="divSignature3" style="width:25%;float:left;">
                    Thủ quỹ
                  </div>
                  <div id="divSignature4" style="width:25%;float:left;">
                    Người nộp tiền
                  </div>
                </div>

                <div id="divSignatureDetail" style="width:100%;float:left;margin:18px 0;">
                  <div id="divSignature1" style="width:25%;float:left;">
                    Mai Vân Anh
                  </div>
                  <div id="divSignature2" style="width:25%;float:left;">
                    Hoàng Ngọc Anh
                  </div>
                  <div id="divSignature3" style="width:25%;float:left;">
                  
                    <xsl:if test ="OPBillFormat/LoginName=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="OPBillFormat/LoginName"/>
                    
                  </div>
                  <div id="divSignature4" style="width:25%;float:left;">

                    <xsl:if test ="OPBillFormat/TitleName=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="OPBillFormat/TitleName"/>

                    <xsl:if test ="OPBillFormat/Name=''">
                      &#160;&#160;
                    </xsl:if>
                    <xsl:value-of select="OPBillFormat/Name"/>
                  </div>
                </div>
             
              </div>
              
          </div>
          </div>
        </body>
      
    </html>

    
    
    </xsl:template>
</xsl:stylesheet>
