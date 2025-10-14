#import "/src/lib.typ": list
#import "@preview/toolbox:0.1.0": storage
#set page(width: 5cm, height: auto, margin: 1em)

#storage.add("cfg", (lists: par), namespace: "min-resume")

#list[
  - Foo
  - Bar
  - Baz
]

#list[Foo]

#storage.add("cfg", (lists: list), namespace: "min-resume")

#list[
  - Foo
  - Bar
  - Baz
]

#storage.add("cfg", (lists: enum), namespace: "min-resume")

#list[
  - Foo
  - Bar
  - Baz
]