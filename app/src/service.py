"""Threaded HTTP service exposing a health and info endpoint."""
import json
from datetime import datetime
from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn
from typing import Tuple

from .config import load_config


class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True


def _build_payload(path: str) -> Tuple[int, dict]:
    config = load_config()
    payload = {
        "service": config.service_name,
        "version": config.service_version,
        "environment": config.environment,
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "route": path,
    }

    if path == "/health":
        return 200, {"status": "ok", **payload}

    return 200, {"message": "DevOps bridge", **payload}


def _serialize(payload: dict) -> bytes:
    return json.dumps(payload, separators=(',', ':')).encode("utf-8")


class ServiceHandler(BaseHTTPRequestHandler):
    def _respond(self, status: int, body: dict) -> None:
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(_serialize(body))

    def do_GET(self) -> None:
        status, body = _build_payload(self.path)
        self._respond(status, body)

    def log_message(self, format_: str, *args) -> None:  # override to reduce noise
        return


def serve(host: str = "0.0.0.0", port: int | None = None) -> None:
    config = load_config()
    target_port = port or config.port
    with ThreadingHTTPServer((host, target_port), ServiceHandler) as server:
        print(f"Service starting on http://{host}:{target_port}")
        server.serve_forever()


if __name__ == "__main__":
    serve()
