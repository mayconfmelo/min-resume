#import "@preview/min-resume:0.0.0": resume, entry, list, linkedin, letter

#show: resume.with( 
	name: "John B. Goode Workmann",
	title: "Work Specialist",
	photo: image("assets/photo.png"),
	info: "Relevant personal info",
	birth: (1997, 05, 19),
	address: "General Address",
	email: "workmann@email.com",
	phone: "+1 (000) 000-0000"
)


= Objective

To be hired and work hard to (hopefully) earn a lot of money.


= Professional Experience

#entry(  
	title: "Chief Work Officer",
	organization: "A Way More Cooler Corp.",
	time: (2024, 2), 
	skills: [
	  - Applied the things I learned
	  - Did more stuff
	  - Accomplished so much more
	  - Learned even more
	],
)  
#entry(  
	title: "Proactive Manager", 
	organization: "Some Really Cool Inc.",
	location: "Neverland",
	time: (2023, 3, 2024, 1),
	skills: [
	  - Did some stuff
	  - Learned some things
	  - Accomplished some goals
	]
)  


= Education

#entry(
  title: "Doctorate in Grinding",
  organization: "Respected University",
  time: (2020, 1, 2024, 12),
  skills: [
    - Learned stuff
    - Studied more stuff
    - Wrote about the stuff I learned
    - Wrote a thesis on interesting things
  ]
)


= Qualification

- A Really Useful Course. Educational Institution. Year or Validity.  
- A Very Professional Qualification. Educational Institution. Year or Validity.  
- A Less Useful Certification. Educational Institution. Year or Validity.  


= Skills  

#list[
  - Knows things
  - Smile often
  - Talks to a lot of people
  - Get things done
  - Fast coffee and bathroom breaks
]


= Additional Information  

- Available to work 24/7
- Available to do some tiresome business travels
- Know some extra things
- Did some extra work
- Awarded as _Best Employee Ever #datetime.today().year()_


#linkedin("linkedin-username")


#letter(to: "Amazing Enterprise LLC")[
  Dear Hiring Manager, or who it may concern,
  
  Please hire me. I work. A lot. Some say too much. I once stayed late just to
  make sure the lights were turned off — then realized I was the one who turned
  them off; that' the kind of dedication we're talking about.
  
  I believe in giving 110%, though mathematically that’s questionable. I thrive
  under pressure, survive on coffee, and occasionally remember to sleep. If you
  need someone who will work weekends, holidays, and possibly in their dreams
  — I am your person.
  
  I promise to bring unstoppable energy, questionable work-life balance, and a
  genuine passion for making your company even greater. Please, let me prove
  that exhaustion is just another word for “commitment.”
  
  Eagerly (and already working on this application overtime),\
  John B. Goode Workmann
] 