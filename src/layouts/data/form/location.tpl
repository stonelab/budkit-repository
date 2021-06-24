<?xml version="1.0" encoding="utf-8"?>
<tpl:layout xmlns:tpl="http://budkit.org/tpl">
    <input type="text" tpl:name="data_${type}_${uri}" tpl:data-step="${order}" tpl:required="${if://required=1}"  class="input-lg form-control flat" data-autocomplete="true" tpl:data-lat-target="data_${type}_${uri}_lat" tpl:data-lng-target="data_${type}_${uri}_lng" placeholder="Please enter a location" />
    <input type="hidden" tpl:name="data_${type}_${uri}_lat"  value="" />
    <input type="hidden" tpl:name="data_${type}_${uri}_lng"  value="" />

    <div id="map" style="height: 200px;" class="mtl"></div>

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
            require(['gmaps','typeahead.addresspicker','budkit.map'], function(GMaps, AddressPicker, map) {

                var addressPicker = new AddressPicker({ placeDetails: true });
                addressPicker.bindDefaultTypeaheadEvent($('[data-autocomplete="true"]'));

                $('[data-autocomplete="true"]').typeahead(null, {
                    displayKey: 'description',
                    source: addressPicker.ttAdapter()
                }).on('typeahead:selected', function(event, result) {
                    var latTarget = $(this).data('lat-target'), lngTarget = $(this).data('lng-target');
                    GMaps.geocode({
                        placeId: result.place_id ,
                        callback: function(results, status) {

                            if (status == 'OK') {
                                var latlng = results[0].geometry.location;
                                map.setCenter(latlng.lat(), latlng.lng());
                                map.removeMarkers(); //remove all previous markers
                                map.addMarker({
                                    lat: latlng.lat(),
                                    lng: latlng.lng()
                                });
                                $('input[name="'+latTarget+'"]').val(latlng.lat());
                                $('input[name="'+lngTarget+'"]').val(latlng.lng());
                            }
                        }
                    });
                });
            });
        });
    </script>

</tpl:layout>
