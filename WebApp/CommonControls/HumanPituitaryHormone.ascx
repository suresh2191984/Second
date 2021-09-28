<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HumanPituitaryHormone.ascx.cs"
    Inherits="CommonControls_HumanPituitaryHormone" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   function showdiv3() {
            document.getElementById("ucDynamic_ucHumanPituitaryHormone_divChkList").style.display = "block";
      }
      function showdivonClick3() {
            var objDLL = document.getElementById("ucDynamic_ucHumanPituitaryHormone_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem3(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic_ucHumanPituitaryHormone_ddlChkList");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic_ucHumanPituitaryHormone_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic_ucHumanPituitaryHormone_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic_ucHumanPituitaryHormone_hidListMedication');
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
            document.getElementById('ucDynamic_ucHumanPituitaryHormone_hidListMedication').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic_ucHumanPituitaryHormone_lblCheckItemsMedication').innerText=selectedItems;
      }
     
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trHumanPituitaryHormone" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblHumanPituitaryHormone_1112" runat="server" Text="Medications" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1112" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1112" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1112" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td valign="bottom" colspan="3" align="right">
            <div id="divrdoYes_1112" runat="server" style="display: none">
                <table cellpadding="0" align="left" width="100%">
                    <tr valign="bottom" align="center">
                        <td colspan="3" valign="bottom" align="left">
                            <asp:PlaceHolder ID="phDDLCHKMedication" runat="server"></asp:PlaceHolder>
                            <asp:Label ID="lblCheckItemsMedication" Height="50%" Width="30%" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
<asp:HiddenField ID="hidListMedication" runat="server" />