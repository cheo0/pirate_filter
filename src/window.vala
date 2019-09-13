namespace PirateFilter {

    /**
     * Main class of the proyect that inherites of // ApplicationWindow //
     */
    public class Window : Gtk.ApplicationWindow {

        delegate void MenuItemAction ();

        Gdk.Pixbuf img_pixbuf;
        Gtk.Image image = new Gtk.Image ();
        Gtk.Box content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        /**
         * Method that creates the main window, defines the size and the
         * content.
         */
        public Window (Gtk.Application app) {
            Object (application: app);
            set_default_size (800, 800);
            set_titlebar (create_headerbar ());
            content.pack_start (create_scroll (image), true, true, 0);
            add (content);
            show_all ();
            destroy.connect (Gtk.main_quit);
        }

        /*
         * Creates a vertical and horizontal scrollbar to scroll
         * through the image.
         */
        Gtk.ScrolledWindow create_scroll (Gtk.Widget w) {
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.show ();
            scroll.vexpand = true;
            scroll.hexpand = true;
            scroll.add (w);
            return scroll;
        }

        /*
         * Creates a header where will be the open button and the
         * filters button.
         * */
        Gtk.HeaderBar create_headerbar () {
            var headbar = new Gtk.HeaderBar ();
            headbar.title = "Pirate filter";
            headbar.pack_start (create_open_button ());
            headbar.pack_end (create_menu_filters ());
            headbar.show_close_button = true;
            headbar.show ();
            return headbar;
        }

        /*
         * Creates an open button to explorer the files and found the image.
         * */
        Gtk.Button create_open_button () {
            var button = new Gtk.Button.from_icon_name ("document-open",
                Gtk.IconSize.SMALL_TOOLBAR);
            button.clicked.connect (on_open_clicked);
            button.show ();
            return button;
        }

        /*
         * Creates a menu button which will counts with three filters;
         *  1. Red Filter.
         *  2. Blue Filter.
         *  3. Green Filter
         * */
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

        /*
         * Method connected with // create_open_button // for open the image
         * with the use of file manager.
         * @var filter Creates a fileFilter from imamge.
         * @var img_chooser Helps to choose the options between:
         *  #Open Image.
         *  #Open.
         *  #Cancel.
         * @var filename = Helps to choose the image.
         * @throws Glib.Error If the user choose a file that is not an image.
         * */
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

        /*
         * Method responsible of apply the red filter, is connected with the
         * menu button.
         * @var red_filter Initializes an object of type Filters which instance
         *  a RedFIlter
         * */
        void red_filter_cb () {
            var red_filter = new Filters.RedFilter ();
            if (img_pixbuf != null)
                red_filter.apply_filter (img_pixbuf);
        }

        /* Method responsible of apply the blue filter, is connected with the
         * menu button.
         * @var red_filter Initializes an object of type Filters which instance
         *  a BlueFIlter
         * */
        void blue_filter_cb () {
            var blue_filter = new Filters.BlueFilter ();
            if (img_pixbuf != null)
                blue_filter.apply_filter (img_pixbuf);
        }

        /* Method responsible of apply the green filter, is connected with the
         * menu button.
         * @var red_filter Initializes an object of type Filters which instance
         *  a GreenFIlter
         * */
        void green_filter_cb () {
            var green_filter = new Filters.GreenFilter ();
            if (img_pixbuf != null)
                green_filter.apply_filter (img_pixbuf);
        }

    }
}
