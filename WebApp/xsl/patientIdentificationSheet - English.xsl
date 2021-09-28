<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:cs="urn:cs" xmlns:asp="remove">

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
						<td>Registration No</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/VisitNo"/>
						</td>
					</tr>					

					 <tr>
						 <td>Visit Date / Time</td>
						 <td>
							 :<xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
						 </td>
					 </tr>
					  
					<tr>
						<td>MedicalRecord No</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/MedicalRecordNo"/>
						</td>
					</tr>
					<tr>
						<td>Patient Name</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/PatientName"/>
						</td>
					</tr>
					<tr>
						<td>Location</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Location"/>
						</td>
					</tr>
					<tr>
						<td>DOB / Year</td>
						<td>
              :<xsl:value-of select="PatientIdentificationSheet/DOB"/> - <xsl:value-of select="PatientIdentificationSheet/Age"/>
						</td>
					</tr>
					<tr>
						<td>Sex</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Sex"/>
						</td>
					</tr>
					<tr>
						<td>Religion</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Religion"/>
						</td>
					</tr>
					<tr>
						<td>Address</td>
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
						<td>Village</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Kelurahan"/>
						</td>
					</tr>
					<tr>
						<td>District</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Kecamatan"/>
						</td>
					</tr>
					<tr>
						<td>City</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/City"/>
						</td>
					</tr>
					<tr>
						<td>State</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/State"/>
						</td>
					</tr>
					<tr>
						<td>Ph.No</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/TelephoneNo"/>
						</td>
					</tr>
					<tr>
						<td>citizenship</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Country"/>
						</td>
					</tr>
					<tr>
						<td>ID No</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/NoKTP"/>
						</td>
					</tr>
					<tr>
						<td>Qualification</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Qualification"/>
						</td>
					</tr>
					<tr>
						<td>Occupation</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Occupation"/>
						</td>
					</tr>
					<tr>
						<td>Marital Status</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/MaritalStatus"/>
						</td>
					</tr>
					<tr>
						<td>Last Visited Date</td>
						<td>
							<!--:<xsl:value-of select="PatientIdentificationSheet/LastVisitDate"/>-->
							:<xsl:value-of select="PatientIdentificationSheet/RegistrationDate"/>
						</td>
					</tr>
					<tr>
						<td>Insurance</td>
						<td>
							:<xsl:value-of select="PatientIdentificationSheet/Insurance"/>
						</td>
					</tr>
					<tr>
						 <td></td>
						 <td></td>
					</tr>
<tr>
                <td >Policy No</td>
                <td valign="top">
                  :<xsl:value-of select="PatientIdentificationSheet/PolicyNo"/>
                </td>
	<tr>
		<td >PreAuthApproval No </td>
		<td valign="top">
			:<xsl:value-of select="PatientIdentificationSheet/PreAuthApprovalNumber"/>
		</td>

	</tr>
              </tr>
					<tr>
						<td  colspan="2">Destination First Visit</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<table style="font-size:12px;font-family:verdana;">
								<tr>
									<td>installation</td>
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
									<td>Detailed Installation</td>
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
						<td>ALLERGIES</td>
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
						<td colspan="2">NOTE</td>
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
