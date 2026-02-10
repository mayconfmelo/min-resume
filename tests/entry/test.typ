#import "/src/lib.typ": entry
#import "@preview/nexus-tools:0.1.0": storage
#import "@preview/transl:0.2.0": transl
#set page(width: 15cm, height: auto, margin: 1em)

#storage.add("cfg",
  (entry-time-calc: true, entry-dates: "MMM/yyyy", entry-period: true, lists: par),
  append: true, namespace: "min-resume"
)
#transl(data: yaml("/src/assets/lang.yaml"))
#let today = datetime.today()

#entry(
	title: "Title",
	organization: "Organization",
	location: "Location",
  time: (from: (2024, 2), to: (2025, 7, 4)), 
	skills: [
	  - Foo
	  - Bar
	  - Baz
	],
)
#entry(
	title: "Title",
	organization: "Organization",
  time: (from: (2020, 2), to: (2025, 1)),
)