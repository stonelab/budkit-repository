<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="fields" xmlns:tpl="http://budkit.org/tpl">
    <div class="prm ptm plm pbm">
        <div class="custom-fields-selectors mbl">
            <div class="field-selector col-md-12 mbm">
                <input type="radio" class="native" name="field_type"  value="ShortText" />
                <span>Short text</span>
                <tpl:import name="categories/fields/shorttext" />

            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Longtext" />
                <span>Long text</span>
                <tpl:import name="categories/fields/longtext" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Multiplechoice" />
                <span>Multiple choice</span>
                <tpl:import name="categories/fields/multichoice" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Picturechoice" />
                <span>Picture choice</span>
                <tpl:import name="categories/fields/picturechoice" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Statement" />
                <span>Statement</span>
                <tpl:import name="categories/fields/statement" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Dropdown" />
                <span>Dropdown</span>
                <tpl:import name="categories/fields/dropdown" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Yes/No" />
                <span>Yes/No</span>
                <tpl:import name="categories/fields/yesno" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="E-mail" />
                <span>E-mail</span>
                <tpl:import name="categories/fields/email" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Rating" />
                <span>Rating</span>
                <tpl:import name="categories/fields/rating" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Date/Time" />
                <span>Date/Time</span>
                <tpl:import name="categories/fields/datetime" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Opinionscale" />
                <span>Scale</span>
                <tpl:import name="categories/fields/scale" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Number" />
                <span>Number</span>
                <tpl:import name="categories/fields/number" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Location" />
                <span>Location</span>
                <tpl:import name="categories/fields/location" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Website" />
                <span>Website</span>
                <tpl:import name="categories/fields/website" />
            </div>
            <div class="field-selector col-md-12  mbm">
                <input type="radio" class="native" name="field_type" value="Fileupload" />
                <span>File Upload</span>
                <tpl:import name="categories/fields/fileupload" />
            </div>
        </div>


    </div>
</tpl:layout>