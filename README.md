# Minimal Résumé

<center>

<p class="hidden">
  Simple and professional résumé for professional people
</p>

<p class="hidden">
  <a href="https://typst.app/universe/package/min-resume">
    <img src="https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Fmin-resume&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%23239DAE&labelColor=%23353c44" /></a>
  <a href="https://github.com/mayconfmelo/min-resume/tree/cfg/">
    <img src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmayconfmelo%2Fmin-resume%2Frefs%2Fheads%2Fcfg%2Ftypst.toml&query=%24.package.version&logo=github&label=Development&logoColor=%2397978e&color=%23239DAE&labelColor=%23353c44" /></a>
</p>


[![Manual](https://img.shields.io/badge/Manual-%23353c44)](https://raw.githubusercontent.com/mayconfmelo/min-resume/refs/tags/0.1.0/docs/manual.pdf)
[![Example PDF](https://img.shields.io/badge/Example-PDF-%23777?labelColor=%23353c44)](https://raw.githubusercontent.com/mayconfmelo/min-resume/refs/tags/0.1.0/docs/example.pdf)
[![Example SRC](https://img.shields.io/badge/Example-SRC-%23777?labelColor=%23353c44)](https://github.com/mayconfmelo/min-resume/blob/0.1.0/template/main.typ)
[![Changelog](https://img.shields.io/badge/Changelog-%23353c44)](https://github.com/mayconfmelo/min-resume/blob/main/docs/changelog.md)
[![Contribute](https://img.shields.io/badge/Contribute-%23353c44)](https://github.com/mayconfmelo/min-resume/blob/main/docs/contributing.md)


</center>


## Quick Start

```typst
#import "@preview/min-resume:0.1.0": resume
#show: manual.resume(
  name: "Your Name",
  title: "Academic Title and/or Main Occupation",
  photo: image("photo.png"),
  personal: "Relevant personal info",
  birth: (1997, 05, 19),
  address: "Your Address (no street nor house number)",
  email: "example@email.com",
  phone: "+1 (000) 000-0000",
)
```


## Description

Generate a modern and direct to the point résumé, fit for today's Human Resources
demands of assertiveness. There is no colorful designs, figures, creative fonts,
nor anything that diverts attention when reading the document: is just plain old
black sans-serif text in white paper. In fact, if one sees only the resulting
résumé, may say it was written in Word — but it was written with all of
Typst's benefits and conveniences.

The package was written by a Brazilian, so it uses some common Brazilian
practices when writing a résumé — but it is simple and minimalistic, even to
Brazilian standards. Therefore, if some information are missing or  unnecessary
to you, feel free to adapt it to your needs.

## Feature List

- Typst document
  - `#entry` for job experience or academic formation
  - `#list` for special inline lists
  - `#linkedin` for Linkedin profile QR code
  - `#letter` for professional letter
- YAML document
- 