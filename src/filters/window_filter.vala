namespace PirateFilter.Filters {
    public class WindowFilter : Gtk.Window {

        public WindowFilter (Gtk.WindowType? type = POPUP, Gdk.Pixbuf img) {
            Object (type: type);
            var image = new Gtk.Image.from_pixbuf (img);
            set_default_size (800, 800);
            title = "Filter";
            set_titlebar (create_headerbar ());
            add (create_scroll (image));
            show_all ();
        }

        Gtk.ScrolledWindow create_scroll (Gtk.Widget w) {
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.show ();
            scroll.hexpand = true;
            scroll.vexpand = true;
            scroll.add (w);
            return scroll;
        }

        Gtk.HeaderBar create_headerbar () {
            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = "Filter";
            headerbar.show_close_button = true;
            headerbar.show ();
            return headerbar;
        }
    }
}
