s = ""
import json
import requests

responce = requests.get("https://raw.githubusercontent.com/sanjay-rb/hundred_days_of_programming/main/100.md")
s = responce.text
data = {}

task = s.split("---")

def extract_test_case(string):
    test_cases = []
    for line in str(string[i]).splitlines():
        if line.startswith("### TestCase"):
            test_cases.append(line)
        if test_cases[-1]:
            test_cases[-1] += line
    return test_cases

for i in range(1, 100+1):
    print(i)
    si = "task"+str(i).zfill(3)
    data[si] = {}
    title = ""
    description = []
    test_cases = []
    for line in str(task[i]).splitlines():
        if line.startswith("## Day"):
            line = line.removeprefix("## Day").strip()
            _, line = line.split(' - ')
            title = line.strip()
        
        if line.startswith("-"):
            description.append(line.removeprefix("-").strip())

        if line.startswith("### TestCase"):
            test_cases.append(line + "\n")
            continue

        if test_cases:
            test_cases[-1] += line + "\n"
    
    data[si]['title'] = title
    data[si]['id'] = si
    data[si]['day'] = i
    data[si]['description'] = description
    data[si]['testCases'] = test_cases

with open("100.json", "w") as outfile: 
    json.dump({"tasks":data}, outfile)