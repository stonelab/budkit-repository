<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="panel panel-field outro">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">
                <span role="button">"Thank You" Message</span>
            </h4>
        </div>
        <div class="panel-collapse collapse in" role="tabpanel" >
            <div class="panel-body">
                <div class="form-field-group">
                    <textarea class="form-control" name="category_thankyou"
                              placeholder="Thank you text" rows="8"><tpl:data value="editing.category_thankyou" default="Thank you for taking the time to complete this form" /></textarea>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>
