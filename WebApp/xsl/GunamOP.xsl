<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
  <!--<xsl:template match="Author">      
<xsl:value-of select="FirstName"/>      
<xsl:value-of select="LastName"/>      
<xsl:if test="position()!=last()">, 
</xsl:if>    </xsl:template>-->
  <xsl:template match="/">
    <!--<xsl:copy>              
<xsl:apply-templates select="@* | node()"/>          
</xsl:copy>-->
    <html id="htmlOP">
      <body >
        <div style="height:3px">&#160;</div>
        <div style="float:left;width:800px;">
          <div style="width:100%;float:left">
            <div style="width:100%;float:left;padding-bottom: 1.7%;">
              <div  style="width:40%;float:left;">
                <div style="width:50%;float:left;padding-left:42%;">
                  <xsl:value-of select="InventoryOPBill/PatientName"/>
                </div>
              </div>
              <div  style="width:60%;float:left;">
                <div style="width:50%;float:left;padding-left:4%;">
                  <xsl:value-of select="InventoryOPBill/Age"/>
                </div>
              </div>
            </div>
            <div style="width:100%;float:left;padding-bottom: 1.7%;">
              <div  style="width:40%;float:left">
                <div style="width:50%;float:left;padding-left:42%;">
                  <xsl:value-of select="InventoryOPBill/PatientNo"/>
                </div>
              </div>
              <div  style="width:60%;float:left">
                <div style="width:50%;float:left;padding-left:4%;">
                  <xsl:value-of select="InventoryOPBill/BillNo"/>
                </div>
              </div>
            </div>
            <div style="width:100%;float:left;padding-bottom: 1.7%;">
              <div  style="width:40%;float:left">
                <div style="width:50%;float:left;padding-left:42%;">
                  <xsl:if test ="InventoryOPBill/DoctorName=''">
                    &#160;&#160;
                  </xsl:if>
                  <xsl:value-of select="InventoryOPBill/DoctorName"/>
                </div>
              </div>
              <div  style="width:60%;float:left">
                <div style="width:50%;float:left;padding-left:4%;">
                  <xsl:value-of select="InventoryOPBill/Date"/>
                </div>
              </div>
            </div>
          </div>
          <div style="width:100%;float:left;margin-top:35px;margin-left:80px;line-height:17px;letter-spacing:1%;min-height:266px;">
            <xsl:for-each select="InventoryOPBill/OrderedItems">
              <div style="width:100%;float:left">
                <div style="width:4%;float:left;">
                  <xsl:value-of select="SNo"/>
                </div>
                <div style="width:26%;float:left;padding-left:0.3%;">
                  <xsl:value-of select="Description"/>
                </div>
                <div style="width:6%; float:left;text-align:right;">
                  <xsl:value-of select="Quantity"/>
                </div>
                <div style="width:8%;float:left;padding-left:3.5%;">
                  <xsl:value-of select="ManufactureDate"/>
                </div>
                <div style="width:11%; float:left;">
                  <xsl:value-of select="BatchNo"/>
                </div>
                <div style="width:7%; float:left;">
                  <xsl:value-of select="ExpiryDate"/>
                </div>
                <div style="width:5%; float:left; text-align:right;">
                  <xsl:value-of select="Rate"/>
                </div>
                <div style="width:7%; float:left; text-align:right;">
                  <xsl:value-of select="TaxPercent"/>
                </div>
                <div style="width:10%; float:left;text-align:right;">
                  <xsl:value-of select="Amount"/>
                </div>
                
              </div>
            </xsl:for-each>
          </div>
          <div style="width:100%;float:left;">
            <div style="width:50%;float:left;" >
              <div style="width:100%;float:left;text-align:left;padding-left:40%;padding-top:2%;padding-bottom:4%;">
                <xsl:value-of select="InventoryOPBill/PaymentMode"/>
              </div>
              <div style="width:100%;float:left;text-align:left;padding-left:40%;padding-top:8%padding-bottom:2%;">
                <xsl:value-of select="InventoryOPBill/BilledBy"/>
              </div>
            </div>
            <div style="width:50%;float:left;">
              <div style="width:100%;float:left;text-align:right;padding-bottom: 1.5%;padding-top:2%;">
                <xsl:value-of select="InventoryOPBill/NetValue"/>
              </div>
              <div style="width:100%;float:left;text-align:right;padding-bottom: 1.5%;">
                <xsl:value-of select="InventoryOPBill/TaxAmount"/>
              </div>
              <div style="width:100%;float:left;text-align:right;padding-bottom: 1.5%;">
                <xsl:value-of select="InventoryOPBill/Discount"/>
              </div>
              <div style="width:100%;float:left;text-align:right;padding-bottom: 1.5%;">
                <xsl:value-of select="InventoryOPBill/GrandTotal"/>
              </div>
            </div>
          </div>
          <div style="page-break-after : always;padding-bottom:0.5%;">            </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>