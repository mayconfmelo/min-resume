#import "/src/lib.typ": resume
#show: resume.with(
  name: "Name",
  address: "General Address",
  data: yaml("data.yaml"),
  cfg: (typst-defaults: true),
)