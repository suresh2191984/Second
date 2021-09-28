<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">
	<xsl:template match="/">

		<html>
			<body>
				<meta http-equiv="x-ua-compatible" content="IE=9"/>
				<div style="width:100%;float:left;style;font-size:14px;font-family:Arial;">
					<!--Header Format-->

					<div style="width:100%;float:left">
						<div style="width:50%;float:left;">
							<input type="image" style="height:80px;" name="imagem">
								<xsl:attribute name="src">
									<xsl:value-of select="GenerateVisit/HeaderLogo"/>
								</xsl:attribute>
							</input>
						</div>
						<div style="width:50%;float:left;">
							<div style="width:100%;float:left;">
								SURAT ELIGIBILITAS PESERTA
							</div>
							<div style="width:100%;float:left;">
                <xsl:value-of select="GenerateVisit/OrgName"/>
                <xsl:value-of select="GenerateVisit/Location"/>
              </div>
						</div>
					</div>
					<!--Body Format-->
					<div style="width:100%;float:left">
						<div style="width:50%;float:left">

							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									No. SEP
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left;font-weight: bold;">
                    <B>
                      <xsl:value-of select="GenerateVisit/SEPNo"/>
                    </B>	
									</div>
								</div>
							</div>

							<div style="width:100%;float:left;">
								<div style="width:40%;float:left;">
									Tgl. SEP
								</div>
								<div style="width:60%;float:left;">
									<div style="width:10%;float:left;">
										:
									</div>
									<div style="width:90%;float:left;">
										<xsl:value-of select="GenerateVisit/VisitDate"/>
									</div>
								</div>
							</div>

							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									No. Kartu
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
                    <B>
                      <xsl:value-of select="GenerateVisit/InsuranceNo"/>
                    </B>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									No.RM
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/PatientNumber"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Nama Peserta
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/PatientName"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Tgl. Lahir
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/DOB"/>
									</div>
								</div>
							</div>

             
							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Jns. Kelamin
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/Sex"/>
									</div>
								</div>
							</div>

              
              <xsl:if test="GenerateVisit/VisitType = 'RAWAT JALAN'">
							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Poliklinik Tujuan
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/EmpDeptCode"/>
									</div>
								</div>
							</div>
              </xsl:if>


							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Asal Faskes TK. I
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/RefferalName"/>
									</div>
								</div>
							</div>

							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Diagnosa Awal
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/ICD10"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:40%;float:left">
									Catatan
								</div>
								<div style="width:60%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
                    <xsl:value-of select="GenerateVisit/Accident"/> 
									</div>
								</div>
							</div>
              <div style="width:100%;float:left;display:none;">
                <div style="width:40%;float:left">
                  Kasus
                </div>
                <div style="width:60%;float:left">
                  <div style="width:10%;float:left">
                    :
                  </div>
                  <div style="width:90%;float:left">
                    <xsl:value-of select="GenerateVisit/Remarks"/>
                  </div>
                </div>
              </div>
            </div>
						<div style="width:40%;float:left;margin-left:10%;">

							<div style="width:100%;float:left">
								<div style="width:50%;float:left">
									Peserta
								</div>
								<div style="width:50%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/ClientName"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:50%;float:left">
									COB
								</div>
								<div style="width:50%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
                    <xsl:value-of select="GenerateVisit/COB"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:50%;float:left">
									Jns. Rawat
								</div>
								<div style="width:50%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/VisitType"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left">
								<div style="width:50%;float:left">
									Kls. Rawat
								</div>
								<div style="width:50%;float:left">
									<div style="width:10%;float:left">
										:
									</div>
									<div style="width:90%;float:left">
										<xsl:value-of select="GenerateVisit/RateCard"/>
									</div>
								</div>
							</div>


							<div style="width:100%;float:left; margin-top:50px;">
								<div style="width:50%;float:left;">
									<div style="width:100%;float:left;">
										<span style="float:Left">Pasien/</span>
									</div>
									<div style="width:100%;float:left;">
										<span style="float:Left">Keluarga&#160;Pasien</span>
									</div>
								</div>
								<div style="width:50%;float:left;">
									<div style="width:100%;float:left;">
										<span style="float:Left">Petugas/</span>
									</div>
									<div style="width:100%;float:left;">
										<span style="float:Left">BPJS&#160;Kesehatan</span>
									</div>

									<!--<span style="float:Left;padding-left:10%">Petugas&#160;BPJS&#160;Kesehatan</span>-->
								</div>
							</div>

						</div>
					</div>
					<!--Footer Format-->
					<div style="width:100%;float:left;">
						<div style="width:50%;float:left;">
							<div style="width:100%;float:left;font-size:10px;">
								*Saya menyetujui BPJS kesehatan mengunakan informasi Medis Pasien Jika diperlukan.

								<!--*Saya&#160;menyetujui&#160;BPJS&#160;kesehatan&#160;mengunakan&#160;informasi&#160;Medis&#160;Pasien&#160;Jika&#160;diperlukan.-->
							</div>
							<div style="width:100%;float:left;font-size:8px;">
								*SEP bukan sebagai bukti penjaminan peserta.
							</div>
						</div>
						<div style="width:40%;float:left;margin-left:10%;">
							<div style="width:50%;float:left;">
								_____________
							</div>
							<div style="width:50%;float:left;">
								_____________
							</div>

						</div>
            <div style="width:100%;float:left">
              <div style="width:40%;float:left">
                Cetakan ke  <xsl:value-of select="GenerateVisit/Print"/>
              </div>
              <div style="width:60%;float:left">
                <div style="width:10%;float:left">

                </div>
                <div style="width:90%;float:left">

                </div>
              </div>
            </div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
