<?xml version="1.0" encoding="utf-8"?>
<tpl:layout  xmlns:tpl="http://budkit.org/tpl" name="category-editor">
    <div class="ptm mlm mrm mbm">
        <tpl:menu tpl:uid="repoadmin:${object_uri}" class="nav nav-tabs" />
        <div class="panel">
            <div class="panel-body clearfix">
                <div class="row">
                    <div>
                        <tpl:condition on="group" test="equals" is="fields">
                            <div class="pull-left prn col-md-2">
                                <tpl:import name="category/category-field-types" />
                            </div>
                        </tpl:condition>
                    </div>
                    <form tpl:action="/admin/repository/${object_uri}/edit" method="post" class="clearfix">
                        <tpl:block position="form" />
                        <input type="hidden" name="object_uri" tpl:value="${object_uri}"/>
                        <input type="hidden" name="csrftoken" tpl:value="${csrftoken}"/>
                        <tpl:condition  test="equals" on="method" is="update">
                            <input type="hidden" name="_method" value="PATCH"/>
                        </tpl:condition>
                    </form>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>