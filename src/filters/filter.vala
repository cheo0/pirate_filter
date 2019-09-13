namespace PirateFilter.Filters {
    /**
     * Interface that instantiates the method responsible of applying the filters.
     * */
    public interface Filter {
        /**
         * Method that which will instance the correspondent filters.
         * */
        public abstract void apply_filter (Gdk.Pixbuf img);
    }
}
