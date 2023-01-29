#/bin/bash -e

# Copyright 2023 Google LLC.
# SPDX-License-Identifier: Apache-2.0

CAFILE=$1

fail() {
  echo $1 >&2
  exit 1
}

file "${CAFILE}" | grep -q "PEM certificate" || fail "usage: $0 <CAfile>"

N=$(grep -c BEGIN "${CAFILE}")

for I in $(seq 1 "${N}"); do
  [ -a $I.pem ] || [ -o $I.pem.txt ] && fail "$I.pem or $I.txt exists"
done

for I in $(seq 1 "${N}"); do
  awk -v n="${I}" '/BEGIN CERTIFICATE/ && ++k == n, /END CERTIFICATE/' "${CAFILE}" > "${I}.pem"
  openssl x509 -in "${I}.pem" -noout -text > "${I}.txt"
done

echo "Done, wrote 1.pem and 1.txt til ${N}.pem and ${N}.txt."
