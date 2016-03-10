<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div tpl:class="panel panel-field ${order}hide">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">                 <input type="hidden" tpl:name="category_form[${order}][uri]" tpl:value="${uri}" />
               <span class="field-count"><input type="text" tpl:value="${order}" data-toggle="field-count" readonly="readonly" tpl:name="category_form[${order}][order]" /></span>
                <span role="button"><tpl:data  value="question" default="Picture choice" /></span>
                <tpl:condition on="uri" test="empty" is="0">
                    <span class="ionicon ion-minus-round color-silver mrs mls"></span>
                    <span class="color-silver">uri: <tpl:data value="uri" /></span>
                </tpl:condition>
                <span class="pins pull-right">
                    <a data-toggle="remove-field" href="#" class="color-alizarin">
                        Remove
                    </a>
                </span>
                <tpl:condition test="equals" on="type" is="picturechoice">
                    <input type="hidden" tpl:name="category_form[${order}][existing]" value="1" />
                </tpl:condition>
            </h4>
        </div>
        <div class="panel-collapse collapse in" role="tabpanel">
            <div class="panel-body">
                <div class="form-group row">
                    <div class="col-md-8 prn">
                        <input type="text" class="form-control" tpl:name="category_form[${order}][picturechoice][question]"  placeholder="Question *" tpl:value="${question}" />
                    </div>
                    <div class="col-md-4">
                        <select tpl:name="category_form[${order}][picturechoice][authority]" class="form-control native">
                            <tpl:loop foreach="$.authorities">
                                <option tpl:value="${authority_id}" tpl:selected="${if://$.authority=authority_id}">
                                    <tpl:loop limitby="indent">:-- </tpl:loop>
                                    <span><tpl:data value="authority_title" /></span>
                                </option>
                            </tpl:loop>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-8 prn">
                        <input type="text" class="form-control" tpl:name="category_form[${order}][picturechoice][name]"  placeholder="Unique short name *" tpl:value="${name}" />
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][picturechoice][required]" selected="required">
                            <option value="0" selected="selected">Optional</option>
                            <option value="1">Required</option>
                        </tpl:select>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-4 prn">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][picturechoice][multiselect]" selected="multiselect">
                            <option value="0" selected="selected">Single choice</option>
                            <option value="1">Multiple choices</option>
                        </tpl:select>
                    </div>
                    <div class="col-md-4 prn">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][picturechoice][customchoice]" selected="customchoice">
                            <option value="0" selected="selected">Predefined choices only</option>
                            <option value="1">Allow custom choice</option>
                        </tpl:select>
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][picturechoice][showcaptions]" selected="showcaptions">
                            <option value="1">Show captions</option>
                            <option value="0">Hide captions</option>
                        </tpl:select>
                    </div>
                </div>
                <tpl:loop foreach="choice">
                    <div class="form-group input-group">
                    <span class="input-group-addon">
                        <input type="file" />
                    </span>
                        <input type="text" class="form-control" data-toggle="multichoice-choice" tpl:name="category_form[${$.order}][picturechoice][choice][]"  placeholder="Picture caption" />
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-inverse" data-toggle="add-choice">
                                <i class="ionicons ion-plus color-green-sea" />
                            </button>
                            <button type="button" class="btn btn-inverse" data-toggle="delete-choice">
                                <i class="ionicons ion-close color-alizarin" />
                            </button>
                        </div>
                    </div>
                </tpl:loop>
                <div class="form-group input-group">
                    <span class="input-group-addon">
                        <input type="file" />
                    </span>
                    <input type="text" class="form-control" data-toggle="multichoice-choice" tpl:name="category_form[${order}][picturechoice][choice][]"  placeholder="Picture caption" />
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-inverse" data-toggle="add-choice">
                            <i class="ionicons ion-plus color-green-sea" />
                        </button>
                        <button type="button" class="btn btn-inverse" data-toggle="delete-choice">
                            <i class="ionicons ion-close color-alizarin" />
                        </button>
                    </div>
                </div>
                <div class="form-field-group">
                    <textarea class="form-control" tpl:name="category_form[${order}][picturechoice][description]"  placeholder="Description" rows="4"></textarea>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>
