
int main (string[] args) {
    var app = new Gtk.Application ("com.dinamita.filters", ApplicationFlags.FLAGS_NONE);
    app.activate.connect (() => {
        var win = app.active_window;
        if (win == null) {
            win = new Pirate_filter.Window (app);
        }
        win.present ();
    });

    return app.run (args);
}
