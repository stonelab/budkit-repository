<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="form" xmlns:tpl="http://budkit.org/tpl">
    <div class="container-form">
        <div class="category">
            <div class="form-group">
                <label>Name</label>
                <input type="text" class="form-control" name="category_name"
                       placeholder="Category name" tpl:value="${editing.category_name}" />
                <span class="help-block">One word titles work best</span>
            </div>
            <div class="form-group">
                <label>Form title</label>
                <input type="text" class="form-control" name="media_title"
                       placeholder="Category form title" tpl:value="${editing.media_title}" />
                <span class="help-block">One word titles work best</span>
            </div>
            <div class="form-group">
                <label>Form Description</label>
                 <textarea class="form-control" name="media_summary"
                           placeholder="Field description" rows="4"><tpl:data value="editing.media_summary" /></textarea>
                <span class="help-block">This description is displayed on the first page of your data aquisition form</span>
            </div>
            <div class="form-group">

                <label>Can View</label>
                <select name="category_view_permission" class="form-control">
                    <option value="">...</option>
                    <tpl:loop foreach="authorities">
                        <option tpl:value="${authority_id}" tpl:selected="${if://$.editing.category_view_permission=authority_id}">
                            <span><tpl:data value="authority_title" /></span>
                        </option>
                    </tpl:loop>
                </select>
                <span class="help-block">In addition to the data owner (i.e the person submitting the form) who else on the network should be allowed to see this data once submitted?</span>
            </div>

            <div class="form-group">

                <label>Can Submit</label>
                <select name="category_submit_permission" class="form-control">
                    <option value="">...</option>
                    <tpl:loop foreach="authorities">
                        <option tpl:value="${authority_id}" tpl:selected="${if://$.editing.category_submit_permission=authority_id}">
                            <span><tpl:data value="authority_title" /></span>
                        </option>
                    </tpl:loop>
                </select>
                <span class="help-block">Who can view and submit data using this form. Note that a public form will automatically require a user account to be created, and additional fields will be added to the form if there is no active user session</span>
            </div>
            <div class="form-group">
                <label>Progress bar type</label>

                <div class="button-radio-group mbl">
                    <a class="col-md-4 prn active">
                        <tpl:input type="radio" class="native" name="category_form_progressbar_type"
                                   checked="" value="1" data="editing.category_form_progressbar_type"/>
                        <span>Percentage</span>
                    </a>
                    <a class="col-md-4 prn">
                        <tpl:input type="radio" class="native" name="category_form_progressbar_type"
                                   value="2"  data="editing.category_form_progressbar_type"/>
                        <span>Proportional</span>
                    </a>
                    <a class="col-md-4">
                        <tpl:input type="radio" class="native" name="category_form_progressbar_type"
                                   value="3"  data="editing.category_form_progressbar_type"/>
                        <span>Steps</span>
                    </a>
                </div>
                <span class="help-block">The nature of the progress bar to display with the category form</span>
            </div>
            <div class="form-group">
                <label>Icon</label>
                <input type="text" class="form-control" name="category_icon" tpl:value="${editing.category_icon}"
                       placeholder="Category Icon"/>
                <span class="help-block">A unique icon class to describe this category</span>
            </div>
            <div class="form-group">
                <label>Colour</label>
                <input type="text" class="form-control" name="category_colour" tpl:value="${editing.category_colour}"
                       placeholder="Category Colour"/>
                <span class="help-block">A unique color to define this category</span>
            </div>
            <div class="form-group">
                <button class="btn btn-success btn-lg" type="submit">Save Category</button>
                <a class="btn btn-danger btn-lg pull-right" href="#">Delete Category</a>
            </div>
        </div>
    </div>
    <div class="container-box">

    </div>
</tpl:layout>