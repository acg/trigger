#!/bin/sh

set -e

PKG_NAME=`basename "$PWD"`
PKG_VERSION="`tail -1 package/versions`"
PKG_BUILD_DIR="$PKG_NAME-$PKG_VERSION"
PKG_SOURCE="$PKG_NAME-$PKG_VERSION".tar.gz

main()
{
  git ls-files | tar_rewrite "@^@$PKG_BUILD_DIR/@" czf ./"$PKG_SOURCE" -T -
  echo "created tarball at ./$PKG_SOURCE"
}

tar_rewrite()
{
  pattern="$1" ; shift
  if [ -n "`tar --version | head -1 | grep GNU`" ]; then
    tar "$@" --transform "flags=r;s${pattern}"
  else
    tar "$@" -s "$pattern"
  fi
}

main "$@"

