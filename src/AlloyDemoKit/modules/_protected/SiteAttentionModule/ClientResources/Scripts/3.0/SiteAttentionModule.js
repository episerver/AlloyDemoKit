/**
 * This is the SiteAttention CMS library that can be used by the developer
 * integrating SiteAttention into their CMS or website.
 *
 * @class      SiteAttentionModule Library
 *
 * Author      Marius Jigoreanu    2017-02-16 17:20:42
 *
 * Copyright   SiteAttention       2017
 */

let SiteAttentionModule = function () {
    /**
     * This is the private store of data for this module. This WeakMap is only
     * available for this scope/ encapsulation.
     *
     * @type       {WeakMap}
     */

    const store = new WeakMap();




    /**
     * This function creates the {Object} containing the SEO fields that will be
     * later passed to SiteAttention.load().
     *
     * @class      FieldFactory Creator
     * @param      {Array}   fields  The fields present on the page. Each object
     *                               in the array will be used to create a new
     *                               instance of the class FieldAbstract.
     * @return     {Object}  An object containing the FieldAbstract concrete
     *                       classe implementations for all present SEO fields.
     */

    const FieldFactory = function (map) {
        const fields = {};


        /**
        * This method returns a class representing a Field class that
        * implements FieldAbstract. If no class with the specified name exists
        * then FieldInput class is returned.
        *
        * @param      {String}         type    The type of the HTML field.
        * @return     {FieldAbstract}  The constructor of a class that
        *                              implements FieldAbstract.
        */

        const get_class = function (type) {
            switch (type) {
                case 'FieldInput':
                    return FieldInput;
                case 'FieldTinyMCE3':
                    return FieldTinyMCE3;
                case 'FieldTinyMCE4':
                    return FieldTinyMCE4;
                case 'FieldCKEditor1':
                    return FieldCKEditor1;
                case 'FieldFCKEditor2':
                    return FieldFCKEditor2;
                case 'FieldEPiServerWrapper':
                    return FieldEPiServerWrapper;
                default:
                    return FieldInput;
            }
        }

        for (const field of map) {
            const FieldClass = get_class(field.type);

            // One FieldWrapper per SEO field type
            if (!fields.hasOwnProperty(field.seo)) {
                fields[field.seo] = new FieldWrapper(field.seo);
            }

            fields[field.seo].add(new FieldClass(field));
        }

        return fields;
    };




    /**
     * This abstract class is the base for every single HTML representation of a
     * SEO field. The constructor of this class can only be used as an exaxmple
     * for the concrete implementations.
     *
     * The prototype of this function defines the public methods of the
     * FieldAbstract superclass. Every concrete implementation of a SEO field
     * type class will inherit these methods.
     *
     * @class      FieldAbstract HTML field type
     * @param      {Object}  field   This object contains {seo , name , type}.
     * @return     {FieldAbstract}  The constructor of this class.
     */

    const FieldAbstract = function () {
        function FieldAbstract(field) {
            /**
             * Save the local store to the private store for later access
             */
            const local = { this: this };
            store.set(this, local);


            /**
             * Private variables used for accessing the HTML element
             */

            local.selector = field.selector;                                // CSS selector for accessing the HTML element
            local.element = undefined;                                     // The HTML element (i.e. input, div, etc.)
            local.object = undefined;                                     // Can be the JS object (e.g. tinyMCE) or HTML element
            local.container = undefined;                                     // HTML object that will be highlighter
            local.overlay = undefined;                                     // tinyMCE require overlay to highlight


            /**
             * Private variables used by SiteAttention
             */

            local.seo = field.seo;                                     // The SEO fielt type (i.e. title, url, links, etc.)
            local.name = field.name;                                    // Human readable name (i.e. Title, Teaser, Main Content, etc.)
            local.type = field.type;                                    // The FieldAbstract concrete implementation class name (e.g. FieldInput)
            local.bit = undefined;                                     // The SiteAttention defined bit flag for matching rules
            local.text = undefined;                                     // The text content of the HTML field
            local.html = undefined;                                     // The HTML content of the HTML field
            local.update_to = undefined;                                     // The privately used timeout ID for running update


            /**
             * Protected* overridable methods, called internally
             */

            local.bind = function () { throw 'exception: virtual method \'bind\' not implemented.' };
            local.unbind = function () { throw 'exception: virtual method \'unbind\' not implemented.' };
            local.update = function () { throw 'exception: virtual method \'update\' not implemented.' };
            local.listener = function () { throw 'exception: virtual method \'update\' not implemented.' };

            /**
             * Protected* overridable methods called inside the super class
             */

            local.load = function () { throw 'exception: virtual method \'load\' not implemented.' };
            local.unload = function () { throw 'exception: virtual method \'unload\' not implemented.' };
            local.focus = function () { throw 'exception: virtual method \'focus\' not implemented.' };
            local.highlight = function () { throw 'exception: virtual method \'highlight\' not implemented.' };


            /**
             * Don't forget to return local as there is no way to pass a
             * reference to the using class.
             */

            return local;
        }

        FieldAbstract.prototype = function () {
            let update_cb = undefined,
                update_dl = undefined;

            const update_timer = function () {
                const self = this;
                const local = store.get(this);

                clearTimeout(local.update_to);

                local.update_to = setTimeout
                    (
                    function () {
                        update.call(self);

                    }, update_dl
                    );
            }

            const update = function (no_cb) {
                const local = store.get(this);

                local.update();

                if (!no_cb) {
                    update_cb(local.seo);
                }
            }

            const find = function () {
                const local = store.get(this);

                local.selector = local.selector.split('|');

                let sel = local.selector[0],
                    idx = local.selector[1] || 0;

                local.element = SA.lib.salt(sel)[idx];

                if (local.element === undefined) {

                    return false;
                }

                return true;
            }

            const highlight = function () {
                const local = store.get(this);

                let self = this,
                    highlighted = local.container;

                if (local.overlay !== undefined) {
                    highlighted.insertBefore(local.overlay, highlighted.firstChild);
                    highlighted = local.overlay;
                }

                setTimeout
                    (
                    function () {
                        if (highlighted.classList)
                            highlighted.classList.add('SiteAttention_heighlight');
                    },
                    0
                    );

                setTimeout
                    (
                    function () {
                        if (highlighted.classList)
                            highlighted.classList.add('SiteAttention_heighlight_no');
                    },
                    1500
                    );

                setTimeout
                    (
                    function () {
                        if (highlighted.classList) {
                            highlighted.classList.remove('SiteAttention_heighlight');
                            highlighted.classList.remove('SiteAttention_heighlight_no');
                        }
                        if (local.overlay !== undefined) {
                            local.container.removeChild(local.overlay);
                        }
                    },
                    2000
                    );
            }

            const load = function () {
                const local = store.get(this);

                local.load();
            }

            const unload = function () {
                const local = store.get(this);

                local.unload();
            }

            const focus = function () {
                const local = store.get(this);

                local.focus();
                highlight.call(this);
            }

            const set = function (data) {
                const local = store.get(this);

                local.bit = data.bit || local.bit;

                update_cb = data.update_cb || update_cb;
                update_dl = data.update_dl || update_dl;
            }

            const get_text = function () {
                // whitespaces or not? .replace( /(\n|\r)*\s{1,}/g , ' ' )
                const local = store.get(this);

                return local.text;
            }

            const get_html = function () {
                const local = store.get(this);

                return local.html;
            }

            const get_name = function () {
                const local = store.get(this);

                return local.name;
            }

            const get_seo = function () {
                const local = store.get(this);

                return local.seo;
            }

            const get_bit = function () {
                const local = store.get(this);

                return local.bit;
            }

            return {
                constructor: FieldAbstract,
                _update_timer: update_timer,
                _update: update,
                _find: find,
                load: load,
                unload: unload,
                focus: focus,
                set: set,
                get_text: get_text,
                get_html: get_html,
                get_name: get_name,
                get_seo: get_seo,
                get_bit: get_bit
            };
        }();

        return FieldAbstract;
    }();




    /**
     * This wrapper class overrides FieldAbstract. It holds multiple SEO fields
     * of type FieldAbstract. It adds some functionality so two or more of these
     * fields can be used just like you would use a single one.
     *
     * @class      FieldWrapper Wrapper class for SEO Fields
     * @param      {String}  seo     The SEO field name (title, url, content, etc.).
     * @param      {Array}   fields  Optionally, the field classes as {Array}.
     * @return     {FieldWrapper}  Returns a new instance of FieldWrapper
     *                             containing one or more SEO fields.
     */

    const FieldWrapper = function () {
        function FieldWrapper(seo, fields) {
            store.set(this,
                {
                    seo: seo,
                    name: [],
                    fields: {}
                });

            if (fields instanceof Array) {
                for (const field of fields) {
                    this.add(field);
                }
            }
        };

        FieldWrapper.prototype = function () {
            const _separator = '\n';

            const add = function (field) {
                const local = store.get(this);

                const name = field.get_name();

                local.name.push(name);

                local.fields[name] = field;
            };

            const load = function () {
                const local = store.get(this);

                for (let field in local.fields) {
                    local.fields[field].load();
                }
            };

            const unload = function () {
                const local = store.get(this);

                for (let field in local.fields) {
                    local.fields[field].unload();
                }
            };

            const focus = function (name) {
                const local = store.get(this);

                local.fields[name].focus();
            };

            const set = function (data) {
                const local = store.get(this);

                local.bit = data.bit || local.bit;

                for (let field in local.fields) {
                    local.fields[field].set(data);
                }
            };

            const get_text = function () {
                const local = store.get(this);

                const text = [];

                for (const field in local.fields) {
                    text.push(local.fields[field].get_text());
                }

                return text.join(_separator);
            }

            const get_html = function () {
                const local = store.get(this);

                let html = [];

                for (let field in local.fields) {
                    html.push(local.fields[field].get_html());
                }

                // if ( this.seo === 'headers' )
                // {
                //     text = text.match ( /<h([1-6])[^>]*>[\s\S]*?<\/h\1>/gi );

                //     if ( text )
                //     {
                //         text = text.join( "\n" );
                //     }

                //     else text = "";
                // }

                return html.join(_separator);
            }

            const get_name = function () {
                const local = store.get(this);

                return local.name;
            }

            const get_seo = function () {
                const local = store.get(this);

                return local.seo;
            }

            const get_bit = function () {
                const local = store.get(this);

                return local.bit;
            }

            return {
                constructor: FieldWrapper,
                add: add,
                load: load,
                unload: unload,
                focus: focus,
                set: set,
                get_text: get_text,
                get_html: get_html,
                get_name: get_name,
                get_seo: get_seo,
                get_bit: get_bit
            }
        }();

        return FieldWrapper;
    }();




    /**
     * The implementation of the FieldAbstract class specific for EPIServer.
     * This acts as a wrapper for functions that they have already prepared.
     * This class inherits FieldAbstract and uses the same parameters for it's
     * constructor.
     *
     * @class      FieldEPiServerWrapper EPIServer field type wrapper
     */

    const FieldEPiServerWrapper = function () {
        function FieldEPiServerWrapper(field) {
            const local = FieldAbstract.call(this, field);
            const selector = field.selector;

            local.load = function () {
                if (SiteAttentionEpiServerWatcher) {
                    if (SiteAttentionEpiServerWatcher.hasField(selector)) {
                        local.this._update(true);
                        local.bind();
                        local.element = {};
                        local.object = {};
                        local.container = {};

                        return true;
                    }
                }

                return false;
            }


            local.listener = function () {
                // We need a ref to this FieldInput
                local.this._update_timer.call(local.this);
            }

            local.bind = function () {
                if (SiteAttentionEpiServerWatcher) {
                    SiteAttentionEpiServerWatcher.register(selector, local.listener);
                }
            }

            local.update = function () {
                if (SiteAttentionEpiServerWatcher) {
                    local.text = SiteAttentionEpiServerWatcher.getValue(selector);
                    local.html = SiteAttentionEpiServerWatcher.getHtmlValue(selector);
                }
            }

            local.unload = function () {
                local.unbind();
            }

            local.unbind = function () {
                if (SiteAttentionEpiServerWatcher) {
                    SiteAttentionEpiServerWatcher.unregister(selector);
                }
            }

            local.focus = function () {
                if (SiteAttentionEpiServerWatcher) {
                    SiteAttentionEpiServerWatcher.focus(selector);
                }
            }
        }

        FieldEPiServerWrapper.prototype = FieldAbstract.prototype;

        FieldEPiServerWrapper.prototype.constructor = FieldEPiServerWrapper;

        return FieldEPiServerWrapper;
    }();




    /**
     * The implementation of the FieldAbstract class specific for HTML input and
     * textarea. This class inherits FieldAbstract and uses the same parameters
     * for it's constructor.
     *
     * @class      FieldInput HTML field type
     */

    const FieldInput = function () {
        function FieldInput(field) {
            const local = FieldAbstract.call(this, field);

            local.load = function () {
                if (!local.this._find()) {
                    return false;
                }

                local.this._update(true);
                local.bind();

                local.object = local.element;
                local.container = local.element;

                return true;
            }

            local.bind = function () {
                local.element.addEventListener('keyup', local.listener);
            }

            local.listener = function () {
                // We need a ref to this FieldInput
                local.this._update_timer.call(local.this);
            }

            local.update = function () {
                local.text = local.element.value;

                local.html = local.element.innerHTML || local.text;
            }

            local.unload = function () {
                local.unbind();
            }

            local.unbind = function () {
                local.element.removeEventListener('keyup', local.listener);
            }

            local.focus = function () {
                local.container.focus();
            }
        }

        FieldInput.prototype = FieldAbstract.prototype;

        FieldInput.prototype.constructor = FieldInput;

        return FieldInput;
    }();




    /**
     * The implementation of the FieldAbstract class specific for tinyMCE of versions 3.x.
     * This class inherits FieldAbstract and uses the same parameters for it's
     * constructor.
     *
     * @class      FieldTinyMCE3 HTML field type
     */

    const FieldTinyMCE3 = function (field) {
        let FieldTinyMCE3 = function (field) {
            const local = FieldAbstract.call(this, field);

            local.load = function () {
                if (!local.this._find()) {
                    return false;
                }

                const editor = tinyMCE.get(local.element.id),

                    init = function () {
                        local.container = local.object.getContentAreaContainer();

                        local.overlay = document.createElement('div');
                        local.overlay.id = 'SiteAttention_highlight_overlay';
                        local.overlay.style.position = 'absolute';
                        local.overlay.style.zIndex = '1';
                        local.overlay.style.pointerEvents = 'none';

                        local.this._update(true);
                        local.bind();
                    };

                // TinyMCE has been found, so init()
                if (editor instanceof tinyMCE.Editor) {
                    local.object = editor;

                    init();
                }

                // TinyMCE not yet found, so init() when loaded
                tinyMCE.onAddEditor.add(function (mgr, ed) {
                    if (ed.id === local.element.id) {
                        ed.onInit.add(function (ed) {
                            local.object = ed;

                            init();
                        });
                    }
                });

                return true;
            };

            local.bind = function () {
                // Fires when a key is released within the the editor.
                //local.object.getDoc().addEventListener( 'keyup', local.listener );

                // Fires when a key is released within the the editor.
                local.object.onKeyUp.add(local.listener);

                // Fires when undo level is added to the editor.
                local.object.onChange.add(local.listener);
            };

            local.listener = function () {
                // We need a ref to this FieldTinyMCE3
                local.this._update_timer.call(local.this);
            }

            local.update = function () {
                local.text = local.object.getBody().textContent;

                //local.html = local.object.getBody().innerHTML;
                local.html = local.object.getContent({ format: 'html' });
            };

            local.unload = function () {
                local.unbind();
            };

            local.unbind = function () {
                // Fires when a key is released within the the editor.
                // local.object.getDoc().removeEventListener( 'keyup', local.listener );

                // Fired when a key is released within the the editor.
                local.object.onKeyUp.remove(local.listener);

                // Fired when undo level is added to the editor.
                local.object.onChange.remove(local.listener);
            }

            local.focus = function () {
                local.overlay.style.width = local.object.getDoc().documentElement.clientWidth - 7 + 'px';
                local.overlay.style.height = local.object.getDoc().documentElement.clientHeight - 3 + 'px';

                local.object.focus();
            };
        }

        FieldTinyMCE3.prototype = FieldAbstract.prototype;

        FieldTinyMCE3.prototype.constructor = FieldTinyMCE3;

        return FieldTinyMCE3;
    }();




    /**
     * The implementation of the FieldAbstract class specific for tinyMCE of versions 4.x.
     * This class inherits FieldAbstract and uses the same parameters for it's
     * constructor.
     *
     * @class      FieldTinyMCE3 HTML field type
     */

    const FieldTinyMCE4 = function (field) {
        let FieldTinyMCE4 = function (field) {
            const local = FieldAbstract.call(this, field);

            local.load = function () {
                if (!local.this._find()) {
                    return false;
                }
                const editor = tinyMCE.get(local.element.id),

                    init = function () {
                        local.container = local.object.getContentAreaContainer();

                        local.overlay = document.createElement('div');
                        local.overlay.id = 'SiteAttention_highlight_overlay';
                        local.overlay.style.position = 'absolute';
                        local.overlay.style.zIndex = '1';
                        local.overlay.style.pointerEvents = 'none';

                        local.this._update(true);
                        local.bind();
                    }

                // TinyMCE has been found, so init()
                if (editor instanceof tinyMCE.Editor) {
                    local.object = editor;

                    init();
                }

                // TinyMCE not yet found, so init() when loaded
                tinyMCE.on('addeditor', function (e) {
                    if (e.editor.id === local.element.id) {
                        e.editor.on('init', function (e) {
                            local.object = e.editor;

                            init();
                        });
                    }
                });

                return true;
            };

            local.bind = function () {
                // Fires when a key is released within the the editor.
                local.object.on('keyup', local.listener);

                // Fires when undo level is added to the editor.
                local.object.on('change', local.listener);
            };

            local.listener = function () {
                // We need a ref to this FieldTinyMCE4
                local.this._update_timer.call(local.this);
            }

            local.update = function () {
                local.text = local.object.getContent({ format: 'text' });

                local.html = local.object.getContent({ format: 'html' });
            };

            local.unload = function () {
                local.unbind();
            };

            local.unbind = function () {
                // Fired when a key is released within the the editor.
                local.object.off('keyup', local.listener);

                // Fired when undo level is added to the editor.
                local.object.off('change', local.listener);
            }

            local.focus = function () {
                local.overlay.style.width = local.object.getDoc().documentElement.clientWidth - 7 + 'px';
                local.overlay.style.height = local.object.getDoc().documentElement.clientHeight - 3 + 'px';

                local.object.focus();
            };
        }

        FieldTinyMCE4.prototype = FieldAbstract.prototype;

        FieldTinyMCE4.prototype.constructor = FieldTinyMCE4;

        return FieldTinyMCE4;
    }();




    /**
     * The implementation of the FieldAbstract class specific for CKEditor of versions 1.x.
     * This class inherits FieldAbstract and uses the same parameters for it's
     * constructor.
     *
     * @class      FieldCKEditor1 HTML field type
     */

    const FieldCKEditor1 = function (seo, name, selector) {
        var base = new SA.class.Field(field);
        for (key in base) this[key] = base[key];

        this.load = function () {
            if (this.selector.split(",")[1] == undefined) this.win = window;
            else this.win = this.getWindow(this.selector.split(",")[1].split("|"));
            var elementSelector = this.selector.split(",")[0].split("|");
            this.element = $j(elementSelector[0], this.win.document).eq(elementSelector[1]);
            if (!this.element.length) {
                if (window.console && window.console.error) console.error("SiteAttention selector '" + this.selector + "' not found");
                this.remove();
                return;
            }
            this.selectorElement = this.element[0];
            this.timeoutCounter = 0;
            if (this.win.CKEDITOR != undefined &&
                this.win.CKEDITOR.instances[this.selectorElement.id] != undefined &&
                this.win.CKEDITOR.instances[this.selectorElement.id].document != undefined &&
                this.win.CKEDITOR.instances[this.selectorElement.id].getData() != null) this.bindAll();
            else {
                var me = this;
                this.xml = this.selectorElement.value;
                this.text = this.stripXML(this.xml);
                this.timeoutEvaluate();
                this.win.CKEDITOR.on("instanceReady", function (e) {
                    if (e.editor.name == me.selectorElement.id)
                        me.bindAll();
                });


            }
        };

        this.unload = function () {
            base.unload.call(this);
            if (!this.object) return;
            $j(this.object.document.$).unbind("keyup");
        };

        this.bindAll = function () {
            var me = this;
            this.object = this.win.CKEDITOR.instances[this.selectorElement.id];

            if ($j("#cke_contents_" + this.selectorElement.id + " iframe").length) {
                this.container = $j("#cke_contents_" + this.selectorElement.id + " iframe")[0];
            }
            else if ($j("#cke_" + this.selectorElement.id + " iframe").length) { // Newer version of CKeditor only prepends 'cke_'
                this.container = $j("#cke_" + this.selectorElement.id + " iframe")[0];
            }

            this.update();
            this.timeoutEvaluate();
            $j(this.object.document.$).bind("keyup", function () {
                me.timeoutUpdate();
            });
        };

        this.update = function () {
            this.xml = this.object.getData();
            this.text = this.stripXML(this.xml);
            SA.eval.set_bits(this.bit);
        };

        this.getFieldValue = function () {

            return this.object.document.$.body.innerHTML;
        };

        this.setXML = function (data, evaluate) {
            this.object.setData(data);
            this.xml = data;
            this.text = this.stripXML(this.xml);
            SA.eval.set_bits(this.bit);
            if (evaluate || evaluate == null) this.timeoutEvaluate();
        };

        this.focus = function () {

            this.object.focus();
        };
    }




    /**
     * The implementation of the FieldAbstract class specific for FCKEditor of versions 2.x.
     * This class inherits FieldAbstract and uses the same parameters for it's
     * constructor.
     *
     * @class      FieldFCKEditor2 HTML field type
     */

    const FieldFCKEditor2 = function (seo, name, selector) {
        var base = new SA.class.Field(field);
        for (key in base) this[key] = base[key];

        this.load = function () {
            if (this.selector.split(",")[1] == undefined) this.win = window;
            else this.win = this.getWindow(this.selector.split(",")[1].split("|"));
            var elementSelector = this.selector.split(",")[0].split("|");
            this.element = $j(elementSelector[0], this.win.document).eq(elementSelector[1]);
            if (!this.element.length) {
                if (window.console && window.console.error) console.error("SiteAttention selector '" + this.selector + "' not found");
                this.remove();
                return;
            }
            this.selectorElement = this.element[0];
            this.timeoutCounter = 0;

            if (this.win.FCKeditorAPI &&
                this.win.FCKeditorAPI.GetInstance(this.selectorElement.id) &&
                this.win.FCKeditorAPI.GetInstance(this.selectorElement.id).GetXHTML() != null) this.bindAll();
            else {
                var me = this;
                this.xml = this.selectorElement.value;
                this.text = this.stripXML(this.xml);
                this.timeoutEvaluate();
                if (this.win.FCKeditor_OnComplete) {
                    if (!this.win.old_FCKeditor_OnComplete) {
                        this.win.old_FCKeditor_OnComplete = this.win.FCKeditor_OnComplete;
                        this.win.old_FCKeditor_OnComplete.instances = [];
                        this.win.FCKeditor_OnComplete = function (editor) {
                            for (key in me.win.FCKeditor_OnComplete.fields[editor.Name])
                                me.win.FCKeditor_OnComplete.fields[editor.Name][key].bindAll();
                            me.win.FCKeditor_OnComplete.fields[editor.name] = undefined;
                            if (!me.win.old_FCKeditor_OnComplete.instances.join(",").match(new RegExp("(^|,)" + editor.Name + "(,|$)", ""))) {
                                me.win.old_FCKeditor_OnComplete.instances.push(editor.Name);
                                me.win.old_FCKeditor_OnComplete(editor);
                            }
                        };
                        this.win.FCKeditor_OnComplete.fields = [];
                    }
                    if (!this.win.FCKeditor_OnComplete.fields[this.selectorElement.id])
                        this.win.FCKeditor_OnComplete.fields[this.selectorElement.id] = [];
                    this.win.FCKeditor_OnComplete.fields[this.selectorElement.id].push(this);
                }
                else this.win.FCKeditor_OnComplete = function () { me.bindAll(); };
            }
        };

        this.unload = function () {
            base.unload.call(this);
            if (!this.object) return;
            $j(this.object.EditorDocument).unbind("keyup");
        };

        this.bindAll = function () {
            var me = this;
            this.object = this.win.FCKeditorAPI.GetInstance(this.selectorElement.id);
            this.container = this.win.document.getElementById(this.selectorElement.id + "___Frame");
            this.update();
            this.timeoutEvaluate();
            $j(this.object.EditorDocument).bind("keyup", function () {
                me.timeoutUpdate();
            });
        };

        this.update = function () {
            this.xml = this.object.GetXHTML();
            this.text = this.stripXML(this.xml);
            SA.eval.set_bits(this.bit);
        };

        this.getFieldValue = function () {

            return this.object.EditorDocument.body.innerHTML;
        };

        this.setXML = function (data, evaluate) {
            this.object.SetHTML(data);
            this.xml = data;
            this.text = this.stripXML(this.xml);
            SA.eval.set_bits(this.bit);
            if (evaluate || evaluate == null) this.timeoutEvaluate();
        };

        this.focus = function () {

            this.object.Focus();
        };
    }




    /**
     * This class enables the developer to add hooks to the execution of
     * SiteAttention. This class needs to be instantiated. If parameters are
     * provided to the constructor, the default time/ event will be extended
     * or replaced.
     *
     * @class      HookMan Hook Manager
     */

    const HookMan = function () {
        /**
         * SiteAttention default possible values. SiteAttention will only go
         * through these values.
         *
         * @type {Array}
         */

        const time_def =
            [
                'before',
                'after'
            ];




        /**
         * SiteAttention default possible values. SiteAttention will only go
         * through these values.
         *
         * @type {Array}
         */

        const event_def =
            [
                'play',
                'stop',
                'pause',
                'resume',
                'load',
                'publish',
                'register',
                'instance',
                'license',
                'update',
                'minimise',
                'maximise'
            ];




        /**
         * The HookMan constructor defines three optional parameters. If they
         * are provided, they will be concatenated to the default SiteAttention
         * list of event. If reset is true, they will replace the default
         * values.
         *
         * @param {String} time  The possible moments for the hook to run.
         *                       Default possible values: before, after
         * @param {String} event The events that you want the hook to run at.
         *                       Default possible values: play, stop, pause,
         *                       resume,publish, register
         * @param {String} reset If this parameter is true, the defaults are
         *                       being overrden by the provided values
         */

        function HookMan(_time, _event, _reset) {
            let hooks = {},
                time = time_def,
                event = event_def;

            if (_time instanceof Array) {
                time = _reset ? _time : time_def.concat(_time);
            }

            if (_event instanceof Array) {
                event = _reset ? _event : event_def.concat(_event);
            }

            for (const ev of event) {
                hooks[ev] = {};

                for (const ti of time) {
                    hooks[ev][ti] = {};
                }
            }

            store.set(this,
                {
                    hooks: hooks,
                    time: time,
                    event: event
                });
        }




        /**
         * Adds a hook to the private list of hooks
         *
         * @method add
         * @param  {String} time    The time. Should be one of the defaults
         *                          or of the provided values at the
         *                          instantiation
         * @param  {String} event   The event. Should be one of the defaults
         *                          or of the provided values at the
         *                          instantiation
         * @param  {String} name    The name of the function. Should be
         *                          unique per function
         * @param  {Function} action  The method that will be executed
         * @param  {Object} context The context that the method will be
         *                          executed in
         * @param  {Array} args    The arguments that the action param will
         *                         receive.
         */

        function add(time, event, name, action, context, args) {
            const local = store.get(this);

            validate.call(this, time, event);

            local.hooks[event][time][name] =
                {
                    action: action,
                    args: args !== undefined ? args : [],
                    context: context !== undefined ? context : window,
                    suspended: false
                }
        }




        /**
         * Remove the provided hook from the private list
         *
         * @method rem
         * @param  {String} time  The time of the hook
         * @param  {String} event The eventof the hook
         * @param  {String} name  The name of the hook function
         */

        function rem(time, event, name) {
            const local = store.get(this);

            validate.call(this, time, event);

            delete local.hooks[event][time][name];
        }




        /**
         * Run the provided hook
         *
         * @method run
         * @param  {String} time  The time of the events
         * @param  {String} event The event name
         * @param  {Array} args  The extra arguments to be passed to the
         *                       function that will be ran
         */

        function run(time, event, args) {
            const local = store.get(this);

            validate.call(this, time, event);

            args = args ? args : [];

            for (const name in local.hooks[event][time]) {
                const data = local.hooks[event][time][name];

                data.action.apply(data.context, args.concat(data.args));
            }
        }




        /**
         * Resume the provided hook
         *
         * @method run
         * @param  {String} time  The time of the events
         * @param  {String} event The event name
         * @param  {Array} args  The extra arguments to be passed to the
         *                       function that will be ran
         */

        function resume(time, event, name) {
            const local = store.get(this);

            validate.call(this, time, event);

            local.hooks[event][time][name].suspended = false;
        }




        /**
         * Suspend the provided hook
         *
         * @method run
         * @param  {String} time  The time of the events
         * @param  {String} event The event name
         * @param  {Array} args  The extra arguments to be passed to the
         *                       function that will be ran
         */

        function suspend(time, event, name) {
            const local = store.get(this);

            validate.call(this, time, event);

            local.hooks[event][time][name].suspended = true;
        }




        /**
         * Validates the provided hook
         *
         * @method run
         * @param  {String} time  The time of the events
         * @param  {String} event The event name
         * @param  {Array} args  The extra arguments to be passed to the
         *                       function that will be ran
         */

        const validate = function (_time, _event) {
            const local = store.get(this);

            if (local.time.indexOf(_time) === -1) {
                throw 'HookMan exception: time (' + _time + ') is not a supported value';
            }

            if (local.event.indexOf(_event) === -1) {
                throw 'HookMan exception: event (' + _event + ') is not a supported value';
            }

            return true;
        }




        /**
         * The public methods that HookMan offers are declared i nthe prototype.
         * Using the prototype reveal pattern it keeps some functions private.
         *
         * @return {Object} Public methods wrapped into an object.
         */

        HookMan.prototype =
            {
                constructor: HookMan,
                add: add,
                rem: rem,
                run: run,
                resume: resume,
                suspend: suspend
            };

        return HookMan;
    }();




    /**
     * This is an object containing the possible CMS systems supported by
     * SiteAttention.
     *
     * @type {Object}
     */

    const Cms =
        {
            'Unknown': 'XX',
            'Demo': 'DE',
            'Drupal': 'DP',
            'EPIServer': 'ES',
            'Sitecore': 'SC',
            'Umbraco': 'UM',
            'WordPress': 'WP'
        };




    /**
     * Helper function to inject a script and optionally make a callback when the
     * script has finished loading.
     *
     * @param      {String}    url     The <script> URL address
     * @param      {Function}  cb      Optionally provide a callback that will be
     *                                 called when the script has finished loading
     */

    const inject_script = function (url, cb) {
        let script = document.createElement('script');
        script.type = 'text/javascript';
        script.async = true;
        script.src = url;

        if (cb === undefined) {
            return;
        }

        if (script.addEventListener) {
            script.addEventListener('load', cb);
        }

        else if (script.readyState) {
            script.onreadystatechange = cb;
        }

        document.body.appendChild(script);
    }




    /**
     * Return the public methods needed for the CMS Module developers and for
     * individual developers that seek to integrate SiteAttention into their
     * systems or to make their own implementation of FieldAbstract to fit their
     * needs.
     */

    return {
        Cms: Cms,
        FieldFactory: FieldFactory,
        inject_script: inject_script,
        hooks: new HookMan()
    };
}();
//# sourceURL=module.sa.js

define([
        // Dojo
        "dojo",
        "dojo/_base/declare",
    ],
    function (
        // Dojo
        dojo,
        declare
    ) {
        return declare("siteattention.SiteAttentionModule",
            [],
            {
                SiteAttentionModule: SiteAttentionModule
            });
    });

