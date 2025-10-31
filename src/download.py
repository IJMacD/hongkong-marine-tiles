#!/usr/bin/env python3

url = "https://eseago.hydro.gov.hk/v2/map_download?app_version=3.0.27&os=android&token=eseago"

# Get contents of the URL and parse as xml
import requests
import xml.etree.ElementTree as ET
response = requests.get(url)
root = ET.fromstring(response.content)
# Get text content of <file_path> tag
file_path = root.find('file_path').text
# Get the text content of <file_key> tag   
file_key = root.find('file_key').text
# Construct download URL
download_url = f"{file_path}?{file_key}"
# get basename from the url
import os
basename = os.path.basename(file_path)
print(f"Downloading {basename} from {download_url}")
# Download the file
file_response = requests.get(download_url)
# Save to local file
with open(basename, "wb") as f:
    f.write(file_response.content)
print(f"Downloaded {basename}")