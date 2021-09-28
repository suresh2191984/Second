<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExcelToProductsUpload.aspx.cs"
    Inherits="StockManagement_ExcelToProductsUpload"  meta:resourcekey="PageResource1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Product Upload</title>

    <%--<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>--%>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
    <div class="contentdata">
        <table class="searchPanel w-100p">
            <tr>
                <td class="v-top">
                    <div id='TabsMenu1' class="a-left">
                        <ul>
                            <li id="li1" class="active" onclick="DisplayTab('UploadProducts',0)"><a href='#'><span>
                                <asp:Label ID="lblUploadProducts" runat="server" Text="Upload Products" 
                                    meta:resourcekey="lblUploadProductsResource1"></asp:Label></span></a></li>
                            <li id="li2" onclick="DisplayTab('ResetProductsQty',1)"><a href='#'><span>
                                <asp:Label ID="lblReset" runat="server" Text="Reset Products Qty" 
                                    meta:resourcekey="lblResetResource1"></asp:Label></span></a></li>
                            <%--Different Tabs for Reset Category and Products START --%>
                            <%--  <li id="li2" onclick="DisplayTab('ResetProductswise')"><a href='#'><span>
                                                <asp:Label ID="lblResetProducts" runat="server" Text="Reset Productswise"></asp:Label></span></a></li>
                                            <li id="li3" onclick="DisplayTab('ResetCategorywise')"><a href='#'><span>
                                                <asp:Label ID="Label1" runat="server" Text="Reset Categorywise"></asp:Label></span></a></li>--%>
                            <%--Different Tabs for Reset Category and Products END --%>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr id="trUploadProducts">
                <td>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Select Location" 
                                    meta:resourcekey="lblLocationResource1"></asp:Label>
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="w-170 marginL0" TabIndex="4" 
                                    meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblChooseFile" runat="server" Text="Choose File" CssClass="hide" Font-Bold="True"
                                    meta:resourcekey="lblChooseFileResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="xlsUpload" runat="server" Font-Size="Small" 
                                    meta:resourcekey="xlsUploadResource1" />
                                <asp:RegularExpressionValidator ID="regexValidator" runat="server" ControlToValidate="xlsUpload"
                                    ErrorMessage="Only Xlsx Files are allowed" 
                                    ValidationExpression="(.*\.([Xx][Ll][Ss][Xx])$)" 
                                    meta:resourcekey="regexValidatorResource1"></asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn" Font-Bold="True"
                                    OnClientClick="ControlValidate()" 
                                    OnClick="btnUpload_Click" meta:resourcekey="btnUploadResource1" />
                            </td>
                            <td>
                                <input type="button" id="btnClear" runat="server" value="Clear" class="cancel-btn" font-bold="true"
                                    onclick="javascript:return ClearFields();" />
                            </td>
                            <td class="a-right">
                                <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="~/PlatForm/Images/ExcelImage.GIF"
                                    ToolTip="Download Excel Template" meta:resourcekey="imgBtnXLResource1" />
                                <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                    Font-Size="12px" ForeColor="Black" ToolTip="Download Excel Template" meta:resourcekey="lnkExportXLResource1"><u>Download Excel Template</u></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr>
                            <td class="borderGrey occupied a-center headerRoom">
                                <asp:Label ID="lblFormat" runat="server" 
                                    Text="Uploaded file must be in following Format" 
                                    meta:resourcekey="lblFormatResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="GridLoadExcelTempate" runat="server" class="gridView w-100p" 
                                    OnRowDataBound="GridLoadExcelTempate_RowDataBound" 
                                    meta:resourcekey="GridLoadExcelTempateResource1">
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trChooseResetType" class="hide">
                <td>
                    <table class="w-100p panelFooter">
                        <tr>
                            <td class="borderGrey booked a-center headerRoom">
                                <asp:Label ID="lblChooseType" Text="Please choose type of Reset" runat="server" 
                                    meta:resourcekey="lblChooseTypeResource1"></asp:Label>
                            </td>
                            <td class="panelFooter">
                                <asp:RadioButtonList ID="rdoGroupBy" runat="server" RepeatDirection="Horizontal"
                                    onclick="ChangeByCategory();" meta:resourcekey="rdoGroupByResource1">
                                    <asp:ListItem Text="CategoryWise" Value="0" 
                                        meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="ProductWise" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trResetProductswise" class="hide">
                <td>
                    <table class="w-100p">
                        <tr>
                            <td class="borderGrey occupied a-center headerRoom">
                                <asp:Label ID="lblProductListZeroMSG" runat="server" 
                                    Text="Please Select the Product list reset to Zero" 
                                    meta:resourcekey="lblProductListZeroMSGResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr id="trProductList">
                            <td>
                                <asp:Label ID="lblProductName" runat="server" Text="Product Name" meta:resourcekey="lblProductNameResource1"></asp:Label>
                                <asp:TextBox ID="txtProduct" runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                    MinimumPrefixLength="1" OnClientItemSelected="IsSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProduct" DelimiterCharacters=""
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:HiddenField ID="iconHid" runat="server" />
                                <asp:Label ID="lblHeader" runat="server" Text="Selected Products" CssClass="hide font12 v-middle a-left padding5"
                                    meta:resourcekey="lblHeaderResource1"></asp:Label>
                                <table id="tblResetedProductList" class="gridView w-96p a-left">
                                </table>
                            </td>
                            <td>
                                <asp:Button ID="btnProductWiseReset" runat="server" Text="Reset" CssClass="btn" Font-Bold="True"
                                    OnClientClick="javascript:return ChkProducts();" 
                                    OnClick="btnResetProductwise_Click" 
                                    meta:resourcekey="btnProductWiseResetResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trResetCategorywise" class="hide">
                <td>
                    <table class="w-100p">
                        <tr>
                            <td class="headerRoom">
                                <asp:Label ID="lblCategorywiseList" runat="server" 
                                    Text="Please Select the Category list reset to Zero" 
                                    meta:resourcekey="lblCategorywiseListResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <div>
                                    <img id="imgDDL" alt="DDL" src="../PlatForm/Images/DDL.png" onclick="ToggleDDL(this);" />
                                </div>
                                <div id="CheckBoxListDropDown" class="s1 hide" runat="server">
                                </div>
                            </td>
                            <td>
                                <asp:Button ID="btnCategoriesList" runat="server" Text="Reset" CssClass="btn" Font-Bold="True"
                                    OnClientClick="javascript:return GetCategories()" 
                                    OnClick="btnResetCategorieswise_Click" 
                                    meta:resourcekey="btnCategoriesListResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnProductCategories" runat="server" />
    <input type="hidden" id="hdnProductCategorieschk" runat="server" />
    <input type="hidden" id="hdnIsflag" runat="server" />
    </form>


  <script type="text/javascript" language="javascript">
      var errorMsg = SListForAppMsg.Get("StockManagement_Error") != null ? SListForAppMsg.Get("StockManagement_Error") : "Alert";
      var InformationMsg = SListForAppMsg.Get("StockManagement_Information") != null ? SListForAppMsg.Get("StockManagement_Information") : "Information";
      var okMsg = SListForAppMsg.Get("StockManagement_Ok") != null ? SListForAppMsg.Get("StockManagement_Ok") : "Ok";
      var CancelMsg = SListForAppMsg.Get("StockManagement_Cancel") != null ? SListForAppMsg.Get("StockManagement_Cancel") : "Cancel";
   </script>
   
  <script language="javascript" type="text/javascript">



     function ClearFields() {

         document.getElementById('xlsUpload').value = '';
         $('#ddlLocation').val('0');

     }

     function ChkProducts() {
         var ProductListValue = document.getElementById('iconHid').value;
         if (ProductListValue.length == 0) {
             var userMsg = SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_01") == null ? "Please select Products" : SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_01");
             ValidationWindow(userMsg, errorMsg);
             return false;
         }
         return true;

     }

     function ControlValidate() {
         var LocID = $('#ddlLocation').val();
         var path = $('input[type=file]').val();
         if (LocID != 0 && path != "") {
             return true;
         }

         else {
             if (LocID == 0) {
                 var userMsg = SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_02") == null ? "please select Location" : SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_02");
                 ValidationWindow(userMsg, errorMsg);
             }
             else if (path == "") {
                 var userMsg = SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_03") == null ? "please select File" : SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_03");
                 ValidationWindow(userMsg, errorMsg);
             }
             return false;
         }


     }

     function DisplayTab(tabName, id) {
         //*****************id=0 Upload Products************************//
         //*****************id=1 Reset Products wise************************//
         //*****************id=2 Reset Categories wise************************//
         $('#TabsMenu1 li').removeClass('active');
         if (tabName == 'UploadProducts' && id == 0) {
             $('#trChooseResetType').removeClass().addClass('hide');
             $('#trUploadProducts').removeClass().addClass('displaytr w-100p');
             $('#trResetProductswise').removeClass().addClass('hide');
             $('#trResetCategorywise').removeClass().addClass('hide');

             $('#li1').removeClass().addClass('active');
         }
         else if (tabName == 'ResetProductsQty' && id == 1) {
             $('#<%= rdoGroupBy.ClientID %> input[value="1"]').attr('checked', 'checked');
             $('#trUploadProducts').removeClass().addClass('hide');
             $('#trChooseResetType').removeClass().addClass('displaytr w-100p');
             $('#trResetProductswise').removeClass().addClass('displaytr w-100p');
             $('#trResetCategorywise').removeClass().addClass('hide');
             $('#li2').removeClass().addClass('active');
         }
         else if (tabName == 'ResetProductsQty' && id == 2) {
             $('#<%= rdoGroupBy.ClientID %> input[value="0"]').attr('checked', 'checked');
             $('#trUploadProducts').removeClass().addClass('hide');
             $('#trChooseResetType').removeClass().addClass('displaytr w-100p');
             $('#trResetProductswise').removeClass().addClass('hide');
             $('#trResetCategorywise').removeClass().addClass('displaytr w-100p');
             $('#li2').removeClass().addClass('active');
             ChkALL(0);

         }
     }

        
     
    </script>

  <script language="javascript" type="text/javascript">
        var common;
        //window.onload = function() {
        $(document).ready(function() {
            var struserMsg = SListForAppDisplay.Get("StockManagement_ExcelToProductsUpload_aspx_01") == null ? "ALL" : SListForAppDisplay.Get("StockManagement_ExcelToProductsUpload_aspx_01");
            common = $('#hdnIsflag').val();
            $('#CheckBoxListDropDown').html('');
            //$('[id$="hdnProductCategorieschk"]').val('');
            var tmpTable;
            var lstProductCategories = [];
            lstProductCategories = JSON.parse($('[id$="hdnProductCategories"]').val());
            tmpTable = "<table id ='tblPC' class = 'tempTable w-100p' CELLSPACING=3px><tbody>";

            tmpTable += "<tr id ='imgtrchk'>";
            tmpTable += "<td id ='imgChklistdrp' class='a-left'><input id ='chkAll0' name='0' value ='0' type='checkbox' class='underline pointer' onclick='ChkALL(this)' /></td>";
            tmpTable += "<td id ='lblChk' class='a-left'> --" + struserMsg + "-- </td>";
            tmpTable += "</tr>";

            $.each(lstProductCategories, function(i, obj) {
                tmpTable += "<tr id ='imgtrchk'>";
                tmpTable += "<td id ='imgChklistdrp' class='a-left'><input id ='imgChklist" + obj.CategoryID + "' name='" + obj.CategoryName + obj.CategoryID + "' value ='" + obj.CategoryID + "' type='checkbox' class='underline Profilelnk'  onclick='DeChkALL(this)'/></td>";
                tmpTable += "<td id ='lblChk' class='a-left'>" + obj.CategoryName + " </td>";
                tmpTable += "</tr>";

            });
            tmpTable += "</tbody>";
            tmpTable += "</table>";
            $('#CheckBoxListDropDown').html(tmpTable);
            if ($('[id$="hdnProductCategorieschk"]').val() != '') {
                var lstProductCategories_chk = [];
                lstProductCategories_chk = JSON.parse($('[id$="hdnProductCategorieschk"]').val());
                $.each(lstProductCategories_chk, function(i, obj) {
                    $('#imgChklist' + obj.CategoryID).attr('checked', 'checked');
                    $('#chkAll' + obj.CategoryID).attr('checked', 'checked');

                });
            }


            $(document.body).click(function(e) {
                if (e.target.id != 'imgDDL' && e.target.parentElement.id != 'imgChklistdrp' && e.target.id != 'lblChk') {
                    if ($('#CheckBoxListDropDown').css('display') == 'block') {
                        $('#CheckBoxListDropDown').slideToggle('slow');
                    }
                }
            });
        });
        // }

        function GetCategories() {
            //            debugger;
            var lstPC = [];
            var _flag = $('#hdnIsflag').val();

            if (_flag == 'true') {
                $('#hdnIsflag').val(_flag);
            }

            $("[id$='tblPC'] tbody  tr td input").each(function() {
                if ($(this).attr('checked')) {
                    if ($(this).attr('value') != '') {
                        lstPC.push({
                            CategoryID: $(this).attr('value'),
                            OrgID: '<%= OrgID %>'
                        });
                    }
                }
            });
            if (lstPC.length > 0) {
                $('[id$="hdnProductCategorieschk"]').val(JSON.stringify(lstPC));
            }
            else {
                $('[id$="hdnProductCategorieschk"]').val('');
                var userMsg = SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_04") == null ? "please select the category list" : SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_04");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }

        function ToggleDDL(obj) {
            $('#CheckBoxListDropDown').slideToggle('slow');
        }

        function ChkALL(obj) {
            if ($(obj).attr('checked')) {
                $("[id$='tblPC'] tbody  tr td input").each(function() {
                    $(this).attr('checked', 'checked');
                });
            }
            else {
                $("[id$='tblPC'] tbody  tr td input").each(function() {
                    $(this).attr('checked', false);
                });
            }
        }

        function DeChkALL(obj) {
            if ($(obj).attr('checked') == false) {

                $('#chkAll0').attr('checked', false);
            }
        }


        // $("[id*=rdoGroupBy] input").live("click", function() {
        // $("input:radio[name=rdoGroupBy]").click(function() {
        //   var selectedValue = $(this).val();
        function ChangeByCategory() {
            var selectedValue = $('#rdoGroupBy input:checked').val()
            if (selectedValue == 0) {
                $('#trUploadProducts').removeClass().addClass('hide');
                $('#trResetProductswise').removeClass().addClass('hide');
                $('#trResetCategorywise').removeClass().addClass('displaytr w-100p');
                ChkALL(0);
                return true;
            }
            else {
                $('#trUploadProducts').removeClass().addClass('hide');
                $('#trResetCategorywise').removeClass().addClass('hide');
                $('#trResetProductswise').removeClass().addClass('displaytr w-100p');
                $('#lblHeader').removeClass().addClass('hide');
                $('#tblResetedProductList').removeClass().addClass('hide');
                document.getElementById('iconHid').value = "";
                return true;
            }
        }

        function pSetfocus() {

            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return;
        }
        function IsSelected(source, eventArgs) {

            // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var categoryID;
            var AddStatus = 0;
            var quantity = parseFloat(0).toFixed(2);
            var val = eventArgs.get_value().split('~');
            var desc = val[4];
            var unit = "";
            var lsunit = "";
            var amount = parseFloat(0).toFixed(2);
            var rate = parseFloat(0).toFixed(2);
            var CategoryName = val[2]
            var Product = '';


            var result = eventArgs.get_text().match(/[^[\]]+(?=])/g)
            if (result != null) {
                Product = eventArgs.get_text().replace(/\s*\[.*?\]\s*/g, '');


            } else {
                Product = eventArgs.get_text();
            }
            var ProductName = Product.split('--');
            var InHandQty = 0;
            var ID = 0;
            var BatchNo = val[3];
            //var InHandQty = val[4];
            categoryID = val[1];

            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');

            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] == val[0]) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                // document.getElementById('lblHeader').style.display = "block";
                $('#lblHeader').removeClass().addClass('panelHeader');
                var row = document.getElementById('tblResetedProductList').insertRow(0);
                row.id = val[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' class='pointer' OnClick='ImgOnclick(" + val[0] + ");' src='../PlatForm/Images/Delete.jpg' />";
                //cell1.width = "5%";
                cell1.addClass("w-5p");
                cell2.innerHTML = ProductName[0] + " (" + CategoryName + ")";
                cell3.innerHTML = categoryID;
                //cell3.style.display = "none";
                cell3.addClass("hide");

                document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "^";
                AddStatus = 2;
            }

            if (AddStatus == 0) {

                //document.getElementById('lblHeader').style.display = 'block';
                $('#lblHeader').removeClass().addClass('panelHeader');
                var row = document.getElementById('tblResetedProductList').insertRow(0);
                row.id = val[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclick(" + val[0] + ");' CssClass='ui-icon ui-icon-circle-close b-none pointer' />";
                //cell1.width = "5%";
                cell1.addClass("w-5p");
                cell2.innerHTML = ProductName[0] + " (" + CategoryName + ")";
                cell3.innerHTML = categoryID;
                //cell3.style.display = "none";
                cell3.addClass("hide");

                document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "^";
            }
            else if (AddStatus == 1) {

                var userMsg = SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_05") == null ? "Product already added" : SListForAppMsg.Get("StockManagement_ExcelToProductsUpload_aspx_05");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtProduct').value = '';
                document.getElementById('txtProduct').focus();
                return false;
            }
            if (list.length == 0) {
                $('#lblHeader').removeClass().addClass('hide');
                $('#tblResetedProductList').removeClass().addClass('hide');
                // document.getElementById('tblResetedProductList').style.display = "none";
            }
            else {
                $('#lblHeader').removeClass().addClass('show');
                $('#tblResetedProductList').removeClass().addClass('show');
                //                document.getElementById('lblHeader').style.display = "block";
                //                document.getElementById('tblResetedProductList').style.display = "block";

            }

            pSetfocus();

        }
        function ImgOnclick(ImgID) {

            //document.getElementById(ImgID).style.display = "none";
            $(ImgID).removeClass().addClass('hide');
            var HidValue = document.getElementById('iconHid').value;

            var list = HidValue.split('^');
            var newInvList = '';
            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('iconHid').value = newInvList;
                if (newInvList.split('^').length == 1) {
                    $('#lblHeader').removeClass().addClass('hide');
                    $('#tblResetedProductList').removeClass().addClass('hide');
                    //                    document.getElementById('lblHeader').style.display = "none";
                    //                    document.getElementById('tblResetedProductList').style.display = "none";
                }
                else {
                    //                    document.getElementById('lblHeader').style.display = "block";
                    //                    document.getElementById('tblResetedProductList').style.display = "block";

                    $('#lblHeader').removeClass().addClass('show');
                    $('#tblResetedProductList').removeClass().addClass('show');

                }

            }
        }
        $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>
    
 </body>
</html>
