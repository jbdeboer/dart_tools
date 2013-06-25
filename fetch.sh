set -xve

URL=https://storage.googleapis.com/dart-editor-archive-integration/latest/darteditor-linux-64.zip

LASTETAG=$(cat latest/.etag || true)

ETAG=$(curl -I "$URL" | grep ETag)

if [[ "$LASTETAG" = "$ETAG" ]]; then
  echo "Up-to-date." >/dev/stderr
  exit 0
fi

ID=$(date +%b%d)

curl "$URL" -o $ID.zip

unzip $ID.zip

mv dart $ID

echo "$ETAG" > $ID/.etag

rm -f latest
ln -s $ID latest
