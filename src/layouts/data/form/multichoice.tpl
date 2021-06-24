<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="form-group">
        <div class="button-radio-group mbl">
            <tpl:loop foreach="choice">
                <a class="col-md-3 prn active">
                    <input type="radio" class="native" tpl:data-step="${.order}"  tpl:name="data_${$.type}_${$.uri}"
                               checked="" tpl:value="${$}"  tpl:required="${if://.required=1}" />
                    <span><tpl:data value="$" /></span>
                </a>
            </tpl:loop>
        </div>
    </div>
</tpl:layout>
