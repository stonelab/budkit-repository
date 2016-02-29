<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="file-upload">
        <input type="file" tpl:data-step="${order}" data-multiple-caption="{count} files selected"  tpl:name="data_${type}_${uri}[]" tpl:required="${if://required=1}" tpl:multiple="${if://multiple=1}"  />
        <label tpl:for="data_${type}_${uri}">Choose a file</label>
    </div>
</tpl:layout>
