#!/bin/sh
# Client for the configured file host. FILE_HOST_URL points at the upload API endpoint.
# Usage:
#   upload.sh /path/to/file [--slug NAME | --random]   POST, prints public URL
#   upload.sh --update KEY /path/to/file               PUT, same link, new content
#   upload.sh --delete KEY                             DELETE, permanent + idempotent
# Without FILE_HOST_URL/FILE_HOST_TOKEN an upload falls back to ~/.agents/artifacts/.
set -eu

env_file="${AGENTS_HOME:-$HOME/.agents}/.env"
artifacts="${AGENTS_HOME:-$HOME/.agents}/artifacts"

if [ -f "$env_file" ]; then
  # shellcheck disable=SC1090
  set -a
  . "$env_file"
  set +a
fi

usage() {
  echo "usage: upload.sh /path/to/file [--slug NAME | --random]" >&2
  echo "       upload.sh --update KEY /path/to/file" >&2
  echo "       upload.sh --delete KEY" >&2
  exit 1
}

require_host() {
  if [ -z "${FILE_HOST_URL:-}" ] || [ -z "${FILE_HOST_TOKEN:-}" ]; then
    echo "FILE_HOST_URL/FILE_HOST_TOKEN unset — cannot $1" >&2
    exit 1
  fi
}

case "${1:-}" in
  --update)
    [ $# -eq 3 ] && [ -f "$3" ] || usage
    require_host update
    curl -fsS -X PUT \
      -H "Authorization: Bearer $FILE_HOST_TOKEN" \
      -F "file=@${3};filename=$(basename "$3")" \
      "$FILE_HOST_URL/$2"
    echo
    ;;
  --delete)
    [ $# -eq 2 ] || usage
    require_host delete
    curl -fsS -X DELETE \
      -H "Authorization: Bearer $FILE_HOST_TOKEN" \
      "$FILE_HOST_URL/$2"
    ;;
  *)
    [ "${1:-}" != "" ] && [ -f "${1:-}" ] || usage
    src=$1
    base=$(basename "$src")
    extra=""
    case "${2:-}" in
      "") ;;
      --slug) [ $# -eq 3 ] || usage; extra="-Fslug=$3" ;;
      --random) [ $# -eq 2 ] || usage; extra="-Frandom=true" ;;
      *) usage ;;
    esac
    if [ -n "${FILE_HOST_URL:-}" ] && [ -n "${FILE_HOST_TOKEN:-}" ]; then
      # $extra stays unquoted: it is zero or one curl argument, and the
      # server rejects unsafe slugs, so word splitting cannot smuggle flags.
      curl -fsS \
        -H "Authorization: Bearer $FILE_HOST_TOKEN" \
        -F "file=@${src};filename=${base}" \
        $extra \
        "$FILE_HOST_URL"
      echo
    else
      mkdir -p "$artifacts"
      cp "$src" "$artifacts/$base"
      echo "file://$artifacts/$base"
      echo "FILE_HOST_URL unset — wrote local artifact, not a public URL" >&2
    fi
    ;;
esac
