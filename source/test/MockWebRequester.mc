import Toybox.Lang;

// Synchronous mock for WebRequester. Responses are consumed in FIFO order,
// so the two-stage retry in TrainService can be exercised without a real network.
(:test)
class MockWebRequester extends WebRequester {

    private var responses_ as Array;
    private var nextIdx_   as Number;

    var callCount  as Number;
    var lastUrl    as String;
    var lastParams as Dictionary?;

    function initialize() {
        WebRequester.initialize();
        responses_ = [] as Array;
        nextIdx_   = 0;
        callCount  = 0;
        lastUrl    = "";
        lastParams = null;
    }

    // Queue a response to be returned on the next get() call.
    function enqueue(code as Number, data as Dictionary?) as Void {
        responses_.add([code, data]);
    }

    // Overrides WebRequester.get() — calls the callback synchronously.
    function get(url as String, params as Dictionary?, callback as Lang.Method) as Void {
        callCount++;
        lastUrl    = url;
        lastParams = params;
        var r = responses_[nextIdx_] as Array;
        nextIdx_++;
        callback.invoke(r[0] as Number, r[1]);
    }
}
