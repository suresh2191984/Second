<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:template match="/">
    <html>
      <body>
        <div id="XsltPharmacyBill">
          <style type="text/css">
            .HeaderStyle
            {
            height: 46.5pt;
            width: 591pt;
            color: black;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
            background: #CCFFCC;
            }
            .TborderTop
            {
            border-top: 1px solid black;border-right: 1px solid black;
            }
            .TborderTopRight
            {
            border-top: 1px solid black;border-right: 1px solid black;
            }
            .TborderTopLeft
            {
            border-top: 1px solid black;border-Left: 1px solid black;
            }
            .Tborder
            {
            border: 1px solid black;
            }
            .TborderRight
            {
            border-right:1px solid black;
            }
            .TborderLeft
            {
            border-Left:1px solid black;
            }
            .TborderTopRightLeft
            {
            border-top: 1px solid black;border-right: 1px solid black; border-Left:1px solid black;
            }
            .TborderLeftRight
            {
            border-right: 1px solid black; border-Left:1px solid black;
            }
          </style>
          <div>
            <table border="0" cellpadding="0" cellspacing="0" width="850px" class="Tborder">
              <tr>
                <td class="HeaderStyle" style="border-bottom:1px solid black" colspan="12" >
                  WESTMINSTER HEALTH CARE PVT LTD<br />
                  Address<br />
                  Phone no:<xsl:value-of select="Pharmacy/PhoneNo"/>
                </td>
              </tr>
              <tr >
                <td rowspan="16"  style="width:2%; transform:rotate(270deg);">
                  Emergency call:<span style="mso-spacerun: yes"> </span>Helpline:
                </td>
                <td class="TborderLeft" style="width:8%">
                  Invoice No
                </td>
                <td colspan="5" class="TborderRight">
                  :<xsl:value-of select="Pharmacy/InvoiceNo"/>
                </td>
                <td style="width:8%">
                  TIN No
                </td>
                <td colspan="4">
                  :<xsl:value-of select="Pharmacy/TINNo"/>
                </td>
              </tr>
              <tr>
                <td class="TborderLeft">
                  Invoice date
                </td>
                <td colspan="5" class="TborderRight">
                  :<xsl:value-of select="Pharmacy/Invoicedate"/>
                </td>
                <td>
                </td>
                <td colspan="4">
                </td>
              </tr>
              <tr>
                <td class="TborderLeft">
                  Doctor name
                </td>
                <td colspan="5" class="TborderRight">
                  :<xsl:value-of select="Pharmacy/Doctorname"/>
                </td>
                <td>
                </td>
                <td colspan="4">
                </td>
              </tr>
              <tr>
                <td class="TborderLeft">
                  Client name
                </td>
                <td colspan="5" class="TborderRight">
                  :<xsl:value-of select="Pharmacy/Clientname"/>
                </td>
                <td>
                </td>
                <td colspan="4">
                </td>
              </tr>
              <tr>
                <td class="TborderTopRightLeft" style="width:10%">
                  <span style="font-weight:bold;"> Quantity </span> 
                </td>
                <td colspan="3" class="TborderTopRight" style="width:25%">
                  <span style="font-weight:bold;">Description  </span> 
                </td>
                <td class="TborderTopRight" style="width:10%">
                  <span style="font-weight:bold;">Type  </span> 
                </td>
                <td colspan="2" class="TborderTopRight" style="width:10%">
                  <span style="font-weight:bold;">Manuf  </span> 
                </td>
                <td class="TborderTopRight" style="width:15%">
                  <span style="font-weight:bold;">Batch no. </span> 
                </td>
                <td class="TborderTopRight" style="width:11%">
                  <span style="font-weight:bold;">Expiry date </span> 
                </td>
                <td class="TborderTopRight" style="width:4%">
                  <span style="font-weight:bold;">Sch</span>
                </td>
                <td class="TborderTopRight" style="width:15%">
                  <span style="font-weight:bold;">Amount(₹) </span> 
                </td>
              </tr>
              <!-- Line Item Looping-->
              <xsl:for-each select="Pharmacy/ItemDetails">
                <tr>
                  <td class="TborderTopRightLeft">
                    <xsl:value-of select="Quantity" />
                  </td>
                  <td colspan="3" class="TborderTop">
                    <xsl:value-of select="Description" />
                  </td>
                  <td class="TborderTop">
                    <xsl:value-of select="Type" />
                  </td>
                  <td colspan="2" class="TborderTop" >
                    <xsl:value-of select="Manuf" />
                  </td>
                  <td class="TborderTop">
                    <xsl:value-of select="Batchno" />
                  </td>
                  <td class="TborderTop">
                    <xsl:value-of select="Expirydate" />
                  </td>
                  <td class="TborderTop">
                    <xsl:value-of select="ScheduleableDrug" />
                  </td>
                  <td class="TborderTop">
                    <xsl:value-of select="Amount" />
                  </td>
                </tr>
              </xsl:for-each>
              <!-- END Line Item Looping-->
              <tr>
                <td colspan="4" class="TborderTopRightLeft">
                </td>
                <td colspan="6" class="TborderTopRightLeft" style="text-align: right">
                  Total
                </td>
                <td colspan="2" class="TborderTopRight">
                  <xsl:value-of  select="Pharmacy/Total"/> 
                </td>
              </tr>
              <tr>
                <td colspan="4" class="TborderLeftRight">
                </td>
                <td colspan="6" class="TborderTopRight" style="text-align: right">
                  Discount %
                </td>
                <td colspan="2" class="TborderTopRight">
                  <xsl:value-of select="Pharmacy/Discount"/>
                </td>
              </tr>
              <tr>
                <td colspan="4" class="TborderLeftRight">
                </td>
                <td colspan="6" class="TborderTopRight" style="text-align: right">
                  Net total
                </td>
                <td colspan="2" class="TborderTopRight">
                  <xsl:value-of select="Pharmacy/Nettotal"/>
                </td>
              </tr>
              <tr>
                <td colspan="4" class="TborderTopRightLeft">
                  Pharmacist Signature
                </td>
                <td colspan="6" class="TborderTopRight" style="text-align: right">
                </td>
                <td colspan="2" class="TborderTopRight">
                </td>
              </tr>
              <tr>
                <td colspan="12" class="TborderTopRightLeft">
                  :)<span style="mso-spacerun: yes"> </span>Get well Soon<span style="mso-spacerun: yes">
                  </span>:)<span style="mso-spacerun: yes"> </span>E&amp;OE Goods once sold cannot
                  be taken back or exchanged
                </td>
              </tr>
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
