gulp = require 'gulp'
imgmin = require 'gulp-imagemin'
path = require('../config').path


gulp.task 'image', () ->
  return gulp.src ["#{path.src.image}/**/*"]
    .pipe imgmin
      progressive: true
      # optimizationLevel: 7
    .pipe gulp.dest "#{path.dest.image}"