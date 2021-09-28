<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:asp="remove"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo"
                >
  <xsl:template match="/">
    <html>
      <body>
        <div id="div" class="printfont">
          <div id="div" class="UIfont" >
            <br></br>
            <div id="dvContent">
              <!-- Address Header-->
              <div style="width:100%">
                <table width="100%">
                  <tr>
                    <td width="50%">
                      <img alt="logo" src="../PlatForm/Images/Logo/321.jpg" />
                      <xsl:value-of select="Indent/OrgName"/>
                      <br/>
                      <xsl:value-of select="Indent/Street"/>
                      <br/>
                      <xsl:value-of select="Indent/City"/>
                      <br/>
                      <xsl:value-of select="Indent/Phonenumber"/>
                      <br/>
                      <br/>
                    </td>
                    <td>
                      <h5>
                        Stock Transfer Form
                      </h5>
                    </td>
                  </tr>
                </table>
              </div>
              <!-- End Address Header-->

              <!-- Patient Or Header Details-->
              <div id="dvPatientDtls" style="padding:5px;">
                <table width="100%">
                  <tr>
                    <td width="100%">
                      <table width="100%">
                        <tr>
                          <td width="20%">
                            Indent No
                          </td>
                          <td width="4px">:</td>
                          <td width="26%">
                            <xsl:value-of select="Indent/IntendNo"/>
                          </td>
                          <td width="20%">
                            Raised Date
                          </td>
                          <td width="4px">:</td>
                          <td width="26%">
                            <xsl:value-of select="Indent/RaisedDate"/>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            Transferree TIN No
                          </td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="Indent/TransferorTinNo"/>
                          </td>
                          <td>
                            Status
                          </td>
                          <td>:</td>
                          <td >
                            <xsl:value-of select="Indent/Status"/>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            Stock transfer from
                          </td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="Indent/IndentRaiseTo"/>
                          </td>
                          <td>
                            Stock Transfer No
                          </td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="Indent/IndentReceivedNo"/>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            Stock Transfer To
                          </td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="Indent/IndentFrom"/>
                          </td>
                          <td>
                            Partial Issued Date
                          </td>
                          <td>:</td>
                          <td>
                            <xsl:value-of select="Indent/IssuedDate"/>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            Comments
                          </td>
                          <td>:</td>
                          <td >
                            <xsl:value-of select="Indent/Comments"/>
                          </td>
                          <td>
                          </td>
                          <td></td>
                          <td>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </div>
              <br/>
              <!-- END Patient Or Header Details-->

              <!-- Line Item Details-->
              <div id="dvBillingDetails"  style="border-width: thin; border-top-color:Black; border-top-style:solid;display:inline">
                <table width="100%" style="border:1px solid #ccc;border-collapse: collapse;border-spacing: 0;margin:0;padding:0;">
                  <tr style="border:1px solid #ccc;">
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="8%">Product Code</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="20%">Product Name</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="10%">Category</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="9%">Batch No</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="10%">Expiry Date</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="10%">Ordered Qty(Lsu)</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="8%">Issued Qty</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="17%">Total Issued Qty Amount</td>
                    <td style="background:#f1f1f1 ;border:1px solid #ccc;" width="8%">Total</td>
                  </tr>
                  <!-- Line Item Looping-->
                  <xsl:for-each select="Indent/IndentDetails">
                    <tr style="border:1px solid #ccc;">
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="ProductCode" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="ProductName" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="CategoryName" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="BatchNo" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="ExpiryDate" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="Quantity" />
                      </td>
                      <td style="border:1px solid #ccc;">
                        <xsl:value-of select="IssuedQuantity" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="TotalIssuedQtyAmount" />
                      </td>
                      <td style="border:1px solid #ccc;" align="right">
                        <xsl:value-of select="Total" />
                      </td>
                    </tr>
                  </xsl:for-each>
                  <!-- END Line Item Looping-->
                  <!-- Footer-->
                  <br/>
                  <tr>
                    <td colspan="2">Total Issued Amount</td>
                    <td align="right">
                      <xsl:value-of select="Indent/TotalIssuedAmount" />
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">Total Received Amount</td>
                    <td align="right">
                      <xsl:value-of select="Indent/TotalReceivedAmount" />
                    </td>
                  </tr>
                  <!-- END Footer-->
                </table>
              </div>
              <!-- End Line Item Details-->
            </div>
          </div>
        </div>
      </body>
    </html>

  </xsl:template>
</xsl:stylesheet>
