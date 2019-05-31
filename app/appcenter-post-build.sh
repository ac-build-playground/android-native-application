echo $build_sourcesdirectory

BASE="/Users/vsts/agent/2.152.0/work/1/s/app/build/outputs/apk"

# $BASE is path to outputs/apk folder - for compatibility we don't change it but use relative path
OUTPUTS=$BASE/..

pushd $OUTPUTS

MAPPING_TOTAL=$(find -E . -iregex ".+mapping.+mapping\.txt" | wc -l)
if (($MAPPING_TOTAL > 0)); then
    # emit tag for when mapping files exist and will be made available
    echo "##vso[build.addbuildtag]mapping"
fi
popd
