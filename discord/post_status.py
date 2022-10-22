from discord import SyncWebhook
import json
import os
import sys


def get_webhook_url(fpath='.env'):
    if not os.path.isfile(fpath):
        raise Exception(f"Could not locate config file: {fpath}")

    with open(fpath, 'r') as f:
        data = json.load(f)
    
    if 'webhook_url' not in data:
        raise Exception(f"Could not locate webhook URL in {data}")

    return data['webhook_url']

def found_winner(message, enable_icons=True):
    if enable_icons:
        msg = f':boom: {message} :boom:'
    else:
        msg = message

    url = get_webhook_url()
    webhook = SyncWebhook.from_url(url)
    webhook.send(msg)

if __name__ == '__main__':

    if len(sys.argv) != 2:
        sys.exit(f'Usage: ./{sys.argv[0]} "<message to send to discord>"')

    found_winner(sys.argv[1])