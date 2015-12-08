<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="editor" xmlns:tpl="http://budkit.org/tpl">
    <html lang="en">
    <head>
        <tpl:import name="head"/>
    </head>
    <body class="editing">
    <div class="container-side minimized sidebar" role="side"><!-- add "minimized" class to minimize-->
        <tpl:import name="sidebar"/>
    </div>
    <div class="container-main admin" role="main" style="z-index: 1">
        <div class="container-navigation">
            <tpl:import name="admin/navigation"/>
        </div>
        <div class="container-block">
            <div class="container-aside">
                <div class="container-heading">Add Fields</div>
                <div class="container-block">
                    <tpl:import name="categories/fields.tpl"/>
                </div>
            </div>

            <form tpl:action="/admin/repository/category/${object_uri}/edit" method="post" class="container-main clearfix">
                <div class="container-block no-scroll">
                    <div class="container-pside background-white" role="pside">
                        <div class="container-heading">
                            Data Form
                        </div>
                        <div class="container-block">
                            <div>
                                <tpl:import name="alerts"/>
                            </div>

                                <tpl:import name="categories/form" />

                        </div>
                    </div>
                    <div class="container-main">
                        <div class="container-block no-scroll">
                            <div class="container-main">
                                <div class="container-heading">
                                    <span>Data Fields</span>
                                    <tpl:condition on="object_uri" test="empty" is="0">
                                        <a tpl:href="/repository/${object_uri}/add" class="pull-right">Preview form</a>
                                    </tpl:condition>
                                </div>
                                <div class="container-block background-white no-scroll">
                                    <div class="container-block custom-fields-holder">

                                        <div class="fields-intro">
                                            <tpl:import name="categories/fields/welcome" />
                                        </div>

                                        <div class="fields-holder">

                                            <tpl:loop foreach="editing.category_form">
                                                <div>
                                                    <tpl:import tpl:name="categories/fields/${type}.tpl" />
                                                </div>
                                            </tpl:loop>

                                            <div class="placeholder empty">
                                                Drag data fields here
                                            </div>

                                        </div>

                                        <div class="fields-intro">
                                            <tpl:import name="categories/fields/thankyou" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="object_uri" tpl:value="${object_uri}"/>
                <input type="hidden" name="csrftoken" tpl:value="${csrftoken}"/>
                <tpl:condition  test="equals" on="method" is="update">
                    <input type="hidden" name="_method" value="PATCH"/>
                </tpl:condition>
            </form>
        </div>
    </div>
    <script type="text/javascript">
        require(['config'], function () {
            require(['jquery', 'budkit.fields'], function ($, BKFields) {
                //console.log(BKFields)
                var $fields = new BKFields();

                $.fn.managechoices = function(option) {

                    return this.each(function() {

                        var $field = $(this),
                                $add = $field.next().find('[data-toggle="add-choice"]'),
                                $delete = $field.next().find('[data-toggle="delete-choice"]'),
                                $group = $field.parent()
                                ;

                        $add.off().on("click", function() {

                            var value = $.trim($field.val())
                            if(value.length > 0){
                                var $newgroup = $group.clone();
                                $newgroup.find('[data-toggle="multichoice-choice"]').val("").managechoices();
                                $newgroup.insertAfter($group)
                            }
                        });

                        $delete.off().on("click", function() {
                            //we need at least one child for continuity
                            $group.not(':only-child').remove();
                        });
                    });
                };

                $('[data-toggle="multichoice-choice"]').managechoices();

                //Remove field
                $(".panel").each(function(){
                    var $panel = $(this),
                            $remover = $panel.find('[data-toggle="remove-field"]')
                            ;
                    $remover.on("click", $($fields.options.holder),  function(e) {
                        $panel.remove();
                        $fields.renumberOrdering();
                    });
                });
            });
        });
    </script>
    </body>
    </html>
</tpl:layout>