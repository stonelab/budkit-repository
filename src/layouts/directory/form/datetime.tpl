<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <input type="date" tpl:name="data_${type}_${uri}" class="input-lg form-control flat" tpl:required="${if://required=1}" placeholder="Select a date" tpl:max="${range.stop}" tpl:data-step="${order}"  tpl:min="${range.start}" date="true" />
</tpl:layout>
