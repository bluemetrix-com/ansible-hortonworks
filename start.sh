#!/usr/bin/env bash

# Set 'strict' mode because I don't love debugging
set -euo pipefail
IFS=$'\n\t'

# Check variables
if test -z "${GCE_EMAIL+x}" -o -z "${GCE_PROJECT+x}" -o -z "${GCE_CREDENTIALS_FILE_PATH+x}"
then
	cat<<-EOF
	The following environment variables need to be exported:

	GCE_EMAIL = Google Cloud service account id (misleading variable name, not an actual email)
	GCE_PROJECT = Google Cloud project where the cluster will be created
	GCE_CREDENTIALS_FILE_PATH = Path to the JSON file with the service account credentials
	EOF
	exit 1
fi

export CLOUD_TO_USE=gce

# We just launch all the build scripts sequentally. 'set -e' will terminate this script if any of these commands fail

$(dirname "${BASH_SOURCE[0]}")/build_cloud.sh
$(dirname "${BASH_SOURCE[0]}")/install_cluster.sh
