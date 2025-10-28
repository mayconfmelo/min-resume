#import "/src/lib.typ": entry
#import "@preview/toolbox:0.1.0": storage
#import "@preview/transl:0.1.1": transl
#set page(width: 15cm, height: auto, margin: 1em)

#storage.add("cfg", (entry-time-calc: true), append: true, namespace: "min-resume")
#storage.add("cfg", (lists: par), append: true, namespace: "min-resume")
#transl(data: yaml("/src/assets/lang.yaml"))
#let today = datetime.today()

#entry(
	title: "Title",
	organization: "Organization",
	location: "Location",
  time: (2024, 2, 2025, 7), 
	skills: [
	  - Foo
	  - Bar
	  - Baz
	],
)
#entry(
	title: "Title",
	organization: "Organization",
  time: (2020, 2, 2025, 1),
)