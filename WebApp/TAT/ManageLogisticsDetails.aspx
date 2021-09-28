<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageLogisticsDetails.aspx.cs"
    Inherits="Admin_ManageLogisticsDetails" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %> -->
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Logistics Details</title>
    <style>
        .hide_column
        {
            display: none;
        }
        .menu_links:hover
        {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
       <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
                    <div class="contentdata">
                  
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlCntrl" Width="100%" runat="server">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblfrmOrg" runat="server" Text="From Org"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFrmOrg" onchange="LoadFromLocation();" runat="server" CssClass="ddlsmall"
                                                    Height="18px">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFromLocation" runat="server" Text="From Location"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFromLocation" runat="server" CssClass="ddlsmall" Height="18px">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblToOrg" runat="server" Text="To Org"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlToOrg" onchange="LoadToLocation();" runat="server" CssClass="ddlsmall"
                                                    Height="18px">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblToLocation" runat="server" Text="To Location"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlToLocation" runat="server" CssClass="ddlsmall" Height="18px">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTransitTime" runat="server" Text="Transit Duration"></asp:Label>
                                            </td>
                                            <td>
                                                <input type="text" id="txtTransitTime"   onkeypress="return isNumber(event);" runat="server" style="width: 38px;" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlTransitTime" runat="server" CssClass="small" Height="18px">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="ADD" OnClientClick="javascript:return SaveLogisticsDetails();" />
                                                <asp:Button ID="btnUpdate" Style="display: none" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="UPDATE" OnClientClick="javascript:return UpdateLogisticsDetails();" />
                                                    <asp:Button ID="btnClear"   runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="CLEAR" OnClientClick="javascript:return rowClear();" />
                                            </td>
                                        </tr>
                                        <asp:HiddenField ID="hdnDepartment" runat="server" />
                                    </table>
                                    <table>
                                        <tr>
                                            <div id="DivManageLogistics" style="display: none" runat="server">
                                                <table id="tblManageLogistics" style="display: none;">
                                                    <thead align="left">
                                                        <tr>
                                                           
                                                            <th class="hide_column">
                                                                Logisticdetailsid
                                                            </th>
                                                            <th>
                                                                From Org
                                                            </th>
                                                            <th class="hide_column">
                                                                Fromorgid
                                                            </th>
                                                            <th>
                                                                From Location
                                                            </th>
                                                            <th class="hide_column">
                                                                Fromorgaddressid
                                                            </th>
                                                            <th>
                                                                To Org
                                                            </th>
                                                            <th class="hide_column">
                                                                Toorgid
                                                            </th>
                                                            <th>
                                                                To Location
                                                            </th>
                                                            <th class="hide_column">
                                                                Toorgaddressid
                                                            </th>
                                                            <th>
                                                                Transit Duration
                                                            </th>
                                                            <th>
                                                                Action
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                
    <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
    <asp:HiddenField ID="hdnorgAddressId" runat="server" />
    <asp:HiddenField ID="hdnLogisticdetailsid" runat="server" />
    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    
    </form>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>
</html>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        // GetData();
        //document.getElementById("ddlFrmOrg").innerHTML = "";
        document.getElementById("ddlFromLocation").innerHTML = "";
        document.getElementById("ddlToOrg").innerHTML = "";
        document.getElementById("ddlToLocation").innerHTML = "";
        //$("#ddlFrmOrg").append($("<option selected='selected'></option>").val(0).html('--Select--'));
        $("#ddlFromLocation").append($("<option selected='selected'></option>").val(0).html('--Select--'));
        $("#ddlToOrg").append($("<option selected='selected'></option>").val(0).html('--Select--'));
        $("#ddlToLocation").append($("<option selected='selected'></option>").val(0).html('--Select--'));
        LoadFromOrg();
        LoadToOrg();
        GetData();


    }
);

    function GetData() {
        try {


            var OrgId = document.getElementById('hdnBaseOrgId').value;
            var OrgAddressId = document.getElementById('hdnorgAddressId').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/LoadTATLogisticsDetails",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgId':" + OrgId + ",'OrgAddressId':" + OrgAddressId + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice tblManageLogistics calling");

                    return false;
                }
            });
            $('#DivManageLogistics').show();
            $('#tblManageLogistics').show();

        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false;

    }
    function AjaxGetFieldDataSucceeded(result) {
        try {

            var oTable;
            var dataRes;

            dataRes = result.d;

            if (result != "") {

                oTable = $('#tblManageLogistics').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { //pop.show(); 
                    },
                    "aoColumns": [
                     // { "mDataProp": "SNO" },
                      { "mDataProp": "Logisticdetailsid", "sClass": "hide_column" },
                      { "mDataProp": "Fromorgname" },
                      { "mDataProp": "Fromorgid", "sClass": "hide_column" },
                      { "mDataProp": "Fromlocationname" },
                      { "mDataProp": "Fromorgaddressid", "sClass": "hide_column" },
                      { "mDataProp": "Toorgname" },
                      { "mDataProp": "Toorgid", "sClass": "hide_column" },
                      { "mDataProp": "Tolocationname" },
                      { "mDataProp": "Toorgaddressid", "sClass": "hide_column" },
                      { "mDataProp": "Transittimetype" },

                      { "mDataProp": "Logisticdetailsid",
                          "mRender": function(data, type, full) {

                              if (data != '') {
                                  var returnLink = '<table><tr><td class="pEdit"><a href="#" id="' + full.Logisticdetailsid + '_EditID" class="menu_links" onclick="EditLogisticsDetails(' + full.Logisticdetailsid + ');"  onmouseover=""> <font color="blue"><b>Edit</b></font></a></td>'
                                                   + '<td class="pEdit"><a href="#" id="' + full.Logisticdetailsid + '_DeleteID" class="menu_links" onclick="ValidationAlert(' + full.Logisticdetailsid + ')"  onmouseover=""> <font color="red">Delete</font></a></td>'
//                                                    + '<td class="pCancel"><a href="#" id="' + full.Logisticdetailsid + '_CancelID" class="menu_links" onclick="rowClear(this)"  onmouseover=""> <font color="blue">Clear</font></a></td></tr></table>'
                                  return returnLink
                              }
                          }
                      }

],
                    "sPaginationType": "full_numbers",
                    "bDeferRender": false,
                    "bPaginate": false,
                    // "sScrollX": "100%",
                    "sScrollXInner": "100%",
                    "bScrollAutoCss": true,
                    "bJQueryUI": false,
                    "aLengthMenu": [[20, 50, 75, -1], [20, 50, 75, "All"]],
                    "iDisplayLength": 20,
                    //"sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false,
                    "bInfo": true,
                    "bLengthChange": false,
                      "searching": false


                });

                //$('.pCancel').hide();

                $('#DivManageLogistics').show();
                $('#tblManageLogistics').show();


            }
        }

        catch (e) {

            alert('Error in tblManageLogistics Values');

        }

    }


    function LoadFromOrg() {
        var orgID = '<%= OrgID %>';
        $.ajax({

            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetOrgLoction",
            dataType: "json",
            success: function(Result) {
                $.each(Result.d, function(key, value) {
                    if (orgID == value.OrgID) {


                        $("#ddlFrmOrg").append($("<option></option>").val
                                           (value.OrgID).html(value.Name));
                    }

                });

            },

            error: function(result) {
                alert("Error");
            }

        });

        LoadFromLocation();
    }


    function LoadFromLocation() {

        var OrgId = '<%= OrgID %>';
        var OrgAddressId = $('#ddlFromLocation option:selected').val();
        $.ajax({

            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetOrgLocationDetails",
            data: "{'OrgId':" + OrgId + ",'OrgAddressId':" + OrgAddressId + "}",
            dataType: "json",
            success: function(Result) {
                $('#ddlFromLocation').find('option').remove();
                $("#ddlFromLocation").append($("<option></option>").val
                (0).html('--Select--'));
                $.each(Result.d, function(key, value) {

                    $("#ddlFromLocation").append($("<option></option>").val
                                           (value.Fromorgaddressid).html(value.Fromlocationname));
                });
            },

            error: function(result) {
                alert("Error");
            }

        });


    }


    //To Org and Location


    function LoadToOrg() {

        $.ajax({

            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetOrgLoction",
            dataType: "json",
            success: function(Result) {
                $.each(Result.d, function(key, value) {
                    $("#ddlToOrg").append($("<option></option>").val
                                           (value.OrgID).html(value.Name));

                });
            },

            error: function(result) {
                alert("Error");
            }

        });

        LoadToLocation();
    }


    function LoadToLocation() {

        var OrgId = $('#ddlToOrg option:selected').val();
        var OrgAddressId = $('#ddlToLocation option:selected').val();
        $.ajax({

            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetOrgLocationDetails",
            data: "{'OrgId':" + OrgId + ",'OrgAddressId':" + OrgAddressId + "}",
            dataType: "json",
            async: false,
            success: function(Result) {
                $('#ddlToLocation').find('option').remove();
                $("#ddlToLocation").append($("<option></option>").val
                (0).html('--Select--'));
                $.each(Result.d, function(key, value) {

                    $("#ddlToLocation").append($("<option></option>").val
                                           (value.Fromorgaddressid).html(value.Fromlocationname));
                });
            },

            error: function(result) {
                alert("Error");
            }

        });


    }


    function SaveLogisticsDetails() {
        try {

            //debugger;
            var lstResultValues = [];
            var lstValues = [];
            //            var table = $("#tblManageLogistics").dataTable();
            var Fromorgid = $("#ddlFrmOrg option:selected").val();
            var Fromorgaddressid = $("#ddlFromLocation option:selected").val();
            var Toorgid = $("#ddlToOrg option:selected").val();
            var Toorgaddressid = $("#ddlToLocation option:selected").val();
            var Transittimevalue = document.getElementById('txtTransitTime').value;
            var Transittimetype = $("#ddlTransitTime option:selected").val();
            if (Fromorgaddressid == 0) {
                alert('Please select From Location');
                return false;
            }
            if (Toorgid == 0) {
                alert('Please select To Organisation');
                return false;
            }
            if (Toorgaddressid == 0) {
                alert('Please select To Location');
                return false;
            }
            if (Transittimetype == 0 || Transittimevalue == '') {
                alert('Please Give details for Time Duration');
                return false;
            }
           // if (Fromorgid == Toorgid && Toorgaddressid == Fromorgaddressid) {
            //    alert('Same From/To Org and Loacation should not be exist..!!');
            //    return false;
           // }




            lstResultValues.push({
                Fromorgid: Fromorgid, //Fromorgid
                Fromorgaddressid: Fromorgaddressid, //Fromorgaddressid
                Toorgid: Toorgid, //Toorgid
                Toorgaddressid: Toorgaddressid, //Toorgaddressid
                Transittimevalue: Transittimevalue, //Transittimevalue
                Transittimetype: Transittimetype//Transittimetype
            });





            var lstSave;

            if (JSON.stringify(lstResultValues) == "[]") {
                lstSave = '';
            }
            else {
                lstSave = JSON.stringify(lstResultValues);
            }


            if (lstSave == '') {
                alert('Please select Test');

                return false;
            }
            if ($("#tblManageLogistics").dataTable().fnSettings().aoData.length != 0) {
                $("#tblManageLogistics > tbody > tr").each(function() {
                    var oTable = $("#tblManageLogistics").dataTable();
                    var pos = oTable.fnGetPosition(this);
                    var rowData = oTable.fnGetData(pos);
                    lstValues.push({
                        pFromorgid: rowData["Fromorgid"],
                        pFromorgaddressid: rowData["Fromorgaddressid"],
                        pToorgid: rowData["Toorgid"],
                        pToorgaddressid: rowData["Toorgaddressid"]
                    });

                });
                for (var i = 0; i < lstValues.length; i++) {
                    for (var j = i; j < lstValues.length; j++) {


                        if (Fromorgaddressid == lstValues[j].pFromorgaddressid && Toorgid == lstValues[j].pToorgid && Toorgaddressid == lstValues[j].pToorgaddressid) {
                            alert('Same Org and Location Details already Exists....! ');
                            return false;

                        }
                    }
                }
            }
            var AjaxContent = "{'lstSave':'" + lstSave + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveTATLogisticsDetails",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {

                    alert("Saved Sucessfully");
                    GetData();
                    var orgID = '<%= OrgID %>';

                    $('#ddlFrmOrg').val(orgID);
                    $('#ddlFromLocation').val('0');
                    $('#ddlToOrg').val('0');
                    $('#ddlToLocation').val('0');
                    $('#ddlTransitTime').val('0');
                    document.getElementById('txtTransitTime').value = '';

                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {

                    alert("Error in Webservice Calling");
                    $('#tblManageLogistics').hide();


                    return false;
                }
            });
            return false;
        }

        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }


    function EditLogisticsDetails(Logisticdetailsid) {
        var Logisticid = Logisticdetailsid;
        $('#hdnLogisticdetailsid').val(Logisticid);
        try {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/EditTATLogisticsDetails",
                contentType: "application/json;charset=utf-8",
                data: "{'Logisticdetailsid':" + Logisticdetailsid + "}",
                dataType: "json",
                async: false,
                success: AjaxEditGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice EditManageLogistics calling");

                    return false;
                }
            });

        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false;

    }
    function AjaxEditGetFieldDataSucceeded(result) {
        try {


            var dataRes;
            dataRes = result.d;

            if (result != "") {

                var Fromorgid = dataRes[0].Fromorgid;
                $("#<%=ddlFrmOrg.ClientID %>").val(Fromorgid);

                var Fromorgaddressid = dataRes[0].Fromorgaddressid;
                $("#<%=ddlFromLocation.ClientID %>").val(Fromorgaddressid);
                var Toorgid = dataRes[0].Toorgid;
                $("#<%=ddlToOrg.ClientID %>").val(Toorgid);

                LoadToLocation();


                var Transittimetype = dataRes[0].Transittimetype;
                $("#<%=ddlTransitTime.ClientID %>").val(Transittimetype);

                var Transittimevalue = dataRes[0].Transittimevalue;
                $('#txtTransitTime').val(Transittimevalue);


                var Toorgaddressid = dataRes[0].Toorgaddressid;
                $("#<%=ddlToLocation.ClientID %>").val(Toorgaddressid);

                $('#btnUpdate').show();
                // $('.pCancel').show();
                $('#btnAdd').hide();
                //$('.pEdit').hide();





            }
        }

        catch (e) {

            alert('Error in tblManageLogistics Values');

        }
    }

    function UpdateLogisticsDetails() {
        try {


            var lstResultValues = [];
            var lstValues = [];
            var Fromorgid = $("#ddlFrmOrg option:selected").val();
            var Fromorgaddressid = $("#ddlFromLocation option:selected").val();
            var Toorgid = $("#ddlToOrg option:selected").val();
            var Toorgaddressid = $("#ddlToLocation option:selected").val();
            var Transittimevalue = document.getElementById('txtTransitTime').value;
            var Transittimetype = $("#ddlTransitTime option:selected").val();
            var Logisticdetailsid = $('#hdnLogisticdetailsid').val();

            if (Fromorgid == Toorgid && Toorgaddressid == Fromorgaddressid) {
                alert('Same From/To Org and Loacation should not be exist..!!');
                return false;
            }


            lstResultValues.push({
                Fromorgid: Fromorgid,  //Fromorgid
                Fromorgaddressid: Fromorgaddressid, //Fromorgaddressid
                Toorgid: Toorgid, //Toorgid
                Toorgaddressid: Toorgaddressid, //Toorgaddressid
                Transittimevalue: Transittimevalue,  //Transittimevalue
                Transittimetype: Transittimetype,
                Logisticdetailsid: Logisticdetailsid//Transittimetype
            });





            var lstUpdate;

            if (JSON.stringify(lstResultValues) == "[]") {
                lstUpdate = '';
            }
            else {
                lstUpdate = JSON.stringify(lstResultValues);
            }


            if (lstUpdate == '') {
                alert('Please give the Details');

                return false;
            }
            if ($("#tblManageLogistics").dataTable().fnSettings().aoData.length != 0) {
                $("#tblManageLogistics > tbody > tr").each(function() {
                    var oTable = $("#tblManageLogistics").dataTable();
                    var pos = oTable.fnGetPosition(this);
                    var rowData = oTable.fnGetData(pos);
                    lstValues.push({

                        pFromorgaddressid: rowData["Fromorgaddressid"],
                        pToorgid: rowData["Toorgid"],
                        pToorgaddressid: rowData["Toorgaddressid"],
                        pLogisticdetailsid: rowData["Logisticdetailsid"]
                    });

                });
                for (var i = 0; i < lstValues.length; i++) {
                    for (var j = i; j < lstValues.length; j++) {
                        if (Logisticdetailsid != lstValues[j].pLogisticdetailsid) {
                            if (Fromorgaddressid == lstValues[j].pFromorgaddressid && Toorgid == lstValues[j].pToorgid && Toorgaddressid == lstValues[j].pToorgaddressid) {
                                alert('Same Org and Location Details already Exists....! ');
                                return false;

                            }
                        }
                    }
                }
            }

            var AjaxContent = "{'lstUpdate':'" + lstUpdate + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/UpdateTATLogisticsDetails",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {

                    alert("updated Sucessfully");
                    GetData();
                    var orgID = '<%= OrgID %>';

                    $('#ddlFrmOrg').val(orgID);
                    $('#ddlFromLocation').val('0');
                    $('#ddlToOrg').val('0');
                    $('#ddlToLocation').val('0');
                    $('#ddlTransitTime').val('0');
                    document.getElementById('txtTransitTime').value = '';
                    $('#btnUpdate').hide();
                    $('#btnAdd').show();
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {

                    alert("Error in Webservice Calling");
                    $('#tblManageLogistics').hide();


                    return false;
                }
            });
            return false;
        }

        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }


    function DeleteLogisticsDetails(Logisticdetailsid) {
        try {


            var lstResultValues = [];
            var Logisticid = Logisticdetailsid;


            lstResultValues.push({

                Logisticdetailsid: Logisticid//Logisticid
            });





            var lstDelete;

            if (JSON.stringify(lstResultValues) == "[]") {
                lstDelete = '';
            }
            else {
                lstDelete = JSON.stringify(lstResultValues);
            }


            if (lstDelete == '') {
                alert('Please give the Details');

                return false;
            }

            var AjaxContent = "{'lstDelete':'" + lstDelete + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteTATLogisticsDetails",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {


                    // alert("Delete Sucessfully");
                    
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {

                    alert("Error in Webservice Calling");
                    $('#tblManageLogistics').hide();


                    return false;
                }
            });
            return false;
        }

        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }
    function rowClear() {

      
        var orgID = '<%= OrgID %>';

        $('#ddlFrmOrg').val(orgID);
        $('#ddlFromLocation').val('0');
        $('#ddlToOrg').val('0');
        $('#ddlToLocation').val('0');
        $('#ddlTransitTime').val('0');
        $('#txtTransitTime').val('');
        //$row.find('.pCancel').hide();
       //$row.find('.pEdit').show();
        //$('.pCancel').hide();
        $('#btnAdd').show();
        $('#btnUpdate').hide();
        // $('.pEdit').show();
        return false;

    }
    function ValidationAlert(Logisticdetailsid) {
        var id = Logisticdetailsid;
        var IsDelete = confirm("Are you confirm to delete!!");
        if (IsDelete == true) {
            
            DeleteLogisticsDetails(id);
            alert("Deleted Sucessfully");
            GetData();
            
        }
        else
        { return false; }
    }

//    function blockSpecialChar(e) {
//        var k;
//        document.all ? k = e.keyCode : k = e.which;
//        return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
//    }

    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

    $("#txtTransitTime").on("keypress keyup", function() {
        if ($(this).val() == '0') {
            $(this).val('');
        }
    });
 
    
    
    
</script>

