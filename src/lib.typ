// Résumé package

#import "@preview/linguify:0.4.0": linguify, set-database

#let resume-name-state = state("resume-name")
#let resume-title-state = state("reume-title")
#let resume-lang-data-state = state("resume-lang-data")

// TODO: Check optional arguments
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
  paper: "a4",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.65em,
  par-margin: 1.2em,
  margin: 0.75in,
  font: "Arial",
  font-size: 11.5pt,
  body
) = {
  // Required arguments
  let req = (
    name: name,
    birth: birth,
    address: address
  )
  for arg in req.keys() {
    if req.at(arg) == none {
      panic("Missing required argument: " + arg)
    }
  }
  
  // Tranform (yyyy, mm, dd) date into datetime:
  if type(date) == array {
    date = datetime(
      year: int(date.at(0)),
      month: int(date.at(1)),
      day: int(date.at(2))
    )
  }
  
  // State updates:
  resume-name-state.update(name)
  resume-title-state.update(title)
  resume-lang-data-state.update(lang-data)
  
  set document(
    title: name + " - " + title,
    author: name,
    date: date,
  )
  set page(
    paper: paper,
    margin: margin,
    header: context if locate(here()).page() > 1 {
      // Name and title in header after 1th page
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
  show heading.where(level: 1): set text(size: font-size)
  show heading.where(level: 2): set text(size: font-size)
  show heading.where(level: 3): set text(size: font-size)
  show heading.where(level: 4): set text(size: font-size)
  show heading.where(level: 5): set text(size: font-size)
  show heading.where(level: 6): set text(size: font-size)
  
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
  v(1em)
  
  // Insert photo, if any
  if type(photo) == content {
    box(width: 5.75em, height: 5.75em)[
      #photo
    ]
  }

  box(width: 1fr)[
    #align(right)[
      // Relevant personal information, if any
      #if personal != none [#personal, ]
      // Age calculation using birth date, if any:
      #if birth != none {
        // Tranform (yyyy, mm, dd) into datetimes
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
        
        // Age if yet to comemorate birthday this year:
        if birthday > datetime.today() {
          str(datetime.today().year() - birth.year() - 1)
        }
        // Age if already comemorated birthday this year:
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
        
        // Removr country code from phone number
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
      #v(1em)
    ]
  ]
  
  show heading: it => {
    block(
      above: 1.5em,
      below: 1em,
      upper(it)
    )
  }
  
  body
}


// Generate a professional letter.
#let letter(
  enterprise,
  dept: linguify("hr-dept"),
  body
) = {
  if enterprise == true or type(enterprise) == str {
    import "@preview/icu-datetime:0.1.2": fmt-date
    
    // Remove résumé header:
    set page(header: none)
    
    pagebreak(weak:true)
    
    // Letter receiver, if any:
    box(width: 1fr)[
      #if type(enterprise) == str {
        enterprise
        linebreak()
        dept
      }
    ]
    // Letter sender:
    box(width: 1fr,
      align(right + top, [
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
#let xp(
  role: none,
  place: none,
  time: none,
  actual-job: false,
  skills: none,
  skills-list: false,
  skills-sep: "  " + sym.bullet + "  "
) = {
  // Job role
  strong(role)
  linebreak()
  // Place of work (enterprise)
  place + "  " + sym.ast.op + "  "
  
  let year = datetime.today().year()
  let month = datetime.today().month()
  
  if time.len() == 1 {
    // Become: (time.at(0), 1, THIS-YEAR, THIS-MONTH)
    time.push(1)
    time.push(year)
    time.push(month)
    actual-job = true
  }
  else if time.len() == 2 {
    // Become: (time.at(0), time.at(1), THIS-YEAR, THIS-MONTH)
    time.push(year)
    time.push(month)
    actual-job = true
  }
  else if time.len() == 3 {
    // Become: (time.at(0), time.at(1), time.at(2), THIS-MONTH)
    time.push(month)
    
    if time.at(2) >= year {
      actual-job = true
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
    
    let n = str(start.month())
    // Find month abbreviation name in lang data file:
    context resume-lang-data-state.at(here())
      .at("lang")
      .at(text.lang)
      .at("month-abbrev")
      .at(n)
    //start.display("[month repr:short]")
    "/" + str(start.year()) + sym.dash.en
    
    // If this is the current job:
    if actual-job == true  or end >= datetime.today() {
      linguify("now")
    }
    else {
      let n = str(end.month())
      // Find month abbreviation name in lang 8data file:
      context resume-lang-data-state.at(here())
        .at("lang")
        .at(text.lang)
        .at("month-abbrev")
        .at(n)
      //end.display("[month repr:short]")
      "/" + str(end.year()) + " ("
      
      
      // Number of days in this job:
      let diff = end - start
      // Number of years in this job:
      let years = calc.div-euclid(diff.days(), 365)
      // Number of months in this job:
      let months = calc.div-euclid(
        calc.rem(diff.days(), 365),
        30
      )
      
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
  "."
  
  linebreak()
  
  // Show skills inline:
  if skills-list == false and type(skills) != str {
    let items = ()
    
    for child in skills.children {
      if child.has("body") {
        items.push(child.body)
      }
    }
    
    items.join(skills-sep)
  }
  // Show skills as topics:
  else {
    skills
  }
}


// A wrapper around `#xp` for educational experiences
#let edu(
  course: none,
  place: none,
  time: none,
  actual-course: false,
  skills: none,
  skills-list: false,
  skills-sep: "  " + sym.bullet + "  "
) = xp(
  role: course,
  place: place,
  time: time,
  actual-job: actual-course,
  skills: skills,
  skills-list: skills-list,
  skills-sep: skills-sep
)


// Insert inline skills, like in `#xp`
#let skills(
  skills-list: false,
  skills-sep: "  " + sym.bullet + "  ",
  skills
) = {
  if skills-list == false or type(skills) == str {
    let items = ()
    
    for child in skills.children {
      if child.has("body") {
        items.push(child.body)
      }
    }
    
    items.join(skills-sep)
  }
  else {
    skills
  }
}


// Generate a Linkedin QR code:
#let linkedin-qrcode(user, size) = {
  import "@preview/cades:0.3.0": qr-code
  
  set align(center)
  
  v(1fr)
  block(width: 100%)[
    // Link to Linkedin profile
    #link("https://www.linkedin.com/in/" + user)[
      // Generate QR Code to Linkedin profile
      #qr-code(
        "https://www.linkedin.com/in/" + user,
        height: size
      )
      // Insert Linkedin logo above QR code:
      #place(center + horizon,
        block(
          height: size * 0.4,
          width: size * 0.4,
          image("assets/linkedin.png")  
        )
      )
    ]
  ]
  v(1fr)
}