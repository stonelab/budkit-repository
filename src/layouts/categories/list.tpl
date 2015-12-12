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
                                <h3 class="subject heading">
                                    <a tpl:href="/repository/category/${object_uri}" class="subject"><tpl:data value="media_title" /></a>
                                </h3>
                                <div class="summary"><tpl:data value="media_summary" parsedown="true" markup="true" /></div>
                                <div class="body clearfix"></div>
                                <div class="actions clearfix">
                                    <ul class="nav pull-left">
                                        <li>
                                            <a tpl:href="/repository/${object_uri}/add" class="edit">
                                                <span>Form</span>
                                            </a>
                                        </li>
                                    </ul>
                                    <ul class="nav  pull-right">
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
                            </div>
                        </div>
                    </li>
                </tpl:loop>
            </ul>
        </div>
    </div>
</tpl:layout>
