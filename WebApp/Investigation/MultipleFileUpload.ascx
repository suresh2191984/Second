<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MultipleFileUpload.ascx.cs" Inherits="Investigation_MultipleFileUpload" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<%--<script src="../Scripts/jquery_MultiFileplugin.js" type="text/javascript"></script>--%>

<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

<script type="text/javascript">

    function OnFileDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDeleted = SListForAppMsg.Get('Investigation_MultipleFileUpload_ascx_01') == null ? "Deleted Successfully.." : SListForAppMsg.Get('Investigation_MultipleFileUpload_ascx_01');
        var vUnable = SListForAppMsg.Get('Investigation_MultipleFileUpload_ascx_02') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_MultipleFileUpload_ascx_02');

        try {
            var $row = $(obj).closest('tr');
            var FileID = $row.find("input[id$='HiddenFileID']").val();
            var orgID = $row.find("input[id$='HiddenOrgID']").val();
            if (FileID == '' || FileID == undefined) {
                FileID = '0';
            }

            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteMultiUploadFiles",
                data: "{ID: " + FileID + ",OrgID: " + orgID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('tr').remove();
                    //alert("Deleted Successfully..");
                    ValidationWindow(vDeleted, AlertType);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vUnable, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }


</script>


    <div id="diveHide" style="display: block;">
        <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
            onclick="showResponses('diveHide','diveShow','divshowhide',1);" />
        <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('diveHide','diveShow','divshowhide',1);">
        <%=Resources.Investigation_ClientDisplay.Investigation_MultipleFileUpload_ascx_01 %></span>
    </div>
    <div id="diveShow" style="display: none;">
        <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
            style="cursor: pointer" onclick="showResponses('diveHide','diveShow','divshowhide',0);" />
        <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('diveHide','diveShow','divshowhide',0);">
        <%=Resources.Investigation_ClientDisplay.Investigation_MultipleFileUpload_ascx_01 %></span>
    </div>
    <div id="divshowhide" style="display:none;">
    <table>
        <tr>
            <td>
                <%=Resources.Investigation_ClientDisplay.Investigation_MultipleFileUpload_ascx_02 %>
            </td>
            <td>
                <asp:FileUpload ID="MutipleFileUpload" runat="server" class="multi" 
                    meta:resourcekey="MutipleFileUploadResource1" />
                <input type="hidden" runat="server" id="hdnMultiFilename" />
            </td>
        </tr>
        <tr>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td style="width: 30%; vertical-align: top;">
                            <div class="mytable1" style="overflow: auto; max-height: 200px" id="tdrptUpload"
                                runat="server" visible="false">
                                <table cellpadding="3" cellspacing="0" width="100%">
                                    <thead>
                                        <tr style="height: 17px;" class="dataheader1">
                                            <th style="width: 15%;">
                                                <asp:Label runat="server" ID="thProbes" Text="File Name" 
                                                    meta:resourcekey="thProbesResource1" />
                                            </th>
                                            <th style="width: 15%;">
                                                <asp:Label runat="server" ID="thimage" Text="Download" 
                                                    meta:resourcekey="thimageResource1" />
                                            </th>
                                            <th style="width: 15%;">
                                                <asp:Label runat="server" ID="Label2" Text="Action" 
                                                    meta:resourcekey="Label2Resource1" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptCommonUpload" runat="server" OnItemDataBound="CommonUpload_ItemBound">
                                            <ItemTemplate>
                                                <tr style="height: 17px;">
                                                    <td align="left">
                                                        <asp:Label ID="FilePath" runat="server" Text='<%# Bind("FileUrl") %>' 
                                                            meta:resourcekey="FilePathResource1"></asp:Label>
                                                        <asp:HiddenField ID="HiddenFileUrl" runat="server" Value='<%# Bind("FileUrl") %>' />
                                                        <asp:HiddenField ID="HiddenFileID" runat="server" Value='<%# Eval("FileID") %>' />
                                                        <asp:HiddenField ID="HiddenIdentifyingType" runat="server" Value='<%# Eval("IdentifyingType") %>' />
                                                        <asp:HiddenField ID="HiddenOrgID" runat="server" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:HyperLink ID="HyperFileDownload" runat="server" Text="Download" 
                                                            meta:resourcekey="HyperFileDownloadResource1"></asp:HyperLink>
                                                    </td>
                                                    <td align="center">
                                                        <input id="btnDelete" runat="server" value="Delete" type="button" style="background-color: Transparent;
                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                            font-size: 11px;" onclick="OnFileDelete(this);" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
