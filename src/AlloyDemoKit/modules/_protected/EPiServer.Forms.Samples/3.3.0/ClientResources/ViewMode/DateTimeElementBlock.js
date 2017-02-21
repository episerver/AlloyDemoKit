(function ($) {
    var _utilsSvc = epi.EPiServer.Forms.Utils,
        language = navigator.language || navigator.userLanguage,
        dateFormatSettings = epi.EPiServer.Forms.Samples.DateFormats[language],
        dateFormat = dateFormatSettings ? dateFormatSettings.pickerFormat : $.datetimepicker._defaults.dateFormat;

    // init all DateTimeFormElement on the ViewMode with our modified jQuery DatePicker
    if (typeof __SamplesDateTimeElements != "undefined") {
        $.each(__SamplesDateTimeElements || [], function (i, dateTimeElementInfo) {
            $("#" + dateTimeElementInfo.guid).datetimepicker({
                type: dateTimeElementInfo.pickerType,
                constrainInput: false,
                dateFormat: dateFormat
            });
        });

        $('.EPiServerForms .Form__CustomInput.FormDateTime__Input, .EPiServerForms .Form__CustomInput.FormDateTimeRange__End, .EPiServerForms .Form__CustomInput.FormDateTimeRange__Start').on('keydown', function _onKeyDown(e) {
            return _utilsSvc.showNextStepOnEnterKeyDown(e);
        });
    }

})($$epiforms || $);