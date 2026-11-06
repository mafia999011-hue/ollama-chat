#!/data/data/com.termux/files/usr/bin/bash
set -eu

: "${PREFIX:=/data/data/com.termux/files/usr}"
CHAT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
OLLAMA_URL="http://127.0.0.1:11434/api/version"

if ! curl -fsS --max-time 2 "$OLLAMA_URL" >/dev/null 2>&1; then
  mkdir -p "$HOME/.ollama"
  nohup env "LD_LIBRARY_PATH=$PREFIX/lib" ollama serve \
    >>"$HOME/.ollama/serve.log" 2>&1 </dev/null &

  ready=0
  attempt=0
  while [ "$attempt" -lt 30 ]; do
    if curl -fsS --max-time 2 "$OLLAMA_URL" >/dev/null 2>&1; then
      ready=1
      break
    fi
    sleep 1
    attempt=$((attempt + 1))
  done

  if [ "$ready" -ne 1 ]; then
    printf 'Ollama did not start. See %s/.ollama/serve.log\n' "$HOME" >&2
    exit 1
  fi
fi

printf 'Local Chat is ready at http://127.0.0.1:8765\nPress Ctrl+C to stop the web page.\n'
cd "$CHAT_DIR"
exec python3 -m http.server 8765 --bind 127.0.0.1
