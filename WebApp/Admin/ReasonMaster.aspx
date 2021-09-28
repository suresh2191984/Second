<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReasonMaster.aspx.cs" Inherits="Admin_ReasonMaster" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reason Master</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function getreasonmasterrowid(rid, CategoryID, ReasonTypeID, ReasonID, Reason, ReasonCode, Status, SequenceNo, ExtCmt) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            rid.checked = true;
            document.getElementById('ddlCategory').value = CategoryID;
            document.getElementById('ddlType').value = ReasonTypeID;
            document.getElementById('txtReasonCode').value = ReasonCode;
            document.getElementById('txtReason').value = Reason;
           document.getElementById('ExtCmt').value = ExtCmt;

            document.getElementById('trchkactive').style.display = "table-row";
//            document.getElementById('chkActive').style.display = "block";

            if (document.getElementById('chkActive') != null) {
                if (Status == 'Active') {
                    document.getElementById('chkActive').checked = true;
                }
                else {
                    document.getElementById('chkActive').checked = false;
                }
            }
            document.getElementById('hdnReasonID').value = ReasonID;
            if (document.getElementById('hdnReasonID').value != '') {
                document.getElementById('ddlCategory').disabled = true;
                document.getElementById('ddlType').disabled = true;
                document.getElementById('txtReasonCode').disabled = true;
            }
        }
        function ClearControls() {

            document.getElementById('ddlCategory').disabled = false;
            document.getElementById('ddlType').disabled = false;
            document.getElementById('txtReasonCode').disabled = false;

            document.getElementById('ddlCategory').value = '0';
            document.getElementById('ddlType').value = '-1';

            document.getElementById('ddlType').options.length = 0;
            
            document.getElementById('txtReasonCode').value = '';
            document.getElementById('txtReason').value = '';
            document.getElementById('ExtCmt').value = '';
            if (document.getElementById('chkActive') != null) {
                document.getElementById('chkActive').checked = false;
            }
            document.getElementById('trchkactive').style.display = "none";
            if (document.getElementById('gvwReasons') != null) {
                document.getElementById('gvwReasons').style.display = "none";
            }
            document.getElementById('hdnReasonID').value = '';
            document.getElementById('tdismapped').style.display = "none";
            document.getElementById('btnSave').style.display = "block";
            
        }
        function ValidateReasonEntries() {
            var objVar01 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_01") == null ? "Select Category" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_01");
            var objVar02 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_02") == null ? "Select Type" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_02");
            var objVar03 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_03") == null ? "Enter Code" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_03");
            var objVar04 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_04") == null ? "Enter Reason" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_ReasonMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_Alert");
            var objVar05 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_05") == null ? "Enter External comment" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_05");
            var objVar06 = SListForAppMsg.Get("Admin_ReasonMaster_aspx_06") == null ? "Special characters not allowed in External Comment" : SListForAppMsg.Get("Admin_ReasonMaster_aspx_06");
            if (document.getElementById('ddlCategory').value == "-1") {
                //alert('Select Category');
                ValidationWindow(objVar01, objAlert);
                return false;
            }
            if (document.getElementById('ddlType').value == "-1") {
                // alert('Select Type');
                ValidationWindow(objVar02, objAlert);

                return false;
            }
            if (document.getElementById('txtReasonCode').value == "") {
                //                alert('Enter Code');
                ValidationWindow(objVar03, objAlert);

                return false;
            }
            if (document.getElementById('txtReason').value == "") {
                //                alert('Enter Reason');
                ValidationWindow(objVar04, objAlert);

                return false;
            }
            if (document.getElementById('ExtCmt').value != "") {
                var letters = /^[a-zA-Z-,]+(\s{0,1}[a-zA-Z-, ])*$/;  // /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/
                if (ExtCmt.value.match(letters)) {
                    return true;
                }
                else {
                    ValidationWindow(objVar06, objAlert);
                    //alert("Special Charcters not allowed");
                    return false;
                }
               // ValidationWindow(objVar05, objAlert);

                //return false;
            }
            if (document.getElementById('ExtCmt').value == "") {
                ValidationWindow(objVar05, objAlert);

                return false;
            }
        }
        function onchangesData() {
            document.getElementById('tdismapped').style.display = "table-cell";
            document.getElementById('btnSave').style.display = "none";

        }
//        function AfterMapped() {
//            document.getElementById('ddlCategory').disabled = false;
//            document.getElementById('ddlType').disabled = false;
//            document.getElementById('txtReasonCode').disabled = false;

//            document.getElementById('ddlCategory').value = '0';
//            document.getElementById('ddlType').value = '-1';

//            document.getElementById('ddlType').options.length = 0;

//            document.getElementById('txtReasonCode').value = '';
//            document.getElementById('txtReason').value = '';
//            if (document.getElementById('chkActive') != null) {
//                document.getElementById('chkActive').checked = false;
//            }
//            document.getElementById('trchkactive').style.display = "none";
//            if (document.getElementById('gvwReasons') != null) {
//                document.getElementById('gvwReasons').style.display = "none";
//            }
//            document.getElementById('hdnReasonID').value = '';
//            document.getElementById('tdismapped').style.display = "none";
//            document.getElementById('btnSave').style.display = "block";

//        }
    </script>

<script type="text/javascript">
    function lettersOnly() {
        var charCode = event.keyCode;

        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8 || charCode == 32)
       // (charCode>= 48 && charCode <= 57) {   //0-9 only                          backspace           whitespace
            return true;
        else
            return false;
                   }

//        var charCode = (evt.which) ? evt.which : window.event.keyCode;

//        if (charCode <= 13) {
//            return true;
//        }
//        else {
//            var keyChar = String.fromCharCode(charCode);
//            var re = /^[a-zA-Z]+$/
//            return re.test(keyChar);}
        
    
</script>

<script type="text/javascript">
    function validate() {
        var firstname = document.getElementById("ExtCmt");
        var alpha = /^[a-zA-Z\s-, ]+$/;
        if (firstname.value == "") {
            alert('Please enter Name');
            return false;
        }
        else if (!firstname.value.match(alpha)) {
            alert('Invalid ');
            return false;
        }
        else {
            return true;
        }
    }
</script>

<script type="text/javascript">
function onlyNumbersandSpecialChar(evt) {
    var e = window.event || evt;
    var charCode = e.which || e.keyCode;
    
  if (charCode > 31 && (charCode < 48 || charCode > 57 || charCode > 107 || charCode > 219 ||          charCode > 221) && charCode != 40 && charCode != 32 && charCode != 41 && (charCode < 43 || charCode > 46)) {
        if (window.event) //IE
            window.event.returnValue = false;
        else //Firefox
            e.preventDefault();
    }
    return true;

   }

 </script>
    <style type="text/css">
        .style2
        {
            width: 298px;
        }
        .style4
        {
            width: 405px;
        }
        .style5
        {
            width: 94px;
        }
        .style6
        {
            width: 53px;
        }
    </style>

</head>
<body  oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                     
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="padding3 a-center">
                                            <table class="dataheader2 defaultfontcolor a-center w-100p">
                                                <%--<tr>
                                                    <td class="Duecolor" height="18" align="left" colspan="3">
                                                        &nbsp;&nbsp;<asp:Label ID="lblReasonMasterHeader" Text="Reason Master" 
                                                            runat="server" meta:resourcekey="lblReasonMasterHeaderResource1" />
                                                        &nbsp;
                                                    </td>
                                                </tr>     --%>                                       
                                                <tr>
                                                    <td class="a-left" width="250px" >
                                                        <asp:Label ID="lblCategory" Text="Category" runat="server" 
                                                            meta:resourcekey="lblCategoryResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlCategory" CssClass="ddl" runat="server" Height="22px" 
                                                            Width="178px" AutoPostBack="True" 
                                                            onselectedindexchanged="ddlCategory_SelectedIndexChanged"  ></asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblType" Text="Type" runat="server" 
                                                            meta:resourcekey="lblTypeResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlType" CssClass="ddl" runat="server" Width="178px"  AutoPostBack="True"
                                                            onselectedindexchanged="ddlType_SelectedIndexChanged" ></asp:DropDownList>
                                                    </td>
                                                    <td class="a-left style5">
                                                        <asp:Button ID="btnShow" Visible="False" Text="Show Reason List" runat="server" ToolTip="Click here to show the Reasons" 
                                                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                            onmouseout="this.className='btn'" Width="135px" onclick="btnShow_Click" 
                                                            meta:resourcekey="btnShowResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblReasonCode" Text="Code" runat="server" 
                                                            meta:resourcekey="lblReasonCodeResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtReasonCode" Width="50px" CssClass="Txtboxsmall" runat="server" 
                                                            onblur="javascript:ConverttoUpperCase(this.id);" MaxLength="5" meta:resourcekey="txtReasonCodeResource1" ></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                                            meta:resourcekey="lblReasonResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtReason"  CssClass="Txtboxsmall" runat="server" 
                                                            Width="396px" MaxLength="50" meta:resourcekey="txtReasonResource1" ></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                
                                                    <td class="a-left">
                                                        <asp:Label ID="Label1" Text="External Comment" runat="server" 
                                                            meta:resourcekey="lblExternalComment"></asp:Label>
                                                            
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="ExtCmt" TextMode="MultiLine"   CssClass="Txtboxsmall" runat="server" onkeypress="return lettersOnly(event)"
           
                                                            Width="696px" MaxLength="150" meta:resourcekey="txtExternalCommnet" ></asp:TextBox>
                                                            <%--onkeypress="return lettersOnly(event)" --%>
                                                            <%--onkeypress="return IsAlphaNumeric(event);"  ondrop="return false;" onpaste="return false;"--%><%--onKeyPress="return onlyNumbersandSpecialChar()" --%>
                                                </tr>
                                               
                                                <tr id="trchkactive" style="display:none">
                                                    <td class="style2"></td>
                                                    <td class="a-left" colspan="2">
                                                        <asp:CheckBox ID="chkActive" Text="Active" Width="50px" runat="server" 
                                                            meta:resourcekey="chkActiveResource1" />
                                                    </td>
                                                </tr>
                                           
                                                <tr>
                                                    <td colspan ="3" class="h-60" style="padding-left:310px;">
                                                        <table>
                                                            <tr>
                                                                <td class="a-right">
                                                                    <asp:Button ID="btnSave" Text="Save" runat="server" ToolTip="Click here to Save/Update the data" 
                                                                        Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                                        onmouseout="this.className='btn'" Width="60px" 
                                                                        OnClientClick="return ValidateReasonEntries();" onclick="btnSave_Click" 
                                                                        meta:resourcekey="btnSaveResource1" />
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" ToolTip="Click here to Clear the data" 
                                                                        Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                                        onmouseout="this.className='btn'" Width="60px" 
                                                                        OnClientClick="ClearControls();return false" 
                                                                        meta:resourcekey="btnCancelResource1"  />
                                                                    
                                                                </td>
                                                                <td id="tdismapped" style="display:none;">
                                                                 <asp:Button ID="btnIsMapped" Text="Save Mapping Data" runat="server"  
                                                                        Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                                        onmouseout="this.className='btn'" Width="120px" onclick="btnIsMapped_Click"  OnClientClick = "return ClearControls();" meta:resourcekey="btnIsMappedResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td class="a-center v-top" runat="server">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter" class="a-center">
                                                    </div>
                                                    <div id="processMessage" class="a-center w-20p">
                                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                    </div>
                                                </ProgressTemplate>

                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center paddingB10">
                                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" 
                                                Text="No Matching Records Found!" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            <asp:GridView ID="gvwReasons" runat="server" CellSpacing="1" CellPadding="1"
                                                AllowPaging="True" AutoGenerateColumns="False"  PageSize="30"  OnPageIndexChanging="gvwReasons_PageIndexChanging"
                                                ForeColor="#333333" CssClass="mytable1 gridView w-100p" 
                                                meta:resourcekey="gvwReasonsResource1" 
                                                onrowdatabound="gvwReasons_RowDataBound">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <input id="rdSel" name="radio" onclick='getreasonmasterrowid(this,&#039;<%# Eval("CategoryID") %>&#039;,&#039;<%# Eval("ReasonTypeID") %>&#039;,&#039;<%# Eval("ReasonID") %>&#039;,&#039;<%# Eval("Reason") %>&#039,&#039;<%# Eval("ReasonCode") %>&#039,&#039;<%# Eval("Status") %>&#039,&#039;<%# Eval("SequenceNo") %>&#039,&#039;<%# Eval("ExternalComment") %>&#039;)'
                                    
                                                                type="radio" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Reason" HeaderText="Reason" 
                                                        meta:resourcekey="BoundFieldResource1" >
                                                        <ControlStyle Width="65%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ReasonCode" HeaderText="Code" 
                                                        meta:resourcekey="BoundFieldResource2" >
                                                        <ControlStyle Width="5%" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Status" HeaderText="Status" 
                                                        meta:resourcekey="BoundFieldResource3" >
                                                        <ControlStyle Width="5%" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ExternalComment" HeaderText="External Comment" 
                                                        meta:resourcekey="ExternalComment" >
                                                        <ControlStyle />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    
                                                    <asp:TemplateField HeaderText="IsMapped" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                           <asp:CheckBox ID="chkselect" runat="server" />
                                                           <asp:HiddenField ID="hdnselect"   Value='<%# Bind("ReasonID") %>'  runat="server"/>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" />
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                        PageButtonCount="5" PreviousPageText="" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnReasonID" runat="server" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />           
    </form>
</body>
</html>
