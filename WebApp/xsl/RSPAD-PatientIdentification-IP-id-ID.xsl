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
                        <tr Width="100%">
                            <td nowrap="nowrap" colspan="2">
                                <table Width="20%">
                                    <tr>
                                        <td align="left" width="5%" valign ="top">
                                            <input type="image" name="imagem">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="PatientIdentificationSheet/src" />
                                                </xsl:attribute>
                                            </input>
                                        </td>
                                        <td align="left" nowrap="nowrap" Width="5%" valign ="bottom">
                                            <h6>
                                                <br/>
                                                <br/>
                                                DIREKTORAT KESEHATAN ANGKATAN DARAT  <br/>
                                                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;RSPAD GATOT SOEBROTO
                                                <hr/>
                                            </h6>

                                        </td>
                                    </tr>
                                    <!--<tr>
                                        <td nowrap="nowrap" colspan="2">
                                            <hr/>
                                        </td>
                                    </tr>-->
                                </table>
                            </td >
                        </tr>
                        <tr  Width="100%">
                            <td align="center" nowrap="nowrap" colspan="2">
                                <h3>RINGKASAN MASUK DAN KELUAR PASIEN RAWAT INAP</h3>
                            </td >
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap" colspan="2">
                                <br/>
                            </td>
                        </tr>
                        <tr  Width="100%">
                            <td colspan="2">
                                <table Width="100%">
                                    <tr>
                                        <td  nowrap="nowrap">Nama Pasien</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientName"/>
                                        </td>
                                        <td nowrap="nowrap">Nomor RM</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientNumber"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Tanggal Lahir</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DOB"/>
                                        </td>
                                        <td  nowrap="nowrap" >Jenis Kelamin</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Gender"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap">Alamat</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Address"/>
                                        </td>
                                        <td  nowrap="nowrap">Telepon Rumah</td>
                                        <td  nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/TeleNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">Telepon Selular(HP)</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/MobileNo"/>
                                        </td>
                                        <td nowrap="nowrap">Pendidikan</td>
                                        <td nowrap="nowrap">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Qualification"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Suku Bangsa</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Race"/>
                                        </td>
                                        <td  nowrap="nowrap" >No.KTP/SIM/Pasport</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/URNNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Kewarganegaraan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Country"/>
                                        </td>
                                        <td  nowrap="nowrap" >Agama</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Religion "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Status Pasien</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/PatientStatus"/>
                                        </td>
                                        <td  nowrap="nowrap" >Status Pernikahan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/MaritalStatus"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Pekerjaan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Occupation"/>
                                        </td>
                                        <td  nowrap="nowrap" >Kesatuan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Corp "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Pangkat/Golongan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Designation"/>
                                        </td>
                                        <td  nowrap="nowrap" >Angkatan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/FieldArmy "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Tanggal Masuk</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitDate"/>
                                        </td>
                                        <td  nowrap="nowrap" >Kelas Perawatan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RateCardName "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Jam</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/VisitTime "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Nama Keluarga Terdekat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Hubungan Keluarga</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelationShip "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Alamat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelAddress"/>
                                        </td>
                                        <td  nowrap="nowrap" >Telepon Rumah</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelTelNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" ></td>
                                        <td  nowrap="nowrap" >

                                        </td>
                                        <td  nowrap="nowrap" >Telepon Selular(HP)</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/RelMobNo "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Perhatian Khusus</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/HistOfDise"/>
                                        </td>
                                        <td  nowrap="nowrap" > Alergi Obat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Allergies "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Diagnosa Masuk</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AdmissionDiagsName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Kode Diagnosa Masuk</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AdmissionICD10 "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Dokter yang merawat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/PrimaryDoctor"/>
                                        </td>
                                        <td  nowrap="nowrap" >Lama dirawat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Duration "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Diagnosa Keluar</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DischargeDiagsName"/>
                                        </td>
                                        <td  nowrap="nowrap" >Lama dirawat</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/DischargeICD10 "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Tindakan Pembedahan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/SurgeryType"/>
                                        </td>
                                        <td  nowrap="nowrap" >Nama Operasi / Tindakan</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/SurgeryName "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Golongan Operasi</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/OperationTime "/>
                                        </td>
                                        <td  nowrap="nowrap" >Jenis Anestesi</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/AnestType "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Infeksi Nosokomial</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Infeksi "/>
                                        </td>
                                        <td  nowrap="nowrap" >Penyebab Infeksi</td>
                                        <td  nowrap="nowrap" >
                                            :   <xsl:value-of select="PatientIdentificationSheet/Penyebab "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Pengobatan Radioterapi/Radio Nuklir</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/RadiNuk "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Keadaan Keluar</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/Condition "/>
                                        </td>
                                        <td  nowrap="nowrap" >Cara Keluar</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/TypeofDischarge "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="right" nowrap="nowrap">
                                            Jakarta,----------------------------------------------------<br />
                                            Tanda Tangan<br />
                                            <br />
                                            <br />
                                            <br />
                                            Dokter yang merawat
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Nama Perusahaan / Penanggung Jawab Biaya</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientName "/>
                                        </td>
                                        <td  nowrap="nowrap">Alamat Penaggung Jawab Biaya</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientAddress "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Telepon / HP</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientLandLine "/>
                                        </td>
                                        <td  nowrap="nowrap">Nomor Asuransi</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/InsuranceNumber "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  nowrap="nowrap" >Surat Jaminan</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientReferrelForm "/>
                                        </td>
                                        <td  nowrap="nowrap">Yang dihubungi Keterangan</td>
                                        <td  nowrap="nowrap" colspna="3">
                                            :   <xsl:value-of select="PatientIdentificationSheet/ClientRemarks "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="right" nowrap="nowrap">
                                            Jakarta,----------------------------------------------------<br />
                                            Tanda Tangan<br />
                                            <br />
                                            <br />
                                            <br />
                                            Petugas Min
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr >
                    </table >
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
