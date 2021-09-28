<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BulkRegistrationBookings.aspx.cs" Inherits="HomeCollection_BulkRegistrationBookings" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>BulkRegistration Bookings</title>
    <%--2added--%>
       <%-- <link href="../PMS/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../PMS/css/bootstrap-theme.min.css" rel="stylesheet" />
        <link href="../PMS/css/dashboard.css" rel="stylesheet" />
        <link href="../PMS/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />    
        <link href="../PMS/css/dataTables.bootstrap.css" rel="stylesheet" />
        <link href="../PMS/css/dataTables.tableTools.min.css" rel="stylesheet" />
        <link href="../PMS/css/dataTables.responsive.css" rel="stylesheet" />    
        <link href="../PMS/css/jquery-ui.min.css" rel="stylesheet" />   --%>
        <link href="../PMS/css/buttons.dataTables.min.new.css" rel="stylesheet" type="text/css" />
        <link href="../PMS/css/jquery.dataTables.min.new.css" rel="stylesheet" type="text/css" />
    <%--2added--%>
 <style type="text/css">
  table.dataTable
        {
            width:auto;
            margin: 0 auto;
            clear: both;
            border-collapse: separate;
            border-spacing: 0;
        }
        table.dataTable thead th, table.dataTable tfoot th
        {
            font-weight: bold;
             width:auto;
        }
        table.dataTable thead th, table.dataTable thead td
        {
            text-align:left;
            padding: 10px 40px;
            border-bottom: 1px solid #111;
        }
        table.dataTable thead th:active, table.dataTable thead td:active
        {
            outline: none;
        }
        table.dataTable tfoot th, table.dataTable tfoot td
        {
            padding: 10px 18px 6px 18px;
            border-top: 1px solid #111;
        }
        table.dataTable thead .sorting, table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc
        {
            cursor: pointer; *cursor:hand}
        table.dataTable thead .sorting, table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting_asc_disabled, table.dataTable thead .sorting_desc_disabled
        {
            background-repeat: no-repeat;
            background-position: center right;
        }
        table.dataTable thead .sorting
        {
            background-image: url("../images/sort_both.png");
        }
        table.dataTable thead .sorting_asc
        {
            background-image: url("../images/sort_asc.png");
        }
        table.dataTable thead .sorting_desc
        {
            background-image: url("../images/sort_desc.png");
        }
        table.dataTable thead .sorting_asc_disabled
        {
            background-image: url("../images/sort_asc_disabled.png");
        }
        table.dataTable thead .sorting_desc_disabled
        {
            background-image: url("../images/sort_desc_disabled.png");
        }
        table.dataTable tbody tr
        {
            background-color: #ffffff;
        }
        table.dataTable tbody tr.selected
        {
            background-color: #B0BED9;
        }
        table.dataTable tbody th, table.dataTable tbody td
        {
            padding: 8px 10px;
            border: 1px solid #c6c6c6;
        }
        table.dataTable.row-border tbody th, table.dataTable.row-border tbody td, table.dataTable.display tbody th, table.dataTable.display tbody td
        {
            border-top: 1px solid #ddd;
        }
        table.dataTable.row-border tbody tr:first-child th, table.dataTable.row-border tbody tr:first-child td, table.dataTable.display tbody tr:first-child th, table.dataTable.display tbody tr:first-child td
        {
            border-top: none;
        }
        table.dataTable.cell-border tbody th, table.dataTable.cell-border tbody td
        {
            border-top: 1px solid #ddd;
            border-right: 1px solid #ddd;
        }
        table.dataTable.cell-border tbody tr th:first-child, table.dataTable.cell-border tbody tr td:first-child
        {
            border-left: 1px solid #ddd;
        }
        table.dataTable.cell-border tbody tr:first-child th, table.dataTable.cell-border tbody tr:first-child td
        {
            border-top: none;
        }
        table.dataTable.stripe tbody tr.odd, table.dataTable.display tbody tr.odd
        {
            background-color: #f9f9f9;
        }
        table.dataTable.stripe tbody tr.odd.selected, table.dataTable.display tbody tr.odd.selected
        {
            background-color: #acbad4;
        }
        table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover
        {
            background-color: #f6f6f6;
        }
        table.dataTable.hover tbody tr:hover.selected, table.dataTable.display tbody tr:hover.selected
        {
            background-color: #aab7d1;
        }
        table.dataTable.order-column tbody tr > .sorting_1, table.dataTable.order-column tbody tr > .sorting_2, table.dataTable.order-column tbody tr > .sorting_3, table.dataTable.display tbody tr > .sorting_1, table.dataTable.display tbody tr > .sorting_2, table.dataTable.display tbody tr > .sorting_3
        {
            background-color: #fafafa;
        }
        table.dataTable.order-column tbody tr.selected > .sorting_1, table.dataTable.order-column tbody tr.selected > .sorting_2, table.dataTable.order-column tbody tr.selected > .sorting_3, table.dataTable.display tbody tr.selected > .sorting_1, table.dataTable.display tbody tr.selected > .sorting_2, table.dataTable.display tbody tr.selected > .sorting_3
        {
            background-color: #acbad5;
        }
        table.dataTable.display tbody tr.odd > .sorting_1, table.dataTable.order-column.stripe tbody tr.odd > .sorting_1
        {
            background-color: #f1f1f1;
        }
        table.dataTable.display tbody tr.odd > .sorting_2, table.dataTable.order-column.stripe tbody tr.odd > .sorting_2
        {
            background-color: #f3f3f3;
        }
        table.dataTable.display tbody tr.odd > .sorting_3, table.dataTable.order-column.stripe tbody tr.odd > .sorting_3
        {
            background-color: whitesmoke;
        }
        table.dataTable.display tbody tr.odd.selected > .sorting_1, table.dataTable.order-column.stripe tbody tr.odd.selected > .sorting_1
        {
            background-color: #a6b4cd;
        }
        table.dataTable.display tbody tr.odd.selected > .sorting_2, table.dataTable.order-column.stripe tbody tr.odd.selected > .sorting_2
        {
            background-color: #a8b5cf;
        }
        table.dataTable.display tbody tr.odd.selected > .sorting_3, table.dataTable.order-column.stripe tbody tr.odd.selected > .sorting_3
        {
            background-color: #a9b7d1;
        }
        table.dataTable.display tbody tr.even > .sorting_1, table.dataTable.order-column.stripe tbody tr.even > .sorting_1
        {
            background-color: #fafafa;
        }
        table.dataTable.display tbody tr.even > .sorting_2, table.dataTable.order-column.stripe tbody tr.even > .sorting_2
        {
            background-color: #fcfcfc;
        }
        table.dataTable.display tbody tr.even > .sorting_3, table.dataTable.order-column.stripe tbody tr.even > .sorting_3
        {
            background-color: #fefefe;
        }
        table.dataTable.display tbody tr.even.selected > .sorting_1, table.dataTable.order-column.stripe tbody tr.even.selected > .sorting_1
        {
            background-color: #acbad5;
        }
        table.dataTable.display tbody tr.even.selected > .sorting_2, table.dataTable.order-column.stripe tbody tr.even.selected > .sorting_2
        {
            background-color: #aebcd6;
        }
        table.dataTable.display tbody tr.even.selected > .sorting_3, table.dataTable.order-column.stripe tbody tr.even.selected > .sorting_3
        {
            background-color: #afbdd8;
        }
        table.dataTable.display tbody tr:hover > .sorting_1, table.dataTable.order-column.hover tbody tr:hover > .sorting_1
        {
            background-color: #eaeaea;
        }
        table.dataTable.display tbody tr:hover > .sorting_2, table.dataTable.order-column.hover tbody tr:hover > .sorting_2
        {
            background-color: #ececec;
        }
        table.dataTable.display tbody tr:hover > .sorting_3, table.dataTable.order-column.hover tbody tr:hover > .sorting_3
        {
            background-color: #efefef;
        }
        table.dataTable.display tbody tr:hover.selected > .sorting_1, table.dataTable.order-column.hover tbody tr:hover.selected > .sorting_1
        {
            background-color: #a2aec7;
        }
        table.dataTable.display tbody tr:hover.selected > .sorting_2, table.dataTable.order-column.hover tbody tr:hover.selected > .sorting_2
        {
            background-color: #a3b0c9;
        }
        table.dataTable.display tbody tr:hover.selected > .sorting_3, table.dataTable.order-column.hover tbody tr:hover.selected > .sorting_3
        {
            background-color: #a5b2cb;
        }
        table.dataTable.no-footer
        {
            border-bottom: 1px solid #111;
        }
        table.dataTable.nowrap th, table.dataTable.nowrap td
        {
            white-space: nowrap;
        }
        table.dataTable.compact thead th, table.dataTable.compact thead td
        {
            padding: 4px 17px 4px 4px;
        }
        table.dataTable.compact tfoot th, table.dataTable.compact tfoot td
        {
            padding: 4px;
        }
        table.dataTable.compact tbody th, table.dataTable.compact tbody td
        {
            padding: 4px;
        }
        table.dataTable th.dt-left, table.dataTable td.dt-left
        {
            text-align: left;
        }
        table.dataTable th.dt-center, table.dataTable td.dt-center, table.dataTable td.dataTables_empty
        {
            text-align: center;
        }
        table.dataTable th.dt-right, table.dataTable td.dt-right
        {
            text-align: right;
        }
        table.dataTable th.dt-justify, table.dataTable td.dt-justify
        {
            text-align: justify;
        }
        table.dataTable th.dt-nowrap, table.dataTable td.dt-nowrap
        {
            white-space: nowrap;
        }
        table.dataTable thead th.dt-head-left, table.dataTable thead td.dt-head-left, table.dataTable tfoot th.dt-head-left, table.dataTable tfoot td.dt-head-left
        {
            text-align: left;
        }
        table.dataTable thead th.dt-head-center, table.dataTable thead td.dt-head-center, table.dataTable tfoot th.dt-head-center, table.dataTable tfoot td.dt-head-center
        {
            text-align: center;
        }
        table.dataTable thead th.dt-head-right, table.dataTable thead td.dt-head-right, table.dataTable tfoot th.dt-head-right, table.dataTable tfoot td.dt-head-right
        {
            text-align: right;
        }
        table.dataTable thead th.dt-head-justify, table.dataTable thead td.dt-head-justify, table.dataTable tfoot th.dt-head-justify, table.dataTable tfoot td.dt-head-justify
        {
            text-align: justify;
        }
        table.dataTable thead th.dt-head-nowrap, table.dataTable thead td.dt-head-nowrap, table.dataTable tfoot th.dt-head-nowrap, table.dataTable tfoot td.dt-head-nowrap
        {
            white-space: nowrap;
        }
        table.dataTable tbody th.dt-body-left, table.dataTable tbody td.dt-body-left
        {
            text-align: left;
        }
        table.dataTable tbody th.dt-body-center, table.dataTable tbody td.dt-body-center
        {
            text-align: center;
        }
        table.dataTable tbody th.dt-body-right, table.dataTable tbody td.dt-body-right
        {
            text-align: right;
        }
        table.dataTable tbody th.dt-body-justify, table.dataTable tbody td.dt-body-justify
        {
            text-align: justify;
        }
        table.dataTable tbody th.dt-body-nowrap, table.dataTable tbody td.dt-body-nowrap
        {
            white-space: nowrap;
        }
        table.dataTable, table.dataTable th, table.dataTable td
        {
            -webkit-box-sizing: content-box;
            box-sizing: content-box;
        }
        .dataTables_wrapper
        {
            position: relative;
            clear: both; *zoom:1;zoom:1}
        .dataTables_wrapper .dataTables_length
        {
            float: left;
        }
        .dataTables_wrapper .dataTables_filter
        {
            float: right;
            text-align: right      
        }
        .dataTables_wrapper .dataTables_filter input
        {
            margin-left: 0.5em;
        }
        .dataTables_wrapper .dataTables_info
        {
            clear: both;
            float: left;
            padding-top: 0.755em;
        }
        .dataTables_wrapper .dataTables_paginate
        {
            float: right;
            text-align: right;
            padding-top: 0.25em;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button
        {
            box-sizing: border-box;
            display: inline-block;
            min-width: 1.5em;
            padding: 0.5em 1em;
            margin-left: 2px;
            text-align: center;
            text-decoration: none !important;
            cursor: pointer; *cursor:hand;color:#333!important;border:1pxsolidtransparent;border-radius:2px}
        .dataTables_wrapper .dataTables_paginate .paginate_button.current, .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover
        {
            color: #333 !important;
            border: 1px solid #979797;
            background-color: white;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fff), color-stop(100%, #dcdcdc));
            background: -webkit-linear-gradient(top, #fff 0%, #dcdcdc 100%);
            background: -moz-linear-gradient(top, #fff 0%, #dcdcdc 100%);
            background: -ms-linear-gradient(top, #fff 0%, #dcdcdc 100%);
            background: -o-linear-gradient(top, #fff 0%, #dcdcdc 100%);
            background: linear-gradient(to bottom, #fff 0%, #dcdcdc 100%);
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button.disabled, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:hover, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:active
        {
            cursor: default;
            color: #666 !important;
            border: 1px solid transparent;
            background: transparent;
            box-shadow: none;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover
        {
            color: white !important;
            border: 1px solid #111;
            background-color: #585858;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #585858), color-stop(100%, #111));
            background: -webkit-linear-gradient(top, #585858 0%, #111 100%);
            background: -moz-linear-gradient(top, #585858 0%, #111 100%);
            background: -ms-linear-gradient(top, #585858 0%, #111 100%);
            background: -o-linear-gradient(top, #585858 0%, #111 100%);
            background: linear-gradient(to bottom, #585858 0%, #111 100%);
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button:active
        {
            outline: none;
            background-color: #2b2b2b;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #2b2b2b), color-stop(100%, #0c0c0c));
            background: -webkit-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
            background: -moz-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
            background: -ms-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
            background: -o-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
            background: linear-gradient(to bottom, #2b2b2b 0%, #0c0c0c 100%);
            box-shadow: inset 0 0 3px #111;
        }
        .dataTables_wrapper .dataTables_paginate .ellipsis
        {
            padding: 0 1em;
        }
        .dataTables_wrapper .dataTables_processing
        {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100%;
            height: 40px;
            margin-left: -50%;
            margin-top: -25px;
            padding-top: 20px;
            text-align: center;
            font-size: 1.2em;
            background-color: white;
            background: -webkit-gradient(linear, left top, right top, color-stop(0%, rgba(255,255,255,0)), color-stop(25%, rgba(255,255,255,0.9)), color-stop(75%, rgba(255,255,255,0.9)), color-stop(100%, rgba(255,255,255,0)));
            background: -webkit-linear-gradient(left, rgba(255,255,255,0) 0%, rgba(255,255,255,0.9) 25%, rgba(255,255,255,0.9) 75%, rgba(255,255,255,0) 100%);
            background: -moz-linear-gradient(left, rgba(255,255,255,0) 0%, rgba(255,255,255,0.9) 25%, rgba(255,255,255,0.9) 75%, rgba(255,255,255,0) 100%);
            background: -ms-linear-gradient(left, rgba(255,255,255,0) 0%, rgba(255,255,255,0.9) 25%, rgba(255,255,255,0.9) 75%, rgba(255,255,255,0) 100%);
            background: -o-linear-gradient(left, rgba(255,255,255,0) 0%, rgba(255,255,255,0.9) 25%, rgba(255,255,255,0.9) 75%, rgba(255,255,255,0) 100%);
            background: linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(255,255,255,0.9) 25%, rgba(255,255,255,0.9) 75%, rgba(255,255,255,0) 100%);
        }
        .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing, .dataTables_wrapper .dataTables_paginate
        {
            color: #333;
        }
        .dataTables_wrapper .dataTables_scroll
        {
            clear: both;
        }
        .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody
        { *margin-top:-1px;-webkit-overflow-scrolling:touch}
        .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody th, .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody td
        {
            vertical-align: middle;
        }
        .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody th > div.dataTables_sizing, .dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody td > div.dataTables_sizing
        {
            height: 0;
            overflow: hidden;
            margin: 0 !important;
            padding: 0 !important;
        }
        .dataTables_wrapper.no-footer .dataTables_scrollBody
        {
            border-bottom: 1px solid #111;
        }
        .dataTables_wrapper.no-footer div.dataTables_scrollHead table, .dataTables_wrapper.no-footer div.dataTables_scrollBody table
        {
            border-bottom: none;
        }
        .dataTables_wrapper:after
        {
            visibility: hidden;
            display: block;
            content: "";
            clear: both;
            height: 0;
        }
        
        
        td
        {text-align:left !important;
        }
        @media screen and (max-width: 767px)
        {
            .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_paginate
            {
                float: none;
                text-align: center;
            }
            .dataTables_wrapper .dataTables_paginate
            {
                margin-top: 0.5em;
            }
        }
        @media screen and (max-width: 640px)
        {
            .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter
            {
                float: none;
                text-align: center;
            }
            .dataTables_wrapper .dataTables_filter
            {
                margin-top: 0.5em;
            }
        }
        .thpadding
        {
           padding:2px !important;
        }
        .hide_Column
        {display:none;}
        
         .ui-datepicker
        {
            font-size: 10pt !important;
            
        }
    ui_tpicker_time_label
    .ui_tpicker_time_label
        {
            font-size:x-small;
        }
       
       .ui_tpicker_minute_label
        {
            font-size:x-small;
        }
         .ui_tpicker_time
        {
            font-size:x-small;
        }
        .ui_tpicker_second_label
        {
            font-size:x-small;
        }
        .ui_tpicker_time_label
        {
             font-size:x-small;
        }
        .ui_tpicker_hour_label
        {
            font-size:x-small;
        }
        .buttons-pdf
        {
            display:none !important;
        }
        #ReportDetails  th {
        <%--    background: url("Images/ui-bg_glass_45_0078ae_1x400.jpg") repeat-x scroll 50% 50% #0078ae !important;--%>
            border: 1px solid #c6c6c6;
            color: #fff!important;
            margin: 0px!important;
            font-weight: normal!important;
             position: -webkit-sticky;
  position: sticky;
  top: 0;
  z-index: 2;
  background-color:#d6e9c6
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
    <div id="statusProgess" style="display: none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="w-15p a-center" style="display: block;">
                <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                    Font-Size="Larger" />
                <br />
                <br />
                <asp:Image ID="imgProgressbar1" Width="16px" Height="16px" runat="server" ImageUrl="../Images/working.gif" />
            </div>
        </div>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <table id="tblCollectionOPIP" class="a-center w-100p">
                    <tr class="a-center">
                        <td class="a-left">
                            <div class="dataheaderWider">
                                <table id="tbl">
                                    <tr>
                                        <td class="a-right">
                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall" Width="120px"></asp:TextBox>
                                             <img runat="server" ID="ImgBntCalc" src="../Images/Calendar_scheduleHS.png" alt="" align="middle" />
                                              <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" />
                                        </td>
                                        <td class="a-right">
                                            &nbsp;<asp:Label ID="Rs_ToDate" Text="To Date :" runat="server"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall" Width="120px"></asp:TextBox>
                                                 <img runat="server" ID="ImgToDate" src="../Images/Calendar_scheduleHS.png" alt="" align="middle" />
                                             &nbsp;<ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" />    
                                        </td>
                                        <td>
                                            &nbsp; <asp:Label ID="lbllocation" Text="Location" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlLocation" CssClass="ddlsmall" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                        </td>
                                        <td class="a-left">
                                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return GetResult();"
                                                meta:resourcekey="btnSubmitResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                           
                            <table class="a-center w-100p">
                                <tr>
                                    <td>
                                        <div id="ARegistrations" style="overflow: auto;height: 460px;max-width:1340px;">
                                            <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                                PopupControlID="pnlPopup" DynamicServicePath="" Enabled="True" />
                                            <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Width="95%" Style="display: none"
                                                BackImageUrl="~/Images/Loader.gif">
                                            </asp:Panel>
                                            <table id="ReportDetails" style="display: none; width: auto">
                                                <thead>
                                                    <tr>
                                                        <th class="thpadding" >
                                                            SlNo
                                                        </th>
                                                        <th class="thpadding">
                                                            OrgName
                                                        </th>
                                                        <th class="thpadding">
                                                            Location
                                                        </th>
                                                        <th class="thpadding">
                                                            Registration Date  (dd-Mmm-yy hh:mm AM/PM)
                                                        </th>
                                                        <th class="thpadding">
                                                            Sample Collected Date & Time (dd-Mmm-yy hh:mm AM/PM)
                                                        </th>
                                                        <th class="thpadding">
                                                            Patient Number
                                                        </th>
                                                        <th class="a-left">
                                                            HealthHub ID
                                                        </th>
                                                        <th class="a-left">
                                                            Employee ID
                                                        </th>
                                                        <th class="a-left">
                                                            Source Type
                                                        </th>
                                                        <th class="a-left">
                                                            Salutation
                                                        </th>
                                                        <th class="a-left">
                                                            Patient Name
                                                        </th>
                                                        <th class="a-left">
                                                            DoB (dd-Mmm-yy)
                                                        </th>
                                                        <th class="a-left">
                                                            Age
                                                        </th>
                                                        <th class="a-left">
                                                            Year(S)
                                                        </th>
                                                        <th class="a-left">
                                                            Sex
                                                        </th>
                                                        <th class="a-left">
                                                            Test Codes
                                                        </th>
                                                        <th class="thpadding">
                                                            Amount Paid
                                                        </th>
                                                        <th class="thpadding">
                                                            Discount Amount
                                                        </th>
                                                        <th class="a-left">
                                                            Client Code
                                                        </th>
                                                         <th class="a-left">
                                                            Phlebotomist name
                                                        </th>
                                                        <th class="a-left">
                                                            MobileNo
                                                        </th>
                                                        <th class="a-left">
                                                            Email ID
                                                        </th>
                                                        <th class="a-left">
                                                            Dispatch Mode
                                                        </th>
                                                        <th class="a-left">
                                                            Ref. Doctor
                                                        </th>
                                                        <th class="a-left">
                                                            Ref. Hospital
                                                        </th>
                                                        <th class="a-left">
                                                            History
                                                        </th>
                                                        <th class="a-left">
                                                            Remarks
                                                        </th>
                                                        <th class="a-left">
                                                            BookingID
                                                        </th>
                                                        <th class="a-left">
                                                            ExternalRefNo
                                                        </th>
                                                        <th class="a-left">
                                                            SampleNumber
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnValidateTime" runat="server" Value="Y" />
    </form>

<%--2added--%>
 <script src="js/BulkRegistrationBookings/jquery-1.12.3.new.js" language="javascript" type="text/javascript"></script>
 <script src="js/bootstrap.min.js" language="javascript" type="text/javascript"></script>
 <script src="js/BulkRegistrationBookings/jquery.dataTables.min.new.js" language="javascript" type="text/javascript"></script>
<%--2added--%>

    <%--<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>--%>
    <script src="js/BulkRegistrationBookings/dataTables.tableTools.min.js" language="javascript" type="text/javascript"></script>
    <script src="../Scripts/TableTools.js" language="javascript" type="text/javascript"></script>
    <script src="../Scripts/TableTools.min.js" language="javascript" type="text/javascript"></script>
    <script src="js/BulkRegistrationBookings/dataTables.bootstrap.js" language="javascript" type="text/javascript"></script>
    <script src="js/BulkRegistrationBookings/jquery-ui.min.js" language="javascript" type="text/javascript"></script>
    <%--<script type="text/javascript" src="../Scripts/TableTools.js"></script>
    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>--%>
    
    <%--2added--%>
<script src="js/BulkRegistrationBookings/dataTables.buttons.min.new.js" language="javascript" type="text/javascript"></script>
<script src="js/BulkRegistrationBookings/jszip.min.new.js" language="javascript" type="text/javascript"></script>
<script src="js/BulkRegistrationBookings/pdfmake.min.new.js" language="javascript" type="text/javascript"></script>
<script src="js/BulkRegistrationBookings/vfs_fonts.new.js" language="javascript" type="text/javascript"></script>
<script src="js/BulkRegistrationBookings/buttons.html5.min.new.js" language="javascript" type="text/javascript"></script>
<%--2added--%>
<script src="../Scripts/ZeroClipboard.js" language="javascript" type="text/javascript"></script>
<%--<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>--%>
    <script type="text/javascript">       

        function Valiadte() {
            var iatrue = true;
            if ($("#txtFromDate").val() == "") {
                alert('From Date is empty.');
                iatrue = false;
            }
            else if ($("#txtToDate").val() == "") {
                alert('To Date is empty.');
                iatrue = false;
            }
            return iatrue;
        }

        function GetResult() {
            //debugger;
            try {
                if (Valiadte()) {
                    var pop = $find("mdlPopup");
                    pop.show();
                    $('#statusProgess').show();
                    var Location = $('#ddlLocation').val();
                    var FromDate = $('#txtFromDate').val();
                    var ToDate = $('#txtToDate').val();
                    var OrgID = $('#hdnOrgID').val();

                $.ajax({
                    type: "POST",
                    url: "../HCService.asmx/GetBookingsdetailsforBulkReg",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{ pFromdt: '" + FromDate + "',pTodt: '" + ToDate + "',pOrgID: '" + OrgID + "',pOrgAddressID: '" + Location + "'}",
                    success: AjaxDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                       // debugger;
                        alert("Error");
                        $('#ReportDetails').hide();
                        pop.hide();
                        $('#statusProgess').hide();

                        return false;
                    }
                });
                }
            }
            catch (e) {
                pop.hide();
                $('#statusProgess').hide();
            }

            return false;
        }
        function AjaxDataSucceeded(result) {
             //debugger;
            $('#ARegistrations').show();
            var cssClass="";

            var pop = $find("mdlPopup");
            var oTableTools;
            var countR = result.d.length;
            if (countR > 0 && result != "[]") {
                oTableTools = $('#ReportDetails').dataTable({
                  "bDestroy": true,
                  "bAutoWidth": false,
                  "bProcessing": true,
                  "aaData": result.d,
                  "fixedHeader": true,
                  "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                                { "mDataProp": "SNo" },
                                { "mDataProp": "OrgName" },
                                { "mDataProp": "LocationName" },
                                { "mDataProp": "Registrationdt" },
                                { "mDataProp": "SampleCollecteddt" },
                                { "mDataProp": "PatientNumber" },
                                { "mDataProp": "HealthHubID" },
                                { "mDataProp": "EmployeeID" },
                                { "mDataProp": "SourceType" },
                                { "mDataProp": "Salutation" },
                                { "mDataProp": "PatientName" },
                                { "mDataProp": "DOB" },
                                { "mDataProp": "Age" },
                                { "mDataProp": "AgeType" },
                                { "mDataProp": "Sex" },
                                { "mDataProp": "TestCodes" },
                                { "mDataProp": "AmountPaid" },
                                { "mDataProp": "DiscountAmt" },
                                { "mDataProp": "ClientCode" },
                                { "mDataProp": "PhleboName" },
                                { "mDataProp": "Mobile" },
                                { "mDataProp": "EmailID" },
                                { "mDataProp": "DispatchMode" },
                                { "mDataProp": "RefDocName" },
                                { "mDataProp": "RefHospName" },
                                { "mDataProp": "History" },
                                { "mDataProp": "Remarks" },
                                { "mDataProp": "BookingID" },
                                { "mDataProp": "ExternalRefNo" },
                                { "mDataProp": "SampleNumber" },
                              ],
                    "sPaginationType": "full_numbers",
                    "sZeroRecords": "No records found",
                    "bSort": false,
                    "bJQueryUI": true,
                    "iDisplayLength": 30,
                    //  "sDom": '<"H"Tfr>t<"F"ip>',
                    "dom": 'Bfrtip',
                    "buttons": [
                               {
                                   extend: 'excel',
								   extension: '.xls',
                                   text: 'Excel',
                                   className: 'exportExcel',
                                   filename: 'Test_Excel',
                                   exportOptions: { modifier: { page: 'all'} },
								        customize: function( xlsx ) {                                   
              var source = xlsx.xl['workbook.xml'].getElementsByTagName('sheet')[0];
              source.setAttribute('name','ARegistrations');
						}     
                               },
                {
                    extend: 'csv',
                    text: 'CSV',
                    className: 'exportExcel',
                    filename: 'Test_Csv',
                    exportOptions: { modifier: { page: 'all'} }
                },
                {
                    extend: 'pdf',
                    text: 'PDF',
                    className: 'exportExcel',
                    filename: 'Test_Pdf',
                    exportOptions: { modifier: { page: 'all'} }
                }
                          ]
//                    "oTableTools": {
//                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
//                        aButtons: [
//                         { sExtends: "xls",
//                            sFileName: 'ARegistrations.xls'
//                         }
//                      ]
//                    }
                });
                $('#ReportDetails').show();
                $('#statusProgess').hide();
                pop.hide();
                
                //               
                debugger;
                    var el = document.getElementById('ReportDetails_filter');                     
                    if(el !=undefined && el != null && el != ""){
                        el.addEventListener('keydown', function(event) { 
                            const key = event.key;                            
                            if (key === "Backspace") { 
                            var cursorposition = event.target.selectionStart;
                            if(parseInt(event.target.selectionStart) >0)
                            var value =$('input[type=search]').val().slice(0,parseInt(event.target.selectionStart)-1)+$('input[type=search]').val().slice(parseInt(event.target.selectionStart));
                            $('input[type=search]').val(value);                            
                            }
                            else if (key === "Delete") { 
                            var cursorposition = event.target.selectionStart;
                            if(parseInt(event.target.selectionStart) >0)
                            var value = $('input[type=search]').val().slice(0,parseInt(event.target.selectionStart))+$('input[type=search]').val().slice(parseInt(event.target.selectionStart)+1,$('input[type=search]').val().length);
                            $('input[type=search]').val(value)                            
                            } 
                        }); 
                    }
                    //
            }
            else {
                alert('No Records Found');
                $('#ReportDetails').hide();
                $('#statusProgess').hide();
                pop.hide();
                $('#ARegistrations').hide();
            }

            return false;
        }
        
    </script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function GetCorrectdate(value) {

            if (value != null && value != '') {

                var str = new Date(value.substr(0, 11));
               var date= str.toLocaleDateString("en-GB");
               var time = value.substr(11, 6);
             var time=  convertTimeFrom12To24(time);
                value = date + " " + time;
            }
            else
            { value = ""; }
            return value;
        }

        function convertTimeFrom12To24(time) {
            var colon = time.indexOf(':');
            var hours = time.substr(0, colon),
      minutes = time.substr(colon + 1, 2),
      meridian = time.substr(colon + 3, 2).toUpperCase();


            var hoursInt = parseInt(hours, 10),
      offset = meridian == 'PM' ? 12 : 0;

            if (hoursInt === 12) {
                hoursInt = offset;
            } else {
                hoursInt += offset;
            }
            return hoursInt + ":" + minutes;
        }
    </script>
</body>
</html>
