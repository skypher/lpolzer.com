#!/bin/bash

set -x

set -e
which kramdown cat mkdir cp >/dev/null
set +e

function html_escape() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

OUTDIR=out/posts

mkdir -p "$OUTDIR"

# posts/index
echo '<h2>Articles</h2>' > out/index.frag.html
echo '<ul class="articles">' > out/index.frag.html
for f in posts/*; do
  kramdown $f | cat templates/template-head.frag.html - templates/template-foot.frag.html > "out/$f.html"
  TITLE=$(grep h1 "out/$f.html" | sed 's!</\?h1[^>]*>!!g' | html_escape)
  echo "<li><a href='posts/$f.html'>$TITLE</a></li>" >> out/index.frag.html
done
echo '</ul>' >> out/index.frag.html
cat templates/template-head.frag.html out/index.frag.html templates/template-foot.frag.html > "out/index.html"

# css
mkdir -p out/css
cp -av css/* out/css/

# cv
cp -av cv/ out/
