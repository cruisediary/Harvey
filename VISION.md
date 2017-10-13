# Harvey Vision

For a long time at Moya we were struggling with migrating the codebase to be `SPM-test` compatible. We acknowledged that we need to replace our current network stubbing library,
[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs), with something that is SPM
compatible, written in Swift and actively maintained. We searched for replacements, but
nothing met our criteria, so we decided to create our own library under the Moya organization.

# Project goals
- provide network response stubbing based on request properties (url/method etc.)
- provide simple, yet extensible, API
- satisfy the testing needs of Moya
- fully SPM-compatible (`build`/`test`)
- determine the extent to which Harvey can be bootstrapped using Moya's first class stubbing API
- leverage the [Moya Community](https://github.com/orgs/Moya/people) to keep Harvey updated to the latest Moya/Swift versions
- cultivate an inclusive open source community through respectful discussion
