import telnetlib
import json
from Crypto.Util.number import long_to_bytes
import binascii
import base64
import time


def _rot13(c):
    if 'A' <= c and c <= 'Z':
        # 13 文字分ずらす
        return chr((ord(c) - ord('A') + 13) % 26 + ord('A'))

    if 'a' <= c and c <= 'z':
        # 13 文字分ずらす
        return chr((ord(c) - ord('a') + 13) % 26 + ord('a'))

    # その他の文字は対象外
    return c


def rot13(s):
    # ジェネレータ内包表記で文字列に ROT13 を適用する
    g = (_rot13(c) for c in s)
    # 文字列に直す
    return ''.join(g)


HOST = "socket.cryptohack.org"
PORT = 13377

tn = telnetlib.Telnet(HOST, PORT)


def readline():
    return tn.read_until(b"\n")


def json_recv():
    line = readline()
    return json.loads(line.decode())


def json_send(hsh):
    request = json.dumps(hsh).encode()
    tn.write(request)


for i in range(101):
    received = json_recv()

    print(received)

    if received["type"] == "base64":
        encoded = str(base64.b64decode(received["encoded"].encode()))[
            2:-1]  # wow so encode
    elif received["type"] == "hex":
        encoded = binascii.a2b_hex(received["encoded"]).decode('utf-8')
    elif received["type"] == "rot13":
        encoded = rot13(received["encoded"])
    elif received["type"] == "bigint":
        encoded = str(long_to_bytes(int(received["encoded"], 16)))[2:-1]
    elif received["type"] == "utf-8":
        encoded = ("".join([chr(c) for c in received["encoded"]]))
    print("encoded", encoded)
    to_send = {
        "decoded": encoded
    }
    to_send = {
        "decoded": encoded
    }
    print(to_send)
    json_send(to_send)
    time.sleep(2)

