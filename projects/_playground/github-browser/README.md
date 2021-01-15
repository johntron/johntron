# Github repo browser


## Technologies used

* [Berglas](https://github.com/GoogleCloudPlatform/berglas) for securely storing credentials in Google Cloud Storage
* Google's Cloud KMS for credential storage (berglas credential)
* Google Cloud Run for handling OAuth workflow
* Nodejs

## Setup

1. Follow [setup instructions for berglas](https://github.com/GoogleCloudPlatform/berglas#setup)
2. Create credential called "gh-browser-client" in KMS - follow [berglas CLI instructions](https://github.com/GoogleCloudPlatform/berglas#cli-usage)
3. [Grant GCP service account access to credential](https://github.com/GoogleCloudPlatform/berglas/blob/34e256/examples/cloudrun/node/README.md#berglas-cloud-run-example---node)

## Todo

* Build read-only actions like: get file listing, git raw file
**** Using authentication token from another serverless, build write actions like: commit change to file

