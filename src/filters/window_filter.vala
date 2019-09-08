namespace Pirate_filter.Filters {
    public class WindowFilter : Gtk.Window {
        public WindowFilter (Gtk.WindowType? type = POPUP, Gtk.Image image) {
            Object (type: type);
            set_default_size (600, 600);
            title = "Filter";
            add (create_scroll(image));
            show_all ();
        }

        private Gtk.ScrolledWindow create_scroll (Gtk.Widget w) {
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.show ();
            scroll.hexpand = true;
            scroll.vexpand = true;
            scroll.add (w);
            return scroll;
        }
    }
}
