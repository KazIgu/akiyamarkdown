gulp = require 'gulp'
stylus = require 'gulp-stylus'
nib = require 'nib'
pleeease = require 'gulp-pleeease'
path = require('../config').path

gulp.task 'stylus', () ->
  return gulp.src ["#{path.src.stylus}/**/!(_)*.styl"]
    .pipe stylus
      compress: true
      use: nib()
    .pipe pleeease
      fallbacks:
        autoprefixer: ['last 2 version']
        optimizers:
          minifier: true
    .pipe gulp.dest "#{path.dest.css}"

