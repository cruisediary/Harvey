fail("intentionally failing to test")

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
not_declared_trivial = !(github.pr_title.include? "#trivial")
has_app_changes = !git.modified_files.grep(/Sources/).empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn("Big PR, try to keep changes smaller if you can") if git.lines_of_code > 200

# Changelog entries are required for changes to library files.
no_changelog_entry = !git.modified_files.include?("Changelog.md")
if has_app_changes && no_changelog_entry && not_declared_trivial
  warn("Any changes to library code should be reflected in the Changelog. Please consider adding a note there and adhere to the [Changelog Guidelines](https://github.com/Moya/contributors/blob/master/Changelog%20Guidelines.md).")
end

podspec_updated = !git.modified_files.grep(/Harvey.podspec/).empty?
package_updated = !git.modified_files.grep(/Package.swift/).empty?

if !(podspec_updated^package_updated) # an inverted xor, I had to look it up
  warn("Only one of either the podspec or SPM package was changed. This might be uninstentional – double check.")
end

# Run SwiftLint
swiftlint.lint_files

