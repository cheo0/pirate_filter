
namespace PirateFilter {
    public class Window : Gtk.ApplicationWindow {

<<<<<<< HEAD
        /*Variable inicializers*/
        private Image image = new Image ();
        private Box content = new Box (Orientation.VERTICAL, 0);
=======
        delegate void MenuItemAction ();

        Gdk.Pixbuf img_pixbuf;
        Gtk.Image image = new Gtk.Image ();
        Gtk.Box content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
>>>>>>> window_cheo

        /*Builder*/
        public Window (Gtk.Application app) {

            //Define the window size.
            Object (application: app);
<<<<<<< HEAD
            this.set_default_size(600, 600);

            //Adds items and show them in the window.
            content.pack_start (create_toolbar(), false, true, 0);
            content.pack_start (create_scroll(), true, true, 0);
            this.add (content);
            this.show_all ();
            this.destroy.connect (main_quit);
        }

        /*Creates a vertical and horizontal scroll bar for help in the
         * image scrolling. */
        private ScrolledWindow create_scroll () {
            var scroll = new ScrolledWindow (null, null);
            scroll.show ();

            //Horizontal scroll bar.
            scroll.hexpand = true;

            //Vertical scroll bar.
=======
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
>>>>>>> window_cheo
            scroll.vexpand = true;
            scroll.hexpand = true;
            scroll.add (w);
            return scroll;
        }

<<<<<<< HEAD
        /*Creates a set of functional buttons.*/
        private Toolbar create_toolbar () {

            //Define the toolbar for their next use.
            var toolbar = new Toolbar ();
            toolbar.get_style_context ()
                .add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);

            //Adds the buttons to the toolbar and show them.
            toolbar.add (create_toolbutton ());
            toolbar.add (create_menu_button());
            toolbar.show ();
            return toolbar;
        }

        /*Creates the toolbutton. Their use will focus in open the image*/
        private ToolButton create_toolbutton (){
            var open_button = new ToolButton (null, "Open");

            //Enables the button and connect with the auxiliar method
            //for open the image.
            open_button.is_important = true;
            open_button.clicked.connect (on_open_clicked);
            return open_button;
        }

        /*Creates the menu button for deploy the filters that we
         * will use.*/
        private MenuToolButton create_menu_button () {

            //Define the menu button.
            var filters_menu = new MenuToolButton (null, "Filters");

            //Define the menu. Here the menu options will be added.
            var model = new GLib.Menu ();

            //Buttons adds to the menu.
            model.append ("Red filter", "win.red");
            model.append ("Blue filter", "win.blue");
            model.append ("Green filter", "win.green");
            filters_menu.set_menu (new Gtk.Menu.from_model(model));
            return filters_menu;
        }


        /*Auxiiar method that help in open the necessary image since
         * the computer files.*/
        private void on_open_clicked (ToolButton self) {

            //Define what the button will do once the files are opened.
            var dialog = new FileChooserDialog (
                "Open Image", this, FileChooserAction.OPEN, "_Open",
                ResponseType.ACCEPT, "_Cancel", ResponseType.CANCEL
            );
            if (dialog.run () == ResponseType.ACCEPT)
                image.set_from_file (dialog.get_filename ());
            dialog.destroy ();
=======
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
>>>>>>> window_cheo
        }

    }
}