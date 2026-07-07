#!/bin/bash
for dir in */; do
  dir=${dir%/}
  if [ -f "$dir/pubspec.yaml" ]; then
    echo "$dir: Flutter / Dart"
  elif [ -f "$dir/package.json" ]; then
    if grep -q '"vue"' "$dir/package.json"; then
      echo "$dir: Vue.js / JavaScript"
    elif grep -q '"react"' "$dir/package.json"; then
      echo "$dir: React / JavaScript"
    elif grep -q '"electron"' "$dir/package.json"; then
      echo "$dir: Electron / JavaScript"
    else
      echo "$dir: Node.js / JavaScript"
    fi
  elif [ -f "$dir/Cargo.toml" ]; then
    echo "$dir: Rust"
  elif [ -f "$dir/Makefile" ] || [ -f "$dir/CMakeLists.txt" ] || [ -d "$dir/src" ] && ls $dir/src/*.c >/dev/null 2>&1; then
    echo "$dir: C/C++ (Native)"
  elif [ -f "$dir/main.py" ] || ls $dir/*.py >/dev/null 2>&1; then
    echo "$dir: Python"
  else
    # Try to guess from files inside
    if ls $dir/*.c >/dev/null 2>&1 || ls $dir/*/*.c >/dev/null 2>&1; then
      echo "$dir: C/C++"
    elif ls $dir/*.py >/dev/null 2>&1 || ls $dir/*/*.py >/dev/null 2>&1; then
      echo "$dir: Python"
    else
      echo "$dir: Unknown"
    fi
  fi
done
