# MinIO object storage

## Installation

1. [Install krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)
2. kubectl krew install minio 
3. kubectl minio init 
4. kubectl minio tenant create --name tenant1 --servers 4 --volumes 16 --capacity 16Ti