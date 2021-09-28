<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TATReport.aspx.cs" Inherits="Reports_TATReport" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Resources.Admin_AppMsg.Admin_Reports_aspx_01%></title>
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
                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                             <img src="../Images/starbutton.png" alt="" align="middle" />
                                            <%--<td id="datecheck" runat="server" class="a-right">
                                            
                                                <%--<a href="javascript:NewCssCal('<% =txtFDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                               
                                            </td>--%>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="120px" meta:resourcekey="txtTDateResource1"
                                                OnTextChanged="txtTDate_TextChanged"></asp:TextBox>
                                                 <img src="../Images/starbutton.png" alt="" align="middle" />
                                           <%-- <td id="Td1" runat="server" class="a-right">
                                               <%-- <a href="javascript:NewCssCal('<% =txtTDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                               
                                            </td>--%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbllocation" Text="Reg.Location" runat="server" meta:resourcekey="lbllocationResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlLocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlLocationResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left w-10p">
                                            <asp:Label runat="server" ID="lblDepartment" Text="Select Department" CssClass="label_title"
                                                meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                        </td>
                                        <td class="a-left w-15p" colspan="4">
                                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl" Width="200px"
                                                TabIndex="7" meta:resourcekey="ddlDepartmentResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                        </td>
                                        <td class="a-left">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return GetResult();"
                                                meta:resourcekey="btnSubmitResource1" />
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                           
                            <table class="a-center w-100p">
                                <tr>
                                    <td>
                                        <div id="TATMISReport" style="overflow: auto;height: 460px;max-width:1340px;">
                                            <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                                PopupControlID="pnlPopup" DynamicServicePath="" Enabled="True" />
                                            <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Width="95%" Style="display: none"
                                                BackImageUrl="~/Images/Loader.gif">
                                            </asp:Panel>
                                            <table id="ReportDetails" style="display: none; width: auto">
                                                <thead>
                                                    <tr>
                                                        <th class="thpadding" >
                                                            S No
                                                        </th>
                                                        <th class="thpadding">
                                                            Patient Number
                                                        </th>
                                                        <th class="thpadding">
                                                            Name
                                                        </th>
                                                        <th class="thpadding">
                                                            Visit ID/Lab No
                                                        </th>
                                                        <th class="thpadding">
                                                            Test Name
                                                        </th>
                                                        <th class="thpadding">
                                                            Department
                                                        </th>
                                                        <th class="a-left">
                                                            Register Location
                                                        </th>
                                                        <th class="a-left">
                                                            Processed Location
                                                        </th>
                                                        <th class="a-left">
                                                            Client Name
                                                        </th>
                                                        <th class="a-left">
                                                            Ordered Time
                                                        </th>
                                                        <th class="a-left">
                                                            Collected Time
                                                        </th>
                                                        <th class="a-left">
                                                            Transfered Time
                                                        </th>
                                                        <th class="a-left">
                                                            Transferedby
                                                        </th>
                                                        <th class="a-left">
                                                            Received Time
                                                        </th>
                                                        <th class="a-left">
                                                            Receivedby
                                                        </th>
                                                        <th class="a-left">
                                                            Transit Time
                                                        </th>
                                                        <th class="a-left">
                                                            Values Entered Time
                                                        </th>
                                                        <th class="a-left">
                                                            Values Entered by
                                                        </th>
                                                        <th class="a-left">
                                                            Completed Time
                                                        </th>
                                                         <th class="a-left">
                                                            Completed by
                                                        </th>
                                                        <th header="ValidatedTime" class="a-left">
                                                            Validated Time
                                                        </th>
                                                        <th header="Validatedby" class="a-left">
                                                            Validated by
                                                        </th>
                                                         <th header="CoAuthorizedTime" class="a-left">
                                                            Coauthorized Time
                                                        </th>
                                                         <th header="CoAuthorizedby" class="a-left">
                                                            Coauthorized by
                                                        </th>
                                                        <th class="a-left">
                                                            Approved Time
                                                        </th>
                                                         <th class="a-left">
                                                            Approved by
                                                        </th>
                                                       
                                                        <th class="a-left">
                                                            Status
                                                        </th>
                                                        <th class="a-left">
                                                            Expected TAT
                                                        </th>
                                                        <th class="a-left">
                                                            Actual TAT
                                                        </th>
                                                        <th class="a-left">
                                                            Elasped Time
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
    <asp:HiddenField ID="hdnCoAuth" runat="server" Value="Y" />
    <asp:HiddenField ID="hdnValidateTime" runat="server" Value="Y" />
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript">       

        function Valiadte() {
            var iatrue = true;
            if ($("#txtFDate").val() == "") {
                alert('From Date is empty.');
                iatrue = false;
            }
            else if ($("#txtTDate").val() == "") {
                alert('To Date is empty.');
                iatrue = false;
            }
            return iatrue;
        }

        $(function() {
        $("#txtFDate").datetimepicker({
        dateFormat: 'dd/mm/yy',
        timeFormat: "hh:mm:ss tt",
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                buttonImageOnly: true,
                maxDate: 0,
               
                
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                $("#txtTDate").datetimepicker("option", "minDate", selectedDate);

                var date = $("#txtFDate").datetimepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTDate").datetimepicker({
            dateFormat: 'dd/mm/yy',
            timeFormat: "hh:mm:ss tt",
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../StyleSheets/start/images/calendar.gif",
                buttonImageOnly: true,
                maxDate: 0,
               
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                $("#txtFDate").datetimepicker("option", "maxDate", selectedDate);
                }
            })
        });


        function GetResult() {
            //debugger;
            try {
                if (Valiadte()) {
                    var pop = $find("mdlPopup");
                    pop.show();
                    $('#statusProgess').show();
                    var Location = $('#ddlLocation').val();
                    var FromDate = $('#txtFDate').val();
                    var ToDate = $('#txtTDate').val();
                    var Dept = $('#ddlDepartment').val();
                    var OrgID = $('#hdnOrgID').val();

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetTATMISReport",
                    contentType: "application/json; charset=utf-8",
                    // data: "{ Orgid: '" + Orgid + "',Location: '" + Location + "',VisitType: " + VisitType + "}",
                    //  data: JSON.stringify({ pFromDate: FromDate, ToDate: ToDate, pOrgID: OrgID, LocationID: Location, DeptID: Dept }),
                    dataType: "json",
                    data: "{ pFromDate: '" + FromDate + "',pToDate: '" + ToDate + "',pOrgID: '" + OrgID + "',LocationID: '" + Location + "',DeptID: '" + Dept + "'}",
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
            // debugger;
            $('#TATMISReport').show();
            var cssClass="";
           var validTime= $("#hdnValidateTime").val();
           if (validTime == "N") {
               $('table th[header = "ValidatedTime"]').addClass('hide_Column');
               $('table th[header = "Validatedby"]').addClass('hide_Column');
               cssClass = "hide_Column";
           }
           else {
               $('table th[header = "ValidatedTime"]').removeClass('hide_Column');

               $('table th[header = "Validatedby"]').removeClass('hide_Column'); 
            }

           var CoAuthCSSClass = "";

           var CoAuthTime = $("#hdnCoAuth").val();
           if (CoAuthTime == "N") {
               $('table th[header = "CoAuthorizedTime"]').addClass('hide_Column');
               $('table th[header = "CoAuthorizedby"]').addClass('hide_Column');
               CoAuthCSSClass = "hide_Column";
           }
           else {
               $('table th[header = "CoAuthorizedTime"]').removeClass('hide_Column');
               $('table th[header = "CoAuthorizedby"]').removeClass('hide_Column');
            }

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
//               "scrollY": "100px",
//                                     "scrollX": true,
              "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                                { "mDataProp": "SNo" },
                                { "mDataProp": "PatientNumber" },
                                { "mDataProp": "PatientName" },
                                { "mDataProp": "VisitNumber" },
                                { "mDataProp": "TestName" },
                                { "mDataProp": "DeptName" },
                                { "mDataProp": "RegisterLocation" },
                                { "mDataProp": "ProcessedLocation" },
                                 { "mDataProp": "ClientName" },                                 
                                { "sTitle": "OrderedTime", "mDataProp": "OrderedTime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                 { "sTitle": "CollectedDateTime", "mDataProp": "CollectedDateTime",
                                     "mRender": function(data, type, full) {
                                         return '<label ID="dtme1">' + GetCorrectdate(data) + '</label>';
                                     }
                                 },                               
                                { "sTitle": "TransferedDatetime", "mDataProp": "TransferedDatetime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme2">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                  { "mDataProp": "Transferedby" },
                                { "sTitle": "ReceivedDatetime", "mDataProp": "ReceivedDatetime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme3">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                { "mDataProp": "Receivedby" },
                                { "mDataProp": "Transittime" },                               
                              
                                { "sTitle": "ValuesEnteredtime", "mDataProp": "ValuesEnteredtime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme5">' + GetCorrectdate(data) + '</label>';
                                    }
                                }, 
                                 { "mDataProp": "ValuesEnteredby" },
                                { "sTitle": "CompletedTime", "mDataProp": "CompletedTime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme5">' + GetCorrectdate(data) + '</label>';
                                    }
                                }, 
                                  { "mDataProp": "Completedby" },
                               
                                 { "sTitle": "ValidatedTime", "mDataProp": "ValidatedTime",
                                     "mRender": function(data, type, full) {
                                         return '<label ID="dtme6">' + GetCorrectdate(data) + '</label>';
                                     }
                                 },
                                { "mDataProp": "Validatedby",
                                    "sClass": cssClass
                                },
                                { "sTitle": "CoauthorizedTime", "mDataProp": "CoauthorizedTime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme7">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                  { "mDataProp": "Coauthorizedby", "sClass": CoAuthCSSClass },
                                { "sTitle": "ApprovedTime", "mDataProp": "ApprovedTime",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme8">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                 { "mDataProp": "Approvedby" },                              
                                { "mDataProp": "Status" },
                                { "sTitle": "ExpectedTAT", "mDataProp": "ExpectedTAT",
                                    "mRender": function(data, type, full) {
                                        return '<label ID="dtme9">' + GetCorrectdate(data) + '</label>';
                                    }
                                },
                                 { "sTitle": "ActualTAT", "mDataProp": "ActualTAT",
                                     "mRender": function(data, type, full) {
                                         return '<label ID="dtme10">' + GetCorrectdate(data) + '</label>';
                                     }
                                 },
                                { "mDataProp": "ElaspedTime" },
                                ],
                    "sPaginationType": "full_numbers",
                    "sZeroRecords": "No records found",
                    "bSort": true,
                    "bJQueryUI": true,
                    "iDisplayLength": 30,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        aButtons: [
    { sExtends: "csv",
        sFileName: 'TATMISREPORT.csv',
        sFieldSeperator: "," //<--- example of how to set the delimiter
    },
    { sExtends: "xls",
        sFileName: 'TATMISREPORT.xls'
    },
    { sExtends: "pdf",
        sFileName: 'TATMISREPORT.pdf'
    }
]

                    }


                });
                $('#ReportDetails').show();
                $('#statusProgess').hide();
                pop.hide();
            }
            else {
                alert('No Records Found');
                $('#ReportDetails').hide();
                $('#statusProgess').hide();
                pop.hide();
                $('#TATMISReport').hide();
            }

            return false;
        }
        
    </script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {
            var AlertType = SListForAppMsg.Get("Reports_TATReport_aspx_01") == null ? "Alert" : SListForAppMsg.Get("Reports_TATReport_aspx_01");
            var from = SListForAppMsg.Get("Reports_TATReport_aspx_02") == null ? "Select From Date!!!" : SListForAppMsg.Get("Reports_TATReport_aspx_02");
            var to = SListForAppMsg.Get("Reports_TATReport_aspx_03") == null ? "Select To Date!!!'" : SListForAppMsg.Get("Reports_TATReport_aspx_03");

            if (document.getElementById('txtFDate').value == '')
             {
                 ValidationWindow(from, AlertType);
              //  alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                // alert('Provide / select value for To date');
                ValidationWindow(to, AlertType);
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
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
