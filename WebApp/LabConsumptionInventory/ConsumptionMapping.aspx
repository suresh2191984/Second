<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsumptionMapping.aspx.cs"
    Inherits="LabConsumptionInventory_ConsumptionMapping" meta:resourcekey="PageResource1"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ConsumptionMapping</title>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
     <Services >
      <asp:ServiceReference Path="~/LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx" />
     </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <table class="w-100p">
                        <tr id="trHeader">
                              <td>
                                <asp:Label ID="lblDevicesName" Text="Devices Name" runat="server" 
                                      meta:resourcekey="lblDevicesNameResource1"  ></asp:Label>
                                </td><td>
                                <asp:DropDownList  ID="ddlAnalyzerName" runat="server" CssClass="medium" meta:resourcekey="ddlAnalyzerNameResource1" 
                                     ></asp:DropDownList>
                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td>
                                <asp:Label ID="lblTestName" Text="Investigation Name" runat="server" meta:resourcekey="lblTestNameResource1" 
                                     ></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTestName" runat="server" MaxLength="255" 
                                    CssClass="medium AutoCompletesearchBox" meta:resourcekey="txtTestNameResource1"
                                    ></asp:TextBox>
                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                           
                            <td>
                                <asp:Label ID="lblMethodName" Text="Method Name" runat="server" meta:resourcekey="lblMethodNameResource1" 
                                     ></asp:Label></td><td>
                                <asp:DropDownList 
                                    ID="ddlMethodName" runat="server" CssClass="medium" meta:resourcekey="ddlMethodNameResource1" 
                                     ></asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="h-50">
                            <td>
                                <asp:Label ID="lalProduct" Text="Product Name" runat="server" meta:resourcekey="lalProductResource1" 
                                     ></asp:Label></td><td>
                                <asp:TextBox 
                                    ID="txtProductName" runat="server" MaxLength="255" 
                                    CssClass="medium AutoCompletesearchBox" meta:resourcekey="txtProductNameResource1" 
                                    ></asp:TextBox><img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td>
                                <asp:Label ID="lblConsumptionQty" Text="Consumption Quantity" runat="server" meta:resourcekey="lblConsumptionQtyResource1" 
                                     ></asp:Label></td><td>
                                <asp:TextBox 
                                    ID="txtConsumptionQty" runat="server" MaxLength="6" CssClass="xsmaller"
                                    onkeydown="return validatenumber(event);" meta:resourcekey="txtConsumptionQtyResource1" 
                                     ></asp:TextBox><asp:DropDownList 
                                    ID="ddlUOMID" runat="server" CssClass="xsmaller"  
                                    onchange="return DDlUomOnchange();" meta:resourcekey="ddlUOMIDResource1"
                                     ></asp:DropDownList>
                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td>
                                <asp:Label ID="lblCalibration" Text="Calibration" runat="server" meta:resourcekey="lblCalibrationResource1" 
                                    ></asp:Label></td><td>
                                <asp:TextBox 
                                    ID="txtCalibration" runat="server" MaxLength="6" CssClass="xsmaller"
                                    onkeydown="return validatenumber(event);" meta:resourcekey="txtCalibrationResource1" 
                                     ></asp:TextBox>
                                <asp:DropDownList 
                                    ID="ddlCalibrationUOMID" runat="server" CssClass="xsmaller" meta:resourcekey="ddlCalibrationUOMIDResource1"  
                                     ></asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnAdd" Text="Add" CssClass="btn" OnClientClick="return fun_ValidatebtnAdd();"
                                     runat="server" meta:resourcekey="btnAddResource1"  /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:PlaceHolder ID="PlaceHolder1" runat="server">
                        <div id="divConsumption" class="w-100p hide">
                            <table id="tblConsumption" class="w-100p gridView">
                                <thead>
                                    <tr>
                                        <th>
                                            <asp:Label ID="lbltblProductName" Text="Product Name" runat="server" meta:resourcekey="lbltblProductNameResource1" 
                                                ></asp:Label></th><th>
                                            <asp:Label 
                                                ID="lbltblConsumptionQuantity" Text="Consumption Quantity" runat="server" meta:resourcekey="lbltblConsumptionQuantityResource1" 
                                                ></asp:Label></th><th>
                                            <asp:Label 
                                                ID="lbltblConsumptionUOM" Text="Consumption Quantity" runat="server" meta:resourcekey="lbltblConsumptionUOMResource1" 
                                                ></asp:Label></th><th>
                                            <asp:Label 
                                                ID="lbltblCalibration" Text="Calibration" runat="server" meta:resourcekey="lbltblCalibrationResource1" 
                                                ></asp:Label></th><th>
                                            <asp:Label 
                                                ID="lblTblCalibrationUOM" Text=" Calibration UOM" runat="server" meta:resourcekey="lblTblCalibrationUOMResource1" 
                                                ></asp:Label></th><th>
                                            <asp:Label 
                                                ID="lblTblAction" Text="Action" runat="server" meta:resourcekey="lblTblActionResource1" 
                                                ></asp:Label></th></tr></thead><tbody>
                                </tbody>
                            </table>
                            <table class="w-100p h-40">
                                <tr>
                                    <td class="a-right">
                                        <asp:Button ID="btnSave" Text="Save" CssClass="btn" 
                                            runat="server" OnClick="btnSave_Click"
                                            OnClientClick="return fun_ReadTbltblConsumption();" meta:resourcekey="btnSaveResource1" 
                                             /></td>
                                    <td class="a-left">
                                        <asp:Button ID="btnClear" Text="Clear" CssClass="btn" 
                                            runat="server" OnClientClick="fun_ClearALL();"
                                            OnClick="btnClear_Click" meta:resourcekey="btnClearResource1"  /></td>
                                </tr>
                            </table>
                        </div>
                    </asp:PlaceHolder>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="searchPanel w-100p marginT5 marginB5">
                        <tr class="panelHeader">
                            <td class="a-left" colspan="2">
                                <div class="show" id="DivAllergy13">
                                    <img src="../PlatForm/Images/showBids.gif" class="w-15 h-17 v-top pointer" onclick="showResponses('DivAllergy13','DivAllergy14','trContent',1);" />
                                    <span class="pointer" onclick="showResponses('DivAllergy13','DivAllergy14','trContent',1);">
                                        <asp:Label 
                                        ID="lblSearch" Text="Search" runat="server" meta:resourcekey="lblSearchResource1" 
                                         ></asp:Label></span></div><div class="hide" id="DivAllergy14">
                                    <img src="../PlatForm/Images/hideBids.gif" class="w-15 h-17 v-top pointer" onclick="showResponses('DivAllergy13','DivAllergy14','trContent',0);" />
                                    <span class="pointer" onclick="showResponses('DivAllergy13','DivAllergy14','trContent',0);">
                                        <asp:Label 
                                        ID="lblAllergyHeader01" Text="Search" runat="server" meta:resourcekey="lblAllergyHeader01Resource1" 
                                         ></asp:Label></span></div></td></tr><tr id="trContent" class="hide lh35" runat="server">
                            <td>
                                <table class="w-100p">
                                    <tr class="h-50">
                                               <td>
                                            <asp:Label ID="lblseaAnalyzerName" Text="Devices Name" runat="server" meta:resourcekey="lblseaAnalyzerNameResource1" 
                                                 ></asp:Label></td><td>
                                            <asp:DropDownList 
                                                ID="ddlseaAnalyzerName" runat="server" CssClass="medium" meta:resourcekey="ddlseaAnalyzerNameResource1" 
                                                 ></asp:DropDownList>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                        
                                             <td>
                                            <asp:Label ID="lblseaTestName" Text="Investigation Name" runat="server" meta:resourcekey="lblseaTestNameResource1" 
                                                 ></asp:Label></td><td>
                                            <asp:TextBox 
                                                ID="txtseaTestName" runat="server" MaxLength="255" 
                                                CssClass="medium AutoCompletesearchBox" meta:resourcekey="txtseaTestNameResource1" 
                                                ></asp:TextBox><img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblseaMethodName" Text="Method Name" runat="server" meta:resourcekey="lblseaMethodNameResource1" 
                                                 ></asp:Label></td><td>
                                            <asp:DropDownList 
                                                ID="ddlseaMethodName" runat="server" CssClass="medium" meta:resourcekey="ddlseaMethodNameResource1" 
                                                 ></asp:DropDownList>
                                        </td>
                                   
                                 
                                        <td>
                                            <asp:Button ID="btnGo" Text="GO" CssClass="btn"  runat="server"
                                                OnClick="btnGo_Click" OnClientClick="fun_ClearALL();" meta:resourcekey="btnGoResource1" 
                                                 /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="7">
                                            <asp:GridView ID="gvInvestigationDevices" runat="server" AutoGenerateColumns="False"
                                                CssClass="gridView w-100p" meta:resourcekey="gvInvestigationDevicesResource1" 
                                                 ><Columns>
                                                    <asp:TemplateField 
                                                        HeaderText="SNO" ItemStyle-HorizontalAlign="Justify" meta:resourcekey="TemplateFieldResource1" 
                                                        ><ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %></ItemTemplate><ItemStyle HorizontalAlign="Justify"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="Test Name" 
                                                        DataField="InvestigationName" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField 
                                                        HeaderText="Device Name" DataField="DevicesName" meta:resourcekey="BoundFieldResource2" 
                                                         />
                                                    <asp:BoundField 
                                                        HeaderText="Method" DataField="MethodName" meta:resourcekey="BoundFieldResource3" 
                                                         />
                                                    <asp:BoundField 
                                                        HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource4" 
                                                        />
                                                    <asp:BoundField 
                                                        HeaderText="Consumption Qty" DataField="ConsumptionQty" meta:resourcekey="BoundFieldResource5" 
                                                         />
                                                    <asp:TemplateField 
                                                        HeaderText="Action" meta:resourcekey="TemplateFieldResource2" ><ItemTemplate>
                                                            <asp:HiddenField 
                                                                ID="hdnInvProMapDetailID" runat="server" 
                                                                Value='<%# Bind("InvestigationProductMapDetailID") %>' /><input 
                                                                value="Delete" type="button" id="imgbtnDelete" runat="server"
                                                                class="ui-icon ui-icon-trash b-none pointerm pull-left marginL5 pointer" 
                                                                onclick="fun_updateInvestigationProductMappingStatus(this)" /> <input 
                                                                id="btnEdit" value="Edit" type="button" runat="server" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer pull-left"
                                                                title="Click to Edit" onclick="fun_EditConsumptiontbl(this);" /></ItemTemplate></asp:TemplateField></Columns></asp:GridView></td></tr></table></td></tr></table></td></tr></table><asp:HiddenField ID="hdnProductID" runat="server" />
        <asp:HiddenField ID="hdnInvestigationID" runat="server" />
        <asp:HiddenField ID="hdnseaInvestigationID" runat="server" />
        <asp:HiddenField ID="hdnOrgid" runat="server" Value="0" />
        <asp:HiddenField ID="hdnlstInvestigationProductMappingDetails" runat="server" />
        <input type="hidden" id="hdnInvestigationProductMapDetailID" value="0" />
        <input type="hidden" id="hdnInvestigationProductMapID" value="0" />
        <input type="hidden" id="hdnActionFlag" value="INSERT" />
        <asp:HiddenField 
            ID="hdnGVJsonData" runat="server" /><input type="hidden" id="hdnCheckExists" runat="server" value="" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <style type="text/css">
        .disabledHH
        {
            background-color: #FFF8DC;
        }
    </style>

    <script type="text/javascript">
    
    
    $(document).ready(function() {
                    
    
                $("#txtProductName").autocomplete({
                    minLength: 2,
                    autoFocus: true,
					open: function() {$($('.ui-autocomplete')).css('width','300px');},
                    source: function(request, response) {
                        var param = { prefixText: $('#txtProductName').val(),strOrgID:$("#hdnOrgid").val()};

                        $.ajax({
                            url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetProductList",
                            data: JSON.stringify(param),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",

                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.split('^')[0],
                                        value: item.split('^')[0],
										pValue: item.split('^')[1]

                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                var err = eval("(" + XMLHttpRequest.responseText + ")");
                                //alert(err.Message)
                                // console.log("Ajax Error!");  
                            }
                        });
                    },
                    select: function(e, i) {                    
                        $("#txtProductName").val(i.item.label);
                        $("#hdnProductID").val(i.item.pValue);     
                        //alert( $("#hdnProductID").val());               
                        return false;
                    },
                });
                
                
                 $("#txtTestName").autocomplete({
                    minLength: 2,
                    autoFocus: true,
					open: function() {$($('.ui-autocomplete')).css('width','300px');},
                    source: function(request, response) {
                        var param = { prefixText: $('#txtTestName').val(),strOrgID:$("#hdnOrgid").val(),DeviceID:$("#ddlAnalyzerName option:selected").val(),PageType:"CM"};
                        
                        
                        $.ajax({
                            url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetInvestigationList",
                            data: JSON.stringify(param),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",

                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.split('^')[0],
                                        value: item.split('^')[0],
										Tval: item.split('^')[1]

                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                var err = eval("(" + XMLHttpRequest.responseText + ")");
                                //alert(err.Message)
                                //console.log("Ajax Error!"); 
                                
                            }
                        });
                    },
                    select: function(e, i) {                    
                        $("#txtTestName").val(i.item.label);
                        $("#hdnInvestigationID").val(i.item.Tval);     
                        //alert( $("#hdnInvestigationID").val());               
                        return false;
                    },
                });
				
	 $("#txtseaTestName").autocomplete({
                    minLength: 2,
					open: function() {$($('.ui-autocomplete')).css('width','300px');},
                    source: function(request, response) {
                    
                        var param = { prefixText: $('#txtseaTestName').val(),strOrgID:$("#hdnOrgid").val(),DeviceID:$("#ddlseaAnalyzerName option:selected").val(),PageType:"CM"};

                        $.ajax({
                            url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetInvestigationList",
                            data: JSON.stringify(param),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",

                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.split('^')[0],
                                        value: item.split('^')[0],
										TSval: item.split('^')[1]

                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                var err = eval("(" + XMLHttpRequest.responseText + ")");
                                //alert(err.Message)
                                //console.log("Ajax Error!"); 
                                
                            }
                        });
                    },
                    select: function(e, i) {                    
                        $("#txtseaTestName").val(i.item.label);
                        $("#hdnseaInvestigationID").val(i.item.TSval);     
                        //alert( $("#hdnseaInvestigationID").val());               
                        return false;
                    },
                });
                           
                
            });
			
    
$('#txtProductName').keyup(function(e) {
    var key = e.which;
    
    if (key != 13 && e.keyCode != 9)  // the enter key code
    {
       $('#hdnProductID').val('');
        return false;
    }
});


$('#txtTestName').keyup(function(e) {
    var key = e.which;
    //alert(key);
    if (key != 13 && e.keyCode != 9)  // the enter key code  
    {
        $('#hdnInvestigationID').val('');
        return false;
    }
});

    </script>


<script src="Scripts/Js_ConsumptionMapping.js" type="text/javascript"></script>

</body>
</html>
