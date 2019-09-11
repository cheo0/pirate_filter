namespace PirateFilter.Filters {
    public class GreenFilter : Filter {
        public void apply_filter (Gdk.Pixbuf img) {
            stdout.printf ("\nSi entro\n");
            var data = img.pixel_bytes.get_data ();
        }
    }
}
