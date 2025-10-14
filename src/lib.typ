// NAME: Minimal Résumé
// TODO: Implement web résumé (HTML) when stable

#let resume(
  name: none,
  title: none,
  photo: none,
  info: none,
  birth: none,
  address: none,
  email: none,
  phone: none,
  data: (:),
  cfg: (:),
  translation: yaml("assets/lang.yaml"),
  typst-defaults: false,
  body
) = context {
  assert.ne(name, none, message: "#resume(name) required")
  assert.ne(address, none, message: "#resume(address) required")
  assert.eq(type(cfg), dictionary, message: "#resume(cfg) must be a dictionary")
  
  import "@preview/toolbox:0.1.0": storage, default, get, its
  import "@preview/transl:0.1.1": transl
  
  let birth = birth
  let font-size = default(
    when: text.size == 11pt,
    value: 12pt,
    otherwise: text.size,
    typst-defaults
  )
  let cfg = (
    country-code: false,
    letter-show: true,
    lists: par,
    entry-time-calc: true,
    data-assets: (:)
  ) + cfg
  
  storage.add("cfg", cfg, namespace: "min-resume")
  
  transl(data: translation)
  
  set document(
    title: name + " - " + title,
    author: name,
    date: datetime.today(),
  )
  set page(
    ..default(
      when: page.margin == auto,
      value: (margin: 2cm),
      typst-defaults
    ),
    header: context if locate(here()).page() > 2 {
      // Name and title in header after 1st page
      align(
        right,
        text(font-size - 2pt)[#name\ #title]
      )
    },
  )
  set par(
    ..default(
      when: not par.justify,
      value: (justify: true),
      typst-defaults
    ),
    ..default(
      when: par.leading == 0.65em,
      value: (leading: 0.6em),
      typst-defaults
    ),
  )
  set text(
    size: font-size,
    ..default(
      when: text.font == "libertinus serif",
      value: (font: ("Tex Gyre Heros", "Arial")),
      typst-defaults
    ),
    ..default(
      when: text.hyphenate == auto,
      value: (hyphenate: true),
      typst-defaults
    ),
  )
  set terms(separator: [: ], tight: true)
  set underline(offset: 3pt)
  
  show quote: set pad(x: 1em)
  show heading: set text(
    size: font-size + 1pt,
    ..default(
      when: text.font == "libertinus serif",
      value: (font: ("tex gyre adventor", "century gothic")),
      typst-defaults
    ),
  )
  show heading: set block(
    above: par.spacing,
    below: par.spacing,
  )
  
  // Main header
  {
    set align(center)
    
    text(name, size: 1.3em, weight: "bold")
    linebreak()
    title
  }
  v(0.5em)
  
  // Personal info
  let personal
  
  if info != none {
    personal += info
    personal += if birth != none {", "} else {"."}
  }
  if birth != none {
    let birth = get.date(..birth)
    let curr = datetime(
      year: datetime.today().year(),
      month: birth.month(),
      day: birth.day()
    )
    let age = datetime.today().year() - birth.year()
    
    if curr > datetime.today() {age -= 1}
    
    personal += str(age) + " "
    personal += transl("years-old") + "."
  }
  if info != none or birth != none {personal += linebreak()}
  personal += address + "." + linebreak()
  if email != none {personal += link("mailto:" + email) + linebreak()}
  if phone != none {
    let display = phone
    let url = "https://wa.me/" + phone.replace(regex("[^0-9]"), "")
        
    // Remove country code from phone number
    if cfg.country-code == false {
      let country-code = phone.find(regex("^\+(\d+)"))
      display = phone.replace(country-code, "")
    }
    
    personal += link(url, display)
  }
  
  grid(
    columns: (4.8em, 1fr),
    block(photo, height: 4.8em, inset: 0pt, outset: 0pt),
    align(right, personal),
  )
  
  if data != (:) {
    assert.eq(type(data), dictionary, message: "#resume(data) must be dictionary")
    assert.eq(type(data.doc), array, message: "#resume(data.doc)")
    
    import "lib.typ" as self
    
    let eval = eval.with(
      scope: dictionary(self) + cfg.data-assets,
      mode: "markup"
    )
      
    for elem in data.doc {
      assert.eq(type(elem), dictionary, message: "#resume(data.doc.elem)")
      assert.eq(
        elem.len(), 1,
        message: "Element data." + elem.keys().at(0) + " has more than 1 key"
      )
      
      let kind = elem.keys().join()
      let data = elem.at(kind)
      
      if kind == "hide" {continue}
      
      if kind == "header" {heading(level: 1, data)}
      else if kind == "text" {eval(data)}
      else if kind == "entry" {
        if data.at("skills", default: "") != "" {
          data.skills = eval(data.skills)
        }
        self.entry(..data)
      }
      else if kind == "list" {self.list(eval(data))}
      else if kind == "linkedin" {self.linkedin(data)}
      else if kind == "letter" {self.letter(eval(data.remove("body")), ..data)}
      else {panic("Invalid data kind: " + kind)}
    }
  }
  
  body
  
  storage.namespace("min-resume")

  context if not its.empty( storage.final("letter", (:)) ) {
    let stored = storage.final("letter", (:))
    
    if cfg.letter-show {
      import "@preview/datify:1.0.0": custom-date-format
      
      set text(hyphenate: false)
      set par(justify: false)
      
      if stored.to == none {stored.to = transl("hr-dept") + "."}
      
      pagebreak()
      
      grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        stored.to,
        {
          set align(right)
          
          name
          linebreak()
          if title != none {
            title
            linebreak()
          }
          address
        }
      )
      
      v(2em)
      
      custom-date-format(
        datetime.today(),
        pattern: "long",
        lang: text.lang,
      ) + "."
      
      parbreak()
      
      stored.body
    }
  }
}


// Generate a professional letter.
#let letter(
  to: none,
  display: true,
  body
) = context {
  import "@preview/toolbox:0.1.0": storage

  let data = (
    body: body,
    to: to,
  )
  
  storage.add("letter", data, append: true, namespace: "min-resume")
}


#let list(body) = context {
  import "@preview/toolbox:0.1.0": storage
  import "origin.typ"
  
  let mode = storage.get("cfg", namespace: "min-resume").lists
  let items = ()
  let sep = [ #sym.bullet ]
  
  if type(body) == str {return body}
  else if body.has("text"){return body.text}
  else {
    for child in body.children {
      if child.has("body") {
        items.push(child.body)
      }
    }
  }
  
  if mode == par {items.join(sep)}
  else if mode == list or mode == origin.list {origin.list(..items)}
  else if mode == enum {enum(..items)}
  else {
    panic("Invalid #resume(cfg.lists) mode: " + repr(mode))
  }
}


// Insert a professional experience entry.
#let entry(
  title: none,
  organization: none,
  location: none,
  time: (),
  skills: none,
) = context {
  assert.ne(title, none, message: "#entry(title) required")
  assert.ne(organization, none, message: "#entry(organization) required")
  assert(
    time.len() == 2 or time.len() == 4,
    message: "#entry(time) must be (YYYY, DD) or (YYYY, DD, YYYY, DD)"
  )
  
  import "@preview/transl:0.1.1": transl
  import "@preview/toolbox:0.1.0": get, storage
  import "@preview/datify:1.0.0": custom-date-format
  
  let today = datetime.today()
  let end = ()
  let start = ()
  let diff
  
  start.push(time.at(0))
  start.push(time.at(1))
  start.push(1)
  start = get.date(..start)
  
  end.push( time.at(2, default: today.year()) )
  end.push( time.at(3, default: today.month()) )
  end.push(2)
  end = get.date(..end)
  
  strong(title) + ", "
  emph(organization)
  linebreak()
  
  if (today - end).weeks() < 4 {
    let since = transl("since", mode: str)
    
    upper(since.at(0)) + since.slice(1) + " "
  }
  
  custom-date-format(start, pattern: "MMM/yyyy")
  
  if (today - end).weeks() > 4 {
    " " + transl("to") + " "
    custom-date-format(end, pattern: "MMM/yyyy")
  }
  
  if storage.get("cfg", namespace: "min-resume").entry-time-calc {
    let weeks = (end - start).weeks()
    let years = int(weeks / 52)
    let months = int( (weeks - (years * 52)) / 4 )
    
    " ("
    if years > 0 {
      let key = "year" + if years != 1 {"s"}
      
      str(years) + " "
      transl(key) + " "
      if months > 0 {transl("and") + " "}
    }
    if months > 0 {
      let key = "month" + if months != 1 {"s"}
      
      str(months) + " "
      transl(key)
    }
    ")"
  }
  "."
  
  if location != none {" " + location + "."}
  linebreak()
  
  if skills != none {text(size: 1em - 1pt, list(skills))}
  
  parbreak()
}


// Generate a Linkedin QR code:
#let linkedin(user) = {
  import "@preview/tiaoma:0.3.0": qrcode
  
  set align(center)
  
  let url = "https://www.linkedin.com/in/" + user
  let img = {
    qrcode(
      url,
      options: (
        scale: 1.3,
        option-1: 3
      )
    )
    
    place(
      center + horizon,
      block(
        height: 0.7cm,
        width: 0.7cm,
        image("assets/linkedin.png")  
      )
    )
  }
  
  block(
    link(url, img),
    width: 100%,
    above: 1fr,
    below: 1fr
  )
}