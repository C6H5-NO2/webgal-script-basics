import re
from http import HTTPStatus
from http.client import HTTPResponse
from typing import List
from urllib.request import urlopen


def fetch(url: str, pattern: str) -> List[str]:
    with urlopen(url) as response:  # type: HTTPResponse
        if response.status != HTTPStatus.OK:
            raise RuntimeError(f'HTTP GET failed with {response.status}')
        body = response.read().decode('utf-8')
    tokens = [m.group(1) for m in re.finditer(pattern, body)]
    tokens.sort()
    return tokens


def subst(inpath: str, outpath: str, pattern: str, repl: str):
    # similar to `pattern=repl envsubst '$pattern' < inpath > outpath`
    with open(inpath, 'rt', encoding='utf-8') as infile:
        with open(outpath, 'wt', encoding='utf-8') as outfile:
            outfile.write(re.sub(pattern, repl, infile.read()))  # rel small files


def update_commands():
    url = 'https://raw.githubusercontent.com/MakinoharaShoko/WebGAL/main/packages/webgal/src/Core/config/scriptConfig.ts'
    pattern = r"scriptString:\s*'([^']+)'"
    tokens = fetch(url, pattern)
    print(f'Found {len(tokens)} commands: {tokens}')
    subst('build/webgal.tmLanguage.json.tpl', 'syntaxes/webgal.tmLanguage.json', r'\${WEBGAL_CMD}', '|'.join(tokens))


def update_configs():
    url = 'https://raw.githubusercontent.com/MakinoharaShoko/WebGAL/main/packages/webgal/src/Core/util/coreInitialFunction/infoFetcher.ts'
    pattern = r"e\[0\] === '([^']+)'"
    tokens = fetch(url, pattern)
    print(f'Found {len(tokens)} config keys: {tokens}')
    subst('build/webgal-config.tmLanguage.json.tpl', 'syntaxes/webgal-config.tmLanguage.json', r'\${WEBGAL_CFG}', '|'.join(tokens))


def main():
    update_commands()
    update_configs()


if __name__ == '__main__':
    main()
