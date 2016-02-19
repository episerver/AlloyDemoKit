/* This EPiServerForms.js file will be injected into ViewMode page by ClientScriptRegister, as WebResource URL
These functionality will be performed by this script:
 - client validation of FormElement
 - step depends on FormElement
 - posting to the EPiForms controller
 - clientside interaction, step navigation
*/

/// begin main entry execution
(function ($) {
    if (typeof (epi) == 'undefined' || typeof (epi.EPiServer) == 'undefined' || typeof (epi.EPiServer.Forms) == 'undefined') {
        console.error('Forms is not initialized correctly');
        return;
    }
    if (typeof ($) == 'undefined') {
        console.error('Forms cannot work without jQuery');
        return;
    }

    var _utilsSvc = epi.EPiServer.Forms.Utils,
        _dataSvc = epi.EPiServer.Forms.Data,
        _extensionSvc = epi.EPiServer.Forms.Extension;
    /// All metadata for Forms in ClientSide will stay inside EPiServer.Forms object
    epi.EPiServer.Forms.__DebounceTimer = null;
    epi.EPiServer.Forms.__Initialized = !(epi.EPiServer.Forms.__Initialized === undefined);   // a flag to know does the EPiServerForms.js.init() ever run? We can have multiple reference, but should run Forms.init() once.



    /// adding some statical utils functions
    /// ===========================
    $.extend(true, epi.EPiServer.Forms, {
        Utils: {

            //delay the call of fn, only execute the **last** call to fn after delay.
            debounce: function (/*function*/ fn, /*number, milisecond*/ delay) {
                return function () {
                    var context = this, args = arguments;
                    clearTimeout(this.__DebounceTimer);
                    this.__DebounceTimer = setTimeout(function () {
                        fn.apply(context, args);
                    }, delay);
                };
            },

            // load script (by injecting <script> into <head>) from sScriptSrcList. When done, call oCallback
            loadExternalScriptOnDemand: function (/*array of String*/ scriptSourceList, /*function*/ oCallback, async) {

                var oHead = document.getElementsByTagName('head')[0];
                var itemIndex = 0,
                    totalItems = scriptSourceList.length,
                    item = null;

                for (; itemIndex < totalItems; itemIndex++) {
                    item = scriptSourceList[itemIndex];

                    var oScript = document.createElement('script');
                    oScript.type = 'text/javascript';
                    oScript.async = async || false;
                    oScript.defer = async || false;
                    oScript.src = item;

                    oHead.appendChild(oScript);

                    if (itemIndex === totalItems - 1) {
                        this._setupCallback(oScript, oCallback);
                    }
                }
            },

            // Load css file from <param>cssSourceList</param>, when done, call oCallback
            loadExternalCssOnDemand: function (/*array of String*/ cssSourceList, /*function*/ oCallback) {
                var oHead = document.getElementsByTagName('head')[0];
                var itemIndex = 0,
                    totalItems = cssSourceList.length,
                    item = null;

                for (; itemIndex < totalItems; itemIndex++) {
                    item = cssSourceList[itemIndex];

                    var linkTag = document.createElement("link");
                    linkTag.setAttribute("rel", "stylesheet");
                    linkTag.setAttribute("type", "text/css");
                    linkTag.setAttribute("href", item);

                    oHead.appendChild(linkTag);

                    if (itemIndex === totalItems - 1) {
                        this._setupCallback(linkTag, oCallback);
                    }
                }
            },

            // setup callback after element is loaded
            _setupCallback: function (element, oCallback) {
                // TECHNOTE: do callback after loading, for most browsers
                if (typeof (oCallback) === 'function') {
                    element.onload = oCallback;
                    // for IE 6 & 7
                    element.onreadystatechange = function () {
                        if (this.readyState == 'complete') {
                            oCallback();
                        }
                    }
                }
            },

            // return a string from a format string and corresponding arguments.
            // null, empty argument will be replaced as ""
            // Example: var selector = _utilsSvc.stringFormat("{0}{1}{2}", [1, 2, 3]) will return "123";
            stringFormat: function (/*string*/ formatString, /*array*/ arguments) {
                var s = formatString, i = arguments.length;
                while (i--) {
                    s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i] || "");
                }
                return s;
            },

            // return concatination string if input is an array
            // Example: getConcatString([1,2,3], "&") returns "1&2&3"
            getConcatString: function (srcObject, seperator) {
                return (srcObject instanceof Array) ? srcObject.join(seperator) : srcObject;
            },

            // return HTML encoded string from given originalString
            htmlEncodeEntities: function (originalString) {
                return $('<div></div>').text(originalString).html();
            },

            /// Decode HTML string
            /// This technique is better than .replace() solution, because it can render UTF-8 escaped when we use <%: TextHere %> on server-side
            /// remark: source is from http://stackoverflow.com/a/1395954/161471
            htmlDecodeEntities: function (encodedString) {
                var textArea = document.createElement('textarea');
                textArea.innerHTML = encodedString;
                return textArea.value;
            },

            // Return true if the value string matches with the RegEx pattern.
            isMatchedReg: function (value, regex) {
                var rx = new RegExp(regex), // default settings: global = false, multiline = false (causes ^ and $ to match begin and end of string), ignoreCase = false
                    matches = rx.exec(value);
                return (matches != null && matches.length > 0);
            },



            // raise custom jQuery event on workingFormInfo.$workingForm. ExtraInfo will be used to mixed into event object
            raiseFormsEvent: function (workingFormInfo, extraInfo) {
                var event = $.extend(true, {
                    type: 'forms',
                    workingFormInfo: workingFormInfo
                }, extraInfo);

                if (workingFormInfo) {
                    workingFormInfo.$workingForm.triggerHandler(event);
                }
                else {
                    var $containerToRaise = $(".EPiServerForms:eq(0)"); // raise on first FormContainer, so it will not duplicated
                    if (!$containerToRaise || $containerToRaise.length < 1) {
                        $containerToRaise = $("body");
                    }
                    $containerToRaise.triggerHandler(event);
                }
            },

            /// Injects visitor data to hidden field of the working form
            injectVisitorData: function (workingFormInfo) {

                var $visitorDataSourcesElements = $(".FormHidden[data-epiforms-visitordatasources]", workingFormInfo.$workingForm);
                if (!$visitorDataSourcesElements || $visitorDataSourcesElements.length === 0) {
                    return;
                }

                var $targetElement = null;
                $visitorDataSourcesElements.each(function () {
                    $targetElement = $(this);
                    if ($targetElement && $targetElement.length > 0) {
                        var func = null;
                        $($targetElement.data("epiforms-visitordatasources").split(",")).each(function (index, visitorDataSource) {
                            func = epi.EPiServer.Forms.VisitorData[visitorDataSource];
                            if (typeof func === "function") {
                                func($targetElement);
                            }
                        });
                    }
                });

            },

            // get value of element ($element must be a DOM of .Form__Element), base on its type, we will have different process (because get value from textbox is different from getting value from :radio)
            getElementValue: function ($element) {

                if ($element.hasClass("FormFileUpload")) {
                    return this.getPreviousPostedFiles($element);
                }

                if ($element.hasClass("FormChoice")) {
                    // get contained checkbox|radio value
                    // always store as Array (because it can be multiple selected, and has multiple values)            
                    var childValue = $element.find('.FormChoice__Input:checked')
                        .map(function (index, item) { return $(item).val() })
                        .get(); // convert to pure array
                    return childValue;
                }

                if ($element.hasClass("FormSelection")) {
                    // always should be array of values                    
                    //var alphaNumeric = ['a', 'b', 'c'].concat(1, [2, 3]); ===> Result: ['a', 'b', 'c', 1, 2, 3]
                    return [].concat($element.find("select").val());   // always return as array of values
                }

                //case "textbox" base
                if ($element.hasClass("FormCaptcha") || $element.hasClass("FormTextbox") || $element.hasClass("FormTextbox--Textarea")) {
                    return $.trim($('.FormTextbox__Input', $element).val());
                }

                // range element
                if ($element.hasClass("FormRange")) {
                    return $.trim($('.FormRange__Input', $element).val());
                }

                // simple form input like hidden input will goes here
                return epi.EPiServer.Forms.Extension.getCustomElementValue($element);
            },

            getWorkingFormFromInnerElement: function (/*Object*/source) {
                /// TECHNOTE: we can guess the $workingForm and workingFormInfo by look "up" to the ancestor of this button

                return $(source).parents(".EPiServerForms:first");    // only work with element inside this form
            },

            getFormIdentifier: function ($workingForm) {
                // summary:
                //      Get form's identifier, this now will be the Guid of the form, to lookup in metadata for Steps, Descriptors, ...
                // tags:
                //      public

                return $workingForm.prop('id');
            },

            getPreviousPostedFiles: function ($fileUploadElement) {
                // summary:
                //      Gets previous posted file from storage.
                // tags:
                //      pulbic


                var $inputElement = $fileUploadElement.find(".FormFileUpload__Input"),
                    elementName = $inputElement.attr("name") || $inputElement.data("epiforms-element-name"),
                    formData = epi.EPiServer.Forms.Data.loadCurrentFormDataFromStorage(this.getWorkingFormFromInnerElement($inputElement)),
                    elementValue = $inputElement[0].files;   // the file upload's current chosen files
                // Step can be Next/Prev, file is uploaded at Next, but user can Prev then Next again without chosen another file causes Required validator fail,
                // need to assign the chosen and uploaded file (the stored one) to it
                $.each(formData, function (name, val) {
                    // look for associate fileupload __TempData and assign its stored file names
                    if (name.indexOf("__TempData") != -1 && name.replace("__TempData", "") == elementName && elementValue.length == 0) {
                        elementValue = val;

                        return false;
                    }
                });

                return elementValue;
            },

            // summary:
            //      get the first step that matching currentPageLink
            //      if return -1, it mean some step(s) is configured to a page, but nothing match this page
            //      if return NaN, it means malform data happened. Someone set the wrong data to the __FormCurrentStepIndex hiddenInput
            // tags:
            //      public
            getCurrentStepIndex: function (workingFormInfo) {
                var currentStepIndex = $("input[name=__FormCurrentStepIndex]", workingFormInfo.$workingForm).val();

                // if value in the hiddenInput is undetermined, we try to inspect from form metadata
                if (currentStepIndex === undefined
                    || currentStepIndex.trim() === ""
                    || isNaN(+currentStepIndex)     // we do nothing with malform CurrentStepIndex. Something is wrong with the Form initialization.
                    || +currentStepIndex > workingFormInfo.StepsInfo.Steps.length - 1   // stepIndex is bigger than stepCount
                    ) {

                    // all step are not configured to contentLink, display the first step on this page
                    if (workingFormInfo.StepsInfo.AllStepsAreNotLinked) {
                        currentStepIndex = 0;
                    }
                    else {
                        // steps are linked then figure out from the StepsInfo based on pageLink and its denpendent condition
                        $.each(workingFormInfo.StepsInfo.Steps, function (i, step) {
                            if (step.attachedContentLink == epi.EPiServer.CurrentPageLink &&
                                _extensionSvc.isStepSatisfyDependentCondition(step, workingFormInfo)) {
                                currentStepIndex = i;
                                return false;   // break on first one
                            }
                        });
                    }
                }
                else {
                    currentStepIndex = +currentStepIndex;   // convert to number
                }

                return currentStepIndex;
            },

            // Set the zero-base stepIndex
            //      if return -1, it mean some step(s) is configured to a page, but nothing match this page
            //      if return NaN, it mean no step is configured to any page
            setCurrentStepIndex: function (workingFormInfo, stepIndex) {
                $("input[name=__FormCurrentStepIndex]", workingFormInfo.$workingForm).val(stepIndex);
                return stepIndex;
            },
            
            validateRegularExpressionValidator: function (fieldName, fieldValue, validatorMetaData) {
                // summary:
                //      VALIDATE DATAVALUE
                // fielName: String
                //      Name of the field to be validated.
                // fieldValue: [Object]
                //      User input value for the field.
                // validatorMetaData: [Object]
                //      Validation meta data for the current element
                // returns: Object
                // tags:
                //      private

                // Validate element's data based on "validate as" type
                if (!validatorMetaData || !validatorMetaData.model || !validatorMetaData.model.jsPattern || fieldValue === "") {
                    // This element is valid
                    return { isValid: true };
                }

                if (!_utilsSvc.isMatchedReg(fieldValue, validatorMetaData.model.jsPattern)) {
                    // also put the validatior.Description as help-tip for Visitor
                    var message = _utilsSvc.stringFormat(validatorMetaData.model.message, [validatorMetaData.model.jsPattern, validatorMetaData.description]);

                    return { isValid: false, message: message };
                }

                return { isValid: true };
            }
        },

        Extension: {

            // summary:
            //      Gets summarized text based on form fields
            // tags:
            //      public
            getSummarizedText: function (workingFormInfo, data, displayAsHtmlContent) {
                // workingFormInfo.ElementsInfo: contains friendlyName for each field code

                var newLineString = displayAsHtmlContent ? "<br/>" : "\n",
                    confirmMessage = displayAsHtmlContent ? workingFormInfo.ConfirmMessage : _utilsSvc.htmlDecodeEntities(workingFormInfo.ConfirmMessage),
                    elementsInfo = workingFormInfo.ElementsInfo,
                    addedKeys = [],
                    shouldBeHiddenKeys = [],
                    ignoreFields = ["__FormGuid", "__FormLanguage", "__FormCurrentStepIndex", "__FormSubmissionId"],
                    summarizedText = workingFormInfo.ConfirmMessage ? confirmMessage + newLineString + newLineString : "",
                    friendlyName = null,
                    dataValue = null;

                // Note: the given data is a merging from stored value and the currentStep value, and then an stored empty FileList will become an empty object (not a FileList)

                for (var key in data) {
                    // exclude the __TempData key which its associcate key has been added
                    if (addedKeys.indexOf(key.replace("__TempData", "")) != -1) {
                        continue;
                    }

                    var elementInfo = key.indexOf("__TempData") != -1
                        ? elementsInfo[key.replace("__TempData", "")]
                        : elementsInfo[key];

                    friendlyName = elementInfo && elementInfo.friendlyName ? elementInfo.friendlyName : "";
                    dataValue = elementInfo && elementInfo.customBinding == true ?
                        epi.EPiServer.Forms.CustomBindingElements[elementInfo.type](elementInfo, data[key])
                        : data[key];

                    if (dataValue == null || (dataValue instanceof Array && dataValue.length === 0) || $.isEmptyObject(dataValue)) {
                        dataValue = "";
                    }

                    if (dataValue instanceof Array) {

                        // take all the name, transform, concat with comma
                        dataValue = $.map(dataValue, function (o, i) {
                            if (typeof o === "string") {
                                return o;   // multiple checkbox (dataValue  will be array of string)
                            }
                            else if (typeof o === "object") {   // File upload value
                                return o.name;   // file element, (dataValue  will be array of File object),
                            }
                        }).join(", ");
                    }
                    else if ((dataValue instanceof FileList && dataValue.length == 0)) {
                        // empty value of File upload, just check with "[object" for sastified on different browsers
                        dataValue = "";
                    }
                    else {
                        dataValue = dataValue.toString().substr(0, 46).trim(); // substr(0, 50) to not bloat/crash/break the dialog width
                        if (dataValue.length >= 45) {
                            dataValue += " ...";
                        }
                    }

                    if ($("[name=" + key + "]", workingFormInfo.$workingForm).hasClass("FormHideInSummarized")) {
                        shouldBeHiddenKeys.push(key);
                    }

                    // ignore Element with FormHideInSummarized class, hidden field, buildin field, meta field of Form, empty value, or no friendly name
                    if (friendlyName == ""
                        || friendlyName == null
                        || dataValue == ""
                        || dataValue == null
                        || ignoreFields.indexOf(key) >= 0
                        || shouldBeHiddenKeys.indexOf(key) >= 0) {
                        continue;
                    } else {
                        addedKeys.push(key);
                    }

                    if (displayAsHtmlContent) {
                        summarizedText += _utilsSvc.stringFormat("{0}: {1}" + newLineString, [friendlyName, _utilsSvc.htmlEncodeEntities(dataValue)]);
                    } else {
                        summarizedText += _utilsSvc.stringFormat("{0}: {1}" + newLineString, [_utilsSvc.htmlDecodeEntities(friendlyName), dataValue]);
                    }
                }   // end foreach(data)

                return summarizedText;
            },

            // tag: public
            // summary: 3rd developer can replace this function to show better flyout dialog instead of default HTML confirm()
            // return: "true" is Visitor allowed with the submitting data
            showSummarizedText: function (data, workingFormInfo, ignoreFields, shouldBeHiddenKeys) {
                // workingFormInfo.ElementsInfo: contains friendlyName for each field code
                // ignoreFields: are (System) fields should be ignored
                // shouldBeHiddenKeys: are fields which should not be shown (hidden field, tracking code, ...)
                // to determine field should be display or not, check $("[name=" + key + "]", workingFormInfo.$workingForm).hasClass("FormHideInSummarized"))

                var $deferred = $.Deferred(),
                    summarizedText = this.getSummarizedText(workingFormInfo, data, false);

                // empty text, no need to show the confirm box
                if (!summarizedText || summarizedText.trim() === "") {
                    $deferred.resolve(true);

                    return $deferred.promise();
                }

                var confirmResult = confirm(summarizedText);
                $deferred.resolve(confirmResult);

                return $deferred.promise();
            },

            // get custom element value, 3rd party override this method to return value from custom element
            // $element: element root
            getCustomElementValue: function ($element) {
                // default simply return 
                return $element.val();
            },

            // bind custom element value, 3rd party override this method to bind value for custom element.
            // $element: element root 
            bindCustomElementValue: function ($element, val) {
                var $elementInput = $element.find(".Form__CustomInput");
                $elementInput.val(val);
            },

            // return true if "step" is satisfy the dependCondition
            isStepSatisfyDependentCondition: function (step, workingFormInfo) {
                if (!step) return false;

                var dependField = step.dependField,
                    storedData = _dataSvc.loadCurrentFormDataFromStorage(workingFormInfo.$workingForm),
                    funcOfDependCondition = epi.EPiServer.Forms.DependConditions[step.dependCondition];

                if (!dependField || !funcOfDependCondition || !storedData)  // no input to check, consider it's OK
                    return true;

                var ret = funcOfDependCondition(storedData[dependField], step.dependValue);
                return ret;
            }
        },

        Data: {
            loadCurrentFormDataFromStorage: function ($workingForm) {
                /// <summary>load current form's data from client storage, 
                /// current form is specified by <paramref name="id"></summary>

                // get epiforms-form's data by formname
                var storage = this.getStorage(),
                    data = storage[epi.EPiServer.Forms.Utils.getFormIdentifier($workingForm)];
                if (!data) {
                    return {};
                }

                data = $.parseJSON(data);
                if (!data) {
                    return {};
                }

                return data;
            },

            // Save current form data to storage
            // @return: return the saved data	
            saveCurrentFormDataToStorage: function ($workingForm, data) {
                var storage = this.getStorage();
                // NOTE: file is NOT stringifiable then could not be stored => need use a custom library that support???
                // store data in Storage: key is dynamic-form's name, value is data object of current form
                // E.g.: { 'myformname' : { TB: "123", CB: "true" } }
                storage.setItem(epi.EPiServer.Forms.Utils.getFormIdentifier($workingForm), JSON.stringify(data));
                return data;
            },

            clearFormDataInStorage: function ($workingForm) {
                /// clear saved data of $workingForm in storage

                this.getStorage().removeItem(epi.EPiServer.Forms.Utils.getFormIdentifier($workingForm));
            },

            getStorage: function () {
                // summary:
                //      abstract storage to store EPiForms's data
                // returns: [Object]
                // tags:
                //      public

                return sessionStorage;
            }
        }
    });

    var _storage = _dataSvc.getStorage();




    /// add buildin implementation of visitor data sources
    /// ==================================================
    var buildinVisitorData = {
        VisitorData: {
            "EPiServer.Forms.Implementation.VisitorData.GeoVisitorDataSource": function ($element) {
                $.ajax({
                    url: "//freegeoip.net/json/",
                    type: "POST",
                    dataType: "jsonp",
                    success: function (location) {
                        var originalValue = $element.val(),
                            property = $element.data("epiforms-visitordataproperty");
                        if (location[property]) {
                            $element.val(location[property]);
                        }
                    }
                });
            }
        }
    };

    /// add buildin implementation of validators
    /// ========================================
    var buildinValidators = {
        Validators: {
            "EPiServer.Forms.Implementation.Validation.RequiredValidator": function (fielName, fieldValue, validatorMetaData) {
                // summary:
                //      VALIDATE REQUIRED
                // fielName: String
                //      Name of the field to be validated.
                // fieldValue: [Object]
                //      User input value for the field.
                // validatorMetaData: [Object]
                //      Validation meta data for the current element
                // returns: Object
                // tags:
                //      private


                // Check element's value for required field
                if (validatorMetaData) {
                    if (fieldValue == ""
                        // for FileUpload element
                        || (fieldValue && !fieldValue.length)) {
                        return {
                            isValid: false,
                            message: validatorMetaData.model.message
                        };
                    }
                }

                return { isValid: true };
            },

            "EPiServer.Forms.Implementation.Validation.RegularExpressionValidator": _utilsSvc.validateRegularExpressionValidator,
            "EPiServer.Forms.Implementation.Validation.EmailValidator": _utilsSvc.validateRegularExpressionValidator,
            "EPiServer.Forms.Implementation.Validation.UrlValidator": _utilsSvc.validateRegularExpressionValidator,

            "EPiServer.Forms.Implementation.Validation.DateDDMMYYYYValidator": _utilsSvc.validateRegularExpressionValidator,
            "EPiServer.Forms.Implementation.Validation.DateMMDDYYYYValidator": _utilsSvc.validateRegularExpressionValidator,
            "EPiServer.Forms.Implementation.Validation.DateYYYYMMDDValidator": _utilsSvc.validateRegularExpressionValidator,

            "EPiServer.Forms.Implementation.Validation.IntegerValidator": _utilsSvc.validateRegularExpressionValidator,
            "EPiServer.Forms.Implementation.Validation.PositiveIntegerValidator": _utilsSvc.validateRegularExpressionValidator,

            "EPiServer.Forms.Implementation.Validation.AllowedExtensionsValidator": function (fieldName, fieldValue, validatorMetaData) {

                function __isFileNameValid(fileName, blackExtensions, extensions) {
                    /// <summary>checking file name with list of extension WITHOUT DOT</summary>

                    var fileExtension = __getFileExtension(fileName);
                    // file without extension is considered as invalid
                    if (fileExtension.length < 1) {
                        return false;
                    }

                    fileExtension = fileExtension.toLowerCase();
                    if (blackExtensions.indexOf(fileExtension) >= 0) {
                        return false;
                    }

                    // just check when extension was specified
                    if (extensions.length < 1) {
                        return true;
                    }

                    return extensions.indexOf(fileExtension) > -1;
                }

                function __getFileExtension(fileName) {
                    /// <summary>get file extension WITHOUT DOT</summary>

                    // returning "" instead of the full string when there's no dot or no string before the dot
                    return fileName.substr((~-fileName.lastIndexOf(".") >>> 0) + 2);  // replace "+ 2" with "+ 1" to include the DOT
                }

                if (!fieldValue || (fieldValue instanceof Array && fieldValue.length == 0)) {
                    return { isValid: true };
                }

                var files = fieldValue,
                    acceptValue = validatorMetaData.model.accept,
                    unacceptTypes = epi.EPiServer.Forms.UploadExtensionBlackList.split(","),
                    acceptTypes = (acceptValue == undefined || acceptValue.length < 1) ? [] : acceptValue.split(","),
                    i = 0, j = 0,
                    totalAcceptTypes = acceptTypes.length,
                    totalFiles = files.length;

                // remove the DOT before checking, acceptTypes was sent from server always starts with DOT
                if (totalAcceptTypes > 0) {
                    for (; i < totalAcceptTypes; i++) {
                        acceptTypes[i] = acceptTypes[i].substr(1);
                    }
                }

                // for simpleness, just comparing the extension, NOT cover image/*|video/*|audio/* pattern
                for (; j < totalFiles; j++) {
                    if (!__isFileNameValid(files[j].name, unacceptTypes, acceptTypes)) {
                        return {
                            isValid: false,
                            message: epi.EPiServer.Forms.Utils.stringFormat(validatorMetaData.model.message, [acceptValue])
                        }
                    }
                }

                return { isValid: true };
            },
            "EPiServer.Forms.Implementation.Validation.MaxFileSizeValidator": function (fieldName, fieldValue, validatorMetaData) {

                var files = fieldValue,
                    i = 0,
                    totalItems = files.length,
                    expectedSize = validatorMetaData.model.sizeInBytes,
                    isValid = true;
                for (; i < totalItems; i++) {
                    if (files[i].size > expectedSize) {
                        return {
                            isValid: false,
                            message: epi.EPiServer.Forms.Utils.stringFormat(validatorMetaData.model.message, [expectedSize / (1024 * 1024)])
                        };
                    }
                }

                return { isValid: true };
            },
            "EPiServer.Forms.Implementation.Validation.CaptchaValidator": {

                initialize: function ($element) {
                    // summary:
                    //      Initialize Captcha validator
                    // $element: [Object]
                    //      Current element.

                    var self = this;
                    $element.parents(".FormCaptcha").find(".FormCaptcha__Refresh").on("click", function (e) {
                        self.refreshCaptcha($(this));
                        e.preventDefault(); // to prevent page refreshed
                    });
                },

                validate: function (fieldName, fieldValue, validatorMetaData) {
                    // summary:
                    //      Validate Captcha data
                    // fielName: String
                    //      Name of the field to be validated.
                    // fieldValue: [Object]
                    //      User input value for the field.
                    // validatorMetaData: [Object]
                    //      Validation meta data for the current element
                    // returns: Object
                    // tags:
                    //      private

                    // we cannot validate the captcha in clientside, but at least we expect something from user
                    var actualCaptchaValue = fieldValue.trim();
                    return actualCaptchaValue != null && actualCaptchaValue != "";
                },

                onServerValidateFailed: function ($element, validator) {
                    // summary:
                    //      Call when validate on server side failed.
                    // $element: [Object]
                    //      Current element to validate.
                    //  validator: [Object]
                    //      Captcha validator.

                    this.refreshCaptcha($element);
                },

                refreshCaptcha: function ($element) {
                    /// <summary>Refresh captcha image to get new one</summary>

                    var $parent = $element.parents(".FormCaptcha"),
                        $captchaImg = $parent.find(".FormCaptcha__Image"),
                        $captchaInput = $parent.find(".FormTextbox__Input");

                    $captchaImg.attr("src", $captchaImg.attr("src") + "&d=" + Math.random());   // random param to avoid cache of the image
                    // clear input value
                    $captchaInput.val("");
                }
            }
        }
    };

    var buildinDependConditions = {

        DependConditions: {
            "Equals": function (actualValue, expectedValue) {
                // summary:
                //      Compare whether user input data equals depend value or not.
                // userValue: [Object]
                //      Value that user has input
                // dependValue: [Object]
                //      The depend value need to be verified.
                // returns: [Boolean]
                // tags:
                //      private

                actualValue = !actualValue ? '' : epi.EPiServer.Forms.Utils.getConcatString(actualValue, ",").toUpperCase();

                expectedValue = !expectedValue ? '' : expectedValue.toUpperCase();

                return actualValue === expectedValue;
            },

            "NotEquals": function (actualValue, expectedValue) {
                // summary:
                //      Compare whether user input data does NOT equal depend value or not.
                // userValue: [Object]
                //      Value that user has input
                // dependValue: [Object]
                //      The depend value need to be verified.
                // returns: [Boolean]
                // tags:
                //      private

                actualValue = !actualValue ? '' : epi.EPiServer.Forms.Utils.getConcatString(actualValue, ",").toUpperCase();

                expectedValue = !expectedValue ? '' : expectedValue.toUpperCase();

                return actualValue != expectedValue;
            },

            "Contains": function (actualValue, expectedValue) {
                // summary:
                //      Compare whether user input data contains depend value or not.
                // userValue: [Object]
                //      Value that user has input
                // dependValue: [Object]
                //      The depend value need to be verified.
                // returns: [Boolean]
                // tags:
                //      private

                actualValue = !actualValue ? '' : epi.EPiServer.Forms.Utils.getConcatString(actualValue, ",").toUpperCase();

                expectedValue = !expectedValue ? '' : expectedValue.toUpperCase();

                return actualValue.indexOf(expectedValue) >= 0;
            },

            "NotContains": function (actualValue, expectedValue) {
                // summary:
                //      Compare whether user input data does NOT contain depend value or not.
                // userValue: [Object]
                //      Value that user has input
                // dependValue: [Object]
                //      The depend value need to be verified.
                // returns: [Boolean]
                // tags:
                //      private

                actualValue = !actualValue ? '' : epi.EPiServer.Forms.Utils.getConcatString(actualValue, ",");

                return (!actualValue && expectedValue)
                    || (actualValue && !expectedValue)
                    || (actualValue && expectedValue && actualValue.toUpperCase().indexOf(expectedValue.toUpperCase()) < 0);
            },

            "MatchRegularExpression": function (actualValue, patternOfExpected) {
                // summary:
                //      Compare user input with a pattern. Return true if pattern matchs actualUserValue
                // userValue: [Object]
                //      Value that user has input
                // pattern: [Object]
                //      The depend value need to be verified.
                // returns: [Boolean]
                // tags:
                //      private

                var regex = new RegExp(patternOfExpected, "igm");
                regex.ignoreCase = regex.global = regex.multiline = true;

                return (!patternOfExpected) || (patternOfExpected && regex.test(actualValue));
            }
        }
    };

    var buildInCustomBindingElements = {
        CustomBindingElements: {}
    };

    $.extend(true, epi.EPiServer.Forms, buildinVisitorData);
    $.extend(true, epi.EPiServer.Forms, buildinValidators);
    $.extend(true, epi.EPiServer.Forms, buildinDependConditions);
    $.extend(true, epi.EPiServer.Forms, buildInCustomBindingElements);

    /// init function for clientside interaction of EPiServer.Forms
    /// ================================================
    epi.EPiServer.Forms.init = function () {
        // if this script is initialized once, it will return immediately.
        if (epi.EPiServer.Forms.__Initialized) {
            return;
        }
        epi.EPiServer.Forms.__Initialized = true;   // turn the flag            console.debug("epi.EPiServer.Forms.init", "epi.EPiServer.Forms.__Initialized:", epi.EPiServer.Forms.__Initialized);


        $(document).ready(function () {

            // pre-condition to use sessionStorage
            if (!_storage) {
                $('.EPiServerForms .Form__Status__Message').text(epi.EPiServer.Forms.ErrorMessages.cantnotworkwithoutstorage);
                return;
            }


            /// foreach Forms in this page, take the formDescriptor (workingFormInfo) and call functions with that context.
            /// most of functions here should work with that context, not lookup the $workingForm by itself.
            $('.EPiServerForms').each(function (index, item) {
                var $workingForm = $(item),
                    workingFormInfo = getFormDescriptor($workingForm);

                // is this form allowed current user to submit?
                if (workingFormInfo.SubmittableStatus && workingFormInfo.SubmittableStatus.submittable === false) {
                    showFormMessage(workingFormInfo, workingFormInfo.SubmittableStatus.message);
                }

                navigationInit(workingFormInfo);

                /// foreach Init all declared Validators
                $(workingFormInfo.ValidationInfo).each(function (index, item) {
                    $(item.validators).each(function (i, validator) {
                        var staticValidator = epi.EPiServer.Forms.Validators[validator.type];
                        // call initialize() func of Validator object to init it with actual element
                        if (staticValidator && typeof staticValidator["initialize"] === "function") {
                            staticValidator["initialize"]($("#" + item.targetElementId));
                        }
                    });
                });

                _utilsSvc.injectVisitorData(workingFormInfo);

                //// TECHNOTE: we don't support Element depends on other Element, so this feature might be remove
                //// on blur,keyup of textbox, textarea, on change of listbox, radio, we try to validate current form page, and update 'live' features
                //$('.EPiServerForms .Form__Element:input').on('blur keyup change', epi.EPiServer.Forms.Utils.debounce(function myfunction() {
                //    var formData = loadCurrentFormDataFromStorage();
                //    // run validate(), if OK, save to Storage, try to update some "live" features (DynamicLabel,...)
                //    var validateOK = _validateCurrentForm();
                //    if (validateOK) {
                //        // save data from UI (DOM element to storage)
                //        var formData = saveCurrentFormDataToStorage();

                //        if (formData) {
                //            _rebindElementWithFormStorageData(formData);
                //        }
                //    }
                //}, epi.EPiServer.Forms.ThrottleTimeout)    // delay/throttle so we don't abuse the browser to update DOM too often
                //);

                // handle click event of submit buttons of each form
                $(".Form__Element.FormSubmitButton", $workingForm).off("click", _formSubmissionHandler)
                    .on("click", _formSubmissionHandler);

                $(".Form__Element.FormResetButton", $workingForm).off("click", _formResetHandler)
                    .on("click", _formResetHandler);

                _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsSetupCompleted' });
            });

            // when key is pressed in Textbox--Number, 
            // in keydown, we get the keyCode, in keyup, we get the input.value (including the charactor we've just typed)
            $('.EPiServerForms .FormTextbox--Number .FormTextbox__Input').on('keydown', function _liveRevalidateNumberInput_KeyDown(e) {
                var key = e.which || e.keyCode;

                // ignore alphabet and spacebar
                if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                    key >= 65 && key <= 90 ||
                    key == 32) {
                    return false;
                }

                if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                    // numbers and Numeric keypad
                    key >= 48 && key <= 57 ||
                    key >= 96 && key <= 105 ||

                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: Ctrl+C
                    (key == 67 && e.ctrlKey === true) ||
                    // Allow: Ctrl+X
                    (key == 88 && e.ctrlKey === true) ||
                    //(key == 86 && e.ctrlKey === true)   // Allow: Ctrl+V

                    // Allow: home, end, left, right
                    (key >= 35 && key <= 39) ||
                    // Backspace and Tab and Enter
                    key == 8 || key == 9 || key == 13 ||
                    // Del and Ins
                    key == 46 || key == 45) {
                    return true;
                }

                var v = this.value; // v can be null, in case textbox is number and does not valid
                if (//  minus, dash
                    key == 109 || key == 189) {
                    // if already has -, ignore the new one
                    if (v[0] === '-') {
                        return false;
                    }
                }

                if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                    // comma, period and dot on keypad
                    key == 190 || key == 188 || key == 110) {
                    // already having comma, period, dot
                    if (/[\.,]/.test(v)) {
                        return false;
                    }
                }
            })
            .on('keyup', function _liveRevalidateNumberInput_KeyUp(e) {
                // routine run to this case is typing - in the middle of the string, or Ctrl V some invalid chars
                var v = this.value;

                if (+v) { // convert to number success
                    //                      "1000"	"10.9"	"1,000.9"	"011"	"10c"	"$10"
                    //+str, str*1, str-0	1000	10.9	NaN	        11	    NaN	    NaN
                    // do nothing, let it be
                } else if (v) {
                    // refine the value
                    v = (v[0] === '-' ? '-' : '') + v.replace(/[^0-9\.]/g, ""); // we will also remove the -, so we need to retain negative state
                    v = v.replace(/\.(?=(.*)\.)+/g, "");  // remove all dot that have other dot following. Only the last dot is kept.
                    this.value = v; // only replace if we have to change wrong value with right one
                }

            });



            function _formSubmissionHandler(/*Event*/e) {
                e.preventDefault();
                e.stopPropagation();

                var $workingForm = _utilsSvc.getWorkingFormFromInnerElement(e.target),
                    workingFormInfo = getFormDescriptor($workingForm);


                // do nothing if the form should not be submitted
                if (workingFormInfo.SubmittableStatus.submittable === false) {
                    showFormMessage(workingFormInfo, workingFormInfo.SubmittableStatus.message);
                    return false;
                }

                // validate on current Step not the whole Form
                var $currentStep = _getCurrentStepDOM(workingFormInfo);
                if (!validateElementsIn($currentStep, workingFormInfo)) {
                    _refereshCaptchaElement($currentStep);
                    return false;
                }

                // get all element's data for validating whole form before do submit
                var data = getCurrentFormData($workingForm);   // get saved form data, merged with current stepview,
                $.when(showSummarizedData(workingFormInfo, data)).then(function (userAcceptToSubmit) {
                    if (!userAcceptToSubmit) {
                        return false;
                    }

                    // With multi-step-multi-page Form user can jump directly to the last step and bypass middle steps validation,
                    // then need to re-Validate the whole form data before submit it
                    var validateResults = []
                    for (var fieldName in data) {
                        if (fieldName.indexOf("__TempData") != -1) {
                            continue;
                        }

                        var validators = _getElementValidators(workingFormInfo.ValidationInfo, fieldName);
                        validateResults = validateResults.concat(validateFormValue(fieldName, data[fieldName], validators));
                    }

                    var invalidResultItems = $.grep(validateResults, function (item) {
                        return item.isValid == false;
                    });

                    if (invalidResultItems.length > 0) {
                        var messages = $.map(invalidResultItems, function (item) {
                            return workingFormInfo.ElementsInfo[item.fieldName].friendlyName + ": " + item.message;
                        });
                        showFormMessage(workingFormInfo, messages.join(" "));

                        // cancel submit form
                        return false;
                    }

                    _doSubmitForm(e);
                });
            }

            function _formResetHandler(/*Event*/e) {
                e.preventDefault();
                e.stopPropagation();

                var $workingForm = _utilsSvc.getWorkingFormFromInnerElement(e.target),
                    workingFormInfo = getFormDescriptor($workingForm);

                _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsReset', sourceEvent: e });
                // reset form values
                _resetFormValues($workingForm, workingFormInfo);

                // Navigate to the first step when RESET button is clicked.
                navigateToStep(workingFormInfo.StepsInfo.Steps[0], workingFormInfo);
            }

            // Reset value of form elements to default
            // tags:
            //      private
            function _resetFormValues($workingForm, workingFormInfo) {

                $workingForm.get(0).reset();    // explicitly call reset() on form DOM element
                showFormMessage(workingFormInfo, "");
                _dataSvc.clearFormDataInStorage($workingForm);     // clear saved form storage

                // clear all data of every Form__Element
                $(".Form__Element", $workingForm).each(function loopEachFormElementToClear(i, formElement) {
                    var $el = $(formElement);

                    // clear ValidationMessage (Form__Element__ValidationError)
                    _getValidationMessage($el).text("");


                    if ($el.hasClass("FormChoice")) {
                        // For radio, checkbox (of Choice elements) inside a hidden container (previous/next steps)
                        $el.find("input[type=checkbox], input[type=radio]").each(function (i, input) {
                            var $checkOrRadio = $(input);
                            $checkOrRadio.prop("checked", $checkOrRadio.data("epiforms-default-value") ? true : false);
                        });
                    }
                    else if ($el.hasClass("FormSelection")) {

                        $el.find('option[disabled]:eq(0)').prop("selected", true);    // select the first null thing, then try to select the default-value later

                        // For select elements (of Selection) inside a hidden container (previous/next steps)
                        $el.find('option').each(function (i, option) {
                            var $option = $(option);
                            if ($option.prop("disabled") === false) {
                                $option.prop("selected", $option.data("epiforms-default-value") ? true : false);
                            }
                        });
                    }
                    else if ($el.hasClass("FormFileUpload")) {
                        // Remove posted file message
                        _getPostedFileMessage($el).text("");
                        _hack_clearFileInput($el.find(".FormFileUpload__Input"));
                    };
                });
            }

            // Prepare FormData object, submit form process, this can be called when click submitbutton, or when changing form step
            // e: [Event]
            //      Current event object
            // tags:
            //      private
            function _doSubmitForm(/*Event*/e) {
                var $workingForm = _utilsSvc.getWorkingFormFromInnerElement(e.target),
                    workingFormGuid = epi.EPiServer.Forms.Utils.getFormIdentifier($workingForm),
                    workingFormInfo = getFormDescriptor($workingForm);

                // store result to session storage
                var data = _dataSvc.saveCurrentFormDataToStorage($workingForm, getCurrentStepData($workingForm)),
                    formData = new FormData(); // Using FormData object to post data and upload files

                var currentStepIndex = _utilsSvc.getCurrentStepIndex(workingFormInfo),
                    nextStep = _findNextStep(currentStepIndex, workingFormInfo),
                    isFinalizedSubmission = nextStep ? false : true;

                // these informations are stored as hiden inputs of this Form as well
                formData.append("__FormGuid", workingFormGuid);
                formData.append("__FormHostedPage", epi.EPiServer.CurrentPageLink);
                formData.append("__FormLanguage", epi.EPiServer.CurrentPageLanguage);
                formData.append("__FormCurrentStepIndex", currentStepIndex);
                formData.append("__FormWithJavaScriptSupport", "true"); // so only JS-enable-browser can set this form field

                var ovalue;
                for (var key in data) {
                    if (!data.hasOwnProperty(key)) {
                        continue;
                    }

                    ovalue = data[key];
                    // checking file upload elements, item must be File if any,
                    // for using Object.getPrototypeOf(variable) variable must be object type
                    if (Array.isArray(ovalue) && ovalue.length > 0 &&
                        ovalue[0] !== null && typeof ovalue[0] === "object" &&
                        ovalue[0].file && Object.getPrototypeOf(ovalue[0].file) === File.prototype) {
                        var files = ovalue, fileNames = "", ofile;

                        // append each upload file with a unique key (bases on element's key) so that the server side can see it through the Request.Files,
                        // concat all the files' name and assign with the element's Id
                        for (var idx = 0; idx < files.length; idx++) {
                            ofile = files[idx].file;
                            formData.append(key + "_file_" + idx, ofile);
                            fileNames += ofile.name + "|";   // charactor | cannot be used in filename and then is safe for splitting later
                        }
                        formData.append(key, fileNames);
                    }
                    else {
                        formData.append(key, ovalue);
                    }
                }

                _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsStartSubmitting', formData: formData });

                // Start submitting data
                var $actionButton = $(e.srcElement || e.target);
                $actionButton.prop("disabled", true); // Disable submit button to avoid accident multi-click
                showFormMessage(workingFormInfo, "");   // clear Forms message showed by prev step (multi-step-one-page)

                $.ajax({
                    url: $workingForm.prop('action'),
                    data: formData,
                    cache: false,
                    type: $workingForm.prop('method'),  // post, get
                    processData: false, // tells jQuery doesn't process the formData object in any way
                    contentType: false, // tells jQuery doesn't add a boundary, something it would normally do
                    async: false,

                    success: function onFormSubmittingSuccess(returnedResult) {
                        e.preventDefault();

                        if (returnedResult.IsSuccess === true) {

                            // remove upload elements' files (on the current DOM Step) to avoid repeated upload between Next/Prev of multi-step-ONE-page
                            // where selected file(s) are still keeped with the element(s)
                            var $currentStep = _getCurrentStepDOM(workingFormInfo);
                            $(".FormFileUpload .FormFileUpload__Input", $currentStep).each(function (index, item) {
                                $(this).val("");
                                _hack_clearFileInput($(this));
                            });

                            /////// Step submission
                            if (isFinalizedSubmission == false) {
                                _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsNavigationNextStep', targetStep: nextStep });

                                var oldData = _dataSvc.loadCurrentFormDataFromStorage($workingForm),// Get the current data collection
                                    newMergeData = $.extend(oldData, { "__FormSubmissionId": returnedResult.Data.SubmissionId });
                                _dataSvc.saveCurrentFormDataToStorage($workingForm, newMergeData);

                                _utilsSvc.raiseFormsEvent(workingFormInfo, {
                                    type: 'formsSubmitted', formData: formData, isFinalizedSubmission: false,
                                    isSuccess: returnedResult.IsSuccess,
                                    returnedResult: returnedResult
                                });

                                navigateToStep(nextStep, workingFormInfo);
                                return false;   // quit the doSubmitForm()
                            }

                            /////// Full form submission
                            // reset form values
                            _resetFormValues($workingForm, workingFormInfo);

                            _utilsSvc.raiseFormsEvent(workingFormInfo, {
                                type: 'formsSubmitted', formData: formData, isFinalizedSubmission: true,
                                isSuccess: returnedResult.IsSuccess,
                                returnedResult: returnedResult
                            });


                            if (returnedResult.RedirectUrl) {
                                window.location.href = returnedResult.RedirectUrl;
                                return false;   // quit the doSubmitForm()
                            }
                            else {
                                // show success message and hide form body
                                $('.Form__MainBody', workingFormInfo.$workingForm).hide();
                                showFormMessage(workingFormInfo, returnedResult.Message);
                            }
                        }
                            // server return fail then show the reason
                        else {
                            _navigationBarUpdate(workingFormInfo);

                            _utilsSvc.raiseFormsEvent(workingFormInfo, {
                                type: 'formsSubmitted', formData: formData,
                                isSuccess: returnedResult.IsSuccess,
                                returnedResult: returnedResult
                            });

                            if (returnedResult.Message) {
                                showFormMessage(workingFormInfo, returnedResult.Message);
                            }

                            // validation fail then got the element and corresponding validator which causes fail
                            if (returnedResult.Data && returnedResult.Data.ValidationInfo.InvalidElement) {
                                // get the elements from its id
                                var $element = $("#" + returnedResult.Data.ValidationInfo.InvalidElement + "", workingFormInfo.$workingForm),
                                    $messageContainer = _getValidationMessage($element),
                                    validatorsInfo = _getElementValidators(workingFormInfo.ValidationInfo, returnedResult.Data.ValidationInfo.InvalidElement),
                                    validatorInfo = _getValidatorByValidatorType(validatorsInfo, returnedResult.Data.ValidationInfo.Validator);

                                // call event onServerValidateFailed for element update its UI if needed
                                if (validatorInfo) {
                                    var validatorObj = epi.EPiServer.Forms.Validators[validatorInfo.type],
                                        func_onServerValidateFailed = validatorObj["onServerValidateFailed"];
                                    if (func_onServerValidateFailed && typeof (func_onServerValidateFailed) === "function") {
                                        func_onServerValidateFailed.apply(validatorObj, [$element, validatorInfo]);
                                    }
                                }

                                $messageContainer.text(returnedResult.Data.ValidationInfo.ValidationMessage || epi.EPiServer.Forms.Messages.viewMode.commonValidationFail).show();
                            }
                        }
                    },
                    error: function onFormSubmittingError(xhr, typeOfFailure, status) {
                        e.preventDefault();
                        //console.error(typeOfFailure, status, xhr.responseText);
                        showFormMessage(workingFormInfo, typeOfFailure + " " + xhr.status + ": " + status);
                    },
                    complete: function onFormSubmittingComplete() {
                        //A function to be called when the request finishes (after success and error callbacks are executed). 
                        $actionButton.prop("disabled", false);
                        _navigationBarUpdate(workingFormInfo);  // refresh the state of next/prev button, because nextbutton can be submit button, and it loses its :disabled state in submitting process
                    }
                });
            }

            // show Summarized of submitted Data before submitting. Return true of end user accept to submit data
            function showSummarizedData(workingFormInfo, data) {

                var $deferred = $.Deferred();

                // is this form configured to show summarized data before submitting?
                if (!workingFormInfo.ShowSummarizedData) {
                    $deferred.resolve(true);

                    return $deferred.promise();
                }

                var shouldBeHiddenKeys = [],
                    ignoreFields = ["__FormGuid", "__FormLanguage", "__FormCurrentStepIndex", "__FormSubmissionId"];

                return _extensionSvc.showSummarizedText(data, workingFormInfo, ignoreFields, shouldBeHiddenKeys);
            }

            // show the message to Form's message area, give empty <param message> to clear the message panel
            function showFormMessage(workingFormInfo, message) {
                if (!workingFormInfo) {
                    return;
                }

                var $messagePanel = $(".Form__Status__Message", workingFormInfo.$workingForm);

                if (message) {
                    return $messagePanel.removeClass("hide").addClass("Form__Warning__Message").html(message);
                }
                else {
                    return $messagePanel.removeClass("Form__Warning__Message").addClass("hide").html("");
                }
            };

            // rebind DOM dynamic-element (of current $workingForm) base on form's storage data
            function _rebindElementWithFormStorageData(formData, $workingForm) {

                $.each(formData, function (name, val) {
                    // bind checkbox, radio, dropdown, ... state
                    var $item = $('[name="' + name + '"]', $workingForm);
                    if (name.indexOf("__TempData") != -1) {
                        $item = $('[name="' + name.replace("__TempData", "") + '"]', $workingForm);
                    }

                    if ($item.length > 0) { //found the input control that should hold field value

                        if ($item.hasClass("FormChoice__Input--Checkbox")) {
                            // several input-checkbox will have same name
                            $.each($item, function () {
                                var currentInputValue = $(this).val();
                                // val is array of selectedValues, or a string of selected Value
                                $(this).attr('checked', val.indexOf(currentInputValue) > -1);
                            });
                            return;
                        }

                        if ($item.hasClass("FormChoice__Input--Radio")) {
                            var savedItemValue = $.isArray(val) ? val[0] : val;

                            // several input-radio will have same name, we have to filter by value as well
                            $.each($item, function () {
                                var currentInputValue = $(this).val();
                                $(this).attr('checked', savedItemValue == currentInputValue);
                            });
                            return;
                        }

                        if ($item.parents('.FormSelection:first').length > 0) {
                            $("option", $item).each(function (i, el) {
                                $(el).attr('selected', val.indexOf($(el).val()) > -1);
                            });
                            return;
                        }

                        // don't rebind entered value for captcha
                        if ($item.hasClass("FormCaptcha__Input")) {
                            return;
                        }

                        if ($item.hasClass("FormFileUpload__Input")) {
                            var postedFileName = val instanceof Array && val.length > 0 ? val[0].name : "",
                                $fileUploadElement = $item.parents(".FormFileUpload:first");
                            if (postedFileName) {
                                var postedFiledMessage = _utilsSvc.stringFormat(epi.EPiServer.Forms.Messages.fileUpload.postedFile, [postedFileName]),
                                    $postedFileMessage = _getPostedFileMessage($fileUploadElement);
                                $postedFileMessage.text(postedFiledMessage).show();
                            }

                            return;
                        }

                        // if the element need custom binding data
                        if ($item.hasClass("Form__CustomInput")) {
                            var $element = $item.parents(".Form__CustomElement:first");
                            _extensionSvc.bindCustomElementValue($element, val);
                            return;
                        }

                        // default case, textbox, textarea, selection, ... jQuery.val() can do itself
                        $item.val(val);
                    }

                }); // end each(data)

            }

            // Gets posted file message element
            function _getPostedFileMessage($fileUploadElement) {
                var $messageContainer = $fileUploadElement.find(".FormFileUpload__PostedFile");
                return $messageContainer;
            }

            // Gets current step form data, New data (of current step) will be merged with old data, and new field's value will overrides old one.
            function getCurrentStepData($workingForm, excludeCallback) {
                var workingFormInfo = getFormDescriptor($workingForm);
                // get currentStepDOM and collect input in this step only
                var $currentStep = _getCurrentStepDOM(workingFormInfo);
                var newData = collectInputData($currentStep, excludeCallback),
                    oldData = _dataSvc.loadCurrentFormDataFromStorage($workingForm); // Get the current data collection

                return $.extend(oldData, newData);
            }

            // Gets current form data, New data will be merged with old data, and new field's value will overrides old one.
            function getCurrentFormData($workingForm) {
                var newData = collectInputData($workingForm),
                    oldData = _dataSvc.loadCurrentFormDataFromStorage($workingForm);

                return $.extend(oldData, newData);
            }


            // From DOM element, get the FormDescriptor object
            function getFormDescriptor($workingForm) {
                var workingFormGuid = _utilsSvc.getFormIdentifier($workingForm),
                    workingFormInfo = epi.EPiServer.Forms[workingFormGuid];

                workingFormInfo.$workingForm = $workingForm;

                return workingFormInfo;
            }

            // inspect the form UI's inputs inside the $container, return object which contains all input data from users.
            function collectInputData($container, excludeCallback) {
                var result = {};    // this is data dictionary, key will be elementName, value is value of element

                // Get textbox/textarea/selection/listbox values
                $(".Form__Element, .Form__CustomElement", $container).each(function (index, el) {
                    $el = $(el);
                    if (typeof excludeCallback === "function" && excludeCallback($el)) {
                        return;
                    }

                    var elementName = el.name || $el.data('epiforms-element-name');
                    if (!elementName) {
                        return;
                    }

                    // if none is selected then assign empty value so that the element's name presents in the post,
                    // available name will tell server side that this posts an empty value and an asscociate field must be created
                    result[elementName] = _utilsSvc.getElementValue($el);
                });

                // Get fileupload data
                $(".FormFileUpload .FormFileUpload__Input", $container).each(function (index) {
                    if (typeof excludeCallback === "function" && excludeCallback($(this))) {
                        return;
                    }

                    if (!this.name || this.files == undefined) {
                        return;
                    }

                    var tempdataName = this.name + "__TempData";
                    result[this.name] = [];
                    result[tempdataName] = [];

                    if (this.files.length === 0) {
                        var files = _utilsSvc.getPreviousPostedFiles($(this).parents(".FormFileUpload:first"));
                        result[this.name] = files;
                        result[tempdataName] = files;
                    } else {
                        for (var fileIdx = 0; fileIdx < this.files.length; fileIdx++) {
                            var oFile = this.files[fileIdx];

                            result[this.name].push({
                                "name": oFile.name,
                                "file": oFile
                            });
                            result[tempdataName].push({
                                "name": oFile.name
                            });
                        }
                    }
                });

                return result;
            }




            /// Scan all Form__Element in a specific container element (currently only support Step element), 
            /// return true if all the elements satisfy its validators.
            function validateElementsIn($container, /*Object*/workingFormInfo) {
                if (!$container) {
                    return true; // nothing to validate then got validated of true
                }

                var isValid = true;
                // Validate textbox/textarea/selection values
                $(".FormTextbox, .FormTextbox--Textarea, .FormSelection, .FormChoice, .FormFileUpload, .Form__CustomElement", $container).each(function (index, element) {
                    isValid = isValid && validateElement(element, workingFormInfo);
                });

                _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsStepValidating', isValid: isValid });

                workingFormInfo.$workingForm.toggleClass("ValidationFail", !isValid);

                return isValid;
            }

            /// validate element, return false if fail, show/hide the $messageContainer for this element
            // element: should be the DOM root of each Form__Element
            function validateElement(element, workingFormInfo) {
                // TODO: move the showing message code to another function, this function should just do validating
                var $element = $(element),
                    $messageContainer = _getValidationMessage($element),
                    elementName = $element.attr("name") || $element.data("epiforms-element-name"),
                    elementIdentifier = $element.attr("id") || elementName,
                    validators = _getElementValidators(workingFormInfo.ValidationInfo, elementIdentifier),
                    isValid = true;

                if (!(validators instanceof Array) || validators.length === 0) {
                    return isValid;
                }

                var elementValue = _utilsSvc.getElementValue($element);
                var results = validateFormValue(elementName, elementValue, validators);
                var invalidResultItems = $.grep(results, function (item) {
                    return item.isValid == false;
                });

                if (invalidResultItems && invalidResultItems.length > 0) {
                    var messages = $.map(invalidResultItems, function (item) {
                        return item.message;
                    });

                    $element.addClass("ValidationFail");

                    $messageContainer.text(messages.join(" ")).show();

                    return false;
                } else {

                    $element.removeClass("ValidationFail");

                    $messageContainer.hide();

                    return true;
                }
            }

            // summary:
            //      Validate a field with input value.
            // return: Array of result object. ex [ { isValid: true }]
            function validateFormValue(fieldName, fieldValue, validators) {
                var results = [];

                $(validators).each(function (index, item) {

                    // take the Actor, it can be function to execute, or contain property (of type function) "validate"
                    var validatorActor = epi.EPiServer.Forms.Validators[item.type];
                    var validatorFunc = null;

                    if (typeof validatorActor === "function") {
                        validatorFunc = validatorActor;
                    } else if (typeof validatorActor["validate"] === "function") {
                        validatorFunc = validatorActor["validate"];
                    }

                    // execute the validatorFunc
                    if (validatorFunc) {
                        var itemResult = validatorFunc(fieldName, fieldValue, item);
                        $.extend(itemResult, { fieldName: fieldName, fieldValue: fieldValue });
                        results.push(itemResult);
                    }
                });

                return results;
            }

            function _getValidationMessage(/*Object*/$element) {
                // summary:
                //      Gets message container object by the given element
                // $element: [Object]
                //      Current element as jQuery object
                // returns: [Object]
                //      Message container as jQuery object
                // tags:
                //      private

                // try to find Form__Element__ValidationError based on name attribute first
                var elementName = $element.attr('name') || $element.data('epiforms-element-name');
                var selector = _utilsSvc.stringFormat("{0}[data-epiforms-linked-name={1}], {0}[data-epiforms-linked-name={2}]",
                    [".Form__Element__ValidationError", elementName, $element.attr('id')]);
                return $(selector);
            }

            // summary:
            //      Gets all validator meta data objects by the given element identifier
            // formValidationInfo: [Array]
            //      Entire validation info of this FORM
            // elementIdentifier: [String]
            //      HTML tag id or name
            // returns: [Array]
            //      Collection of validator meta data object
            // tags:
            //      private
            function _getElementValidators(/*Array*/formValidationInfo, /*String*/elementIdentifier) {
                if (!(formValidationInfo instanceof Array) || formValidationInfo.length === 0 || !elementIdentifier) {
                    return;
                }

                var itemIndex = 0,
                    totalItems = formValidationInfo.length,
                    item = null;
                for (; itemIndex < totalItems; itemIndex++) {
                    item = formValidationInfo[itemIndex];
                    if (!item) {
                        continue;
                    }

                    if (item.targetElementId === elementIdentifier || item.targetElementName === elementIdentifier) {
                        return item.validators;
                    }
                }
            }

            // summary:
            //      Gets validator metadata by tag name from given validators array
            // elementValidators: [Array]
            //      Collection of validator metadata
            // validatorType: [String]
            //      Validator tag
            // returns: [Object]
            //      Validator metadata object that matched with the given tag
            // tags:
            //      private
            function _getValidatorByValidatorType(/*Array*/elementValidators, /*string*/validatorType) {

                if (!(elementValidators instanceof Array) || elementValidators.length === 0 || !validatorType) {
                    return;
                }

                var itemIndex = 0, item = null,
                    totalItems = elementValidators.length;
                for (; itemIndex < totalItems; itemIndex++) {
                    item = elementValidators[itemIndex];
                    if (!item) {
                        continue;
                    }

                    if (item.type === validatorType) {
                        return item;
                    }
                }

            }




            // init navigation panel inside Form, for changing between steps
            function navigationInit(workingFormInfo) {
                // there is no step data, // no need to do anything
                if (!workingFormInfo || !workingFormInfo.StepsInfo || !workingFormInfo.StepsInfo.Steps) {
                    return;
                }

                // initialize value of workingFormInfo.$steps
                workingFormInfo.$steps = $(".FormStep", workingFormInfo.$workingForm);

                // just one step, no need to init navigation anymore
                if (workingFormInfo.StepsInfo.Steps.length < 2) {
                    return;
                }

                var currentStep = workingFormInfo.StepsInfo.Steps[_utilsSvc.getCurrentStepIndex(workingFormInfo)];
                navigateToStep(currentStep, workingFormInfo);    // move navigateToStep(current) here, so if we need redirection, the rest of function no need to be run.

                $(".Form__NavigationBar__Action.btnNext", workingFormInfo.$workingForm).on("click", function (e) {
                    e.preventDefault(); // because this is submit button

                    // validate on current Step not on whole the Form
                    var $currentStep = _getCurrentStepDOM(workingFormInfo);
                    var isValid = validateElementsIn($currentStep, workingFormInfo);
                    if (!isValid) {
                        _refereshCaptchaElement($currentStep);
                        return false;
                    }

                    // validate OK, now we submit
                    _doSubmitForm(e);
                });

                $(".Form__NavigationBar__Action.btnPrev", workingFormInfo.$workingForm).on("click", function (e) {
                    e.preventDefault(); // because this is submit button

                    // when go back, we don't need to validate, just save the state
                    var newMergeData = getCurrentStepData(workingFormInfo.$workingForm, /*excludeCallback*/function __excludeFileUpload($element) {
                        return $element.hasClass("FormFileUpload");
                    });
                    _dataSvc.saveCurrentFormDataToStorage(workingFormInfo.$workingForm, newMergeData); // save form state before changing step

                    var prevStep = _findPreviousStep(_utilsSvc.getCurrentStepIndex(workingFormInfo), workingFormInfo);
                    navigateToStep(prevStep, workingFormInfo);

                    // refresh captcha elements
                    var $step = $("section[data-epiforms-stepindex=" + prevStep.index + "]", workingFormInfo.$workingForm);
                    _refereshCaptchaElement($step);

                    _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsNavigationPrevStep', targetStep: prevStep });
                });

            };  // navigationInit


            // navigate the Form to target step. This can be call on-same-page, or redirection between pages
            // @param stepToChangeTo: is StepInfo object
            function navigateToStep(stepToChange, workingFormInfo) {
                if (stepToChange) {

                    _utilsSvc.raiseFormsEvent(workingFormInfo, { type: 'formsNavigateToStep', targetStep: stepToChange });

                    // binding the elements with stored input value between Next/Prev navigation. This section must be here, because onload of a page, we call this function in navigationInit()
                    var formData = _dataSvc.loadCurrentFormDataFromStorage(workingFormInfo.$workingForm);
                    _rebindElementWithFormStorageData(formData, workingFormInfo.$workingForm);

                    // don't redirect if steps have same attached Url (multi-step but on same page)
                    if (workingFormInfo.StepsInfo.AllStepsAreNotLinked
                        || stepToChange.attachedContentLink == epi.EPiServer.CurrentPageLink) {
                        // this is same page navigation

                        workingFormInfo.$steps.addClass("hide");  // hide all step panel first

                        workingFormInfo.$steps.each(function (index, eStep) {
                            if (index === stepToChange.index) {
                                // only show step intended to display in this page
                                $(eStep).removeClass("hide");

                                _utilsSvc.setCurrentStepIndex(workingFormInfo, stepToChange.index);
                                return false;   // break the loop
                            }
                        });
                    }
                    else {
                        // this is different page navigation makes request to the FormContainerBlockController which requires the current FormGuid and expected stepIndex

                        if (stepToChange.attachedUrl && stepToChange.attachedUrl.length) {
                            // redirect to desire step's page, include the formGuid and stepIndex so that the server side know which step 
                            // (e.g. 2 steps have different dependent condition but have same attached page) to display.                            
                            var hasQM = (/\?/).test(stepToChange.attachedUrl);  // simple check for any ? (in case the site not using friendlyURL) before adding step index query
                            var targetUrl = stepToChange.attachedUrl + (hasQM ? "&" : "?") + "__FormGuid=" + workingFormInfo.Id + "&__FormCurrentStepIndex=" + stepToChange.index;
                            window.location.replace(targetUrl);   // replace() does not put the originating page in the session history
                            return; // end function immediately
                        }
                        else {
                            if (workingFormInfo.StepsInfo.AllStepsAreNotLinked) {
                            }
                            else {
                                showFormMessage(workingFormInfo, epi.EPiServer.Forms.Messages.viewMode.malformStepConfiguration);
                            }
                        }
                    }
                }
                else {
                    workingFormInfo.$steps.hide();  // hide all step panel first
                }

                _navigationBarUpdate(workingFormInfo);

            };

            // Find captcha element in $container and refresh
            function _refereshCaptchaElement($container) {
                epi.EPiServer.Forms.Validators["EPiServer.Forms.Implementation.Validation.CaptchaValidator"].refreshCaptcha($(".FormCaptcha__Input", $container));
            }

            // Navigation Bar processing, disable/enable button, show navigation indicator
            function _navigationBarUpdate(workingFormInfo) {
                var currentStepIndex = _utilsSvc.getCurrentStepIndex(workingFormInfo);

                var $navbar = $('.Form__NavigationBar', workingFormInfo.$workingForm);

                // hidden Next/Prev buttons if no step matchs
                if (currentStepIndex < 0) {
                    $navbar.hide();
                    return;
                }

                // show Next and Previous button first
                var $btnPrev = $(".Form__NavigationBar__Action.btnPrev", $navbar).prop("disabled", false);
                var $btnNext = $(".Form__NavigationBar__Action.btnNext", $navbar).prop("disabled", false);
                // update/disable nav buttons usable status
                if (currentStepIndex == 0 || workingFormInfo.SubmittableStatus.submittable === false) {
                    $btnPrev.prop("disabled", true);
                }

                if (currentStepIndex == workingFormInfo.StepsInfo.Steps.length - 1 || workingFormInfo.SubmittableStatus.submittable === false) {
                    $btnNext.prop("disabled", true);
                }


                // update the navigation bar
                $(".Form__NavigationBar", workingFormInfo.$workingForm).toggle(workingFormInfo.ShowNavigationBar);
                var currentDisplayStepIndex = currentStepIndex + 1; // one-base index
                var currentDisplayStepCount = workingFormInfo.StepsInfo.Steps.length;
                $(".Form__NavigationBar__ProgressBar__CurrentStep", $navbar).text(currentDisplayStepIndex);
                $(".Form__NavigationBar__ProgressBar__StepsCount", $navbar).text(currentDisplayStepCount);
                $(".Form__NavigationBar__ProgressBar--Progress", $navbar).css({ width: 100 * currentDisplayStepIndex / currentDisplayStepCount + "%" });
            }

            function _findNextStep(currentIndex, workingFormInfo) {
                // summary:
                //      rescusive finding next step to display in form.
                // currentIndex: [Integer]
                //      Current index for searching step.
                // tags:
                //      private

                var satisfyStep = null;

                // get next step to check
                var nextStepIndex = currentIndex + 1;
                var step = workingFormInfo.StepsInfo.Steps[nextStepIndex];
                if (step) {
                    // is nextStep OK with dependCondition?
                    if (epi.EPiServer.Forms.Extension.isStepSatisfyDependentCondition(step, workingFormInfo)) {
                        satisfyStep = step;
                    }
                    else {
                        satisfyStep = _findNextStep(nextStepIndex, workingFormInfo);
                    }
                }

                return satisfyStep;
            }

            function _findPreviousStep(currentIndex, workingFormInfo) {
                // summary:
                //      Find previous step to display in form.
                // currentIndex: [Integer]
                //      Current index for searching step.
                // tags:
                //      private

                var satisfyStep = null;
                // get prev step to check
                var prevStepIndex = currentIndex - 1;
                var step = workingFormInfo.StepsInfo.Steps[prevStepIndex];
                if (step) {
                    // is prevStep OK with dependCondition?
                    if (epi.EPiServer.Forms.Extension.isStepSatisfyDependentCondition(step, workingFormInfo)) {
                        satisfyStep = step;
                    }
                    else {
                        satisfyStep = _findPreviousStep(prevStepIndex, workingFormInfo);
                    }
                }

                return satisfyStep;
            }

            // return the DOM object of current Step bases on CurrentStepIndex
            function _getCurrentStepDOM(workingFormInfo) {
                var currentIndex = _utilsSvc.getCurrentStepIndex(workingFormInfo);

                // Note that the currrent Step is normally active and visible, is there any case it is hidden???
                return $(workingFormInfo.$steps[currentIndex]);
            }

            /// HACK: THIS IS FOR IE only: 
            /// "form reset" default behaviour does not clear the property "el.files" (even the "el.value" is cleared). 
            /// So we need to explicitly clear it.
            function _hack_clearFileInput($el) {
                if (/MSIE/.test(navigator.userAgent)) {
                    $el.replaceWith($el = $el.clone(true));   // seem to work better, but not really good, because we might lost events bound to this element

                    // http://jsfiddle.net/uzbqyL8j/9/
                    // http://webtips.krajee.com/clear-html-file-input-value-ie-using-javascript/
                    //safer, but does not work on IE10
                    //$el.val('');
                    //$el.wrap('<form>').closest('form').get(0).reset();
                    //$el.unwrap();
                    //console.log("val=", $el.val(), "   files.length=", $el.get(0).files.length);
                }
            }
        });

    };   // end init()



    /// load jquery as fundemental util library. Load external script on demand
    /// =============================================

    /// call init()
    if (epi.EPiServer.Forms.ExternalScriptSources.length <= 0 && epi.EPiServer.Forms.ExternalCssSources.length <= 0) {
        epi.EPiServer.Forms.init(); // init() once
    }
    else {
        // load external scripts
        _utilsSvc.loadExternalScriptOnDemand(epi.EPiServer.Forms.ExternalScriptSources, function () {
            _utilsSvc.raiseFormsEvent(null, { type: 'formsLoadExternalScripts', scripts: epi.EPiServer.Forms.ExternalScriptSources });
            // init() after we load all external scripts
            epi.EPiServer.Forms.init(); // init() once
        });

        // load external css
        _utilsSvc.loadExternalCssOnDemand(epi.EPiServer.Forms.ExternalCssSources, function () {
            _utilsSvc.raiseFormsEvent(null, { type: 'formsLoadExternalCss', Css: epi.EPiServer.Forms.ExternalCssSources });
        });
    }

})($$epiforms || $);  // use the Forms's jQuery before using site's jQuery
