using Gtk;

namespace Pirate_filter {
    public class Window : Gtk.ApplicationWindow {

        private Image image = new Image ();
        private Box content = new Box (Orientation.VERTICAL, 0);

        public Window (Gtk.Application app) {
            Object (application: app);
            this.set_default_size(600, 600);
            content.pack_start (create_toolbar(), false, true, 0);
            content.pack_start (create_scroll(), true, true, 0);
            this.add (content);
            this.show_all ();
            this.destroy.connect (main_quit);
        }

        private ScrolledWindow create_scroll () {
            var scroll = new ScrolledWindow (null, null);
            scroll.show ();
            scroll.hexpand = true;
            scroll.vexpand = true;
            scroll.add (image);
            return scroll;
        }

        private Toolbar create_toolbar () {
            var toolbar = new Toolbar ();
            var open_button = new ToolButton (null, "Open");
            toolbar.get_style_context ()
                .add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
            open_button.is_important = true;
            toolbar.add (open_button);
            toolbar.add (create_menu_button());
            open_button.clicked.connect (on_open_clicked);
            toolbar.show ();
            return toolbar;
        }

        private MenuToolButton create_menu_button () {
            var filters_menu = new MenuToolButton (null, "Filters");
            var model = new GLib.Menu ();
            model.append ("Red filter", "win.red");
            model.append ("Blue filter", "win.blue");
            model.append ("Green filter", "win.green");
            filters_menu.set_menu (new Gtk.Menu.from_model(model));
            return filters_menu;
        }

        private void on_open_clicked (ToolButton self) {
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
