<?xml version="1.0" encoding="utf-8"?>
<tpl:layout extends="index" xmlns:tpl="http://budkit.org/tpl">


    <!--Remove-->
    <tpl:remove path="//div[@role='stream']"/>
    <tpl:remove path="//div[@role='side']"/>
    <tpl:remove path="//div[@role='aside']"/>

    <tpl:replace path="//div[@role='main']">
        <div class="container-main">
            <div class="container-navigation lg">
                <tpl:import name="navigation"/>
            </div>
            <div class="container-block" id="budkit-form-holder">
                <div class="container" data-form-step="0">
                    <div class="row text-center mb">
                        <h1 class="page-header bottom-border"><tpl:data value="category.media_title" default="Add New Listing" />
                            <div class="small help-block"><tpl:data value="category.media_summary" default="Please select a category below" parsedown="true" markup="true" /> </div>
                        </h1>
                    </div>
                </div>
                <div class="container prl pbl pll">
                    <form class="stream-flow add-listing" id="budkit-form" role="form" method="post" tpl:action="/repository/${object_uri}/put" style="margin-left: -40px" data-enable-shim="true">
                        <div class="stream-list">
                            <div class="stream-line"/>
                            <ul class="stream">
                                <li class="stream-title">Start</li>

                                <li class="stream-item form-step form-first-step">
                                    <div class="stream-line"/>
                                    <div class="item has-step-number">
                                        <div class="stream-intro">
                                            <tpl:data value="category.category_welcome" />
                                        </div>
                                       <div class="form-navigation" id="budkit-form-navigator">
                                           <ul>
                                               <li class="current start" data-target-step="0"><a><i class="ionicon"></i></a></li>
                                               <tpl:loop foreach="category.category_form">
                                                    <li tpl:data-target-step="${order}"><a><i class="ionicon"></i></a></li>
                                               </tpl:loop>
                                           </ul>
                                       </div>
                                    </div>
                                </li>

                                <tpl:loop foreach="category.category_form">
                                    <li class="stream-item form-step" tpl:data-form-step="${order}">
                                        <div class="stream-line"/>
                                        <div>
                                        <tpl:condition on="type" test="not" is="statement">
                                        <div class="item has-step-number form-step-holder">

                                                <span class="btn btn-lg btn-circle step-number"><tpl:data value="order" /></span>

                                                <h3 class="subject heading"><tpl:data value="question"/></h3>

                                                <div class="body clearfix mtl mbl">
                                                    <div class="content clearfix">
                                                        <tpl:import tpl:name="categories/form/${type}.tpl" />
                                                    </div>
                                                </div>
                                                <div class="summary"><tpl:data value="description" parsedown="true" markup="true" /></div>

                                        </div>
                                        </tpl:condition>
                                        </div>
                                        <tpl:condition on="type" test="equals" is="statement">
                                            <div class="item has-step-number form-step-holder">
                                                <span class="btn btn-lg btn-circle step-number"><tpl:data value="order" /></span>
                                                <h4 class="subject heading border-bottom">
                                                    <em><tpl:data value="text" parsedown="true" markup="true" /></em>
                                                </h4>
                                            </div>
                                        </tpl:condition>
                                    </li>
                                </tpl:loop>

                                <li class="stream-item form-step form-last-step">
                                    <div class="stream-line"/>
                                    <div class="item has-step-number">
                                        <div class="stream-outro mbl">
                                            <tpl:data value="category.category_thankyou" parsedown="true" markup="true" />
                                        </div>

                                        <button type="submit" class="mtl btn btn-primary btn-lg">Review &amp; Submit</button>
                                    </div>

                                </li>
                                <li class="stream-title end">The End</li>
                            </ul>
                        </div>
                    </form>
                </div>
                <div id="map" style="display: none;"></div>
                <tpl:import name="foot" />
                <script>
                    require(['config'], function () {
                        require.config({
                            googlemaps: {
                                params: {
                                    key: 'AIzaSyBZrzwMucdDb547ZrUkWrhkIChoNJfAC88',
                                    libraries: 'places'
                                }
                            }
                        });
                        require(['budkit.map', 'budkit.form'], function() {
                            $("#budkit-form").bkform({
                                form_holder : "#budkit-form-holder",
                                form_navigator: "#budkit-form-navigator"
                            });
                        })
                    });
                </script>
            </div>
        </div>
    </tpl:replace>
</tpl:layout>

