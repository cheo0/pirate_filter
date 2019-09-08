namespace Pirate_filter.Filters {
    public class RedFilter : Filters.Filter {
        public void apply_filter (Gtk.Image image) {
            var pixbuf_img = image.pixbuf.copy ();
            var bytes_img = pixbuf_img.pixel_bytes.get_data ();
            foreach (var i in bytes_img) {
                i = i << 7;
            }
            var new_buffer = new Gdk.Pixbuf.from_data (
                bytes_img, pixbuf_img.get_colorspace (),
                pixbuf_img.has_alpha, pixbuf_img.bits_per_sample,
                pixbuf_img.width, pixbuf_img.height, pixbuf_img.rowstride
            );
            var img_red = new Gtk.Image.from_pixbuf (new_buffer);
            new WindowFilter (Gtk.WindowType.POPUP, img_red);
        }
    }
}
