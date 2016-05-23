<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer" %>
<%@ import namespace="EPiServer.Core" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<ImageChoiceElementBlock>" %>

<%  
    var formElement = Model.FormElement; 
    var labelText = Model.Label;
    var urlResolver = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<EPiServer.Web.Routing.UrlResolver>();
    var sShouldBeVisible = Model.ShowSelectionInputControl ? "" : "hidden";
%>

<div class="Form__Element FormChoice FormChoice--Image <%: Model.GetValidationCssClasses() %>" id="<%: formElement.Guid %>" data-epiforms-element-name="<%: formElement.ElementName %>"
    <%= Model.AttributesString %>>

    <%  if(!string.IsNullOrEmpty(labelText)) { %>
    <div class="Form__Element__Caption"><%: labelText %></div>
    <% }
        var index = 0;
        foreach(var item in Model.Items)
        {
            var imageChoiceId = string.Format("{0}_{1}", formElement.Guid, index);

            var defaultCheckedString = Model.GetDefaultSelectedString(item);
            var checkedString = string.IsNullOrEmpty(defaultCheckedString) ? string.Empty : "checked";
    %>
    <label class="FormChoice--Image__Item">
        <% if(Model.AllowMultiSelect) { %>
        <input type="checkbox"  id="<%: imageChoiceId %>" name="<%: formElement.ElementName %>" value="<%: item.Text %>" <%: checkedString %>   <%: defaultCheckedString %> class="FormChoice__Input FormChoice__Input--Checkbox <%: sShouldBeVisible %>" />
        <% } else { %>
        <input type="radio"     id="<%: imageChoiceId %>" name="<%: formElement.ElementName %>" value="<%: item.Text %>" <%: checkedString %>   <%: defaultCheckedString %> class="FormChoice__Input FormChoice__Input--Radio <%: sShouldBeVisible %>" />
        <% } %>
        <span class="FormChoice--Image__Item__Caption"><%: item.Text %></span>
        <img src="<%: urlResolver.GetUrl(item.GetMappedHref()) %>" title="<%: item.Title ?? item.Text %>" />
    </label>
    <%  index++;
    } %>
    <span data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>