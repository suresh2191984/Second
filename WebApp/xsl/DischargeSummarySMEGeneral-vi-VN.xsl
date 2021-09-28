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
								<b>Tóm tắt xuất viện</b>
							</u>
						</center>

						<div width="100%" class="s1" align="center">
							<table width="100%">
								<tr>
									<td>
										<b>danh tính bệnh nhân</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/PatientNo"/>
									</td>
									<td>
										<b>Tên bệnh nhân</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/PatientName"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>Tuổi</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/Age"/>
									</td>
									<td>
										<b>tính trai gái</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/Sex"/>
									</td>
								</tr>
															<tr>

								<td  nowrap="nowrap">
									<xsl:if test="DischargeSummary/PresentAddress!=''">
										<b>Địa chỉ hiện tại</b>
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
										<b>Địa chỉ thường trú</b>
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
									<b>IP Không</b>
								</td>
								<td>:</td>
								<td>
									<xsl:value-of select="DischargeSummary/IPNo"/>
								</td>
								<td>
									<b>Phòng Không / giường không</b>
								</td>
								<td>:</td>
								<td>
									<xsl:value-of select="DischargeSummary/RoomNo"/>
								</td>
							</tr>


								<tr>
									<td  nowrap="nowrap">
										<b>Ngày nhập học</b>
									</td>
									<td>:</td>
									<td  nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/DOA"/>
									</td>
									<td  nowrap="nowrap">
										<b>Ngày xuất viện</b>
									</td>
									<td>:</td>
									<td>
										<xsl:value-of select="DischargeSummary/DOD"/>
									</td>
								</tr>
							</table>
						</div>

						<div width="100%" class="s2">
							<table width="100%">
								<tr>
									<td align="left"  nowrap="nowrap">
										<b>Tư vấn chính</b>
									</td>
									<td> : </td>
									<td align="left"  nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/PC"/>
									</td>
								</tr>
								<tr>
									<td align="left">
										<b>Chuyên môn</b>
									</td>
									<td> : </td>
									<td align="left" nowrap="nowrap">
										<xsl:value-of select="DischargeSummary/Speciality"/>
									</td>
								</tr>
								<tr>
									<xsl:if test="DischargeSummary/BloodGroup!=''">
										<td>
											<b>Nhóm máu</b>
										</td>
										<td> : </td>
										<td align="left">
											<xsl:value-of select="DischargeSummary/BloodGroup"/>
										</td>
									</xsl:if>
								</tr>

							</table>
						</div>

            <xsl:if test="DischargeSummary/DiagnosisName/Type!=''">
              <table width="100%" class="s3">
                <tr>
                  <xsl:if test="DischargeSummary/DiagnosisName!=''">
                    <td align="left">
                      <b>
                        <u>Chẩn đoán :</u>
                      </b>
                    </td>
                  </xsl:if>
                </tr>
                <xsl:for-each select="DischargeSummary/DiagnosisName">
                  <tr>
                    <td align="left">
                      <xsl:value-of select="Type" />
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
            </xsl:if>

            <xsl:if test="DischargeSummary/Procedure">
              <table width="100%" class="s3">
                <tr>
                  <xsl:if test="DischargeSummary/Procedure!=''">
                    <td align="left">
                      <u>
                        <b>THỦ TỤC :</b>
                      </u>
                    </td>
                  </xsl:if>
                </tr>
                <xsl:for-each select="DischargeSummary/Procedure">
                  <tr>
                    <td align="left">
                      <xsl:value-of select="Type" />
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
            </xsl:if>

						<table width="100%" class="s3">
							<xsl:if test="TreatmentName!=''">
								<tr>
									<td align="left">
										<u>
											<b>THỦ TỤC</b>
										</u>
									</td>
								</tr>
								<xsl:for-each select="DischargeSummary/Procedure">
									<tr>
										<td style="border:solid 1px black;">
											<table width="100%" class="s3">
												<tr>
													<td align="left">Loại</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="Type" />
													</td>
												</tr>
												<tr>
													<td align="left">Tên điều trị</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="TreatmentName" />
													</td>
												</tr>
												<tr>
													<td align="left">phép thay răng giả</td>
													<td align="left">:</td>
													<td align="left">
														<xsl:value-of select="Prosthesis" />
													</td>
												</tr>
												<tr>
													<td align="left">Kế hoạch điều trị ngày</td>
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


            <xsl:if test="DischargeSummary/HistoryDetails/History!=''">
              <table width="100%" class="s3">
                <tr>
                  <xsl:if test="DischargeSummary/HistoryDetails/History!=''">
                    <td align="left">
                      <b>
                        <u>sử :</u>
                      </b>
                    </td>
                  </xsl:if>
                </tr>
                <xsl:for-each select="DischargeSummary/HistoryDetails">
                  <tr>
                    <td align="left">
                      <xsl:value-of disable-output-escaping="yes" select="History" />
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
            </xsl:if>

						<table width="100%" class="s3">
							<xsl:if test="DischargeSummary/MedicalProblems/Temp!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>
												Vấn đề y tế nền
											</b>
										</u>
									</td>
								</tr>
								<tr>
									<td align="left">
										<table>
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
											<b>nhập học tin cần thiết</b>
										</u>
									</td>
								</tr>
								<tr>
									<td align="left">
										<table width="100%" border="1" cellpadding="0" cellspacing="0" class="s3">
											<tr style="border:solid 1px black;">
												<td  nowrap="nowrap">
													<b>nhiệt độ</b>
												</td>
												<td  nowrap="nowrap">
													<b>SBP</b>
												</td>
												<td  nowrap="nowrap">
													<b>DBP</b>
												</td>
												<td  nowrap="nowrap">
													<b>Xung</b>
												</td>
												<td  nowrap="nowrap">
													<b>Chiều cao</b>
												</td>
												<td  nowrap="nowrap">
													<b>Cân nặng</b>
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
											<b>Tổng kiểm tra</b>
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
											<b>Kiểm tra hệ thống</b>
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
											<b>điều tra</b>
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
											<b>Tất nhiên trong bệnh viện</b>
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
											<b>Điều kiện về Discharge</b>
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
											<b>xả toa</b>
										</u>
									</td>
								</tr>
								<tr>
									<td>
										<table width="100%" class="s3" border="1" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<b>Xây dựng</b>
												</td>
												<td>
													<b>Tên thuốc</b>
												</td>
												<td>
													<b>liều</b>
												</td>
												<td>
													<b>ROA</b>
												</td>
												<td>
													<b>Frequency</b>
												</td>
												<td>
													<b>thời gian</b>
												</td>
												<td>
													<b>Chỉ dẫn</b>
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
						<table  width="100%" class="s3">
							<xsl:if test="DischargeSummary/GeneralAdvice/GenAdvice!=''">
								<tr>
									<td align="left"  nowrap="nowrap">
										<u>
											<b>Lời khuyên chung</b>
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
									<u>Các chú ý về phẫu thuật</u>
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
														<b>nhóm hoạt động</b>
													</u>
												</td>
											</tr>
											<tr>
												<td align="left">Bác sĩ phẫu thuật trưởng</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="ChiefSurgeon"/>
												</td>
											</tr>
											<tr>
												<td align="left">Y tá</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="Nurse"/>
												</td>
											</tr>
											<tr>
												<td align="left">từ thời gian</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="FromTime"/>
												</td>
											</tr>
											<tr>
												<td align="left">Giờ</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="ToTime"/>
												</td>
											</tr>
										</table>
										<table width="100%" class="s3">
											<tr>
												<td colspan="3" align="left">
													<u>
														<b>Chi tiết hoạt động</b>
													</u>
												</td>
											</tr>
											<tr>
												<td align="left">Loại phẫu thuật</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="SurgeryType"/>
												</td>
											</tr>
											<tr>
												<td align="left">Loại hoạt động</td>
												<td align="left">:</td>
												<td align="left">
													<xsl:value-of select="OperationType"/>
												</td>
											</tr>
											<tr>
												<td align="left">Loại gây mê</td>
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
														<b>phát hiện trước mổ</b>
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
														<b>Kỹ thuật phẫu thuật</b>
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
														<b>Kết quả phẫu thuật</b>
													</u>
												</td>
											</tr>
											<tr>
												<td>
													<xsl:value-of select="OperativeFindings"/>
												</td>
											</tr>
										</table>
										<table  width="100%" class="s3">
											<tr>
												<td align="left">
													<u>
														<b>Kết quả sau phẫu thuật</b>
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
														<b>biến chứng hoạt động</b>
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
											<b>xả Tư vấn</b>
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
										<b>Chế độ xả</b>
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
                    <b>Bệnh viện khóa học</b>
                  </td>
                  <td align="left">:</td>
                  <td align="left" >
                    <xsl:value-of disable-output-escaping="yes" select="DischargeSummary/HospitalCourse"/>
                  </td>
                </xsl:if>
              </tr>
							<tr>
								<xsl:if test="DischargeSummary/NextReview!=''">
									<td align="left" nowrap="nowrap">
										<b>Xem tiếp</b>
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
										<b>lý do xét</b>
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
										<b>Được chuẩn bị bởi</b>
									</td>
									<td align="left">:</td>
									<td align="left">
										<xsl:value-of select="DischargeSummary/TypedBy"/>
									</td>
								</xsl:if>
							</tr>
						</table>

						<table width="100%" style="float:left;" >
							<tr>
								<td align="left" nowrap="nowrap">
									<b>(TRA BÁO CÁO đưa vào hồ sơ) </b>
								</td>
								<td align="right">
									<table style="float:right;padding-right:50px;">
										<tr valign="top">
											<td align="center">
												<xsl:value-of select="DischargeSummary/ConsultantIncharge"/>
											</td>
										</tr>
										<tr valign="top">
											<td  align="right" nowrap="nowrap">Tư vấn Phụ trách</td>
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
