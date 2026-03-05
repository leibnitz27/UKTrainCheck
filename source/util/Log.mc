import Toybox.Lang;

using Toybox.System;

// System.println is a no-op on production devices (no console attached),
// so logging is always compiled in but harmless in release builds.
(:glance)
module Log {

    function println(msg as Object) as Void {
        System.println(msg);
    }

}
