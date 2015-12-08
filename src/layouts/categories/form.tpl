<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="form" xmlns:tpl="http://budkit.org/tpl">
    <div class="container-form">
        <div class="category">
            <div class="form-group">
                <label>Title</label>
                <input type="text" class="form-control" name="media_title"
                       placeholder="Category Title" tpl:value="${editing.media_title}" />
                <span class="help-block">One word titles work best</span>
            </div>
            <div class="form-group">
                <label>Description</label>
                 <textarea class="form-control" name="media_summary"
                           placeholder="Field description" rows="4"><tpl:data value="editing.media_summary" /></textarea>
                <span class="help-block">This description is displayed on the first page of your data aquisition form</span>
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