#!/usr/bin/env python3
"""
Simple HTTP server for hosting Quark documentation locally.
Usage: python serve.py [port]
"""

import http.server
import socketserver
import webbrowser
import os
import sys
from pathlib import Path

# Default port
PORT = 8000

# Get port from command line argument if provided
if len(sys.argv) > 1:
    try:
        PORT = int(sys.argv[1])
    except ValueError:
        print(f"Invalid port: {sys.argv[1]}")
        sys.exit(1)

# Determine the docs directory (same location as this script)
SCRIPT_DIR = Path(__file__).parent.resolve()
DOCS_DIR = SCRIPT_DIR / "docs"

# If docs folder doesn't exist here, check if we're already in it
if not DOCS_DIR.exists():
    if (SCRIPT_DIR / "docs/index.html").exists():
        DOCS_DIR = SCRIPT_DIR
    else:
        print(f"Error: Could not find docs directory at {DOCS_DIR}")
        print("Make sure serve.py is in the same folder as the docs directory.")
        sys.exit(1)

os.chdir(DOCS_DIR)

class Handler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Add CORS headers for local development
        self.send_header("Access-Control-Allow-Origin", "*")
        super().end_headers()

    def log_message(self, format, *args):
        # Custom logging with colors
        print(f"[{self.address_string()}] {format % args}")

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    url = f"http://localhost:{PORT}"
    print(f"\n{'='*50}")
    print(f"  Quark Documentation Server")
    print(f"{'='*50}")
    print(f"  Serving: {DOCS_DIR}")
    print(f"  URL: {url}")
    print(f"{'='*50}\n")
    
    # Open browser automatically
    webbrowser.open(url)
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n\nServer stopped.")
        httpd.shutdown()
