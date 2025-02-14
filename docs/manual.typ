#import "@preview/min-manual:0.1.0": manual, arg

#show: manual.with(
  title: "Minimal Résumé",
  description: "Simple and professional résumé for professional people.",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  cmd: "min-resume",
  version: "0.1.0",
  license: "MIT",
  logo: image("assets/manual-logo.png")
)


= Quick Start

```typm
#import "@preview/min-resume:0.1.0": resume
#show: manual.resume(
  name: "Your Name",
	title: "Title or Main Occupation",
	photo: image("photo.png"),
	personal: "Relevant personal info",
	birth: (1997, 05, 19),
	address: "Your Address (no street nor house number)",
	email: "example@email.com",
	phone: "+1 (000) 000-0000",
)
```


= Description

Generate modern and direct to the point résumé, fit for today's Human Resources
demands of assertiveness. There is no colorfull designs, figures, creative fonts,
nor anything that diverts attention when reading the document: is just plain old
black sans-serif text in white paper. In fact, if one see only the resulting
résumé, may say it was written in Word, maybe --- but it was written with all of
Typst's benefits and conveniences.

As this package was written by a Brazilian, it was made using some of the
Brazilian practices when writting a résumé --- but it is simple and minimalistic
even to Brazilian standards. Therefore, if some information are missing or 
unnecesary to you, feel free to adapt it to your needs.

This manual will be updated only when new versions break or modify something;
otherwise, it will be valid to all newer versions starting by the one documented
here.


= Options

Those are the full list of options available and its default values:

```typm
#import "@preview/min-manual:0.1.0": manual
#show: manual.with(
  name: none,
  title: none,
  photo: none,
  personal: none,
  birth: none,
  address: none,
  email: none,
  phone: none,
  date: datetime.today(),
  paper: "a4",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.65em,
  par-margin: 1.2em,
  margin: 0.75in,
  font: "Arial",
  font-size: 11.5pt,
  show-country-code: false,
)
```

Seems like an awfull lot to start with, but let's just break down all this to
understand it better, shall we?

#arg(
  "name:", ("string", "content"),
  required: true
)[
  The name of the résumé owner; generally your name, or someone you know.
]

#arg(
  "title:", ("string", "content")
)[
  The résumé owner title or main occupation; keep it short and concise, just one
  line is enough.
]

#arg(
  "photo:", "none"
)[
  A photo of the résumé owner. It is not a trending practice nowadays, but if
  needed is supported.
]

#arg(
  "personal:", ("string", "content")
)[
  Some general personal information, like nationality, or social status, or
  really anything that describes you a little bit.
]

#arg(
  "birth:", ("string", "content")
)[
  Date of birth, in format `(yyyy, mm, dd)`. Used just to calculate the
  age, the datebitselv is not disclosed.
]

#arg(
  "address:", ("string", "content")
)[
  General address --- no street name nor house number needs to be disclosed.
]

#arg(
  "email:", ("string", "content")
)[
  Email address. Will have a _mailto:_ hyperlink to conveniently send emails to
  it.
]

#arg(
  "phone:", "string"
)[
  Phone number, starting with a country code in format `+N` where `N` is a number,
  separated from the phone number itself. Spaces, parenthesis and dashes can be
  freely used as separators inside the number.
  
  For example: `+1 (000) 000-0000`.
]

#arg(
  "date:", "array"
)[
  Defines the document date --- used only to set ```typc document(date)``` option.
]

#arg(
  "show-country-code:", "boolean"
)[
  Defines whether the phone number will be printed as is or without the country
  code. For a domestic résumé this option can be `false`, but it is better to
  set it `true` when creating a résumé for some international job offer.
]

#arg(
  "paper:", "string"
)[
  Defines the page paper type --- and its size therefore.
]

#arg(
  "lang:", "string"
)[
  Defines the language of the written text.
]

#arg(
  "justify:", "boolean"
)[
  Defines if the text will have justified aligment.
]

#arg(
  "line-space:", "length"
)[
  Defines the space between lines in the document.
]

#arg(
  "par-margin:", "length"
)[
  Defines the document margin space after each paragraph. Set it the same as `line-space`
  to remove get paragraphs without additional space in between.
]

#arg(
  "margin:", "length"
)[
  Defines the document margins.
]

#arg(
  "font:", ("string", "array")
)[
  Defines the font families used for the text: a principal font and its falbacks.
]

#arg(
  "font-size:", "length"
)[
  Defines the size of the text in the document.
]


= Letter Command

```typ
#letter(
  enterprise,
  dept: linguify("hr-dept"),
)[
  body
]
```

Adds a professional letter, in its own page.

#arg(
  "enterprise", ("string", "boolean"),
  required: true
)[
  The name of the letter receiver --- an enterprise. If the résumé is created to
  no enterprise in particular, just set it to `true` to generate a letter without
  receiver.
]

#arg(
  "dept:", "string"
)[
  The name used for the enteprise's department which will receive the letter.
]

#arg(
  "body", "content"
)[
  The letter content.
]

#pagebreak()


= Job Experience Command

```typ
#xp(
  role: none,
  place: none,
  time: none
  actual-job: false,
  skills: none,
  skills-list: false,
  skills-sep: "  " + sym.bullet + "  "
)
```

Adds a job experience entry.

#arg(
  "role:", ("string", "content"),
  required: true
)[
  The occupation name or role played in this job.
]

#arg(
  "place:", ("string", "content"),
  required: true
)[
  The place of work or enteprise name.
]

#arg(
  "time:", "array",
  required: true
)[
  The duration of this work expecience, in format `("yyyy-initial", "mm-initial",
  "yyyy-final", "mm-final")`. At least one item, the initial year, must be
  provided and the other values not provided will fallback to the current year
  and month --- thus defining it a current job.
]

#arg(
  "actual-job:", "boolean"
)[
  //TODO: why does this argument even exists?!
]

#arg(
  "skills:", ("string", "content")
)[
  Skills learned and used, as well as goals acomplished. Can be a string or a
  content with a unumbered list (topics) inside, shown as inline topics.
]

#arg(
  "skills-list:", "boolean"
)[
  Forces the list of skills to be shown as standard lists instead of inline
  topics.
]

#arg(
  "skills-sep:", "string"
)[
  Defines the separator for each inline topic item.
]

#pagebreak()


= Education Command

```typ
#edu(
  course: none,
  place: none,
  time: (2025, 1),
  actual-course: false,
  skills: none,
  skills-list: false,
  skills-sep: sym.bullet
)
```

Adds a education entry, like a course or graduation.

#arg(
  "role:", ("string", "content"),
  required: true
)[
  The name of the course or graduation.
]

#arg(
  "place:", ("string", "content"),
  required: true
)[
  The institutuion or university of the course.
]

#arg(
  "time:", "array",
  required: true
)[
  The duration of this course, in format `("yyyy-initial", "mm-initial",
  "yyyy-final", "mm-final")`. At least one item, the initial year, must be
  provided and the other values not provided will fallback to the current year
  and month --- thus defining it a current course.
]

#arg(
  "actual-course:", "boolean"
)[
  //TODO: why does this argument even exists?!
]

#arg(
  "skills:", ("string", "content")
)[
  Skills learned and developed, as well as research and goals acomplished. Can
  be a string or a content with a unumbered list (topics) inside, shown as
  inline topics.
]

#arg(
  "skills-list:", "boolean"
)[
  Forces unumbered list of skills to be shown as standard lists instead of.inline
  topics.
]

#arg(
  "skills-sep:", "string"
)[
  Defines the separator for each inline topic item.
]

#pagebreak()


= Linkedin QR Code Command

Generates a Linkedin profile QR code:

```typ
#linkedin-qrcode(
  user,
  size
)
```

#arg(
  "user", "string"
)[
  The Linkedin username, not the URL. Can be obtained from the profile URL, in
  format `https://www.linkedin.com/in/USERNAME`.
]

#arg(
  "size", "length"
)[
  The size of the QR code created.
]


= Skills Input Command

Allows to insert a list of inline topics

```typ
#skills(
  skills-list: false,
  skills-sep: sym.bullet,
  skills
)[
  body
]
```

#arg(
  "skills:", ("string", "content")
)[
  Skills learned and developed, as well as research and goals acomplished. Can
  be a string or a content with a unumbered list inside, shown as
  inline topics.
]

#arg(
  "skills-list:", "boolean"
)[
  Forces unumbered list of skills to be shown as standard lists instead of inline
  topics.
]

#arg(
  "skills-sep:", "string"
)[
  Defines the separator for each inline topic item.
]

#arg(
  "body", ("string", "content")
)[
  The inline list itself: a string or a content block with a unumbered list inside.
]


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT terms and rights. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the extent
permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.