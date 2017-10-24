import Foundation
import Danger

let danger = Danger()

let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

let changelogChanged = allSourceFiles.contains("CHANGELOG.md")
let sourceChanges = allSourceFiles.first(where: { $0.hasPrefix("Sources") })
let isTrivial = danger.github.pullRequest.title.contains("#trivial")

if (danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > 10) {
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
if onlyPodspec || onlyPackage {
    warn("Only one of either the podspec or SPM package was changed. This might be unintentional – double check.")
}

// A quick output fo the swiftlint JSON, someone else can make this more useful
let fileManager = FileManager.default
if fileManager.fileExists(atPath: "swiftlint-results.json") {
    if let results = try? String(contentsOfFile: "swiftlint-results.json", encoding: String.Encoding.utf8) {
      if(results.contains("fail")) {
        fail("```json\n" + results + "\n```")
      } else {
        warn("```json\n" + results + "\n```")
      }
    }
}
