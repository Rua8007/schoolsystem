# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Rails.application.config.assets.precompile += %w( codeprettifier/prettify.js )
# Rails.application.config.assets.precompile += %w( easypiechart/jquery.easypiechart.min.js )
# Rails.application.config.assets.precompile += %w( sparklines/jquery.sparklines.min.js )
# Rails.application.config.assets.precompile += %w( form-toggle/toggle.min.js )
# Rails.application.config.assets.precompile += %w( fullcalendar/fullcalendar.min.js )
# Rails.application.config.assets.precompile += %w( form-daterangepicker/daterangepicker.min.js )
# Rails.application.config.assets.precompile += %w( form-daterangepicker/moment.min.js )
# Rails.application.config.assets.precompile += %w( charts-flot/jquery.flot.min.js )
# Rails.application.config.assets.precompile += %w( charts-flot/jquery.flot.resize.min.js )
# Rails.application.config.assets.precompile += %w( charts-flot/jquery.flot.orderBars.min.js )
# Rails.application.config.assets.precompile += %w( pulsate/jQuery.pulsate.min.js )
# Rails.application.config.assets.precompile += %w( demo-index.js )
# Rails.application.config.assets.precompile += %w( demo.js )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( form-daterangepicker/daterangepicker-bs3.css )
# Rails.application.config.assets.precompile += %w( fullcalendar/fullcalendar.css )
# Rails.application.config.assets.precompile += %w( form-markdown/css/bootstrap-markdown.min.css )
# Rails.application.config.assets.precompile += %w( codeprettifier/prettify.css )
# Rails.application.config.assets.precompile += %w( form-toggle/toggles.css )


Rails.application.config.assets.precompile += %w( externals/*.js externals/*.css *.js *.css *.woff *.ttf *.eot *.svg)

Rails.application.config.assets.paths<< Rails.root.join('app', 'assets', 'fonts')


# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )
# Rails.application.config.assets.precompile += %w( variations/default.css )

