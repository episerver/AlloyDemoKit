define([
// dojo
    'dojo/date/locale',
// epi
    'epi/datetime',
    'epi/shell/dgrid/Formatter',
    'epi/shell/dgrid/util/misc'
],
function (
// dojo
    locale,
// epi
    epiDateTime,
    Formatter,
    GridMiscUtil
) {

    // module:
    //      epi-forms/dgrid/Formatters
    // summary:
    //      Register custom formatters to dgrid that used in EPiServer Forms addon.
    //      Formatters:
    //          richTextTemplate
    //          dateTimeFormatter
    //          embededLinksFormatter
    //          encodeAndEllipsisFormatter
    //          removeNullValueFormatter
    // tags:
    //      public

    var module = {

        richTextTemplate: function (/*Object*/value) {
            // summary:
            //      Message template formatter.
            //      Enable HTML content display in dgrid.
            // value: [Object]
            //      Text that desired to show as HTML content.
            // tags:
            //      public

            return value;
        },

        dateTimeFormatter: function (/*Object*/value) {
            // summary:
            //      Returns formate of DateTime as "yyyy-MM-dd HH:mm:ss".
            // tags:
            //      public

            return locale.format(epiDateTime.deserialize(value), { datePattern: 'yyyy-MM-dd', timePattern: 'HH:mm:ss' });
        },

        embededLinksFormatter: function (/*Object*/value) {
            // summary:
            //      Returns clickable links from upploaded file urls
            // tags:
            //      public

            var emptyResult = '';

            if (!value) {
                return emptyResult;
            }

            var relativePaths = value.split('|');
            if (relativePaths.length < 1) {
                return emptyResult;
            }

            var links = [];
            relativePaths.forEach(function (item) {
                var fileUrl = item.trim();
                if (!fileUrl) {
                    return emptyResult;
                }

                var indexSharp = fileUrl.indexOf('#@'),
                    namePart = fileUrl.substr((~-indexSharp >>> 0) + 3);  // replace "+ 3" with "+ 1" to include the #@
                if (namePart) {
                    fileUrl = fileUrl.slice(0, indexSharp);
                } else {
                    namePart = fileUrl.substr((~-fileUrl.lastIndexOf('/') >>> 0) + 2);  // replace "+ 2" with "+ 1" to include the /
                }

                if (namePart) {
                    links.push('<a class="epi-fileUpload" target="_blank" href="' + fileUrl + '">' + GridMiscUtil.htmlEncode(namePart) + '</a>');
                }
            });

            return links.join(', ');
        },

        encodeAndEllipsisFormatter: function (/*Object*/value) {
            // summary:
            //      Returns encode and ellipsis of input value.
            // tags:
            //      public

            return GridMiscUtil.ellipsis(GridMiscUtil.htmlEncode(value));
        },

        removeNullValueFormatter: function (/*Object*/value) {
            // summary:
            //      Returns empty string instead of null to display on grid.
            // tags:
            //      public

            return value == null ? '' : value;
        }

    };

    Formatter.addFormatter('richTextTemplate', module.richTextTemplate);
    Formatter.addFormatter('dateTimeFormatter', module.dateTimeFormatter);
    Formatter.addFormatter('embededLinksFormatter', module.embededLinksFormatter);
    Formatter.addFormatter('encodeAndEllipsisFormatter', module.encodeAndEllipsisFormatter);
    Formatter.addFormatter('removeNullValueFormatter', module.removeNullValueFormatter);

    return module;

});