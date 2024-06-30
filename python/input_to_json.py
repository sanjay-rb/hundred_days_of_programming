s = ""
import json
import requests

responce = requests.get("https://raw.githubusercontent.com/sanjay-rb/hundred_days_of_programming/build/home_view/100.md")
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
    si = "task"+str(i).zfill(3)
    data[si] = {}
    title = ""
    description = []
    test_cases = []
    for line in str(task[i]).splitlines():
        if line.startswith("## Day"):
            title = line.removeprefix("## ").strip()
        
        if line.startswith("-"):
            description.append(line.removeprefix("-").strip())

        if line.startswith("### TestCase"):
            test_cases.append(line + "\n")
            continue

        if test_cases:
            test_cases[-1] += line + "\n"
    
    data[si]['title'] = title
    data[si]['day'] = i
    data[si]['description'] = description
    data[si]['testCases'] = test_cases
    data[si]['completedUsers'] = []

with open("100.json", "w") as outfile: 
    json.dump({"tasks":data}, outfile)