<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<ChoiceElementBlock>" %>

<%  
    var formElement = Model.FormElement; 
    var labelText = Model.Label;
    var items = Model.GetItems();
%>

<div class="Form__Element FormChoice" id="<%: formElement.Guid %>" data-epiforms-element-name="<%: formElement.Code %>" 
    <%= formElement.AttributesString %>>

    <%  if(!string.IsNullOrEmpty(labelText)) { %>
    <span class="Form__Element__Caption"><%: labelText %></span>
    <% } 
        
        foreach(var item in items)
        {   
            var checkedString = item.Checked.HasValue && item.Checked.Value ? "checked" : string.Empty;
            var defaultCheckedString = !string.IsNullOrEmpty(checkedString) ? "data-epiforms-default-value=true" : string.Empty;
    %>

    <label>
        <% if(Model.AllowMultiSelect) { %>
        <input type="checkbox"  name="<%: formElement.Code %>" value="<%: item.Value %>" class="FormChoice__Input FormChoice__Input--Checkbox" <%: checkedString %>   <%: defaultCheckedString %> />
        <% } else  { %>
        <input type="radio"     name="<%: formElement.Code %>" value="<%: item.Value %>" class="FormChoice__Input FormChoice__Input--Radio"    <%: checkedString %>   <%: defaultCheckedString %> />
        <% } %>
        <%: item.Caption %></label>

    <% } %>
    <span data-epiforms-linked-name="<%: formElement.Code %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>
