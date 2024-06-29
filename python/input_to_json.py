s = ""
import json
import requests

responce = requests.get("https://raw.githubusercontent.com/sanjay-rb/100-Days-of-Code/main/README.md")
s = responce.text
current_id = ""
data = {"":{}}
md = ""
for l in s.splitlines():
    data[current_id]['md'] = md

    if l.startswith("# Day"):
        id, title = l.split(" - ")
        id = id.replace("# Day", "").strip()
        title = title.strip()
        if current_id != id:
            md = ""
            current_id = id
            data[current_id] = {"id":current_id, "title":title}

    if l.startswith("### "):
        _, url = l.split("(")
        url, _ = url.split(")")
        url = url.strip()
        data[current_id]["url"] =url

    md += l +"\n"

with open("input.json", "w") as outfile: 
    json.dump(data, outfile)