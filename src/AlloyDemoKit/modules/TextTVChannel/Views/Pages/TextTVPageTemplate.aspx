<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextTVPageTemplate.aspx.cs" Inherits="TextTVChannel.Views.Pages.TextTVPageTemplate" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TextTvTemplate</title>
    <style type="text/css">
        /* http://meyerweb.com/eric/tools/css/reset/ 
   v2.0 | 20110126
   License: none (public domain)
*/

        html, body, div, span, applet, object, iframe,
        h1, h2, h3, h4, h5, h6, p, blockquote, pre,
        a, abbr, acronym, address, big, cite, code,
        del, dfn, em, img, ins, kbd, q, s, samp,
        small, strike, strong, sub, sup, tt, var,
        b, u, i, center,
        dl, dt, dd, ol, ul, li,
        fieldset, form, label, legend,
        table, caption, tbody, tfoot, thead, tr, th, td,
        article, aside, canvas, details, embed,
        figure, figcaption, footer, header, hgroup,
        menu, nav, output, ruby, section, summary,
        time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            font: inherit;
            vertical-align: baseline;
        }
        /* HTML5 display-role reset for older browsers */
        article, aside, details, figcaption, figure,
        footer, header, hgroup, menu, nav, section {
            display: block;
        }

        body {
            line-height: 1;
        }

        ol, ul {
            list-style: none;
        }

        blockquote, q {
            quotes: none;
        }

            blockquote:before, blockquote:after,
            q:before, q:after {
                content: '';
                content: none;
            }

        table {
            border-collapse: collapse;
            border-spacing: 0;
        }

        body {
            font-family: 'Courier New';
            color: white;
            padding: 5px;
            font-size: 1em;
        }
        h1 {
            margin-bottom: 0.5em;
            color: #ffFFFF;
            font-size: 1.2em;
        }

        img {
            display: none;
        }
        #header {
            margin-bottom: 1em;
            background-color: blue;
            color: white;
            padding: 0 1em;
        }
        #footer {
            margin-top: 1em;
            background-color: blue;
            color: white;
        }
        a {
            color: white;
            text-decoration: none;
        }
        .intro {
            color: yellow;
            margin-bottom: 0.5em;
        }
    </style>
</head>
<body>
    <form id="Form1" runat="server">
        <div>
            <div id="header">TEXT TV<div style="float: right;"><a href="<%= GetPage(CurrentPage.ParentLink).LinkURL %>"><%= GetPage(CurrentPage.ParentLink).PageName %></a></div></div>
            <EPiServer:Property PropertyName="PageName" CustomTagName="h1" runat="server" DisplayMissingMessage="false" />
            <div style="height: 202px; overflow: hidden; border: 1px white;">
                <EPiServer:Property runat="server" PropertyName="MetaDescription" CssClass="intro" CustomTagName="div" DisplayMissingMessage="false" />
                <EPiServer:Property runat="server" PropertyName="MainBody" DisplayMissingMessage="false" />
            </div>
            <div id="footer"><span style="background: white; color: blue; padding: 0 1em"><%= CurrentPage.ContentLink.ID %></span></div>
        </div>
    </form>
</body>
</html>
