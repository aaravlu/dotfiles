#!/bin/sh
for file in "$@"; do
    [ ! -f "$file" ] && echo "跳过: $file (不存在或不是文件)" && continue
    awk '{
        if ($0 ~ /^\./)
            print "0\t" $0;
        else
            print "1\t" $0
    }' "$file" \
    | sort -k1,1 -k2 \
    | cut -f2- > "$file.tmp" && mv "$file.tmp" "$file"
done
