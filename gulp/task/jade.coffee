gulp = require 'gulp'
rawJade = require 'jade'
jade = require 'gulp-jade'

path = require('../config').path

gulp.task 'jade', () ->
  return gulp.src ["#{path.src.jade}/views/**/!(_)*.jade"]
    .pipe jade
      jade: rawJade
      basedir: path.src.jade
    .pipe gulp.dest "#{path.dest.html}"
