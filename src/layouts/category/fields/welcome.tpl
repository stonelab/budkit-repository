<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="panel panel-field intro mtn">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">
                <span role="button">"Welcome" message</span>
            </h4>
        </div>
        <div class="panel-collapse collapse in" role="tabpanel" >
            <div class="panel-body">
                <div class="form-field-group">
                    <textarea class="form-control" name="category_welcome"
                              placeholder="Introductory text" rows="6">
                        <tpl:data value="editing.category_welcome" default="Please take the time to read through every question and answer to the best of your abilities" />
                    </textarea>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>
