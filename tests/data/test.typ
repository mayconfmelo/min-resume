#import "/src/lib.typ": resume
#show: resume.with(
  name: "Name",
  address: "General Address",
  data: yaml("data.yaml"),
  typst-defaults: true,
)