#import "/src/lib.typ"

#let doc = read("/template/main.typ")
#let doc = doc.replace(regex("#import.*?min-resume.*"), "")
#let doc = doc.replace(
  regex("(read|yaml|image)\(\"/?"),
  m => m.captures.at(0) + "(\"/template/"
)
#let doc = doc.replace(".with(", ".with(typst-defaults: true,")

#eval(
  "[" + doc + "]",
  scope: dictionary(lib)
)