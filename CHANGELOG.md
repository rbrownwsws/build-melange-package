# Changelog

## 1.0.0 (2026-08-25)


### ⚠ BREAKING CHANGES

* Don't do caching (leave that to the workflow)
* Don't include signing public key or melange config in output.

### Features

* add inputs for controlling index and provenance generation ([dd8d27d](https://github.com/rbrownwsws/build-melange-package/commit/dd8d27d563e275350ad382f1f90eaa9e948f5d02))
* allow packages to not be signed as part of build ([96f42fb](https://github.com/rbrownwsws/build-melange-package/commit/96f42fb1e694c1af8d0deedade62d1658042ea0e))
* allow setting package namespace ([f08bf40](https://github.com/rbrownwsws/build-melange-package/commit/f08bf4063eb9af96be2c8d2bd1d7a90352a4f1d0))
* Don't do caching (leave that to the workflow) ([2d2adec](https://github.com/rbrownwsws/build-melange-package/commit/2d2adeca09cd8e0d2527cf60891b2fb5c178ec0a))
* Don't include signing public key or melange config in output. ([bdecf05](https://github.com/rbrownwsws/build-melange-package/commit/bdecf050dc684695ff999bb961dda5e84f8efdc8))


### Bug Fixes

* don't mangle signing key name as verification relies on it ([d2e347f](https://github.com/rbrownwsws/build-melange-package/commit/d2e347fb782cc0a5a76fa8f15e374b157c324dd6))


### Continuous Integration

* add reusable workflows for zizmor and release-please ([ee17302](https://github.com/rbrownwsws/build-melange-package/commit/ee173026b66f7b2448191c7e87ca6785a6e2603d))
