using Gtk;

namespace Pirate_filter {
	public class Window : Gtk.ApplicationWindow {

	    private Toolbar toolbar;
	    private Box content;
	    private Image image;
	    Gtk.ToolButton open_button;
	    private TextView text_view;

        /*
         * Constructor.
         * */
		public Window (Gtk.Application app) {
			Object (application: app);
			this.set_default_size(600, 600);

			content = new Box (Orientation.VERTICAL, 0);
			image = new Image ();
			create_toolbar ();
			content.pack_start (image);
			content.pack_start (toolbar, false, true, 0);
			this.add (content);
			this.show_all ();
			this.destroy.connect (main_quit);
		}

		private void create_toolbar () {
            toolbar = new Gtk.Toolbar ();
            toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);

            /*
             * Creates the toolbutton for open the image.
             * */
            open_button = new Gtk.ToolButton (null, "Open");
            open_button.is_important = true;
            toolbar.add (open_button);
            open_button.clicked.connect (create_dialog);
            open_button.show ();

		}

		private void create_dialog () {
		    var image_chooser = new FileChooserDialog (
		        "Open Image", this, FileChooserAction.OPEN,
		        "_Cancel", ResponseType.CANCEL,"_Open", ResponseType.ACCEPT
		    );
		    if (image_chooser.run () == ResponseType.ACCEPT) {
		        open_file (image_chooser.get_filename ());
		    }
		    image_chooser.destroy ();
        }

        private void open_file (string filename) {
            try {
                string text;
                FileUtils.get_contents (filename, out text);
                this.text_view.buffer.text = text;
            } catch (Error e) {
                stderr.printf ("Error: %s\n", e.message);
            }
	    }
    }
}