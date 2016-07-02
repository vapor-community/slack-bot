import PackageDescription

let package = Package(
    name: "SlackBot",
    dependencies: [
      .Package(url: "https://github.com/qutheory/vapor-ssl", majorVersion: 0, minor: 1)
    ],
    exclude: [
        "Images"
    ]
)
