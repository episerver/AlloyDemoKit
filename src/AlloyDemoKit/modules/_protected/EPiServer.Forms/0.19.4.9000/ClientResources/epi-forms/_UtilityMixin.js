define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/Deferred',
    'dojo/when',
// epi
    'epi/string'
],
function (
// dojo
    declare,
    lang,

    Deferred,
    when,
// epi
    epiString
) {

    // module:
    //      epi-forms/_UtilityMixin
    // summary:
    //      
    // tags:
    //      protected

    return declare([], {

        getInstanceFromType: function (/*String*/type, /*Object*/typeParams) {
            // summary:
            //      Get an instance of object from its type string.
            // type: [String]
            //      Object type.
            // typeParams: [Object]
            //      Initialize params used to create this instance.
            // returns: [Object]
            //      An instance of 'dojo/Deferred'
            // tags:
            //      public

            var deferred = new Deferred();

            if (!type) {
                deferred.resolve(null);

                return deferred;
            }

            require([epiString.slashName(type)], lang.hitch(this, function (typeClass) {

                !typeParams && (typeParams = {});

                deferred.resolve(new typeClass(typeParams));

            }));

            return deferred;
        }

    });

});