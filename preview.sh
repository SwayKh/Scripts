#! /usr/bin/env bash

image() {
  chafa "$1" -f sixels -s "${FZF_PREVIEW_COLUMNS}"x"${FZF_PREVIEW_LINES}" --polite on
}

batorcat() {
  file="$1"
  shift
  if command -v bat >/dev/null 2>&1; then
    bat --color=always --style=plain --pager=never "$file" "$@"
  else
    cat "$file"
  fi
}

glowormdcat() {
  file="$1"
  shift
  if command -v glow >/dev/null 2>&1; then
    glow "$file"
  else
    mdcat "$file"
  fi
}

CACHE="$HOME/.cache/lf/thumbnail.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}'))"

case "$(printf "%s\n" "$(readlink -f "$1")" | awk '{print tolower($0)}')" in
*.tgz | *.tar.gz) tar tzf "$1" ;;
*.tar.bz2 | *.tbz2) tar tjf "$1" ;;
*.tar.txz | *.txz) xz --list "$1" ;;
*.tar) tar tf "$1" ;;
*.zip | *.jar | *.war | *.ear | *.oxt) unzip -l "$1" ;;
*.rar) unrar l "$1" ;;
*.md)
  glowormdcat "$1"
  ;;
*.7z) 7z l "$1" ;;
*.[1-8]) man "$1" | col -b ;;
*.o) nm "$1" ;;
*.torrent) transmission-show "$1" ;;
*.iso) iso-info --no-header -l "$1" ;;
*.odt | *.ods | *.odp | *.sxw) odt2txt "$1" ;;
*.doc) catdoc "$1" ;;
*.docx) docx2txt "$1" ;;
*.xml | *.html) batorcat "$1" ;;
*.xls | *.xlsx)
  ssconvert --export-type=Gnumeric_stf:stf_csv "$1" "fd://1" | batorcat --language=csv
  ;;
*.wav | *.mp3 | *.flac | *.m4a | *.wma | *.ape | *.ac3 | *.og[agx] | *.spx | *.opus | *.as[fx] | *.mka)
  exiftool "$1"
  ;;
*.pdf)
  [ ! -f "${CACHE}.jpg" ] &&
    pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
  image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
  ;;
*.epub)
  [ ! -f "$CACHE" ] &&
    epub-thumbnailer "$1" "$CACHE" 1024
  image "$CACHE" "$2" "$3" "$4" "$5"
  ;;
*.cbz | *.cbr | *.cbt)
  [ ! -f "$CACHE" ] &&
    comicthumb "$1" "$CACHE" 1024
  image "$CACHE" "$2" "$3" "$4" "$5"
  ;;
*.avi | *.mp4 | *.wmv | *.dat | *.3gp | *.ogv | *.mkv | *.mpg | *.mpeg | *.vob | *.fl[icv] | *.m2v | *.mov | *.webm | *.ts | *.mts | *.m4v | *.r[am] | *.qt | *.divx)
  [ ! -f "${CACHE}.jpg" ] &&
    ffmpegthumbnailer -i "$1" -o "${CACHE}.jpg" -s 0 -q 5
  image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
  ;;
*.bmp | *.jpg | *.jpeg | *.png | *.xpm | *.webp | *.tiff | *.gif | *.jfif | *.ico)
  image "$1" "$2" "$3" "$4" "$5"
  ;;
*.svg)
  [ ! -f "${CACHE}.jpg" ] &&
    convert "$1" "${CACHE}.jpg"
  image "${CACHE}.jpg" "$2" "$3" "$4" "$5"
  ;;
*.ino)
  batorcat --language=cpp "$1"
  ;;
*)
  batorcat "$1"
  ;;
esac

# # Cleanup function
# cleanup() {
#   [[ -n "$thumb_cache" ]] && rm -f "$thumb_cache"
# }
# trap cleanup EXIT
#
# # MIME type of the file
# mime=$(file --mime-type -b "$1" 2>/dev/null)
#
# # Handle different MIME types
# case "$mime" in
# text/*)
#   # Use bat for text files
#   bat --color=always --style=numbers "$1" 2>/dev/null
#   ;;
# inode/directory)
#   tree "$1" 2>/dev/null
#   ;;
# image/jpeg | image/png | image/svg+xml)
#   # Use magick to display images in the terminal using sixel
#   # magick "$1" -geometry 800x480 sixel:- 2>/dev/null
#   # or use chafa
#   chafa "$1" -f sixels -s "${FZF_PREVIEW_COLUMNS}"x"${FZF_PREVIEW_LINES}"
#   ;;
# application/pdf)
#   # Use pdftotext for PDF files
#   pdftotext "$1" - | head -n 1000 2>/dev/null
#   ;;
# application/epub+zip)
#   # Use epub2txt for EPUB files
#   epub2txt "$1" | head -n 1000 2>/dev/null
#   ;;
# video/*)
#   # Generate a thumbnail for video files
#   thumb_cache=$(mktemp "${TMPDIR:-/tmp}/thumb_cache.XXXXX.png")
#   ffmpegthumbnailer -i "$1" -o "$thumb_cache" -s 0 2>/dev/null
#   # Display the thumbnail
#   img2sixel <"$thumb_cache" 2>/dev/null
#   ;;
# application/x-tar | application/gzip | application/x-compressed-tar | application/x-bzip2 | application/x-xz | application/zip | application/x-7z-compressed | application/x-rar-compressed)
#   ~/.config/lf/pistol-static-linux-x86_64 "$1" 2>/dev/null
#   ;;
# *)
#   # Default: show file details
#   echo "File type: $mime"
#   echo "No preview available for this file type."
#   ;;
# esac
