<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <!--<input type="date" tpl:name="data_${type}_${uri}" class="input-lg form-control flat"  placeholder="Select a date" tpl:max="${range.stop}" tpl:data-step="${order}"  tpl:min="${range.start}" date="true" /> -->
    <div class="controls inline-inputs clearfix">
        <div class="row">
            <div class="col-md-2 col-sm-2 prn">
                <tpl:datepicker type="day"  tpl:name="data_${type}_day_${uri}" tpl:required="${if://required=1}"
                                id="dob-day" class="form-control"/>
            </div>
            <div class="col-md-3 col-sm-6 prn">
                <tpl:datepicker type="month"  tpl:name="data_${type}_month_${uri}" tpl:required="${if://required=1}" class="form-control"/>
            </div>
            <div class="col-md-2 col-sm-4 prn">
                <tpl:datepicker type="year"  tpl:name="data_${type}_year_${uri}" tpl:required="${if://required=1}"  tpl:range="${range.start}" tpl:limit="${range.stop}" class="form-control"/>
            </div>

            <!-- if we need we are showing the time -->
            <tpl:condition on="time" test="empty" is="0">
                <div class="col-md-2 col-sm-6 prn">
                    <tpl:datepicker type="hour"  tpl:name="data_${type}_hour_${uri}" tpl:required="${if://required=1}" class="form-control"/>
                </div>
                <div class="col-md-2 col-sm-4 prn">
                    <tpl:datepicker type="min"  tpl:name="data_${type}_min_${uri}" tpl:required="${if://required=1}"  class="form-control"/>
                </div>
            </tpl:condition>
        </div>
    </div>

</tpl:layout>
