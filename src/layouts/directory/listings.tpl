<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">

    <div class="container-iside sidestream" role="stream">
        <div class="container-block">
            <tpl:import name="directory/search"/>
            <tpl:import name="directory/stream"/>
        </div>
    </div>
    <div class="container-main" role="main">
        <div id="map" class="container-block no-scroll"> </div>
        <script>
            require(['config'], function(){
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

</tpl:layout>

