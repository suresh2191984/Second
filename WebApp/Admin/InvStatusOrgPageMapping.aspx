<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="InvStatusOrgPageMapping.aspx.cs"
    Inherits="Admin_Dummy" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>

    <style type="text/css">
        .hide_Column
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            //call display function to show data
        //LoadPageNames();
       // btnSave
        $("#btnSave").css({ "visibility": "hidden" });
            $("#btnUpdate").css({ "visibility": "hidden" });
            $("#btnnewUpdate").css({ "visibility": "hidden" });
            LoadPageTypes();
            LoadStatus();
            showData();
            LoadLang();
        }
);









        function LoadPageTypes() {
           // debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/fetchPageType",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    var ddlCustomers = $("#ddlPageType");
                    ddlCustomers.empty().append('<option selected="selected" value="-1">Please select</option>');
                    $.each(data.d, function() {
                        ddlCustomers.append($("<option></option>").val(this['Code']).html(this['DisplayText']));
                    });
                },
                error: function(d) {
                  //  debugger;
                    alert('Error in fun loading')
                }
            });
        }





        function LoadStatus() {
           // debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/fetchPageStatus",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                   // debugger;
                    var ddlStatusval = $("#ddlStatus");
                    ddlStatusval.empty().append('<option selected="selected" value="-1">Please select</option>');
                    $.each(data.d, function() {
                        ddlStatusval.append($("<option></option>").val(this['InvSampleStatusID']).html(this['InvSampleStatusDesc']));
                    });
                },
                error: function(d) {
                   // debugger;
                    alert('Error in fun loading')
                }
            });
        }




        //added lang

        function LoadLang() {
         //   debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetPageLang",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    //debugger;
                    var ddlLangval = $("#ddlLang");
                    ddlLangval.empty().append('<option selected="selected" value="-1">Please select</option>');
                    $.each(data.d, function() {
                        ddlLangval.append($("<option></option>").val(this['Code']).html(this['Name']));
                    });
                },
                error: function(d) {
                   // debugger;
                    alert('Error in function Loading')
                }
            });
        }


        //        function showData() {
        //            $.ajax({
        //                type: 'POST',
        //                url: '../WebService.asmx/fetchGridData',
        //                contentType: 'application/json; charset=utf-8',
        //                dataType: 'json',
        //                success: function(msg) {
        //                    debugger;
        //                    var table = '<table id="#myTable" class="mytable1 w-100p" style="height:100px;"><th>ID</th><th>PAGE TYPE</th>' +
        //            '<th>IsDefault</th><th>Displaytext</th><th>Edit</th><th>Delete</th>';
        //                    // loop each record
        //                    //class="mytable1 w-100p" style="height:100px;"     tbDummy
        //                    for (var i = 0; i < msg.d.length; i++) {
        //                        table += '<tr><td class="nr">' + msg.d[i].InvStatusOrgPageMappingID + '</td>' +
        //                        '<td class="nr">' + msg.d[i].PageType + '</td>' +
        //                              '<td class="nr">' + msg.d[i].IsDefault + '</td><td class="nr">' + msg.d[i].Displaytext + '</td>' +

        //                              '<td><input type="button" id="u" onclick = FetchRecordForEdit(event) value="Update" class="btn btn-medium" ></button></td>' +
        //                              '<td><input type="button"  id="d" value="Delete" class="btn btn-medium" ></button></td></tr>';
        //                    }
        //                    table += '</table>';                    
        //                    $('#GrdDiv').html(table);
        //                },
        //                error: function(d) { debugger; alert('fef'); }
        //            });
        //        }

        //
        function showData() {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/fetchGridData",
                // url: "../WebService.asmx/GetEditPatientHistoryNew",
                contentType: "application/json;charset=utf-8",
                //data: AjaxcontentData,
                dataType: "json",
                success: function Aj(dat) {
                    AjaxGetFieldDataSuccees(dat);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice showData calling");
                    //$('#divHistoryDetail').hide();
                    return false;
                }
            });
        }
        var lstEdithis = [];
        function AjaxGetFieldDataSuccees(result) {
           // debugger;
            lstEdithis = result.d;

            if (lstEdithis.length > 0) {



                $('#tblMetaData').dataTable({
                    paging: true,
                    "aLengthMenu": [[10, 20, 30, 50, -1], [10, 20, 30, 50, "All"]],
                    data: lstEdithis,
                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                           { 'data': 'InvStatusOrgPageMappingID',
                                               "sClass": "hide_Column"

                                           },
                                           { 'data': 'PageType'

                                           },
                                           { 'data': 'IsDefault'

                                           },
                                           { 'data': 'Displaytext'

                                           },
                                          { 'data': 'StatusID'
                                          },
                                          {
                                              'data': 'LangCode'
                                          },
                    //                                          { 'data': 'LangCode',
                    //                                              "sClass": "hide_Column"
                    //                                          },
                                                         {
                                                         'data': 'Edit',
                                                         "mRender": function(data, type, full, meta) {

                                                         return '<input value = "Edit" onclick="EditRecordForEdit(event)" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />/<input value = "Delete" onclick="DeleteRecordForEdit(event)" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';

                                                             //                                                             return   '<input value = "Edit" onclick="EditRecordForEdit(event)" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                         }



                                                         //                                                          {
                                                         //                                                         'data': 'Delete',
                                                         //                                                         "mRender": function(data, type, full, meta) {
                                                         //                                                         return '<input value = "Delete" onclick="EditRecordForEdit(event)" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                         //                                                         }

                                                     },
               ]
                });
            }
            else {
                alert('No records found');
            }


        }



        //latest Edit for grid by sudha EditRecordForEdit(new)*****************************

        var ddlCustomers11
        var dbid11, valpagetype11, valisdefault11, Valstatusid11, valisDisaplaytext11, valLangcode11
        function EditRecordForEdit(values) {
            //alert("hi call Edit");
            // btnnewUpdate
            $("#btnUpdate").css({ "visibility": "visible" });
            $("#btnSave").css({ "visibility": "hidden" });
            $("#btnnewUpdate").css({ "visibility": "hidden" });
            // btnnewSave
            $("#btnnewSave").css({ "visibility": "hidden" });
           // debugger;
            if (values == 0) {
                alert('Please select the record to Edit.');
                return;
            }



            else {
                var A = $("#tblMetaData tr:nth(" + (parseInt(values.path[2].sectionRowIndex) + 1) + ")"); //$("#tblMetaData tr:nth(" + this.rowIndex + ")");
                //                alert(A);
                dbid11 = A[0].cells[0].innerText;
                valpagetype11 = A[0].cells[1].innerText;
                valisdefault11 = A[0].cells[2].innerText;
                valisDisaplaytext11 = A[0].cells[3].innerText;
                Valstatusid11 = A[0].cells[4].innerText;
                valLangcode11 = A[0].cells[5].innerText;

                //                alert(dbid);
                //                alert(valpagetype);
                //                alert(valisdefault);
                //                alert(valisDisaplaytext);
                //                alert(Valstatusid);
               // debugger;

                $("#ddlStatus").val(Valstatusid11);
                var f = $("#ddlPageType option");

                f.each(function(key, s) {
                   // debugger;
                    if (s.text == valpagetype11) { $("#ddlPageType").val(s.value); return; }
                });



                $("[id*=TxtDisplayText]").val(valisDisaplaytext11);

                $("#ddlLang").val(valLangcode11);


                if (valisdefault11 == "Y" || valisdefault11 == 1)
                { $('input:checkbox[name=checkMeOut]').attr('checked', true); }
                else {
                    $('input:checkbox[name=checkMeOut]').attr('checked', false);
                }


               // debugger;




            }
        }








        //        var lstEdithis2 = [];
        //        function CheckNewEditSuccees(result) {
        //            debugger;
        //            lstEdithis2 = result.d;


        //            alert("New success coming");
        //            for (var i = 0; i < lstEdithis2.length; i++) {
        //                debugger;
        //                if (lstEdithis2[i].PageType == Pagetypeval1 &&  lstEdithis2[i].PageType == Pagetypeval1 && lstEdithis2[i].StatusID == StatusVal1 && lstEdithis2[i].Displaytext == DisplayTextVal1 && lstEdithis2[i].IsDefault == isCheckedWithGlobalVariable1) {
        //                    alert("This item already exist");
        //                    return false;

        //                }
        //            }


        ////ve ti check

        //            $.ajax({

        //                type: "POST",
        //                url: "../WebService.asmx/NewUpdateInvStatusOrgPageMapping",
        //                data: JSON.stringify({ PageType: Pagetypeval1, Isdefault: isCheckedWithGlobalVariable1, DisplayText: DisplayTextVal1, statusId: StatusVal1 }),
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                success: function(response) {
        //                    debugger;
        //                    alert("New Updation*****");
        //                    alert("InvStatusOrgPageMapping has been Updated successfully.");
        //                    window.location.reload();
        //                },
        //                error: function() {
        //                    debugger;
        //                }
        //            });
        //            return false;





        //        }













        // end latest Edit  ******************

        //latest delete for jegan
        var dbid
        function DeleteRecordForEdit(values) {
          //  alert("hi call delete");
           // debugger;
            if (values == 0) {
                alert('Please select the record to delete.');
                return;
            }



            else {
                var A = $("#tblMetaData tr:nth(" + (parseInt(values.path[2].sectionRowIndex) + 1) + ")"); //$("#tblMetaData tr:nth(" + this.rowIndex + ")");
                //alert(A);
                dbid = A[0].cells[0].innerText;
               // alert(dbid);
                DeleteDbdata(dbid);
                // assign column values to corresponding asp.net control 
            }
        }


        function DeleteDbdata(dbid) {
          //  debugger;
          //  alert("db delete");
           // alert(dbid);


            $.ajax({

                type: "POST",
                url: "../WebService.asmx/DeleteInvStatusOrgPageMapping",
                // data: JSON.stringify({ PageType: dbid }),
                data: JSON.stringify({ 'refid': dbid }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                   // debugger;
                   // alert("db delete coming");
                    alert("InvStatusOrgPageMapping has been Deleted successfully.");
                    window.location.reload();
                },
                error: function() {
                 //   debugger;
                }
            });
            return false;






        }


        function FetchRecordForEdit(values) {
           // alert("hi call delete");
            //debugger;
            if (values == 0) {
                alert('Please select the record to edit.');
                return;
            }



            else {
                //debugger;
                $("#btnUpdate").css({ "visibility": "visible" });
                $("#btnSave").css({ "visibility": "hidden" });
                var f = $("#GrdDiv table tr:nth(" + values.path[2].sectionRowIndex + ")");
                var columns = f.find('td');
               // alert(columns);
                // assign column values to corresponding asp.net control 
            }
        }






        //**********  Hided by sudha1 recently
        $(document).ready(function() {
            $('#ddlPageType').change(function() {
                ($("#ddlPageType option:selected").text());
            });
        });


        //**********  Hided by sudha1 recently










        // for insert (Save button)
        $(function() {
            $("[id*=btnSave]").bind("click", function() {
                //debugger;
              //  alert("Add");



                var Pagetypeval = $("#ddlPageType option:selected").val();
                var StatusVal = $("#ddlStatus option:selected").val();
                var langVal = $("#ddlStatus option:selected").val();
                var DisplayTextVal = $("[id*=TxtDisplayText]").val();

                if (Pagetypeval == -1 || StatusVal == -1 || DisplayTextVal == '') {
                    alert("Please select values in dropdown");
                    return false;
                }



                //**********
                var isCheckedWithGlobalVariable = 0;
                if ($('#checkMeOut').is(':checked'))
                { isCheckedWithGlobalVariable = 1; }
                else { isCheckedWithGlobalVariable = 0; }
                // alert(isCheckedWithGlobalVariable);

                var objInvStatusOrgPageMapping = {};
                // $("#ddlPageType option:selected").text();
                var PageType = $("#ddlPageType option:selected").text();
               // alert(PageType);
                objInvStatusOrgPageMapping.PageType = PageType;
                // objMetaData.LocationID = 0;
                objInvStatusOrgPageMapping.IsDefault = isCheckedWithGlobalVariable;
                //objInvStatusOrgPageMapping.IsDefault = 0;
                alert(isCheckedWithGlobalVariable);
                objInvStatusOrgPageMapping.StatusID = 0;
                objInvStatusOrgPageMapping.Displaytext = $("[id*=TxtDisplayText]").val();
                // alert(objMetaData.Displaytext);



                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/InsertInvStatusOrgPageMapping",
                    data: JSON.stringify({ PageType: PageType, Isdefault: isCheckedWithGlobalVariable, DisplayText: $("[id*=TxtDisplayText]").val(), statusId: StatusVal }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                       // debugger;
                        //alert("add1");
                        alert("InvStatusOrgPageMapping has been added successfully.");
                        window.location.reload();
                    },
                    error: function() {
                        debugger;
                    }
                });
                return false;
            });
        });





        //for update


        var isCheckedWithGlobalVariable2;
        var Pagetypeval2;
        var PageType2 ;
        var statusval2;
        var Langval2;
        var DisplayTextVal2;
        $(function() {
       // var isCheckedWithGlobalVariable;
//        var Pagetypeval = $("#ddlPageType option:selected").val();
//        var PageType = $("#ddlPageType option:selected").text();
//        var statusval = $("#ddlStatus option:selected").val();
//        var Langval = $("#ddlLang option:selected").val();
            $("[id*=btnUpdate]").bind("click", function() {
               // debugger;
               // alert("Update");
                //alert(dbid11);
                 Pagetypeval2 = $("#ddlPageType option:selected").val();
                 PageType2 = $("#ddlPageType option:selected").text();
                 statusval2 = $("#ddlStatus option:selected").val();
                 Langval2 = $("#ddlLang option:selected").val();
                 DisplayTextVal2 = $("[id*=TxtDisplayText]").val();
                var objInvStatusOrgPageMapping = {};
                // $("#ddlPageType option:selected").text();
                
               // alert(PageType2);

                
               //  alert(Langval2);
                
                if ($('#checkMeOut').is(':checked'))
                { isCheckedWithGlobalVariable2 = "Y"; }
                else { isCheckedWithGlobalVariable2 = "N"; }
                //   alert(isCheckedWithGlobalVariable)






                objInvStatusOrgPageMapping.PageType = PageType2;
                // objMetaData.LocationID = 0;
                objInvStatusOrgPageMapping.IsDefault = isCheckedWithGlobalVariable2;
                //objInvStatusOrgPageMapping.IsDefault = 0;
               // alert(isCheckedWithGlobalVariable2);
                objInvStatusOrgPageMapping.StatusID = 0;
                objInvStatusOrgPageMapping.Displaytext = $("[id*=TxtDisplayText]").val();
                // alert(objMetaData.Displaytext);



                if (Pagetypeval2 == -1 || statusval2 == -1 || Langval2 == -1 || DisplayTextVal2 == '') {
                    alert("Please select the corresponding dropdown values and Display text")
                    return false;
                }

                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/NewUpdateInvStatusOrgPageMapping",
                    data: JSON.stringify({ InvStatusOrgPageMappingID: dbid11, PageType: PageType2, Isdefault: isCheckedWithGlobalVariable2, DisplayText: $("[id*=TxtDisplayText]").val(), statusId: statusval2, LangCode: Langval2 }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        //debugger;
                        //alert("add1");
                        alert("InvStatusOrgPageMapping has been Updated successfully.");
                        window.location.reload();
                    },
                    error: function(f) {
                        //debugger;
                    }
                });
               //return false;
            });
        });





        // for clearbutton click


        $(function() {
            $("[id*=btnClear]").bind("click", function() {
                debugger;
               // alert("clearInterval");
                $('#TxtDisplayText').val('');
                  $('#txtLocation').val('');
                $('input:checkbox[name=checkMeOut]').attr('checked', false)
                var clr = -1;
                $("#ddlStatus").val(clr);
                $("#ddlPageType").val(clr);
                $("#ddllang").val(clr);
                // window.location.reload();

                  
LoadLang();
                $("#btnUpdate").css({ "visibility": "hidden" });
                $("#btnSave").css({ "visibility": "hidden" });
                $("#btnnewUpdate").css({ "visibility": "hidden" });
                // btnnewSave
                $("#btnnewSave").css({ "visibility": "visible" });
                $("#btnClear").css({ "visibility": "visible" });

            });
        });














        //for add1 button  Testing btnnewSave(add1 button)
        var Pagetypeval1;
        var StatusVal1;
        var DisplayTextVal1;
        var isCheckedWithGlobalVariable1;
        var langVal1;
        var Pagetypeval2;
        $(function() {
            $("[id*=btnnewSave]").bind("click", function() {
                //debugger;
               // alert("btnnewSave");



                Pagetypeval1 = $("#ddlPageType option:selected").val();
                Pagetypeval2 = $("#ddlPageType option:selected").text();
                StatusVal1 = $("#ddlStatus option:selected").val();
                DisplayTextVal1 = $("[id*=TxtDisplayText]").val();
                langVal1 = $("#ddlLang option:selected").text();
              //  alert(langVal1);

                if (Pagetypeval1 == -1 || StatusVal1 == -1 || langVal1 == -1 || DisplayTextVal1 == '') {
                    alert("Please select the corresponding dropdown values and Display text")
                    return false;
                }

                isCheckedWithGlobalVariable1 = "N";
                if ($('#checkMeOut').is(':checked'))
                { isCheckedWithGlobalVariable1 = "Y"; }
                else { isCheckedWithGlobalVariable1 = "N"; }

                //                if (Pagetypeval == 0 || StatusVal == 0 || DisplayTextVal == '') {
                //                    alert("Please select values in dropdown");

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/fetchGridData",
                    // url: "../WebService.asmx/GetEditPatientHistoryNew",
                    contentType: "application/json;charset=utf-8",
                    //data: AjaxcontentData,
                    dataType: "json",
                    success: function Aj(dat) {
                        CheckDataSuccees(dat);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error in Webservice showData calling");
                        //$('#divHistoryDetail').hide();
                        return false;
                    }
                });
                return false;
                //                }
            });
        });




        var lstEdithis1 = [];
        function CheckDataSuccees(result) {
           // debugger;
            lstEdithis1 = result.d;


           // alert("New success coming");
            for (var i = 0; i < lstEdithis1.length; i++) {
               // debugger;
                if (lstEdithis1[i].PageType == Pagetypeval2 && lstEdithis1[i].StatusID == StatusVal1 && lstEdithis1[i].Displaytext == DisplayTextVal1 && lstEdithis1[i].IsDefault == isCheckedWithGlobalVariable1 ) {
                    alert("This item already exist");
                    return false;

                }
            }




            $.ajax({

                type: "POST",
                url: "../WebService.asmx/InsertInvStatusOrgPageMapping",
                data: JSON.stringify({ PageType: Pagetypeval2, Isdefault: isCheckedWithGlobalVariable1, DisplayText: DisplayTextVal1, statusId: StatusVal1, Langcode: langVal1 }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    //debugger;
                    //alert("add1*****");
                    alert("InvStatusOrgPageMapping has been added successfully.");
                    window.location.reload();
                },
                error: function(f) {
                   // debugger;
                }
            });
            return false;





        }


       
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div align="center">
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblPageType" runat="server" Text="Page Type"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <%-- <asp:DropDownList ID="ddlPageType" Width="62%" runat="server">
                    </asp:DropDownList>--%>
                    <select id="ddlPageType" name="Fruit" width="62%">
                    </select>
                </td>
                <td>
                    <input type="button" id="btnSave" value="Add" />
                    <input type="button" id="btnClear" value="Clear" />
                    <input type="button" id="btnUpdate" value="Update" />
                    <input type="button" id="btnnewSave" value="Add1" />
                    <input type="button" id="btnnewUpdate" value="Update1" />
                    <%-- <input type="button" id ="btnDelete" value="Delete" />--%>
                    <%-- *******************File Content && File Name***************************--%>
                </td>
            </tr>
            <tr style="display:none">
                <td>
                    <asp:Label ID="Label2" runat="server" Text="Location"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <%-- <asp:DropDownList ID="DropDownList1" Width="62%" runat="server">
                    </asp:DropDownList>--%>
                    <asp:TextBox ID="txtLocation" runat="server" Width="60%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Status"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <asp:DropDownList ID="ddlStatus" Width="62%" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Display Text"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <asp:TextBox ID="TxtDisplayText" runat="server" Width="60%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Language Code"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <%-- <asp:TextBox ID="TextBox1" runat="server" Width="60%"></asp:TextBox>--%>
                    <%-- <asp:DropDownList ID ="ddlLang" Width="62%" runat="server"></asp:DropDownList>--%>
                    <select id="ddlLang" name="Fruit" onchange="SetSelectedText(this)" width="62%">
                        <%--<option value="0">Please Select</option>
                        <option value="en-GB">English</option>
                        <option value="id-ID">Bahasa</option>
                        <option value="ta-IN">தமிழ்</option>
                        <%-- zh-CN--%>
                        <%--   <option value="zh-CN">Chinese</option>
                        <option value="es-ES">Español</option>--%>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblIsDefault" runat="server" Text="Isdefault"></asp:Label>
                </td>
                <td width="30%" align="left">
                    <%-- <asp:DropDownList ID="DropDownList1" Width="62%" runat="server">
                    </asp:DropDownList>--%>
                    <%--<asp:CheckBox ID="chkdefault" runat="server" />--%>
                    <input type="checkbox" value="1" name="checkMeOut" id="checkMeOut" checked="checked" />
                </td>
            </tr>
        </table>
        <div id="GrdDiv" runat="server">
            <table id="tblMetaData">
                <thead>
                    <tr class='dataheader1'>
                        <th>
                            InvStatusOrgPageMappingID
                        </th>
                        <th>
                            PageType
                        </th>
                        <th>
                            IsDefault
                        </th>
                        <th>
                            DisplayText
                        </th>
                        <th>
                            StatusID
                        </th>
                        <th>
                            Languange
                        </th>
                        <th>
                            Edit
                        </th>
                        <%--<th>
                            Delete
                        </th>--%>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%-- <script type="text/javascript" src="../PlatForm/Scripts/DataTable/jquery.dataTables.js"></script>--%>
    <%--  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>--%>
    </form>
    <%--<script type="text/javascript" src="../PlatForm/Scripts/DataTable/jquery.dataTables.js"></script>--%>

    <script src="../QMS/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>

</body>
</html>
