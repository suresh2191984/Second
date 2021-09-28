<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Topheader.ascx.cs" Inherits="CommonControls_Topheader" %>
<%--<%@ Register Src="../CommonControls_ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<table class="pageHeading bg-secondary header-color">
    <tr>
        <td class="smallheaderleft padding0 margin0" id="imagetd">
            <div class="pull-left" style="width: 40px;">
                <img alt="" onclick="Showmenu_New();Showhide_New();" src="../Images/hide.png" id="showmenu"
                    class="show pointer pull-left paddingR3" style="height: 15px; width: 15px;margin-left: 3px;" />
                <img alt="toogleimage" src="../Images/v-menu.png" id="toogleimage" class="show menuToogle pointer pull-left"
                    menudir="d" style="height: 15px; width: 15px;" />
            </div>
        </td>
        <td class="w-30p">
            <div class="paddingL10 pageName">
                <asp:Label ID="lblvalue" runat="server" Text="Home" meta:resourcekey="lblvalueResource1"></asp:Label></div>
        </td>
        <td id="hideShowHeader" runat="server" class="hideShow a-right paddingR10">
          <%--  <ul>
                <li>--%>
                   <%-- <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                   <asp:ImageButton ID="hideButton" runat="server" CssClass="hideButton" ImageUrl="../Images/show-panel.png" title="Click Here to show/hide Header" OnClientClick="hideButton_Click(); return false"  meta:resourcekey="hideButtonResource1"/>
                   <asp:ImageButton ID="showButton" runat="server" CssClass="showButton" ImageUrl="../Images/hide-panel.png" title="Click Here to show/hide Header" OnClientClick="showButton_Click(); return false" style="display:none;"  meta:resourcekey="showButtonResource1"/>
               <%-- </li>
            </ul>--%>
        </td>
        <td class="w-3p">
            <asp:ImageButton ID="ImgBtnHome" runat="server" ImageUrl="../Images/home111.png"
                OnClick="ImgBtnHome_Click" />
        </td>
    </tr>
</table>
<script type="text/javascript">
    function hideButton_Click() {
      //  $("#header").attr("style", "display:none;");
        //   $("#navigation").attr("style", "display:none;");
        $("#header").hide();
        $("#navigation").hide();
        $("#Attuneheader_TopHeader1_hideButton").attr("style", "display:none;");
        $("#Attuneheader_TopHeader1_showButton").attr("style", "display:inline;");
        $(".pageHeading").addClass("pageHeadingBorder");
        
        window.contentHieght = $(window).height() - ($('.tdspace').children().first().height() + $('#footer').height() + 5); //10 for contentdata padding top

        $('.contentdata').height(window.contentHieght);
        
        return true;
    }
    function showButton_Click() {
        //$("#header").attr("style", "display:block;");
        //$("#navigation").attr("style", "display:inline-block;");
        $("#header").show();
        $("#navigation").show();
        $("#Attuneheader_TopHeader1_hideButton").attr("style", "display:inline;");
        $("#Attuneheader_TopHeader1_showButton").attr("style", "display:none;");
        $(".pageHeading").removeClass("pageHeadingBorder");
        $("#imagetd").addClass("imageNone");
        $("#v-image").attr("style", "display:block;");
        window.contentHieght = $(window).height() - ($('#header').height() + $('.tdspace').children().first().height() + $('#footer').height() + $(".newMenu").height() + 15);

        $('.contentdata').height(window.contentHieght);
        return true;
    }
</script>