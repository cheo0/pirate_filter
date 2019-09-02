
namespace Pirate_filter {
	public class Window : Gtk.ApplicationWindow {

		public Window (Gtk.Application app) {
			Object (application: app);
			this.set_default_size(600, 600);
		}
	}
}
