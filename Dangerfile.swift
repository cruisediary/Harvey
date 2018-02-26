import Foundation
import Danger
import DangerSwiftLint // package: https://github.com/ashfurrow/danger-swiftlint.git

let danger = Danger()
// warn(message: "Bad empty line!", file: "Sources/Harvey/HarveyResponse.swift", line: 12)
// message(message: "It happens, though...", file: "Sources/Harvey/HarveyResponse.swift", line: 12)
// fail(message: "Jk, fix it bro", file: "Sources/Harvey/HarveyResponse.swift", line: 12)
// message(message: "Message not in the inline scope", file: "Dangerfile.swift", line: 20)
// warn(message: "🤦🏼‍♂️", file: "Sources/Harvey/HarveyResponse.swift", line: 20)
// message("Message into main comment")
message(message: "New message arrived!", file: "circle.yml", line: 15)

let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

let changelogChanged = allSourceFiles.contains("CHANGELOG.md")
let sourceChanges = allSourceFiles.first(where: { $0.hasPrefix("Sources") })
let isTrivial = danger.github.pullRequest.title.contains("#trivial")

if danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > 10 {
    warn("Big PR, try to keep changes smaller if you can")
}

if !isTrivial && !changelogChanged && sourceChanges != nil {
    warn("""
     Any changes to library code should be reflected in the Changelog.

     Please consider adding a note there and adhere to the [Changelog Guidelines](https://github.com/Moya/contributors/blob/master/Changelog%20Guidelines.md).
    """)
}

if danger.github.pullRequest.title.contains("WIP") {
    warn("PR is classed as Work in Progress")
}

let onlyPodspec = allSourceFiles.contains("Harvey.podspec") && !allSourceFiles.contains("Package.swift")
let onlyPackage = !allSourceFiles.contains("Harvey.podspec") && allSourceFiles.contains("Package.swift")
if onlyPodspec != onlyPackage {
    warn("Only one of either the podspec or SPM package was changed. This might be unintentional – double check.")
}

// Workaround for SwiftLint bug https://github.com/ashfurrow/danger-swiftlint/issues/4
SwiftLint.lint(directory: "Sources", configFile: ".swiftlint.yml")
SwiftLint.lint(directory: "Tests", configFile: "Tests/HarveyTests/.swiftlint.yml")
