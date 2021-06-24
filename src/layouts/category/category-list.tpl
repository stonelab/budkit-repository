<?xml version="1.0" encoding="utf-8"?><tpl:layout name="category-list" xmlns:tpl="http://budkit.org/tpl">    <div class="col-md-12 ptm">        <tpl:condition on="categories.items" test="empty" is="1">            <div class="container-empty-state">                <div class="empty-state">                    <img src="/theme/assets/img/placeholders/emptystate.png" />                    <h4 class="mtl mbm">Nothing to show</h4>                    <p>You have not yet created any data repository</p>                    <a href="/admin/repository/add" class="btn btn-rounded btn-outlined btn-default">Create repository</a>                </div>            </div>        </tpl:condition>        <tpl:condition on="categories.items" test="empty" is="0">            <div class="panel panel-list">            <div class="panel-body clearfix row">                <div class="table-responsive">                    <table class="table table-striped table-vertical-aligned    ">                        <thead>                        <tr>                            <th width="2%"></th>                            <th width="3%"></th>                            <th width="50%">Category</th>                            <th width="25%">Permalink</th>                            <th>Action</th>                        </tr>                        </thead>                        <tbody>                        <tpl:loop foreach="categories.items">                            <tr>                                <td>                                    <label class="checkbox">                                        <input type="checkbox" name="page_uri[]" tpl:value="${object_uri}" />                                    </label>                                </td>                                <td>                                    <a tpl:href="/repository/${object_uri}">                                        <i tpl:class="ionicons ${category_icon} color-${category_colour}" />                                    </a>                                </td>                                <td>                                    <a tpl:href="/admin/repository/${object_uri}/data" class="color-information">                                        <span class="mrs"><tpl:data value="category_name" /></span>                                        <span class="ionicon ion-minus-round color-clouds mrs"></span>                                    </a>                                    <span><tpl:data value="media_summary" parsedown="true" markup="true" /></span>                                </td>                                <td><a tpl:href="/repository/${object_uri}">/repository/<tpl:data value="object_uri" /></a></td>                                <td>                                    <a tpl:href="/data/${object_uri}/add" class="edit mrm mts">                                        <span>Form</span>                                    </a>                                    <a tpl:href="/admin/repository/${object_uri}/edit" class="edit mrm mts color-warning">                                        <span>Edit</span>                                    </a>                                    <a tpl:href="/admin/repository/${object_uri}/delete" class="delete color-danger mrm mts mbs">                                        <span class="color-alizarin">Delete</span>                                    </a>                                </td>                            </tr>                        </tpl:loop>                        </tbody>                    </table>                </div>            </div>            <tpl:import name="pagination" />        </div>        </tpl:condition>    </div></tpl:layout>