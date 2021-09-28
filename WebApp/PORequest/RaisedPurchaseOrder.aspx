<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaisedPurchaseOrder.aspx.cs"
    EnableEventValidation="false" Inherits="PORequest_RaisedPurchaseOrder" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Raise Purchase order</title>
 
    

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
            
             <table class="dataheader2 defaultfontcolor w-100p gridView">
                <tr>
                    <td>
                        <asp:HiddenField ID="hdbValues" runat="server" />
                        <asp:GridView ID="grdResult" EnableViewState="true" runat="server" AutoGenerateColumns="False"
                            CellPadding="2" CssClass="gridView" Width="100%" DataKeyNames="ID" OnRowDataBound="grdResult_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Products">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnParentProductid" runat="server" Value='<%# Eval("ParentProductID")%>' />
                                        <asp:Label ID="lblproducts" Text='<%# Eval("Description")%>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="hdnproductid" runat="server" Value='<%# Eval("ProductID")%>' />
                                        <asp:HiddenField ID="hdnpoRequestid" runat="server" Value='<%# Eval("AttributeDetail")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Supplier">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlSup" runat="server">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RequestQuantity">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtQty" Text='<%# Eval("OrderedQty")%>' runat="server" onkeypress="return ValidateMultiLangChar(this);"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Units" Visible="true">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlUnits" runat="server">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hdnunitss"  runat="server" />
                                        <asp:HiddenField ID="hdnunitsvalue" runat="server" />
                                        <asp:HiddenField ID="hdnconvesrsiondata" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="RequestQuantity">
                                    <ItemTemplate>
                                         <asp:Button ID="btnratemapping" Text="RateMapping" runat="server" CssClass="btn" 
                                         onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" CommandArgument="RateMapping" />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                        <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
                            top: 3%">
                            <div onclick="hidebox();return false" class="divCloseRight">
                            </div>
                            <table border="0" width="453px" cellspacing="1" class="modalPopup dataheaderPopup"
                                cellpadding="1">
                                <tr>
                                    <td id="dragbar" class="moveCursor pointer" width="100%" onmousedown="initializedrag(event)">
                                        <asp:Label ID="lblProductDetails" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnPO" runat="server" Text="RaisePO" ToolTip=""
                             CssClass="btn pointer" OnClick="btnPO_Click" OnClientClick="Javascript:return validate();" />
                        <%--     <asp:Button ID="btnsupplier" runat="server" Text="SupplierRateMapping" ToolTip=""
                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="btnsupplier_Click" />--%>
                    </td>
                </tr>
            </table>
            <%-- <asp:UpdatePanel ID="raisedPR" runat="server">
                <ContentTemplate>--%>
            <%-- <asp:Panel ID="pnlsupplier" runat="server" Style="display: none" Width="70%" Height="80%"
                        CssClass="modalPopup dataheaderPopup">
                        <div  >
                        <asp:ImageButton CssClass="TitlebarRight" runat="server"  ID="btnClosepn"  OnClick="btnClosepn_Click" />
                        </div>
                                        <asp:Label ID="lblproductss" runat="server" />
                                        <iframe id="iframesupplier" src="ProductSupplierRateMapping.aspx?CPage=Y" height="95%"
                                        width="100%" frameborder="0" runat="server"></iframe>
                         
                    </asp:Panel>--%>
            <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
            <%--<asp:Button ID="btnClosepn" runat="server"  />--%>
            <%--<cc1:ModalPopupExtender ID="ModalPopupExtender1"  runat="server"
                TargetControlID="btnsupplier" PopupControlID="pnlsupplier" BackgroundCssClass="modalBackground"
                DropShadow="false"  />--%>
        </div>
                
        <asp:HiddenField ID="hdnunits" runat="server" />
        <asp:HiddenField ID="hdnproductsdata" runat="server" />
        <asp:HiddenField ID="hdnprid" runat="server" />
        <asp:HiddenField ID="ddlSupListCount" runat="server" />
    
     <asp:HiddenField ID ="hdnMessages" runat ="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script type="text/javascript" language="javascript">
        var userMsg;
        function validate() {
            var flag = true;
            var dropdowns = new Array(); //Create array to hold all the dropdown lists.
            var gridview = document.getElementById('grdResult'); //GridView1 is the id of ur gridview.
            dropdowns = gridview.getElementsByTagName('select'); //Get all dropdown lists contained in GridView1.
            for (var i = 0; i < dropdowns.length; i++) {
                if (dropdowns.item(i).value == '0') //If dropdown has no selected value
                {
                    flag = false;
                    break; //break the loop as there is no need to check further.
                }
            }
            if (!flag) {
                userMsg = SListForApplicationMessages.Get('Inventory\\RaisedPurchaseOrder.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Please select value in each dropdown');
                    return false;

                }
            }
            return flag;
        }

        function BindUnits(pUnites, pSuppliervalues, pconvesrsiondata) {

            var ddlSupplierList = document.getElementById(pSuppliervalues).value;
            var splt = document.getElementById(pconvesrsiondata).value;
            var drpunits = document.getElementById(pUnites);
            drpunits.options.length = 0;
            var optn2 = document.createElement("option");
            drpunits.options.add(optn2);
            optn2.text = "-Select-";
            optn2.value = "0";
            var t = splt.split('^');

            for (i = 0; i < t.length; i++) {
                var list1 = t[i].split('#');
                if (t[i] != "") {
                    var supplier = list1[0].split('~');
                    for (j = 1; j < list1.length; j++) {
                        var res = list1[j].split('~')
                        if (list1[j] != "") {

                            if (supplier[2] == ddlSupplierList) {
                                var optns = document.createElement("option");
                                drpunits.options.add(optns);
                                optns.text = res[0];
                                optns.value = res[3];
                                $('#hdnunitss').val(res[0]);
                            }
                        }
                    }



                }
            }


        }

        function SetSuppliers() {
            var ddlSupListCount = document.getElementById("ddlSupListCount").value.split("^");
            for (k = 0; k < ddlSupListCount.length; k++) {
                if (ddlSupListCount[k].trim() != "") {
                    document.getElementById(ddlSupListCount[k].trim()).onchange();

                }
            }
        }
        function Unitschange(punits, hdnvalue, hnunitspvalue) {
            var drpunits = document.getElementById(punits).options[document.getElementById(punits).selectedIndex].text;
            var unitvalues = document.getElementById(punits).value;
            document.getElementById(hdnvalue).value = drpunits + '~' + unitvalues;
            document.getElementById(hnunitspvalue).value = unitvalues;

        }
        function cancel() {
            document.getElementById('btnClosepn').click();
        }

        function ProductSupplierlist(productmap) {
            var table = '';
            var tr = '';
            var end = '</table>';
            var y = '';
            document.getElementById('lblProductDetails').innerHTML = '';
            table = "<table class='gridView w-100p'"
                           + "><thead class='gridHeader a-left'>"
                           + "<th class='w-200p'>Product Name</th>"
                           + "<th class='w-150p'>Supplier Name</th>"
                           + "<th class='w-100p'>Unit</th>"
                           + "<th class='w-150p'>UnitPrice</th> </thead>";



            var lis = productmap.split('^');
            var sum = 0;
            var pcount = 0
            for (i = lis.length - 1; i >= 0; i--) {
                if (lis[i] != "") {
                    var y = lis[i].split('#');
                    var pname = y[0].split('~')[1];
                    var sname = y[0].split('~')[3];
                    for (j = 1; j < y.length; j++) {
                        var tblData = y[j].split('~')
                        if (tblData != "") {
                            if (tblData[4].trim() == 'R') {
                                tr += "<tr class='font10 h-10 a-left'><td class='w-200p'>"
                        + pname + "</td><td class='w-150p'>"
                        + sname + "</td><td class='w-100p'>"
                        + tblData[0] + "</td><td class='w-150p'>"
                        + tblData[1].trim() + "</td></tr>"
                                //                        + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                //                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                //                                                  "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] +
                                //                                                 "' onclick='btnEdit_OnClick(name);' value = 'select' type='button' style='font-size:10px;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                                //                        + "" + Tname + "</td>
                                //                        "</tr>";
                            }
                        }
                    }

                }
            }
            var tab = table + tr + end;
            document.getElementById('lblProductDetails').innerHTML = tab;
            tbshow();
        }
        var ns4 = document.layers
        var ie4 = document.all
        var ns6 = document.getElementById && !document.all


        var dragswitch = 0
        var nsx
        var nsy
        var nstemp

        function drag_dropns(name) {
            if (!ns4)
                return
            temp = eval(name)
            temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
            temp.onmousedown = gons
            temp.onmousemove = dragns
            temp.onmouseup = stopns
        }

        function gons(e) {
            temp.captureEvents(Event.MOUSEMOVE)
            nsx = e.x
            nsy = e.y
        }
        function dragns(e) {
            if (dragswitch == 1) {
                temp.moveBy(e.x - nsx, e.y - nsy)
                return false
            }
        }

        function stopns() {
            temp.releaseEvents(Event.MOUSEMOVE)
        }

        //drag drop function for ie4+ and NS6////
        /////////////////////////////////


        function drag_drop(e) {
            if (ie4 && dragapproved) {
                crossobj.style.left = tempx + event.clientX - offsetx
                crossobj.style.top = tempy + event.clientY - offsety
                return false
            }
            else if (ns6 && dragapproved) {
                crossobj.style.left = tempx + e.clientX - offsetx + "px"
                crossobj.style.top = tempy + e.clientY - offsety + "px"
                return false
            }
        }

        function initializedrag(e) {
            crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
            var firedobj = ns6 ? e.target : event.srcElement
            var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
            while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
                firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
            }

            if (firedobj.id == "dragbar") {
                offsetx = ie4 ? event.clientX : e.clientX
                offsety = ie4 ? event.clientY : e.clientY

                tempx = parseInt(crossobj.style.left)
                tempy = parseInt(crossobj.style.top)

                dragapproved = true
                document.onmousemove = drag_drop
            }
        }

        ////drag drop functions end here//////

        function hidebox() {
            crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

            crossobj.style.display = "none"

        }
        function tbshow() {
            document.onmouseup = new Function("dragapproved=false")

            document.getElementById("showimage").style.display = "block";
        }
        function Make_OnClick(sEditedData) {
        }
    </script>
</body>
</html>
