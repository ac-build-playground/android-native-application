#!/bin/sh

if [ -z "$1" ]; then
    echo "No base path specified."
    exit 0
fi

BASE=$1

echo "Removing all ABI or density dependent APKs…"

find -E $BASE -iregex "$BASE.+(armeabi|arm64|x86|mips|ldpi|mdpi|hdpi|xhdpi|xxhdpi|xxxhdpi).+\.apk" -exec rm -f {} \;

APK_TOTAL=$(find -E $BASE -iregex "$BASE.+\.apk" | wc -l)
APK_UNALIGNED=$(find -E $BASE -iregex "$BASE.+(-unaligned)\.apk" | wc -l)

echo "Found $APK_TOTAL APK file(s)"
echo "Found $APK_UNALIGNED unaligned APK file(s)"
if (($APK_TOTAL >= 2 && $APK_UNALIGNED < $APK_TOTAL)); then
    echo "Deleting unaligned APK files…"
    find -E $BASE -iregex "$BASE.+(-unaligned)\.apk" -exec rm -f {} \;  
fi

APK_UNSIGNED=$(find -E $BASE -iregex "$BASE.+-unsigned\.apk" | wc -l)
if (($APK_UNSIGNED > 0)); then
    echo "Removing \"-unsigned\" from affected APKs…"
    for i in $(find -E $BASE -iregex "$BASE.+-unsigned\.apk")
    do
        mv $i $(echo $i | sed -e 's/-unsigned\.apk/\.apk/')
    done
fi

# $BASE is path to outputs/apk folder - for compatibility we don't change it but use relative path
OUTPUTS=$BASE/..

pushd $OUTPUTS
MAPPING_TOTAL=$(find -E . -iregex ".+mapping.+mapping\.txt" | wc -l)
if (($MAPPING_TOTAL > 0)); then
    # emit tag for when mapping files exist and will be made available
    echo "##vso[build.addbuildtag]mapping"
fi
popd
