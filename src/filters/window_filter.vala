namespace PirateFilter.Filters {
    /**
     * Class that inherites from // Window // and creates the new window.
     * */
    public class WindowFilter : Gtk.Window {

        /**
         * Method that creates the main window, defines the size and the
         * content.
         */
        public WindowFilter (Gtk.WindowType? type = POPUP, Gdk.Pixbuf img) {
            Object (type: type);
            var image = new Gtk.Image.from_pixbuf (img);
            set_default_size (800, 800);
            title = "Filter";
            set_titlebar (create_headerbar ());
            add (create_scroll (image));
            show_all ();
        }

        /*
         * Creates a vertical and horizontal scrollbar to scroll
         * through the image.
         */
        Gtk.ScrolledWindow create_scroll (Gtk.Widget w) {
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.show ();
            scroll.hexpand = true;
            scroll.vexpand = true;
            scroll.add (w);
            return scroll;
        }

        /*
         * Creates an headerbar to the new window, adds a close button.
         * */
        Gtk.HeaderBar create_headerbar () {
            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = "Filter";
            headerbar.show_close_button = true;
            headerbar.show ();
            return headerbar;
        }
    }
}
