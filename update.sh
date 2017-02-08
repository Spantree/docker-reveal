#!/bin/bash
set -e

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

travisEnv=
for version in "${versions[@]}"; do
	(
		set -x
    mkdir -p $version
		cp docker-entrypoint.sh "$version/"
    cp docker-compose.yml "$version/"
		sed '
			s!%%NODE_VERSION%%!'"4.7"'!g;
			s!%%REVEAL_VERSION%%!'"$version"'!g;
		' Dockerfile.template > "$version/Dockerfile"
	)
done
