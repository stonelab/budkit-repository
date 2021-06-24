<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="datetime" xmlns:tpl="http://budkit.org/tpl">
    <p>
        <tpl:condition on="multiselect" test="equals" is="0">
            <tpl:data value="value" />
        </tpl:condition>
    </p>
    <div>
        <tpl:condition on="multiselect" test="equals" is="1">
            <ul class="pll mbl">
                <tpl:loop foreach="value">
                    <li><tpl:data value="$" /></li>
                </tpl:loop>
            </ul>

        </tpl:condition>
    </div>
</tpl:layout>