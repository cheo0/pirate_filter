namespace PirateFilter.Filters {

    /**
     * Class that inherites from // Filter // for applies the red filter in
     * the image.
     * */
    public class RedFilter : Filter {

        /**
         * Method that instance from // Filter // and especifies how will
         * apllies the red filter. Creates a bytes array. After if has alpha,
         * will divide them in a package of arrays of 4 places, otherwise will
         * package them in arrays of 3 places. Followed inmediately will go over
         * the arrays and will see what byte is the blue and green byte and will put
         * their value in 0.
         * @param img The image that will applies the filter.
         * */
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

