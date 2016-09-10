import PackageDescription

let package = Package(
    name: "SlackBot",
    dependencies: [
      .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 18)
    ],
    exclude: [
        "Images"
    ]
)
