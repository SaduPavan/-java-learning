import os
import requests
from dotenv import load_dotenv

load_dotenv()

CONFLUENCE_BASE_URL = os.getenv('CONFLUENCE_BASE_URL')
CONFLUENCE_API_TOKEN = os.getenv('CONFLUENCE_API_TOKEN')
CONFLUENCE_PAGE_ID = os.getenv('CONFLUENCE_PAGE_ID')


def upload_docx_to_confluence(docx_path, title='Knowledge Article'):
    url = f"{CONFLUENCE_BASE_URL}/rest/api/content/{CONFLUENCE_PAGE_ID}/child/attachment"
    headers = {
        'Authorization': f'Bearer {CONFLUENCE_API_TOKEN}'
    }
    files = {
        'file': (os.path.basename(docx_path), open(docx_path, 'rb'), 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    }
    params = {
        'minorEdit': 'true',
        'comment': f'Automated upload: {title}'
    }
    response = requests.post(url, headers=headers, files=files, params=params)
    if response.status_code == 200 or response.status_code == 201:
        print('Upload successful!')
    else:
        print(f'Upload failed: {response.status_code} {response.text}') 