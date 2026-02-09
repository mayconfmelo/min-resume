#import "/src/lib.typ": letter
#import "@preview/nexus-tools:0.1.0": storage
#set page(width: 10cm, height: auto, margin: 1em)

#letter(to: "Enterprise Name/Address", lorem(50))

#context raw(
  yaml.encode(storage.get("letter", namespace: "min-resume")),
  lang: "yaml",
)