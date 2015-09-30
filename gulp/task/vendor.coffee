gulp = require 'gulp'
uglify = require 'gulp-uglify'
path = require('../config').path


gulp.task 'vendor', () ->
  return gulp.src ["#{path.src.vendor}/**/*"]
    .pipe uglify()
    .pipe gulp.dest "#{path.dest.vendor}"