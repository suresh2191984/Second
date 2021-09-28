<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientHeader.ascx.cs" Inherits="CommonControls_PatientHeader" %>



<!-- PNG FIX for IE6 -->
<!-- http://24ways.org/2007/supersleight-transparent-png-in-ie6 -->
<!--[if lte IE 6]>
		<script type="text/javascript" src="js/pngfix/supersleight-min.js"></script>
	<![endif]-->
<!-- Panel -->
<div id="toppanel">
    <div id="panel">
        <div class="content clearfix">
            <table class="w-100p">
                <tr>
                    <td class="v-top">
                        <table cellspacing="2" class="w-100p PatentHeader">
                            <tr>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblPatient" Text="Name" runat="server" meta:resourcekey="lblPatientResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblTitleName" runat="server" meta:resourcekey="lblTitleNameResource1"></asp:Label>
                                    <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblPateintNu" Text="PatientNumber" runat="server" meta:resourcekey="lblPatientNumber" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblPatientNumber" runat="server" 
                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblAgeText" Text="Age" runat="server" meta:resourcekey="lblAgeTextResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblSexText" Text="Sex" runat="server" meta:resourcekey="lblSexTextResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblMaritalText" Text="Marital Status" runat="server" meta:resourcekey="lblMaritalTextResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblMartial" runat="server" meta:resourcekey="lblMartialResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblClientText" Text="Client Name" runat="server" meta:resourcekey="lblClientTextResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblClient" runat="server" meta:resourcekey="lblClientResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" class="a-right">
                                    <asp:Label ID="lblRateText" Text="Ratecard Name" runat="server" meta:resourcekey="lblRateTextResource1" />
                                </td>
                                <td><b>:</b></td>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblRate" runat="server" meta:resourcekey="lblRateResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap">
                                    <img alt="" src="../Images/allergy-icon.png" runat="server" id="imgallergy" class="hide" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="30%" class="a-center">
                        <ul>
                            <li>
                                <asp:Label ID="vitalsImg" Text="Patient Vitals" CssClass="PatientVitals" runat="server"
                                     meta:resourcekey="vitalsImgResource1" />
                            </li>
                        </ul>
                        <ul class="casesummary">
                            <li id="VSummry1" runat="server" class="casesummary">BP :<asp:Label ID="lblBP" runat="server"
                                meta:resourcekey="lblBPResource1"></asp:Label>
                                <asp:Label ID="lblBPVal" runat="server" meta:resourcekey="llblBPValResource1">/</asp:Label>
                                <asp:Label ID="lblBPUOMCode" runat="server" meta:resourcekey="lblBPUOMCodeResource1"></asp:Label></li>
                            <li id="VSummry2" runat="server" class="casesummary">RR :<asp:Label ID="lblTemp"
                                runat="server" meta:resourcekey="lblTempResource1"></asp:Label>
                                <asp:Label ID="lblTempVal" runat="server" meta:resourcekey="lblTempValResource1"></asp:Label>
                                <asp:Label ID="lblTempUOMCode" runat="server" meta:resourcekey="lblTempUOMCodeResource1"></asp:Label></li>
                            <li id="VSummry3" runat="server" class="casesummary">PR :<asp:Label ID="lblPulse"
                                runat="server" meta:resourcekey="lblPulseResource1"></asp:Label>
                                <asp:Label ID="lblPulseVal" runat="server" meta:resourcekey="lblPulseValResource1"></asp:Label>
                                <asp:Label ID="lblPulseUOMCode" runat="server" meta:resourcekey="lblPulseUOMCodeResource1"></asp:Label></li>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!-- /login -->
    <!-- The tab on top -->
    <div class="tab hide">
        <ul class="login">
            <li class="left"></li>
            <li id="toggle"><a id="open" class="open" href="#">Open Panel</a><a id="close" style="display: none;"
                class="close" href="#">Close Panel</a> </li>
            <li class="right"></li>
        </ul>
    </div>
    <!-- / top -->
</div>

<script type="text/javascript">

    var datadiv_tooltip = false;
    var datadiv_tooltipShadow = false;
    var datadiv_shadowSize = 4;
    var datadiv_tooltipMaxWidth = 200;
    var datadiv_tooltipMinWidth = 100;
    var datadiv_iframe = false;
    var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
    function showTooltip(e, tooltipTxt) {

        var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

        if (!datadiv_tooltip) {
            datadiv_tooltip = document.createElement('DIV');
            datadiv_tooltip.id = 'datadiv_tooltip';
            datadiv_tooltipShadow = document.createElement('DIV');
            datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

            document.body.appendChild(datadiv_tooltip);
            document.body.appendChild(datadiv_tooltipShadow);

            if (tooltip_is_msie) {
                datadiv_iframe = document.createElement('IFRAME');
                datadiv_iframe.frameborder = '5';
                datadiv_iframe.style.backgroundColor = '#FFFFFF';
                datadiv_iframe.src = '#';
                datadiv_iframe.style.zIndex = 100;
                datadiv_iframe.style.position = 'absolute';
                document.body.appendChild(datadiv_iframe);
            }

        }

        datadiv_tooltip.style.display = 'block';
        datadiv_tooltipShadow.style.display = 'block';
        if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

        var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
        var leftPos = e.clientX + 10;

        datadiv_tooltip.style.width = null; // Reset style width if it's set 
        datadiv_tooltip.innerHTML = tooltipTxt;
        datadiv_tooltip.style.left = leftPos + 'px';
        datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


        datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
        datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

        if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
            datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
        }

        var tooltipWidth = datadiv_tooltip.offsetWidth;
        if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


        datadiv_tooltip.style.width = tooltipWidth + 'px';
        datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
        datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

        if ((leftPos + tooltipWidth) > bodyWidth) {
            datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
            datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
        }

        if (tooltip_is_msie) {
            datadiv_iframe.style.left = datadiv_tooltip.style.left;
            datadiv_iframe.style.top = datadiv_tooltip.style.top;
            datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
            datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

        }

    }

    function hideTooltip() {
        datadiv_tooltip.style.display = 'none';
        datadiv_tooltipShadow.style.display = 'none';
        if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
    }
</script>

