import Toybox.Lang;
import Toybox.Time;

using Toybox.Time.Gregorian;
using Toybox.WatchUi;

class TrainViewModel {

    private var service_    as TrainService;
    private var stop1_      as String;
    private var stop2_      as String;
    private var outward_    as Boolean;
    private var switchHour_ as Number;
    private var offset_     as Number = 0;

    function initialize(stop1 as String, stop2 as String, switchHour as Number, requester as WebRequester) {
        stop1_      = stop1;
        stop2_      = stop2;
        switchHour_ = switchHour;
        var now = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        outward_ = (now.hour < switchHour_);
        service_ = new TrainService(method(:onDataChanged), requester);
    }

    function onSettingsChanged(stop1 as String, stop2 as String, switchHour as Number) as Void {
        stop1_      = stop1;
        stop2_      = stop2;
        switchHour_ = switchHour;
        refresh();
    }

    function refresh() as Void {
        offset_ = 0;
        var now = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        outward_ = (now.hour < switchHour_);
        if (outward_) {
            service_.request(stop1_, stop2_, 10, -60);
        } else {
            service_.request(stop2_, stop1_, 10, -60);
        }
    }

    function getOffset() as Number {
        return offset_;
    }

    function scrollDown() as Void {
        var max = service_.getTrains().size() - 1;
        if (offset_ < max) {
            offset_++;
            WatchUi.requestUpdate();
        }
    }

    function scrollUp() as Void {
        if (offset_ > 0) {
            offset_--;
            WatchUi.requestUpdate();
        }
    }

    function getTitle() as String {
        return _genTitle();
    }

    function getTrains() as Array<Train> {
        return service_.getTrains();
    }

    function isPending() as Boolean {
        return service_.isPending();
    }

    function isBusService() as Boolean {
        return service_.isBusService();
    }

    function getError() as String or Null {
        return service_.getError();
    }

    function onDataChanged() as Void {
        WatchUi.requestUpdate();
    }

    private function _genTitle() as String {
        if (outward_) {
            return stop1_ + " -> " + stop2_;
        }
        return stop2_ + " -> " + stop1_;
    }
}
