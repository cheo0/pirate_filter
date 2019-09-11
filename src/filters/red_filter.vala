namespace PirateFilter.Filters {
    public class RedFilter : Filter {
        public void apply_filter (Gdk.Pixbuf img) {
            var data = img.pixel_bytes.get_data ();
            var new_data = new uint8[data.length];
            int width = img.get_width ();
            int height = img.get_height ();
            int rowstride = img.get_rowstride ();
            var limit = img.has_alpha ? 4 : 3;
            var dif = data.length - ((width * height) * limit);
            for (var y = 0; y < data.length; y += limit) {
                new_data[y] = data[y];
                new_data[y + 1] = 0;
                new_data[y + 2] = 0;
                if (limit == 4)
                    new_data[y + 3] = data[y + 3];
            }
            new WindowFilter (Gtk.WindowType.POPUP, new Gdk.Pixbuf.from_data (
                new_data, img.colorspace, img.has_alpha, img.bits_per_sample,
                width, height, rowstride));
        }
    }
}
