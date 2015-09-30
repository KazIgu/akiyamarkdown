path =
  src:
    jade: './src/templates'
    stylus: './src/assets/stylus'
    coffee: './src/assets/coffee'
    image: './src/assets/image'
    font: './src/assets/font'
    vendor: './src/assets/vendor'
    data: './data'

  dest:
    html: './dest/'
    css: './dest/assets/stylesheets'
    js: './dest/assets/javascripts'
    image: './dest/assets/images'
    font: './dest/assets/fonts'
    vendor: './dest/assets/vendor'
    data: './dest/data'


module.exports =
  path: path
