import re
from http import HTTPStatus
from http.client import HTTPResponse
from urllib.request import urlopen


def main():
    url = 'https://raw.githubusercontent.com/MakinoharaShoko/WebGAL/main/packages/webgal/src/Core/config/scriptConfig.ts'
    with urlopen(url) as response:  # type: HTTPResponse
        if response.status != HTTPStatus.OK:
            raise RuntimeError(f'HTTP GET failed with {response.status}')
        body = response.read().decode('utf-8')
    commands = [m.group(1) for m in re.finditer(r"scriptString:\s*'([^']+)'", body)]
    commands.sort()
    print(f'Found {len(commands)} commands: {commands}')
    pattern = '|'.join(commands)
    print(pattern)


if __name__ == '__main__':
    main()
