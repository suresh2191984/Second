<?xml version="1.0" encoding="utf-8"?>
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:asp="remove">

    <!--<xsl:template match="Author">
    <xsl:value-of select="FirstName"/>
    <xsl:value-of select="LastName"/>
    <xsl:if test="position()!=last()">, </xsl:if>
	
	
    
  </xsl:template>-->
    <xsl:template match="/">
        <!--<xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>-->

        <html>
            <body>
                <table>
                    <tr>
                        <td colspan="2" class="a-left">
                            <table class="panelContent">
                                <tr>
                                    <td>
                                        1.&#160;Symptoms
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" >
                                        <input type ="text" id="txtSymptoms" Class="small"
                                        style="height:25px;width:700PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        2.&#160;Psychosocial and Spiritual History
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkWorry" Name="Psychosocial" />Worry
                                        &#160;&#160;<input type ="radio"  id="chkScary" Name="Psychosocial" />Scary
                                        &#160;&#160;<input type ="radio"  id="chkSad" Name="Psychosocial" />Sad
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        3.&#160;Communication and Education Demand
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkComNo" Name="Education" onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');"/>No
                                        &#160;&#160;<input type ="radio"  id="chkComYes" Name="Education"  onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');"/>Yes,Explain
                                        &#160;&#160;  <input type ="text" id="txtComExplain" Class="small" onclick="javascript:return ChkNodisabled('chkComNo','chkComYes','txtComExplain');"
                                         style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        4.&#160;Injury / Fall risk
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkInjNo" Name="Injury" onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');" />No
                                        &#160;&#160;<input type ="radio"  id="chkInjYes" Name="Injury" onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');"/>Yes,Explain
                                        &#160;&#160;  <input type ="text" id="txtInjExplain" Class="small" onclick="javascript:return ChkNodisabled('chkInjNo','chkInjYes','txtInjExplain');"
                           style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        5.&#160;Functional Status
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkFunIndependent" Name="Functional" />Independent 
                                       <BR/><input type ="radio" id="chkFunNeedHelp" Name="Functional" />Need Help,Explain
                                        &#160;&#160;  <input type ="text" id="txtFunExplain" Class="small"
                          style="width:500PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        6.&#160;PainFul Scale
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type ="radio"  id="chkPainLignt" Name="PainFul" />Light Pain,analgetik oral
                                        <BR/><input type ="radio" id="chkPainMedium" Name="PainFul" />Medium Pain,need analgetik injection
                                        <BR/><input type ="radio" id="chkPainHard" Name="PainFul" />Hard Pain,ask Pain team
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        7.&#160;Pain Score(0-10)&#160;<input type ="text" id="txtPainScore" onblur="javascript:return doValidatePainScore(this);"
                                         onKeyDown="return validatenumber(event);" Class="mini" maxlength="2"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        8.&#160;Nutrition
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &#160;&#160;a.&#160;Did the Patient have a weight decreasing in past 6 Month?<br/>
                                        &#160;&#160;<input type ="radio"  id="chkNutANo" Name="NutritionA" onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');" />No
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutANotSure" Name="NutritionA" onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');"/>Not Sure
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutAYes" Name="NutritionA" onclick="javascript:return ChkNodisabled('chkNutANo','chkNutAYes','txtNutExp');"/>Yes,Explain
                                        &#160;&#160;<input type ="text" id="txtNutExp" Class="small"
                             style="width:500PX;"/><BR/>
                                        &#160;&#160;b.&#160;Is the patient have lost appetite because the appetite was decreasing?<br/>
                                        &#160;&#160;<input type ="radio"  id="chkNutBNo" Name="NutritionB" />No
                                        <BR/>&#160;&#160;<input type ="radio"  id="chkNutBYes" Name="NutritionB" />Yes
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr>
                                    <td colspan="2">
                                        9.&#160;List of Nursing Priority Problem
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan="2" >
                                        &#160;&#160;a.&#160;Nursing Problem <br/>
                                        &#160;&#160; <input type ="text" id="txtNursingProblem" Class="small"
                                        style="height:25px;width:700PX;"/><br/>
                                        &#160;&#160;b.&#160;Meassureable Goals <br/>
                                        &#160;&#160;<input type ="text" id="txtNursingMeassureable" Class="small"
                                        style="height:25px;width:700PX;"/>
                                    </td>
                                </tr>
                                <TR>
                                    <TD>
                                        <BR/>
                                    </TD>
                                </TR>
                                <tr id="trAnamnesa" class="hide">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td>
                                                    Anamnesa Doctor
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type ="text" id="txtAnamnesa" Class="small"
                                                    style="height:25px;width:700PX;"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
