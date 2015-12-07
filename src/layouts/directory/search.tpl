<?xml version="1.0"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl" name="search">
    <div class="container-search">
        <form class="main-search" role="form" method="post" action="?">
            <div class="row">
                <div class="col-md-8 prn">
                    <div class="form-group">
                        <label for="location">Location</label>

                        <input type="text" class="form-control places-search" id="location" placeholder="Enter Location"/>

                    </div>
                </div>
                <!--/.col-md-6-->
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="type">Categories</label>
                        <select name="type"  title="All"  class="form-control" data-live-search="true" id="type">
                            <option value="1">Stores</option>
                            <option value="2" class="sub-category">Apparel</option>
                            <option value="3" class="sub-category">Computers</option>
                            <option value="4" class="sub-category">Nature</option>
                            <option value="5">Tourism</option>
                            <option value="6">Restaurant &amp; Bars</option>
                            <option value="7" class="sub-category">Bars</option>
                            <option value="8" class="sub-category">Vegetarian</option>
                            <option value="9" class="sub-category">Steak &amp; Grill</option>
                            <option value="10">Sports</option>
                            <option value="11" class="sub-category">Cycling</option>
                            <option value="12" class="sub-category">Water Sports</option>
                            <option value="13" class="sub-category">Winter Sports</option>
                        </select>
                    </div>
                    <!-- /.form-group -->
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 prn">
                    <div class="form-group">
                        <label for="location">Needed From</label>

                        <input type="text" class="form-control places-search" id="location" placeholder="Enter Date" />

                    </div>
                </div>
                <div class="col-md-4 prn">
                    <div class="form-group">
                        <label for="location">For (Duration) </label>
                        <select   title="All" data-toggle="select" class="form-control" data-live-search="true" id="type">
                            <option value="1">Less than 1 Day</option>
                            <option value="1">1 Day</option>
                            <option value="2">2 Days</option>
                            <option value="2">3 Days</option>
                            <option value="2">4 Days</option>
                            <option value="2">5 Days</option>
                            <option value="2">Over 5 Days</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="type">Guests</label>
                        <select name="type"  title="All" data-toggle="select" class="form-control" data-live-search="true" id="type">
                            <option value="1">1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="2">3 Guests</option>
                            <option value="2">4 Guests</option>
                            <option value="2">5 Guests</option>
                            <option value="2">5+ Guests</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    </div>
</tpl:layout>