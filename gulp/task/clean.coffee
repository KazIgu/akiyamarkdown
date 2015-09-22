gulp = require 'gulp'
clean = require 'gulp-clean'
path = require('../config').path


gulp.task 'clean', ['clean:html', 'clean:js', 'clean:css', 'clean:image']

gulp.task 'clean:html', () ->
  gulp.src ["#{path.dest.html}/**/*.html"]
    .pipe clean()

gulp.task 'clean:js', () ->
  gulp.src ["#{path.dest.js}/**/*.js"]
    .pipe clean()

gulp.task 'clean:css', () ->
  gulp.src ["#{path.dest.css}/**/*.css"]
    .pipe clean()

gulp.task 'clean:image', () ->
  gulp.src ["#{path.dest.image}/**/*"]
    .pipe clean()

