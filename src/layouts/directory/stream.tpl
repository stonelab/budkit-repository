<?xml version="1.0"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl" name="stream">
    <div class="stream-grid">
        <div class="stream-line"/>
        <ul class="stream">
            <tpl:loop repeat="10">
                <li class="stream-item col-md-12">
                    <span class="stream-label"></span>

                    <!-- <div class="stream-line"/>
                    <a class="stream-cover background-green-sea color-white text-center" href="/listing">
                        <i class="ionicons ion-android-restaurant color-white" />
                    </a> -->
                    <div class="item background-white">
                        <div class="stream-content">
                            <h3 class="subject heading">
                                <a href="#" class="subject">Housing</a>
                                <!-- <a href="#" class="author"></a> -->
                                <!-- <a href="#" class="time"><span>2 hours ago</span> </a> -->
                            </h3>

                            <div class="summary">Good result for <a href="">@Hugh_Small</a> and <a
                                        href="">@wclgreens</a> in Westminster by election: nearly 10% of vote, more
                                than
                                double both Lib Dems and Ukip.
                            </div>
                            <div class="body clearfix">
                                <!-- <div class="content clearfix">
                                    <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac
                                        turpis
                                        egestas.
                                        Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet,
                                        ante.
                                        Donec eu
                                        libero sit amet quam egestas semper. Aenean
                                        ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                                </div> -->
                            </div>
                            <div class="actions clearfix">
                                <ul class="nav pull-left">
                                    <li>
                                        <a href="#" class="edit">
                                            <i class="ionicons ion-compose"/>
                                            <span>Edit</span>
                                        </a>
                                    </li>
                                </ul>
                                <ul class="nav  pull-right">
                                    <li>
                                        <a href="#" class="delete">
                                            <i class="ion-android-delete"/>
                                            <span>Delete</span>
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
</tpl:layout>