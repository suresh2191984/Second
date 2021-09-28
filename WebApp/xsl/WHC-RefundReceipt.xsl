<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:asp="remove"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
  <xsl:template match="/">
    <html style="height:1200px;overflow:scroll;">
      <style type="text/css">
        td
        {
        border-style: none;
        border-color: inherit;
        border-width: medium;
        padding-top: 1px;
        padding-right: 1px;
        padding-left: 1px;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        }
        .style1
        {
        height: 25.5pt;
        width: 510pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 700;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: middle;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: 1.0pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        background: #CCFFCC;
        }
        .style2
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style3
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style4
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style5
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style6
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style7
        {
        height: 30.0pt;
        width: 102pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: normal;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style8
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style9
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style10
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style11
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style12
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style13
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style14
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style15
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style16
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style17
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style18
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style19
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style20
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style21
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style22
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style23
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 700;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style24
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 700;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style25
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 700;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style26
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 700;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style27
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style28
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style29
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style30
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: .5pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style31
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style32
        {
        height: 30.0pt;
        width: 102pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: normal;
        border-left: 1.0pt solid windowtext;
        border-right: .5pt solid windowtext;
        border-top: .5pt solid windowtext;
        border-bottom: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style33
        {
        width: 93pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: normal;
        border: .5pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style34
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: italic;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: center;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style35
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        background: #CCFFCC;
        }
        .style36
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-style: none;
        border-color: inherit;
        border-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        background: #CCFFCC;
        }
        .style37
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom-style: none;
        border-bottom-color: inherit;
        border-bottom-width: medium;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        background: #CCFFCC;
        }
        .style38
        {
        height: 15.0pt;
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left: 1.0pt solid windowtext;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: 1.0pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style39
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right-style: none;
        border-right-color: inherit;
        border-right-width: medium;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: 1.0pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
        .style40
        {
        color: black;
        font-size: 11.0pt;
        font-weight: 400;
        font-style: normal;
        text-decoration: none;
        font-family: Calibri, sans-serif;
        text-align: general;
        vertical-align: bottom;
        white-space: nowrap;
        border-left-style: none;
        border-left-color: inherit;
        border-left-width: medium;
        border-right: 1.0pt solid windowtext;
        border-top-style: none;
        border-top-color: inherit;
        border-top-width: medium;
        border-bottom: 1.0pt solid windowtext;
        padding-left: 1px;
        padding-right: 1px;
        padding-top: 1px;
        }
      </style>
      <body>
        <div id="div" style="margin:0 auto;">
          <div id="divOP"   >
            <br></br>
            <div id="dvContent">

              <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; width: 510pt;margin: 0 auto;" width="681">
                <colgroup>
                  <col style="mso-width-source: userset; mso-width-alt: 4973; width: 102pt" width="136" />
                  <col style="mso-width-source: userset; mso-width-alt: 10788; width: 221pt" width="295" />
                  <col style="mso-width-source: userset; mso-width-alt: 4534; width: 93pt" width="124" />
                  <col span="2" style="width: 47pt" width="63" />
                </colgroup>
                <tr height="34" style="mso-height-source: userset; height: 25.5pt">
                  <td class="style1" colspan="5" height="34" style="border-right: 1px solid black !important;" width="681">
                    <input type="image" style="width: 15%;height: 95px;padding: 5px;" name="imagem">
                      <xsl:attribute name="src">
                        <xsl:value-of select="RefundReceipt/src" />
                      </xsl:attribute>
                    </input>
                    WESTMINSTER HEALTH CARE PVT LTD
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt;">
                  <td class="style2" colspan="5" style="border-right: 1px solid black !important;font-weight:bold;" height="20">
                     Refund Receipt
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Client Name:
                  </td>
                  <td class="style4">
                    <xsl:value-of select="RefundReceipt/Name" />
                  </td>
                  <td class="style5">
                    Booking No:
                  </td>
                  <td class="style5">
                    
                  </td>
                  <td class="style6">
                    
                  </td>
                </tr>
                <tr height="40" style="height: 30.0pt">
                  <td class="style7" height="40" width="136">
                    Father&#39;s /
                    <br />
                    Husband Name:
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Gender:
                  </td>
                  <td class="style10">
                    <xsl:value-of select="RefundReceipt/Gender" />
                  </td>
                  <td class="style11">
                    UHID:
                  </td>
                  <td class="style5">
                    <xsl:value-of select="RefundReceipt/PatientNumber" />
                  </td>
                  <td class="style6">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    DOB:
                  </td>
                  <td class="style8">
                    <xsl:value-of select="RefundReceipt/DOB" />
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Age:
                  </td>
                  <td class="style8">
                    <xsl:value-of select="RefundReceipt/Age" />
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Address:
                  </td>
                  <td class="style8">
                    <xsl:value-of select="RefundReceipt/Address" />
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td class="style11">
                    Membership ID:
                  </td>
                  <td class="style5">
                    
                  </td>
                  <td class="style6">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Email ID:
                  </td>
                  <td class="style8">
                    <xsl:value-of select="RefundReceipt/EMail" />
                  </td>
                  <td class="style12">
                    Date:
                  </td>
                  <td class="style13">
                    <xsl:value-of select="RefundReceipt/RefundDate" />
                  </td>
                  <td class="style14">
                     
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style15" height="20">
                    Phone no.:
                  </td>
                  <td class="style16">
                    <xsl:value-of select="RefundReceipt/MobileNumber" />
                  </td>
                  <td class="style17">
                    Time:
                  </td>
                  <td class="style18">
                    <xsl:value-of select="RefundReceipt/RefundTime" />
                  </td>
                  <td class="style19">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style20" height="20">
                    Doctor Name:
                  </td>
                  <td class="style4">
                    
                  </td>
                  <td class="style4">
                    Invoice no:
                  </td>
                  <td class="style5">
                    <xsl:value-of select="RefundReceipt/BillNo" />
                  </td>
                  <td class="style6">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style21" height="20">
                    Speciality:
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td class="style8">
                    Type of Invoice:
                  </td>
                  <td>
                    <xsl:value-of select="RefundReceipt/TypeOfInvoice" />
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style22" height="20">
                    
                  </td>
                  <td class="style16">
                    
                  </td>
                  <td class="style16">
                    TPA/Corporate:
                  </td>
                  <td class="style18">
                    <xsl:value-of select="RefundReceipt/ClientName" />
                  </td>
                  <td class="style19">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style23" height="20">
                    Service code
                  </td>
                  <td class="style24">
                    Service Name
                  </td>
                  <td class="style25">
                    Department Name
                  </td>
                  <td class="style26" style="border-right: 1px solid black !important;" colspan="2">
                    Amount ( ₹ )
                  </td>
                </tr>
                <xsl:for-each select="RefundReceipt/RefundBillingDetails">
                <tr height="20" style="height: 15.0pt">
                  <td class="style27" height="20">
                    
                  </td>
                  <td>
                    <xsl:value-of select="FeeDescription" />
                    
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td class="style10">
                    <xsl:value-of select="Amount" />
                    
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                </xsl:for-each>
                <tr height="20" style="height: 15.0pt">
                  <td class="style27" height="20">
                    
                  </td>
                  <td>
                  </td>
                  <td class="style8">
                    
                  </td>
                  <td class="style10">
                    
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                
                <tr height="20" style="height: 15.0pt">
                  <td class="style29" height="20">
                    Total amount
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style30">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style21" height="20">
                    Advance received
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style10">
                    
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style29" height="20">
                    Refunded amount
                  </td>
                  <td class="style13">
                    <xsl:value-of select="RefundReceipt/RefundedAmt" />
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style30">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style29" height="20">
                    Net amount
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style30">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style29" height="20">
                    Taxes if any
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style30">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style21" height="20">
                    Amount in words:
                  </td>
                  <td>
                    <xsl:value-of select="RefundReceipt/RefundedAmtInWords" />
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style22" height="20">
                    
                  </td>
                  <td class="style18">
                    
                  </td>
                  <td class="style18">
                    
                  </td>
                  <td class="style18">
                    
                  </td>
                  <td class="style19">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style31" height="20">
                    Payment type:
                  </td>
                  <td class="style13">
                    <xsl:value-of select="RefundReceipt/PaymentType" />
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="40" style="height: 30.0pt">
                  <td class="style32" height="40" width="136">
                    Signature of
                    <br />
                    Cashier
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style33" width="124">
                    Signature of
                    <br />
                    Client
                  </td>
                  <td class="style13">
                    
                  </td>
                  <td class="style14">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style34" colspan="5" height="20">
                    <span style="mso-spacerun: yes">
                      
                    </span>Keep the records carefully and bring them along during your next visit to
                    our hospital<span style="mso-spacerun: yes">
                      
                    </span>E&amp;OE
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style35" height="20">
                    
                  </td>
                  <td class="style36" colspan="3" style="mso-ignore: colspan">
                    For enquiries , appointments, &amp; telemedicine consultations contact 044<span style="mso-spacerun: yes"></span>
                  </td>
                  <td class="style37">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Working hours:
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Address:
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    CIN no.:
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style3" height="20">
                    Service tax no.:
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td class="style9">
                    
                  </td>
                </tr>
                <tr height="20" style="height: 15.0pt">
                  <td class="style38" height="20">
                    
                  </td>
                  <td class="style39">
                    
                  </td>
                  <td class="style39">
                    
                  </td>
                  <td class="style39">
                    
                  </td>
                  <td class="style40">
                    
                  </td>
                </tr>
              </table>

            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>