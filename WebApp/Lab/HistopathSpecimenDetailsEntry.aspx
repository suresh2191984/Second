<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistopathSpecimenDetailsEntry.aspx.cs"
    Inherits="Histopath_Specimen_Details_Entry" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Histopath Specimen Detail Entry</title>
    <%--<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">--%>

    
<%--
    <script src="../Scripts/datatablescroll.min.js" type="text/javascript"></script><script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>--%>


    <script src="../Scripts/datatablescroll.3.3.1.js" type="text/javascript"></script>

    <link href="../StyleSheets/datatable.scroll.min.css" rel="stylesheet" type="text/css" />
    <%-- <script src="../Scripts/jquery.fixedheadertable.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.fixedheadertable.min.js" type="text/javascript"></script>--%>
<script type="text/javascript">
function bindscroll(){
    $('#tblEnterTissue').DataTable( {
        "scrollY":        "200px",
        "scrollCollapse": true,
        "paging":         false
    } );
    }
</script>
    <style type="text/css">
    /*  #tblEnterTissue thead {
  display: table;  to take the same width as tr */
/*  width: 100% !important; /* - 17px because of the scrollbar width 
}


#tblEnterTissue tbody {
  display: block;  to enable vertical scrolling
 max-height: 220px;  e.g.
  overflow-y: scroll;  keeps the scrollbar even if it doesn't need it; display purpose 
}*/
     .ui-autocomplete
        {
            height: 200px;
            overflow-y: scroll;
            overflow-x: hidden;
        }
        .ui-datepicker
        {
            font-size: 10pt !important;
        }
        ui_tpicker_time_label .ui_tpicker_time_label
        {
            font-size: x-small;
        }
        .ui_tpicker_minute_label
        {
            font-size: x-small;
        }
        .ui_tpicker_time
        {
            font-size: x-small;
        }
        .ui_tpicker_second_label
        {
            font-size: x-small;
        }
        .ui_tpicker_time_label
        {
            font-size: x-small;
        }
        .ui_tpicker_hour_label
        {
            font-size: x-small;
        }
        .tabdsg-li
        {
            width: 33%;
        }
        .tabdsg:hover
        {
            background-color: rgba(32, 34, 47, 0.51);
        }
        .ui-tabs .ui-tabs-nav li.ui-state-default.ui-tabs-active a
        {
            color: #fff;
            font-size: 13px;
            font-weight: bold;
        }
        .ui-tabs .ui-tabs-nav li.ui-state-default a
        {
            color: #ccc;
            text-decoration: none;
        }
        .ui-tabs .ui-tabs-panel
        {
            padding: 0.5em 0.4em !important;
        }
        .ScrollStyle
        {
            max-height: 300px;
            overflow-y: scroll;
            height: 300px;
        }
        .w-100p
        {
            width: 100%;
        }
        .contentPlane
        {
            display: block;
            background-color: #e2e2e2;
            line-height: 37px;
            border-radius: 5px;
        }
        .marginL10
        {
            margin-left: 10px;
        }
    </style>
    <style type="text/css">
        /************Jeeva********/.w-50
        {
            width: 50px !important;
        }
        .w-60
        {
            width: 60px !important;
        }
        .padding0
        {
            padding: 0px !important;
        }
        /*****new Css**********/.input-group-btn select
        {
            border-color: #ccc;
            margin-top: 0px;
            margin-bottom: 0px;
            padding-top: 5px;
            padding-bottom: 6px;
        }
        /***********************.sidebar-mini.skin-purple **************************/.sidebar-mini.skin-purple .main-sidebar, .sidebar-mini.skin-purple .left-side
        {
            background-color: #323140;
        }
        .sidebar-mini.skin-purple .sidebar a
        {
            color: #e3e3e3;
        }
        .sidebar-mini.skin-purple .nav-pills > li.active > a, .sidebar-mini.skin-purple .nav-pills > li.active > a:focus, .sidebar-mini.skin-purple .nav-pills > li.active > a:hover
        {
            color: #fff;
            background-color: #555299;
        }
        .sidebar-mini.skin-purple .responstable th, .sidebar-mini.skin-purple .responstable .responstableHeader td
        {
            border: 0 !important;
            border-right: 1px solid #ccc !important;
            border: 1px solid #ccc;
            background-color: #605ca8;
            color: #FFF; /* padding: 1em; */
        }
        .sidebar-mini.skin-purple .btn-primary
        {
            background-color: #605ca8;
            border-color: #605ca8;
        }
        .sidebar-mini.skin-purple .btn-primary:hover, .sidebar-mini.skin-purple .btn-primary:active, .sidebar-mini.skin-purple .btn-primary.hover
        {
            background-color: #555299;
        }
        .sidebar-mini.skin-purple .box
        {
            border: 1px solid #b2b1b1;
            border-top: 3px solid #605ca8;
        }
        .sidebar-mini.skin-purple .box-header.with-border
        {
            border-bottom: 1px solid #b2b1b1;
            background: #f5f5f5;
        }
        .sidebar-mini.skin-purple .box-title
        {
            color: #605ca8;
            font-weight: bold;
        }
        .sidebar-mini.skin-purple .responstable.box-table th, .sidebar-mini.skin-purple .responstable.box-table .responstableHeader td
        {
            border: 0 !important;
            border-right: 1px solid #ccc !important;
            border: 1px solid #ccc;
            background-color: #f5f5f5;
            color: #000; /* padding: 1em; */
        }
        .boldlbl
        {
            font-weight: bold;
        }
        /***********************End of .sidebar-mini.skin-purple **************************//*****End of new Css**********//************Jeeva********/</style>
    <style>
        .autocmp .ui-corner-all
        {
            -moz-border-radius: 4px 4px 4px 4px;
        }
        .ui-widget-content
        {
            border: 1px solid black;
            color: #222222;
            background-color: White;
        }
        .ui-menu
        {
            display: block;
            float: left;
            list-style: none outside none;
            margin: 0;
            padding: 2px;
        }
        .ui-autocomplete
        {
            cursor: default;
            position: absolute;
        }
        .ui-menu .ui-menu-item
        {
            clear: left;
            float: left;
            margin: 0;
            padding: 0;
            width: 100%;
        }
        .ui-menu .ui-menu-item a
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            cursor: pointer;
            background-color: White;
        }
        .ui-menu .ui-menu-item a:hover
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            color: White;
            cursor: pointer;
            background-color: ButtonText;
        }
        .ui-widget-content a
        {
            color: #222222;
        }
        .h-210{max-height: 410px;}
        .o-auto{overflow: auto;}
    </style>
    <%-- <link href="../QMS/dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />--%>
</head>
<body>
    <form id="form1" runat="server" onkeydown="TextBoxpressBrowserRefresh();">
    <asp:HiddenField ID="hdnOrgDateTime" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnOrgDate" runat="server"></asp:HiddenField>
	<asp:HiddenField ID="hdnMessages" Value="" runat="server"></asp:HiddenField>
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="tabs">
            <ul>
                <li class="tabdsg-li"><a href="#GrossContent" class="tabdsg w-100p" id="Gross">Gross Examination</a></li>
                <li class="tabdsg-li"><a href="#TissueContent"  class="tabdsg w-100p" id="Tissue">Tissue Preparation</a></li>
                <li class="tabdsg-li"><a href="#MicroContent" class="tabdsg w-100p" id="Micro">MicrosCopy</a></li>
            </ul>
            <div id="searchfltPnl">
                <table id="mainCten" style="padding-right: 15px; width: 1300px; height: 150px; /* right: 134px;
                    */">
                    <tr>
                        <td>
                            <asp:Label ID="lblVisitNos" runat="server" Text="Visit Number "></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtVisitNos" />
                        </td>
                        <td>
                            <asp:Label ID="lblPatient" runat="server" Text="Patient No "></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtPatientNo" />
                        </td>
                        <td>
                            <asp:Label ID="lblHisto" runat="server" Text="Histopath Number "></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtHistopath" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProcessed" runat="server" Text="PatientName "></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtPatientName" />
                        </td>
                        <td>
                            <asp:Label ID="lblClient" runat="server" Text="Investigations  "></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtINV" onkeyup="ContainerAutoCom(this.id)" />
                        </td>
                        <td>
                            <asp:Label ID="lblRefDr" runat="server" Text="Sample Name"></asp:Label>
                        </td>
                        <td>
                            <input id="txtSpeciman" type="text" onkeyup="ContainerAutoCom(this.id)" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCOntainerName" Text="Container Name" runat="server"></asp:Label>
                        </td>
                        <td>
                            <input id="txtContainer" type="text" onkeyup="ContainerAutoCom(this.id)" />
                        </td>
                        <td>
                            <asp:Label ID="lblBarcode" Text="BarCode Number" runat="server"></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtBarCode" />
                        </td>
                        <td>
                            <asp:Label ID="lblTissue" Text="Tissue Type" runat="server"></asp:Label>
                        </td>
                        <td>
                            <input type="text" id="txtTissue" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblFromDate" Text="From Date" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFDate" class="Tdate" runat="server"></asp:TextBox><img src="../Images/starbutton.png" alt="" class="a-center">
                        </td>
                        <td>
                            <asp:Label ID="lblToDate" Text="To Date" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTDate" class="Tdate" runat="server"></asp:TextBox><img src="../Images/starbutton.png" alt="" class="a-center">
                        </td>
                        <td>
                            <asp:Label ID="lblinvStatus" Text=" Status" runat="server"></asp:Label>
                        </td>
                        <td>
                            <select id="drpStatus">
                            </select>
                        </td>
                    </tr>
                    <tr id="trTissueBlock">
                        <td>
                            <asp:Label ID="lblBlock" Text=" Block No" CssClass="boldlbl" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBlockNo" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblBlockTye" Text=" Block Type" CssClass="boldlbl" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBlockTye" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr id="trTissueSilde">
                        <td>
                            <asp:Label ID="lblSideNo" Text=" Slide No" CssClass="boldlbl" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSideNo" class="slide" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblSlideTye" Text=" Slide Type" CssClass="boldlbl" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSlideType" class="slide" runat="server"></asp:TextBox>
                        </td>
                        <td class="stain">
                            <asp:Label ID="lblStain" CssClass="boldlbl" Text=" Staining Type  " runat="server"></asp:Label>
                        </td>
                        <td class="stain">
                            <asp:TextBox ID="txtStain" class="slide" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <%-- <tr>
                    <td>
                        <asp:Label ID="lblBarcodeNos" Text="BarCode Number" runat="server"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="txtBarcodeNos" />
                    </td>
                    <td>
                        <asp:Label ID="lblContainer" Text="Container Name" runat="server"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="txtContainer" />
                    </td>
                    <td>
                        <asp:Label ID="lblStat" Text="StatPriority" runat="server"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="txtStatPriority" />
                    </td>
                </tr>--%>
                    <tr>
                        <td>
                        </td>
                        <td style="width: 310px;">
                            <div id="TissueRadiobtns" style="font-size: xx-small; font-weight: bold;">
                                <input type="radio" name="Histo" id="TissuePre" class="Histo" value="Tissue" checked>
                                Tissue Processing
                                <input type="radio" name="Histo" class="Histo" value="Slide">
                                Slide Preparation
                                <input type="radio" name="Histo" class="Histo" value="Stain">
                                Staining
                            </div>
                        </td>
                        <td>
                            <input type="button" value="Search" class="btn" onclick="searchData();" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="CompDateTimeAndSearch" class="datebtn contentPlane ">
                <label class="marginL10" id="lbldateTime">
                    Completion Date & Time
                </label>
                <input id="MainDateTimePicker" type="text" class="dateTimePicker test"></input>
                &nbsp;&nbsp;
                <label>
                    Count :</label>&nbsp;
                <label id="lblCount">
                </label>
               <asp:TextBox ID="txtSearch" CssClass="form-control"   style="margin-left: 45%;" placeholder="Filter" Visible="true"
                                                runat="server" onkeyup="Search_Gridview(this, 'tblEnterTissue')"></asp:TextBox>
            </div>
            <div id="GrossContent" class="w-100p">
            </div>
            <div id="TissueContent" class="w-100p">
            </div>
            <div id="MicroContent" class="w-100p">
            </div>
            <div id="downbtnDiv">
                <input type="button" value="Save" style="margin-left: 50%;" class="btn datebtn" id="btnSaveclick"
                    onclick="SaveStatusTime();" /></div>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

 
    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<script src="../Scripts/datatablescroll.min.js" type="text/javascript"></script>
    <script src="../Scripts/HistopathSpecimenDetailsEntry.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <%--<script src="../Scripts/ScrollableTablePlugin_1.0_min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        $(function() {
            $("#txtFDate").datepicker({
                dateFormat: 'dd/mm/yy',
               
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                buttonImageOnly: true,
                maxDate: 0,


                yearRange: '1900:2100',
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                onClose: function(selectedDate) {
                    $("#txtTDate").datetimepicker("option", "minDate", selectedDate);

                    var date = $("#txtFDate").datetimepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTDate").datepicker({
                dateFormat: 'dd/mm/yy',
             
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                buttonImageOnly: true,
                maxDate: 0,

                yearRange: '1900:2100',
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                onClose: function(selectedDate) {
                    $("#txtFDate").datetimepicker("option", "maxDate", selectedDate);
                }
            })
        });
        $('input:text').not('.Tdate').keypress(function(e) {
        var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }

            e.preventDefault();
            return false;
        });
    </script>

    <asp:HiddenField ID="hdnSampleID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnContainer" runat="server" Value="0" />
    <asp:HiddenField ID="hdnInvID" runat="server" Value="0" />
   
    
    </form>
</body>
</html>
