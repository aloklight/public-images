find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
while read -r f; do
  dir=$(dirname "$f")
  base=$(basename "$f")

  # ✅ Skip files that are already compressed
  if [[ "$base" == compressed_* ]]; then
    echo "Skipping (already a compressed file): $f"
    continue
  fi
  # Skip files that are already thumbnails
  if [[ "$base" == thumbnail_* ]]; then
    echo "Skipping (compressed version of already a thumbnail file): $f"
    continue
  fi

  out="$dir/compressed_$base"

  # ✅ Skip if a compressed version already exists
  if [ -f "$out" ]; then
    echo "Skipping (compressed version exists): $out"
    continue
  fi

  echo "Compressing: $f → $out"
  convert "$f" -strip -quality 70 "$out"
done
