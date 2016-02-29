<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div tpl:class="panel panel-field hide${type}">
        <div class="panel-heading" role="tab">
            <h4 class="panel-title">                 <input type="hidden" tpl:name="category_form[${order}][uri]" tpl:value="${uri}" />
               <span class="field-count"><input type="text" tpl:value="${order}" data-toggle="field-count" readonly="readonly" tpl:name="category_form[${order}][order]" /></span>
                <span role="button"><tpl:data value="question" default="File upload" /></span>
                <span class="pins pull-right">
                    <a data-toggle="remove-field" href="#" class="color-alizarin">
                        Remove
                    </a>
                </span>
                <tpl:condition test="equals" on="type" is="fileupload">
                    <input type="hidden" tpl:name="category_form[${order}][existing]" value="1" />
                </tpl:condition>
            </h4>
        </div>
        <div class="panel-collapse collapse in" role="tabpanel">
            <div class="panel-body">
                <div class="form-group row">
                    <div class="col-md-8 prn">
                        <input type="text" class="form-control" tpl:name="category_form[${order}][fileupload][question]"  placeholder="Question *" tpl:value="${question}" />
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][fileupload][required]" selected="required">
                            <option value="0" selected="selected">Optional</option>
                            <option value="1">Required</option>
                        </tpl:select>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-4 prn">
                        <input type="text" class="form-control" tpl:name="category_form[${order}][fileupload][types]"  placeholder="Limit upload file types" tpl:value="${types}" />
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][fileupload][dropzone]" selected="dropzone">
                            <option value="1" >Show as dropzone</option>
                            <option value="0" selected="selected" >Show classic</option>
                        </tpl:select>
                    </div>
                    <div class="col-md-4">
                        <tpl:select class="form-control native" tpl:name="category_form[${order}][fileupload][multiple]" selected="multiple">
                            <option value="0" selected="selected">Single file</option>
                            <option value="1">Multiple files</option>
                        </tpl:select>
                    </div>
                </div>
                <div class="form-field-group">
                    <textarea class="form-control" tpl:name="category_form[${order}][fileupload][description]"  placeholder="Description" rows="4"><tpl:data value="description" /></textarea>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>
