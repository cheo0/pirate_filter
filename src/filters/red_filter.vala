namespace Pirate_filter.Filters {
    public class RedFilter : Filters.Filter {
        public void apply_filter (Gtk.Image image) {
            var img_pixbuf = image.get_pixbuf ();
            var bytes_data = img_pixbuf.pixel_bytes.get_data ();
            var limit = img_pixbuf.has_alpha ? 4 : 3;
            var aux_limit = limit;
            for (var i = 0; i < bytes_data.length; i++) {
                if (limit != aux_limit)
                    bytes_data[i] = 0;
                limit--;
                if (limit == 0)
                    limit = aux_limit;
            }
            var new_image = new Gtk.Image.from_pixbuf(
                new Gdk.Pixbuf.from_data (
                    bytes_data, img_pixbuf.colorspace, img_pixbuf.has_alpha,
                    img_pixbuf.bits_per_sample, img_pixbuf.width, img_pixbuf.height,
                    img_pixbuf.rowstride
                )
            );
            new Filters.WindowFilter (Gtk.WindowType.POPUP, new_image);
        }
    }
}
