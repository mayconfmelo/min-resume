# Minimal Résumé

<center>
  description = "Simple and professional résumé for professional people"
</center>


# Quick Start

```typst
#import "@preview/min-resume:0.1.0": resume
#show: manual.resume(
  name: "Your Name",
	title: "Main Title or Occupation",
	photo: image("example-photo.png"),
	personal: "Relevant personal info",
	birth: (1997, 05, 19),
	address: "Your Address (no street nor house number)",
	email: "example@email.com",
	phone: "+1 (000) 000-0000",
)
```

# Description

Generate modern and direct to the point résumé, fit for today's Human Resources
demands of assertiveness. There is no colorfull designs, figures, creative fonts,
nor anything that diverts attention when reading the document: is just plain old
black sans-serif text in white paper. In fact, if one see only the resulting
résumé, may say it was written in Word, maybe --- but it was written with all of
Typst's benefits and conveniences.


# More Information

- [Official manual](docs/pdf/manual.pdf)
- [Example PDF result](docs/pdf/example.pdf)
- [Example Typst code](template/main.typ)


# Setup

This project uses `just` to automate all development processes. Run `just` or
refer to the _justfile_ for more information.


### Release

Install the package in default _preview_ namespace:

```
just install preview
```

To uninstall it:

```
just remove preview
```


### Testing

Install the package in a separated _local_ namespace:

```
just install local
```

To uninstall it:

```
just remove local
```

The command `just install-all` installs it in both _preview_ and _local_
namespaces at the same time.


### Development

Create a direct symbolic link between this project and and the _local_ namespace,
under a special _0.0.0_ version:

```
just dev-link
```

This way, every change made into the package will instantly be available to 
Typst by using a `@local/min-article:0.0.0` import.

This command is a toggle: run it once, and it creates the link; run it again and
the link is removed; and so on.