Amd2Md = () ->
  if Editors.length == 0
    return

  id = ID
  editor = ace.edit("editor#{id}")
  _text = editor.getValue()

  titles = []
  subtitles = []
  smalltitles = []
  indents = []
  md = _text

  _titles = _text.match /^(　+)?【(.*?)】/gm
  _subtitles = _text.match /^(　+)?■(.*)/gm
  _smalltitles = _text.match /^(　+)?・(.*)/gm
  _indents = _text.match /^(　+)?→(.*)/gm

  if _titles
    for title in _titles
      titleBody = title.replace(/^(　+)?【/, '\n# ').replace(/】/, '\n')
      md = md.replace title, titleBody

  if _subtitles
    for subtitle in _subtitles
      subtitleBody = subtitle.replace(/^(　+)?■/, '\n## ')
      md = md.replace subtitle, "#{subtitleBody}\n"

  if _smalltitles
    for smalltitle in _smalltitles
      smalltitleBody = smalltitle.replace(/^(　+)?・/, '')
      md = md.replace smalltitle, "#{smalltitleBody}  "

  if _indents
    for indent in _indents
      indentBody = indent.replace(/^(　+)?→/,'')
      md = md.replace indent, "- #{indentBody}"

  createEditor()
  ace.edit("editor#{ID}").setValue md, -1

  return



module.exports = Amd2Md