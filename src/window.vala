using Gtk;

namespace Pirate_filter {
	public class Window : Gtk.ApplicationWindow {

	    private Toolbar toolbar;
	    private Box content;
	    private Image image;

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
            toolbar = new Toolbar ();
            var open_button = new ToolButton (null, "Open");
            open_button.is_important = true;
            open_button.clicked.connect (create_dialog);
            toolbar.add (open_button);
            open_button.show ();
		}

		private void create_dialog () {
		    var filter = new FileFilter ();
		    var dialog = new FileChooserDialog (
		        "Open Image", this, FileChooserAction.OPEN,
		        ResponseType.CANCEL, "_Cancel", ResponseType.ACCEPT, "_Open"
		    );
		}
	}
}
