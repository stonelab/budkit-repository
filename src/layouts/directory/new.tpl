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
            <div class="container-block">
                <div class="container">
                    <div class="row text-center mb">
                        <h1 class="page-header bottom-border"><tpl:data value="category.media_title" default="Add New Listing" />
                            <p class="small help-block"><tpl:data value="category.media_summary" default="Please select a category below" /> </p>
                        </h1>
                    </div>
                </div>
                <div class="container prl pbl pll">
                    <form class="stream-flow add-listing" role="form" method="post" action="?" style="margin-left: -40px">
                        <div class="stream-list">
                            <div class="stream-line"/>
                            <ul class="stream">
                                <li class="stream-title">Start</li>

                                <li class="stream-item">
                                    <div class="stream-line"/>
                                    <div class="item has-step-number">
                                        <div class="stream-intro">
                                            <tpl:data value="category.category_welcome" />
                                        </div>
                                    </div>

                                </li>

                                <tpl:loop foreach="category.category_form">
                                    <li class="stream-item">
                                        <div class="stream-line"/>
                                        <div class="item has-step-number">
                                            <span class="btn btn-lg btn-circle step-number"><tpl:data value="order" /></span>
                                            <h3 class="subject heading"><tpl:data value="question"/></h3>
                                            <div class="summary"><tpl:data value="description"/></div>

                                            <div class="body clearfix">
                                                <div class="content clearfix ptm">
                                                    <tpl:import tpl:name="categories/form/${type}.tpl" />
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </tpl:loop>

                                <li class="stream-item">
                                    <div class="stream-line"/>
                                    <div class="item has-step-number">
                                        <div class="stream-outro">
                                            <tpl:data value="category.category_thankyou" />
                                        </div>
                                    </div>

                                </li>
                                <li class="stream-title end">The End</li>
                            </ul>
                        </div>


                        <div class="form-section">
                            <h2 class="form-subheading">
                                About you and/or your organisation
                            </h2>
                            <div class="form-row row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">First Name</label>
                                        <input type="text" class="form-control" name="user_first_name" placeholder="First Name"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Last Name</label>
                                        <input type="text" class="form-control" name="user_last_name" placeholder="Last Name"/>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Date of Birth</label>
                                        <input type="text" class="form-control" name="user_last_name" placeholder="Last Name"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Gender</label>
                                        <input type="text" class="form-control" name="user_last_name" placeholder="Last Name"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="location">Email Address</label>
                                        <input type="text" class="form-control" name="user_first_name" placeholder="First Name"/>
                                        <span class="help-block">Please provide a valid email address to which we shall send important information</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Phone Number</label>
                                        <input type="text" class="form-control" name="user_first_name" placeholder="Phone Number"/>
                                        <span class="help-block">We may sometimes need to call you. </span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">What is your occupation?</label>
                                        <input type="text" class="form-control" name="user_last_name" placeholder="Occupation"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="location">What languages are you fluent in?</label>
                                        <select multiple="multiple" class="form-control multiselect multiselect-default">
                                            <option value="0">English</option>
                                            <option value="1" selected="selected">French (Français)</option>
                                            <option value="2" selected="selected">Spanish (Espagnol)</option>
                                            <option value="3" selected="selected">Bedawi (البداوي)</option>
                                            <option value="4">German</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mtl mbl clearfix"/>
                        <div class="form-section">
                            <h2 class="form-subheading">
                                About the accomodation offered
                            </h2>

                            <div class="form-row">
                                <div class="form-group">

                                    <label>Room Type</label>

                                    <div class="button-radio-group mbl">
                                        <a class="col-md-3 active">
                                            <input type="radio" class="native" name="listing_type" checked="checked" value="Housing"/>
                                            <span>Private Room(s)</span>
                                        </a>
                                        <a class="col-md-3">
                                            <input type="radio" class="native" name="listing_type" value="Housing"/>
                                            <span>Shared Room(s)</span>
                                        </a>
                                        <a class="col-md-3">
                                            <input type="radio" class="native" name="listing_type" value="Housing"/>
                                            <span>Other Space(s)</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="location">Location</label>
                                        <input type="text" class="form-control places-search" id="location"
                                               placeholder="Enter Location"/>
                                    </div>
                                </div>
                                <!--/.col-md-6-->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Number of rooms offered</label>
                                        <input type="text" class="form-control" placeholder="Enter Number"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Number of beds offered</label>
                                        <input type="text" class="form-control" placeholder="Enter Number"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Number of bathrooms offered</label>
                                        <input type="text" class="form-control places-search" id="location"
                                               placeholder="Enter Location"/>
                                    </div>
                                </div>
                                <!--/.col-md-6-->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">How many people live here?</label>
                                        <input type="text" class="form-control places-search" id="location"
                                               placeholder="Enter Number"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">How many pets in the property?</label>
                                        <input type="text" class="form-control" placeholder="Enter Number"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Dates available from</label>

                                        <input type="text" class="form-control places-search" id="location"
                                               placeholder="Enter date"/>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Max duration of stay </label>
                                        <select name="type" title="All" data-toggle="select" class="select select-white"
                                                data-live-search="true" id="type">
                                            <option value="1">At least 3 Months</option>
                                            <option value="2">Up to 6 Months</option>
                                            <option value="2">More than 6 Months</option>
                                            <option value="2">Up to a year</option>
                                            <option value="2">More than a year</option>
                                            <option value="2" selected="selected">However long needed</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="type">Max number of guests</label>
                                        <select name="type" title="All" data-toggle="select" class="select select-white"
                                                data-live-search="true" id="type">
                                            <option value="1">1 Guest</option>
                                            <option value="2">2 Guests</option>
                                            <option value="2">3 Guests</option>
                                            <option value="2">4 Guests</option>
                                            <option value="2">5 Guests</option>
                                            <option value="2">5+ Guests</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="location">Offer expires on</label>

                                        <input type="text" class="form-control places-search" id="location"
                                               placeholder="Enter expiry date"/>

                                    </div>
                                </div>
                            </div>
                            <div class="form-row row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="location">Room Description, Preferences etc</label>
                                        <textarea class="form-control" rows="10" id="location"
                                                  placeholder="Please provide details of any perks, features etc associated with this offering"></textarea>
                                        <span class="help-block">In the description, please provide as many relevant details as possible. For install are all the rooms offered in the same property? Are there any specific groups of people you will not want to house?</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-section">
                            <h2 class="form-subheading">
                                The legal bits and other information
                            </h2>

                            <div class="form-row">
                                <p>Ensure that you have read and understand how the whole process works. This includes your responsibilities, and legal protection. </p>
                                <p>All the very personal information which you have provided to enable us make the best possible match between yourself and a potential tenant is strictly governed as per the terms in our privacy policy</p>
                                <p>We are legally required to consider any criminal records you may have had</p>
                                <dl>
                                    <dt><label>Do you or anyone living in the property offered have a criminal record.</label></dt>
                                    <dd>
                                        <div class="controls">
                                            <label class="radio">
                                                <input type="radio" name="options[site][registration]" value="1" />
                                                <span>Yes</span>
                                            </label>
                                            <label class="radio">
                                                <input type="radio" name="options[site][registration]" value="1"  />
                                                <span>No</span>
                                            </label>
                                        </div>
                                    </dd>
                                </dl>
                                <p>If you answered yes to the above question, please write to <a href="mailto:host@refugeeswelcome.uk">host@refugeeswelcome.uk</a> with a complete DBS (Disclosure and Barring Service) report</p>
                                <p>Finally, by submitting this form to us, you declare that the information you provide is accurate to the best of your knowledge, and agree to all the terms discussed above plus those in our terms of service.</p>
                            </div>

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
                        require(['budkit.map'])
                    });
                </script>
            </div>
        </div>

    </tpl:replace>
</tpl:layout>

