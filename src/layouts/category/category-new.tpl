<?xml version="1.0" encoding="utf-8"?>
<tpl:layout  xmlns:tpl="http://budkit.org/tpl" name="category-editor">
    <div class="col-md-12 ptm">
        <tpl:menu tpl:uid="repoadmin:${object_uri}" class="nav nav-tabs" />
        <div class="panel">
            <!--<div class="panel-heading">
                <h4 class="panel-title">How we are performing</h4>
                <p class="nomargin">Past 30 Days — Last Updated September 19, 2015</p>
            </div>-->
            <div class="panel-body clearfix row">

                    <form tpl:action="/admin/repository/${object_uri}/edit" method="post" class="clearfix">

                        <tpl:import name="category/category-form" />
                        
                        <input type="hidden" name="object_uri" tpl:value="${object_uri}"/>
                        <input type="hidden" name="csrftoken" tpl:value="${csrftoken}"/>
                        <tpl:condition  test="equals" on="method" is="update">
                            <input type="hidden" name="_method" value="PATCH"/>
                        </tpl:condition>
                    </form>

            </div>
        </div>
    </div>
</tpl:layout>