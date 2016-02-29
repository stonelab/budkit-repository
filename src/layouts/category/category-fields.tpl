<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="category-fields" xmlns:tpl="http://budkit.org/tpl">
    <div class="pull-right pln prn col-md-9">
        <div class="custom-fields-holder">
            <div class="fields-intro">
                <tpl:import name="category/fields/welcome" />
            </div>
            <div class="fields-holder">
                <tpl:loop foreach="editing.category_form">
                    <div>
                        <tpl:import tpl:name="category/fields/${type}.tpl" />
                    </div>
                </tpl:loop>
                <div class="placeholder empty">
                    Drag data fields here
                </div>
            </div>
            <div class="fields-intro">
                <tpl:import name="category/fields/thankyou" />
            </div>
        </div>
        <div class="form-group mtl mll">
            <button class="btn btn-success" type="submit">Save Form</button>
        </div>
    </div>
</tpl:layout>