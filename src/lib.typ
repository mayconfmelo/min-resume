// NAME: Minimal Résumé
// REQ: linguify, icu-datetime, tiaoma
// TODO: refactor config system
// TODO: Implement web résumé (HTML) when stable

#import "@preview/linguify:0.4.2": linguify, set-database

#let resume-name-state = state("resume-name")
#let resume-title-state = state("reume-title")
#let resume-lang-data-state = state("resume-lang-data")
#let resume-config-state = state("resume-config")

#let resume(
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
  letter: true,
  skills: "inline",
  paper: "a4",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.6em,
  par-margin: 1.2em,
  margin: 0.75in,
  font: "Arial",
  font-size: 11.5pt,
  body
) = {
  // Required arguments
  let req = (
    name: name,
    address: address
  )
  for arg in req.keys() {
    if req.at(arg) == none {
      panic("Missing required argument: " + arg)
    }
  }
  
  // Temporary config data
  let config = (
    letter: letter,
    skills: skills,
  )
  
  if type(config.letter) == bool {
    config.letter = (print: config.letter)
  }
  else if type(config.letter) != dictionary {
    config.letter = (enterprise: config.letter)
  }
  
  if type(config.skills) == str {
    config.skills = (display: config.skills)
  }
  else if type(config.skills) != dictionary {
    config.skills = (:)
  }

  // State updates:
  resume-config-state.update(config)
  resume-name-state.update(name)
  resume-title-state.update(title)
  resume-lang-data-state.update(lang-data)
  
  // Transform (yyyy, mm, dd) date into datetime:
  if type(date) == array {
    date = datetime(
      year: int(date.at(0)),
      month: int(date.at(1)),
      day: int(date.at(2))
    )
  }
  else if type(date) != datetime {
    panic("Invalid #resume(date) value: must be an array or datetime")
  }
  
  set document(
    title: name + " - " + title,
    author: name,
    date: date,
  )
  set page(
    paper: paper,
    margin: margin,
    header: context if locate(here()).page() > 1 {
      // Name and title in header after 1st page
      align(right)[#name #linebreak() #title]
    }
  )
  set par(
    justify: justify,
    leading: line-space,
    spacing: par-margin,
  )
  set text(
    font: font,
    size: font-size,
    lang: lang,
    hyphenate: true,
  )
  set terms(separator: [: ], tight: true)
  
  show quote: set pad(x: 1em)
  show heading: set text(size: font-size + 1pt)
  
  // Set linguify database
  set-database(lang-data)
  
  // Main header
  align(center)[
    #heading(
      level: 1,
      text(size: 1.3em, weight: "bold", name)
    )
    #title
  ]
  v(0.5em)
  
  // Insert photo, if any
  if type(photo) == content {
    box(
      width: 5em,
      height: 5em,
      inset: 0pt,
      outset: 0pt,
      photo
    )
  }

  box(
    width: 1fr,
    height: 5em,
    inset: 0pt,
    outset: 0pt,
  )[
    #align(right + top)[
      // Relevant personal information, if any
      #if personal != none {
        personal
        
        if birth != none {
          ","
        }
        else {
          "."
        }
      }
      // Age calculation using birth date, if any:
      #if birth != none {
        // Transform (yyyy, mm, dd) into datetime
        if type(birth) == array {
          birth = datetime(
            year: birth.at(0),
            month: birth.at(1),
            day: birth.at(2)
          )
        }
        else if type(birth) != datetime {
          panic("Invalid birth argument: " + birth)
        }
        
        // This year's birthday:
        let birthday = datetime(
          year: datetime.today().year(),
          month: birth.month(),
          day: birth.day()
        )
        
        // Age if yet to commemorate birthday this year:
        if birthday > datetime.today() {
          str(datetime.today().year() - birth.year() - 1)
        }
        // Age if already commemorated birthday this year:
        else {
          str(datetime.today().year() - birth.year())
        }

        [ #linguify("years-old").]
      }
      #if personal != none or birth != none { linebreak() }
      #address
      #linebreak()
      #if email != none {
        link("mailto:" + email)
        linebreak()
      }
      #if phone != none {
        let phone-display = phone
        
        // Remove country code from phone number
        if show-country-code == false {
          let country-code = phone.find(regex("^\+(\d+)"))
          phone-display = phone.replace(country-code, "")
        }
        
        // Phone number with WhatsApp link
        link(
          "https://wa.me/" +
          phone.replace(regex("[ \+\-\(\)]+"), "")
        )[#phone-display]
      }
    ]
  ]
  
  // Heading formatting for résumé body
  show heading: set block(above: par-margin, below: par-margin)
  show heading: it => upper(it)
  
  body
}


// Set global configurations (contextual)
// TODOC: set-config()
#let set-config(
  ..cfg
) = context {
  // Ignores positional arguments
  let cfg = cfg.named()
  
  // Set new cfg, if any
  if cfg.len() > 0 {
    // Copies the config state
    let config = resume-config-state.get()
    
    // Insert cfg into copied config state
    for (key, value) in cfg.pairs() {
      if type(value) == dictionary {
        for val in value.pairs() {
          config.at(key).insert(..val)
        }
      }
      else {
        config.insert(key, value)
      }
    }
    
    [#config]
    // Substitute config state to tue locally modified state
    //resume-config-state.update(config)
  }
}


// Generate a professional letter.
#let letter(
  body
) = context {
  let cfg = resume-config-state.get().letter

  if cfg.at("print", default: true) == true {
    import "@preview/icu-datetime:0.1.2": fmt-date
    
    // Remove résumé header:
    set page(header: none)
    
    pagebreak(weak:true)
    
    // Letter receiver, if any:
    box(width: 1fr)[
      #if type(cfg.at("enterprise", default: none)) != none {
        cfg.enterprise
        linebreak()
        if cfg.at("dept", default: auto) == auto {
          cfg.dept = linguify("hr-dept")
        }
        cfg.dept
      }
    ]
    // Letter sender:
    box(
      width: 1fr,
      height: 2em,
      align(top + right, [
        // Get name and title from `#resume` using states
        #context resume-name-state.get()
        #linebreak()
        #context resume-title-state.get()
      ])
    )
    v(4em)
    
    // Current date:
    context fmt-date(
      datetime.today(),
      locale: text.lang,
      length: "long"
    ) + "."
    
    parbreak()

    body
  }
}


// Insert a professional experience entry.
// TODO: cfg.time-calc option
#let xp(
  role: none,
  place: none,
  time: none,
  skills: none,
) = context {
  let cfg = resume-config-state.get().skills
  
  // Job role
  // TODOC: *enterprise*, where
  let place = place.split(",")
  place.at(0) = strong(place.at(0))
  place.join(",")
  linebreak()
  
  // Place of work (enterprise)
  emph(role) + ", "// + sym.ast.op + "  "
  
  let time = time
  let year = datetime.today().year()
  let month = datetime.today().month()
  let current-job = false
  
  if time.len() == 1 {
    // Become: (time.at(0), 1, THIS-YEAR, THIS-MONTH)
    time.push(1)
    time.push(year)
    time.push(month)
    current-job = true
  }
  else if time.len() == 2 {
    // Become: (time.at(0), time.at(1), THIS-YEAR, THIS-MONTH)
    time.push(year)
    time.push(month)
    current-job = true
  }
  else if time.len() == 3 {
    // Become: (time.at(0), time.at(1), time.at(2), THIS-MONTH)
    time.push(month)
    
    if time.at(2) >= year {
      current-job = true
    }
  }
  
  if time.len() == 4 {
    let start = datetime(
      year: time.at(0),
      month: time.at(1),
      day: 1
    )
    let end = datetime(
      year: time.at(2),
      month: time.at(3),
      day: 2
    )
    
    if current-job == true {
      linguify("since") + " "
    }
    else {
      linguify("from") + " "
    }
    
    let n = str(start.month())
    // Find month abbreviation name in lang data file:
    context resume-lang-data-state.at(here())
      .at("lang")
      .at(text.lang)
      .at("month-abbrev")
      .at(n)
    //start.display("[month repr:short]")
    "/" + str(start.year())
    
    // If this is the current job:
    if current-job == false {
      " "
      linguify("to") + " "
      
      let n = str(end.month())
      // Find month abbreviation name in lang data file:
      context resume-lang-data-state.at(here())
        .at("lang")
        .at(text.lang)
        .at("month-abbrev")
        .at(n)
      //end.display("[month repr:short]")
      "/" + str(end.year())
      
      // Calculate time between start-end
      if cfg.at("time-calc", default: true) == true {
      
        // Number of days in this job:
        let diff = end - start
        // Number of years in this job:
        let years = calc.div-euclid(diff.days(), 365)
        // Number of months in this job:
        let months = calc.div-euclid(
          calc.rem(diff.days(), 365),
          30
        )
        
        [ (]
        // Show the years in this job
        if years > 0 {
          if years == 1 {
            [1 #linguify("year")]
          }
          else {
            [#years #linguify("years")]
          }
        }
        // Show the months in this job
        if months > 0  {
          if years > 0 {
            [ #linguify("and") ]
          }
          if months == 1 {
            [1 #linguify("month")]
          }
          else {
            [#months #linguify("months")]
          }
        }
        [)]
      }
    }
  }
  
  set text(size: 1em - 1pt)
  
  // Show skills inline:
  if cfg.at("display", default: "inline") == "inline" {
    let items = ()
    
    if type(skills) == content and skills.at("children", default: none) != none {
      for child in skills.children {
        if child.has("body") {
          items.push(child.body)
        }
      }
      
      linebreak()
      items.join(cfg.at("sep", default:  "  " + sym.bullet + "  "))
    }
    else {
      linebreak()
      skills
    }
  }
  // Show skills as topics:
  else if cfg.at("display", default: "inline") == "list" {
    par(
      spacing: 0.65em,
      pad(left: 1em)[#skills]
    )
  }
  else {
    panic("Invalid skills value: must be 'inline' or 'list'")
  }
}


// A wrapper around `#xp` for educational experiences
#let edu(
  course: none,
  place: none,
  time: none,
  skills: none,
  config: none,
) = xp(
  role: course,
  place: place,
  time: time,
  skills: skills
)


// Insert inline skills, like in `#xp`
#let skills(
  skill-list
) = context {
  let cfg = resume-config-state.get().skills

  if cfg.at("display", default: "inline") == "inline" {
    let items = ()
    
    for child in skill-list.children {
      if child.has("body") {
        items.push(child.body)
      }
    }
    
    items.join(cfg.at("sep", default:  "  " + sym.bullet + "  "))
  }
  else if cfg.at("display", default: "inline") == "list" {
    skill-list
  }
  else {
    panic("Invalid skills value: must be 'inline' or 'list'")
  }
}


// Generate a Linkedin QR code:
#let linkedin-qrcode(
  user
) = {
  import "@preview/tiaoma:0.3.0": qrcode
  
  set align(center)
  v(1fr)
  block(width: 100%)[
    // Link to Linkedin profile
    #link("https://www.linkedin.com/in/" + user)[
      // Generate QR Code to Linkedin profile
      #qrcode(
        "https://www.linkedin.com/in/" + user,
        options: (
          scale: 1.3,
          option-1: 3
        )
      )
      // Insert Linkedin logo above QR code:
      #place(center + horizon,
        block(
          height: 0.7cm,
          width: 0.7cm,
          image("assets/linkedin.png")  
        )
      )
    ]
  ]
  v(1fr)
}