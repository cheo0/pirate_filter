using Gtk;

namespace Pirate_filter {
    public class Window : Gtk.ApplicationWindow {

        /*Variable inicializers*/
        private Image image = new Image ();
        private Box content = new Box (Orientation.VERTICAL, 0);

        /*Builder*/
        public Window (Gtk.Application app) {

            //Define the window size.
            Object (application: app);
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
            scroll.vexpand = true;
            scroll.add (image);
            return scroll;
        }

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
        }
    }
}