<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="category-data" xmlns:tpl="http://budkit.org/tpl">
    <div class="container-overflow">

        <tpl:condition on="categorydata" test="empty" is="1">
            <div class="container-empty-state">
                <div class="empty-state">
                    <img src="/theme/assets/img/placeholders/emptystate.png" />
                    <h4 class="mtl mbm">Nothing to show</h4>
                    <p>There is no data in this repository</p>
                    <a tpl:href="/data/${object_uri}/add" class="btn btn-rounded btn-outlined btn-default">Add Data</a>
                </div>
            </div>
        </tpl:condition>
        <tpl:condition on="categorydata" test="empty" is="0">

        <table class="table table-striped table-bordered-internal table-overflow table-vertical-aligned">
                <thead>
                <tr>
                    <th width="2%">
                        <label class="checkbox">
                            <input type="checkbox" name="data_uri[]" />
                        </label>
                    </th>
                    <th width="5%"></th>
                    <tpl:loop foreach="editing.category_form">
                        <th>
                            <span class="mrs"><tpl:data value="order" tpl:default="${order}" />.</span>
                            <span class="mrs"><tpl:data value="type" tpl:default="${type}" /></span>
                            <span class="help-block">(<tpl:data value="question" tpl:default="${type}" />)</span>
                        </th>
                    </tpl:loop>
                </tr>
                </thead>
                <tbody>
                <tpl:loop foreach="categorydata">
                    <tr>
                        <th width="2%">
                            <label class="checkbox">
                                <input type="checkbox" name="data_uri[]" tpl:value="${uri}" />
                            </label>
                        </th>
                        <th>
                            <a tpl:href="/data/${uri}"> <tpl:data value="uri" /></a>
                        </th>
                        <tpl:loop foreach="data">
                            <td>
                                <tpl:data value="$" />
                            </td>
                        </tpl:loop>
                    </tr>
                </tpl:loop>

                </tbody>
            </table>

            </tpl:condition>
    </div>
</tpl:layout>


