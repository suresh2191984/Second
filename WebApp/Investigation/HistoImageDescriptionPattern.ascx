<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HistoImageDescriptionPattern.ascx.cs" 
Inherits="Investigation_HistoImageDescriptionPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>

 <script src="../Ckeditor/ckeditor.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
    // new pattern edit
    var OSts;
    $(document).ready(function() {
        var OID = $("[name*=txtOrgan]");
         OSts = OID[0].name.split("$")[0] + '_ddlstatus';
        var e = document.getElementById(OSts);
        if (e != null) {
            OSts = e.options[e.selectedIndex].value.split("_")[0];
        }

        setInterval(function() {
            if (($("#hdnAutoSave").val()) == "Y") {
            if (($("#hdnRoleName").val()) == "Lab Technician") {
                fnSaveAsDrafts1();
                }
            }
        }, 50000);


    });
    function fnSaveAsDrafts1() {
        var visitid = $('[ID*=hdnPatientVisitID]').val();
        var loginid = $('[ID*=hdnloginid]').val();
        var orgid = $('[ID=hdnOrgID]').val();
        var LstInvValues = [];
        var lstpatientinv = [];
        if (visitid != 0 && visitid != "") {
            //txtorgan(Specimen) change begins//
            var OrganValue = $("[name*=txtOrgan]");
            if (OrganValue.length > 0) {
                var Organvalues;
                var OrganInvID;
                var OrganName;
                var organDDlID;
                var organStatus;
                var FCKSection1;
                for (var i = 0; i < OrganValue.length; i++) {
                    var organfck = OrganValue[i].name.split("$")[0] + '_txtOrgan';
                   

                    FCKSection1 = CKEDITOR.instances[organfck];
                    var d = "[id*='" + organfck+"']";
                    FCKSection1=$(d).html();
                    
                    if (FCKSection1 != undefined) {
                        Organvalues = FCKSection1;
                    }
                    if (Organvalues != "" && Organvalues != null && Organvalues != "<br />") {
                        OrganInvID = OrganValue[i].name.split("~")[0];
                        organDDlID = OrganValue[i].name.split("$")[0] + '_ddlstatus';
                        OrganName = $("[id*=lblOrgan]").html();
                        //OrganName = OrganName.replace("&amp;", "&");
                        
                        var e = document.getElementById(organDDlID);
                        organStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending" ) {
                            organStatus = "Pending";
                            }
                            
                        LstInvValues.push({
                            InvestigationID: OrganInvID,
                            Name: OrganName,
                            Value: Organvalues,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid,
                            Status: organStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //txtorgana change End//
            //Specimen No change begins//
            var objSpecimenNoval = $("[name*=txtSpecimenNo]");
            if (objSpecimenNoval.length > 0) {
                var SpecNovalue;
                var SpecNoInvID;
                var SpecNoName;
                var SpecNoDDlID;
                var SpecNoStatus;
                for (var i = 0; i < objSpecimenNoval.length; i++) {
                    SpecNovalue = objSpecimenNoval[i].value;
                    if (SpecNovalue != "" && SpecNovalue != null && SpecNovalue != "<br />") {
                        SpecNoInvID = objSpecimenNoval[i].name.split("~")[0];
                        SpecNoDDlID = objSpecimenNoval[i].name.split("$")[0] + '_ddlstatus';
                        SpecNoName = $("[id*=lblSpecimenNo]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        
                        var e = document.getElementById(SpecNoDDlID);
                        SpecNoStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            SpecNoStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: SpecNoInvID,
                            Name: SpecNoName,
                            Value: SpecNovalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: SpecNoStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //Specimen No change End//

            //ClinicalNotes change Begins//
            var objclinicnotes = $("[name*=txtClinicalNotes]");
            if (objclinicnotes.length > 0) {
                var CNvalue;
                var CNInvID;
                var CNName;
                var CNDDlID;
                var CNStatus;
                var FCKSection1;
                for (var i = 0; i < objclinicnotes.length; i++) {
                    CNvalue = objclinicnotes[i].value;
                    if(CNvalue=="")
                    {
                        var objclinicnotes1 = $("[id*=tdNoteCell]");
                        CNvalue = objclinicnotes1.html();
                    }
                    if (CNvalue != "" && CNvalue != null && CNvalue != "<br />") {
                        CNInvID = objclinicnotes[i].name.split("~")[0];
                        CNDDlID = objclinicnotes[i].name.split("$")[0] + '_ddlstatus';
                        CNName = $("[id*=lblClinicalNotes]").html().split(' ').join('');
                        //CNName = CNName.replace("&amp;", "&");
                      
                        var e = document.getElementById(CNDDlID);
                        CNStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            CNStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: CNInvID,
                            Name: CNName,
                            Value: CNvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: CNStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //ClinicalNotes change End//

            //Gross change Begins//
            var objGross = $("[name*=txtGross]");
            if (objGross.length > 0) {
                var Grossvalue;
                var GrossInvID;
                var GrossName;
                var GrossDDlID;
                var GrossStatus;
                var FCKSection1;
                for (var i = 0; i < objGross.length; i = objGross.length) {
                    var grossfck = objGross[i].name.split("$")[0] + '_txtGross';
                   // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[grossfck];
                   // }
                    if (FCKSection1 != undefined) {
                        Grossvalue = FCKSection1.getData();
                    }
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblGross]").html();
                        //GrossName = GrossName.replace("&amp", "&");
                        
                        var e = document.getElementById(GrossDDlID);
                        GrossStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            GrossStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: GrossInvID,
                            Name: GrossName,
                            Value: Grossvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: GrossStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //Gross change End//

            //GrossedBy change Begins//
            var objGross = $("[name*=txtGrossedBy]");
            if (objGross.length > 0) {
                var Grossvalue;
                var GrossInvID;
                var GrossName;
                var GrossDDlID;
                var GrossStatus;
                var FCKSection1;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblGrossedby]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        
                        var e = document.getElementById(GrossDDlID);
                        GrossStatus = e.options[e.selectedIndex].value.split("_")[0];
                       if (OSts == "Pending") {
                            GrossStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: GrossInvID,
                            Name: GrossName,
                            Value: Grossvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: GrossStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //GrossedBY change End//

            //txtAssistedBy change Begins//
            var objGross = $("[name*=txtAssistedBy]");
            if (objGross.length > 0) {
                var Grossvalue;
                var GrossInvID;
                var GrossName;
                var GrossDDlID;
                var GrossStatus;
                var FCKSection1;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblAssistedby]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        
                        var e = document.getElementById(GrossDDlID);
                        GrossStatus = e.options[e.selectedIndex].value.split("_")[0];
                         if (OSts == "Pending") {
                            GrossStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: GrossInvID,
                            Name: GrossName,
                            Value: Grossvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: GrossStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //txtAssistedBy change End//

            //txttimeoffixation change Begins//
            var objGross = $("[name*=txttimeoffixation]");
            if (objGross.length > 0) {
                var Grossvalue;
                var GrossInvID;
                var GrossName;
                var GrossDDlID;
                var GrossStatus;
                var FCKSection1;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblTimeoffixation]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        
                        var e = document.getElementById(GrossDDlID);
                        GrossStatus = e.options[e.selectedIndex].value.split("_")[0];
                         if (OSts == "Pending") {
                            GrossStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: GrossInvID,
                            Name: GrossName,
                            Value: Grossvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: GrossStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //txttimeoffixation change End//

            //Microscopy change Begins//
            var objMicroscopy = $("[name$=txtMicroscopy]");
            if (objMicroscopy.length > 0) {
                var Micvalue;
                var MicInvID;
                var MicName;
                var MicDDlID;
                var MicStatus;
                var FCKSection1;
                for (var i = 0; i < objMicroscopy.length; i++) {
                    var micfck = objMicroscopy[i].name.split("$")[0] + '_txtMicroscopy';
                    //if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[micfck];
                    //}
                    if (FCKSection1 != undefined) {
                        Micvalue = FCKSection1.getData();
                    }
                    if (Micvalue != "" && Micvalue != null && Micvalue != "<br />") {
                        MicInvID = objMicroscopy[i].name.split("~")[0];
                        MicDDlID = objMicroscopy[i].name.split("$")[0] + '_ddlstatus';
                        MicName = $("[id*=lblMicroscopy]").html();
                        //MicName = MicName.replace("&amp;", "&");
                        
                        var e = document.getElementById(MicDDlID);
                        MicStatus = e.options[e.selectedIndex].value.split("_")[0];
                         if (OSts == "Pending") {
                             MicStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: MicInvID,
                            Name: MicName,
                            Value: Micvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: MicStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //Microscopy change End//
            //Impression change Begins//
            var objImpression = $("[name*=txtImpression]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                for (var i = 0; i < objImpression.length; i++) {
                    var impfck = objImpression[i].name.split("$")[0] + '_txtImpression';
                   // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[impfck];
                   // }
                    if (FCKSection1 != undefined) {
                        Impvalue = FCKSection1.getData();
                    }
                    if (Impvalue != "" && Impvalue != null && Impvalue != "<br />") {
                        ImpInvID = objImpression[i].name.split("~")[0];
                        ImpDDlID = objImpression[i].name.split("$")[0] + '_ddlstatus';

                        //ImpName = $("[id*=Label3]")[4].value;
                        ImpName = "Original H & E Report";
                        ImpName = ImpName.replace("&amp;", "&");
                        
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                             ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: ImpStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //Impression change End//
            //txtResult change Begins//
            var objImpression = $("[name*=txtResult]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                for (var i = 0; i < objImpression.length; i++) {
                    var impfck = objImpression[i].name.split("$")[0] + '_txtResult';
                   // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[impfck];
                   // }
                    if (FCKSection1 != undefined) {
                        Impvalue = FCKSection1.getData();
                    }
                    if (Impvalue != "" && Impvalue != null && Impvalue != "<br />") {
                        ImpInvID = objImpression[i].name.split("~")[0];
                        ImpDDlID = objImpression[i].name.split("$")[0] + '_ddlstatus';
                        ImpName = $("[id*=lblResult]").html();
                        //ImpName = ImpName.replace("&amp;", "&");
                        
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                             ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: ImpStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //txtResult change End//
            //txtDiagnosis change Begins//
            var objImpression = $("[name*=txtDiagnosis]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                for (var i = 0; i < objImpression.length; i++) {
                    var impfck = objImpression[i].name.split("$")[0] + '_txtDiagnosis';
                   // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[impfck];
                  //  }
                    if (FCKSection1 != undefined) {
                        Impvalue = FCKSection1.getData();
                    }
                    if (Impvalue != "" && Impvalue != null && Impvalue != "<br />") {
                        ImpInvID = objImpression[i].name.split("~")[0];
                        ImpDDlID = objImpression[i].name.split("$")[0] + '_ddlstatus';
                        ImpName = $("[id*=lblDiagnosis]").html();
                        //ImpName = ImpName.replace("&amp;", "&");
                        
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                         if (OSts == "Pending") {
                             ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: null,
                            GroupID: 0,
                            Orgid: orgid, //OrgID;
                            Status: ImpStatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });
                        
                    }
                }
            }
            //txtDiagnosis change End//

            var lstinvvalue = [];
            lstinvvalue.push(LstInvValues);

            //PatientInvestigation list  change Begins//
            var patientinv = $("[name*=txtOrgan]");
            if (patientinv.length > 0) {
                var ptInvID;
                var ptDDlID;
                var ptStatus;
                for (var i = 0; i < patientinv.length; i++) {
                    ptInvID = patientinv[i].name.split("~")[0];
                    ptDDlID = patientinv[i].name.split("$")[0] + '_ddlstatus';
                    var e = document.getElementById(ptDDlID);
                    ptStatus = e.options[e.selectedIndex].value.split("_")[0];
                     if (OSts == "Pending") {
                             ptStatus = "Pending";
                        }
                    lstpatientinv.push({
                        InvestigationID: ptInvID,
                        PatientVisitID: visitid,
                        GroupName: null,
                        GroupID: 0,
                        Orgid: orgid, //OrgID;
                        Status: ptStatus,
                        Reason: null,
                        MedicalRemarks: null,
                        RemarksID: 0
                    });
                    
                }
            }
            //PatientInvestigation list  change Begins//
                        var vdata = {};
                        vdata.LstinvValues = lstinvvalue;
                       vdata.lstPatientInvs = lstpatientinv;
                       vdata.vid = visitid;
                       vdata.guid = $('[ID*=hdnguid]').val();
                       vdata.orgid = orgid;
                       if (vdata.lstPatientInvs.length > 0) {
                           $.ajax({
                               type: "POST",
                               url: "InvestigationResultsCapture.aspx/AutoSaveHisto",
                               data: JSON.stringify(vdata),
                               contentType: "application/json; charset=utf-8",
                               dataType: "json",
                               async: true,
                               success: function Success(data) {
                               },
                               error: function(jqXHR, textStatus, errorThrown) {
                                   alert(errorThrown);
                               }
                           });
                       }
        }
    }

    // end
    //InvRemarks
    function SelectedRemarks(source, eventArgs) {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnRemarksID') != null) {
            document.getElementById('hdnRemarksID').value = RemarksDetails;
        }
    }
    function GetInvMedicalRemarks(source, eventArgs) {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    //InvRemarks
    function AddItemsToTableHPP(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vMethods = SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_03') == null ? "Please Select Processing Methods" : SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_03');
        var vStaining = SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_04') == null ? "Please Select Staining" : SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_04');
        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ProcessMethods;
        var Staining;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hResultvalues').value;
        if (document.getElementById(splitString[0] + '_ddlProcessingMethods').value == "0") {
            //alert('Please Select Processing Methods');
            ValidationWindow(vMethods, AlertType);
            document.getElementById(splitString[0] + '_ddlProcessingMethods').focus();
            return false;
        }
        if (document.getElementById(splitString[0] + '_ddlStaining').value == "0") {
            //alert('Please Select Staining');
            ValidationWindow(vStaining, AlertType);
            document.getElementById(splitString[0] + '_ddlStaining').focus();
            return false;
        }
        ProcessMethods = document.getElementById(splitString[0] + '_ddlProcessingMethods').options[document.getElementById(splitString[0] + '_ddlProcessingMethods').selectedIndex].text;
        Staining = document.getElementById(splitString[0] + '_ddlStaining').options[document.getElementById(splitString[0] + '_ddlStaining').selectedIndex].text;
        var row = document.getElementById(splitString[0] + '_tblResult').insertRow(1);
        rowNumber = HidValue.split('^').length;
        var rowID = splitString[0] + '_tblResult' + rowNumber;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        document.getElementById(splitString[0] + '_tblResult').style.display = "block";
        //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + rowID + ");' src='../Images/Delete.jpg' />";
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = ProcessMethods;
        cell2.width = "20%"
        cell3.innerHTML = Staining;
        cell3.width = "20%"
        document.getElementById(splitString[0] + '_hResultvalues').value += "RID:" + rowNumber + "~ProcessMethods:" + ProcessMethods + "~Staining:" + Staining + "^";
        document.getElementById(splitString[0] + '_ddlProcessingMethods').value = "0";
        document.getElementById(splitString[0] + '_ddlStaining').value = "0";
        return false;
    }
    function AddClinicalNotes(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vNotes = SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_05') == null ? "Please Select Clinical Notes" : SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_05');

        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ClinicalNotes;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        if (document.getElementById(splitString[0] + '_txtClinicalNotes').value == "") {
            //alert('Please Select Clinical Notes');
            ValidationWindow(vNotes, AlertType);
            document.getElementById(splitString[0] + '_txtClinicalNotes').focus();
            return false;
        }
        ClinicalNotes = document.getElementById(splitString[0] + '_txtClinicalNotes').value;
        if (HidValue != '') {
            rowNumber = HidValue.split(',').length;
        }
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "block";

        if (document.getElementById(splitString[0] + '_hdnClinicalNotes').value == '') {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = ClinicalNotes;
        }
        else {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = document.getElementById(splitString[0] + '_hdnClinicalNotes').value + ', ' + ClinicalNotes;
        }
        document.getElementById(splitString[0] + '_tdNoteCell').innerHTML = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        return false;
    }

    function ImgOnclick(ImgID) {
        //alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hResultvalues').value;
        var list = HidValue.split('^');
        // alert(ImgsplitID[0]);
        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hResultvalues').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != 'RID:' + ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hResultvalues').value = newInvList;
        }
    }
    function ImgClinicalNotesDelete(ImgID) {
        var splitString = ImgID.split('_');
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = '';
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "none";
        document.getElementById(splitString[0] + '_hdnClinicalNotes').value = '';
    }
    function ImgClinicalNotesEdit(ImgID) {
        var splitString = ImgID.split('_');
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = '';
        document.getElementById(splitString[0] + '_txtClinicalNotes').readOnly = false;
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        document.getElementById(splitString[0] + '_hdnClinicalNotes').value = '';
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "none";
    }

    function LoadExistingItems(hdnValue, idd) {
        if (document.getElementById(idd + '_hdnClinicalNotes').value != '') {
            document.getElementById(idd + '_tdClinicalNotes').style.display = "block";
            document.getElementById(idd + '_tdNoteCell').innerHTML = document.getElementById(idd + '_hdnClinicalNotes').value;
        }
        else {
            document.getElementById(idd + '_tdClinicalNotes').style.display = "none";
        }
    }


    function ValidateUpload(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vInvalid = SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_01') == null ? "Invalid File" : SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_01');
        // alert(id);
        var Upload_Image = document.getElementById(id);
        var myfile = Upload_Image.value;
        //alert(Upload_Image.value);
        if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0 || myfile.indexOf("JPG") > 0) {


        }
        else {
            //alert('Invalid File');
            ValidationWindow(vInvalid, AlertType);
        }
    }
    function SetBulkDataSearch_ClinicalNotes(KeyName, autoid) {
        autoClientid = autoid.split('_')[0] + '_' + 'AutoClinicalNotes';
        hdnContextClientid = autoid.split('_')[0] + '_' + 'hdnContext';
        searchvalue = $('[id$="' + hdnContextClientid + '"]').val() + "~" + KeyName;
        $find(autoClientid).set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_GrossedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoGrossedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_AssistedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoAssistedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_timeoffixation(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=Autotimeoffixation.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_TestperformedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoTestperformedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function ClickAdd(id) {
        var splitString = id.split('_');
        if (document.getElementById(splitString[0] + '_txtClinicalNotes').value != "") {
            document.getElementById(splitString[0] + '_btnCNAdd').click();
            document.getElementById(splitString[0] + '_txtClinicalNotes').value = "";
        }
    }
    function BindImage(invid, orgid, visitid, ctrlID) {
        var ctrlVal = "";
        var bindCtrlVal = "";
        var row$ = "";
        var tbl = document.getElementById(ctrlID + "_tblHistro");
        var tbody = $('<tbody/>');
        var i = 0;
        var ImgSourceDetails = JSON.parse(document.getElementById(ctrlID + '_hdnImgSourceDetails').value);
        var Description = JSON.parse(document.getElementById(ctrlID + '_hdnDescription').value);

        if (document.getElementById(ctrlID + '_hdnImgSourceDetails').value != "") {
            row$ = $('<tr/>');
            $.each(ImgSourceDetails, function(m, obj) {
                if (ImgSourceDetails[m].ImageID != "") {

                    var textdescription = Description[m].Description;


                    var url = "ProbeImagehandler.ashx?InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID;
                    ctrlVal = '<img src="' + url + '" alt="Image" id="ctlimg' + i + '" width="200" height="100">';
                    ctrlVal += '<br/><input id="hdnImg' + i + '" type="hidden" value="' + ImgSourceDetails[m].ImageID + '"/><input id="ctl' + i + '"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="HistroOnRowDelete(this);" />';


                    var downloadURL = "ProbeImagehandler.ashx?Download=true&InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID + "&ImageName=" + ImgSourceDetails[m].FilePath;
                    ctrlVal += '<a href="' + downloadURL + '" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; font-size: 11px;  alt="#">Download</a>'



                    ctrlVal += '<textarea id="txtDescription' + i + '" rows="2"  cols="15" readonly > ' + textdescription + ' </textarea>';


                    //   ctrlVal += '<input id="txtDescription' + i + '" type="text"  TextMode="MultiLine" value="' + textdescription + '"/>';
                    ctrlVal += '<input id="hdnInvestigationId' + i + '" type="hidden" value="' + invid + '"/>';
                    ctrlVal += '<input id="hdnOrgID' + i + '" type="hidden" value="' + orgid + '"/>';
                    ctrlVal += '<input id="hdnPvisitid' + i + '" type="hidden" value="' + visitid + '"/>';
                    bindCtrlVal = $('<td/>').html(ctrlVal);
                    row$.append(bindCtrlVal);
                    ctrlVal = "";
                    bindCtrlVal = "";
                    i++;

                }
                $(tbody).append(row$);
            });
            $(tbl).append(tbody);
        }
    }
    function HistroOnRowDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUnable = SListForAppMsg.Get('Investigation_GeneralPattern_ascx_02') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_GeneralPattern_ascx_02');
        try {
            var $row = $(obj).closest('td');
            var invID = $row.find("input[id^='hdnInvestigationId']").val();
            var orgID = $row.find("input[id^='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id^='hdnPvisitid']").val();
            var imageID = $row.find("input[id^='hdnImg']").val();
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }
            if (imageID == '' || imageID == undefined) {
                imageID = '0';
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + imageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('td').remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vUnable, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }


    function SetResultTemplate(objId, content) {
        try {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vTemplate = SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_02') == null ? "Select Result Template" : SListForAppMsg.Get('Investigation_HistoImageDescriptionPattern_ascx_02');

            var Orgid = $('input[id$=hdnOrgid]').val();
            var CtlID = $('input[id$=hidVal]').val();
            var userControlID = objId.split("_")
            var Result = $('select[id$="' + userControlID[0] + '_ddlInvResultTemplate"] option:selected').text();
            var Resultvalue = $('select[id$="' + userControlID[0] + '_ddlInvResultTemplate"] option:selected').val();
            if (Resultvalue == "0") {
                //alert('Select Result Template');
                ValidationWindow(vTemplate, AlertType);
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SetResultTemplate",
                    data: "{POrgid: " + Orgid + ",ControlID: " + CtlID + ",ResultName: '" + Result + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {

                        var ResultXmlData = $.parseXML(data.d);
                        if (typeof FCKeditorAPI != 'undefined') {

                            var txtGross = FCKeditorAPI.GetInstance(userControlID[0] + '_txtGross');
                            var txtMicroscopy = FCKeditorAPI.GetInstance(userControlID[0] + '_txtMicroscopy');
                            var txtImpression = FCKeditorAPI.GetInstance(userControlID[0] + '_txtImpression');
                            var txtResult = FCKeditorAPI.GetInstance(userControlID[0] + '_txtResult');
                            var txtDiagnosis = FCKeditorAPI.GetInstance(userControlID[0] + '_txtDiagnosis');


                            if (content == "Add") {

                                if (txtGross) {
                                    if (txtGross.GetHTML() == "") {
                                        txtGross.SetHTML($(ResultXmlData).find("Gross")[0].text);
                                    }
                                    else {
                                        txtGross.SetHTML(txtGross.GetHTML() + " " + $(ResultXmlData).find("Gross")[0].text);
                                    }
                                }
                                if (txtMicroscopy) {
                                    if (txtMicroscopy.GetHTML() == "") {
                                        txtMicroscopy.SetHTML($(ResultXmlData).find("Microscopy")[0].text);
                                    }
                                    else {
                                        txtMicroscopy.SetHTML(txtMicroscopy.GetHTML() + " " + $(ResultXmlData).find("Microscopy")[0].text);
                                    }
                                }
                                if (txtImpression) {
                                    if (txtImpression.GetHTML() == "") {
                                        txtImpression.SetHTML($(ResultXmlData).find("OriginalHEReport")[0].text);
                                    }
                                    else {
                                        txtImpression.SetHTML(txtImpression.GetHTML() + " " + $(ResultXmlData).find("OriginalHEReport")[0].text);
                                    }
                                }
                                if (txtResult) {
                                    if (txtResult.GetHTML() == "") {
                                        txtResult.SetHTML($(ResultXmlData).find("Result")[0].text);
                                    }
                                    else {
                                        txtResult.SetHTML(txtResult.GetHTML() + " " + $(ResultXmlData).find("Result")[0].text);
                                    }
                                }
                                if (txtDiagnosis) {
                                    if (txtDiagnosis.GetHTML() == "") {
                                        txtDiagnosis.SetHTML($(ResultXmlData).find("Diagnosis")[0].text);
                                    }
                                    else {
                                        txtDiagnosis.SetHTML(txtDiagnosis.GetHTML() + " " + $(ResultXmlData).find("Diagnosis")[0].text);
                                    }
                                }
                            }


                            else {


                                if (txtGross) {

                                    txtGross.SetHTML($(ResultXmlData).find("Gross")[0].text);
                                }
                                if (txtMicroscopy) {

                                    txtMicroscopy.SetHTML($(ResultXmlData).find("Microscopy")[0].text);
                                }
                                if (txtImpression) {

                                    txtImpression.SetHTML($(ResultXmlData).find("OriginalHEReport")[0].text);
                                }
                                if (txtResult) {

                                    txtResult.SetHTML($(ResultXmlData).find("Result")[0].text);
                                }
                                if (txtDiagnosis) {

                                    txtDiagnosis.SetHTML($(ResultXmlData).find("Diagnosis")[0].text);
                                }

                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {


                    }
                });
            }
        }

        catch (e) {
            return false;
        }

        return false;
    } 
    
</script>

<%--<asp:ScriptManager ID="sm" runat="server">
</asp:ScriptManager>--%>
<table>
    <tr>
        <td>
            <table width="width: 80%;">
                <tr>
                    <td style="font-weight: bold; font-size: 12px; height: 20px; color: #000;" colspan="3">
                        <input type="hidden" id="hdnProcess" value="" runat="server" />
                        <input type="hidden" id="hdnStain" value="" runat="server" />
                        <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                            meta:resourcekey="lblNameResource1"></asp:Label>
                        &nbsp;
                        <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                        <%--<asp:LinkButton id="lnkEdit" runat="server"  OnClientClick="lnkEdit_OnClientClick(this.id)" style="color: red; width:50px; font-size:larger"
                            visible="false"></asp:LinkButton>--%>
                        <a id="lnkEdit" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                            visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_HEMATOLOGY_ascx_01 %></u></a>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlEnableHis" runat="server" meta:resourcekey="pnlEnableHisResource1">
                            <table>
                                <tr>
                                    <td id="tdbarcodetxt" runat="server" style="font-weight: normal; font-size: 14px;
                                        height: 20px; color: #000; display: none">
                                        <asp:Label ID="lblbarcode" Text="Slide No" runat="server" 
                                            meta:resourceKey="lblbarcodeResource1"></asp:Label>
                                    </td>
                                    <td style="display: none" id="tdbarcode" runat="server">
                                        <asp:DropDownList ForeColor="Black" ID="ddlBarcode" runat="server" 
                                            meta:resourceKey="ddlBarcodeResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                        <asp:Label ID="lblSpecimenNo" runat="server" Text="Case No" 
                                            meta:resourceKey="lblSpecimenNoResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSpecimenNo" TextMode="MultiLine"
                                            runat="server" Width="200px" meta:resourcekey="txtSpecimenNoResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                        <asp:Label ID="lblOrgan" runat="server" Text="Specimen" meta:resourcekey="lblOrganResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtOrgan" TextMode="MultiLine"
                                            runat="server" Width="200px" meta:resourcekey="txtOrganResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; color: #000;" width="30%">
                                        <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" 
                                            meta:resourceKey="lblClinicalNotesResource1"></asp:Label>
                                    </td>
                                    <td colspan="4" width="70%">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td align="left" width="50%">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtClinicalNotes" onfocus="javascript:SetBulkDataSearch_ClinicalNotes('ClinicalNotes',this.id);"
                                                        runat="server" TextMode="MultiLine" Width="400px" Height="80px" 
                                                        onblur="javascript:ClickAdd(this.id);" 
                                                        meta:resourceKey="txtClinicalNotesResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoClinicalNotes" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtClinicalNotes" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdnContext" runat="server" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:Button ID="btnCNAdd" runat="server" class="btn" OnClientClick="return AddClinicalNotes(this.id);"
                                                        onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" Text="Add" 
                                                        meta:resourceKey="btnCNAddResource1" />
                                                </td>
                                                <td valign="top" style="font-weight: normal; font-size: 14px; height: 20px; color: #000;"
                                                    width="50%">
                                                    <table id="tdClinicalNotes" class="dataheaderInvCtrl" cellpadding="4" cellspacing="0"
                                                        width="100%" style="display: none;" runat="server">
                                                        <tr id="Tr2" class="colorforcontent" runat="server">
                                                            <td id="Td26" style="font-weight: bold; font-size: 14px; height: 8px; color: White;
                                                                width: 5%;" runat="server">
                                                                <img id="imgDeletebtn" style="cursor: pointer;" src="../Images/DoustBin.png" runat="server"
                                                                    title="Delete ClinicalNotes" onclick="javascript:ImgClinicalNotesDelete(this.id);" />
                                                            </td>
                                                            <td id="Td1" style="font-weight: bold; font-size: 14px; height: 8px; color: White;
                                                                width: 5%;" runat="server">
                                                                <img id="imgEditbtn" style="cursor: pointer;" src="~/Images/Edit.png" runat="server"
                                                                    title="Edit ClinicalNotes" onclick="javascript:ImgClinicalNotesEdit(this.id);" />
                                                            </td>
                                                            <td id="tdNoteCell" style="font-weight: bold; font-size: 14px; height: 8px; color: White;
                                                                width: 90%;" runat="server">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                        <asp:Label ID="lblProcessingMethods" runat="server" Text="Processing Methods" meta:resourcekey="lblProcessingMethodsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlProcessingMethods" runat="server" meta:resourcekey="ddlProcessingMethodsResource1">
                                            <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="Routine" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="Frozen Section" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="Microwave" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                        <asp:Label ID="lblStaining" runat="server" Text="Staining" meta:resourcekey="lblStainingResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlStaining" runat="server" meta:resourcekey="ddlStainingResource1">
                                            <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                            <asp:ListItem Text="Hematoxylin and Eosin" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnAddProcess" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return AddItemsToTableHPP(this.id);"
                                            meta:resourcekey="btnAddProcessResource1" />
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td colspan="4">
                                        <table id="tblResult" class="dataheaderInvCtrl" cellpadding="4" cellspacing="0" width="100%"
                                            style="display: none;" runat="server">
                                            <tr id="Tr1" class="colorforcontent" runat="server">
                                                <td id="Td25" style="font-weight: bold; font-size: 14px; height: 8px; color: White; width: 5%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                                </td>
                                                <td id="Td2" style="font-weight: bold; font-size: 14px; height: 8px; color: White; width: 20%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_ProcessingMethods" Text="Processing Methods" runat="server"></asp:Label>
                                                </td>
                                                <td id="Td3" style="font-weight: bold; font-size: 14px; height: 8px; color: White; width: 20%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_Staining" Text="Staining" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValues"
                                            Text="Please select the below Result Names one by one to keep adding Result Values:"
                                            runat="server" Font-Size="14px" meta:resourcekey="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValuesResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td id="Td4" style="font-size: 14px; height: 8px; width: 20%;" runat="server">
                                        <asp:Label ID="Rs_SelectResult" Text="Select Result Template" runat="server" 
                                            meta:resourceKey="Rs_SelectResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlInvResultTemplate" runat="server" 
                                                        CssClass="ddl" meta:resourceKey="ddlInvResultTemplateResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnLoadResultTemplate" runat="server" Text="Load" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:SetResultTemplate(this.id,this.value);return false;"
                                                        meta:resourcekey="btnLoadResultTemplateResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddResultTemplate" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:SetResultTemplate(this.id,this.value);return false;"
                                                        meta:resourcekey="btnAddResultTemplateResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 15px; color: #000;">
                                        <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGrossResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtGross" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtGrossResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtGross" FontSizes="10px" FontNames="Arial" runat="server"
                                            Width="600px" Height="200px" ToolbarSet="Biospy"  meta:resourceKey="txtGrossResource1" >
                                       </FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <table class="dataheaderInvCtrl" cellpadding="4" cellspacing="0" border="0">
                                            <tr>
                                                <td class="colorforcontent" style="font-weight: bold; font-size: 11px; color: White;">
                                                    <asp:Label ID="lblGrossedby" Width="100px" runat="server" Text="Grossed By" 
                                                        meta:resourceKey="lblGrossedbyResource1"></asp:Label>
                                                </td>
                                                <td width="20%">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtGrossedBy" onfocus="javascript:SetBulkDataSearch_GrossedBy('Grossed By','<%=AutoGrossedBy.ClientID%>');"
                                                        runat="server" Width="150px" meta:resourceKey="txtGrossedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoGrossedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtGrossedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="colorforcontent" style="font-weight: bold; font-size: 11px; height: 8px;
                                                    color: White;">
                                                    <asp:Label ID="lblAssistedby" runat="server" Width="100px" Text="Assisted By" 
                                                        meta:resourceKey="lblAssistedbyResource1"></asp:Label>
                                                </td>
                                                <td width="20%">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtAssistedBy" onfocus="javascript:SetBulkDataSearch_AssistedBy('Assisted By','<%=AutoAssistedBy.ClientID%>');"
                                                        runat="server" Width="150px" meta:resourceKey="txtAssistedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoAssistedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtAssistedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="colorforcontent" width="20%" style="font-weight: bold; font-size: 11px;
                                                    color: White;">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="100%" nowrap="nowrap">
                                                                <asp:Label ID="lblTimeoffixation" runat="server" Width="100%" 
                                                                    Text="Time oF Fixation" meta:resourceKey="lblTimeoffixationResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100%" nowrap="nowrap">
                                                                <asp:Label ID="lblTimeOffixToolTip" runat="server" Width="100%" Text="(for ER, PR, Cer B2)"
                                                                    ForeColor="DarkGreen" meta:resourceKey="lblTimeOffixToolTipResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="20%">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txttimeoffixation" onfocus="javascript:SetBulkDataSearch_timeoffixation('Time Of Fixation','<%=Autotimeoffixation.ClientID%>');"
                                                        runat="server" Width="150px" meta:resourceKey="txttimeoffixationResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="Autotimeoffixation" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txttimeoffixation" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 15px; color: #000;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblImpression" runat="server" Text="Original H & E Report" Visible="False"
                                                        ToolTip="Only for Second Opinion Histo, IHC, ER, PR Tests" 
                                                        meta:resourceKey="lblImpressionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text="Advice/Comment" Font-Bold="False" 
                                                        meta:resourceKey="Label3Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtImpression" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" 
                                            meta:resourceKey="txtImpressionResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 15px; color: #000;">
                                        <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtMicroscopy" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtMicroscopyResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtMicroscopy" FontSizes="10px" FontNames="Arial"
                                            runat="server" Width="600px" ToolbarSet="Biospy" 
                                            meta:resourceKey="txtMicroscopyResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 15px; color: #000;">
                                        <asp:Label ID="lblResult" runat="server" Text="Result" 
                                            meta:resourceKey="lblResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtResult" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourceKey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 14px; height: 15px; color: #000;">
                                        <asp:Label ID="lblDiagnosis" runat="server" Text="Diagnosis" 
                                            meta:resourceKey="lblDiagnosisResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                    Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtDiagnosis" runat="server" Width="600px" FontSizes="10px"
                                            FontNames="Arial" Height="200px" ToolbarSet="Biospy">
                                        </FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="80%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td class="colorforcontent" width="40%" style="font-weight: bold; font-size: 11px;
                                                    color: White;">
                                                    <asp:Label ID="lblTestperformedby" runat="server" Text="Test Performed By" 
                                                        meta:resourceKey="lblTestperformedbyResource1"></asp:Label>
                                                    <asp:Label ID="lblToolTestper" runat="server" Text="(for IHC & Special Stains)" 
                                                        ForeColor="DarkGreen" meta:resourceKey="lblToolTestperResource1"></asp:Label>
                                                </td>
                                                <td width="60%">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtTestperformedBy" onfocus="javascript:SetBulkDataSearch_TestperformedBy('TestPerformedBy','<%=AutoTestperformedBy.ClientID%>');"
                                                        runat="server" Width="300px"
                                                        meta:resourceKey="txtTestperformedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoTestperformedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtTestperformedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" 
                                        meta:resourcekey="ddlstatusResource1">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 5%;">
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                    Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                    meta:resourcekey="ddlStatusReasonResource1" CssClass="ddl">
                                                    <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <span class="richcombobox" style="width: 100px;">
                                                    <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                        CssClass="ddl" Width="100px" meta:resourcekey="ddlOpinionUserResource1">
                                                       <%-- <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="font-weight: normal; font-size: 14px; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_Comments" Text="Technical Remarks" Width="70px" 
                                        runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                        CssClass="textbox_pattern" Height="94%" Width="200px" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                <td style="font-weight: normal; font-size: 14px; height: 10px; color: #000; width: 8%;">
                                    <asp:Label ID="lblMedRemarks" Text="Medical Remarks" Width="70px" runat="server"></asp:Label>
                                </td>
                                <td style="font-weight: normal; font-size: 10px; height: 50px; color: #000; width: 8%;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                                        TextMode="MultiLine" CssClass="textbox_pattern" Height="84%" Width="200px"
                                        meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                                </td>
                                <td>
                                    &nbsp;
                                    <asp:HiddenField runat="server" ID="hidVal" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <%--<asp:LinkButton ID="lnkBrowse" runat="server" Text="Browse">
        </asp:LinkButton>--%>
            <%--<ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" PopupControlID="divPopUp" PopupDragHandleControlID="panelDragHandle"
                TargetControlID="lnkBrowse" />--%>
            <div id="divPopUp" class="modalPopup">
                <table>
                    <tr>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUploadResource1" />
                        </td>
                        <td>
                            <asp:Label ID="lbldescription1" runat="server" Text="Description" 
                                meta:resourcekey="lbldescription1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtdescription1" runat="server" 
                                meta:resourcekey="txtdescription1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload2" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload2Resource1" />
                        </td>
                         <td>
                            <asp:Label ID="lbldescription2" runat="server" Text="Description" 
                                meta:resourcekey="lbldescription2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtdescription2" runat="server" 
                                meta:resourcekey="txtdescription2Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload3" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload3Resource1" />
                        </td>
                          <td>
                            <asp:Label ID="lbldescription3" runat="server" Text="Description" 
                                meta:resourcekey="lbldescription3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtdescription3" runat="server" 
                                meta:resourcekey="txtdescription3Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" accept="jpg" ID="flUpload4" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload4Resource1" />
                        </td>
                         <td>
                            <asp:Label ID="lbldescription4" runat="server" Text="Description" 
                                meta:resourcekey="lbldescription4Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtdescription4" runat="server" 
                                meta:resourcekey="txtdescription4Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table id="tblHistro" cellpadding="3" cellspacing="0" width="98%" runat="server">
    <thead>
    </thead>
    <tbody>
    </tbody>
</table>

<input type="hidden" id="hResultvalues" value="" style="width: 50%;" runat="server" />
<input type="hidden" id="hdnClinicalNotes" value="" style="width: 50%;" runat="server" />
<input type="hidden" id="hdnAllClinicalNotes" value="" style="width: 50%;" runat="server" />
<input type="hidden" id="hdnControlID" value="" style="width: 50%;" runat="server" />
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<input id="hdninvid" runat="server" type="hidden" value="" />
<input id="hdnOrgid" runat="server" type="hidden" value="" />
<input id="hdnDescription" runat="server" type="hidden" value="" />
<input id="hdnImgSourceDetails" runat="server" type="hidden" value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
    .style4
    {
        width: 50px;
    }
    .dataheaderInvCtrl
    {
        width: 98%;
    }
</style>
