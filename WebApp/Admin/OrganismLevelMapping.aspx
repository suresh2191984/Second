<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrganismLevelMapping.aspx.cs"
    Inherits="Admin_OrganismLevelMapping" EnableEventValidation="false" Debug="true" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Organism Level Mapping</title>

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>

    <style type="text/css">
        .ths
        {
            color: Black;
            font-size: small;
            background-color: White !important;
        }
        .ui-helper-hidden-accessible
        {
            position: absolute;
            left: -9999px;
        }
        .ScrollStyle
        {
            max-height: 150px;
            overflow-y: scroll;
        }
        #divErrorDetails
        {
            margin: 20px 0;
        }
        .black_overlay
        {
            display: none;
            position: fixed;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1001;
            -moz-opacity: 0.8;
            opacity: .80;
            filter: alpha(opacity=80);
        }
        .white_content1
        {
            display: none;
            position: fixed;
            top: 22%;
            height: 50% !important;
            padding: 16px;
            border: none !important;
            background-color: white;
            z-index: 1002;
            width: 77% !important;
            left: 12% !important;
            border-radius: 10px;
        }
        #LnkHl7upload
        {
            padding-left: 15px;
        }
        /* The Modal (background) */.modal
        {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        /* Modal Content */.modal-content
        {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        /* The Close Button */.close
        {
            color: red;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }
        .close:hover, .close:focus
        {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        .btnsel
        {
            background-color: Transparent !important;
            color: Blue !important;
            border: none !important;
        }
        .header1
        {
            background-color: LightSlateGray;
            text-decoration: dotted;
            font-weight: bolder;
            color: white;
            height: 30px;
            text-align: -webkit-center;
            padding-top: 5px;
        }
        .modal-content
        {
            text-align: center;
            padding: 20px 0px;
            margin: auto;
            overflow: auto;
            word-break: break-all;
            max-height: 370px;
        }
        .lh60
        {
            line-height: 60px;
        }
        .marginT15
        {
            margin-top: 15px;
        }
        .marginB15
        {
            margin-bottom: 15px;
        }
        .Initial
        {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            background: url("../Images/InitialImage.png") no-repeat right top;
            color: Black;
            font-weight: bold;
        }
        .Initial:hover
        {
            color: White;
            background: url("../Images/SelectedButton.png") no-repeat right top;
        }
        .Clicked
        {
            float: left;
            display: block;
            background: url("../Images/SelectedButton.png") no-repeat right top;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
        }
        .bbb
        {
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 12px;
            width: 250px;
            font-weight: normal;
            line-height: 0.428571;
            text-align: left;
            height: 23px;
            text-align: left;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
            color: #333;
            background-color: #fff;
            border-color: #ccc;
            text-align: center;
        }
        .bth
        {
            border-style: None;
            background: transparent;
            color: white;
            font-size: small;
            font-weight: bold;
            padding-top: 10px;
        }
        .th:background-color
        {
            background-color: Black;
        }
    </style>
    <style type="text/css">
        .pagination-ys
        {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }
        .pagination-ys table > tbody > tr > td
        {
            display: inline;
        }
        .pagination-ys table > tbody > tr > td > a, .pagination-ys table > tbody > tr > td > span
        {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;
            color: #dd4814;
            background-color: #ffffff;
            border: 1px solid #dddddd;
            margin-left: -1px;
        }
        .pagination-ys table > tbody > tr > td > span
        {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;
            margin-left: -1px;
            z-index: 2;
            color: #aea79f;
            background-color: #f5f5f5;
            border-color: #dddddd;
            cursor: default;
        }
        .pagination-ys table > tbody > tr > td:first-child > a, .pagination-ys table > tbody > tr > td:first-child > span
        {
            margin-left: 0;
            border-bottom-left-radius: 4px;
            border-top-left-radius: 4px;
        }
        .pagination-ys table > tbody > tr > td:last-child > a, .pagination-ys table > tbody > tr > td:last-child > span
        {
            border-bottom-right-radius: 4px;
            border-top-right-radius: 4px;
        }
        .pagination-ys table > tbody > tr > td > a:hover, .pagination-ys table > tbody > tr > td > span:hover, .pagination-ys table > tbody > tr > td > a:focus, .pagination-ys table > tbody > tr > td > span:focus
        {
            color: #97310e;
            background-color: #eeeeee;
            border-color: #dddddd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" style="height: 100%;">
        <asp:UpdatePanel runat="server" ID="uPanel1" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="uPanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="UpdatePanel" runat="server">
                    <ContentTemplate>
                        <asp:Panel runat="server">
                            <div class="header1">
                                <ul>
                                    <li><a href="#">
                                        <asp:Button Text="Family Master" BorderStyle="None" CausesValidation="false" ID="tbFamilyMaster"
                                            CssClass="bth" runat="server" OnClick="tbFamilyMaster_Click" /></a></li>
                                    <li><a href="#">
                                        <asp:Button Text="Drug Master" BorderStyle="None" ID="tbDrugMaster" CausesValidation="false"
                                            CssClass="bth" runat="server" OnClick="tbDrugMaster_Click" /></a></li>
                                    <li><a href="#">
                                        <asp:Button Text="Organism Master" BorderStyle="None" ID="tbOrganismMaster" CausesValidation="false"
                                            CssClass="bth" runat="server" OnClick="tbOrganismMaster_Click" /></a></li>
                                    <li><a href="#">
                                        <asp:Button Text="Organism Mapping" BorderStyle="None" CausesValidation="false" ID="tbOrganismMapping"
                                            CssClass="bth" runat="server" OnClick="tbOrganismMapping_Click" /></a></li>
                                    <%--/* BEGIN | sabari | 20181129 | Dev | Culture Report */--%>
                                    <li><a href="#">
                                        <asp:Button Text="Level Mapping" BorderStyle="None" CausesValidation="false" ID="tbLevelMaster"
                                            CssClass="bth" runat="server" OnClick="tbLevelMapping_Click" /></a></li>
                                    <%--/* END | sabari | 20181129 | Dev | Culture Report */  --%>                                          
                                </ul>
                            </div>
                            <div class="bg-row padding10 w-100p">
                                <asp:MultiView ID="MainView" Visible="true" ActiveViewIndex="0" runat="server">
                                    <asp:View ID="TabPanel1" runat="server">
                                        <div class="bg-row padding10 w-80p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblFamilyName" runat="server" Text="Family Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFamilyName" runat="server" Style="width: 20%" runat="server"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblFamilyCode" runat="server" Text="Family Code"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFamilyCode" TabIndex="1" Style="width: 25%" runat="server"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblUploadMaster" runat="server" Text="Upload Bulk Master"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="fuFamilyBulkData" runat="server" />
                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fuFamilyBulkData"
                                                            Display="Dynamic" ErrorMessage="Please select file to upload."></asp:RequiredFieldValidator>--%>
                                                        <%--</td>
                                <td>--%>
                                                        <input type="reset" id="btnfamilyClear" tabindex="4" value="Clear" class="btn btn-small" />
                                                        <asp:Button ID="btnuploadFamily" runat="server" Text="Upload" CssClass="btn1 btn-medium"
                                                            OnClientClick="return ValidateFile('fuFamilyBulkData');" OnClick="btnuploadFamily_Click" />
                                                        <asp:ImageButton ID="ibFamilyDownload" runat="server" ImageUrl="../Images/download1.png"
                                                            OnClick="ibFamilyDownload_Click" CausesValidation="False" />
                                                        <asp:Image runat="server" ID="Image2" ImageUrl="~/Images/ExcelImage.GIF" />
                                                        <asp:Button ID="ibFamilyExportDownload" ImageAlign="Left" Style="border: none; background: none;
                                                            color: black; padding-left: 0px;" Text="Export to Excel" runat="server" OnClick="ibFamilyExportDownload_Click"
                                                            CausesValidation="False" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" style="padding-top: 15px" colspan="2">
                                                        <asp:Button ID="btnAdd" runat="server" CssClass="btn1 btn-medium" OnClientClick="return ValidateFamilyMaster();"
                                                            CausesValidation="False" Text="Save" OnClick="btnAdd_Click" />
                                                        <input id="btnClear" class="btn1 btn-small" tabindex="5" type="reset" value="Clear" />
                                                        <asp:HiddenField ID="hdnFamilyId" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divFamilyMaster" class="bg-row padding10 w-80p" style="height: 390px;">
                                            <asp:GridView ID="gvFamilyMaster" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                                                PagerStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast" ForeColor="#333333"
                                                OnPageIndexChanging="gvFamilyMaster_PageIndexChanging" OnRowDataBound="gvFamilyMaster_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                            <%--<asp:HiddenField ID="HDFamilyMasterId" Value='<%# bind("FamilyId") %>' runat="server" />--%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="FamilyName" HeaderText="Family Name">
                                                        <HeaderStyle Width="20%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FamilyCode" HeaderText="Family Code">
                                                        <HeaderStyle Width="20%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" CausesValidation="False" ID="btnFamilyEdit" Text="Edit"
                                                                OnClick="btnFamilyEdit_Click" />
                                                            <asp:LinkButton runat="server" CausesValidation="False" ID="btnFamilyInActive" Text="InActive"
                                                                OnClick="btnFamilyInActive_Click" />
                                                            <asp:HiddenField ID="HDFamilyMasterId" Value='<%# bind("FamilyId") %>' runat="server" />
                                                            <asp:HiddenField ID="HDFamilyMasterActive" Value='<%# bind("IsActive") %>' runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton runat="server" ID="btnFamilyHistory" Style="height: 30px;" CausesValidation="False"
                                                                ImageUrl="../Images/Hist2.png" OnClick="btnFamilyHistory_Click" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle Font-Bold="True" HorizontalAlign="Center" CssClass="pagination-ys" />
                                            </asp:GridView>
                                        </div>
                                        <div id="divFamilyMasterHistory" class="modal">
                                            <!-- Modal content -->
                                            <div class="modal-content">
                                                <div class="header">
                                                    <div class="lh60">
                                                        Family Master History
                                                    </div>
                                                </div>
                                                <div>
                                                    <br />
                                                    <asp:GridView ID="gvFamilyMasterHistory" CssClass="mytable1 w-100p gridView" runat="server"
                                                        EmptyDataText="History is not available" AutoGenerateColumns="False" AllowPaging="True"
                                                        ForeColor="#333333">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" Visible="False">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                    <asp:HiddenField ID="HDFamilyMasterId" Value='<%# bind("FamilyId") %>' runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="FamilyName" HeaderText="Family Name">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="FamilyCode" HeaderText="Family Code">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Description" HeaderText="Description">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="LangCode" HeaderText="Modified by ">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Modifiedat" HeaderText="Modified At">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </div>
                                                <div>
                                                    <input type="button" onclick="document.getElementById('divFamilyMasterHistory').style.display='none'"
                                                        class="close" value="Close" />
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="tpDrugMaster" runat="server">
                                        <div class="bg-row w-80p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDrugName" runat="server" Text="Drug Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDrugName" TabIndex="1" runat="server">
                                                        </asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        <asp:HiddenField ID="DrugMasterId" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDrugcode" runat="server" Text="Drug Code"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDrugCode" runat="server" runat="server">
                                                        </asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDrugFamilyName" runat="server" Text="Family Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFamilyName" runat="server" runat="server">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text="Upload Bulk Master"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="fpDrugMaster" runat="server" />
                                                    </td>
                                                    <td>
                                                        <input type="reset" id="fpDrugMasterreset" tabindex="4" value="Clear" class="btn btn-small" />
                                                        <asp:Button ID="btnDrugMasterUpload" OnClientClick="return ValidateFile('fpDrugMaster');"
                                                            runat="server" Text="Upload" class="btn1 btn-medium" OnClick="btnDrugMasterUpload_Click" />
                                                        <asp:ImageButton ID="imDrugMasterDownload" CausesValidation="False" runat="server"
                                                            ImageUrl="../Images/download1.png" OnClick="imDrugMasterDownload_Click" />
                                                        <asp:Image runat="server" ID="Image1" ImageUrl="~/Images/ExcelImage.GIF" />
                                                        <asp:Button ID="imDrugMasterExportDownload" CssClass="btn" Text="Export to Excel"
                                                            Style="border: none; background: none; color: black; padding-left: 0px;" CausesValidation="False"
                                                            runat="server" OnClick="imDrugMasterExportDownload_Click" ImageUrl="Images/ExcelImage.GIF"
                                                            ImageAlign="Left" />
                                                    </td>
                                                    <caption>
                                                        <br />
                                                        <tr>
                                                            <td class="a-center" colspan="3">
                                                                <asp:Button ID="btnDrugMasterSave" runat="server" CausesValidation="False" class="btn1 btn-medium"
                                                                    OnClick="btnDrugMasterSave_Click" OnClientClick="return ValidateDrugMaster();"
                                                                    Text="Save" />
                                                                <input id="btnDrugmasterReset" class="btn1 btn-small" tabindex="5" type="reset" value="Clear" />
                                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </caption>
                                            </table>
                                            <div id="divDrugMaster" class="bg-row padding10 w-80p" style="height: 390px;">
                                                <asp:GridView ID="gvDrugMaster" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                                                    OnPageIndexChanging="gvDrugMaster_PageIndexChanging" OnRowDataBound="gvDrugMaster_RowDataBound"
                                                    ForeColor="#333333">
                                                    <Columns>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center"
                                                            HeaderText="S.No">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                                <%--<asp:HiddenField ID="hdnFamilyId" Value='<%# bind("FMID") %>' runat="server" />
                                                                <asp:HiddenField ID="HDDrugMasterId" Value='<%# bind("DrugID") %>' runat="server" />--%>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataField="BrandName" HeaderText="Drug Name">
                                                            <HeaderStyle Width="20%"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataField="Code" HeaderText="Drug Code">
                                                            <HeaderStyle Width="20%"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataField="FamilyName" HeaderText="Family Name">
                                                            <HeaderStyle Width="20%"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center"
                                                            HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" CausesValidation="False" ID="btnDrugEdit" Text="Edit"
                                                                    OnClick="btnDrugEdit_Click" />
                                                                <asp:LinkButton runat="server" CausesValidation="False" ID="btnDrugInActive" Text="InActive"
                                                                    OnClick="btnDrugInActive_Click" />
                                                                <asp:HiddenField ID="HDDrugMasterActive" Value='<%# bind("IsActive") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnFamilyId" Value='<%# bind("FMID") %>' runat="server" />
                                                                <asp:HiddenField ID="HDDrugMasterId" Value='<%# bind("DrugID") %>' runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:ImageButton runat="server" CausesValidation="False" ID="btnDrugHistory" Style="height: 30px;"
                                                                    ImageUrl="../Images/Hist2.png" OnClick="btnDrugHistory_Click" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys" />
                                                </asp:GridView>
                                            </div>
                                        </div>
                                        <div id="divDrugMasterHistory" class="modal">
                                            <!-- Modal content -->
                                            <div class="modal-content">
                                                <div class="header">
                                                    <div class="lh60">
                                                        Drug Master History
                                                    </div>
                                                </div>
                                                <div>
                                                    <br />
                                                    <asp:GridView ID="gvDrugMasterHistory" CssClass="mytable1 w-100p gridView" runat="server"
                                                        EmptyDataText="History is not available" AutoGenerateColumns="False" AllowPaging="True"
                                                        ForeColor="#333333">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" Visible="false">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="BrandName" HeaderText="Drug Name">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Code" HeaderText="Drug Code">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Description" HeaderText="Description">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="LoginName" HeaderText="Modified by ">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ModifiedAt" HeaderText="Modified At">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </div>
                                                <div>
                                                    <input type="button" onclick="document.getElementById('divDrugMasterHistory').style.display='none'"
                                                        class="close" value="Close" />
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="tpOrganismMaster" runat="server">
                                        <div class="bg-row padding10 w-80p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblOrganismName" runat="server" Text="Organism Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOrganismName" runat="server" Style="width: 57%" runat="server">
                                                        </asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        <asp:HiddenField ID="HDOrganismMasterId" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblOrganismCode" runat="server" Text="Organism Code"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOrganismCode" runat="server" Style="width: 57%" runat="server">
                                                        </asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblUploadBulk" runat="server" Text="Upload Bulk Master"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="fpOrganismUploadBulkMaster" runat="server" />
                                                    </td>
                                                    <td>
                                                        <input type="reset" id="btnUploadBulkMaster" value="Clear" class="btn btn-small" />
                                                        <asp:Button ID="btnOrganismUploadBulkMaster" OnClientClick="return ValidateFile('fpOrganismUploadBulkMaster');"
                                                            Text="Upload" class="btn1 btn-medium" runat="server" OnClick="btnOrganismUploadBulkMaster_Click" />
                                                        <asp:ImageButton ID="imButtonDownloadBulkMaster" runat="server" ImageUrl="../Images/download1.png"
                                                            CausesValidation="False" OnClick="imButtonDownloadBulkMaster_Click" />
                                                        <asp:Image runat="server" ID="img14" ImageUrl="~/Images/ExcelImage.GIF" />
                                                        <asp:Button ID="imButtonExportBulkMaster" Text="Export to Excel" runat="server" CausesValidation="False"
                                                            OnClick="imButtonExportBulkMaster_Click" ImageUrl="Images/ExcelImage.GIF" ImageAlign="Left"
                                                            Style="border: none; background: none; color: black; padding-left: 0px;" />
                                                    </td>
                                                    <caption>
                                                        <br />
                                                        <tr>
                                                            <td class="a-center" colspan="3">
                                                                <asp:Button ID="btnSaveOrganism" runat="server" CausesValidation="False" class="btn1 btn-medium"
                                                                    OnClick="btnSaveOrganism_Click" OnClientClick="return ValidateOrganismMaster();"
                                                                    Text="Save" />
                                                                <input id="btnRetestOrganism" class="btn1 btn-small" type="reset" value="Clear" />
                                                            </td>
                                                        </tr>
                                                    </caption>
                                            </table>
                                        </div>
                                        <div id="divOrganismMaster" class="bg-row padding10 w-80p" style="height: 390px;
                                            padding-top: 0px !Important;">
                                            <asp:GridView ID="gvOrganismMaster" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                                                ForeColor="#333333" OnPageIndexChanging="gvOrganismMaster_PageIndexChanging"
                                                OnRowDataBound="gvOrganismMaster_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderStyle-Width="20%" DataField="Name" HeaderText="Organism Name">
                                                        <HeaderStyle Width="20%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderStyle-Width="20%" DataField="Code" HeaderText="Code">
                                                        <HeaderStyle Width="20%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnEdit" Text="Edit" OnClick="btnEdit_Click" CausesValidation="False" />
                                                            <asp:HiddenField ID="HDOrgaanismMasterActive" Value='<%# bind("IsActive") %>' runat="server" />
                                                            <asp:HiddenField ID="HDOrganismMasterId" Value='<%# bind("ID") %>' runat="server" />
                                                            <asp:LinkButton runat="server" ID="btnInActive" Text="InActive" OnClick="btnInActive_Click"
                                                                CausesValidation="False" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:ImageButton runat="server" ID="btnOrganismHistory" CausesValidation="False"
                                                                Style="height: 30px;" ImageUrl="../Images/Hist2.png" OnClick="btnOrganismHistory_Click" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys" />
                                            </asp:GridView>
                                        </div>
                                        <div id="divOrganismMasterHistory" class="modal">
                                            <!-- Modal content -->
                                            <div class="modal-content">
                                                <div class="header">
                                                    <div class="lh60">
                                                        Organism Master History
                                                    </div>
                                                </div>
                                                <div>
                                                    <br />
                                                    <asp:GridView ID="gvOrganismMasterHistory" CssClass="mytable1 w-100p gridView" runat="server"
                                                        EmptyDataText="History is not available" AutoGenerateColumns="False" AllowPaging="True"
                                                        ForeColor="#333333">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" Visible="false">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Name" HeaderText="Organism Name">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Code" HeaderText="Organism Code">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Description" HeaderText="Description">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="LoginName" HeaderText="Modified by ">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ModifiedAt" HeaderText="Modified At">
                                                                <HeaderStyle Width="20%"></HeaderStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </div>
                                                <div>
                                                    <input type="button" onclick="document.getElementById('divOrganismMasterHistory').style.display='none'"
                                                        class="close" value="Close" />
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="tpActionTemplate" runat="server">
                                        <div class="bg-row padding10 w-80p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label12" runat="server" Text="Test Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDrugNameMapping" MaxLength="50" Width="330px" CssClass="searchBox"
                                                            AutoComplete="off" runat="server"></asp:TextBox><img src="../Images/starbutton.png"
                                                                alt="" class="v-middle" />
                                                        <ajc:AutoCompleteExtender ID="ACETestCodeScheme" runat="server" TargetControlID="txtDrugNameMapping"
                                                            FirstRowSelected="false" EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="2"
                                                            CompletionListCssClass="wordWheel listMain .box mediumList" CompletionListItemCssClass="wordWheel itemsMain mediumList"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList" ServiceMethod="GetTestCodingScheme"
                                                            ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters=":"
                                                            Enabled="True" OnClientItemSelected="SelectedTestCodeScheme">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text="Organism Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlOrganismName" AutoPostBack="false" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Drug Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" ID="ddlDrugName" CssClass="bbb" SelectionMode="Multiple"
                                                            Text="-- Select --" OnClick="ddlDrugName_Click"></asp:Button>
                                                        <asp:Button runat="server" ID="btnGenerate" CssClass="btn btn-medium" Text="Add"
                                                            OnClick="btnGenerate_Click"></asp:Button>
                                                    </td>
                                                </tr>
                                                <caption>
                                                </caption>
                                            </table>
                                        </div>
                                        <br />
                                        <br />
                                        <div id="divOrgMapping" style="height: 390px;">
                                            <asp:GridView AutoGenerateColumns="false" CssClass="mytable1 w-80p gridView" runat="server"
                                                ID="gvOrgMapping" OnRowDataBound="gvOrgMapping_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                            <asp:HiddenField ID="HDOrgaanismId" Value='<%# bind("OrganismId") %>' runat="server" />
                                                            <asp:HiddenField ID="HDOrgaanismTestId" Value='<%# bind("InvestigationID") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" />
                                                    <asp:BoundField DataField="OrganismName" HeaderText="Organism Name" />
                                                    <asp:TemplateField HeaderText="Drug Name">
                                                        <ItemTemplate>
                                                            <asp:GridView AutoGenerateColumns="false" ShowHeader="false" runat="server" ID="gvOrgMappingDrug"
                                                                OnRowCommand="gvOrgMappingDrug_RowCommand">
                                                                <Columns>
                                                                    <%--<asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <%--<asp:Label runat="server" ID="lblSerialno" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>--%>
                                                                    <asp:BoundField HeaderText="fzD" DataField="BrandName" />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField ID="hdnSeqNumber" Value='<%# bind("SeqNo") %>' runat="server" />
                                                                            <asp:ImageButton ID="btnUp" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex")%>'
                                                                                ImageUrl="~/Images/UpArrow.png" CommandName="UP" />
                                                                            <asp:ImageButton ID="btnDown" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex")%>'
                                                                                ImageUrl="~/Images/DownArrow.png" CommandName="DOWN" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <br />
                                            <div class="a-center" colspan="3">
                                                <asp:Button ID="btnOrgnismSave" runat="server" class="btn1 btn-medium" Text="Save"
                                                    OnClick="btnOrgnismSave_Click" />
                                                <asp:Button ID="btnMappingClear" runat="server" class="btn1 btn-small" OnClick="btnMappingClear_Click"
                                                    Text="Clear" />
                                            </div>
                                            </br>
                                            <asp:GridView AutoGenerateColumns="false" CssClass="mytable1 w-80p gridView" runat="server"
                                                ID="gvDrugMappingGrid" OnRowDataBound="gvDrugMappingGrid_RowDataBound" OnPageIndexChanging="gvDrugMappingGrid_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdnMappedDrugId" runat="server" />
                                                            <div id="div<%# Container.DataItemIndex + 1 %>" style="display: none;">
                                                                <asp:GridView AutoGenerateColumns="false" runat="server" CssClass="gridView w-100p"
                                                                    EmptyDataText="No matching records found " DataKeyNames="DrugID" ID="gvOrgMappingDrugsubgrid">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnDrugId" Value='<%# bind("DrugID") %>' runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Drug Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblMappedDrugName" Text='<%# bind("BrandName") %>' runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                            <asp:HiddenField ID="HDOrgaanismId" Value='<%# bind("OrganismId") %>' runat="server" />
                                                            <asp:HiddenField ID="HDOrgaanismTestId" Value='<%# bind("InvestigationID") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" />
                                                    <asp:BoundField DataField="OrganismName" HeaderText="Organism Name" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <a href="JavaScript:shrinkandgrow('div<%# Container.DataItemIndex + 1 %>');">
                                                                <img alt="+" id="imgdiv<%# Container.DataItemIndex + 1 %>" src="../Images/plus.png" />
                                                                <asp:Label ID="lblDrugName" runat="server" Text="View Drugs"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Edit">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnMappedEdit" OnClick="btnMappedEdit_Click" runat="server" CssClass="btn"
                                                                Text="Edit" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys" />
                                            </asp:GridView>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="LevelMaster" runat="server">
                                        <div class="bg-row w-80p">
                                            <table class="w-100p">
                                                <tr>
													<td>
                                                        <asp:Label ID="lblLevelMapDrugName" runat="server" Text="Drug Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlLevelMapDrugName" AutoPostBack="false" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        <asp:HiddenField ID="HiddenField3" runat="server" />
                                                    </td>
												 </tr>
												<tr>
                                                    <td>
                                                        <asp:Label ID="lblLevelName" runat="server" Text="Level Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLevelName" TabIndex="1" runat="server">
                                                        </asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" style="padding-top: 15px" colspan="2">
                                                        <asp:Button ID="btnAddLevelmap" runat="server" CssClass="btn1 btn-medium" OnClientClick="return ValidateLevelMap();"
                                                            CausesValidation="False" Text="Save" OnClick="btnAddLevelmap_Click" />
                                                        <input id="Reset1" class="btn1 btn-small" tabindex="5" type="reset" value="Clear" />
                                                        <asp:HiddenField ID="hdnLevelID" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divDrugLevelMap" class="bg-row padding10 w-80p" style="height: 390px;">
                                                <asp:GridView ID="grdDrugLevelMap" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                                                    OnPageIndexChanging="grdDrugLevelMap_PageIndexChanging"  OnRowDataBound="grdDrugLevelMap_RowDataBound" ForeColor="#333333">
                                                    <Columns>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center"
                                                            HeaderText="S.No">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                                <asp:HiddenField ID="HDLevelID" Value='<%# bind("LevelID") %>' runat="server"  />
                                                                <%--<input type="hidden" id="hdnLevelID"  value='<%# bind("LevelID") %>' runat="server" />--%>
                                                                <asp:HiddenField ID="hdnDrugID" Value='<%# bind("DrugID") %>' runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Width="5%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataField="BrandName" HeaderText="Drug Name">
                                                            <HeaderStyle Width="20%"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataField="LevelName" HeaderText="Level Name">
                                                            <HeaderStyle Width="20%"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center"
                                                            HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" CausesValidation="False" ID="btnLvelMapEdit" Text="Edit"
                                                                    OnClick="btnLevelMapEdit_Click" />
                                                                <asp:LinkButton runat="server" CausesValidation="False" ID="btnLvelMapInActive" Text="InActive"
                                                                    OnClick="btnLevelMapInActive_Click" />
                                                                <asp:HiddenField ID="hdnDrugLevelMappingActive" Value='<%# bind("IsActive") %>' runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        
                                                    </Columns>
                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys" />
                                                </asp:GridView>
                                            </div>
                                        </div>
                                        
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                            <asp:HiddenField ID="hdnSelectedId" runat="server" />
                            <asp:HiddenField ID="hdnInvId" runat="server" />
                            <asp:HiddenField ID="hdnAddOrEdit" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnTestName" runat="server" />
                            <asp:HiddenField ID="hdnTestCode" runat="server" />
                            <div id="divdrug" style="display: none; width: 172px; height: 200px; margin-left: 63%;
                                overflow-x: hidden; margin-top: 10%; padding-top: 0px !important; padding-left: 0px !IMPORTANT;
                                border: 1px solid #888; background-color: white" class="modal">
                                <div class="modal-content" style="padding: 0px 0px!important; text-align: left; max-height: 400px;
                                    overflow: auto; width: 170px;">
                                    <div style="max-height: 177px;">
                                        <asp:GridView runat="server" CssClass="w-100p" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="White"
                                            ID="gvddlDrugBrand" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField HeaderStyle-CssClass="ths">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk" runat="server" onclick="checkUncheckHeaderCheckBox(this.id);"
                                                            OnCheckedChanged="chk_CheckedChanged" />
                                                        <asp:HiddenField ID="hdDrugIds" Value='<%# bind("DrugID") %>' runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox Visible="true" ID="chkAll" runat="server" />
                                                    </HeaderTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="ths" DataField="BrandName" HeaderText="select All"
                                                    HeaderStyle-Font-Bold="true" />
                                                <%--<asp:BoundField DataField="Code" />--%>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                                <div>
                                    <asp:Button ID="btnOk" CssClass="btn" Style="margin-left: 25%;" runat="server" Text="Ok"
                                        OnClick="btnOk_Click" OnClientClick="return ValidateDrugBrands();" />
                                    <input type="button" id="btnClose" onclick="CloseDiv();" value="Close" />
                                </div>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnuploadFamily" />
                        <asp:PostBackTrigger ControlID="btnOrganismUploadBulkMaster" />
                        <asp:PostBackTrigger ControlID="btnDrugMasterUpload" />
                    </Triggers>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>

    <script type="text/javascript">
        function ValidateFamilyMaster() {
            debugger;
            var istrue = true;
            if ($('#txtFamilyName').val() == "") {
                alert('Family Name is empty..');
                istrue = false;
            }
            else if ($('#txtFamilyCode').val() == "") {
                alert('Family Code is empty..');
                istrue = false;
            }
            return istrue;
        }
        function ValidateOrganismMaster() {
            var istrue = true;
            if ($('#txtOrganismName').val() == "") {
                alert('Organism Name is empty..');
                istrue = false;
            }
            else if ($('#txtOrganismCode').val() == "") {
                alert('Organism Code is empty..');
                istrue = false;
            }
            return istrue;
        }


        function ValidateDrugMaster() {
            var istrue = true;
            if ($('#txtDrugName').val() == "") {
                alert('Drug Name is empty..');
                istrue = false;
            }
            else if ($('#txtDrugCode').val() == "") {
                alert('Drug Code is empty..');
                istrue = false;
            }
            else if ($('#ddlFamilyName').val() == "-1") {
                alert('Family Name is empty..');
                istrue = false;
            }
            return istrue;
        }

        /* BEGIN | sabari | 20181129 | Dev | Culture Report */
        function ValidateLevelMap() {
            debugger;
            var istrue = true;
            if ($('#txtLevelName').val() == "") {
                alert('Level Name is empty..');
                istrue = false;
            }
            else if ($('#ddlDrugName').val() == "") {
                alert('Drug Name is empty..');
                istrue = false;
            }
            return istrue;
        }
        /* END | sabari | 20181129 | Dev | Culture Report */
        function shrinkandgrow(input) {
            debugger;
            var displayIcon = "img" + input;
            if ($("#" + displayIcon).attr("src") == "../Images/plus.png") {
                $("#" + displayIcon).closest("tr")
			    .after("<tr><td></td><td colspan = '100%'>" + $("#" + input)
			    .html() + "</td></tr>");
                $("#" + displayIcon).attr("src", "../Images/minus.png");
            } else {
                $("#" + displayIcon).closest("tr").next().remove();
                $("#" + displayIcon).attr("src", "../Images/plus.png");
            }
        }

        //    $(document).on("click", "#TabContainer1_TabPanel1_gvFamilyMaster_ctl02_btnFamilyHistory", function() {

        function FamilyHistory(name) {

            var modal = document.getElementById(name);

            // Get the button that opens the modal
            var btn = document.getElementById("df");

            // Get the <span> element that closes the modal
            //        var span = $(".close");
            //        span.onclick = function() {
            //            modal.style.display = "none";
            //        }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
            modal.style.display = "block";
            //document.getElementById('pdp').innerHTML = $test.replace(/\n/g, "<br />");
        }


        function DrugPopup(name) {
            var modal = document.getElementById(name);

            // Get the button that opens the modal
            var btn = document.getElementById("df");
            modal.style.display = "block";
            highlite();
            //document.getElementById('pdp').innerHTML = $test.replace(/\n/g, "<br />");
        }

        function highlite() {
            debugger;
            var hdnLock;
            var value;
            var checkbox;
            var f = $('#hdnSelectedId').val();
            var fg = f.split(',');
            $("#gvddlDrugBrand tr:not(:first-child)").each(function() {
                hdnLock = $(this).find('td input[type="hidden"]')[0].value;
                checkbox = $(this).find('td input[type="checkbox"]')[0];
                $.each(fg, function(index, value) {
                    if (hdnLock == value) {
                        checkbox.defaultChecked = "true"
                    }
                });
            });
        }


        function ValidateDrugBrands() {
            debugger;
            var istrue = true;
            var gv = document.getElementById("<%= gvddlDrugBrand.ClientID %>");
            var items = $('#gvddlDrugBrand input[name$="chk"]');
            var count = 0;
            for (var i = 0; i < items.length; i++) {
                if (items[i].checked) {
                    count = count + 1;
                }
            }

            if (count == 0) {
                istrue = false;
                alert("Drugs are empty, Please select drugs.");
            }
            return istrue;
        }
    </script>

    <script type="text/javascript">

        function SelectedTestCodeScheme(Source, eventArgs) {
            try {
                var hdnTestCode = '<%=hdnTestCode.ClientID %>';
                var lstSelectedValue = eventArgs.get_value().split(':');

                var seletedReflextest = lstSelectedValue[0];
                //        var Isorderable = lstSelectedValue[1];
                //        $('input[id$="hdnSelectedReflexTest"]').val(lstSelectedValue[0]);
                //        $('input[id$="hdnIsOrderable"]').val(lstSelectedValue[1]);



                //$('#' + hdnInvID).val(seletedReflextest);
                var lstSelectedText = eventArgs.get_text().split(':');
                if (seletedReflextest.length > 1 && seletedReflextest != null) {
                    //$('#' + txtTestCodeScheme).val(lstSelectedText[1]);
                    $('#' + hdnTestCode).val(seletedReflextest);
                    $('#' + HDOrgaanismTestId).val(seletedReflextest);

                }
            }
            catch (e) {
                return false;
            }
        }

        function checkUncheckHeaderCheckBox(obj) {
            debugger;
            if ($("input[id$=chk]").length == $("input[id$=chk]:checked").length) {

                $('#gvddlDrugBrand_ctl01_chkAll').prop('checked', true);
            } else {
                $('#gvddlDrugBrand_ctl01_chkAll').prop('checked', false);
            }
        }

        $(document).on('change', '#gvddlDrugBrand_ctl01_chkAll', function() {
            debugger;
            if (this.checked) {
                $('#gvddlDrugBrand input[name$="chk"]').prop('checked', true);
            }
            else {
                $('#gvddlDrugBrand input[name$="chk"]').prop('checked', false);
            }
        });

        function CloseDiv() {
            debugger;
            document.getElementById("divdrug").style.display = "none";
        }

        var validFilesTypes = ["xls", "xlsx"];

        function ValidateFile(name) {
            debugger;
            var file = document.getElementById(name);
            var labelvalue;
            var path = file.value;
            var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();
            var isValidFile = false;
            if (file.value != "") {
                for (var i = 0; i < validFilesTypes.length; i++) {
                    if (ext == validFilesTypes[i]) {
                        isValidFile = true;
                        break;
                    }
                }
                if (!isValidFile) {
                    labelvalue = "Invalid File. Please upload a File with extension: " + validFilesTypes.join(", ");
                    alert(labelvalue);
                }
            }
            else {
                alert('Please select file to upload.');
            }
            return isValidFile;
        }


        Sys.Browser.WebKit = {};
        if (navigator.userAgent.indexOf('WebKit/') > -1) {
            Sys.Browser.agent = Sys.Browser.WebKit;
            Sys.Browser.version = parseFloat(navigator.userAgent.match(/WebKit\/(\d+(\.\d+)?)/)[1]);
            Sys.Browser.name = 'WebKit';
        }
       
    </script>

    <%--   <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/smoothness/jquery-ui.css" />--%>
</body>
</html>
