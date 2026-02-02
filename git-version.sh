#!/bin/bash

if [ -e LFS-RELEASE ]; then
    exit 0
fi

if ! git status > /dev/null; then

# Either it's not a git repository or git is unavailable.
# Just workaround.
cat >> version.ent << 'EOF'
<!ENTITY version           "unknown">
<!ENTITY releasedate       "unknown">
<!ENTITY copyrightdate     "1999-2026">
EOF

exit 0

fi

export LC_ALL=en_US.utf8
export TZ=America/Chicago

commit_date=$(git show -s --format=format:"%cd" --date=local)

year=$(date --date "$commit_date" "+%Y")
month=$(date --date "$commit_date" "+%B")
month_digit=$(date --date "$commit_date" "+%m")
day=$(date --date "$commit_date" "+%d" | sed 's/^0//')

case $day in
    "1" | "21" | "31" ) suffix="st";;
    "2" | "22" ) suffix="nd";;
    "3" | "23" ) suffix="rd";;
    * ) suffix="th";;
esac

full_date="$month $day$suffix, $year"

sha="$(git describe --abbrev=1 --always)"
rev=$(echo "$sha" | sed 's/-g[^-]*$//')
version="$rev"

if [ "$(git diff HEAD | wc -l)" != "0" ]; then
    version="$version-wip"
fi

cat >> version.ent << EOF
<!ENTITY version           "$version">
<!ENTITY releasedate       "$full_date">
<!ENTITY copyrightdate     "1999-$year">
EOF

[ -z "$DIST" ] || echo $version > "$DIST"
