<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ParasiticInfections.ascx.cs"
    Inherits="CommonControls_ParasiticInfections" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   function showdiv2() {
            document.getElementById("ucDynamic_ucParasiticInfections_divChkList").style.display = "block";
      }
      function showdivonClick2() {
            var objDLL = document.getElementById("ucDynamic_ucParasiticInfections_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem2(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic_ucParasiticInfections_ddlChkList");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic_ucParasiticInfections_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic_ucParasiticInfections_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic_ucParasiticInfections_hidListPara');
            for (i = 0; i < arr.length; i++) {
                  checkbox = arr[i];
                  if (i == lstNo) {
                        if (ctrlType == 'anchor') {
                              if (!checkbox.checked) {
                                    checkbox.checked = true;
                              }
                              else {
                                    checkbox.checked = false;
                              }
                        }
                  }
                  if (checkbox.checked) {
                        if (selectedItems == "") {
                              selectedItems = arrlbl[i].innerText;
                        }
                        else {
                              selectedItems = selectedItems + "," + arrlbl[i].innerText;
                        }
                        noItemChecked = noItemChecked + 1;
                  }
            }
            ddlReport.title = selectedItems;
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            if (noItemChecked == 1)
                  ddlReport.options[ddlReport.selectedIndex].text = lstValue;
            else
                  ddlReport.options[ddlReport.selectedIndex].text = noItemChecked + " Items";
            document.getElementById('ucDynamic_ucParasiticInfections_hidListPara').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic_ucParasiticInfections_lblCheckItemsPara').innerText=selectedItems;
      }
//     document.onclick = check2;   
//      function check2(e) {
//            var target = (e && e.target) || (event && event.srcElement);
//            var obj = document.getElementById('ucDynamic_ucSickleCellAnamia_divChkList');
//            var obj1 = document.getElementById('ucDynamic_ucSickleCellAnamia_ddlChkList');
//            var obj2 = document.getElementById('ucDynamic_ucLiver_divChkList');
//            var obj3 = document.getElementById('ucDynamic_ucLiver_ddlChkList');
//            if (target.id != "alst" && !target.id.match("chkLstItem")) {
//                  if (!(target == obj || target == obj1 || target == obj2 || target == obj3)) {
//                        obj.style.display = 'none';
//                        obj2.style.display='none';
//                  }
//                  else if (target == obj || target == obj1 || target == obj2 || target == obj3) {
//                        if (obj.style.display == 'block') {
//                              obj.style.display = 'block';
//                        }
//                        else {
//                              obj.style.display = 'none';
//                              document.getElementById('ucDynamic_ucSickleCellAnamia_ddlChkList').blur();
//                              document.getElementById('ucDynamic_ucLiver_ddlChkList').blur();
//                        }
//                  }
//            }
//      }
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trParasiticInfections" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblParasiticInfections_972" runat="server" Text="Parasitic Infections" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_972" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_972" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_972" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_972" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="3">
                            <asp:PlaceHolder ID="phDDLCHKPara" runat="server"></asp:PlaceHolder>
                            <asp:Label ID="lblCheckItemsPara" Height="50%" Width="30%" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
<asp:HiddenField ID="hidListPara" runat="server" />