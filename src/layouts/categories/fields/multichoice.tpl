<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div tpl:class="panel panel-field hide${type}">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">                 <input type="hidden" tpl:name="category_form[${order}][uri]" tpl:value="${uri}" />
               <span class="field-count"><input type="text" tpl:value="${order}" data-toggle="field-count" readonly="readonly" tpl:name="category_form[${order}][order]" /></span>
                <span role="button"><tpl:data value="question" default="Multichoice" /></span>
            <span class="pins pull-right">
                    <a data-toggle="remove-field" href="#" class="color-alizarin">
                        Remove
                    </a>
                </span>
                <tpl:condition test="equals" on="type" is="multichoice">
                    <input type="hidden" tpl:name="category_form[${order}][existing]" value="1" />
                </tpl:condition>
            </h4>
        </div>
        <div class="panel-collapse collapse in" role="tabpanel">
            <div class="panel-body">
                <div class="form-group row">
                    <div class="col-md-8 prn">
                        <input type="text" class="form-control" tpl:name="category_form[${order}][multichoice][question]"  placeholder="Question *" tpl:value="${question}" />
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][multichoice][required]" selected="required">
                            <option value="0" selected="selected">Optional</option>
                            <option value="1">Required</option>
                        </tpl:select>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-4 prn">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][multichoice][multiselect]" selected="multiselect">
                            <option value="0" selected="selected">Single choice</option>
                            <option value="1">Multiple choices</option>
                        </tpl:select>
                    </div>
                    <div class="col-md-4 prn">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][multichoice][customchoice]" selected="customchoice">
                            <option value="0" selected="selected">Predefined choices only</option>
                            <option value="1">Allow custom choice</option>
                        </tpl:select>
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][multichoice][verticallist]" selected="verticallist">
                            <option value="1" selected="selected">Show all choices</option>
                            <option value="0">Display as select dropdown</option>
                        </tpl:select>
                    </div>
                </div>

                <tpl:loop foreach="choice">
                    <div class="form-group input-group">
                        <input type="text" class="form-control" data-toggle="multichoice-choice" tpl:name="category_form[${$.order}][multichoice][choice][]"  placeholder="Add answer choice" tpl:value="${$}" />
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
                    <input type="text" class="form-control" data-toggle="multichoice-choice" tpl:name="category_form[${order}][multichoice][choice][]"  placeholder="Add answer choice" />
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
                    <textarea class="form-control" tpl:name="category_form[${order}][multichoice][description]"  placeholder="Description" rows="4"><tpl:data value="description" /></textarea>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>
