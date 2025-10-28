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
- header: String
- code: String
- letter:
    to: String
    body: String
- list: Content
- entry:
    title: String
    organization: String
    location: String
    time: [1997, 5]
    skills: Array or String
- linkedin: String
```
The file must be a YAML array, and each array item must be a dictionary with one
and only one key --- mind the indentation for options; the content is generated
in the same order as the array (see `tests/data/data.yaml` file). Multiline YAML
string values are allowed.

/ `header`: Generate a section heading.
/ `code`: Evaluate Typst code from string.
/ `letter`: Generate the professional letter.
/ `list`: Generate a special inline lists.
/ `entry`: Generate a job experience/academic formation entry.
/ `linkedin`: Generate a Linkedin profile QR code.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.