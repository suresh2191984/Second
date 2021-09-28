<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Nutrition.ascx.cs" Inherits="CommonControls_Nutrition" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<script type="text/javascript" src="../Scripts/paging/jquery.dataTables.js"></script>
    <style type="text/css">
        .style1
        {
            height: 34px;
            width: 30%;
        }
        .style2
        {
            height: 34px;
            width: 70%;
        }
    </style>

    <script type="text/javascript">

        function RequestFoodList() {

            var orgid = 1;
            var FoodMenuID = $('#ucNutrition_ddlMenu option:selected').val();
            var FoodSessionID = $('#ucNutrition_ddlFoodSession option:selected').val();

            if (orgid != '' && FoodMenuID != '' && FoodSessionID != '') {
                $.ajax({
                    type: "POST",
                    url: "../NutritionWebService.asmx/GetFoodList",
                    data: "{ 'orgid': '" + orgid + "','FoodMenuID': '" + FoodMenuID + "','FoodSessionID': '" + FoodSessionID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function(data) {
                        var Items = data.d;
                        if (Items != '') {
                            $('#spanMsg').hide();
                            $('#btnSave').show();
                            BindFoodList(Items)
                        }
                        else {
                            $('#trFoodList td').remove();
                            $('#spanMsg').show();
                            $('#btnSave').hide();
                        }
                    },
                    failure: function(msg) {
                        alert('error');
                    }
                });
            }


        }

        function BindFoodList(Items) {
            $('#trFoodList td').remove();
            $.each(Items, function(index, Item) {
                $('#trFoodList').append('<td><input id="Checkbox1" type="checkbox" onclick="GetSelectedFoodList(this)" name="' + Item.FoodName + '" value="' + Item.FoodID + '" />' + Item.FoodName + '</td>');
            });
        }

        var getFoodCollectionID = '';
        var getFoodCollectionText = '';
        function GetSelectedFoodList(ele) {
            if ($(ele).attr('checked')) {
                getFoodCollectionID += $(ele).attr('value') + '|';
                getFoodCollectionText += $(ele).attr('name') + ',';
            }
            else {
                getFoodCollectionID = getFoodCollectionID.replace($(ele).attr('value') + '|', '');
                getFoodCollectionText = getFoodCollectionText.replace($(ele).attr('name') + ',', '');
            }

        }

        var lstFoodList = [];
        var hdnFoodDescription = '';
        var drawFoodDescription = '';
        var temp = 0;

        function CreateFoodList() {

            if ($("#ucNutrition_txtFrom").val() == '') {
                alert("choose a date");
                temp = 1;
                return false;
            } else {
                temp = 0;
            }

            if ($("#ucNutrition_txtTo").val() == '') {
                alert("choose a date");
                temp = 1;
                return false;
            } else {
                temp = 0;
            }

            if (Date.parse($.trim($("#ucNutrition_txtFrom").val())) < Date.parse($('#ucNutrition_hdnCurrentDate').val())) {
                alert("choose a proper from order date");
                temp = 1;
                return false;
            } else {
                temp = 0;
            }

            var varFromDate = $("#ucNutrition_txtFrom").val();
            var varToDate = $("#ucNutrition_txtTo").val();
            if (Date.parse(varFromDate) > Date.parse(varToDate)) {
                alert("Invalid Date Range!\nStart Date cannot be after End Date!");
                temp = 1;
                return false;
            }
            else {
                temp = 0;
            }

            var fromDate = $('#ucNutrition_txtFrom').val();
            var toDate = $('#ucNutrition_txtTo').val();
            var menuName = $('#ucNutrition_ddlMenu option:selected').text();
            var menuID = $('#ucNutrition_ddlMenu option:selected').val();
            var sessionName = $('#ucNutrition_ddlFoodSession option:selected').text(); ;
            var sessionID = $('#ucNutrition_ddlFoodSession option:selected').val(); ;
            var foodListText = getFoodCollectionText.substring(0, (getFoodCollectionText.length - 1));
            var foodListID = getFoodCollectionID.substring(0, (getFoodCollectionID.length - 1));
            //var LoginID = $('#ucNutrition_hdnLoginID').val();
            //var PatientVisitID = $('#ucNutrition_hdnPatientVisitID').val();
            //var PatientID = $('#ucNutrition_hdnPatientID').val();
            //var refType = $('#ucNutrition_hdnRefType').val();

            var varfoodListID = '';
            var varfoodListText = '';
            if (foodListID != '') {
                varfoodListID = foodListID.split('|');
                varfoodListText = foodListText.split(',');
            }
            if (varfoodListID.length == 0) {
                alert("select food list");
                temp = 1;
                return false;
            }
            else {
                temp = 0;
            }
            for (var i = 0; i < varfoodListID.length; i++) {
                hdnFoodDescription += fromDate + '@' + toDate + '@' + menuID + '@' + sessionID + '@' + varfoodListID[i] + '|';
                drawFoodDescription += fromDate + '@' + toDate + '@' + menuName + '@' + menuID + '@' + sessionName + '@' + sessionID + '@' + varfoodListText[i] + '@' + varfoodListID[i] + '|';
            }

            var checkData = fromDate + ',' + toDate + ',' + menuName + ',' + menuID + ',' + sessionName + ',' + sessionID + ',' + foodListText + ',' + foodListID;

            //if (lstFoodList.IndexOf(checkData) == '-1') {
            //console.log(hdnFoodDescription);
            lstFoodList.push({
                fromDate: fromDate,
                toDate: toDate,
                menuName: menuName,
                menuID: menuID,
                sessionName: sessionName,
                sessionID: sessionID,
                foodListText: foodListText,
                foodListID: foodListID
            });
            //}
            // else {
            // alert("data already exist !!!");
            // }

            getFoodCollectionText = '';
            getFoodCollectionID = '';

            if (temp == 0) {
                DrawTable(lstFoodList);
            }
        }


        function DrawTable(lstFoodList) {
            $('#tblFoodDescription tr').empty();
            //var DataTable = [];
            //DataTable = lstFoodList;
            var dt = drawFoodDescription.substring(0, (drawFoodDescription.length - 1));
            var DataTable = dt.split('|');
            var varRow = '';
            $.each(DataTable, function(i, obj) {
                var varData = DataTable[i].split('@');
                varRow = '<tr>';
                varRow += '<td FO=' + varData[0] + '>' + varData[0] + '</td>';
                varRow += '<td FO=' + varData[1] + '>' + varData[1] + '</td>';
                varRow += '<td FO=' + varData[3] + '>' + varData[2] + '</td>';
                varRow += '<td FO=' + varData[5] + '>' + varData[4] + '</td>';
                varRow += '<td FO=' + varData[7] + '>' + varData[6] + '</td>';
                varRow += '<td onclick="RemoveRow(this,' + i + ');" style="cursor:pointer">' + '<u>remove</u>' + '</td>';
                varRow += '</tr>';
                $('#tblFoodDescription').append(varRow);
            });
            $('#thText').show();
            ClearFields();
            $('#ucNutrition_btnSaveFoodDetails').show();
        }

        function RemoveRow(ele, index) {
            
            var varRow = '';
            var varRemoveRow = '';
            var drawRemoveRow = '';
            $(ele).parent('tr').children('td').each(function(i) {

                if (i != 5) {

                    if (i == 4) {
                        var v = $(this).attr('FO');
                        varRemoveRow += varRow + v + '|';
                    }
                    else {
                        varRow += $(this).attr('FO') + '@';
                    }


                    if (i == 0) {
                        drawRemoveRow += $(this).attr('FO') + '@';
                    }
                    else if (i == 1) {
                        drawRemoveRow += $(this).attr('FO') + '@';
                    }
                    else if (i == 2) {
                        drawRemoveRow += $(this).html() + '@';
                        drawRemoveRow += $(this).attr('FO') + '@';
                    }
                    else if (i == 3) {
                        drawRemoveRow += $(this).html() + '@';
                        drawRemoveRow += $(this).attr('FO') + '@';
                    }
                    else if (i == 4) {
                        drawRemoveRow += $(this).html() + '@';
                        drawRemoveRow += $(this).attr('FO') + '|';
                    }


                }

            });
            //console.log(hdnFoodDescription);
            hdnFoodDescription = hdnFoodDescription.replace(varRemoveRow, '');
            drawFoodDescription = drawFoodDescription.replace(drawRemoveRow, '');
            //console.log(hdnFoodDescription);
            $(ele).parent('tr').remove();
            //console.log(lstFoodList);
        }
        

        function ClearFields() {
            $('#ucNutrition_txtFrom').val('');
            $('#ucNutrition_txtTo').val('');
            $('#ucNutrition_ddlMenu').get(0).selectedIndex = 0;
            $('#ucNutrition_ddlFoodSession').get(0).selectedIndex = 0;
            $('#trFoodList td').empty();
        }

        function fnSaveFoodDetails() {

            $('#ucNutrition_hdnFoodDescription').val(hdnFoodDescription.substring(0, (hdnFoodDescription.length - 1)));
            //       $.ajax({
            //           type: "POST",
            //           url: "nutrition.asmx/SaveFoodList",
            //           data: "{ 'FoodList': '" + $('#hdnFoodDescription').val() + "'}",
            //           contentType: "application/html; charset=utf-8",
            //           dataType: "html",
            //           async: true,
            //           success: function(data) {
            //               alert(data);
            //           },
            //           failure: function(msg) {
            //               alert('error');
            //           }
            //       });
        }

   
    
    </script>

    <table style="width: 80%;padding-bottom:30px;">
        <tr>
            <td colspan="2">
                <h3>
                    <asp:Label ID="lblHeaderTxt" runat="server" Text="Order Your Food Here" 
                        meta:resourcekey="lblHeaderTxtResource1"></asp:Label>
                </h3>
            </td>
        </tr>
        <tr width="50%">
            <td>
                <asp:Label ID="lblFromDate" runat="server" Text="From Date" 
                    meta:resourcekey="lblFromDateResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtFrom" runat="server" Width="150px" 
                    meta:resourcekey="txtFromResource1"></asp:TextBox>
                <ajc:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtFrom"
                    format="dd/MM/yyyy" popupbuttonid="Image1" Enabled="True" />
            </td>
            <td>
                <asp:Label ID="lblTodate" runat="server" Text="To Date" 
                    meta:resourcekey="lblTodateResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtTo" runat="server" Width="150px" 
                    meta:resourcekey="txtToResource1"></asp:TextBox>
                <ajc:calendarextender id="CalendarExtender3" runat="server" targetcontrolid="txtTo"
                    format="dd/MM/yyyy" popupbuttonid="Image1" Enabled="True" />
            </td>
        </tr>
        <tr width="50%">
            <td>
                <asp:Label ID="lblMenu" runat="server" Text="Menu" 
                    meta:resourcekey="lblMenuResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlMenu" runat="server" Width="160px" 
                    meta:resourcekey="ddlMenuResource1">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lblSession" runat="server" Text="Session" 
                    meta:resourcekey="lblSessionResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlFoodSession" runat="server" Width="160px" 
                    onchange="RequestFoodList();" meta:resourcekey="ddlFoodSessionResource1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Label ID="lblFoodList" runat="server" Text="Food List" 
                    meta:resourcekey="lblFoodListResource1"></asp:Label>&nbsp;&nbsp;:
                <table id="tblFoodList">
                    <tr id="trFoodList">
                    </tr>
                </table>
                <span id="spanMsg" style="display: none"><asp:Label ID="lblErrorMsg" 
                    runat="server" Text="sorry, No Food List For this session" 
                    meta:resourcekey="lblErrorMsgResource1"></asp:Label></span>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="button" id="btnSave" value="ADD" onclick="return CreateFoodList();"
                    style="display: none" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <table cellpadding="2" cellspacing="2" border="1" width="100%">
                <thead id="thText" style="display:none">   
                    <th><asp:Label ID="Label1" runat="server" Text="Start Date" 
                            meta:resourcekey="Label1Resource1"></asp:Label></th>
                    <th><asp:Label ID="Label2" runat="server" Text="End Date" 
                            meta:resourcekey="Label2Resource1"></asp:Label></th>
                    <th><asp:Label ID="Label3" runat="server" Text="Food Menu Name" 
                            meta:resourcekey="Label3Resource1"></asp:Label></th>
                    <th><asp:Label ID="Label4" runat="server" Text="Food Session Name" 
                            meta:resourcekey="Label4Resource1"></asp:Label></th>
                    <th><asp:Label ID="Label5" runat="server" Text="Food Name" 
                            meta:resourcekey="Label5Resource1"></asp:Label></th>
                    <th><asp:Label ID="Label6" runat="server" Text="Remove" 
                            meta:resourcekey="Label6Resource1"></asp:Label></th>
                </thead>
                <tbody id="tblFoodDescription"></tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <%--<input type="button" id="Button1" value="SAVE DIET" onclick="fnSaveFoodDetails()" />--%>
                <asp:Button ID="btnSaveFoodDetails" runat="server" Style="display: none" OnClientClick="fnSaveFoodDetails()"
                    Text="SAVE DIET" OnClick="btnSaveFoodDetails_Click" 
                    meta:resourcekey="btnSaveFoodDetailsResource1" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                         <asp:GridView ID="gvFoodOrdered" runat="server" AutoGenerateColumns="False" 
                             CssClass="mytable1" DataKeyNames="PatientDietPlanID"
                    PageSize="5" CellSpacing="4" Width="60%" HorizontalAlign="Left" CellPadding="4" OnRowCommand="gvFoodOrdered_RowCommand"
                    AllowPaging="True" OnPageIndexChanging="gvFoodOrdered_PageIndexChanging" 
                             meta:resourcekey="gvFoodOrderedResource1">
                    <Columns>
                        <asp:TemplateField HeaderText="Start Date" 
                            meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:Label ID="lblStartDate" runat="server" 
                                    Text='<%# Eval("StartDate","{0:dd/MM/yyyy}") %>' 
                                    meta:resourcekey="lblStartDateResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="End date" 
                            meta:resourcekey="TemplateFieldResource2">
                            <ItemTemplate>
                                <asp:Label ID="lblEnddate" runat="server" 
                                    Text='<%# Eval("Enddate","{0:dd/MM/yyyy}") %>' 
                                    meta:resourcekey="lblEnddateResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Food Menu Name" 
                            meta:resourcekey="TemplateFieldResource3">
                            <ItemTemplate>
                                <asp:Label ID="lblFoodMenuName" runat="server" 
                                    Text='<%# Eval("FoodMenuName") %>' meta:resourcekey="lblFoodMenuNameResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Food Session Name" 
                            meta:resourcekey="TemplateFieldResource4">
                            <ItemTemplate>
                                <asp:Label ID="lblFoodSessionName" runat="server" 
                                    Text='<%# Eval("FoodSessionName") %>' 
                                    meta:resourcekey="lblFoodSessionNameResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Food Name" 
                            meta:resourcekey="TemplateFieldResource5">
                            <ItemTemplate>
                                <asp:Label ID="lblFoodName" runat="server" Text='<%# Eval("FoodName") %>' 
                                    meta:resourcekey="lblFoodNameResource1"></asp:Label>
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Delete" 
                            meta:resourcekey="TemplateFieldResource6">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteOrder" 
                                    CommandArgument='<%# Container.DataItemIndex %>' Text="Delete" 
                                    meta:resourcekey="lnkDeleteResource1"></asp:LinkButton>
                                <asp:HiddenField ID="hdnPatientDietPlanID" runat="server" 
                                    Value='<%# bind("PatientDietPlanID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="dataheader1" />
                </asp:GridView>
                 </ContentTemplate>
            </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnLoginID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnPatientVisitID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnPatientID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnRefType" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnFoodDescription" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnCurrentDate" runat="server"></asp:HiddenField>

