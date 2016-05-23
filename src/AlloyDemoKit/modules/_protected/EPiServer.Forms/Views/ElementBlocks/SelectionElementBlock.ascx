<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<SelectionElementBlock>" %>

<%
    var formElement = Model.FormElement; 
    var labelText = Model.Label;
    var placeholderText = Model.PlaceHolder;
    var defaultOptionItemText = !string.IsNullOrWhiteSpace(placeholderText) ? placeholderText : Html.Translate(string.Format("/episerver/forms/viewmode/selection/{0}", Model.AllowMultiSelect ? "selectoptions" : "selectanoption"));
    var defaultOptionSelected = Model.Items.Count(x => x.Checked.HasValue && x.Checked.Value) <= 0 ? "selected=\"selected\"" : "";
    var items = Model.GetItems();
%>

<div class="Form__Element FormSelection <%: Model.GetValidationCssClasses() %>" data-epiforms-element-name="<%: formElement.ElementName %>" >
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption"><%: labelText %></label>
    <select name="<%: formElement.ElementName %>" id="<%: formElement.Guid %>" <%: Model.AllowMultiSelect ? "multiple" : "" %>  <%= Model.AttributesString %> >
        <option disabled="disabled" <%= defaultOptionSelected %> value=""><%: defaultOptionItemText %></option>
        <%
        foreach (var item in items)
        {
            var defaultSelectedString = Model.GetDefaultSelectedString(item);
            var selectedString = string.IsNullOrEmpty(defaultSelectedString) ? string.Empty : "selected";
        %>
        <option value="<%: item.Value %>" <%= selectedString %> <%= defaultSelectedString %>><%: item.Caption %></option>
        <% } %>
    </select>
    <span data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>