<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:cs="urn:cs" xmlns:asp="remove">
	<msxsl:script language="C#" implements-prefix="cs">
		<![CDATA[
      public string datenow()
     {
        return(DateTime.Now.ToString("dd MMMM yyyy hh':'mm tt"));
     }
     ]]>
	</msxsl:script>
	<xsl:template match="/">
		<html>
			<body>
				<div id="divContainer" style="margin-top:0px;">
					<h4 align="center">KWITANSI PEMBAYARAN </h4>
          <div align="center"> <xsl:if test="OpReceipt/DuplicateCopy='Y'"> Duplicate Copy </xsl:if></div>
          
          <!--<div align="right">COPY</div>-->
					<div id="div0" style="text-align:center;">
						<table width="50%" style="font-size:13px;border-top: 1px solid black;">
							<tr>
								<td>Telah Terima Dari</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/PaymentCollectedFrom"/>
								</td>
							</tr>
							<tr>
								<td>Untuk Pembayaran</td>
								<td>:</td>
								<td valign="top">
									Biaya Pelayanan
								</td>
							</tr>
							<tr style="display:none;">
								<td>No. Kwitansi</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/ReceiptNO"/>
								</td>
							</tr>
							<tr style="display:none;">
								<td>Tanggal</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/VisitDate"/>
								</td>
							</tr>

							<tr>
								<td>No.Reg/No.Rm</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/VisitNo"/> / <xsl:value-of select="OpReceipt/MediacalRecordNo"/>
								</td>
							</tr>
							<tr>
								<td>Nama:</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/PatientName"/>
								</td>
							</tr>
							<tr>
								<td>Jumlah</td>
								<td>:</td>
								<td valign="top">
									Rp. <xsl:value-of select="OpReceipt/AmountReceived"/>
								</td>
							</tr>
							<tr style="display:none;">
								<td>Cara Bayar</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/TPAName"/>
								</td>
							</tr>

							<tr>
								<td>Terbilang</td>
								<td>:</td>
								<td valign="top">
									<xsl:value-of select="OpReceipt/AmountinWords"/> Rupiah
								</td>
							</tr>

						</table>
						<table align="right" style="font-size:12px;">
							<tr>
								<td align="center">
									Denpasar, <xsl:value-of select="cs:datenow()"></xsl:value-of>
								</td>
							</tr>
							<tr>
								<td align="center" style="padding-top:30px;">
									(<xsl:value-of select="OpReceipt/LoginName"/>)
								</td>
							</tr>
						</table>
					</div>

				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
