namespace PirateFilter {

    public class App : Gtk.Application {
        Window app_window;

        public App () {
            application_id = "mx.dinamita.pirate";
            flags |= GLib.ApplicationFlags.HANDLES_OPEN;
        }

        public override void activate () {
            if (app_window == null)
                app_window = new Window (this);
            app_window.present ();
        }

    }

}
