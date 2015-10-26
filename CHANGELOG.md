## 1.0.7 (2015-10-26)
 IMPROVEMENTS
  - Fix regression in ssl url generation [GH-32]
  - Remove Travis support for 1.9.3
  - Remove unnecessary rubocop todo

## 1.0.6 (2015-05-08)
 IMPROVEMENTS
  - Better https/ssl support [GH-30], [GH-31]

## 1.0.5 (2015-02-27)
 BUG FIXES:
  - Fixes bug introduced in 1.0.4 [GH-29]

## 1.0.4 (2015-02-26)
 IMPROVEMENTS
  - Allows for the overriding of graphite settings. [GH-28]
  - Updates README.md with instructions for overrides.

## 1.0.3 (2015-01-08)
BUG FIXES:
  - Fix bad logic in suppress option. [GH-27]

IMPROVEMENTS
 - Removed gem post install message.
 - Safer setting of config values. [GH-24]
 - Speedier builds via TravisCI Docker infrastructure. [GH-25]

## 1.0.2 (2014-11-19)
BUG FIXES:
  - Fix bug introduced by [GH-17].
  - Fix issue where notification could be sent on failed deploy/rollback.

IMPROVEMENTS:
  - Cleaner Rake syntax.

## 1.0.1 (2014-11-19)
BUG FIXES:
  - Fix bug where multiple events were sent to graphite. [GH-18]

IMPROVEMENTS:
  - Update test command example in README.md. [GH-19]
  - Lint entire project with RuboCop. [GH-17]
  - Add `rake` task to lint with RuboCop when Travis is run. [GH-17]

## Previous Versions
Sorry, no true documentation was kept prior to 1.0.1.
