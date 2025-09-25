find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
while read -r f; do
  dir=$(dirname "$f")
  base=$(basename "$f")
  
  # Skip files that are already thumbnails
  if [[ "$base" == thumbnail_* ]]; then
    echo "Skipping (already a thumbnail): $f"
    continue
  fi
  # ✅ Skip files that are already compressed
  if [[ "$base" == compressed_* ]]; then
    echo "Skipping (thumbnail of already a compressed file): $f"
    continue
  fi

  out="$dir/thumbnail_$base"
  if [ ! -f "$out" ]; then
    echo "Creating thumbnail: $f → $out"
    convert "$f" -thumbnail 200x200 -strip -quality 80 "$out"
  fi
done
