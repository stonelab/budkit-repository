<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <div class="col-md-12 prn">
        <div class="stream-grid">
            <div class="stream-line"/>
            <ul class="stream">
                <tpl:loop foreach="categories.items">
                    <li class="stream-item col-md-3 pln">
                        <span class="stream-label"></span>

                        <div class="stream-line"/>
                        <a tpl:class="stream-cover background-${category_colour} color-white text-center" tpl:href="/repository/category/${object_uri}">
                            <i tpl:class="ionicons ${category_icon} color-white" />
                        </a>
                        <div class="item background-white">
                            <div class="stream-content">
                                <h3 class="subject heading mbn">
                                    <a tpl:href="/repository/category/${object_uri}" class="subject"><tpl:data value="category_name" /></a>

                                    <div class="actions btn-group">
                                        <button type="button" class="btn btn-default dropdown-toggle btn-rounded" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="ionicons ion-gear-b"/>
                                        </button>
                                        <ul class="dropdown-menu pull-right">
                                            <li>
                                                <a tpl:href="/repository/${object_uri}/add" class="edit">
                                                    <span>Form</span>
                                                </a>
                                            </li>
                                            <li role="separator" class="divider"></li>
                                            <li>
                                                <a tpl:href="/admin/repository/category/${object_uri}/edit" class="edit">
                                                    <span>Edit</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a tpl:href="/admin/repository/category/${object_uri}/delete" class="delete color-alizarin">
                                                    <span class="color-alizarin">Delete</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </h3>

                                <!--<div class="summary"><tpl:data value="media_summary" parsedown="true" markup="true" /></div>
                                <div class="body clearfix"></div>-->
                            </div>
                        </div>
                    </li>
                </tpl:loop>
            </ul>
        </div>
    </div>
</tpl:layout>
