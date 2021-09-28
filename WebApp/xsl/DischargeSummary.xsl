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

		<style>
			<![CDATA[
         table{clear:left;float:left;font-family:verdana;}
         b{font-family:verdana;font-size:12px;}
         .s1{clear:left;border:solid 1px black;margin:15px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;}
         .s5{background-color:#96C4DD;}
		 .s1,.s2 {color: #000 !important;}
      ]]>
		</style>

		<html>
			<body>
				<div id="divDischargeSummarysheet" class="printfont">
					<div id="divDischargeSummary" class="UIfont">
						<br />
						<center class="bold">
							<u>
								<b>Discharge summary</b>
							</u>
						</center>

						<div width="100%" class="s1">
							<table width="100%">
								<tr>
									<td>
										<b>UHID</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/PatientNo"/>
									</td>
									<td>
										<b>Patient Name</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/PatientName"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>Age</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/Age"/>
									</td>
									<td>
										<b>Sex</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/Sex"/>
									</td>
								</tr>
															<tr>

								<td  nowrap="nowrap">
									<xsl:if test="DischargeSummary/PresentAddress!=''">
										<b>Present Address</b>
									</xsl:if>
								</td>


								<td>
									<xsl:if test="DischargeSummary/PresentAddress!=''">: </xsl:if>
								</td>

								<td>
									<xsl:value-of disable-output-escaping="yes" select="DischargeSummary/PresentAddress"/>

								</td>
								<td  nowrap="nowrap">
									<xsl:if test="DischargeSummary/PermenantAddress!=''">
										<b>Permanent Address</b>
									</xsl:if>
								</td>

								<td>
									<xsl:if test="DischargeSummary/PermenantAddress!=''">: </xsl:if>
								</td>

								<td>
									<xsl:value-of  disable-output-escaping="yes" select="DischargeSummary/PermenantAddress"/>

								</td>

							</tr>
							<tr>
								<td>
									<b>IP No</b>
								</td>
								<td>:</td>
								<td>
									<xsl:value-of select="DischargeSummary/IPNo"/>
								</td>
								<td>
									<b>Room No/Bed no</b>
								</td>
								<td>:</td>
								<td>
									<xsl:value-of select="DischargeSummary/RoomNo"/>
								</td>
							</tr>


								<tr>
									<td  nowrap="nowrap">
										<b>Date of Admission</b>
									</td>
									<td>:</td>
									<td  nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/DOA"/>
									</td>
									<td  nowrap="nowrap">
										<b>Date of Discharge</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/DOD"/>
									</td>
								</tr>
							</table>
						</div>

						<div class="s2" width="100%">
							<table width="100%">
								<tr>
									<td align="left"  nowrap="nowrap">
										<b>Primary Consultant</b>
									</td>
									<td> : </td>
									<td align="left"  nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/PC"/>
									</td>
								</tr>
								<tr>
									<td align="left">
										<b>Speciality</b>
									</td>
									<td> : </td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/Speciality"/>
									</td>
								</tr>
								<tr>
									<xsl:if test="DischargeSummary/BloodGroup!=''">
										<td>
											<b>Blood Group</b>
										</td>
										<td> : </td>
										<td align="left">
											<xsl:value-of select="DischargeSummary/BloodGroup"/>
										</td>
									</xsl:if>
								</tr>

							</table>
						</div>


						<table class="s3" width="100%">
							<xsl:if test="DischargeSummary/Diagnosis/Type!=''">
								<tr>
									<td align="left">
										<b>
											<u>Diagnosis</u>
										</b>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/Diagnosis">
									<tr>
										<td align="left">
											<xsl:value-of select="Type" />
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>


						<table width="100%" class="s3">
							<xsl:if test="TreatmentName!=''">
								<tr>
									<td align="left">
										<u>
											<b>Procedure</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/Procedure">
									<tr>
										<td style="border:solid 1px black;">
											<table width="100%" class="s3">
												<tr>
													<td align="left">Type</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="Type" />
													</td>
												</tr>
												<tr>
													<td align="left">Treatment Name</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="TreatmentName" />
													</td>
												</tr>
												<tr>
													<td align="left">Prosthesis</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="Prosthesis" />
													</td>
												</tr>
												<tr>
													<td align="left">Treatment Plan Date</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="TreatmentPlanDate" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>


						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/HistoryDetails/History!=''">
								<tr>
									<td colspan="3" align="left">
										<u>
											<b>History</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/HistoryDetails">
									<tr>
										<td align="left" nowrap="nowrap">
											<xsl:value-of disable-output-escaping="yes" select="History" />
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>

						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/MedicalProblems/Temp!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>
												Background medical problems
											</b>
										</u>
									</td>
								</tr>
								<tr>
									<td align="left">
										<table width="100%">
											<xsl:for-each select="DischargeSummary/MedicalProblems">
												<tr>
													<td  nowrap="nowrap">
														• <xsl:value-of select="Temp" />
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</xsl:if>
						</table>


						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/ADMISSIONVITALS/Temp!=''">
								<tr>
									<td align="left">
										<u>
											<b>ADMISSION VITALS</b>
										</u>
									</td>
								</tr>
								<tr>
									<td align="left">
										<table width="100%" border="1" cellpadding="0" cellspacing="0" class="s3">
											<tr style="border:solid 1px black;">
												<td  nowrap="nowrap">
													<b>Temprature</b>
												</td>
												<td  nowrap="nowrap">
													<b>SBP</b>
												</td>
												<td  nowrap="nowrap">
													<b>DBP</b>
												</td>
												<td  nowrap="nowrap">
													<b>Pulse</b>
												</td>
												<td  nowrap="nowrap">
													<b>Height</b>
												</td>
												<td  nowrap="nowrap">
													<b>Weight</b>
												</td>
												<td  nowrap="nowrap">
													<b>SpO2</b>
												</td>
												<td  nowrap="nowrap">
													<b>RR</b>
												</td>
											</tr>
											<xsl:for-each select="DischargeSummary/ADMISSIONVITALS">
												<tr style="border:solid 1px black;">
													<td  nowrap="nowrap">
														<xsl:value-of select="Temp" disable-output-escaping="yes" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="SBP" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="DBP" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="Pulse" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="Height" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="Weight" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="SpO2" />
													</td>
													<td  nowrap="nowrap">
														<xsl:value-of select="RR" />
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</xsl:if>
						</table>


						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/GeneralExamination/GenExamination!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>General Examination</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/GeneralExamination">
									<tr>
										<td align="left"  nowrap="nowrap">
											<xsl:value-of select="GenExamination" />
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>

						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/SystemicExamination/SystemExamination!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>Systemic Examination</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/SystemicExamination">
									<tr>
										<td align="left"  nowrap="nowrap">
											<xsl:value-of select="SystemExamination" />
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>

						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/Investigation!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>Investigations</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/Investigation">
									<tr>
										<td align="left"  nowrap="nowrap">
											• <xsl:value-of select="*" />
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>

						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/CourseInHospital!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>Course in Hospital</b>
										</u>
									</td>
								</tr>
								<tr>
									<td  nowrap="nowrap">
										<xsl:value-of disable-output-escaping="yes" select="DischargeSummary/CourseInHospital"/>
									</td>
								</tr>
							</xsl:if>
						</table>
						<table width="100%" class="s8">
							<xsl:if test="DischargeSummary/ConditionDischarge!=''">
								<tr>

									<td  nowrap="nowrap">
										<u>
											<b>Condition on Discharge</b>
										</u>
									</td>
									<td> : </td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/ConditionDischarge"/>
									</td>

								</tr>
							</xsl:if>
						</table>
						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/PatientPrescription/DrugName!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>Discharge Prescription</b>
										</u>
									</td>
								</tr>
								<tr>
									<td>
										<table width="100%" class="s3" border="1" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<b>Formulation</b>
												</td>
												<td>
													<b>Drug Name</b>
												</td>
												<td>
													<b>Dose</b>
												</td>
												<td>
													<b>ROA</b>
												</td>
												<td>
													<b>Frequency</b>
												</td>
												<td>
													<b>Duration</b>
												</td>
												<td>
													<b>Instruction</b>
												</td>
											</tr>
											<xsl:for-each select="DischargeSummary/PatientPrescription">
												<tr>
													<td nowrap="nowrap">
														<xsl:value-of select="Formulation" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="DrugName" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="Dose" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="ROA" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="Frequency" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="Duration" />
													</td>
													<td nowrap="nowrap">
														<xsl:value-of select="Instruction" />
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</xsl:if>
						</table>
						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/GeneralAdvice/GenAdvice!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>General Advice</b>
										</u>
									</td>

								</tr>
								<xsl:for-each select="DischargeSummary/GeneralAdvice">
									<tr>
										<td  nowrap="nowrap">
											<xsl:value-of select="GenAdvice"/>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
						</table>
						<xsl:if test="ChiefSurgeon!=''">
							<center class="s4">
								<b>
									<u>Operation Notes</u>
								</b>
							</center>
						</xsl:if>
						<xsl:for-each select="DischargeSummary/OperationNotes">
							<table width="100%" class="s3">
								<tr>
									<td>
										<table width="100%" class="s3">
											<tr>
												<td colspan="3" align="left" >
													<u>
														<b>Operation team</b>
													</u>
												</td>
											</tr>
											<tr>
												<td align="left">Chief Surgeon</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="ChiefSurgeon"/>
												</td>
											</tr>
											<tr>
												<td align="left">Nurse</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="Nurse"/>
												</td>
											</tr>
											<tr>
												<td align="left">From Time</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="FromTime"/>
												</td>
											</tr>
											<tr>
												<td align="left">To Time</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="ToTime"/>
												</td>
											</tr>
										</table>
										<table  width="100%" class="s3">
											<tr>
												<td colspan="3" align="left">
													<u>
														<b>Operation Details</b>
													</u>
												</td>
											</tr>
											<tr>
												<td align="left">Surgery Type</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="SurgeryType"/>
												</td>
											</tr>
											<tr>
												<td align="left">Operation Type</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="OperationType"/>
												</td>
											</tr>
											<tr>
												<td align="left">Anesthesia Type</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="AnesthesiaType"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Pre-operative findings</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="PreOperative"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Operative Technique</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="OperativeTechnique"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Operative Findings</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="OperativeFindings"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Post-Operative Findings</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="PostOperative"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Operation complications</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="OperationComplications"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</xsl:for-each>


						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/DischargeAdvice!=''">
								<tr>
									<td align="left" nowrap="nowrap">
										<u>
											<b>Discharge Advice</b>
										</u>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:value-of select="DischargeSummary/DischargeAdvice"/>
									</td>
								</tr>
							</xsl:if>
						</table>

						<table width="100%" class="s3">
							<tr>
								<xsl:if test="DischargeSummary/ModeOfDischarge!=''">
									<td align="left" nowrap="nowrap">
										<b>Mode of Discharge</b>
									</td>
									<td align="left">:</td>
									<td align="left">
										<xsl:value-of select="DischargeSummary/ModeOfDischarge"/>
									</td>
								</xsl:if>
							</tr>
              <tr>
                <xsl:if test="DischargeSummary/HospitalCourse!=''">
                  <td align="left" nowrap="nowrap">
                    <b>Hospital Course</b>
                  </td>
                  <td align="left">:</td>
                  <td align="left">
                    <xsl:value-of select="DischargeSummary/HospitalCourse"/>
                  </td>
                </xsl:if>
              </tr>
							<tr>
								<xsl:if test="DischargeSummary/NextReview!=''">
									<td align="left" nowrap="nowrap">
										<b>Next Review</b>
									</td>
									<td align="left">:</td>
									<td align="left">
										<xsl:value-of select="DischargeSummary/NextReview"/>
									</td>
								</xsl:if>
							</tr>
							<tr>
								<xsl:if test="DischargeSummary/ReviewReason!=''">
									<td align="left" nowrap="nowrap">
										<b>Review reason</b>
									</td>
									<td align="left">:</td>
									<td align="left">
										<xsl:value-of select="DischargeSummary/ReviewReason"/>
									</td>
								</xsl:if>
							</tr>
							<tr>
								<xsl:if test="DischargeSummary/TypedBy!=''">
									<td align="left" nowrap="nowrap">
										<b>Prepared By</b>
									</td>
									<td align="left">:</td>
									<td align="left">
										<xsl:value-of select="DischargeSummary/TypedBy"/>
									</td>
								</xsl:if>
							</tr>
						</table>

						<table  style="float:left;" width="100%">
							<tr>
								<td align="left" nowrap="nowrap">
									<b>(INVESTIGATION REPORTS ENCLOSED IN THE FILE) </b>
								</td>
								<td align="right">
									<table style="float:right;padding-right:50px;">
										<tr valign="top">
											<td align="center">
												<xsl:value-of select="DischargeSummary/ConsultantIncharge"/>
											</td>
										</tr>
										<tr valign="top">
											<td  align="right" nowrap="nowrap">Consultant Incharge</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
