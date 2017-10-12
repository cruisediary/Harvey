# Harvey Vision

For a long time at Moya we were struggling with migrating the codebase to be `SPM-test` compatible. We acknowledge that we need to replace our current network stubbing library,
[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs), with something that is SPM
compatible, written in Swift and actively maintained. We searched for replacements, but
nothing met our criteria, so we decided to create our own library under Moya organization.

# Project goals
- provide network response stubbing based on request properties (url/method etc.)
- provide simple, yet extensible, API
- satisfy whatever needs we have for network stubbing over at Moya
- find out if we can leverage some stubbing work off of Moya
- fully SPM-compatible (`build`/`test`)
- actively maintained/updated to newest Moya/Swift versions
- cultivate an inclusive open source community through respectful discussion
