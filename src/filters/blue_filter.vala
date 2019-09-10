namespace Pirate_filter.Filters {
    public class BlueFilter : Filters.Filter {
        public void apply_filter (Gtk.Image image) {
            var pixbuf_img = image.pixbuf.copy ();
            var bytes_img = pixbuf_img.pixel_bytes.get_data ();
            var new_bytes = new uint8[bytes_img.length];
            int limit;
            if (pixbuf_img.has_alpha)
                limit = 4;
            else
                limit = 3;
            var aux_limit = limit;
            for (int i = 0; i < new_bytes.length; i++) {
                if (limit == 4)
                    if (limit != 2)
                        new_bytes[i] = 0;
                    else
                        new_bytes[i] = bytes_img[i];
                else
                    if (limit != 1)
                        new_bytes[i] = 0;
                    else
                        new_bytes[i] = bytes_img[i];
                limit--;
                if (limit == 0)
                    limit = aux_limit;
            }
            var new_buffer = new Gdk.Pixbuf.from_data (
                new_bytes, pixbuf_img.get_colorspace (),
                pixbuf_img.has_alpha, pixbuf_img.bits_per_sample,
                pixbuf_img.width, pixbuf_img.height, pixbuf_img.rowstride
            );
            var img_blue = new Gtk.Image.from_pixbuf (new_buffer);
            new WindowFilter (Gtk.WindowType.POPUP, img_blue);
        }
    }
}
