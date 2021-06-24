<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="category-field-types" xmlns:tpl="http://budkit.org/tpl">
    <div class="">
        <div class="custom-fields-selectors mbl">
            <div class="field-selector col-md-12 mbm">
                <input type="radio" class="native" name="field_type"  value="ShortText" />
                <span>Short text</span>
                <tpl:import name="category/fields/shorttext" />

            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Longtext" />
                <span>Long text</span>
                <tpl:import name="category/fields/longtext" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Multiplechoice" />
                <span>Multiple choice</span>
                <tpl:import name="category/fields/multichoice" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Picturechoice" />
                <span>Picture choice</span>
                <tpl:import name="category/fields/picturechoice" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Statement" />
                <span>Statement</span>
                <tpl:import name="category/fields/statement" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Dropdown" />
                <span>Dropdown</span>
                <tpl:import name="category/fields/dropdown" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Yes/No" />
                <span>Yes/No</span>
                <tpl:import name="category/fields/yesno" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="E-mail" />
                <span>E-mail</span>
                <tpl:import name="category/fields/email" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Rating" />
                <span>Rating</span>
                <tpl:import name="category/fields/rating" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Date/Time" />
                <span>Date/Time</span>
                <tpl:import name="category/fields/datetime" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Opinionscale" />
                <span>Scale</span>
                <tpl:import name="category/fields/scale" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Number" />
                <span>Number</span>
                <tpl:import name="category/fields/number" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Location" />
                <span>Location</span>
                <tpl:import name="category/fields/location" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Website" />
                <span>Website</span>
                <tpl:import name="category/fields/website" />
            </div>
            <div class="field-selector col-md-12">
                <input type="radio" class="native" name="field_type" value="Fileupload" />
                <span>File Upload</span>
                <tpl:import name="category/fields/fileupload" />
            </div>
        </div>
        <script type="text/javascript">
            require(['config'], function () {
                require(['jquery', 'budkit.fields'], function ($, BKFields) {
                    //console.log(BKFields)
                    var $fields = new BKFields();

                    $.fn.managechoices = function(option) {

                        return this.each(function() {

                            var $field = $(this),
                                    $add = $field.next().find('[data-toggle="add-choice"]'),
                                    $delete = $field.next().find('[data-toggle="delete-choice"]'),
                                    $group = $field.parent()
                                    ;

                            $add.off().on("click", function() {

                                var value = $.trim($field.val())
                                if(value.length > 0){
                                    var $newgroup = $group.clone();
                                    $newgroup.find('[data-toggle="multichoice-choice"]').val("").managechoices();
                                    $newgroup.insertAfter($group)
                                }
                            });

                            $delete.off().on("click", function() {
                                //we need at least one child for continuity
                                $group.not(':only-child').remove();
                            });
                        });
                    };

                    $('[data-toggle="multichoice-choice"]').managechoices();

                    //Remove field
                    $(".panel-field").each(function(){
                        var $panel = $(this), $remover = $panel.find('[data-toggle="remove-field"]');
                        $remover.on("click", $($fields.options.holder),  function(e) {
                            var proceed = confirm("Removing this field will potentially delete existing data from the database when the form is saved. Are you sure you want to do this?");
                            if(proceed) {
                                $panel.remove();
                                $fields.renumberOrdering();
                            }else{
                                e.stopPropagation();
                            }
                        });
                    });
                });
            });
        </script>
    </div>
</tpl:layout>