<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <select tpl:name="data_${type}_${uri}" class="input-lg form-control flat" tpl:multiple="${if://multiselect=1}">
        <tpl:loop foreach-line="choices">
            <option tpl:value="$"><tpl:data value="$" /></option>
        </tpl:loop>
    </select>
</tpl:layout>
