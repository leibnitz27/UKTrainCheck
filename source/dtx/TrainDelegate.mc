import Toybox.Lang;
import Toybox.WatchUi;

class TrainDelegate extends WatchUi.BehaviorDelegate {

    private var viewModel_ as TrainViewModel;

    function initialize(viewModel as TrainViewModel) {
        BehaviorDelegate.initialize();
        viewModel_ = viewModel;
    }

    //! START/STOP — manual refresh
    function onSelect() as Boolean {
        viewModel_.refresh();
        return true;
    }

    function onNextPage()     as Boolean { return true;  }
    function onPreviousPage() as Boolean { return true;  }
    function onMenu()         as Boolean { return true;  }
    function onBack()         as Boolean { return false; }
}
