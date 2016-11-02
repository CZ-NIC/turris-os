#!/bin/sh

# It doesn't make sense to run this script if there is no source data 
if [ ! -d $PWD/logs ]; then
    echo "Directory $PWD/logs doesn't exist!"
    return 1
fi

# Insert XML header
cat > $PWD/logs/junit.xml << EOF
<?xml version='1.0' encoding='utf-8'?>
<testsuites errors='$(cat $PWD/logs/package/error.txt | wc -l)' tests='$(find $PWD/logs/package/ -name compile.txt | wc -l)'>
EOF

# Going through the package build logs
(cd $PWD/logs; find package/ -name compile.txt; cd ..) | while read log; do
PKG_NAME="$(dirname $log)"

# This branch takes care about packages which haven't been build.  
if grep "ERROR: $PKG_NAME failed" logs/package/error.txt; then
cat >> $PWD/logs/junit.xml << EOF
<testsuite errors='1' name='$PKG_NAME' tests='1'>
<testcase name='compile'>
<error message='$PKG_NAME failed to compile' type='error'><![CDATA[
$(tail -n 100 $PWD/logs/$log | sed -e 's|\]\]>|\]\] >|g' -e 's/\x1b//g')
]]></error>
</testcase>
</testsuite>
EOF

# This branch just makes notes about packages which have been built without problems
else
cat >> $PWD/logs/junit.xml << EOF
<testsuite errors='0' failures='0' name='$PKG_NAME' tests='1'>
<testcase name='compile'/>
</testsuite>
EOF
fi
done

# Close the XML file
cat >> $PWD/logs/junit.xml << EOF
</testsuites>
EOF


