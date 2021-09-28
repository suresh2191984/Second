<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientComparisonReport.aspx.cs"
    Inherits="Investigation_PatientComparisonReport" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Comparison Report</title>
    <%--<script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>--%>

    <%--<script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <%--<script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <%--
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">

        function CheckReCollect() {
            SelectValues();
        }
        function hideHeader() {
            document.getElementById('header').style.display = 'none';
            document.getElementById('Attuneheader_menu').style.display = 'none';
            document.getElementById('imagetd').style.display = 'none';
            // $("#navigation").addClass("classNav");
            document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';
            //document.getElementById('txtVisitNumber').disabled = true;
            // document.getElementById('navigation').style.display = 'none';
            //document.getElementById('btnGo').disabled = true;
            $('#Attuneheader_TopHeader1_hideShowHeader').hide();
            $('#Attuneheader_LeftMenu1_leftDiv').hide();
        
        }
        function SelectValues() {

            // var chkRerun = 'N';
            var PageID = document.getElementById('hdnPageID').value;
            var PatientID = document.getElementById('hdnPatientID').value;
            var checkedCheckboxes = 0;

            var dataTables = $('#tbl').dataTable();
            var dataTable = [];
            $(dataTables.fnGetNodes()).each(function(i, n) {
                // $("#tbl tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var chckSelect = $row.find("input[id$='chkjdatatable']").is(":checked");
                if (chckSelect) {
                    checkedCheckboxes = checkedCheckboxes + 1;
                    var InvestigationID = $row.find("input:hidden[id$='jInvestigationID']").val();
                    dataTable.push({
                        InvestigationID: InvestigationID
                    });
                }

            });
            if (checkedCheckboxes == 0) {
                alert('Choose atleast one test');
                return false;
            }
            if (checkedCheckboxes > 8) {
                alert('Selected test cannot be more than 8”');
                return false;
            }

            //            if ($("#chkRerun").prop('checked') == true) {
            //                chkRerun = 'Y';
            //            }
            var chkRerun = ($("#chkRerun").prop('checked') == true) ? 'Y' : 'N';

            var strInvID = JSON.stringify(dataTable);
            $('#li2').addClass('active');
            $('#li1').removeClass('active');
            $('#example').hide();
            //$('#btnVisitDetails').hide();  
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetPatientComparisonReport",
                contentType: "application/json; charset=utf-8",
                data: "{ pPatientIds: '" + PatientID + "',strInvID: '" + strInvID + "',IsRerun: '" + chkRerun + "','pPageID':" + PageID + "}",
                dataType: "json",
                success: PatientComparisonReport,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example1').hide();
                    //pop.hide();
                    return false;
                }

            });
            return false;
            //$("input:hidden[id$=hdnTable]").val(list);
            // return false;
        }
        function PatientComparisonReport(result) {
            //debugger;            
            var oTable;
            var a = 0;
            if (result != "[]") {
                //                var rowCount = $('#tbl2 tr').length;
                //                if (rowCount > 0) {
                //                    $('#tbl2').dataTable().destroy();
                //                }

                oTable = $('#tbl2').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    //"bProcessing": true,
                    "aaData": result.d,
                    // "serverSide": true,
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                                    { "sTitle": "Select", "mDataProp": "InvestigationValueID",
                                        "fnRender": function(oObj) {
                                            if (oObj != null) {
                                                var ResultVal = oObj.aData.Value;
                                                if ($.isNumeric(parseFloat(ResultVal)) == true)
                                                    return '<input type="checkbox" name="checkjdatatable" id="chkboxjdatatable" />';
                                                else
                                                    return '<input type="checkbox" name="checkjdatatable" id="chkboxjdatatable" disabled="true" title="Value is Non-Numeric,Cannot represent in Graph"/>';
                                            }
                                        }

                                    },

                                    { "sTitle": "VisitID", "mDataProp": "VisitNumber",
                                        "fnRender": function(oObj) {
                                            if (oObj.aData.VisitNumber != null) {
                                                return '	<label id="jVisitNumber">' + oObj.aData.VisitNumber + '</label>';
                                            } else {
                                                return '	<label id="jVisitNumber">' + ' ' + '</label>';
                                            }
                                        }
                                    },
                                     { "sTitle": "Visit Date/Time", "mDataProp": "VisitDate",
                                         "fnRender": function(oObj) {
                                             var oldVisitDate = new Date(parseInt(oObj.aData.VisitDate.slice(6, -2)));
                                             var VisitDate = ((1 + oldVisitDate.getMonth()) + '/' + oldVisitDate.getDate() + '/' + oldVisitDate.getFullYear() + ' ' + oldVisitDate.getHours() + ":" + oldVisitDate.getMinutes().toString().slice(-2));
                                             if (VisitDate !== '1/1/1 5:30') {
                                                 return '	<label id="jVisitDate">' + VisitDate + '</label>';
                                             } else {
                                                 return '	<label id="jVisitDate">' + ' ' + '</label>';
                                             }
                                         }
                                     },

                                      { "sTitle": "Test Code", "mDataProp": "InvestigationName",
                                          "fnRender": function(oObj) {
                                              if (oObj.aData.InvestigationName != null) {
                                                  return '	<label id="jInvestigationName">' + oObj.aData.InvestigationName + '</label>';
                                              } else {
                                                  return '	<label id="jInvestigationName">' + ' ' + '</label>';
                                              }
                                          }
                                      },
                                      { "sTitle": "Test Value", "mDataProp": "Value",
                                          "fnRender": function(oObj) {
                                              if (oObj.aData.Value != null) {
                                                  return '	<label id="jValue">' + oObj.aData.Value + '</label><input type="hidden"  id="jpInvestigationID"  value="' + oObj.aData.InvestigationID + '" />';
                                              } else {
                                                  return '	<label id="jValue">' + ' ' + '</label><input type="hidden"  id="jpInvestigationID"  value="' + oObj.aData.InvestigationID + '" />';
                                              }
                                          }
                                      },
                                       { "sTitle": "Analyzer", "mDataProp": "InstrumentName",
                                           "fnRender": function(oObj) {
                                               if (oObj.aData.InstrumentName != null) {
                                                   return '	<label id="jLocation">' + oObj.aData.InstrumentName + '</label>';
                                               } else {
                                                   return '	<label id="jLocation">' + ' ' + '</label>';
                                               }
                                           }
                                       },

                                        { "sTitle": "Processed Location", "mDataProp": "Location",
                                            "fnRender": function(oObj) {
                                                if (oObj.aData.Location != null) {
                                                    return '	<label id="jLocation">' + oObj.aData.Location + '</label>';
                                                } else {
                                                    return '	<label id="jLocation">' + ' ' + '</label>';
                                                }
                                            }
                                        },


                    //                       { "sTitle": "InvestigationID ", "mDataProp": "InvestigationID",
                    //                           "fnRender": function(oObj) {
                    //                           if (oObj.aData.InvestigationID != null) {
                    //                                   return '	<label id="jInvestigationID">' + oObj.aData.InvestigationID + '</label>';
                    //                               } else {
                    //                                   return '	<label id="jInvestigationID">' + ' ' + '</label>';
                    //                               }
                    //                           }
                    //                       },
                                      {"sTitle": "Approved At", "mDataProp": "ApprovedAt",
                                      "fnRender": function(oObj) {
                                          var oldApprovedAt = new Date(parseInt(oObj.aData.ApprovedAt.slice(6, -2)));
                                          var ApprovedAt = (1 + oldApprovedAt.getMonth() + '/' + (oldApprovedAt.getDate()) + '/' + oldApprovedAt.getFullYear() + ' ' + oldApprovedAt.getHours() + ":" + oldApprovedAt.getMinutes().toString().slice(-2));
                                          if (ApprovedAt !== '1/1/1 5:30') {
                                              return '	<label id="jApprovedAt">' + ApprovedAt + '</label>';
                                          } else {
                                              return '	<label id="jApprovedAt">' + ' ' + '</label>';
                                          }
                                      }
                                  },
                                   { "sTitle": "Result Approved By", "mDataProp": "ApprovedByName",
                                       "fnRender": function(oObj) {
                                           if (oObj.aData.ApprovedByName != null) {
                                               return '	<label id="jApprovedBy">' + oObj.aData.ApprovedByName + '</label>';
                                           } else {
                                               return '	<label id="jApprovedBy">' + ' ' + '</label>';
                                           }
                                       }
                                   },
								   { "sTitle": "Completed At", "mDataProp": "CreatedAt",
								       "fnRender": function(oObj) {
								           var oldCreatedAt = new Date(parseInt(oObj.aData.CreatedAt.slice(6, -2)));
								           var CreatedAt = ((1 + oldCreatedAt.getMonth()) + '/' + oldCreatedAt.getDate() + '/' + oldCreatedAt.getFullYear() + ' ' + oldCreatedAt.getHours() + ":" + oldCreatedAt.getMinutes().toString().slice(-2));
								           if (CreatedAt !== '1/1/1 5:30') {
								               return '	<label id="jCreatedAt">' + CreatedAt + '</label>';
								           } else {
								               return '	<label id="jCreatedAt">' + ' ' + '</label>';
								           }
								       }
								   },

                                  { "sTitle": "Result Completed By", "mDataProp": "LoginName",
                                      "fnRender": function(oObj) {
                                          if (oObj.aData.LoginName != null) {
                                              return '	<label id="jCreatedByName">' + oObj.aData.LoginName + '</label>';
                                          } else {
                                              return '	<label id="jCreatedByName">' + ' ' + '</label>';
                                          }
                                      }
                                  }

],
                    "sPaginationType": "full_numbers",
                    "sZeroRecords": "No records found",
                    "bSort": true,
                    "bJQueryUI": true,
                    "iDisplayLength": 50,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                            "copy", "csv", "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                 "aButtons": ["csv", "xls", "pdf"]
                             }
                          ]
                    }
                });

                destroycharts();
                $('#example1').show();
                
                // pop.hide();
                return false;
            }
        }


        function Click_Search() {
            $('#TabsMenu').show();
            $('#li1').addClass('active');
            $('#li2').removeClass('active');
            $('#li3').removeClass('active');
            $('#tblPatientDetails').show();
            $('#example1').hide();
            $('#tbl3').hide();
            GetData_PatientTestReport();
            //$('#example').show();
            return false;
        }
        function GetData_PatientTestReport() {
            // debugger;
            try {
                // var pop = $find("mdlPopup1");
                //pop.show();
                var PageID = document.getElementById('hdnPageID').value;
                var ddlType = $('#ddlType option:selected').val();
                var VisitNumber = '';
                var temp;
                var PatientNumber = '';
                if (ddlType == 0) {
                    VisitNumber = document.getElementById('txtVisitNumber').value;
                }
                if (ddlType == 1) {
                    PatientNumber = document.getElementById('txtVisitNumber').value; //$('#txtVisitNumber').text();
                }

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPatientTestLevelResult",
                    contentType: "application/json; charset=utf-8",
                    data: "{ VisitNumber: '" + VisitNumber + "',PatientNumber: '" + PatientNumber + "','pPageID':" + PageID + "}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded1,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        //pop.hide();
                        return false;
                    }

                });
                return false;

            }
            catch (e) {
                return false;

                // pop.hide();
            }
        }

        function AjaxGetFieldDataSucceeded1(result) {
            // var pop = $find("mdlPopup1");
            var oTable;
            if (result.d[0].length > 0) {
                var list = result.d;
                var lstPatientDetails = [];
                var LstPatientInvestigation = [];
                lstPatientDetails = list[0];
                if (lstPatientDetails[0].Status == '') {
                LstPatientInvestigation = list[1];
                var a = 0;
                if (LstPatientInvestigation != "[]") {
                    // $('#tbl  thead').remove();
                    oTable = $('#tbl').dataTable({
                        "bDestroy": true,
                        "bAutoWidth": false,
                        //"bProcessing": true,
                        'bFilter': true,
                        // "serverSide": true,
                        "aaData": LstPatientInvestigation,
                        //"fnStandingRedraw": function() { pop.show(); },
                        "aoColumns": [
                                    { "sTitle": "S.No", "mDataProp": "SequenceNo",
                                        "fnRender": function(oObj) {
                                            return '<label id="jSno">' + oObj.aData.SequenceNo + '</label>';
                                        }
                                    },
                                    { "sTitle": "Test Name", "mDataProp": "Name",
                                        "fnRender": function(oObj) {
                                            if (oObj.aData.Name != null) {
                                                return '	<label id="jName">' + oObj.aData.Name + '</label>';
                                            } else {
                                                return '	<label id="jName">' + ' ' + '</label>';
                                            }
                                        }
                                    },
                                    { "sTitle": "Test Count", "mDataProp": "TestCount",
                                        "fnRender": function(oObj) {
                                            if (oObj.aData.TestCount != null) {
                                                return '	<label id="jTestCount" style="margin-left:70px;">' + oObj.aData.TestCount + '</label><input type="hidden"  id="jInvestigationID" value="' + oObj.aData.InvestigationID + '" />';
                                            } else {
                                                return '	<label id="jTestCount">' + ' ' + '</label><input type="hidden"  id="jInvestigationID" value="' + oObj.aData.InvestigationID + '" />';
                                            }
                                        }
                                    },
                        //                                     { "sTitle": "InvestigationID", "mDataProp": "InvestigationID", //"bVisible": false,
                        //                                         "fnRender": function(oObj) {
                        //                                             if (oObj.aData.InvestigationID != null) {
                        //                                                 return '	<label id="jInvestigationID">' + oObj.aData.InvestigationID + '</label>';
                        //                                             } else {
                        //                                                 return '	<label id="jInvestigationID">' + ' ' + '</label>';
                        //                                             }
                        //                                         }
                        //                                     },

                                    {"sTitle": "Select", "mData": "TestCount",
                                    "mRender": function(data, type, full) {
                                        return '<input type="checkbox" id="chkjdatatable" class="call-checkbox" />';
                                    }

}],


                        "sPaginationType": "full_numbers",
                        "sZeroRecords": "No records found",
                        "bSort": true,
                        "bJQueryUI": true,
                        "iDisplayLength": 20,
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        //                        "fnRowCallback": function(nRow, aData, iDisplayIndex) {
                        //                            $("td:first", nRow).html(iDisplayIndex + 1);
                        //                            return nRow;
                        //                        },  //serial number
                        "oTableTools": {
                            "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            "aButtons": [
                            "copy", "csv", "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                 "aButtons": ["csv", "xls", "pdf"]
                             }
                          ]
                        }
                    });
                    var PIDs = '';
                    for (var i = 0; i < lstPatientDetails.length; i++) {
                        PIDs += lstPatientDetails[i].PatientID + ',';
                    }
                    $('#hdnPatientID').val(PIDs);
                    $("span[id$=lblPatientID]").text(lstPatientDetails[0].PatientNumber);
                    //                var temp =
                    //                var date=(temp.getDate()) + '/' + (temp.getMonth() + 1) + '/' + temp.getFullYear() + ' 00:00:00';
                    $("span[id$=lblPatientName]").text(lstPatientDetails[0].Name);
                    $("span[id$=lblPatientAge]").text(lstPatientDetails[0].Age);
                    var oldDOB = new Date(parseInt(lstPatientDetails[0].DOB.slice(6, -2)));
                    var DOB = ((1 + oldDOB.getMonth()) + '/' + oldDOB.getDate() + '/' + oldDOB.getFullYear()); //+ ' ' + oldDOB.getHours() + ":" + oldDOB.getMinutes().toString().slice(-2));
                    if (oldDOB != null) {
                        $("span[id$=lblPatientDOB]").text(DOB);
                    }
                    $("span[id$=lblBloodGroup]").text(lstPatientDetails[0].BloodGroup);
                    //                var temp =
                    //                var date=(temp.getDate()) + '/' + (temp.getMonth() + 1) + '/' + temp.getFullYear() + ' 00:00:00';
                    $("span[id$=lblMobileNo]").text(lstPatientDetails[0].MobileNumber);
                    $("span[id$=lblEmail]").text(lstPatientDetails[0].EMail);
                    $("span[id$=lblPatAddress]").text(lstPatientDetails[0].Address);


                    $('#example').show();
                    // pop.hide();
                }
            }
            else {
                    $('#example').hide();
                    $('#TabsMenu').hide();
                    $('#tblPatientDetails').hide();
                    $('#example1').hide();
                    $('#tbl3').hide();
                    alert('Patient having only one visit');
                    return false;
                }
            }
            else {

                $('#example').hide();
                $('#TabsMenu').hide();
                $('#tblPatientDetails').hide();
                $('#example1').hide();
                $('#tbl3').hide();
                alert('No Result Found.... ');
            }
        }

    </script>

    <script type="text/javascript">

        function Validate() {

            if (document.getElementById('txtVisitNumber').value == '') {
                alert('Enter Visit Number');
                return false;
            }

        }
        function DisplayTab(tabName) {

            $('#TabsMenu li').removeClass('active');
            if (tabName == 'TD') {
                $('#li1').addClass('active');
                $('#TabsMenu').show();
                // $('#tblPatientDetails').show();
                // $('#example1').hide();
                document.getElementById('tblPatientDetails').style.display = 'block';
                document.getElementById('example1').style.display = 'none';
                //document.getElementById('example').style.display = 'block';
                $('#example').show();
               // document.getElementById('tbl3').style.display = 'none';
                $('#tbl3').hide();
                GetData_PatientTestReport();
                $('#chkRerun').prop('checked', false);
              //  destroycharts();
            }
            if (tabName == 'VTD') {
                document.getElementById('tblPatientDetails').style.display = 'block';
                document.getElementById('example').style.display = 'none';
                document.getElementById('example1').style.display = 'block';
                // document.getElementById('tbl3').style.display = 'none';
                $('#tbl3').hide();
        
             //   destroycharts();
                $('#li2').addClass('active');
            }
            if (tabName == 'TA') {
                document.getElementById('tblPatientDetails').style.display = 'block';
                document.getElementById('example').style.display = 'none';
                document.getElementById('example1').style.display = 'none';
               // document.getElementById('tbl3').style.display = 'block';
                $('#tbl3').show();
                $('#chkRerun').prop('checked', false);
                $('#li3').addClass('active');
            }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
 
    <asp:ScriptManager ID="scriptManager1" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
       
                    <div class="contentdata">
                       
                        <asp:Panel ID="pnlCntrl" Width="100%" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="width: 20%">
                                        <table style="border: thin;" width="40%" cellspacing="0" cellpadding="0" border="0">
                                            <tr valign="top">
                                                <td>
                                                    <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server">
                                                        <table width="50%" id="1" border="0" cellspacing="1" cellpadding="1">
                                                            <tr>
                                                                <td width="7%" runat="server" id="tdSearchType1">
                                                                    <asp:DropDownList ID="ddlType" runat="server">
                                                                        <asp:ListItem Text="Visit Number" Value="0" Selected="True"></asp:ListItem>
                                                                        <asp:ListItem Text="Patient Number" Value="1"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 15%" align="left">
                                                                    <asp:TextBox ID="txtVisitNumber" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Button ID="btnGo" runat="server" Text="Search" CssClass="btn" Width="60px" OnClientClick="return Click_Search();" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <%-- <tr>
                                                <td>
                                                    <asp:Button ID="Button1" runat="server" Text="Generate" OnClientClick="return showGraph();" />
                                                    <div id="DivID1" />
                                                </td>
                                            </tr>--%>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 70%">
                                        <table id="tblPatientDetails" style="display: none;" border="0" cellspacing="5" cellpadding="0">
                                            <tr>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatID" runat="server" Text="Patient ID :"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 14%;">
                                                    <asp:Label ID="lblPatientID" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatName" runat="server" Text="Patient Name :"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 14%;">
                                                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 11%;" align="left">
                                                    <asp:Label ID="TL_PatAge" runat="server" Text="Age :"></asp:Label>
                                                </td>
                                                <td style="width: 14%;">
                                                    <asp:Label ID="lblPatientAge" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatDOB" runat="server" Text="DOB :"></asp:Label>
                                                </td>
                                                <td style="width: 14%;">
                                                    <asp:Label ID="lblPatientDOB" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatBloodGroup" runat="server" Text="Blood Group:"></asp:Label>
                                                </td>
                                                <td style="width: 14%;">
                                                    <asp:Label ID="lblBloodGroup" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatMobNo" runat="server" Text="Mobile Number:"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 14%;">
                                                    <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatEmail" runat="server" Text="EmailID :"></asp:Label>
                                                </td>
                                                <td style="width: 14%;">
                                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; width: 12%;">
                                                    <asp:Label ID="TL_PatAddress" runat="server" Text="Address :"></asp:Label>
                                                </td>
                                                <td style="width: 14%;">
                                                    <asp:Label ID="lblPatAddress" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <div id='TabsMenu' align="left" style="display: none;">
                                            <ul>
                                                <li id="li1" runat="server" onclick="DisplayTab('TD')"><a href='#'><span>Test Details
                                                </span></a></li>
                                                <li id="li2" runat="server" onclick="DisplayTab('VTD')"><a href="#"><span>Visit Test
                                                    Details </span></a></li>
                                                <li id="li3" runat="server" onclick="DisplayTab('TA')"><a href="#"><span>Trend Analysis
                                                </span></a></li>
                                            </ul>
                                        </div>
                                        <table id="example" style="display: none" width="100%">
                                            <tr>
                                                <td>
                                                    <div>
                                                        <table id='tbl' runat="server">
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Button ID="btnVisitDetails" runat="server" Text="Expand Visit Details" OnClientClick="return SelectValues();" />
                                                    <asp:HiddenField ID="hdnTable" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="example1" style="display: none" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkRerun" runat="server" onclick="CheckReCollect();" />
                                                    <asp:Label ID="lblRerun" Text="Include Report Runs (Rerun/Recollect)" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div>
                                                        <table id='tbl2' runat="server">
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Button ID="btnGenerateTrend" runat="server" Text="Generate" OnClientClick="return showGraph();" />
                                                </td>
                                            </tr>
                                        </table>
                                        <%--  <div id="chartContainer1" style="height: 260px; width: 100%;"></div>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <div id="chartContainer2" style="height: 260px; width: 100%;"></div>--%>
                                        <center>
                                            <table id="tbl3" style="display: none" width="90%" border="1" cellpadding="5" cellspacing="5">
                                                <tr>
                                                    <td>
                                                        <div style="font-family: Sans-Serif; font-weight: bold; padding-left: 2%; font-size: large;">
                                                            Patient Comparison Report</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="chartContainer" style="width: 50%; padding-left: 30%;">
                                                        </div>
                                                        <%--  <div id="chartContainer1" style="vertical-align: top; float: left;">
                                                           
                                                        </div>--%>
                                                        <div id="chartContainerRight" style="vertical-align: top; width: 50%; float: left;
                                                            padding-top: 0px">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </center>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
   <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnPatientID" runat="server" />
    <asp:HiddenField ID="hdnPageID" runat="server" />
    <asp:HiddenField ID="hdnVisitNumber" runat="server" />
    </form>

    <script src="../Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../Scripts/highcharts.js" type="text/javascript"></script>

    <script src="../Scripts/moment.js" type="text/javascript"></script>

    <script type="text/javascript">
        function destroycharts() {
            document.getElementById("chartContainer").innerHTML = "";
        }
        function showGraph() {

            var chartlist = [];
            var dataTable = [];
            var InvestigationIDs = [];
            var UniqueInvestigationIDs = [];
            var checkedCheckboxes = 0;
            count = document.getElementById("tbl2").rows.length;
            
            if (count == 0) {
                alert("Please Select atleast one Item");
                return false;
            }
           

            var dataTables = $('#tbl2').dataTable();
            $(dataTables.fnGetNodes()).each(function(i, n) {
                //$("#tbl2 tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var chckSelect = $row.find("input[id$='chkboxjdatatable']").is(":checked");
                if (chckSelect) {
                    checkedCheckboxes = checkedCheckboxes + 1;
                    var VisitDate = $row.find("#jVisitDate").text();
                    var Value = $row.find("#jValue").text();
                    var InvestigationName = $row.find("#jInvestigationName").text();
                    var InvestigationID = $row.find("input:hidden[id$='jpInvestigationID']").val(); //InvestigationID

                    InvestigationIDs.push({
                        InvestigationID: InvestigationID
                    });

                    dataTable.push({
                        VisitDate: VisitDate,
                        Value: Value,
                        InvestigationID: InvestigationID,
                        InvestigationName: InvestigationName
                    });
                }

            });
            if (checkedCheckboxes == 0) {
                alert('Choose atleast one Item');
                return false;
            }
          //  var x = document.getElementById("example1").rows[0].length;

           

            var dupes = {};

            $.each(InvestigationIDs, function(i, el) {
                if (!dupes[el.InvestigationID]) {
                    dupes[el.InvestigationID] = true;
                    UniqueInvestigationIDs.push(el);
                }
            });

            for (var i = 0; i < UniqueInvestigationIDs.length; ++i) {
                var finals = [];
                var fd = [];
                var investigationName = '';
                var d_id = i + 1;

                var new_id = "chartContainer" + d_id;
                $("#chartContainer").append('<div id="' + new_id + '"></div><br/>');

                for (var j = 0; j < dataTable.length; j++) {
                    if (UniqueInvestigationIDs[i].InvestigationID == dataTable[j].InvestigationID) {
                        var inv = dataTable[j].InvestigationID;

                        var firstdate = new Date(dataTable[j].VisitDate);
                        var d1 = Date.parse(firstdate);
                        investigationName = dataTable[j].InvestigationName;
                        finals.push({ 'x': d1, 'y': parseInt(dataTable[j].Value) });

                        //                        fd += '{ x:'+ new Date(d1) +', y:' + parseInt(dataTable[j].Value) + '},';

                    } //if ends
                } //for loop ends (datatable)



                Highcharts.setOptions({
                    global: {
                        useUTC: false
                    }
                });

                $('#' + new_id).highcharts({
                    chart: {
                        type: 'line',
                        spacingBottom: 15,
                        spacingTop: 10,
                        // spacingLeft:5,
                        spacingRight: 10,
                        width: 500,
                        height: 400
                    },
                     plotOptions: {
                           line: {
            
                           events: {
                            legendItemClick: function (e) {
                            e.preventDefault();
                        //return false; // <== returning false will cancel the default action
                                    }
                                  }
                                 ,
                                  showInLegend: true
                                  }
                          },
                    title: {
                        text: investigationName
                    },
                    xAxis: {
                        type: 'datetime',
                        title: {
                            text: 'VisitDate'
                        },
                        //                        labels: {
                        //                            rotation: -45
                        //                           , format: '{value:%m/%d/%Y %H:%M }'
                        //                        }
                        labels: {
                            rotation: -45,
                            formatter: function() {
                                return Highcharts.dateFormat('%a %d %b %H:%M', this.value);
                                //return Highcharts.dateFormat(Date.parse(this.value + ' UTC'),this.value);
                            }
                        }

                        , startOnTick: true
                        // , pointStart: finals[0].x
                        // , tickInterval: 24 * 3600 * 1000
                    },
                    yAxis: {
                        title: {
                            text: 'Value'
                        }
                    },
                    series: [{
                    data: finals,
                    clickable: false,
                        marker: {
                            enabled: true
                        }
                        // ,pointStart: Date.UTC(2008, 0, 01)
                        //, pointInterval:  24 * 3600 * 1000 //
}]
                    });

                    //chartlist.push(chart);

                } //for loop ends (unique)

                //$('#customtable').show();
                $('#tbl3').show();
                $('#li2').removeClass('active');
                $('#li1').removeClass('active');
                $('#li3').addClass('active');
                $('#example').hide();
                $('#example1').hide();
                //                $(".canvasjs-chart-canvas").attr("style", "position: relative;");
                //                $(".canvasjs-chart-canvas").removeAttr("style", "display:inline-block;");
                //            $(".canvasjs-chart-canvas").removeAttr("style", "width:300px");
                return false;
            }
    </script>

    <%--<script src="../Scripts/canvasjs.min.js" type="text/javascript"></script>--%>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>
</html>
