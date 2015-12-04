<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Core" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<FormContainerBlock>" %>


<% if (EPiServer.Editor.PageEditing.PageIsInEditMode) { %>
<link rel="stylesheet" type="text/css" data-epiforms-resource="EPiServerForms.css" href='<%: ModuleHelper.ToClientResource("ClientResources/ViewMode/EPiServerForms.css")%>' />

<div class="EPiServerForms">
    <h2 class="Form__Title"><%: Html.PropertyFor(m => m.Title) %></h2>
    <h4 class="Form__Description"><%: Html.PropertyFor(m => m.Description) %></h4>

    <%: Html.PropertyFor(m => m.ElementsArea) %>
</div>
<% } else { %>

<%-- 
    Using form tag (instead of div) for the sake of html elements' built-in features e.g. reset, file upload
    Using enctype="multipart/form-data" for post data and uploading files 
--%>
<form enctype="multipart/form-data" class="EPiServerForms" data-epiforms-type="form" id="<%: Model.Form.FormGuid %>">
    <%--Meta data, authoring data of this form is transfer to clientside here. We need to take form with language coresponse with current page's language --%>
    <script type="text/javascript" src="<%: ModuleHelper.GetSiteUrl() %>EPiServer.Forms/DataSubmit/GetFormInitScript?formGuid=<%: Model.Form.FormGuid %>&formLanguage=<%: FormsExtensions.GetCurrentPageLanguage() %>"></script>


    <h2 class="Form__Title"><%: Model.Title %></h2>
    <aside class="Form__Description"><%: Model.Description %></aside>

    <%-- area for showing Form's status or validation --%>
    <div class="Form__Status">
        <span class="Form__Status__Message" style="display: none;"></span>
    </div>

    <div class="Form__MainBody">
        <% var i = 0; 
            foreach (var step in Model.Form.Steps) { %>

        <section id="<%: step.Code %>" data-epiforms-element-name="<%: step.Code %>" class="Form__Element FormStep" data-epiforms-stepindex="<%: i %>" >
            <% 
                var stepBlock = (step.SourceContent as ElementBlockBase);
                if(stepBlock != null)
                {
                    Html.RenderContentData(step.SourceContent, false);
                }
             %>
            
            <!-- Each FormStep groups the elements below it til the next FormStep -->
            <% foreach (var item in step.Elements) {
                    // render each element of the step
                    Html.RenderContentData((item as FormElement).SourceContent, false);
                } // endof foreach element in step %>
        </section>

        <% i++; } // end foreach steps %>

        <% // show Next/Previous buttons when having Steps > 1
            if (Model.Form.Steps.Count() > 1) { %>
        <nav role="navigation" class="Form__NavigationBar">
            <button type="button" class="Form__NavigationBar__Action btnPrev"><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/previous")%></button>
            
            <div class="Form__NavigationBar__ProgressBar">
                <div class="Form__NavigationBar__ProgressBar--Progress"></div>
                <div class="Form__NavigationBar__ProgressBar--Text">
                    <span class="Form__NavigationBar__ProgressBar__ProgressLabel"><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/page")%></span> <span class="Form__NavigationBar__ProgressBar__CurrentStep"></span>/<span class="Form__NavigationBar__ProgressBar__StepsCount"></span>
                </div>
            </div>
            
            <button type="button" class="Form__NavigationBar__Action btnNext"><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/next")%></button>
        </nav>

        <% } // endof if %>
    </div>
    <%-- endof FormMainBody --%>
</form>

<% } %>