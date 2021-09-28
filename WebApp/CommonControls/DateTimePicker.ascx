<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateTimePicker.ascx.cs" Inherits="DateTimePicker" %>
<asp:DropDownList ID="C_ddlYear" runat="server" Style="z-index: 100; left: 143px;
    position: absolute; top: 7px" AutoPostBack="True" 
    OnSelectedIndexChanged="C_ddlYear_SelectedIndexChanged" 
    meta:resourcekey="C_ddlYearResource1">
    <asp:ListItem meta:resourcekey="ListItemResource1">1965</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource2">1966</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource3">1967</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource4">1968</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource5">1969</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource6">1970</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource7">1971</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource8">1972</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource9">1973</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource10">1974</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource11">1975</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource12">1976</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource13">1977</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource14">1978</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource15">1979</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource16">1980</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource17">1981</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource18">1982</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource19">1983</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource20">1984</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource21">1985</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource22">1986</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource23">1987</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource24">1988</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource25">1989</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource26">1990</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource27">1991</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource28">1992</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource29">1993</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource30">1994</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource31">1995</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource32">1996</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource33">1997</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource34">1998</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource35">1999</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource36">2000</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource37">2001</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource38">2002</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource39">2003</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource40">2004</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource41">2005</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource42">2006</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource43">2007</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource44">2008</asp:ListItem>
</asp:DropDownList>
<asp:DropDownList ID="C_ddlMonth" runat="server" Style="z-index: 101; left: 53px;
    position: absolute; top: 7px; right: 573px;" AutoPostBack="True" 
    OnSelectedIndexChanged="C_ddlMonth_SelectedIndexChanged" 
    meta:resourcekey="C_ddlMonthResource1">
    <asp:ListItem Value="01" meta:resourcekey="ListItemResource45">January</asp:ListItem>
    <asp:ListItem Value="02" meta:resourcekey="ListItemResource46">February</asp:ListItem>
    <asp:ListItem Value="03" meta:resourcekey="ListItemResource47">March</asp:ListItem>
    <asp:ListItem Value="04" meta:resourcekey="ListItemResource48">April</asp:ListItem>
    <asp:ListItem Value="05" meta:resourcekey="ListItemResource49">May</asp:ListItem>
    <asp:ListItem Value="06" meta:resourcekey="ListItemResource50">June</asp:ListItem>
    <asp:ListItem Value="07" meta:resourcekey="ListItemResource51">July</asp:ListItem>
    <asp:ListItem Value="08" meta:resourcekey="ListItemResource52">August</asp:ListItem>
    <asp:ListItem Value="09" meta:resourcekey="ListItemResource53">September</asp:ListItem>
    <asp:ListItem Value="10" meta:resourcekey="ListItemResource54">October</asp:ListItem>
    <asp:ListItem Value="11" meta:resourcekey="ListItemResource55">November</asp:ListItem>
    <asp:ListItem Value="12" meta:resourcekey="ListItemResource56">December</asp:ListItem>
</asp:DropDownList>
<asp:DropDownList ID="C_ddlDay" runat="server" Style="z-index: 103; left: 9px;
    position: absolute; top: 7px" Width="44px" AutoPostBack="True" 
    OnSelectedIndexChanged="C_ddlDay_SelectedIndexChanged" 
    meta:resourcekey="C_ddlDayResource1">
    <asp:ListItem meta:resourcekey="ListItemResource57">1</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource58">2</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource59">3</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource60">4</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource61">5</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource62">6</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource63">7</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource64">8</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource65">9</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource66">10</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource67">11</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource68">12</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource69">13</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource70">14</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource71">15</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource72">16</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource73">17</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource74">18</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource75">19</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource76">20</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource77">21</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource78">22</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource79">23</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource80">24</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource81">25</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource82">26</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource83">27</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource84">28</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource85">29</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource86">30</asp:ListItem>
    <asp:ListItem meta:resourcekey="ListItemResource87">31</asp:ListItem>
</asp:DropDownList>
