## 2.0.0

- **Breaking**: `PubInfo.popularity` is replaced by `PubInfo.downloadCount30Days`.
  pub.dev retired the popularity percentile in favour of a 30-day download
  count. Entries written before the switch have no download count until the
  cron task visits them again.
- Null fields are no longer written to the data file.
- Moved off the `xvrh/pub_api_client` fork to the published `pub_api_client`
  2.6.0 → 3.2.0. The fork's `PackageScore` required a `lastUpdated` field that
  pub.dev no longer returns, so every score lookup was throwing.
- The cron task lists packages with `/api/package-names` again rather than the
  20k-capped name-completion endpoint, and refuses to run if pub.dev reports
  fewer packages than the snapshot already holds.
- The cron task survives a package that fails to load, and fails the job
  outright if the whole slice fails.

## 1.0.0

- Initial version.
