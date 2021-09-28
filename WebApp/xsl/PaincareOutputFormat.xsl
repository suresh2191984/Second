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
				<table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;" width="100%">
					<tr>
						<td colspan="3">
							<table width="100%">
								<tr>
									<td align="left">
										<input type="image" name="imagem">
											<xsl:attribute name="src">
												<xsl:value-of select="PaincareOPBill/src" />
											</xsl:attribute>
										</input>
									</td>
									<td align="right">
										290 Orchard Road<br/>
										#18-03 Paragon<br/>
										Singapore 238859<br/>
										Tel:6235 6697<br/>
										Fax: 6235 6846
									</td>
								</tr>
							</table>
							<br/>
						</td>
					</tr>
					<TR width="100%">
						<td  Colspan="3" width="100%">
							<table width="100%">
								<tr>
									<Td align="left" Width="20%" nowrap="nowrap">
										GST Reg No : 53117159X
									</Td>
									<Td align="Center" Width="60%" nowrap="nowrap">

									</Td>
									<td align="Right" Width="20%" nowrap="nowrap">
										Co Reg No : 53117159X
									</td>
								</tr>
							</table>
						</td>
					</TR>
					<TR>
						<td Colspan="3">
							<hr/>
						</td>
					</TR>
					<TR width="100%">
						<Td align="left" Colspan="3">
							<h3>
								<B>TAX INVOICE</B>
							</h3>
						</Td>
					</TR>
					<tr width="100%">
						<td  Width="100%" colspan="3">
							<table width="100%">
								<tr>
									<td align="left" nowrap="nowrap">
										PATIENT
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/Name"/>
									</td>

									<td align="left" nowrap="nowrap">
										Invoice No
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/BillNumber"/>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap="nowrap">
										Address
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/Address"/>
									</td>

									<td align="left" nowrap="nowrap">
										Our Reference
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/RecptNumber"/>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap="nowrap">
										Doctor
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/DoctorName"/>
									</td>
									<td align="left" nowrap="nowrap">
										Date
									</td>
									<td align="left" nowrap="nowrap">
										:
									</td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="PaincareOPBill/CreateDate"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr Width="100%">
						<td Colpan="3" Width="100%">
							<table>
								<tr>
									<td Colspan="5">
										<hr/>
									</td>
								</tr>
								<tr style ="background-color:Gray;">
									<td align="left" width="40%" nowrap="nowrap">
										<B>DESCRIPTION</B>
									</td>
									<td align="left" width="10%" nowrap="nowrap">
										<B>QTY</B>
									</td>
									<td align="left" width="10%" nowrap="nowrap">
										<B>TOTAL (S$)</B>
									</td>
									<td align="left" width="10%" nowrap="nowrap">
										<B>DISC (%)</B>
									</td>
									<td align="left" width="10%" nowrap="nowrap">
										<B>NET TOTAL (S$)</B>
									</td>
								</tr>
								<tr>
									<td Colspan="5">
										<hr/>
									</td>
								</tr>
								<xsl:for-each select="PaincareOPBill/BillingDetails">
									<tr>
										<td align="left" nowrap="nowrap">
											<xsl:value-of select="FeeDescription" />
										</td>
										<td align="right">
											<xsl:value-of select="Quantity" />
										</td>
										<td align="right">
											<xsl:value-of select="Amount" />
										</td>
										<td align="right">
											<xsl:value-of select="Discount" />
										</td>
										<td align="right">
											<xsl:value-of select="NetAmount" />
										</td>
									</tr>
								</xsl:for-each>
								<tr>
									<td align="left">
									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">
										<hr/>
									</td>
								</tr>
								<tr>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left" nowrap="nowrap">
										Sub-Total
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										<xsl:value-of select="PaincareOPBill/GrossAmount"/>
									</td>
								</tr>
								<tr>
									<td align="left">

									</td>
									<td align="left" >

									</td>
									<td align="left" nowrap="nowrap">
										Discount
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										<xsl:value-of select="PaincareOPBill/Discount"/>
									</td>
								</tr>
								<tr>
									<td align="left">

									</td>
									<td align="left" >

									</td>
									<td align="left" nowrap="nowrap">
										Add GST  <xsl:value-of select="PaincareOPBill/TaxPerntage"/> %
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										<xsl:value-of select="PaincareOPBill/TaxAmount"/>
									</td>
								</tr>

								<tr>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">
										<hr/>
									</td>
								</tr>
								<tr>
									<td align="left">
										Paid By
										<xsl:value-of select="PaincareOPBill/PaymentMode"/>
									</td>
									<td align="left">

									</td>
									<td align="left" nowrap="nowrap">
										Total Amount Payable
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										S$<xsl:value-of select="PaincareOPBill/NetAmount"/>
									</td>
								</tr>

								<tr>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">

									</td>
									<td align="left">
										<hr/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td align="right" nowrap="nowrap">
										Amount Received From Patient
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										S$<xsl:value-of select="PaincareOPBill/AmountReceived"/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td align="left" nowrap="nowrap">
										Due
									</td>
									<td align="right">
										:
									</td>
									<td align="right">
										S$<xsl:value-of select="PaincareOPBill/DUE"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>
							<B>	Payment Mode: </B>

							<table>
								<xsl:for-each select="PaincareOPBill/PaymentType">

									<tr>
										<td align="left" nowrap="nowrap">
											<xsl:value-of select="PaymentTypeMode" />
										</td>

									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
					<TR>
						<Td align="left" Colspn="3" nowrap="nowrap">
							All Cheques should be crossed and made payable to :
						</Td>
					</TR>
					<TR>
						<Td align="left" Colspn="3" nowrap="nowrap">
							SINGAPORE PAINCARE CENTER
						</Td>
					</TR>
					<TR>
						<Td align="left" Colspn="3" nowrap="nowrap">
							This is a computer generated invoice which does not require a signature
							<br/>
							<br/>
							<br/>
							<br/>
							<br/>
							E. &amp; O.E
						</Td>
					</TR>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
