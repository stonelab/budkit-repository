<?xml version="1.0"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl" name="single">
    <div class="container-main" role="main">
        <div class="container-block stream-list-content">
            <div class="ptm stream-detailed-title">
                <tpl:link rel="person"  tpl:href="/member/@${reading.media_owner.id}" tpl:src="/file/${reading.media_owner.image.uri}/60x60" class="person img-rounded" />
                <div class="title-body">
                    <h1 class="stream-detailed-media-title">2 mini bedrooms in 5 bedroom house offered for 2 months</h1>
                    <tpl:menu tpl:uid="mediamenu:${reading.object_uri}" class="nav-pills" />
                </div>
            </div>

            <div class="background-white border-top border-clouds">
                <div class="container-post stream-detailed">
                    <div class="container-saside">

                    </div>
                    <div class="container-main relative ">
                        <div class="stream-list pbl">
                            <div class="stream-line"/>
                            <ul class="stream">
                                <li class="stream-item-detailed">
                                    <div class="stream-labels mtl mbl">
                                        <span class="extra label label-warning">Task</span>
                                        <span class="extra label label-danger">Urgent</span>
                                        <span class="extra label label-info">Information</span>
                                        <span class="extra label label-success">Done</span>
                                        <span class="extra label label-default">Urgent</span>
                                    </div>

                                    <dl class="mtm">

                                        <tpl:loop foreach="reading.media_data">
                                            <div>
                                                <tpl:condition on="value" test="empty" is="0">
                                                    <dt><tpl:data value="name" /></dt>
                                                    <dd><tpl:import tpl:name="template" /></dd>
                                                </tpl:condition>
                                            </div>
                                        </tpl:loop>
                                    </dl>
                                </li>
                            </ul>
                            <tpl:import name="stream" />
                        </div>
                        <div class="stream-list-editor pln">
                            <tpl:import name="/posts/post-editor" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</tpl:layout>