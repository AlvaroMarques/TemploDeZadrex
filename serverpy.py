import argparse
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import parse_qs
import json
from baralho import Jogo
j = Jogo()
class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def _html(self, message):
        """This just generates an HTML document that includes `message`
        in the body. Override, or re-write this do do more interesting stuff.
        """
        content = f"{message}"
        return content.encode("utf8")  # NOTE: must return a bytes object!

    def do_GET(self):
        dictget = parse_qs(self.path[2:])
        pi = int(dictget.get("pi",["-1"])[0])
        pf = int(dictget.get("pf",["-1"])[0])
        if (pi != -1 and pf != -1):
            try:
                j.movimenta(pi, pf)
            except:
                pass
            
        r = j.retorno_final() 
        print(r["board"])
        r = json.dumps(r)
        self.send_response(200)
        self.send_header("Content-type", "text/json")
        self.send_header("Content-length", len(r))
        self.end_headers()
        self.wfile.write(self._html(r))

    def do_HEAD(self):
        self._set_headers()

    #Não vamos precisar de post nesse rolê
    def do_POST(self):
        self._set_headers()
        self.wfile.write(self._html("POST!"))


def run(server_class=HTTPServer, handler_class=S, addr="localhost", port=8000):
    server_address = (addr, port)
    httpd = server_class(server_address, handler_class)

    print(f"Starting httpd server on {addr}:{port}")
    httpd.serve_forever()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Run a simple HTTP server")
    parser.add_argument(
        "-l",
        "--listen",
        default="localhost",
        help="Specify the IP address on which the server listens",
    )
    parser.add_argument(
        "-p",
        "--port",
        type=int,
        default=8000,
        help="Specify the port on which the server listens",
    )
    args = parser.parse_args()
    run(addr=args.listen, port=args.port)
