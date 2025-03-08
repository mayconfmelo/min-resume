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
black sans-serif text in white paper. In fact, if one sees only the resulting
résumé, may say it was written in Word --- but it was written with all of
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
  show-country-code: false,
  letter: (
    enterprise: none,
    dept: auto,
  ),
  skills: (
    display: "inline",
    sep: "  " + sym.bullet + "  ",
  ),
  paper: "a4",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.65em,
  par-margin: 1.2em,
  margin: 0.75in,
  font: "Arial",
  font-size: 11.5pt,
)
```

Seems like an awfull lot to start with, but let's just break down all this to
understand it better, shall we?

#arg("name: <- string | content <required>")[
  The name of the résumé owner; generally your name, or someone you know.
]

#arg("title: <- string | content")[
  The title or main occupation of the résumé owner; keep it short and concise,
  just one line is enough.
]

#arg("photo: <- none")[
  A photo of the résumé owner. It is not a trending practice nowadays, but if
  needed is supported.
]

#arg("personal: <- string | content")[
  Some general personal information, like nationality, or social status, or
  really anything that describes the résumé owner a little bit.
]

#arg("birth: <- array | datetime")[
  Date of birth of résumé owner; an array, in format `(yyyy, mm, dd)`; or a
  proper `#datetime`.
]

#arg("address: <- string | content <required>")[
  General address --- no street name nor house number needs to be disclosed.
]

#arg("email: <- string | content")[
  Email address of the résumé owner. Printed with a _mailto:_ hyperlink to
  conveniently send emails.
]

#arg("phone: <- string")[
  Phone number of the résumé owner, starting with a country code in format
  `+CODE` where `CODE` is a number, separated from the phone number itself.
  Spaces, parenthesis, and dashes can be freely used as separators inside the
  phone number.
  
  US phone example: `+1 (000) 000-0000`.
]

#arg("date: <- array | datetime")[
  Defines the document date --- used only to set ```typc #document(date)``` option.
]

#arg("show-country-code: <- boolean")[
  Defines whether the phone number will be printed as is or without the country
  code. For a domestic résumé this option can be `false`, but it is better to
  set it `true` when creating a résumé for some international job offer.
  
  `show-country-code: false` example: `(000) 000-0000`.
]

#arg("letter: <- dictionary | string | boolean")[
  Global letter configuration; can take a dictionary that must contain:
  
  ```typ
  (enterprise: ENTERPRISE, dept: DEPARTMENT)
  ```
  
  If the value is `STRING`, passes `(enterprise: STRING)`; and if the value is a
  boolean, just hide or show the letter using the default configurations.
]

#arg("skills: <- dictionary | string")[
 Global skills configuration; can take a dictionary that must contain:
  
  ```typ
  (display: MODE, sep: SEPARATOR)
  ```
  
  If the value is `STRING`, passes `(display: STRING)`, where the string must be
  whether `"inline"` or `"list"`.
]

#arg("paper: <- string")[
  Defines the page paper type --- and its size therefore.
]

#arg("lang: <- string")[
  Defines the language of the written text.
]

#arg("justify: <- boolean")[
  Defines if the text will have justified aligment.
]

#arg("line-space: <- length")[
  Defines the space between lines in the document.
]

#arg("par-margin: <- length")[
  Defines the document margin space after each paragraph. Set it the same as `line-space`
  to remove get paragraphs without additional space in between.
]

#arg("margin: <- length")[
  Defines the document margins.
]

#arg("font: <- string | array")[
  Defines the font families used for the text: a principal font and its falbacks.
]

#arg("font-size: <- length")[
  Defines the size of the text in the document.
]


= Letter Command

```typ
#letter(
  body
)
```

Adds a professional letter, in its own page. Receives configuration from
`#resume(letter)` and a letter `body` content.

#arg("letter.enterprise <- string | boolean")[
  Received from `#resume`. The name of the letter receiver --- an enterprise. If
  the résumé is created to no enterprise in particular, just set it to `true` to
  generate a letter without receiver; `false` hides the letter.
]

#arg("letter.dept: <- auto | string | content")[
  Received from `#resume`. The name used for the enteprise's department which
  will receive the letter. If set as `auto`, try to automatically retrieve
  the appropriate name for _Human Resources Department_ in `text.lang`, or
  fallback to English if not found.
]

#arg("body <- content")[
  The letter content.
]


= Job Experience Command

```typ
#xp(
  role: none,
  place: none,
  time: none,
  skills: none,
  config: none,
)
```

Adds a job experience entry. Receives configuration from `#resume(skills)` and
some aeguments on its own.

#arg("role: <- string | content <required>")[
  The occupation name or role played in this job.
]

#arg("place: <- string | content <required>")[
  The place of work or enteprise name.
]

#arg("time: <- array <required>")[
  The duration of this work expecience, in format \
  `(YYYY-INITIAL, MM-INITIAL, YYYY-FINAL, MM-FINAL)`, where at least the
  `YYYY-INITIAL` must be provided, and all omitted values will fallback to the
  current year and month --- thus defining it a current job.
]

#arg("skills: <- string | content")[
  Skills learned and used, as well as goals acomplished. Can be a string or a
  content with a unumbered list (topics) inside, shown as inline topics by
  default.
]

#arg("config: <- dictionary | none")[
  Locally override any global configurations received by `#resume(skills)`.
  Applicable to the current `#xp` only.
]

#arg(
  "skills.display: <- string"
)[
  Received from `#resume(skills)`. Make the skills list an `"inline"` topic list
  (saves space) or a proper `"list"`. Can be overriden using the
  `config: (display)` argument.
]

#arg(
  "skills.sep: <- string | content"
)[
  Received from `#resume(skills)`. Defines the separator for each inline topic
  item (when `display: "inline"`). Can be overriden using the `config: (sep)`
  argument.
]


= Education Command

```typ
#edu(
  course: none,
  place: none,
  time: none,
  skills: none,
  config: none,
)
```

Adds an education entry, like a course or graduation. Receives configuration
from `#resume(skills)` and some arguments on its own.

#arg("course: <- string | content <required>")[
  The course or graduation name.
]

#arg("place: <- string | content <required>")[
  The educational institution where the course or graduation take place.
]

#arg("time: <- array <required>")[
  The duration of this course or graduation, in format \
  `(YYYY-INITIAL, MM-INITIAL, YYYY-FINAL, MM-FINAL)`, where at least the
  `YYYY-INITIAL` must be provided, and all omitted values will fallback to the
  current year and month --- thus defining it a current course or graduation.
]

#arg("skills: <- string | content")[
  Skills learned and used, as well as goals acomplished. Can be a string or a
  content with a unumbered list (topics) inside, shown as inline topics by
  default.
]

#arg("config: <- dictionary | none")[
  Locally override any global configurations received by `#resume(skills)`.
  Applicable to the current `#xp` only.
]

#arg(
  "skills.display: <- string"
)[
  Received from `#resume(skills)`. Make the skills list an `"inline"` topic list
  (saves space) or a proper `"list"`. Can be overriden using the
  `config: (display)` argument.
]

#arg(
  "skills.sep: <- string | content"
)[
  Received from `#resume(skills)`. Defines the separator for each inline topic
  item (when `display: "inline"`). Can be overriden using the `config: (sep)`
  argument.
]


= Linkedin QR Code Command

```typ
#linkedin-qrcode(
  user,
  size
)
```

Generates a Linkedin profile QR code.

#arg("user <- string")[
  The Linkedin username, not the URL. Can be obtained from the profile URL, in
  format `https://www.linkedin.com/in/USERNAME`.
]

#arg("size <- length")[
  The size of the QR code created.
]


= Skills Input Command

```typ
#skills(
  config: none,
  skill-list,
)
```

Allows to insert an arbitrary skill list. Receives configuration from
`#resume(skills)` and some arguments on its own.

#arg("config: <- dictionary | none")[
  Locally override any global configurations received by `#resume(skills)`.
  Applicable to the current `#skills` only.
]

#arg(
  "skills.display: <- string"
)[
  Received from `#resume(skills)`. Make the skills list an `"inline"` topic list
  (saves space) or a proper `"list"`. Can be overriden using the
  `config: (display)` argument.
]

#arg(
  "skills.sep: <- string | content"
)[
  Received from `#resume(skills)`. Defines the separator for each inline topic
  item (when `display: "inline"`). Can be overriden using the `config: (sep)`
  argument.
]

#arg("skill-list: <- string | content")[
  Skills learned and used, as well as goals acomplished. Can be a string or a
  content with a unumbered list (topics) inside, shown as inline topics by
  default.
]


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT terms and rights. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the extent
permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.