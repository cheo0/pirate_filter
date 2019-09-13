namespace PirateFilter {

    /**
     * Class encharged of activates the new window.
     * */
    public class App : Gtk.Application {
        Window app_window;

        /**
         * Method for takes the app id for the new window.
         * */
        public App () {
            application_id = "mx.dinamita.pirate";
            flags |= GLib.ApplicationFlags.HANDLES_OPEN;
        }

        /**
         * Method for opens the new window.
         * */
        public override void activate () {
            if (app_window == null)
                app_window = new Window (this);
            app_window.present ();
        }

    }

}
