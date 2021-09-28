<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer.ascx.cs" Inherits="CommonControls_Footer" %>
<%@ Register Src="FeedbackControl.ascx" TagName="Feedback" TagPrefix="FB" %>
<script type="text/javascript" language="javascript">

    function Count(text, long) {
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_Footer_ascx_01") != null ? SListForAppMsg.Get("CommonControls_Footer_ascx_01") : "Only";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_Footer_ascx_02") != null ? SListForAppMsg.Get("CommonControls_Footer_ascx_02") : "characters allowed.";
        var maxlength = new Number(long); // Change number to your max length.
        if (text.value.length > maxlength) {
            text.value = text.value.substring(0, maxlength);
          //alert(" Only " + long + " characters allowed.");
            ValidationWindow(UsrAlrtMsg+long+UsrAlrtMsg1, AlrtWinHdr);
        }
    }

   

    function ShowDivsFeedBack() {

        document.getElementById('<%= divFeedBack1.ClientID %>').style.display = "block";
        //document.getElementById('Footer1_fade').style.display = "block";
        $("#Footer1_fade").show("slow");
        $("#divFeedBack1").show("slow");
        $("#divFeedBack2").show("slow");
        $("#divFeedBack3").show("slow");
        $('[id$="divFeedBack1"]').css({ "position": "fixed", "top": "10px", "right": "10px" });

        //$('[id$="divFeedBack1"]').draggable();
    }
    function HideDivsFeedBack() {

        $("#divFeedBack2").hide("slow");
        $("#divFeedBack3").hide("slow");
        $("#divFeedBack1").hide("slow");
        document.getElementById('<%= divFeedBack1.ClientID %>').style.display = "none";
        //document.getElementById('Footer1_fade').style.display = "none";
        $("#Footer1_fade").hide("slow");
        //$('[id$="divFeedBack1"]').css({ "position": "absolute", "top": "500px", "right": "1000px" });
    }
    //    function expandBox(id) {
    //        document.getElementById(id).rows = "10";
    //    }
    //    function collapseBox(id) {
    //        document.getElementById(id).rows = "5";
    //    }
</script>
<div id="footer">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="footerright">
                <%--<img src="../Images/footer_left.png" alt="footer" width="13" height="27" />--%>
            </td>
            <td class="footer_value">
                <asp:Literal ID="Literal1" Text="Copyright&#169; 2011. All Rights Reserved." runat="server"
                    meta:resourcekey="Literal1Resource1"></asp:Literal>
            </td>
            <td class="footer_value" valign="middle">
                <%--<img src="../Images/images2.jpg" alt="pageid" height="22px" width="30px"  Style="position:relative;" />--%>
                <div style="display: inline-block; height: 17px; padding-left:3px; padding-right:3px; background-color: Yellow; border: solid 1px black; text-align:center; vertical-align:middle; color:Black; padding-top:4px;">
                    <asp:Label ID="LtPageId" runat="server" style="" 
                        meta:resourcekey="LtPageIdResource1"></asp:Label>
                </div>
            </td>
            <td class="footer_value" align="right" visible="false" id="tdMacAddress" runat="server">
                <asp:Literal ID="lblMacAddress" runat="server" Text="Machine ID: " meta:resourcekey="lblMacAddressResource1"></asp:Literal>
                <asp:Literal ID="LtMacAddress" runat="server" 
                    meta:resourcekey="LtMacAddressResource1"></asp:Literal>
            </td>
            <td>
             <%--FeedBack starts--%>
                <table border="0" id="divFeedBack1" runat="server" style="display: none; z-index: 2000;">
                    <tr>
                        <td>
                        
                           <FB:Feedback ID="FeedbackCtrl" runat="server" />
                        </td>
                    </tr>
                </table>
                <table id="divFBFloat" runat ="server" style="display:none; border:1px;  border-style: none; position: fixed; top: 135px; right: 0px;">
                    <tr>
                        <td align="center" style="border-width: 0px; border-style: none; border-color: white;
                            cursor: pointer;">
                            <table width="100%">
                                <tr align="center">
                                    <td align="center" nowrap="nowrap" onclick="ShowDivsFeedBack();">
                                        <img id="img1" runat="server" src="~/Images/feedback-button.png" width="26" height="98"
                                            title="Enter Feedback" style="cursor: pointer; background-color: Yellow; border-width: 1px;
                                            border-color: white; border-style: none;" onclick="ShowDivsFeedBack()" />
                                    </td>
                                    <td align="right" nowrap="nowrap" id="div1ss" style="display: none">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
               <div id="fade" style="position: absolute; display: none; background-color: #000000;
                    top: 0px; left: 0px; width: 100%; height: 100%; z-index: 1000; opacity: 0.7;filter: alpha(opacity=70); -khtml-opacity: 0.7; -moz-opacity: 0.7;" runat="server">
                </div>
                <%--FeedBack ends--%>
            </td>
            <td class="footer_value" align="right">
                <asp:Literal ID="LtBuildNo" runat="server" 
                    meta:resourcekey="LtBuildNoResource1"></asp:Literal>
            </td>
        </tr>
    </table>
</div>
