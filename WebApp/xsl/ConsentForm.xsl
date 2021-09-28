<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
      <style>
        <![CDATA[
         table{clear:left;float:left;font-family:verdana;}
         b{font-family:verdana;font-size:12px;}
         .s1{clear:left;float:left;border:solid 1px black;width:1000px;margin:15px 0px;}
         .s2{clear:left;float:left;}
         .s3{margin:5px 0px;}
         .s4{clear:left;margin:5px 0px;}
         tr td{word-break:nowrap;}
         .s5{background-color:#96C4DD;}
		 
      ]]>
      </style>
      <html>
        <body>
          <div id="dvconsentform" class="printfont">
            <xsl:value-of select="ReferralNotes/ReferralNote"/>
          </div>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
