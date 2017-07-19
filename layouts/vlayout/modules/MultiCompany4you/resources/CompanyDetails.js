/* * *******************************************************************************
 * The content of this file is subject to the MultiCompany4you license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 * ****************************************************************************** */

jQuery.Class("MultiCompany4you_CompanyDetails_Js", {}, {
    registerSaveCompanyDetailsEvent: function() {
        var thisInstance = this;
        jQuery('#updateCompanyDetailsForm').on('submit', function(e) {
            var result = thisInstance.checkValidation();
            if (result == false) {
                return result;
                e.preventDefault();
            }
        });
    },
    registerCancelClickEvent: function() {
        jQuery('.cancelLink').on('click', function() {
            //jQuery('#CompanyDetailsContainer').removeClass('hide');
            //jQuery('#updateCompanyDetailsForm').addClass('hide');
            history.go(-1);
        });
    },
    checkValidation: function() {
        var imageObj = jQuery('#logoFile');
        var imageName = imageObj.val();
        if (imageName != '') {
            var image_arr = new Array();
            image_arr = imageName.split(".");
            var image_arr_last_index = image_arr.length - 1;
            if (image_arr_last_index < 0) {
                imageObj.validationEngine('showPrompt', app.vtranslate('LBL_WRONG_IMAGE_TYPE'), 'error', 'topLeft', true);
                imageObj.val('');
                return false;
            }
            var image_extensions = JSON.parse(jQuery('#supportedImageFormats').val());
            var image_ext = image_arr[image_arr_last_index].toLowerCase();
            if (image_extensions.indexOf(image_ext) != '-1') {
                var size = imageObj[0].files[0].size;
                if (size < 1024000) {
                    return true;
                } else {
                    imageObj.validationEngine('showPrompt', app.vtranslate('LBL_MAXIMUM_SIZE_EXCEEDS'), 'error', 'topLeft', true);
                    return false;
                }
            } else {
                imageObj.validationEngine('showPrompt', app.vtranslate('LBL_WRONG_IMAGE_TYPE'), 'error', 'topLeft', true);
                imageObj.val('');
                return false;
            }

        }
    },
    registerEvents: function() {
        this.registerSaveCompanyDetailsEvent();
        this.registerCancelClickEvent();
        jQuery('#updateCompanyDetailsForm').validationEngine(app.validationEngineOptions);
    }

});

jQuery(document).ready(function(e) {
    var instance = new MultiCompany4you_CompanyDetails_Js();
    instance.registerEvents();
})