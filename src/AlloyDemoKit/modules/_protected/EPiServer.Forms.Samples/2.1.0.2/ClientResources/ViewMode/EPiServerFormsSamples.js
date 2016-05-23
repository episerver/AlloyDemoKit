(function ($) {
    $.extend(true, epi.EPiServer.Forms, {
        // this dateFormats is for using in Samples only
        Samples: {
            // pickerFormat will be used for jQuery datepicker validation,
            // while friendlyFormat will show in validation message for user.
            DateFormats: {
                "en-US": {
                    "pickerFormat": "mm/dd/yy",
                    "friendlyFormat": "MM/dd/yyyy"
                },
                "sv-SE": {
                    "pickerFormat": "yy-mm-dd",
                    "friendlyFormat": "yyyy-MM-dd"
                },
                "nb-NO": {
                    "pickerFormat": "dd.mm.yy",
                    "friendlyFormat": "dd.MM.yyyy"
                },
                "da-DK": {
                    "pickerFormat": "dd-mm-yy",
                    "friendlyFormat": "dd-MM-yyyy"
                },
                "de-DE": {
                    "pickerFormat": "dd.mm.yy",
                    "friendlyFormat": "dd.MM.yyyy"
                },
                "nl-NL": {
                    "pickerFormat": "d-m-yy",
                    "friendlyFormat": "d-M-yyyy"
                },
                "fi-FI": {
                    "pickerFormat": "d.m.yy",
                    "friendlyFormat": "d.M.yyyy"
                },

                "fr-FR": {
                    "pickerFormat": "dd/mm/yy",
                    "friendlyFormat": "dd/MM/yyyy"
                }
            }
        }
    });

    var _utilsSvc = epi.EPiServer.Forms.Utils,
        originalGetCustomElementValue = epi.EPiServer.Forms.Extension.getCustomElementValue,
        originalBindCustomElementValue = epi.EPiServer.Forms.Extension.bindCustomElementValue,
        dateTimePickerTypes = {
            datePicker: "datepicker",
            timePicker: "timepicker",
            dateTimePicker: "datetimepicker"
        },

        language = navigator.language || navigator.userLanguage,
        dateFormatSettings = epi.EPiServer.Forms.Samples.DateFormats[language],
        dateFormat = dateFormatSettings ? dateFormatSettings.pickerFormat : $.datetimepicker._defaults.dateFormat,


        dateTimeValidate = function (fieldName, fieldValue, validatorMetaData) {
            // this function is used to validate visitor's data value in ViewMode

            // the fieldValue return by get getCustomElementValue already contains validate information,
            // just check fieldValue.isValid and return along with error message

            if (typeof fieldValue === 'object' && fieldValue.isValid == false) {

                var friendlyFormat = dateFormatSettings ? dateFormatSettings.friendlyFormat : $.datetimepicker._defaults.dateFormat,
                    message = _utilsSvc.stringFormat(validatorMetaData.model.message, [friendlyFormat])

                return { isValid: false, message: message };
            }

            return { isValid: true };
        };


    // extend the EpiForm JavaScript API in ViewMode
    $.extend(true, epi.EPiServer.Forms, {
        /// extend the Validator to validate Visitor's value in Clientside.
        /// Serverside's Fullname of the Validator instance is used as object key (Case-sensitve) to lookup the Clientside validate function.        
        Validators: {
            "EPiServer.Forms.Samples.Implementation.Validation.DateTimeValidator": dateTimeValidate,
            "EPiServer.Forms.Samples.Implementation.Validation.DateValidator": dateTimeValidate,
            "EPiServer.Forms.Samples.Implementation.Validation.TimeValidator": dateTimeValidate,
            "EPiServer.Forms.Samples.Implementation.Validation.RecaptchaValidator": function (fieldName, fieldValue, validatorMetaData) {
                // validate recaptcha element
                if (fieldValue) {
                    return { isValid: true };
                }

                return { isValid: false, message: validatorMetaData.model.message };
            }
        },

        /// BETA
        /// value store in localStorage and value displaying for Visitor can be different. This function return the value for display to Visitor.
        CustomBindingElements: {
            "EPiServer.Forms.Samples.Implementation.Elements.DateTimeElementBlock": function (elementInfo, val) {

                if (!val || $.type(val) != "string") {
                    return;
                }

                var picker = { settings: { dateFormat: dateFormat } },
                    dateTimeSegments = val.split(" "),
                    dateSegments = dateTimeSegments[0].split("-"),
                    timeString = dateTimeSegments[1] + " " + dateTimeSegments[2],
                    dateString = $.datetimepicker._formatDate(picker, dateSegments[2], +dateSegments[1] - 1, dateSegments[0]);

                switch (elementInfo.pickerType) {
                    case dateTimePickerTypes.datePicker:
                        return dateString;
                    case dateTimePickerTypes.dateTimePicker:
                        return dateString + " " + timeString;
                    case dateTimePickerTypes.timePicker:
                        return timeString;
                }
            }
        },

        Extension: {

            // OVERRIDE, this function to show jQuery Dialog as Summarized Dialog before submission
            showSummarizedText: function (data, workingFormInfo, ignoreFields, shouldBeHiddenKeys) {
                // workingFormInfo.ElementsInfo: contains friendlyName for each field code
                // ignoreFields: are (System) fields should be ignored
                // shouldBeHiddenKeys: are fields which should not be shown (hidden field, tracking code, ...)
                // to determine field should be display or not, check $("[name=" + key + "]", workingFormInfo.$workingForm).hasClass("FormHideInSummarized"))

                var $deferred = $.Deferred(),
                    summarizedText = this.getSummarizedText(workingFormInfo, data, true);
                // empty text, no need to show the confirm box
                if (!summarizedText || summarizedText.trim() === "") {
                    $deferred.resolve(true);

                    return $deferred.promise();
                }

                var confirmationResources = epi.EPiServer.Forms.LocalizedResources.samples.confirmationdialog;

                $("<div class=\"Form__ConfirmationDialog\"></div>").html(summarizedText).appendTo(workingFormInfo.$workingForm);

                $(".Form__ConfirmationDialog", workingFormInfo.$workingForm).dialog({
                    title: confirmationResources.title,
                    resizable: false,
                    modal: true,
                    buttons: [
                        {
                            text: confirmationResources.buttons.ok,
                            click: function () {
                                $(this).dialog("close");
                                $deferred.resolve(true);
                            }
                        },
                        {
                            text: confirmationResources.buttons.cancel,
                            click: function () {
                                $(this).dialog("close");
                                $deferred.resolve(false);
                            }
                        }
                    ]
                });

                return $deferred.promise();
            },

            // OVERRIDE, process to get value from datetime picker element
            getCustomElementValue: function ($element) {

                // for datetime picker we always return result in format "2015-12-25 10:30 AM",
                // and depend on picker type (date/time/datetime) we will parse its value later.
                if ($element.hasClass("FormDateTime")) {
                    var $input = $('.FormDateTime__Input', $element),
                        dateTimeString = $.trim($input.val()),
                        picker = $.datetimepicker._getInst($input[0]),
                        timeRegex = "^(0?[1-9]|1[012])(:[0-5]\\d) [APap][mM]$";

                    if (!dateTimeString) {
                        return dateTimeString;
                    }

                    switch (picker.settings.type) {

                        case dateTimePickerTypes.datePicker:
                        case dateTimePickerTypes.dateTimePicker:
                            var dateTime;
                            try {
                                // try to parse date with format
                                dateTime = $.datetimepicker.parseDate(picker.settings.dateFormat, dateTimeString);
                            } catch (err) {
                                return { isValid: false };
                            }
                            var result = _utilsSvc.stringFormat("{0}-{1}-{2}", [dateTime.getFullYear(), dateTime.getMonth() + 1, dateTime.getDate()]);
                            if (picker.settings.type == dateTimePickerTypes.dateTimePicker) {
                                var dateTimeSegments = dateTimeString.split(" ");

                                if (dateTimeSegments.length < 3) {
                                    return { isValid: false };
                                }

                                var timeString = dateTimeSegments[1] + " " + dateTimeSegments[2];
                                if (!_utilsSvc.isMatchedReg(timeString, timeRegex)) {
                                    return { isValid: false };
                                }

                                result += " " + timeString;
                            } else {
                                result += " 12:00 AM"; // add fake time string into return results, this will be ignored when rebind data
                            }
                            return result;

                        case dateTimePickerTypes.timePicker:
                            if (!_utilsSvc.isMatchedReg(dateTimeString, timeRegex)) {
                                return { isValid: false };
                            }
                            return "1900-1-1 " + dateTimeString; // add fake date string into return results, this will be ignored when rebind data
                    }

                    return datetime;
                } else if ($element.hasClass("FormRecaptcha")) {
                    // for recaptcha element
                    var widgetId = $element.data("epiforms-recaptcha-widgetid");
                    if (widgetId != undefined && grecaptcha) {
                        return grecaptcha.getResponse(widgetId);
                    } else {
                        return null;
                    }
                }

                // if current element is not our job, let others process
                return originalGetCustomElementValue.apply(this, [$element]);
            },

            // OVERRIDE, custom binding data for date/time/datetime picker
            bindCustomElementValue: function ($element, val) {
                var $item = $element.find(".Form__CustomInput");
                if ($item.hasClass("FormDateTime__Input")) {

                    var picker = $.datetimepicker._getInst($item[0]),
                        bindingValue = epi.EPiServer.Forms.CustomBindingElements["EPiServer.Forms.Samples.Implementation.Elements.DateTimeElementBlock"]({ pickerType: picker.settings.type }, val);
                    $item.val(bindingValue);

                    return;
                }
                // if current element is not our job, let others process
                return originalBindCustomElementValue.apply(this, [$item, val]);
            }
        }
    });

    
    // init all DateTimeFormElement on the ViewMode with our modified jQuery DatePicker
    if (typeof __SamplesDateTimeElements != "undefined") {
        $.each(__SamplesDateTimeElements || [], function (i, dateTimeElementInfo) {
            $("#" + dateTimeElementInfo.guid).datetimepicker({
                type: dateTimeElementInfo.pickerType,
                constrainInput: false,
                dateFormat: dateFormat
            });
        });
    }
    
    // reset reCAPTCH elements in target form
    function resetRecaptchaElements(target) {

        var reCaptchaElements = $(".FormRecaptcha", target);
        $.each(reCaptchaElements, function (index, element) {
            var widgetId = $(element).data("epiforms-recaptcha-widgetid");
            if (widgetId != undefined && grecaptcha) {
                grecaptcha.reset(widgetId);
            }
        });
    };

    $(".EPiServerForms").on("formsReset formsNavigationPrevStep", function(event) {
        resetRecaptchaElements(event.target);
    });

    $(".EPiServerForms").on("formsStepValidating", function (event) {
        if (event.isValid == true) {
            return;
        }
        // reset reCAPTCHA element if validation failed
        resetRecaptchaElements(event.target);
    });


})($$epiforms || $);


function initRecaptchaElements() {
    (function ($) {

        //This is the callback function executed after Google authenticates recaptcha values.
        function onVerify($element) {
            return function () {
                return function (response) {
                    if (!response || response.length == 0) {
                        return;
                    };

                    $element.find(".Form__Element__ValidationError").hide();
                }
            }($element);
        };

        $(".Form__Element.FormRecaptcha").each(function (index, element) {
            var $element = $(element),
                $widgetContainer = $(".g-recaptcha", $element),
                siteKey = $element.data("epiforms-sitekey");

            if ($widgetContainer.length == 1 && siteKey) {
                var widgetId = grecaptcha.render($widgetContainer[0], { sitekey: siteKey, callback: onVerify($element) });
                $element.data("epiforms-recaptcha-widgetid", widgetId);
            }
        });

    })($$epiforms || $);
}