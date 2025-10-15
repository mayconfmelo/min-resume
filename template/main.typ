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

To be hired and work hard to (hopefully) earn some money.


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

- #underline[A Really Useful Course]. Educational Institution. Year or Validity.  
- #underline[A Very Professional Qualification]. Educational Institution. Year or Validity.  
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
  Dear Hiring Manager, or to whom it may concern,

  Please hire me. I work. A lot. Some say too much, but I think they are the
  ones who peripherally don’t like working... I mean, you can’t call yourself a hard
  worker and refuse to work on Sundays if your boss asks you to work on Saturdays.
  If they ask of you much, make sure you give them too much --- that’s my life
  philosophy.
  
  I’m also very attentive to details: I once set an out-of-office reply saying I
  would not be checking emails while on holiday. Then I spent most of the holiday
  checking whether it was working properly. I like to ensure everything runs like
  clockwork --- except for my sleep cycle, which is a long-lost battle, but
  nothing two cups of coffee in the morning can’t fix.
  
  I thrive under pressure, survive on caffeine, and only need to rest
  occasionally. If you need someone who will work weekends, holidays, and
  possibly in their dreams --- I am your person.
  
  I promise to bring unstoppable energy, a questionable work-life balance, and a
  genuine passion for making your company even greater and wealthier. Please,
  let me prove that exhaustion is just another word for "commitment."
  
  Eagerly --- and already working on this application overtime ---,\
  John B. Goode Workmann.
] 