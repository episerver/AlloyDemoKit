//////// THIS FILE OF MAI CORE WILL BE INJECTED INTO EPISERVER'S XFORM EDIT DIALOG ///////

function byId(elementId) {
    return document.getElementById(elementId);
}

function ensureInit(e) {
    var submitAction = byId(__submitActionClientID);
    var __textname = byId('__textname');
    var __textareaname = byId('__textareaname');
    var __selectname = byId('__selectname');
    var __selectareaname = byId('__selectareaname');
    var __multiplename = byId('__multiplename');
    var __selectmultiplename = byId('__selectmultiplename');

    if ($(__selectname).length > 0) {
        if (__selectname.options.length == 0) addFields(__selectname);
    }

    if ($(__selectareaname).length > 0) {
        if (__selectareaname.options.length == 0) addFields(__selectareaname);
    }

    if ($(__selectmultiplename).length > 0) {
        if (__selectmultiplename.options.length == 0) addFields(__selectmultiplename);
    }
}

function populate(e) {
    /// called onclick of the XForm control LeftPanel

    var submitAction = byId(__submitActionClientID);
    var __textname = byId('__textname');
    var __textareaname = byId('__textareaname');
    var __selectname = byId('__selectname');
    var __selectareaname = byId('__selectareaname');
    var __multiplename = byId('__multiplename');
    var __selectmultiplename = byId('__selectmultiplename');

    fieldProperties(e);
    if ($(submitAction).length > 0) {
        selectValue(byId('SelectMAForm'), byId('FormCustomUrl'));
        submitAction.selectedIndex = 3;
        formActionChange(submitAction);
    }
    ensureInit();
    if ($(__selectname).length > 0) {
        selectValue(__selectname, __textname);
    }
    if ($(__selectareaname).length > 0) {
        selectValue(__selectareaname, __textareaname);
    }
    if ($(__selectmultiplename).length > 0) {
        selectValue(__selectmultiplename, __multiplename);
    }
}

function selectValue(ddl, textbox) {
    $(ddl).val(textbox.value);
    if (ddl.selectedIndex < 0 || $(textbox).val() != $(ddl).val()) {
        ddl.selectedIndex = 0; // we need to double-check the match because val() will try and match text in the select as well as values!
    }
    displayFieldName(ddl, textbox);
}

function setFieldName(ddl, textbox) {
    if (ddl.options.length > 0 && ddl.selectedIndex > -1) {
        setTextFieldName(ddl, textbox);
        displayFieldName(ddl, textbox);
    }
}

function setTextFieldName(ddl, textbox) {
    $(textbox).val($(ddl).val());
}

function displayFieldName(ddl, textbox) {
    if (ddl.options[ddl.selectedIndex].value == "") {
        $(textbox).css('display', '');
    }
    else {
        $(textbox).css('display', 'none');
    }
}

function overrideStartDrag(e) {
    // Override Start Drag to capture the field drop event

    fieldStartDrag.call(this, e);
    document.body.onmouseup = overrideFieldDrop;
}

function overrideFieldDrop(evt) {
    // Override FieldDrop event to process Silverpop business on creating XForm fields

    var submitAction = byId(__submitActionClientID);
    var __textname = byId('__textname');
    var __textareaname = byId('__textareaname');
    var __selectname = byId('__selectname');
    var __selectareaname = byId('__selectareaname');
    var __multiplename = byId('__multiplename');
    var __selectmultiplename = byId('__selectmultiplename');

    fieldDrop(evt);
    
    ResetElements([__textname, __textareaname, __selectname, __selectareaname, __multiplename, __selectmultiplename]);

    // Have to set timeout to wait for DOM construction of the new form element ready,
    // otherwise we cannot set field name value for the first time in case we click on a toolbutton to insert (DnD works well without setTimeout)
    setTimeout(function () {
        if ($(submitAction).length > 0) {
            submitAction.selectedIndex = 3;
            formActionChange(submitAction);
            byId('SelectMAForm').selectedIndex = 0;
            setTextFieldName(byId('SelectMAForm'), byId('FormCustomUrl'));
        }

        if ($(__selectname).length > 0) {
            setFieldName(__selectname, __textname);
        }
        if ($(__selectareaname).length > 0) {
            setFieldName(__selectareaname, __textareaname);
        }
        if ($(__selectmultiplename).length > 0) {
            setFieldName(__selectmultiplename, __multiplename);
        }
    }, 0);

    /// incase editor just click on the the toolbutton in the toolbar to add the field to XForm row, we cannot handle the drop event. 
    /// We simulate the click on that target row.
    if (evt.target.id === __XformToolboxButtonSubmitClientID) {
        // delaying click to the selected row, so the right panel will be rendered correctly with Silverpop UI elements
        setTimeout(function () {
            // find the current selected row in the left panel (with background color = silver)
            var currentSelectedRow = $.find('tr td[valign=top]', byId(__XformControlClientID)).filter(function (element, index, allArray) {
                return $(element).css('backgroundColor').toLowerCase() === 'silver';
            });

            if (currentSelectedRow.length > 0)
                $(currentSelectedRow).trigger('click');
        }, 100);
    }
}

function ResetElements(/*Array*/ elements) {
    // Reset display state and value of array elements

    $(elements).each(function (index) {
        var $this = $(this);
        $this.css("display", "");
        $this.val("");
    });
}