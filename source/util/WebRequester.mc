import Toybox.Lang;

using Toybox.Communications;

/*
 * Note - this uses a cloudflare proxy, in order to protect api key (and for a little accounting)
 * 
 * If you want to go direct, use the real BASE_URL, and your own API_KEY.
 */
(:glance)
class WebRequester {

//    private static const API_KEY = "...";
//    private static const BASE_URL = "https://api1.raildata.org.uk/1010-live-departure-board-dep1_2/LDBWS/api/20220120/GetDepartureBoard/";
    private static const BASE_URL = "https://nre-proxy.lab27ukrail.workers.dev/departures/";

    function initialize() {}

    function get(url as String, params as Dictionary?, callback as Lang.Method) as Void {
        var options = {
            :method       => Communications.HTTP_REQUEST_METHOD_GET,
            :headers      => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED,
//                "x-apikey"     => API_KEY
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
        Communications.makeWebRequest(url, params, options, callback);
    }

    static function departureUrl(crs as String) as String {
        return BASE_URL + crs;
    }
}
