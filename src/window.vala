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
            toolbar.get_style_context ()
                .add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
            var open_button = new ToolButton (null, "Open");
            open_button.is_important = true;
            toolbar.add (open_button);
            open_button.clicked.connect (on_open_clicked);
            open_button.show ();
            return toolbar;
        }

        private void on_open_clicked () {
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
