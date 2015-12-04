/* 
This EPiServerForms_prerequisite.js TEMPLATE will be compiled with serverside values and injected into ViewMode page
We reuse the existed global var epi from EPiServer CMS, if any. It will init/grab the epi object, and init epi.EPiServer.Forms object
*/

// Forms's jQuery will be injected right before this file. From now on, we refer our own jQuery as $$epiforms.
// after this code, the $ will revert back to its meaning in original library (Alloy jQuery or other lib).
var $$epiforms = jQuery.noConflict();
var epi = epi || {};
(function () {
    var e = epi.EPiServer = epi.EPiServer || {};
    e.PublicModulePath = '___PublicModulePath___';
    e.CurrentPageLink= ___CurrentPageLink___;
    e.CurrentPageLanguage= '___CurrentPageLanguage___';
    e.Forms = e.Forms || {
        $: $$epiforms,  // save our own link to our own jQuery
        ThrottleTimeout: 500,  // miliseconds
        ExternalScriptSources: ___ExternalScriptSources___,
        FormsCssUrl: '___FormsCssUrl___',
        ExtensionBlackList: '___ExtensionBlackList___',
        Messages: ___Messages___
    };
})();


