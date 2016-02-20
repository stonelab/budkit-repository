<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <input type="file" tpl:data-step="${order}" tpl:name="data_${type}_${uri}" class="input-lg form-control flat fileupload" />
    <input id="fileupload" type="file" name="files[]" data-url="/member/timeline.json" multiple="multiple" class="fileupload" />
    <script>
        //<![CDATA[
        require(['config'], function () {
            require(['blueimp.fileupload'], function() {

                $('.fileupload').fileupload({
                    dataType: 'json',
                    done: function (e, data) {
                        $.each(data.result.files, function (index, file) {
                            $('<p/>').text(file.name).appendTo(document.body);
                        });
                    }
                });

            })
        });
       // ]]>
    </script>
</tpl:layout>
