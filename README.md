# Local Ollama Chat

A small, phone-friendly chat page for models served by Ollama on the same Android device. It streams replies, lets you choose an installed model, and keeps conversation context in the current browser tab.

The page binds to `127.0.0.1`; it is intended for use on the device and is not exposed to your network.

## Start

In Termux, from this directory, run:

```sh
chmod +x start.sh
./start.sh
```

Then open <http://127.0.0.1:8765> in the phone's browser. Leave this terminal session running while you chat. The launcher starts Ollama in the background if its API is not already available, then runs the local web page.

Install Ollama and at least one model first. For example:

```sh
ollama pull qwen3:0.6b
```

The page's model menu refreshes when you reload it. `qwen3:0.6b` is the lightest of the models used during setup and is a good first choice on a phone.

## Troubleshooting

- If the page says Ollama is unavailable, check that `ollama serve` is running, then reload.
- If a model runner exits with a missing `libc++` symbol, stop the old Ollama server and relaunch with `./start.sh`. The launcher sets Termux's library path for Ollama.
- If a response is slow, try a smaller model and close other model sessions.

## Privacy

Chat text is sent only to the Ollama API at `127.0.0.1:11434`. This page does not save conversations to disk or send them to a hosted service. The browser tab keeps the context only while it is open.
