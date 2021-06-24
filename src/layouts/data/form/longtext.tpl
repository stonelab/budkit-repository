<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <textarea tpl:name="data_${type}_${uri}" tpl:data-step="${order}" class="form-control flat" tpl:placeholder="${placeholder}" tpl:required="${if://required=1}"  minlength="10" rows="5"></textarea>
</tpl:layout>
