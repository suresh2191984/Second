<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagePackageSequence.aspx.cs" Inherits="Admin_ManagePackageSequence" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>Manage Packages</title>
    <style type="text/css">
        .mytable1 td, .mytable1 th
        {
            border: 1px solid #686868;
            border-bottom: 1px solid #686868;
        }
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .mediumList
        {
            min-width: 330px;
        }
        .bigList
        {
            min-width: 800px;
        }
        .listMain
        {
            min-height: 0px;
        }
        h1, h2, h3, h4, h5, h6
        {
            margin: 10px 0;
            font-family: inherit;
            font-weight: bold;
            line-height: 1;
            color: inherit;
            text-rendering: optimizelegibility;
        }
        h1 small, h2 small, h3 small, h4 small, h5 small, h6 small
        {
            font-weight: normal;
            line-height: 1;
            color: #999999;
        }
        h1
        {
            font-size: 36px;
            line-height: 40px;
        }
        h2
        {
            font-size: 30px;
            line-height: 40px;
        }
        h3
        {
            font-size: 24px;
            line-height: 40px;
        }
        h4
        {
            font-size: 18px;
            line-height: 20px;
        }
        h5
        {
            font-size: 14px;
            line-height: 20px;
        }
        h6
        {
            font-size: 12px;
            line-height: 20px;
        }
        h1 small
        {
            font-size: 24px;
        }
        h2 small
        {
            font-size: 18px;
        }
        h3 small
        {
            font-size: 14px;
        }
        h4 small
        {
            font-size: 14px;
        }
        .close
        {
            float: right;
            font-size: 20px;
            font-weight: bold;
            line-height: 20px;
            color: #000000;
            text-shadow: 0 1px 0 #ffffff;
            opacity: 0.2;
            filter: alpha(opacity=20);
        }
        .close:hover
        {
            color: #000000;
            text-decoration: none;
            cursor: pointer;
            opacity: 0.4;
            filter: alpha(opacity=40);
        }
        button.close
        {
            padding: 0;
            cursor: pointer;
            background: transparent;
            border: 0;
            -webkit-appearance: none;
        }
        .modal-backdrop
        {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1040;
            background-color: #000000;
        }
        .modal-backdrop.fade
        {
            opacity: 0;
        }
        .modal-backdrop, .modal-backdrop.fade.in
        {
            opacity: 0.8;
            filter: alpha(opacity=80);
        }
        .modal
        {
            font-family: "Helvetica Neue" , Helvetica, Arial, sans-serif;
            font-size: 14px;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 1050;
            margin: -250px 0 0 -280px;
            overflow: auto;
            color: #333333;
            padding: 3px;
            background-color: #e0ebf5;
            border: 1px solid #999;
            border: 1px solid rgba(0, 0, 0, 0.3); *border:1pxsolid#999;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-webkit-box-shadow:03px7pxrgba(0, 0, 0, 0.3);-moz-box-shadow:03px7pxrgba(0, 0, 0, 0.3);box-shadow:03px7pxrgba(0, 0, 0, 0.3);-webkit-background-clip:padding-box;-moz-background-clip:padding-box;background-clip:padding-box;}
        .modal-header
        {
            padding: 9px 15px;
            border-bottom: 1px solid #eee;
        }
        .modal-header .close
        {
            margin-top: 2px;
        }
        .modal-header h3
        {
            margin: 0;
            line-height: 30px;
        }
        .modal-body
        {
            max-height: 400px;
            padding: 15px;
            overflow-y: auto;
        }
        .modal-form
        {
            margin-bottom: 0;
        }
        .modal-footer
        {
            padding: 14px 15px 15px;
            margin-bottom: 0;
            text-align: right;
            background-color: #e0ebf5;
            color: #333333;
            border-top: 1px solid #ddd;
            -webkit-border-radius: 0 0 6px 6px;
            -moz-border-radius: 0 0 6px 6px;
            border-radius: 0 0 6px 6px; *zoom:1;-webkit-box-shadow:inset01px0#ffffff;-moz-box-shadow:inset01px0#ffffff;box-shadow:inset01px0#ffffff;}
        .modal-footer:before, .modal-footer:after
        {
            display: table;
            line-height: 0;
            content: "";
        }
        .modal-footer:after
        {
            clear: both;
        }
        .modal-footer .btn + .btn
        {
            margin-bottom: 0;
            margin-left: 5px;
        }
        .modal-footer .btn-group .btn + .btn
        {
            margin-left: -1px;
        }
        fieldset
        {
            border: 1px solid green;
            padding: 5px;
            text-align: left;
        }
        legend
        {
            margin-bottom: 0px;
            margin-left: 5px;
            padding: 1px;
            font-size: 12px;
            font-weight: bold;
            color: White;
            text-align: right;
            background-color: #2C88B1;
        }
        .poplistMain
        {
            visibility: hidden;
        }
        .managepackageScroll
        {
            overflow-y: scroll;
            max-height: 380px;
            min-height:223px;
            display: block;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="600">
            </asp:ScriptManager>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                      <table class="searchPanel w-100p">
                      <tr>
                      <td>
                       <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                            margin-top: -32px; display: block; z-index: 9999;" align="center">
                                            Loading...<br />
                                            <br />
                                            <img src="../Images/loader.gif" alt="" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <div class="container">
                                    <div class="floatLeft">
                                        <table class="a-right w-80p">
                                            <tr class="w-50p">
                                                <td class="w-30p a-left">
                                                    <asp:Label ID="lblpacname" runat="server" Text="Package Name"></asp:Label>
                                                </td>
                                                <td class="w-30p a-left">
                                                    <asp:TextBox ID="txtpackagename" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label2" runat="server" Text="Remarks"> </asp:Label>
                                                </td>
                                                <td class="w-30p a-left">
                                                    <asp:TextBox ID="txtremarks" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label1" runat="server" Text="Status"> </asp:Label>
                                                </td>
                                                <td class="a-left w-30p">
                                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="ddloptiontask">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblCutoffTime" Text="Processing Time" runat="server" meta:resourcekey="lblCutoffTimeResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtCutOffValue" runat="server" MaxLength="2" Width="50px" CssClass="Txtboxsmall"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    meta:resourcekey="txtCutOffValueResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList runat="server" Width="75px" ID="ddlCutOffType" CssClass="ddl" meta:resourcekey="ddlCutOffTypeResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblGender1" runat="server" meta:resourcekey="lblGenderResource1" Text="Gender"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlGender1" runat="server" CssClass="ddl" Width="80px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTestCategory" runat="server" Text="Discount Category" Visible="false"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTestCategory" runat="server" CssClass="ddl" Width="100px" Visible="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblScheduleType" runat="server" Text="Schedule Type"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlScheduleType" runat="server" CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <%--  <tr>
                                                <td align="left">
                                                    <asp:Label ID="lblServiceTaxable" runat="server" meta:resourcekey="lblServiceTaxableResource1"
                                                        Text="ServiceTaxable"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:CheckBox ID="chkServiceTax" runat="server" meta:resourcekey="chkServiceTaxResource1"
                                                        TextAlign="Left" />
                                                </td>
                                            </tr>
                                            <tr id="IsOptionalTestDiv" runat="server">
                                                <td align="left">
                                                    <asp:Label ID="lblIsOptionalTest" runat="server" Text="Is Optional Test"> </asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:CheckBox ID="chkIsOptionalTest" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:Label ID="lblPrintSeparately" runat="server" Text="Print Separately"> </asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:CheckBox ID="chkPrintSeparately" runat="server" />
                                                    <asp:Button ID="btnsave" runat="server" CssClass="btn" OnClick="btnsave_Click" OnClientClick="javascript:return validate()"
                                                        Text="Add" Width="80px" />
                                                    <input id="testNameHDN" runat="server" type="hidden" />
                                                </td>
                                            </tr>--%>
                                        </table>
                                    </div>
                                    <div class="floatRight">
                                        <table class="a-left w-40p">
                                            <tr>
                                                <td class="a-left">
                                                 <asp:CheckBox ID="chkServiceTax" runat="server" meta:resourcekey="chkServiceTaxResource1"
                                                        TextAlign="Left" />
                                                    <asp:Label ID="lblServiceTaxable" Width="180px" runat="server" meta:resourcekey="lblServiceTaxableResource1"
                                                        Text="ServiceTaxable"></asp:Label>
                                                   
                                                </td>
                                            </tr>
                                            <tr id="IsOptionalTestDiv" runat="server" visible="false">
                                                <td class="a-left" nowrap="nowrap">
                                                 <asp:CheckBox ID="chkIsOptionalTest" runat="server" />
                                                    <asp:Label ID="lblIsOptionalTest" Width="180px" runat="server" Text="Does The Package have optional test?"> </asp:Label>
                                                   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                <asp:CheckBox ID="chkPrintSeparately" runat="server" />
                                                    <asp:Label ID="lblPrintSeparately" Width="180px" runat="server" Text="Print Separately"> </asp:Label>
                                                    
                                                </td>
                                            </tr>
                                            <tr class="a-left">
                                                <td class="a-left">
                                                    <asp:GridView ID="grdInvCodingScheme" runat="server" AllowPaging="False" AutoGenerateColumns="False"
                                                        CellPadding="0" CellSpacing="0" CssClass="mytable1 bg-row" ForeColor="#333333" OnPageIndexChanging="grdInvCodingScheme_PageIndexChanging"
                                                        OnRowDataBound="grdInvCodingScheme_OnRowDataBound">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCodingSchemeNameMaster" runat="server" Text='<%# Eval("CodingSchemaName") %>'></asp:Label>
                                                                    <asp:Label ID="lblCodingSchemeNameMasterID" runat="server" Style="display: none"
                                                                        Text='<%# Eval("CodeTypeID") %>'></asp:Label>
                                                                    <asp:Label ID="lblCodeMasterID" runat="server" Style="display: none" Text='<%# Eval("CodeMasterID") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtCodingSchemeNameMaster" runat="server" CssClass="Txtboxsmall"
                                                                        Text='<%# Eval("CodeName") %>' Width="123px"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr class="a-left">
                                                <td class="a-left">
                                                    <asp:Button ID="btnsave" runat="server" CssClass="btn" OnClick="btnsave_Click" OnClientClick="javascript:return validate()"
                                                        Text="Add" Width="80px" />
                                                    <input id="testNameHDN" runat="server" type="hidden" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <%-- <div>--%>
                                <table class="w-100p bg-row">
                                    <tr>
                                        <td class="a-right w-20p">
                                            <asp:Label ID="lblsearchpkg" runat="server" Text="Search Package Name"></asp:Label>
                                        </td>
                                        <td class="a-center w-20p">
                                            <asp:TextBox ID="txtsearchpkg" CssClass="Txtboxsmall" AutoComplete="off" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="a-left w-30p">
                                            <asp:Button ID="btnsearch" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov'"
                                                            onmouseout="this.className='btn1'" OnClick="btnsearch_Click"
                                                Text="Search" Width="80px" />
                                           
                                        </td>
                                        <td class="w-30p a-right">
                                         <div id="ExportXL" runat="server">
                                                <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                    Font-Names="Verdana" Font-Size="9pt"> </asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                    meta:resourcekey="imgBtnXLResource1" Style="width: 16px" OnClick="ImageBtnExport_Click" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblResult" ForeColor="#000333" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="a-left w-100p">
                                        <td class="a-center">
                                            <asp:GridView ID="grdpackages" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p"
                                              DataKeyNames="OrgGroupID,DisplayText,Status,Remarks,Packagecode,PrintSeparately,CutOffTimeValue,CutOffTimeType,Gender,IsServicetaxable,SubCategory,IsTATrandom,IsOptionalTest"
                                                OnRowDataBound="grdpackages_RowDataBound" OnPageIndexChanging="grdpackages_PageIndexChanging"
                                                OnRowCommand="grdpackages_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                            <asp:Label runat="server" ID="lblOrgIDReflex" Visible="false" Text='<%#Bind("OrgGroupID") %>'></asp:Label>
                                                            <asp:Label runat="server" ID="lblDisplayTextReflex" Visible="false" Text='<%#Bind("DisplayText") %>'></asp:Label>
                                                            <asp:Label runat="server" ID="lblPackagecodeReflex" Visible="false" Text='<%#Bind("Packagecode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="8%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="OrgGroupID" HeaderText="Package ID" Visible="false" />
                                                    <asp:BoundField DataField="DisplayText" ItemStyle-HorizontalAlign="Left" HeaderText="Package Name" />
                                                    <asp:BoundField DataField="Packagecode" ItemStyle-HorizontalAlign="Left" HeaderText="Primary Code" />
                                                    <asp:BoundField DataField="Status" ItemStyle-HorizontalAlign="Left" HeaderText="Status" />
                                                    <asp:BoundField DataField="Remarks" ItemStyle-HorizontalAlign="Left" HeaderText="Remarks"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="CutOffTimeValue" ItemStyle-HorizontalAlign="Left" HeaderText="CutOffTimeValue"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="CutOffTimeType" ItemStyle-HorizontalAlign="Left" HeaderText="CutOffTimeType"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="General" ItemStyle-HorizontalAlign="Left" HeaderText="Gender"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="IsServicetaxable" ItemStyle-HorizontalAlign="Left" HeaderText="IsServicetaxable"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="IsTATrandom" ItemStyle-HorizontalAlign="Left" HeaderText="Random/Batch"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="PrintSeparately" ItemStyle-HorizontalAlign="Center" HeaderText="Print Separately"
                                                        Visible="false" />
                                                    <asp:BoundField DataField="IsOptionalTest" ItemStyle-HorizontalAlign="Center" HeaderText="Is Optional Test"
                                                        Visible="false" />
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <table class="mytable1 w-100p gridView">
                                                                <tr>
                                                                    <td class="w-50p">
                                                                        <asp:LinkButton ID="lnkshow" runat="server" Text="Show" CommandName="Mapping" CommandArgument='<%#Eval("OrgGroupID")+","+ Eval("DisplayText")+","+ Eval("Packagecode")%>'></asp:LinkButton>
                                                                    </td>
                                                                    <td class="w-50p">
                                                                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="w-100p">
                                                <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                    <td class="defaultfontcolor a-center">
                                                        <asp:Label ID="Label3" runat="server" Text="Page"></asp:Label>
                                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                        <asp:Label ID="Label4" runat="server" Text="Of"></asp:Label>
                                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                        <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                                        <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                        <asp:Label ID="Label5" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                                        <asp:TextBox ID="txtpageNo" runat="server" Width="30px"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                            AutoComplete="off"></asp:TextBox>
                                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                            OnClientClick="javascript:return validatePageNumber();" />
                                                        <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <Ajax:ModalPopupExtender ID="ModelPopPackageSearch" runat="server" TargetControlID="btnR"
                                                            PopupControlID="pnlUserMaster" BackgroundCssClass="modalBackground" OkControlID="btnPnlClose"
                                                            DynamicServicePath="" Enabled="True" />
                                                        <asp:Panel ID="pnlUserMaster" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup w-80p"
                                                             Style="display: none; top: 400px; height: 500px">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <tr id="swapTR1" runat="server">
                                                                            <td id="Td1" class="v-top w-50p" runat="server">
                                                                                <asp:Table ID="healthPackagesTab" CssClass="dataheaderInvCtrl w-100p" runat="server">
                                                                                </asp:Table>
                                                                            </td>
                                                                            <td id="Td2" class="w-50p v-top" runat="server">
                                                                                <asp:Table ID="healthPackagesContentTab" runat="server" class="w-100p">
                                                                                </asp:Table>
                                                                                <input type="hidden" id="selectedPackage" runat="server" />
                                                                                <input id="hdntotalFinalPKG" runat="server" type="hidden" />
                                                                                <input id="collectedFinalINVGRP" runat="server" type="hidden" />
                                                                                <input id="collectedFinalSpeciality" runat="server" type="hidden" />
                                                                                <input id="collectedFinalProcedure" runat="server" type="hidden" />
                                                                                <input id="collectedFinalHealthCheckUp" runat="server" type="hidden" />
                                                                                <input id="setDefaultPKG" runat="server" type="hidden" />
                                                                                <input id="setOrderedPKG" runat="server" type="hidden" />
                                                                                <input id="setOrderedPKGTemp" runat="server" type="hidden" />
                                                                                <input type="hidden" id="hdnpkgid" runat="server" />
                                                                                <asp:HiddenField ID="hdnaddedInvValue" runat="server" />
                                                                                <asp:HiddenField ID="hdnaddedGroupValue" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="swapTR2" runat="server" style="display: none;">
                                                                            <td id="Td3" colspan="2" runat="server">
                                                                                <table id="typeTab" class="dataheaderInvCtrl w-40p" runat="server" style="display: none;">
                                                                                    <tr id="Tr1" runat="server">
                                                                                        <td id="Td4" class="a-center w-30p" runat="server">
                                                                                            <b>Select Type</b>
                                                                                        </td>
                                                                                        <td id="Td5" runat="server">
                                                                                            <asp:DropDownList ID="ddlSelectType" onchange="javascript:setSelectedType();" runat="server">
                                                                                                <asp:ListItem Selected="True" Text="Lab Investigation" Value="Lab Investigation"></asp:ListItem>
                                                                                                <asp:ListItem Text="Consultation" Value="Consultation"></asp:ListItem>
                                                                                                <asp:ListItem Text="Treatment Procedure" Value="Treatment Procedure"></asp:ListItem>
                                                                                                <asp:ListItem Text="General Health Checkup" Value="General Health Checkup"></asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table id="invCtrlTab" runat="server" class="w-100p">
                                                                                    <tr id="Tr2" runat="server">
                                                                                        <td id="Td6" runat="server">
                                                                                            <uc1:InvestigationControl ID="InvestigationControl1" runat="server" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <asp:HiddenField ID="Hdn" runat="server" />
                                                                                <asp:HiddenField ID="Hdnfld" runat="server" />
                                                                                <table id="specialityTab" style="display: none;" runat="server" class="w-100p">
                                                                                    <tr id="Tr3" runat="server">
                                                                                        <td id="Td7" runat="server">
                                                                                            <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="Tr4" runat="server">
                                                                                        <td id="Td8" runat="server">
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td class="v-top w-50p">
                                                                                                        <asp:ListBox ID="listSpeciality" runat="server" onkeypress="javascript:setItemS(event,this);"
                                                                                                            ondblClick="javascript:onClickAddSpeciality();" Width="350px" Height="150px">
                                                                                                        </asp:ListBox>
                                                                                                    </td>
                                                                                                    <td class="v-top w-50p">
                                                                                                        <input type="hidden" id="hdnSpecialityItems" runat="server"></input>
                                                                                                        <table id="tblSpecialityItems" runat="server" class="dataheaderInvCtrl w-100p">
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table id="procedureTab" style="display: none;" runat="server" class="w-100p">
                                                                                    <tr id="Tr5" runat="server">
                                                                                        <td id="Td9" runat="server">
                                                                                            <asp:Label ID="lblProcedure" runat="server" Text="Procedure"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="Tr6" runat="server">
                                                                                        <td id="Td10" runat="server">
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td class="v-top w-50p">
                                                                                                        <asp:ListBox ID="listProcedure" runat="server" onkeypress="javascript:setItemP(event,this);"
                                                                                                            ondblClick="javascript:onClickAddProcedure();" Width="350px" Height="100px">
                                                                                                        </asp:ListBox>
                                                                                                    </td>
                                                                                                    <td sclass="v-top w-50p">
                                                                                                        <input type="hidden" id="hdnProcedureItems" runat="server"></input>
                                                                                                        <table id="tblProcedureItems" runat="server" class="dataheaderInvCtrl w-100p">
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table id="HealthCheckupTab" style="display: none;" runat="server" class="w-100p">
                                                                                    <tr id="Tr7" runat="server">
                                                                                        <td id="Td11" runat="server">
                                                                                            <asp:Label ID="lblSpecialiType" runat="server" Text="Speciality Type"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="Tr8" runat="server">
                                                                                        <td id="Td12" runat="server">
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td class="v-top w-50p">
                                                                                                        <asp:ListBox ID="listHealthCheckup" runat="server" onkeypress="javascript:setItemHealthCheckup(event,this);"
                                                                                                            ondblClick="javascript:onClickAddHealthCheckup();" Width="350px" Height="150px">
                                                                                                        </asp:ListBox>
                                                                                                    </td>
                                                                                                    <td class="v-top w-50p">
                                                                                                        <input type="hidden" id="hdnHealthCheckupItems" runat="server"></input>
                                                                                                        <input type="hidden" id="hdnupdatevalue" runat="server"></input>
                                                                                                        <input type="hidden" id="hdnupdatevalueType" runat="server"></input>
                                                                                                        <input type="hidden" id="hdnCheckGridItemsExistsorNot" runat="server"></input>
                                                                                                        <table id="tblHealthCheckupItems" runat="server" border="0" cellpadding="4" cellspacing="0"
                                                                                                            class="dataheaderInvCtrl w-100p">
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table  class="w-100p">
                                                                                    <tr>
                                                                                        <td class="a-center">
                                                                                            <asp:HyperLink ID="hypLnkFinish" runat="server" Style="cursor: pointer;" Text="Add Contents to Package"
                                                                                                Font-Bold="True" Font-Underline="True" Font-Size="14px" onclick="javascript:return showHideSwapBlock();"></asp:HyperLink>
                                                                                            <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClose()" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-right" id="pnlclose" runat="server" style="display: none">
                                                                                <asp:Button ID="btnPnlClose" runat="server" class="btn" Text="Close" />
                                                                            </td>
                                                                        </tr>
                                                            </table>
                                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                <ProgressTemplate>
                                                                    <div id="progressBackgroundFilter">
                                                                    </div>
                                                                    <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                                                        margin-top: -32px; display: block; z-index: 9999;" align="center">
                                                                        Loading...<br />
                                                                        <br />
                                                                        <img src="../Images/loader.gif" alt="" />
                                                                    </div>
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
                                                            <table class="w-100p">
                                                                <tr runat="server" id="submitTab">
                                                                    <td class="a-center">
                                                                        <asp:Button ID="btnFinish" runat="server" OnClientClick="return SaveDeletedItems()"
                                                                            OnClick="btnFinish_Click" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" />
                                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" CommandName="Clear" OnClientClick="return popupClose()" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblExtraSamples" runat="server">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblExtraTube" runat="server" Text="Select Extra Tubes for this Package"
                                                                            Font-Bold="true" Font-Underline="true" Style="display: none;"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBoxList ID="chklstExtraSamples" runat="server" RepeatDirection="Vertical">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                            <input type="button" id="btnR" runat="server" style="display: none;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <Ajax:ModalPopupExtender ID="ModalPopupExtenderContentReflex" runat="server" TargetControlID="btnref"
                                                            PopupControlID="pnlOthers" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                                            BehaviorID="mpe" Enabled="True" />
                                                        <asp:Panel ID="pnlOthers" runat="server" CssClass="modalPopup dataheaderPopupdup"
                                                            Style="display: none; max-height: 900px; width: 850px; position: fixed">
                                                            <table class="panel1Table w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <%--<Ajax:ModalPopupExtender ID="ModalPopupExtenderContentReflex" runat="server" TargetControlID="BtnNew"
                                                            PopupControlID="Panl1" CancelControlID="Button2">
                                                        </Ajax:ModalPopupExtender>
                                                        <asp:Panel ID="Panl1" runat="server" Width="65%" Style="display: none; position: relative;
                                                            height: 150px;">--%>
                                                                        <%--<Mpcr:Reflex ID="Reflex1" runat="server" />--%>
                                                                        <%-- <iframe style="width: 900px; height: 700px;" id="irm1" src="ManagePackageContentandReflex.ascx"
                                                                runat="server"></iframe>--%>
                                                                        <%--<asp:Button ID="Button2" runat="server" Text="Close" OnClientClick="return popupClose()" />
                                                        </asp:Panel>--%>
                                                                        <Ajax:TabContainer ID="tabNew" runat="server" ActiveTabIndex="0">
                                                                            <Ajax:TabPanel ID="Createtab" runat="server" HeaderText="Manage Package Content">
                                                                                <HeaderTemplate>
                                                                                    <asp:Label ID="lblCreatePackageContent" runat="server" Text="Manage Package Content"
                                                                                        Font-Names="Verdana" Font-Size="9pt"></asp:Label>
                                                                                </HeaderTemplate>
                                                                                <ContentTemplate>
                                                                                    <asp:UpdatePanel ID="updpnlpackagecontent" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                                                <ProgressTemplate>
                                                                                                    <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                                                                                        margin-top: -32px; display: block; z-index: 9999;" align="center">
                                                                                                        Loading...<br />
                                                                                                        <br />
                                                                                                        <img src="../Images/loader.gif" alt="" />
                                                                                                    </div>
                                                                                                </ProgressTemplate>
                                                                                            </asp:UpdateProgress>
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <table>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <asp:Label runat="server" ID="lblPackageName" Text="Package Name :"></asp:Label>
                                                                                                                    <asp:Label runat="server" ID="lblPackageNameText" Text=""></asp:Label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:Label runat="server" ID="lblPackageCode" Text="Package Code :"></asp:Label>
                                                                                                                    <asp:Label runat="server" ID="lblPackageCodeText" Text=""></asp:Label>
                                                                                                                    <asp:Label runat="server" ID="lblPackageId" Text="0" Visible="false"></asp:Label>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <table>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <asp:Label runat="server" ID="lblProfileContent" Text="Profile Contents"></asp:Label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:TextBox runat="server" ID="txtProfileContents" Wrap="true" CssClass="Txtboxsmall">                                                  
                                                                                                                    </asp:TextBox>
                                                                                                                    <Ajax:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtProfileContents"
                                                                                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                                                                        CompletionListCssClass="wordWheel poplistMain listMain box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetAutoPackageContentandRflex"
                                                                                                                        OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                                                    </Ajax:AutoCompleteExtender>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:CheckBox runat="server" ID="cbxReflexPage" Text="Reflex" />
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:CheckBox runat="server" ID="cbxReportable" Text="Reportable" Checked="true"
                                                                                                                        Enabled="false" Visible="false" />
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:Button ID="btnSaveGrid" runat="server" OnClick="btnSaveGrid_OnClick" Text="Add"
                                                                                                                        CssClass="btn" OnClientClick="return ValidateTextBox();" />
                                                                                                                    <asp:Button ID="btnPackageContentClear" runat="server" CssClass="btn" Text="Clear" OnClick="btnPackageContentClear_OnClick"
                                                                                                                        ></asp:Button>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <table style="overflow-y: scroll; max-height: 500px; width: 800px;">
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <div class="managepackageScroll">
                                                                                                                        <asp:GridView runat="server" ID="gvPackageContent" EmptyDataText="No records found!"
                                                                                                                            AllowPaging="false" AutoGenerateColumns="False" CellPadding="4" CssClass="gridView w-100p"
                                                                                                                            ForeColor="#333333" GridLines="None" OnRowCommand="gvPackageContent_OnRowCommand">
                                                                                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                                                                                                                            <Columns>
                                                                                                                                <asp:TemplateField HeaderText="Sno" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <%# Container.DataItemIndex+1 %>
                                                                                                                                        <asp:Label ID="lblSno" runat="server" Text='<%# Eval("OrgGroupID") %>' Visible="false"></asp:Label>
                                                                                                                                        <asp:Label ID="lblSeqNo" runat="server" Text='<%# Eval("SequenceNo") %>' Visible="false"></asp:Label>
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Code" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:Label ID="lblGrpInvCode" runat="server" Text='<%# Eval("GroupCode") %>'></asp:Label></ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:Label ID="lblPackageContentName" runat="server" Text='<%# Eval("DisplayText") %>'></asp:Label></ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Id" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:Label ID="lblCode" runat="server" Text='<%# Eval("OrgGroupID") %>' Visible="true"></asp:Label></ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:Label ID="lblPackageContentType" runat="server" Text='<%# Eval("Type") %>'></asp:Label></ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Reflex" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:CheckBox ID="cbxReflex" Enabled="false" runat="server" Checked='<%# bool.Parse(Eval("IsReflex").ToString() == "Y" ? "True": "False") %>' />
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Reportable" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:CheckBox ID="cbxReportable" runat="server" Enabled="false" Checked='<%# bool.Parse(Eval("IsReportable").ToString() == "Y" ? "True": "False") %>' />
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                               <%-- NO Need For SequenceNo Maintain Quantum_Malaysia ----%>
                                                                                                                                <asp:TemplateField HeaderText="Sequence" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                                            CommandName="UP" />
                                                                                                                                        <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                                                            CommandName="DOWN" /></ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="Left">
                                                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:Button ID="btnPackageContentUpdate" runat="server" Text="Update" CssClass="btn"
                                                                                                                                            OnClick="btnPackageContentUpdate_OnClick"></asp:Button>
                                                                                                                                        <asp:Button ID="btnPackageContentDelete" runat="server" Text="Delete" CssClass="btn"
                                                                                                                                            OnClick="gvPackageContentDelete_OnClick" OnClientClick="return confirm('Are you sure you want to delete this item?');">
                                                                                                                                        </asp:Button>
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                            </Columns>
                                                                                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                                                            <EditRowStyle BackColor="#999999" />
                                                                                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                                                        </asp:GridView>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Label runat="server" ID="lblExtarTubeForThisPackage" Text="Select extra tubes for this package"
                                                                                                            CssClass="Txtboxsmall" Font-Bold="true"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:CheckBoxList runat="server" ID="CbxExtraTubePackages" RepeatColumns="3" RepeatDirection="Horizontal">
                                                                                                        </asp:CheckBoxList>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                            <table class="w-100p">
                                                                                                <tr class="a-center">
                                                                                                    <td>
                                                                                                        <asp:Button ID="btnPackageContentSave" runat="server" CssClass="btn" Text="Save"
                                                                                                            OnClick="btnPackageContentSave_OnClick" />
                                                                                                        <asp:Button runat="server" ID="btnpopClose" Text="Close" CssClass="btn" OnClientClick="return HideModalPopup()" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </ContentTemplate>
                                                                            </Ajax:TabPanel>
                                                                            <Ajax:TabPanel ID="pnlCreateReflexRule" runat="server" HeaderText="Manage Reflex"
                                                                                Visible="false">
                                                                                <HeaderTemplate>
                                                                                    <asp:Label ID="lblManageReflex" runat="server" Text="Manage Reflex" Font-Names="Verdana"
                                                                                        Font-Size="9pt"></asp:Label>
                                                                                </HeaderTemplate>
                                                                                <ContentTemplate>
                                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                                            <ProgressTemplate>
                                                                                                <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                                                                                    margin-top: -32px; display: block; z-index: 9999;" align="center">
                                                                                                    Loading...<br />
                                                                                                    <br />
                                                                                                    <img src="../Images/loader.gif" alt="" />
                                                                                                </div>
                                                                                            </ProgressTemplate>
                                                                                        </asp:UpdateProgress>--%>
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Label runat="server" ID="lblHeaderTextManageReflex" Text="Vitamin Profile" CssClass="Txtboxsmall"
                                                                                                            Font-Bold="true"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </ContentTemplate>
                                                                            </Ajax:TabPanel>
                                                                        </Ajax:TabContainer>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                            <input type="button" id="btnref" runat="server" style="display: none;" />
                                        </td>
                                    </tr>
                                </table>
                                <table runat="server" id="tblCheckReflex" style="display: none; height: 800px;">
                                    <tr>
                                        <td>
                                            <table class="w-100p" style="height: 800px;">
                                                <tr>
                                                    <td>
                                                        <Ajax:ModalPopupExtender ID="mpeCheckRefelex" runat="server" TargetControlID="btnrefreflex"
                                                            PopupControlID="pnlCheckRefelex" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                                            BehaviorID="mpex" Enabled="True">
                                                        </Ajax:ModalPopupExtender>
                                                        <asp:Panel ID="pnlCheckRefelex" runat="server" CssClass="modalPopup dataheaderPopupdup"
                                                            Style="display: none; max-height: 500px; width: 600px; position: fixed">
                                                            <table class="panel1Table w-100p">
                                                                <tr class="a-center">
                                                                    <td>
                                                                        <asp:Label runat="server" ID="lblreflexText" Text=""></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="managepackageScroll">
                                                                            <asp:GridView ID="gvReflexItems" runat="server" AllowPaging="false" AutoGenerateColumns="False"
                                                                                CellPadding="4" EmptyDataText="No records found!" ForeColor="#333333" GridLines="None" CssClass="w-100p gridView">
                                                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Sno">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <%# Container.DataItemIndex+1 %>
                                                                                            <asp:Label ID="lblSno" runat="server" Text='<%# Eval("OrgGroupID") %>' Visible="false"></asp:Label>
                                                                                            <asp:Label ID="lblSeqNo" runat="server" Text='<%# Eval("SequenceNo") %>' Visible="false"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Code" Visible="false">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblGrpInvCodeRef" runat="server" Text='<%# Eval("GroupCode") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Name">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPackageContentNameRef" runat="server" Text='<%# Eval("DisplayText") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Id" Visible="false">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblCodeRef" runat="server" Text='<%# Eval("OrgGroupID") %>' Visible="true"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Type" Visible="false">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPackageContentTypeRef" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="">
                                                                                        <HeaderTemplate>
                                                                                            <asp:CheckBox ID="allchk" runat="server" onclick="SelectheaderCheckboxes(this);" />
                                                                                        </HeaderTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:CheckBox ID="cbxReflexRef" runat="server" Checked="false" onclick="Check_Click(this);" />
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                        <ItemTemplate>
                                                                                            <asp:CheckBox ID="cbxReportableRef" runat="server" Checked="true" />
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                <EditRowStyle BackColor="#999999" />
                                                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr class="a-center">
                                                                    <td>
                                                                        <asp:Button ID="btnSkip" runat="server" CssClass="btn" OnClientClick="return HideModalPopupReflexChecking()"
                                                                            Text="Skip" />
                                                                        <asp:Button ID="btnAddRef" runat="server" CssClass="btn" OnClick="btnAddReflexTestinvestigation_OnClick"
                                                                            OnClientClick="return findCheckBox(this);" Text="Add" />
                                                                        <input id="btnrefreflex" runat="server" style="display: none;" type="button" />
                                                                    </td>
                                                                </tr>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <%--  </div>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="ImageBtnExport" />
                            </Triggers>
                        </asp:UpdatePanel>
                      </td>
                      </tr>
                      </table>
                       
                    </div>
             <Attune:Attunefooter ID="Attunefooter" runat="server" />   
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnInvID" runat="server" />
    <asp:HiddenField ID="hdnInvName" runat="server" />
    <asp:HiddenField ID="hdnInvType" runat="server" />
    <asp:HiddenField ID="hdnSeqNo" runat="server" />
    <asp:HiddenField ID="txtconformmessageValue" runat="server" />

</form>
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function GetSpecialRated(id) {
            if (id != '') {
                document.getElementById('testNameHDN').value = id;
                document.getElementById('txtpackagename').disabled = true;
                document.getElementById('trchkbnd').style.display = 'block';
            }
        }
        function validate() {
            var value = document.getElementById('txtpackagename').value;
            // alert(value);
            var status = document.getElementById('ddlstatus').value;
            if (value.trim() == "") {
                alert('Enter the package name');
                return false;
            }
            else if (status.trim() == "") {
                alert('Select the status');
                return false;
            }
            //            var _temp = '';

            //            $('#grdInvCodingScheme tbody tr td input:text').each(function() {
            //                if ($(this)[0].value == '') {
            //                    _temp = 'set';
            //                }
            //            });
            //            if (_temp == 'set') {
            //                alert("Please Enter The Coding Scheme Names");
            //                _temp = '';
            //                return false;
            //            }


        }
        function validatePageNumber() {
            if (document.getElementById('txtpageNo').value == "") {
                return false;
            }
        }
        function showHidePKGContent(id) {
            if (document.getElementById('chk' + id).checked) {
                document.getElementById('rowHeader' + id).style.display = "block";
                document.getElementById('rowContent' + id).style.display = "block";
                document.getElementById('submitTab').style.display = 'block';
                document.getElementById('pnlclose').style.display = 'none';
            }
            else {
                document.getElementById('rowHeader' + id).style.display = "none";
                document.getElementById('rowContent' + id).style.display = "none";
                document.getElementById('submitTab').style.display = 'none';
                document.getElementById('pnlclose').style.display = 'block';
            }
            setOrderedPKG();
            return false;
        }
        function showHidePKG(id) {

            //alert(id);
            if (document.getElementById('chk' + id).checked) {
                //alert((document.getElementById(id)));
                var HidValue = document.getElementById('Hdn').value;
                var HidVal = document.getElementById('Hdnfld').value;
                //alert(document.getElementById('Hdn').value);
                var list = HidValue.split('^');
                if (document.getElementById('Hdn').value != "") {
                    document.getElementById('Hdn').value = '';
                    for (var count = 0; count < list.length; count++) {
                        if (list[count] != id) {
                            HidVal += list[count] + '^';
                            //document.getElementById('Hdnfld').value = HidVal;
                            document.getElementById('Hdn').value = HidVal;
                        }
                    }
                }
            }
            else {
                //alert("I");
                var HidValue = document.getElementById('Hdn').value;

                HidValue += id + '^';
                //alert(HidValue);
                document.getElementById('Hdn').value = HidValue;
            }
        }

        function showHideSwapBlock(id) {
            if (document.getElementById('swapTR1').style.display == "none") {
                document.getElementById('swapTR1').style.display = "block";
                document.getElementById('swapTR2').style.display = "none";
                LoadSpecialityItems();
                LoadProcedureItems();
                LoadHealthCheckupItems();
                if (document.getElementById('submitTab')) {
                    document.getElementById('submitTab').style.display = "block";
                }

                LoadOrdItems1();

                SetCollectedItems();
                //alert(chkDft);
                // document.getElementById('chkDft').checked;
                // var x = document.getElementById('PackageProfileControl_TabContainer1_tab2_selectedPackage').value;

                //            if ((document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedSpecialityItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + x).value != "")) {
                //                alert('PackageProfileControl_chkDefault' + x);
                //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "block";
                //            }
                //            else {
                //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "none";
                //            }

            }

            else if (document.getElementById('swapTR2').style.display == "none") {
                //alert(document.getElementById('hdnProcedureItems' + id).value);
                document.getElementById('hdnSpecialityItems').value = document.getElementById('hdnAddedSpecialityItems' + id).value;
                document.getElementById('hdnProcedureItems').value = document.getElementById('hdnAddedProcedureItems' + id).value;
                document.getElementById('InvestigationControl1_iconHid').value = document.getElementById('hdnAddedInvGRP' + id).value;
                document.getElementById('hdnHealthCheckupItems').value = document.getElementById('hdnAddedHealthCheckupItems' + id).value;

                if (document.getElementById('submitTab')) {
                    document.getElementById('submitTab').style.display = "none";

                }




                //        document.getElementById('submitTab').style.display = "block";
                document.getElementById('swapTR2').style.display = "block";
                document.getElementById('swapTR1').style.display = "none";
                document.getElementById('selectedPackage').value = id;
            }
            return false;
        }
        function setSelectedType() {
            if (document.getElementById('ddlSelectType').value == "Lab Investigation") {
                document.getElementById('invCtrlTab').style.display = "block";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "Consultation") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "block";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "Treatment Procedure") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "block";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "General Health Checkup") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "block";
            }
            return false;
        }


        function onClickAddSpeciality() {

            var obj = document.getElementById('listSpeciality');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var specialityValue = obj.options[obj.selectedIndex].value;
            var specialityText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblSpecialityItems').style.display = 'block';
            var HidValue = document.getElementById('hdnSpecialityItems').value;
            // alert(HidValue);
            var list = HidValue.split('^');
            if (document.getElementById('hdnSpecialityItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[1] != '') {
                        if (SpecialityList[0] != '') {
                            rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                        }
                        if (specialityValue != '') {
                            if (SpecialityList[1] == specialityValue) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                if (specialityValue != '') {
                    var row = document.getElementById('tblSpecialityItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = specialityValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                    document.getElementById('hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
                    //alert(document.getElementById('hdnSpecialityItems').value);
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (specialityValue != '') {
                    var row = document.getElementById('tblSpecialityItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = specialityValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                    document.getElementById('hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Consultation Already Added!");
            }
            //        alert(document.getElementById('hdnSpecialityItems').value);
            return false;
        }
        function ImgOnclickSpeciality(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnSpecialityItems').value;
            var list = HidValue.split('^');
            var newSpecialityList = '';
            if (document.getElementById('hdnSpecialityItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[0] != '') {
                        if (SpecialityList[0] != ImgID) {
                            newSpecialityList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnSpecialityItems').value = newSpecialityList;
            }
            if (document.getElementById('hdnSpecialityItems').value == '') {
                document.getElementById('tblSpecialityItems').style.display = 'none';
            }
        }
        function ImgOnclickSpeciality1(ImgID) {

            document.getElementById('collectedFinalSpeciality').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedSpecialityItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newSpecialityList = '';
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[0] != '') {
                        if (SpecialityList[0] != ImgID) {
                            newSpecialityList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = newSpecialityList;
                document.getElementById('collectedFinalSpeciality').value = newSpecialityList;
            }
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value == '') {
                document.getElementById('tblAddedSpecialityItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadSpecialityItems() {

            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).deleteRow();

                for (var j = 0; j < document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedSpecialityItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length);
            if (document.getElementById('ddlSelectType').value == "Lab Investigation") {
                document.getElementById('hdnSpecialityItems').value = document.getElementById('InvestigationControl1_iconHid').value;
                //document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('hdnSpecialityItems').value;
            }
            else {

                document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('hdnSpecialityItems').value;
            }
            //alert(document.getElementById('hdnSpecialityItems').value);
            var HidValue = document.getElementById('hdnAddedSpecialityItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('hdnAddedSpecialityItems' + selectPKG).value);
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var SpecialityList = list[count].split('~');
                    var row = document.getElementById('tblAddedSpecialityItems' + selectPKG).insertRow(0);
                    row.id = SpecialityList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickSpeciality1(" + parseInt(SpecialityList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = SpecialityList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + SpecialityList[2] + "</b> (Consultation)";
                }
                document.getElementById('tblAddedSpecialityItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('hdnSpecialityItems').value = "";
            while (document.getElementById('tblSpecialityItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblSpecialityItems').deleteRow();
                for (var j = 0; j < document.getElementById('tblSpecialityItems').rows.length; j++) {
                    document.getElementById('tblSpecialityItems').deleteRow(j);

                }
            }
        }
        function setItemS(e, ctl) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddSpeciality();
            }

        }
        function onClickAddProcedure() {

            // alert("H");
            var obj = document.getElementById('listProcedure');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var ProcedureValue = obj.options[obj.selectedIndex].value;
            var ProcedureText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblProcedureItems').style.display = 'block';
            var HidValue = document.getElementById('hdnProcedureItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnProcedureItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[1] != '') {
                        if (ProcedureList[0] != '') {
                            rwNumber = parseInt(parseInt(ProcedureList[0]) + parseInt(1));
                        }
                        if (ProcedureValue != '') {
                            if (ProcedureList[1] == ProcedureValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (ProcedureValue != '') {
                    var row = document.getElementById('tblProcedureItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    document.getElementById('hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
                    //alert(document.getElementById('hdnProcedureItems').value);
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (ProcedureValue != '') {
                    var row = document.getElementById('tblProcedureItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    document.getElementById('hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Consultation Already Added!");
            }
            //        alert(document.getElementById('hdnProcedureItems').value);
            return false;
        }
        function ImgOnclickProcedure(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnProcedureItems').value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('hdnProcedureItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnProcedureItems').value = newProcedureList;
            }
            if (document.getElementById('hdnProcedureItems').value == '') {
                document.getElementById('tblProcedureItems').style.display = 'none';
            }
        }
        function ImgOnclickProcedure1(ImgID) {

            document.getElementById('collectedFinalProcedure').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedProcedureItems' + selectPKG).value = newProcedureList;
                document.getElementById('collectedFinalProcedure').value = newProcedureList;
            }
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value == '') {
                document.getElementById('tblAddedProcedureItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadProcedureItems() {

            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedProcedureItems' + selectPKG).deleteRow(j);
                }

            }
            //alert(document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length);
            document.getElementById('hdnAddedProcedureItems' + selectPKG).value = document.getElementById('hdnProcedureItems').value;
            var HidValue = document.getElementById('hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('hdnAddedProcedureItems' + selectPKG).value);
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('tblAddedProcedureItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickProcedure1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Procedure)";

                }
                document.getElementById('tblAddedProcedureItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('hdnProcedureItems').value = "";
            while (document.getElementById('tblProcedureItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
                for (var j = 0; j < document.getElementById('tblProcedureItems').rows.length; j++) {
                    document.getElementById('tblProcedureItems').deleteRow(j);

                }
            }
        }

        function setItemP(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddProcedure();
            }

        }
        function LoadOrdItems1() {

            selectPKG = document.getElementById('selectedPackage').value;


            while (document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).rows.length > 0) {
                //document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).rows.length; j++) {
                    document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).deleteRow(j);
                }
            }


            //alert(document.getElementById('InvestigationControl1_iconHid').value);
            document.getElementById('hdnAddedInvGRP' + selectPKG).value = document.getElementById('InvestigationControl1_iconHid').value;
            var HidValue = document.getElementById('hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');

            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value != "") {

                // alert(HidValue);
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    var row = document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).insertRow(0);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick2(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    if (InvesList[2] == "INV") {
                        ext = " (Investigation)";
                    }

                    else {
                        ext = " (Group)";
                    }

                    document.getElementById('InvestigationControl1_iconHid').value = "";

                    while (document.getElementById('tblOrederedInves').rows.length > 0) {
                        //            document.getElementById('tblOrederedInves').deleteRow();
                        for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                            document.getElementById('tblOrederedInves').deleteRow(j);

                        }

                    }
                    cell2.innerHTML = "<b>" + InvesList[1] + "</b>" + ext;
                    cell3.innerHTML = InvesList[2];
                    cell3.style.display = "none";
                }
                document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).style.display = 'block';


            }
            document.getElementById('InvestigationControl1_iconHid').value = "";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {

                //document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);


                }

            }

            return false;
        }
        function ImgOnclick2(ImgID) {

            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById('collectedFinalINVGRP').value = '';
            document.getElementById(ImgID).style.display = "none";

            var HidValue = document.getElementById('hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');
            var newInvGRPList = '';
            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvGRPList = list[count].split('~');
                    if (InvGRPList[0] != '') {
                        if (InvGRPList[0] != ImgID) {
                            newInvGRPList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedInvGRP' + selectPKG).value = newInvGRPList;
                document.getElementById('collectedFinalINVGRP').value = newInvGRPList;
            }
            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value == '') {
                document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).style.display = 'none';
            }
        }

        function SetCollectedItems() {

            document.getElementById('collectedFinalINVGRP').value = "";
            document.getElementById('collectedFinalSpeciality').value = "";
            document.getElementById('collectedFinalProcedure').value = "";
            document.getElementById('collectedFinalHealthCheckUp').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                //                if (document.getElementById('chk' + pkgID[count]).checked) {
                //alert(document.getElementById('hdnAddedInvGRP').value);
                if (document.getElementById('hdnAddedInvGRP' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalINVGRP').value += pkgID[count] + "$" + document.getElementById('hdnAddedInvGRP' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedSpecialityItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalSpeciality').value += pkgID[count] + "-" + document.getElementById('hdnAddedSpecialityItems' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedProcedureItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalProcedure').value += pkgID[count] + "-" + document.getElementById('hdnAddedProcedureItems' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('hdnAddedHealthCheckupItems' + pkgID[count]).value + "|";
                }

            }
            //}
            //          alert(document.getElementById('collectedFinalINVGRP').value);
            //          alert(document.getElementById('collectedFinalSpeciality').value);
            //          alert(document.getElementById('collectedFinalProcedure').value);
            return false;
        }
        function setDefaultPKG() {
            document.getElementById('setDefaultPKG').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('chkDefault' + pkgID[count]).checked) {


                    document.getElementById('setDefaultPKG').value += pkgID[count] + "~";
                }
            }


            if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {

                document.getElementById('PackageProfileControl_collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value + "|";
            }
        }

        function setOrderedPKG() {
            document.getElementById('setOrderedPKG').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('chk' + pkgID[count]).checked) {
                    document.getElementById('setOrderedPKG').value += pkgID[count] + "~";
                }
            }
        }

        function onClickAddHealthCheckup() {
            var obj = document.getElementById('listHealthCheckup');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblHealthCheckupItems').style.display = 'block';
            var HidValue = document.getElementById('hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnHealthCheckupItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[1] != '') {
                        if (HealthCheckupList[0] != '') {
                            rwNumber = parseInt(parseInt(HealthCheckupList[0]) + parseInt(1));
                        }
                        if (HealthCheckupvalue != '') {
                            if (HealthCheckupList[1] == HealthCheckupvalue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('tblHealthCheckupItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                    document.getElementById('hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('tblHealthCheckupItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                    document.getElementById('hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Health Checkup Already Added!");
            }
            //        alert(document.getElementById('hdnHealthCheckupItems').value);
            return false;
        }
        function ImgOnclickHealthCheckup(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnHealthCheckupItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnHealthCheckupItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnHealthCheckupItems').value == '') {
                document.getElementById('tblHealthCheckupItems').style.display = 'none';
            }
        }


        function ImgOnclickHealthCheckup1(ImgID) {
            document.getElementById('collectedFinalHealthCheckUp').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value;

            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value = NewHealthCheckupList;
                document.getElementById('collectedFinalHealthCheckUp').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value == '') {
                document.getElementById('tblAddedHealthCheckupItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadHealthCheckupItems() {


            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedHealthCheckupItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblAddedHealthCheckupItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedHealthCheckupItems' + selectPKG).deleteRow(j);
                }

            }
            document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value = document.getElementById('hdnHealthCheckupItems').value;
            var HidValue = document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value);
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var HealthCheckupList = list[count].split('~');
                    var row = document.getElementById('tblAddedHealthCheckupItems' + selectPKG).insertRow(0);
                    row.id = HealthCheckupList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup1(" + parseInt(HealthCheckupList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupList[2] + "</b> (Health Checkup)";

                }
                document.getElementById('tblAddedHealthCheckupItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('hdnHealthCheckupItems').value = "";
            while (document.getElementById('tblHealthCheckupItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblHealthCheckupItems').deleteRow();

                for (var j = 0; j < document.getElementById('tblHealthCheckupItems').rows.length; j++) {
                    document.getElementById('tblHealthCheckupItems').deleteRow(j);

                }
            }

        }

        function setItemHealthCheckup(e, ctl) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddHealthCheckup();
            }

        }


        function chkonchange() {
            var tableBody = document.getElementById('PackageProfileControl_TabContainer1_tab1_chklistpackage').childNodes[0];
            //
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in group master');
                return false;
            }
        }
        function SaveDeletedItems() {
            SetCollectedItems();
            return true;
        }


        function popupClose() {
            return false;
        }

        function inputOnlyNumbers(evt) {
            var e = window.event || evt;
            var charCode = e.which || e.keyCode;
            if ((charCode > 47 && charCode < 58) || charCode == 8) {
                return true;
            }
            return false;
        }
        
    </script>

    <style type="text/css">
        .floatLeft
        {
            width: 40%;
            float: left;
        }
        .floatRight
        {
            width: 60%;
            float: right;
        }
        .container
        {
            overflow: hidden;
        }
        .panel1Table #Panl1
        {
            left: 0 !important;
            right: 0 !important;
            margin: auto !important;
            top: 50px !important;
        }
        .panel1Table .contentdata1
        {
            min-height: auto;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function SelectheaderCheckboxes(headerchk) {
            var gvcheck = document.getElementById("<%=gvReflexItems.ClientID%>");
            var i;
            //Condition to check header checkbox selected or not if that is true checked all checkboxes
            if (headerchk.checked) {
                for (i = 0; i < gvcheck.rows.length; i++) {
                    var inputs = gvcheck.rows[i].getElementsByTagName('input');
                    inputs[0].checked = true;
                }
            }
            //if condition fails uncheck all checkboxes in gridview
            else {
                for (i = 0; i < gvcheck.rows.length; i++) {
                    var inputs = gvcheck.rows[i].getElementsByTagName('input');
                    inputs[0].checked = false;
                }
            }
        }
        function Check_Click(objRef) {
            //Get the Row based on checkbox
            var row = objRef.parentNode.parentNode;

            //Get the reference of GridView
            var GridView = row.parentNode;

            //Get all input elements in Gridview
            var inputList = GridView.getElementsByTagName("input");

            for (var i = 0; i < inputList.length; i++) {
                //The First element is the Header Checkbox
                var headerCheckBox = inputList[0];

                //Based on all or none checkboxes
                //are checked check/uncheck Header Checkbox
                var checked = true;
                if (inputList[i].type == "checkbox" && inputList[i] != headerCheckBox) {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            headerCheckBox.checked = checked;
            return true;

        }
        function findCheckBox() {
            var gvDisplayCart = document.getElementById("<%=gvReflexItems.ClientID%>");
            var inputList = gvDisplayCart.getElementsByTagName("input");
            var numChecked = 0;

            for (var i = 0; i < inputList.length; i++) {
                if (inputList[i].type == "checkbox" && inputList[i].checked) {
                    numChecked = numChecked + 1;
                }
            }
            if (numChecked <= 0) {
                alert("Atleast select single reflex test!");
                $find("mpe").show();
                return false;
            }
            else {
                var testNameChild = "";
                var testNameParent = "";
                var gridView = document.getElementById("<%=gvReflexItems.ClientID%>");
                var checkBoxes = gridView.getElementsByTagName("input");
                var gridViewpackage = document.getElementById("<%=gvPackageContent.ClientID%>");
                var intRowCount = gridViewpackage.rows.length;
                if (intRowCount > 0) {
                    //Get Child Grid Content 
                    for (var i = 0; i < checkBoxes.length; i++) {
                        if (checkBoxes[i].type == "checkbox" && checkBoxes[i].checked) {
                            testNameChild = gridView.rows(i).cells(1).innerText;
                            //Get Parent Grid Content 
                            for (var j = 0; j < intRowCount; j++) {
                                var testNameParent = gridViewpackage.rows(j).cells(2).innerText;
                                if (testNameParent != "Name") {
                                    //Check if Exists Or Not Child and  Parent Grid Content 
                                    if (testNameChild.trim() == testNameParent.trim()) {
                                        alert('Reflex test is already mapped as primary investigation within content! Mapped content is:  ' + testNameChild);
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        function popupshow() {
            document.getElementById('pnlOthers').style.display = "block";
            document.getElementById('divOthers').style.display = "block";
            $('[id$="divOthers"]').show();
            return false;
        }
        function popupshowEvents() {
            document.getElementById('pnlOthers').style.display = "block";
            document.getElementById('divOthers').style.display = "block";
            $('[id$="divOthers"]').show();
            return true;
        }
        function closePopup() {
            document.getElementById('pnlOthers').style.display = "none";
            document.getElementById('divOthers').style.display = "none";
            $('[id$="divOthers"]').hide();
            return false;
        }
        function ValidateTextBox() {
            var btnValue = document.getElementById('<%=btnSaveGrid.ClientID%>').value;
            if (btnValue == "Add") {

                var profileResult = document.getElementById('<%=txtProfileContents.ClientID%>').value;
                var invNameResult = document.getElementById('<%=hdnInvName.ClientID%>').value;
                if (profileResult == "") {
                    alert("Please enter profile content name!");
                    document.getElementById("<%=txtProfileContents.ClientID%>").focus();
                    $find("mpe").show();
                    return false;
                }
                if (invNameResult == "") {
                    alert("Please provide valid profile content name!");
                    document.getElementById("<%=txtProfileContents.ClientID%>").focus();
                    document.getElementById("<%=txtProfileContents.ClientID%>").value = '';
                    $find("mpe").show();
                    return false;
                }
                if (profileResult != invNameResult) {
                    alert("Please provide valid profile content name!");
                    document.getElementById("<%=txtProfileContents.ClientID%>").focus();
                    document.getElementById("<%=txtProfileContents.ClientID%>").value = '';
                    $find("mpe").show();
                    return false;
                }
            }
            else {                
                return true;
            }
        }

        function AlertNoList() {          
            var selectedvalue = confirm("Reflex test is not mapped to any primary investigation within content, so the parent relfex test added as package content");
            if (selectedvalue == true) {
                document.getElementById('<%=txtconformmessageValue.ClientID %>').value = "Yes";
                return true;
            }
            else {
                document.getElementById('<%=txtconformmessageValue.ClientID %>').value = "No";
                return false;

            }
        }

        function HideModalPopup() {
            document.getElementById("<%=txtProfileContents.ClientID%>").value = '';
            $find("mpe").hide();
            return false;
        }
        function HideModalPopupReflexChecking() {
            $find("mpex").hide();
            $find("mpe").show();
            document.getElementById("<%=cbxReflexPage.ClientID%>").checked = false;
            return false;
        }
        function ClearShowModalPopup() {    
            document.getElementById("<%=txtProfileContents.ClientID%>").readOnly = false;
            document.getElementById("<%=txtProfileContents.ClientID%>").value = '';
            document.getElementById("<%=txtProfileContents.ClientID%>").focus();
            document.getElementById("<%=hdnInvID.ClientID%>").value = '';
            document.getElementById("<%=hdnInvType.ClientID%>").value = '';
            document.getElementById("<%=hdnInvName.ClientID%>").value = '';
            document.getElementById('hdnSeqNo').value = '';
            document.getElementById("<%=cbxReflexPage.ClientID%>").checked = false;
            document.getElementById("<%=btnSaveGrid.ClientID%>").value = 'Add';
            //$find("mpe").show();            
        }

        function IAmSelected(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var name;
            var SeqNo;
            var InvType;

            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        InvType = list[0];
                        ID = list[1];
                        name = list[2];
                        SeqNo = list[3];
                        document.getElementById('hdnInvType').value = InvType;
                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('hdnSeqNo').value = SeqNo;
                        if (InvType == "GRP") {

                            document.getElementById("<%=cbxReflexPage.ClientID%>").disabled = true;
                            document.getElementById("<%=cbxReflexPage.ClientID%>").checked = false;
                        }
                        else {
                            document.getElementById("<%=cbxReflexPage.ClientID%>").disabled = false;
                        }
                    }
                }
                var rowscount = $("#<%=gvPackageContent.ClientID %> tr").length;
                if (rowscount > 0) {
                    var table, tbody, i, rowLen, row, j, colLen, cell;
                    var profileResult = document.getElementById('hdnInvID').value;
                    table = document.getElementById("<%=gvPackageContent.ClientID%>");
                    tbody = table.tBodies[0];
                    for (i = 0, rowLen = tbody.rows.length; i < rowLen; i++) {
                        row = tbody.rows[i];
                        if (i >= 1) {
                            for (j = 0, colLen = row.cells.length; j < colLen; j++) {
                                cell = row.cells[j];
                                if (cell.innerText == profileResult) {
                                    alert('Mapping content already exists in package list.');
                                    document.getElementById('hdnInvType').value = '';
                                    document.getElementById('hdnInvID').value = '';
                                    document.getElementById('hdnInvName').value = '';
                                    document.getElementById('hdnSeqNo').value = '';
                                    document.getElementById('<%=txtProfileContents.ClientID%>').value = '';
                                    return false;

                                }
                            }
                        }
                    }

                }
            }
        }

        function CheckIsreflexINVorGRP(btnPackageContentUpdate) {
            var rowscount = $("#<%=gvPackageContent.ClientID %> tr").length;
            if (rowscount > 0) {
                var row = btnPackageContentUpdate.parentNode.parentNode;
                var type = row.cells[4].innerText;
                if (type == "GRP") {
                    alert("Not allow update for GRP content!");
                    return false;
                }
            }
        }
    </script>

    
</body>
</html>
