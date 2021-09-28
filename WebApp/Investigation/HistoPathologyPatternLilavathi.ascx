<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HistoPathologyPatternLilavathi.ascx.cs"
    Inherits="Investigation_HistoPathologyPatternLilavathi" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>


<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>

<script language="javascript" type="text/javascript">

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
                if (($("#hdnRoleName").val()) == "Lab Technician" || ($("#hdnRoleName").val()) == "SrLabTech" || ($("#hdnRoleName").val()) == "Doctor" || ($("#hdnRoleName").val()) == "Office Assistant") {
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
        var commonstatus = "Pending";
        if (visitid != 0 && visitid != "") {

            if (($("#hdnRoleName").val()) == "Lab Technician" || ($("#hdnRoleName").val()) == "Office Assistant") {
                commonstatus = "Pending";
            }
            else {
                if (($("#hdnDeptwiseLoginRole").val()) == "Y") {
                    if (($("#hdnRoleName").val()) == "Doctor") {
                        commonstatus = "Completed";
                    }
                }
                else {
                    if (($("#hdnRoleName").val()) == "SrLabTech") {
                        commonstatus = "Completed";
                    }
                    else if (($("#hdnRoleName").val()) == "Doctor") {
                        commonstatus = "Validate";
                    }
                }
            }
        
            //txtorgan(Specimen) change begins//
            var OrganValue = $("[name*=txtOrgan]");
            if (OrganValue.length > 0) {
                var Organvalues;
                var OrganInvID;
                var OrganName;
                var organDDlID;
                var organStatus;
                var OrganGroupid;
                var OrganGroupName;
                var FCKSection1;
                for (var i = 0; i < OrganValue.length; i++) {
//                    var organfck = OrganValue[i].name.split("$")[0] + '_txtOrgan';


//                    FCKSection1 = CKEDITOR.instances[organfck];
//                    var d = "[id*='" + organfck + "']";
//                    FCKSection1 = $(d).html();

//                    if (FCKSection1 != undefined) {
//                        Organvalues = FCKSection1;
                    //                    }
                    Organvalues = OrganValue[i].value;
                    if (Organvalues != "" && Organvalues != null && Organvalues != "<br />") {
                        OrganInvID = OrganValue[i].name.split("~")[0];
                        organDDlID = OrganValue[i].name.split("$")[0] + '_ddlstatus';
                        OrganName = $("[id*=lblOrgan]").html();
                        //OrganName = OrganName.replace("&amp;", "&");
                        OrganGroupid = OrganValue[i].name.split("~")[2];
                        OrganGroupName = OrganValue[i].name.split("~")[1];
                        var e = document.getElementById(organDDlID);
                        organStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            organStatus = "Pending";
                        }

                        LstInvValues.push({
                            InvestigationID: OrganInvID,
                            Name: OrganName,
                            Value: Organvalues,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: OrganGroupName,
                            GroupID: OrganGroupid,
                            Orgid: orgid,
                            Status: commonstatus,
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
                var SpecNoGroupid;
                var SpecNoGroupName;
                for (var i = 0; i < objSpecimenNoval.length; i++) {
                    SpecNovalue = objSpecimenNoval[i].value;
                    if (SpecNovalue != "" && SpecNovalue != null && SpecNovalue != "<br />") {
                        SpecNoInvID = objSpecimenNoval[i].name.split("~")[0];
                        SpecNoDDlID = objSpecimenNoval[i].name.split("$")[0] + '_ddlstatus';
                        SpecNoName = $("[id*=lblSpecimenNo]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        SpecNoGroupid = objSpecimenNoval[i].name.split("~")[2];
                        SpecNoGroupName = objSpecimenNoval[i].name.split("~")[1];
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
                            GroupName: SpecNoGroupName,
                            GroupID: SpecNoGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var CNGroupid;
                var CNGroupName;
                for (var i = 0; i < objclinicnotes.length; i++) {
                    CNvalue = objclinicnotes[i].value;
                    if (CNvalue == "") {
                        var objclinicnotes1 = $("[id*=tdNoteCell]");
                        //                        CNvalue = objclinicnotes1.html();
                        CNvalue = objclinicnotes1[i].innerHTML;
                        CNvalue = CNvalue.trim();
                    }
                    if (CNvalue != "" && CNvalue != null && CNvalue != "<br />") {
                        CNInvID = objclinicnotes[i].name.split("~")[0];
                        CNDDlID = objclinicnotes[i].name.split("$")[0] + '_ddlstatus';
                        CNName = $("[id*=lblClinicalNotes]").html().split(' ').join('');
                        //CNName = CNName.replace("&amp;", "&");
                        CNGroupid = objclinicnotes[i].name.split("~")[2];
                        CNGroupName = objclinicnotes[i].name.split("~")[1];
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
                            GroupName: CNGroupName,
                            GroupID: CNGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var GrossGroupid;
                var GrossGroupName;
//                for (var i = 0; i < objGross.length; i = objGross.length) {
                for (var i = 0; i < objGross.length; i++) {
                    var grossfck = objGross[i].name.split("$")[0] + '_txtGross';
                    // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[grossfck];
                    // }
                    if (FCKSection1 != undefined) {
                        Grossvalue = FCKSection1.getData();
                    }
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        i++;
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblGross]").html();
                        //GrossName = GrossName.replace("&amp", "&");
                        GrossGroupid = objGross[i].name.split("~")[2];
                        GrossGroupName = objGross[i].name.split("~")[1];

                        var e = document.getElementById(GrossDDlID);
                        GrossStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            GrossStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: GrossInvID,
                            Name: GrossName,
                            Value: Grossvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: GrossGroupName,
                            GroupID: GrossGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var GrossGroupid;
                var GrossGroupName;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblGrossedby]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        GrossGroupid = objGross[i].name.split("~")[2];
                        GrossGroupName = objGross[i].name.split("~")[1];
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
                            GroupName: GrossGroupName,
                            GroupID: GrossGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var GrossGroupid;
                var GrossGroupName;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblAssistedby]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        GrossGroupid = objGross[i].name.split("~")[2];
                        GrossGroupName = objGross[i].name.split("~")[1];
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
                            GroupName: GrossGroupName,
                            GroupID: GrossGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var GrossGroupid;
                var GrossGroupName;
                for (var i = 0; i < objGross.length; i++) {
                    Grossvalue = objGross[i].value;
                    if (Grossvalue != "" && Grossvalue != null && Grossvalue != "<br />") {
                        GrossInvID = objGross[i].name.split("~")[0];
                        GrossDDlID = objGross[i].name.split("$")[0] + '_ddlstatus';
                        GrossName = $("[id*=lblTimeoffixation]").html();
                        //GrossName = GrossName.replace("&amp;", "&");
                        GrossGroupid = objGross[i].name.split("~")[2];
                        GrossGroupName = objGross[i].name.split("~")[1];
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
                            GroupName: GrossGroupName,
                            GroupID: GrossGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
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
                var MicGroupid;
                var MicGroupName;
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
                        MicGroupid = objMicroscopy[i].name.split("~")[2];
                        MicGroupName = objMicroscopy[i].name.split("~")[1];
                        var e = document.getElementById(MicDDlID);
                        MicStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            MicStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: MicInvID,
                            Name: MicName,
                            Value: Micvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: MicGroupName,
                            GroupID: MicGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }

            //Comments change begins//
            var objCommentsval = $("[name*=txtComments]");
            if (objCommentsval.length > 0) {
                var Commentsvalue;
                var CommentsInvID;
                var CommentsName;
                var CommentsDDlID;
                var CommentsStatus;
                var CommentsGroupid;
                var CommentsGroupName;
                for (var i = 0; i < objCommentsval.length; i++) {
                    Commentsvalue = objCommentsval[i].value;
                    if (Commentsvalue != "" && Commentsvalue != null && Commentsvalue != "<br />") {
                        CommentsInvID = objCommentsval[i].name.split("~")[0];
                        CommentsDDlID = objCommentsval[i].name.split("$")[0] + '_ddlstatus';
                        CommentsName = $("[id*=lblComments]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        CommentsGroupid = objCommentsval[i].name.split("~")[2];
                        CommentsGroupName = objCommentsval[i].name.split("~")[1];
                        var e = document.getElementById(CommentsDDlID);
                        CommentsStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            CommentsStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: CommentsInvID,
                            Name: CommentsName,
                            Value: Commentsvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: CommentsGroupName,
                            GroupID: CommentsGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Comments change End//

            //Remarks change begins//
            var objRemarksval = $("[name*=txtRemarks]");
            if (objRemarksval.length > 0) {
                var Remarksvalue;
                var RemarksInvID;
                var RemarksName;
                var RemarksDDlID;
                var RemarksStatus;
                var RemarksGroupid;
                var RemarksGroupName;
                for (var i = 0; i < objRemarksval.length; i++) {
                    Remarksvalue = objRemarksval[i].value;
                    if (Remarksvalue != "" && Remarksvalue != null && Remarksvalue != "<br />") {
                        RemarksInvID = objRemarksval[i].name.split("~")[0];
                        RemarksDDlID = objRemarksval[i].name.split("$")[0] + '_ddlstatus';
                        //RemarksName = $("[id*=lblRemarks]").html();
                        RemarksName = "Remarks";
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        RemarksGroupid = objRemarksval[i].name.split("~")[2];
                        RemarksGroupName = objRemarksval[i].name.split("~")[1];
                        var e = document.getElementById(RemarksDDlID);
                        RemarksStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            RemarksStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: RemarksInvID,
                            Name: RemarksName,
                            Value: Remarksvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: RemarksGroupName,
                            GroupID: RemarksGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Remarks change End//
            
            
            //txtResult change Begins//
            var objImpression = $("[name*=txtResult]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                var ImpGroupid;
                var ImpGroupName;
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
                        ImpGroupid = objImpression[i].name.split("~")[2];
                        ImpGroupName = objImpression[i].name.split("~")[1];
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: ImpGroupName,
                            GroupID: ImpGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //txtResult change End//
            //VEL | 08-07-2019 | Add new IF
            //txtIF change Begins//
            var objImpression = $("[name*=txtIF]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                var ImpGroupid;
                var ImpGroupName;
                for (var i = 0; i < objImpression.length; i++) {
                    var impfck = objImpression[i].name.split("$")[0] + '_txtIF';
                    // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[impfck];
                    // }
                    if (FCKSection1 != undefined) {
                        Impvalue = FCKSection1.getData();
                    }
                    if (Impvalue != "" && Impvalue != null && Impvalue != "<br />") {
                        ImpInvID = objImpression[i].name.split("~")[0];
                        ImpDDlID = objImpression[i].name.split("$")[0] + '_ddlstatus';
                        ImpName = $("[id*=lblIF]").html();
                        //ImpName = ImpName.replace("&amp;", "&");
                        ImpGroupid = objImpression[i].name.split("~")[2];
                        ImpGroupName = objImpression[i].name.split("~")[1];
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: ImpGroupName,
                            GroupID: ImpGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //txtIF change End//
            //VEL | 08-07-2019 | Add new IF
            //txtDiagnosis change Begins//
            var objImpression = $("[name*=txtDiagnosis]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                var ImpGroupid;
                var ImpGroupName;
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
                        ImpGroupid = objImpression[i].name.split("~")[2];
                        ImpGroupName = objImpression[i].name.split("~")[1];
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: ImpGroupName,
                            GroupID: ImpGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //txtDiagnosis change End//

            //txtImpression change Begins//
            var objImpression = $("[name*=txtImpression]");
            if (objImpression.length > 0) {
                var Impvalue;
                var ImpInvID;
                var ImpName;
                var ImpDDlID;
                var ImpStatus;
                var FCKSection1;
                var ImpGroupid;
                var ImpGroupName;
                for (var i = 0; i < objImpression.length; i++) {
                    var impfck = objImpression[i].name.split("$")[0] + '_txtImpression';
                    // if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[impfck];
                    //  }
                    if (FCKSection1 != undefined) {
                        Impvalue = FCKSection1.getData();
                    }
                    if (Impvalue != "" && Impvalue != null && Impvalue != "<br />") {
                        ImpInvID = objImpression[i].name.split("~")[0];
                        ImpDDlID = objImpression[i].name.split("$")[0] + '_ddlstatus';
                        ImpName = $("[id*=lblImpression]").html();
                        //ImpName = ImpName.replace("&amp;", "&");
                        ImpGroupid = objImpression[i].name.split("~")[2];
                        ImpGroupName = objImpression[i].name.split("~")[1];
                        var e = document.getElementById(ImpDDlID);
                        ImpStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            ImpStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ImpInvID,
                            Name: ImpName,
                            Value: Impvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: ImpGroupName,
                            GroupID: ImpGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //txtImpression change End//
            
            //Suggest change begins//
            var objSuggestval = $("[name*=txtSuggest]");
            if (objSuggestval.length > 0) {
                var Suggestvalue;
                var SuggestInvID;
                var SuggestName;
                var SuggestDDlID;
                var SuggestStatus;
                var SuggestGroupid;
                var SuggestGroupName;
                for (var i = 0; i < objSuggestval.length; i++) {
                    Suggestvalue = objSuggestval[i].value;
                    if (Suggestvalue != "" && Suggestvalue != null && Suggestvalue != "<br />") {
                        SuggestInvID = objSuggestval[i].name.split("~")[0];
                        SuggestDDlID = objSuggestval[i].name.split("$")[0] + '_ddlstatus';
                        SuggestName = $("[id*=lblSuggest]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        SuggestGroupid = objSuggestval[i].name.split("~")[2];
                        SuggestGroupName = objSuggestval[i].name.split("~")[1];
                        var e = document.getElementById(SuggestDDlID);
                        SuggestStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            SuggestStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: SuggestInvID,
                            Name: SuggestName,
                            Value: Suggestvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: SuggestGroupName,
                            GroupID: SuggestGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Suggest change End//

            //ICDCode change begins//
            var objICDCodeval = $("[name*=txtICDCode]");
            if (objICDCodeval.length > 0) {
                var ICDCodevalue;
                var ICDCodeInvID;
                var ICDCodeName;
                var ICDCodeDDlID;
                var ICDCodeStatus;
                var ICDCodeGroupid;
                var ICDCodeGroupName;
                for (var i = 0; i < objICDCodeval.length; i++) {
                    ICDCodevalue = objICDCodeval[i].value;
                    if (ICDCodevalue != "" && ICDCodevalue != null && ICDCodevalue != "<br />") {
                        ICDCodeInvID = objICDCodeval[i].name.split("~")[0];
                        ICDCodeDDlID = objICDCodeval[i].name.split("$")[0] + '_ddlstatus';
                        ICDCodeName = "ICD Code";  //$("[id*=lblICDCode]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        ICDCodeGroupid = objICDCodeval[i].name.split("~")[2];
                        ICDCodeGroupName = objICDCodeval[i].name.split("~")[1];
                        var e = document.getElementById(ICDCodeDDlID);
                        ICDCodeStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            ICDCodeStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: ICDCodeInvID,
                            Name: ICDCodeName,
                            Value: ICDCodevalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: ICDCodeGroupName,
                            GroupID: ICDCodeGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //ICDCode change End//

            //Category change begins//
            var objCategoryval = $("[name*=ddlCategory]");
            if (objCategoryval.length > 0) {
                var Categoryvalue; 
                var CategoryInvID;
                var CategoryName;
                var CategoryDDlID;
                var CategoryStatus;
                var CategoryGroupid;
                var CategoryGroupName;
                for (var i = 0; i < objCategoryval.length; i++) {
                    Categoryvalue = objCategoryval[i].value;
                    if (Categoryvalue != "" && Categoryvalue != null && Categoryvalue != "<br />" && Categoryvalue != "Select") {
                        CategoryInvID = objCategoryval[i].name.split("~")[0];
                        CategoryDDlID = objCategoryval[i].name.split("$")[0] + '_ddlstatus';
                        CategoryName = $("[id*=lblCategory]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        CategoryGroupid = objCategoryval[i].name.split("~")[2];
                        CategoryGroupName = objCategoryval[i].name.split("~")[1];
                        var e = document.getElementById(CategoryDDlID);
                        CategoryStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            CategoryStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: CategoryInvID,
                            Name: CategoryName,
                            Value: Categoryvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: CategoryGroupName,
                            GroupID: CategoryGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Category change End//

            //Summary of Sections change begins//
            var objSummarySectionval = $("[name*=txtSummary]");
            if (objSummarySectionval.length > 0) {
                var SummarySectionvalue;
                var SummarySectionInvID;
                var SummarySectionName;
                var SummarySectionDDlID;
                var SummarySectionStatus;

                var SummarySectionGroupid;
                var SummarySectionGroupName;
                for (var i = 0; i < objSummarySectionval.length; i++) {
                    SummarySectionvalue = objSummarySectionval[i].value;
                    if (SummarySectionvalue != "" && SummarySectionvalue != null && SummarySectionvalue != "<br />") {
                        SummarySectionInvID = objSummarySectionval[i].name.split("~")[0];
                        SummarySectionDDlID = objSummarySectionval[i].name.split("$")[0] + '_ddlstatus';
                        SummarySectionName = "Summary of Sections";  //$("[id*=lblCategory]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        SummarySectionGroupid = objSummarySectionval[i].name.split("~")[2];
                        SummarySectionGroupName = objSummarySectionval[i].name.split("~")[1];
                        var e = document.getElementById(SummarySectionDDlID);
                        SummarySectionStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            SummarySectionStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: SummarySectionInvID,
                            Name: SummarySectionName,
                            Value: SummarySectionvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: SummarySectionGroupName,
                            GroupID: SummarySectionGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Summary of Sections change End//

            //Special Stain change begins//
            var objSpecialStainval = $("[name*=txtSpecialStain]");
            if (objSpecialStainval.length > 0) {
                var SpecialStainvalue;
                var SpecialStainInvID;
                var SpecialStainName;
                var SpecialStainDDlID;
                var SpecialStainStatus;
                var SpecialStainGroupid;
                var SpecialStainGroupName;
                for (var i = 0; i < objSpecialStainval.length; i++) {
                    var SPSfck = objSpecialStainval[i].name.split("$")[0] + '_txtSpecialStain';
                    //if (typeof FCKeditorAPI != 'undefined') {
                    FCKSection1 = CKEDITOR.instances[SPSfck];
                    //}
                    if (FCKSection1 != undefined) {
                        SpecialStainvalue = FCKSection1.getData();
                    } 
                
                
                    //SpecialStainvalue = objSpecialStainval[i].value;
                    if (SpecialStainvalue != "" && SpecialStainvalue != null && SpecialStainvalue != "<br />") {
                        SpecialStainInvID = objSpecialStainval[i].name.split("~")[0];
                        SpecialStainDDlID = objSpecialStainval[i].name.split("$")[0] + '_ddlstatus';
                        SpecialStainName = "Special Stains";  //$("[id*=lblCategory]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");

                        SpecialStainGroupid = objSpecialStainval[i].name.split("~")[2];
                        SpecialStainGroupName = objSpecialStainval[i].name.split("~")[1];
                        var e = document.getElementById(SpecialStainDDlID);
                        SpecialStainStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            SpecialStainStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: SpecialStainInvID,
                            Name: SpecialStainName,
                            Value: SpecialStainvalue.trim(),
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: SpecialStainGroupName,
                            GroupID: SpecialStainGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Special Stain change change End//
            
            //Test Performed By change begins//
            var objTestperformedByval = $("[name*=txtTestperformedBy]");
            if (objTestperformedByval.length > 0) {
                var TestperformedByvalue;
                var TestperformedByInvID;
                var TestperformedByName;
                var TestperformedByDDlID;
                var TestperformedByStatus;
                var TestperformedByGroupid;
                var TestperformedByGroupName;
                for (var i = 0; i < objTestperformedByval.length; i++) {
                    TestperformedByvalue = objTestperformedByval[i].value;
                    if (TestperformedByvalue != "" && TestperformedByvalue != null && TestperformedByvalue != "<br />") {
                        TestperformedByInvID = objTestperformedByval[i].name.split("~")[0];
                        TestperformedByDDlID = objTestperformedByval[i].name.split("$")[0] + '_ddlstatus';
                        TestperformedByName = "Supervised by" // $("[id*=lblCategory]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        TestperformedByGroupid = objTestperformedByval[i].name.split("~")[2];
                        TestperformedByGroupName = objTestperformedByval[i].name.split("~")[1];
                        var e = document.getElementById(TestperformedByDDlID);
                        TestperformedByStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            TestperformedByStatus = "Pending";
                        }
                        LstInvValues.push({
                        InvestigationID: TestperformedByInvID,
                        Name: TestperformedByName,
                            Value: TestperformedByvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: TestperformedByGroupName,
                            GroupID: TestperformedByGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //Test Performed By change End//


//            //Test Performed By change begins//
//            var objTestperformedByval = $("[name*=txtTestperformedBy]");
//            if (objTestperformedByval.length > 0) {
//                var TestperformedByvalue;
//                var TestperformedByInvID;
//                var TestperformedByName;
//                var TestperformedByDDlID;
//                var TestperformedByStatus;
//                var TestperformedByGroupid;
//                var TestperformedByGroupName;
//                for (var i = 0; i < objTestperformedByval.length; i++) {
//                    TestperformedByvalue = objTestperformedByval[i].value;
//                    if (TestperformedByvalue != "" && TestperformedByvalue != null && TestperformedByvalue != "<br />") {
//                        TestperformedByInvID = objTestperformedByval[i].name.split("~")[0];
//                        TestperformedByDDlID = objTestperformedByval[i].name.split("$")[0] + '_ddlstatus';
//                        TestperformedByName = "Test Performed By" // $("[id*=lblCategory]").html();
//                        //SpecNoName = SpecNoName.replace("&amp;", "&");
//                        TestperformedByGroupid = objTestperformedByval[i].name.split("~")[2];
//                        TestperformedByGroupName = objTestperformedByval[i].name.split("~")[1];
//                        var e = document.getElementById(TestperformedByDDlID);
//                        TestperformedByStatus = e.options[e.selectedIndex].value.split("_")[0];
//                        if (OSts == "Pending") {
//                            TestperformedByStatus = "Pending";
//                        }
//                        LstInvValues.push({
//                            InvestigationID: TestperformedByInvID,
//                            Name: TestperformedByName,
//                            Value: TestperformedByvalue,
//                            PatientVisitID: visitid,
//                            CreatedBy: loginid,
//                            GroupName: TestperformedByGroupName,
//                            GroupID: TestperformedByGroupid,
//                            Orgid: orgid, //OrgID;
//                            Status: commonstatus,
//                            PackageID: 0,
//                            PackageName: null,
//                            SequenceNo: 0
//                        });

//                    }
//                }
//            }
//            //Test Performed By change End//

            //ColdIschemicTime change begins//
            var objtxtcitval = $("[name*=txtcit]");
            if (objtxtcitval.length > 0) {
                var txtcitvalue;
                var txtcitInvID;
                var txtcitName;
                var txtcitDDlID;
                var txtcitStatus;
                var txtcitGroupid;
                var txtcitGroupName;
                for (var i = 0; i < objtxtcitval.length; i++) {
                    txtcitvalue = objtxtcitval[i].value;
                    if (txtcitvalue != "" && txtcitvalue != null && txtcitvalue != "<br />") {
                        txtcitInvID = objtxtcitval[i].name.split("~")[0];
                        txtcitDDlID = objtxtcitval[i].name.split("$")[0] + '_ddlstatus';
                        txtcitName = $("[id*=lblColdIschemicTime]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        txtcitGroupid = objtxtcitval[i].name.split("~")[2];
                        txtcitGroupName = objtxtcitval[i].name.split("~")[1];
                        var e = document.getElementById(txtcitDDlID);
                        txtcitStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            txtcitStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: txtcitInvID,
                            Name: txtcitName,
                            Value: txtcitvalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: txtcitGroupName,
                            GroupID: txtcitGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //ColdIschemicTime change End//

            //Test type by change begins//
            var objtesttypeval = $("[name*=ddltesttype]");
            if (objtesttypeval.length > 0) {
                var testtypevalue;
                var testtypeInvID;
                var testtypeName;
                var testtypeDDlID;
                var testtypeStatus;
                var testtypeGroupid;
                var testtypeGroupName;
                for (var i = 0; i < objtesttypeval.length; i++) {
                    testtypevalue = objtesttypeval[i].value;
                    if (testtypevalue != "" && testtypevalue != null && testtypevalue != "<br />" && testtypevalue != "Select") {
                        testtypeInvID = objtesttypeval[i].name.split("~")[0];
                        testtypeDDlID = objtesttypeval[i].name.split("$")[0] + '_ddlstatus';
                        testtypeName = $("[id*=labTesttypeby]").html();
                        //SpecNoName = SpecNoName.replace("&amp;", "&");
                        testtypeGroupid = objtesttypeval[i].name.split("~")[2];
                        testtypeGroupName = objtesttypeval[i].name.split("~")[1];
                        var e = document.getElementById(testtypeDDlID);
                        testtypeStatus = e.options[e.selectedIndex].value.split("_")[0];
                        if (OSts == "Pending") {
                            testtypeStatus = "Pending";
                        }
                        LstInvValues.push({
                            InvestigationID: testtypeInvID,
                            Name: testtypeName,
                            Value: testtypevalue,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: testtypeGroupName,
                            GroupID: testtypeGroupid,
                            Orgid: orgid, //OrgID;
                            Status: commonstatus,
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 0
                        });

                    }
                }
            }
            //testtype change End//

            var lstinvvalue = [];
            lstinvvalue.push(LstInvValues);

            //PatientInvestigation list  change Begins//
            var patientinv = $("[name*=txtOrgan]");
            if (patientinv.length > 0) {
                var ptInvID;
                var ptDDlID;
                var ptStatus;
                var ptGroupid;
                var ptGroupName;
                for (var i = 0; i < patientinv.length; i++) {
                    ptInvID = patientinv[i].name.split("~")[0];
                    ptDDlID = patientinv[i].name.split("$")[0] + '_ddlstatus';

                    ptGroupid = patientinv[i].name.split("~")[2];
                    ptGroupName = patientinv[i].name.split("~")[1];
                    var e = document.getElementById(ptDDlID);
                    ptStatus = e.options[e.selectedIndex].value.split("_")[0];
                    if (OSts == "Pending") {
                        ptStatus = "Pending";
                    }
                    lstpatientinv.push({
                        InvestigationID: ptInvID,
                        PatientVisitID: visitid,
                        GroupName: ptGroupName,
                        GroupID: ptGroupid,
                        Orgid: orgid, //OrgID;
                        Status: commonstatus,
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
                if (($("#hdnRoleName").val()) == "Lab Technician") {
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
                else {
                    $.ajax({
                        type: "POST",
                        url: "InvestigationApprovel.aspx/AutoSaveHisto",
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
    }


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
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vProcessing = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_01') == null ? "Please Select Processing Methods" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_01');
        var vStaining = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_02') == null ? "Please Select Staining" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_02');
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
            ValidationWindow(vProcessing, AlertType);
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
//        debugger;
        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ClinicalNotes;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        if (document.getElementById(splitString[0] + '_txtClinicalNotes').value == "") {
            alert('Please Select Clinical Notes');
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
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vInvalid = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_03') == null ? "Invalid File" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_03');
        // alert(id);
        var Upload_Image = document.getElementById(id);
        var myfile = Upload_Image.value;
        //alert(Upload_Image.value);
        if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0 || myfile.indexOf("JPG") > 0) {

        }
        else {
            // alert('Invalid File');
            ValidationWindow(vInvalid, AlertType);
        }
    }
    function SetBulkDataSearch_ClinicalNotes(KeyName, autoid) {
        autoClientid = autoid.split('_')[0] + '_' + 'AutoClinicalNotes';
        hdnContextClientid = autoid.split('_')[0] + '_' + 'hdnContext';
        searchvalue = $('[id$="'+hdnContextClientid+'"]').val() + "~" + KeyName;
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
//        debugger;
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
        if (document.getElementById(ctrlID + '_hdnImgSourceDetails').value != "") {
            row$ = $('<tr/>');
            $.each(ImgSourceDetails, function(m, obj) {
                if (ImgSourceDetails[m].ImageID != "") {
                    var url = "ProbeImagehandler.ashx?InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID;
                    ctrlVal = '<img src="' + url + '" alt="Image" id="ctlimg' + i + '" width="200" height="100">';
                    ctrlVal += '<br/><input id="hdnImg' + i + '" type="hidden" value="' + ImgSourceDetails[m].ImageID + '"/><input id="ctl' + i + '"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="HistroOnRowDelete(this);" />';
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
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDelete = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_04') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_04');
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
                    ValidationWindow(vDelete, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    } 
    function SetResultTemplate(objId, content) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vTemplate = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_05') == null ? "Select Result Template" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_05');
        try {
            var Orgid = $('input[id$=hdnOrgid]').val();
            var CtlID = $('input[id$=hidVal]').val();
            var userControlID = objId.split("_")
            var Result = $('select[id$="' + userControlID[0] + '_ddlInvResultTemplate"] option:selected').text();
            var Resultvalue = $('select[id$="' + userControlID[0] +'_ddlInvResultTemplate"] option:selected').val();
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
                            var txtSpecialStain = FCKeditorAPI.GetInstance(userControlID[0] + '_txtSpecialStain');

                            var txtResult = FCKeditorAPI.GetInstance(userControlID[0] + '_txtResult');
                            //VEL | 08-07-2019 | Add new IF
                            var txtIF = FCKeditorAPI.GetInstance(userControlID[0] + '_txtIF');
                            //VEL | 08-07-2019 | Add new IF
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

                                if (txtSpecialStain) {
                                    if (txtSpecialStain.GetHTML() == "") {
                                        txtSpecialStain.SetHTML($(ResultXmlData).find("Special Stains")[0].text);
                                    }
                                    else {
                                        txtSpecialStain.SetHTML(txtMicroscopy.GetHTML() + " " + $(ResultXmlData).find("Special Stains")[0].text);
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
                                //VEL | 08-07-2019 | Add new IF
                                if (txtIF) {
                                    if (txtIF.GetHTML() == "") {
                                        txtIF.SetHTML($(ResultXmlData).find("IF")[0].text);
                                    }
                                    else {
                                        txtIF.SetHTML(txtIF.GetHTML() + " " + $(ResultXmlData).find("IF")[0].text);
                                    }
                                }
                                //VEL | 08-07-2019 | Add new IF
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
                                //VEL | 08-07-2019 | Add new IF
                                if (txtIF) {
                                    txtIF.SetHTML($(ResultXmlData).find("IF")[0].text);
                                }
                                //VEL | 08-07-2019 | Add new IF
                                if (txtDiagnosis) {

                                    txtDiagnosis.SetHTML($(ResultXmlData).find("Diagnosis")[0].text);
                                }

                                if (txtDiagnosis) {

                                    txtDiagnosis.SetHTML($(ResultXmlData).find("Special Stains")[0].text);
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
            <table class="w-80p">
                <tr>
                    <td class="bold font12 h-20" style="color: #000;" colspan="3">
                        <input type="hidden" id="hdnProcess" value="" runat="server" />
                        <input type="hidden" id="hdnStain" value="" runat="server" />
                        <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                            meta:resourcekey="lblNameResource1"></asp:Label>
                        &nbsp;
                        <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                        <%--<asp:LinkButton id="lnkEdit" runat="server"  OnClientClick="lnkEdit_OnClientClick(this.id)" style="color: red; width:50px; font-size:larger"
                            visible="false"></asp:LinkButton>--%>
                        <a id="lnkEdit" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                            visible="false"><u>
                                <%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
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
                                    <td id="tdbarcodetxt" runat="server" class="font14 h-20" style="font-weight: normal;
                                        color: #000; display: none">
                                        <asp:Label ID="lblbarcode" Text="Slide No" runat="server" 
                                            meta:resourcekey="lblbarcodeResource1"></asp:Label>
                                    </td>
                                    <td style="display: none" id="tdbarcode" runat="server">
                                        <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlBarcode" 
                                            runat="server" meta:resourcekey="ddlBarcodeResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblSpecimenNo" runat="server" Text="Case No" 
                                            meta:resourcekey="lblSpecimenNoResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" CssClass="small" ID="txtSpecimenNo"
                                            TextMode="MultiLine" runat="server"  
                                            meta:resourcekey="txtSpecimenNoResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblOrgan" runat="server" Text="Specimen" meta:resourcekey="lblOrganResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtOrgan" TextMode="MultiLine" Width="500px"  Height="50px"
                                            runat="server" meta:resourcekey="txtOrganResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 w-30p" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" 
                                            meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                                    </td>
                                    <td colspan="4" class="w-70p">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left w-50p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" CssClass="small" ID="txtClinicalNotes"
                                                        onfocus="javascript:SetBulkDataSearch_ClinicalNotes('ClinicalNotes',this.id);"
                                                        runat="server" TextMode="MultiLine" Width="500px" Height="125px" onblur="javascript:ClickAdd(this.id);" 
                                                        meta:resourcekey="txtClinicalNotesResource1"></asp:TextBox>
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
                                                        meta:resourcekey="btnCNAddResource1" />
														
                                                </td>
                                                <td class="v-top font14 h-20 w-50p" style="font-weight: normal; color: #000;">
                                                    <table id="tdClinicalNotes" class="dataheaderInvCtrl w-100p" style="display: none;"
                                                        runat="server">
                                                        <tr id="Tr2" class="colorforcontent" runat="server">
                                                            <td id="Td3" class="bold font14 h-8 w-5p" style="color: White;" runat="server">
                                                                <img id="imgDeletebtn" style="cursor: pointer;" src="../Images/DoustBin.png" runat="server"
                                                                    title="Delete ClinicalNotes" onclick="javascript:ImgClinicalNotesDelete(this.id);" />
                                                            </td>
                                                            <td id="Td1" class="bold font14 h-8 w-5p" style="color: White;" runat="server">
                                                                <img id="imgEditbtn" style="cursor: pointer;" src="~/Images/Edit.png" runat="server"
                                                                    title="Edit ClinicalNotes" onclick="javascript:ImgClinicalNotesEdit(this.id);" />
                                                            </td>
                                                            <td class="bold font14 h-8 w-90p" id="tdNoteCell" style="color: White;" runat="server">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblProcessingMethods" runat="server" Text="Processing Methods" meta:resourcekey="lblProcessingMethodsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlProcessingMethods"
                                            runat="server" meta:resourcekey="ddlProcessingMethodsResource1">
                                            <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="Routine" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="Frozen Section" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="Microwave" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblStaining" runat="server" Text="Staining" meta:resourcekey="lblStainingResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlStaining" CssClass="ddlsmall" runat="server"
                                            meta:resourcekey="ddlStainingResource1">
                                           <%-- <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource5"></asp:ListItem>
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
                                        <table id="tblResult" class="dataheaderInvCtrl w-100p" style="display: none;" runat="server">
                                            <tr class="colorforcontent" runat="server">
                                                <td class=" bold font14 h-8p w-5p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font14 h-8p w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_ProcessingMethods" Text="Processing Methods" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font14 h-8p w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Staining" Text="Staining" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValues"
                                            Text="Please select the below Result Names one by one to keep adding Result Values:"
                                            runat="server" CssClass="font14" meta:resourcekey="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValuesResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                
                                <tr>  <%--style="display : none"--%>
                                    <td id="Td7" class="font14 h-8p w-20p" runat="server">
                                        <asp:Label ID="Rs_SelectResult" Text="Select Result Template" runat="server" 
                                            meta:resourcekey="Rs_SelectResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlInvResultTemplate" runat="server" 
                                                        CssClass="ddlsmall" meta:resourcekey="ddlInvResultTemplateResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnLoadResultTemplate" runat="server" Text="Load" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnLoadResultTemplate_Click" meta:resourcekey="btnLoadResultTemplateResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddResultTemplate" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnAddResultTemplate_Click" meta:resourcekey="btnAddResultTemplateResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGrossResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtGross" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtGrossResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtGross" FontSizes="10px" FontNames="Arial" runat="server"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtGrossResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                                    </td>
                                    <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtMicroscopy" FontSizes="10px" FontNames="Arial"
                                            runat="server" Width="600px" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtMicroscopyResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                 <tr>
                                     <td id="td6" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="lblSpecialStain" runat="server" Text="Special Stains"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                        </td>
                                      <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtSpecialStain" FontSizes="10px" FontNames="Arial"
                                            runat="server" Width="600px" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtMicroscopyResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                </tr>
                                
                                  <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblResult" runat="server" Text="IHC" 
                                            meta:resourcekey="lblResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtResult" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblIF" runat="server" Text="IF" 
                                            meta:resourcekey="lblResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtIF" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                   <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblDiagnosis" runat="server" Text="Diagnosis" 
                                            meta:resourcekey="lblDiagnosisResource1"></asp:Label>
                                    </td>
                                    <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtDiagnosis" runat="server" Width="600px" FontSizes="10px"
                                            FontNames="Arial" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtDiagnosisResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblImpression" runat="server" Text="Impression" 
                                            meta:resourcekey="lblDiagnosisResource1"></asp:Label>
                                    </td>
                                    <td colspan="3"> 
                                        <FCKeditorV2:CKEditorControl ID="txtImpression" runat="server" Width="600px" FontSizes="10px"
                                            FontNames="Arial" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtDiagnosisResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblComments" runat="server" Text="Comments" 
                                                        ToolTip="Comments/Remarks" 
                                                        meta:resourcekey="lblImpressionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text=""
                                                        Font-Bold="True" ForeColor="DarkGreen" meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="3">
                                          <asp:TextBox ID="txtComments" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px"  Height="50px" meta:resourcekey="txtImpressionResource1"></asp:TextBox> 
                                            <%--<FCKeditorV2:CKEditorControl ID="txtComments" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>--%>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRemarks" runat="server" Text="Remarks" 
                                                        ToolTip="Remarks" 
                                                        meta:resourcekey="lblImpressionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text=""
                                                        Font-Bold="True" ForeColor="DarkGreen" meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="3">
                                          <asp:TextBox ID="txtRemarks" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" Height="50px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>
                                           <%-- <FCKeditorV2:CKEditorControl ID="txtRemarks" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>--%>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr> 
                                
                                 <tr><td>&nbsp;</td></tr>
                                
                                <tr>
                                     <td id="tdInvName" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="lblSuggest" runat="server" Text="Suggest"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                        <%--<asp:Label ID="lblTestStatus" runat="server" Width="15px" BackColor="Yellow" 
                                            meta:resourcekey="lblTestStatusResource1"></asp:Label>
                                        &nbsp;
                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                                            ForeColor="Red" meta:resourcekey="lnkEditResource1" ></asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value="False" />
                                        <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                                            visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>--%>
                                    </td>
                                    <td class="w-14p v-middle csstxtName">
                                        <asp:TextBox ForeColor="Black" ID="txtSuggest" TextMode="MultiLine"  Width="500px"
                                           runat="server" CssClass="small" meta:resourcekey="txtValueResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                     <td id="td2" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="lblICDCode" runat="server" Text="ICD Code"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                         </td>
                                    <td class="w-14p v-middle csstxtName">
                                        <asp:TextBox ForeColor="Black"  ID="txtICDCode" TextMode="MultiLine"
                                           runat="server" CssClass="small" meta:resourcekey="txtValueResource1"></asp:TextBox>
                                      
             <ajc:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server" TargetControlID="txtICDCode"
                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="1"
                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODEMaster"
                ServicePath="~/WebService.asmx">
            </ajc:AutoCompleteExtender> 
            <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender19" MinimumPrefixLength="1" runat="server"
                                                                TargetControlID="txtICDCode" ServiceMethod="getICDCODEMaster"
                                                                ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                Enabled="True" OnClientItemSelected="SelectedICDCode" > 
                                                          </ajc:AutoCompleteExtender>--%>
                                                                
                                    </td> 
                                </tr>
                                
                                <tr>
                                     <td id="td4" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="lblCategory" runat="server" Text="Category"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                        </td>
                                    <%--<td class="w-14p v-middle csstxtName">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtCategory" TextMode="MultiLine"
                                           runat="server" CssClass="small" meta:resourcekey="txtValueResource1"></asp:TextBox>
                                    </td>--%>
                                    <td>
                                      <asp:DropDownList CssClass="ddlsmall"  ID="ddlCategory" ForeColor="Black" 
                                                        runat="server" >
                                       <asp:ListItem Text="Select" Value="Select" ></asp:ListItem>
                                      <asp:ListItem Text="Malignant" Value="Malignant" ></asp:ListItem>
                                      <asp:ListItem Text="Benign" Value="Benign"></asp:ListItem> 
                                      <asp:ListItem Text="Inflammation" Value="Inflammation"></asp:ListItem> 
                                      <asp:ListItem Text="Within Normal Limit" Value="Within Normal Limit"></asp:ListItem>
                                      </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                <tr>
                                     <td id="td5" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="lblSummary" runat="server" Text="Summary of Sections"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                        </td>
                                    <td class="w-14p v-middle csstxtName">
                                        <asp:TextBox ForeColor="Black" ID="txtSummary" TextMode="MultiLine"
                                           runat="server" CssClass="small" Width="500px" Height="75px" meta:resourcekey="txtValueResource1"></asp:TextBox>
                                    </td>
                                </tr>
                               <tr>
                               <td >
                                                        <asp:Label ID="lblColdIschemicTime" runat="server" CssClass="w-100p" 
                                                            meta:resourcekey="lblTimeoffixationResource1" Text="Cold Ischemic Time"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtcit" runat="server" CssClass="small" 
                                                            ForeColor="Black"></asp:TextBox>
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                    <td >
                                                        <asp:Label ID="lblTimeoffixation" runat="server" CssClass="w-100p" 
                                                            meta:resourcekey="lblTimeoffixationResource1" Text="Time of Fixation"></asp:Label>
                                                    </td>
                                                    <td class="w-20p" colspan="2">
                                                        <asp:TextBox ID="txttimeoffixation" runat="server" CssClass="small" 
                                                             ForeColor="Black" 
                                                            meta:resourcekey="txttimeoffixationResource1" 
                                                            onfocus="javascript:SetBulkDataSearch_timeoffixation('Time Of Fixation','<%=Autotimeoffixation.ClientID%>');"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="Autotimeoffixation" runat="server" 
                                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" 
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" 
                                                            EnableCaching="False" Enabled="True" MinimumPrefixLength="2" 
                                                            OnClientItemSelected="SelectedRemarks" ServiceMethod="GetInvBulkDataAuto" 
                                                            ServicePath="~/WebService.asmx" TargetControlID="txttimeoffixation">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    </tr>
                                <%--<tr>
                                    <td colspan="4">
                                        <table class="dataheaderInvCtrl w-80p">
                                            <tr>
                                                <td class="colorforcontent w-40p font11" style="color: White;">
                                                    <asp:Label ID="lblTestperformedby" runat="server" Text="Test Performed By" 
                                                        meta:resourcekey="lblTestperformedbyResource1"></asp:Label>
                                                    <asp:Label ID="lblToolTestper" runat="server" Text="(for IHC & Special Stains)" 
                                                        ForeColor="DarkGreen" meta:resourcekey="lblToolTestperResource1"></asp:Label>
                                                </td>
                                                <td class="w-60p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtTestperformedBy" onfocus="javascript:SetBulkDataSearch_TestperformedBy('TestPerformedBy','<%=AutoTestperformedBy.ClientID%>');"
                                                        runat="server" CssClass="small" 
                                                        meta:resourcekey="txtTestperformedByResource1"></asp:TextBox>
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
                                </tr>--%>
                                
                                
                                <caption>
                                    &nbsp;
                                    <tr>
                                        <td colspan="5">
                                            <table class="dataheaderInvCtrl">
                                                <tr >
                                                    <td class="colorforcontent bold font11" style="color: White;">
                                                        <asp:Label ID="lblGrossedby" runat="server" CssClass="w-100" 
                                                            meta:resourcekey="lblGrossedbyResource1" Text="Grossed By"></asp:Label>
                                                    </td>
                                                    <td class="w-20p" >
                                                        <asp:TextBox ID="txtGrossedBy" runat="server" CssClass="small" 
                                                            ForeColor="Black" meta:resourcekey="txtGrossedByResource1" 
                                                            onfocus="javascript:SetBulkDataSearch_GrossedBy('Grossed By','<%=AutoGrossedBy.ClientID%>');"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoGrossedBy" runat="server" 
                                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" 
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" 
                                                            EnableCaching="False" Enabled="True" MinimumPrefixLength="2" 
                                                            OnClientItemSelected="SelectedRemarks" ServiceMethod="GetInvBulkDataAuto" 
                                                            ServicePath="~/WebService.asmx" TargetControlID="txtGrossedBy">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td class="colorforcontent bold font11" style="color: White;">
                                                        <asp:Label ID="lblAssistedby" runat="server" CssClass="w-100" 
                                                            meta:resourcekey="lblAssistedbyResource1" Text="Assisted By"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:TextBox ID="txtAssistedBy" runat="server" CssClass="small" 
                                                             ForeColor="Black" meta:resourcekey="txtAssistedByResource1" 
                                                            onfocus="javascript:SetBulkDataSearch_AssistedBy('Assisted By','<%=AutoAssistedBy.ClientID%>');"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoAssistedBy" runat="server" 
                                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" 
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" 
                                                            EnableCaching="False" Enabled="True" MinimumPrefixLength="2" 
                                                            OnClientItemSelected="SelectedRemarks" ServiceMethod="GetInvBulkDataAuto" 
                                                            ServicePath="~/WebService.asmx" TargetControlID="txtAssistedBy">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td class="colorforcontent bold font11" nowrap="nowrap" style="color: White;">
                                                        <asp:Label ID="lblTestperformedby" runat="server" 
                                                            meta:resourcekey="lblTestperformedbyResource1" Text="Supervised by"></asp:Label>
                                                        <%--<asp:Label ID="lblToolTestper" runat="server" Text="(for IHC & Special Stains)" 
                                                        ForeColor="DarkGreen" meta:resourcekey="lblToolTestperResource1"></asp:Label>--%>
                                                    </td>
                                                    <td class="w-60p">
                                                        <asp:TextBox ID="txtTestperformedBy" runat="server" CssClass="small" 
                                                             ForeColor="Black" 
                                                            meta:resourcekey="txtTestperformedByResource1" 
                                                            onfocus="javascript:SetBulkDataSearch_TestperformedBy('TestPerformedBy','<%=AutoTestperformedBy.ClientID%>');"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoTestperformedBy" runat="server" 
                                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" 
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" 
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" 
                                                            EnableCaching="False" Enabled="True" MinimumPrefixLength="2" 
                                                            OnClientItemSelected="SelectedRemarks" ServiceMethod="GetInvBulkDataAuto" 
                                                            ServicePath="~/WebService.asmx" TargetControlID="txtTestperformedBy">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    
                                                </tr>
                                                
                                            </table>
                                        </td>
                                    </tr>
                                    
                                                       
<%--                                                        <tr style="display:none">
                                                            <td class="w-100p" nowrap="nowrap">
                                                                <asp:Label ID="lblTimeOffixToolTip" runat="server" CssClass="w-100p" 
                                                                    ForeColor="DarkGreen" meta:resourcekey="lblTimeOffixToolTipResource1" 
                                                                    Text="(for ER, PR, Cer B2)"></asp:Label>
                                                            </td>
                                                        </tr>--%>
                                     <tr>
                                                        <td id="td8" runat="server" style="font-weight: normal;
                                        color: #000; display: table-cell;"  >
                                        <asp:Label ID="labTesttypeby" runat="server" Text="Test Typed By"
                                            meta:resourcekey="lblNameResource1"></asp:Label>
                                        </td>
                                                        <td>
                                      <asp:DropDownList CssClass="ddlsmall"  ID="ddltesttype" ForeColor="Black" 
                                                        runat="server" >
                                       <asp:ListItem Text="Select" Value="Select" ></asp:ListItem>
                                       <asp:ListItem Text="Sumita Tandel" Value="Sumita Tandel" ></asp:ListItem>
                                       <asp:ListItem Text="Jyotsana Dabre" Value="Jyotsana Dabre" ></asp:ListItem>
                                      </asp:DropDownList>
                                    </td>
                                                        </tr>
                                </caption>
                                                </table>
                                            </td>
                                        </caption>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlstatus" 
                                        runat="server" meta:resourcekey="ddlstatusResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-5p">
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                    onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                    meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                                                  <%--  <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <span class="richcombobox" class="w-100">
                                                    <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                                      <%--  <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_Comments" Text="Technical Remarks" CssClass="w-70" 
                                        runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                        CssClass="textbox_pattern small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                <td class="font14 h-10 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="lblMedRemarks" Text="Medical Remarks" CssClass="w-70" 
                                        runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                </td>
                                <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                        TextMode="MultiLine" CssClass="textbox_pattern small" 
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
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload2" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload2Resource1" />
                        </td>
                    </tr>
                    <tr style="padding-top:2px">
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload3" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload3Resource1" />
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" accept="jpg" ID="flUpload4" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload4Resource1" />
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
<input type="hidden" id="hResultvalues" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnClinicalNotes" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnAllClinicalNotes" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnControlID" value="" class="w-50p" runat="server" />
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<input id="hdninvid" runat="server" type="hidden" value="" />
<input id="hdnOrgid" runat="server" type="hidden" value="" />
<input id="hdnImgSourceDetails" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
    .dataheaderInvCtrl
    {
        width: 98%;
    }
    </style>
