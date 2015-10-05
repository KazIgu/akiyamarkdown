Md2Amd = () ->
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

  _titles = _text.match /^#\s(.*)/gm
  _subtitles = _text.match /^##\s(.*)/gm
  _smalltitles = _text.match /^(.*)(\x20\x20)$/gm
  _indents = _text.match /^\-\s(.*)/gm

  for title in _titles
    titleBody = title.replace(/^#\s/, '')
    md = md.replace "\n#{title}\n", "【#{titleBody}】"
    md = md.replace title, "【#{titleBody}】"

  for subtitle in _subtitles
    subtitleBody = subtitle.replace(/\n##\s/, '')
    md = md.replace subtitle, "■#{subtitleBody}\n"

  for smalltitle in _smalltitles
    smalltitleBody = smalltitle.replace(/\x20\x20/, '')
    md = md.replace smalltitle, "・#{smalltitleBody}"

  for indent in _indents
    indentBody = indent.replace(/^\-\s/,'→')
    md = md.replace indent, "　#{indentBody}"

  createEditor()
  ace.edit("editor#{ID}").setValue md, -1

  return

module.exports = Md2Amd