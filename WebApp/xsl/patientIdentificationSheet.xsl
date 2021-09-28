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
				<center>
				 <table style="font-size:12px;font-family:verdana;border-collapse: separate;border-spacing: 2px;">
					 <tr>
						 <td colspan="2" align="left">
							 <table style="font-size:12px;font-family:verdana;">
                 <tr>
                   <td align="center">
                     <input type="image" name="imagem">
                       <xsl:attribute name="src">
                         <xsl:value-of select="PatientIdentificationSheet/src" />
                       </xsl:attribute>
                     </input>
                   </td>
                 </tr>
								 <tr>
									 <td>RUMAH SAKIT SANGLAH</td>
								 </tr>
								 <tr>
									 <td>JI. KESEHATAN, DENPASAR</td>
								 </tr>
								 <tr>
									 <td>Telp. (0361)227911-15</td>
								 </tr>
								 <tr>
									 <td>Faks. (0361)224206</td>
								 </tr>
							 </table>
						 </td>
					 </tr>
					 <tr>
						 <td colspan="2">
							 <h3>LEMBAR IDENTITAS PASIEN</h3>
						 </td>
					 </tr>
					 <tr>
						 <td></td>
						 <td></td>
					 </tr>
					<tr>
						<td>No Registrasi</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/VisitNo"/>
						</td>
					</tr>				

					 <tr>
						 <td>Tgl / Jam Masuk</td>
						 <td>
							 :<xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
						 </td>
					 </tr>
					<tr>
						<td>No Rekam Medik</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/MedicalRecordNo"/>
						</td>
					</tr>
					<tr>
						<td>Nama Pasien</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/PatientName"/>
						</td>
					</tr>
					<tr>
						<td>Tempat</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Location"/>
						</td>
					</tr>
					<tr>
						<td>Tgl Lahir / Umur</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/DOB"/> - <xsl:value-of select="PatientIdentificationSheet/Age"/>
						</td>
					</tr>
					<tr>
						<td>Jenis Kelamin</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Sex"/>
						</td>
					</tr>
					<tr>
						<td>Agama</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Religion"/>
						</td>
					</tr>
					<tr>
						<td>Alamat</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Address"/>
						</td>
					</tr>
					<tr>
						<td>RT / RW</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/RTRW"/>
						</td>
					</tr>
					<tr>
						<td>Kelurahan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Kelurahan"/>
						</td>
					</tr>
					<tr>
						<td>Kecamatan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Kecamatan"/>
						</td>
					</tr>
					<tr>
						<td>Kodya/Kab</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/City"/>
						</td>
					</tr>
					<tr>
						<td>Propinsi</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/State"/>
						</td>
					</tr>
					<tr>
						<td>Telepon</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/TelephoneNo"/>
						</td>
					</tr>
					<tr>
						<td>Kewarganegaraan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Country"/>
						</td>
					</tr>
					<tr>
						<td>No KTP</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/NoKTP"/>
						</td>
					</tr>
					<tr>
						<td>Pendidikan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Qualification"/>
						</td>
					</tr>
					<tr>
						<td>Pekerjaan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Occupation"/>
						</td>
					</tr>
					<tr>
						<td>Status Perkawinan</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/MaritalStatus"/>
						</td>
					</tr>
					<tr>
						<td>Tgl Pertama Masuk</td>
						<td>
							<!--:<xsl:value-of select="PatientIdentificationSheet/LastVisitDate"/>-->
							:<xsl:value-of select="PatientIdentificationSheet/RegistrationDate"/>
						</td>
					</tr>
					<tr>
						<td>Cara Bayar</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Insurance"/>
						</td>
					</tr>
<tr>
                <td >No.Peserta</td>
                <td valign="top">
                  :<xsl:value-of select="PatientIdentificationSheet/PolicyNo"/>
                </td>

              </tr>

					 <tr>
						 <td >Sep </td>
						 <td valign="top">
							 :<xsl:value-of select="PatientIdentificationSheet/PreAuthApprovalNumber"/>
						 </td>

					 </tr>
					<tr>
						 <td></td>
						 <td></td>
					</tr>
					<tr>
						<td  colspan="2">Tujuan Kunjungan Pertama</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<table style="font-size:12px;font-family:verdana;">
								<tr>
									<td>Instalasi</td>
									<td>
										:<xsl:value-of select="PatientIdentificationSheet/Department"/>
									</td>
								</tr>
								<tr style="display:none" >
									<td>Sub Instalasi</td>
									<td>
										:<xsl:value-of select="PatientIdentificationSheet/SubDepartment"/>
									</td>
								</tr>
								<tr>
									<td>Detil Instalasi</td>
									<td>
										:<xsl:value-of select="PatientIdentificationSheet/Speciality"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					 <tr>
						 <td></td>
						 <td></td>
					 </tr>
					 <tr>
						 <td></td>
						 <td></td>
					 </tr>
					<tr>
						<td>ALERGI</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Allergy"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2">CATATAN</td>
					</tr>
				</table>
				<div style="clear:left;float:right;top:20px;">
					<table style="font-size:12px;font-family:verdana;">
						<tr>
							<td>Denpasar,</td>
							<td>
								<xsl:value-of select="PatientIdentificationSheet/CurrentDate"/>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:30px;">
								<u>( <xsl:value-of select="PatientIdentificationSheet/LoginName"/> )</u>
							</td>
						</tr>
					</table>
					
				</div>
					
			  </center>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
