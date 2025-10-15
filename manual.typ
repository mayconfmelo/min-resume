// NAME: Manual for min-book

#import "@preview/min-manual:0.2.2": manual, arg, univ, url
#let info = toml("typst.toml").package

#show: manual.with(
  title: "Minimal Résumé",
  package: "min-book:1.3.0",
  description: info.description,
  authors: info.authors,
  license: info.license,
  logo: image("docs/assets/manual-logo.png"),
  from-comments: read("src/lib.typ")
)

= YAML Data Structure <data>
```yaml
- header: Section
- text: Typst code
- letter:
    to: Receiver
    body: Content
- list: Content
- entry:
    title: Name
    organization: Name
    location: Place
    time: [1997, 5]
    skills: List
- linkedin: String
```
The file must be a YAML array, where each item generates a header, Typst code,
or _min-resume_ command, in the same order; each of those items must be a
dictionary with one and only one key; the value of those keys can be a string or
another dictionary (see `tests/data/data.yaml` file).


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.