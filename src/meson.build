pirate_filter_sources = [
  'main.vala',
  'window.vala',
  'app.vala',
  'namespace.vala',
  'filters/filter.vala',
  'filters/namespace.vala',
  'filters/red_filter.vala',
  'filters/window_filter.vala',
  'filters/blue_filter.vala',
  'filters/green_filter.vala'
]

pirate_filter_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

pirate_filter_sources += gnome.compile_resources('pirate_filter-resources',
  'pirate_filter.gresource.xml',
  c_name: 'pirate_filter'
)

executable('pirate_filter', pirate_filter_sources,
  vala_args: '--target-glib=2.50',  dependencies: pirate_filter_deps,
  install: true,
)
