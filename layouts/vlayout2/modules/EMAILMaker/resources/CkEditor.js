/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

jQuery.Class("EMAILMaker_CkEditor_Js", {}, {
    ckEditorInstance: false,

    getckEditorInstance: function() {
        if (this.ckEditorInstance == false) {
            this.ckEditorInstance = new Vtiger_CkEditor_Js();
        }
        return this.ckEditorInstance;
    },
    registerEvents: function() {
        var thisInstance = this;
        var ckEditorInstance = this.getckEditorInstance();
    }
});
jQuery(document).ready(function() {
    var EMAILMakerCkEditorJsInstance = new EMAILMaker_CkEditor_Js();
    EMAILMakerCkEditorJsInstance.registerEvents();
});
