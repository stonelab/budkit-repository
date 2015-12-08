<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="form-group">
        <div class="button-radio-group mbl">
            <tpl:loop foreach="choice">
                <a class="col-md-3 prn active">
                    <tpl:input type="radio" class="native" name="${type}_${uri}"
                               checked="" value="1" data="editing.category_form_progressbar_type"/>
                    <span><tpl:data value="$" /></span>
                </a>
            </tpl:loop>
        </div>
    </div>
</tpl:layout>
