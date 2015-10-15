<%@ Page Language="c#" Codebehind="EmployeeSettings.aspx.cs" AutoEventWireup="False" Inherits="AlloyDemoKit.AdminTools.EmployeeSettings" Title="Employee Settings" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head><title>
	Employee Settings
</title>
        <!-- Mimic Internet Explorer 7 -->
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /><link rel="stylesheet" type="text/css" href="/EPiServer/Shell/8.6.1.0/ClientResources/epi/themes/legacy/ShellCore.css" />
<script type="text/javascript" src="/EPiServer/Shell/8.6.1.0/ClientResources/ShellCore.js"></script>
<link rel="stylesheet" type="text/css" href="/EPiServer/Shell/8.6.1.0/ClientResources/epi/themes/legacy/ShellCoreLightTheme.css" />
<script type="text/javascript" src="/EPiServer/CMS/8.6.1.0/ClientResources/ReportCenter/ReportCenter.js"></script>

            <link type="text/css" rel="stylesheet" href="/EPiServer/CMS/8.6.1.0/ClientResources/Epi/Base/CMS.css" />
        <link href="../../../App_Themes/Default/Styles/system.css" type="text/css" rel="stylesheet" /><link href="../../../App_Themes/Default/Styles/ToolButton.css" type="text/css" rel="stylesheet" />
    </head>

    <body>

    <div class="epi-contentContainer epi-padding">
        <div class="epi-contentArea">
                        <h1 class="EP-prefix">Employee Settings</h1>
                        <p class="EP-systemInfo">Defines data import file names for Employee Import job.  System expects files are in the App_Data folder.
                            <br />You may Optionally create test data to use.
                        </p>
                    </div>
                              
        <div id="FullRegion_MainRegion_listPanel">
	    <form runat="server" id="employeeForm">
            
            <asp:Label runat="server" ID="OutputMessage" ForeColor="#FF6600"></asp:Label>
            <table width="20%" class="epi-default">
                <tbody>
                    <tr>
                        <td>
                            Employee filename
                        </td>
                        <td>
                        <asp:TextBox runat="server" id="EmployeeFileName" Width="250"></asp:TextBox>
                        <asp:RequiredFieldValidator id="fileReq1" runat="server" ErrorMessage="Field is required" ControlToValidate="EmployeeFileName" ForeColor="IndianRed"  />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Locations filename
                        </td>
                        <td>
                        <asp:TextBox runat="server" id="LocationsFileName" Width="250"></asp:TextBox>
                        <asp:RequiredFieldValidator id="fileReq2" runat="server" ErrorMessage="Field is required" ControlToValidate="LocationsFileName" ForeColor="IndianRed" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Expertise filename
                        </td>
                        <td>
                            <asp:TextBox runat="server" id="ExpertiseFileName" Width="250"></asp:TextBox>
                            <asp:RequiredFieldValidator id="fileReq3" runat="server" ErrorMessage="Field is required" ControlToValidate="ExpertiseFileName" ForeColor="IndianRed" />
                        </td>
                    </tr>
            
                </tbody>

            </table>

            <div class="epi-buttonDefault">
                <span class="epi-cmsButton">
                    <asp:Button runat="server" CssClass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save" id="FullRegion_MainRegion_Save" Text="Save" title="Save" OnClick="FullRegion_MainRegion_Save_Click"  />
                </span>
                &nbsp;&nbsp;
                <span class="epi-cmsButton">
                    <asp:Button runat="server" CssClass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Add" id="FullRegion_MainRegion_Build" Text="Create Test Data" title="Create Test Data" OnClick="FullRegion_MainRegion_Create_Click"  />
                </span>
            </div>
          </form>      
    
    </div>
    
    </div>
</body>
</html>