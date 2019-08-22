#!/usr/bin/env python3
from argparse import ArgumentParser
from datetime import datetime
import subprocess
import sys


def main():
    parser = ArgumentParser()
    parser.add_argument("-s", "--select", action="store_true")
    parser.add_argument(
        "filename", nargs="?", default=datetime.now().isoformat() + ".png"
    )
    args = parser.parse_args()

    try:
        cmd = ["grim"]
        if args.select:
            out = subprocess.run(["slurp"], stdout=subprocess.PIPE, check=True)
            cmd += ["-g", out.stdout.decode("utf-8").strip()]

        cmd.append(args.filename)

        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError:
        sys.exit(1)


if __name__ == "__main__":
    main()
