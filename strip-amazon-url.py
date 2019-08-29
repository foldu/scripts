#!/usr/bin/env python3
from argparse import ArgumentParser
from urllib.parse import urlparse
from sys import stdin, exit
import re


def main():
    parser = ArgumentParser()
    parser.add_argument("urls", nargs="*")
    args = parser.parse_args()

    urls = (
        [line.strip() for line in stdin.readlines()]
        if len(args.urls) == 0
        else args.urls
    )

    rx = re.compile(r"/ref=[^/]*$")
    for url in map(urlparse, urls):
        stripped = url._replace(query="", path=rx.sub("", url.path), fragment="")
        print(stripped.geturl())


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        exit(1)
