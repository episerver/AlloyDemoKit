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

<div class="Form__Element FormSelection <%: Model.GetValidationCssClasses() %>" data-epiforms-element-name="<%: formElement.Code %>" >
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption"><%: labelText %></label>
    <select name="<%: formElement.Code %>" id="<%: formElement.Guid %>" <%: Model.AllowMultiSelect == true ? "multiple" : "" %>  <%= formElement.AttributesString %> >
        <option disabled="disabled" <%= defaultOptionSelected %> value=""><%: defaultOptionItemText %></option>
        
        <%  
        foreach(var item in items) {
            var selectedString = item.Checked.HasValue && item.Checked.Value ? "selected=\"selected\"" : string.Empty;
            var defaultCheckedString = !string.IsNullOrEmpty(selectedString) ? "data-epiforms-default-value=\"true\"" : string.Empty;
        %>
        <option value="<%: item.Value %>" <%= selectedString %> <%= defaultCheckedString %>><%: item.Caption %></option>
        <% } %>
    </select>
    <span data-epiforms-linked-name="<%: formElement.Code %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>
