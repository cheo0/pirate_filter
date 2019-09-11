namespace PirateFilter {
    public class Window : Gtk.ApplicationWindow {

        delegate void MenuItemAction ();

        Gdk.Pixbuf img_pixbuf;
        Gtk.Image image = new Gtk.Image ();
        Gtk.Box content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        public Window (Gtk.Application app) {
            Object (application: app);
            set_default_size (800, 800);
            set_titlebar (create_headerbar ());
            content.pack_start (create_scroll (image), true, true, 0);
            add (content);
            show_all ();
            destroy.connect (Gtk.main_quit);
        }

        Gtk.ScrolledWindow create_scroll (Gtk.Widget w) {
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.show ();
            scroll.vexpand = true;
            scroll.hexpand = true;
            scroll.add (w);
            return scroll;
        }

        Gtk.HeaderBar create_headerbar () {
            var headbar = new Gtk.HeaderBar ();
            headbar.title = "Pirate filter";
            headbar.pack_start (create_open_button ());
            headbar.pack_end (create_menu_filters ());
            headbar.show_close_button = true;
            headbar.show ();
            return headbar;
        }

        Gtk.Button create_open_button () {
            var button = new Gtk.Button.from_icon_name ("document-open",
                Gtk.IconSize.SMALL_TOOLBAR);
            button.clicked.connect (on_open_clicked);
            button.show ();
            return button;
        }

        Gtk.MenuButton create_menu_filters () {
            var menu_filters = new Gtk.MenuButton ();
            var menu = new Gtk.Menu ();
            menu_filters.popup = menu;
            var red_filter = new Gtk.MenuItem.with_label ("Red filter");
            var blue_filter = new Gtk.MenuItem.with_label ("Blue filter");
            var green_filter = new Gtk.MenuItem.with_label ("Green filter");
            red_filter.activate.connect (red_filter_cb);
            blue_filter.activate.connect (blue_filter_cb);
            green_filter.activate.connect (green_filter_cb);
            menu.append (red_filter);
            menu.append (blue_filter);
            menu.append (green_filter);
            menu.show_all ();
            menu_filters.set_image (
                new Gtk.Image.from_icon_name ("emblem-photos",
                                              Gtk.IconSize.SMALL_TOOLBAR));
            menu_filters.show ();
            return menu_filters;
        }

        void on_open_clicked () {
            var filter = new Gtk.FileFilter ();
            var img_chooser = new Gtk.FileChooserDialog ("Open Image", this,
                Gtk.FileChooserAction.OPEN, "_Open", Gtk.ResponseType.ACCEPT,
                "_Cancel", Gtk.ResponseType.CANCEL);
            filter.add_pixbuf_formats ();
            img_chooser.set_filter (filter);
            if (img_chooser.run () == Gtk.ResponseType.ACCEPT) {
                try {
                    var filename = img_chooser.get_filename ();
                    image.set_from_file (filename);
                    img_pixbuf = new Gdk.Pixbuf.from_file (filename);
                    stdout.printf ("\n%d x %d\n", img_pixbuf.width, img_pixbuf.height);
                } catch (GLib.Error err) {
                    stdout.printf ("\nError al leer el archivo.\n");
                }
            }
            img_chooser.destroy ();
        }

        void red_filter_cb () {
            var red_filter = new Filters.RedFilter ();
            if (img_pixbuf != null)
                red_filter.apply_filter (img_pixbuf);
        }

        void blue_filter_cb () {
            var blue_filter = new Filters.BlueFilter ();
            if (img_pixbuf != null)
                blue_filter.apply_filter (img_pixbuf);
        }

        void green_filter_cb () {
            var green_filter = new Filters.GreenFilter ();
            if (img_pixbuf != null)
                green_filter.apply_filter (img_pixbuf);
        }

    }
}
