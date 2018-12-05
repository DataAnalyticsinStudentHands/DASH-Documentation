#!/usr/local/bin/python3
from subprocess import Popen, PIPE, call
import requests
import json

p = Popen(['/usr/local/spruce/spruce name -v'], stdout=PIPE, shell=True)
output = p.communicate()[0]


url = 'https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000040704.json'
output_tokens = output.decode('utf-8').split('\n')
html_formatted_output = '<table style="width:100%"><tr><th>Application</th><th>Versions</th></tr><tr><td>' + output_tokens[0]
markdown_formatted_output = 'Application | Versions\n--- | ---\n' + output_tokens[0]
version=False
output_tokens.pop(0)
for token in output_tokens:
	if token == '':
		continue
	if not version:
		if token[0] == '\t':
			html_formatted_output += '<td>' + token[1:]
			markdown_formatted_output += ' | ' + token[1:]
			version=True
		else:
			html_formatted_output += '</td><td></td></tr><tr><td>' + token
			markdown_formatted_output += ' | \n' + token
	else:
		if token[0] == '\t':
			html_formatted_output += ', ' + token[1:]
			markdown_formatted_output += ', ' + token[1:]
		else:
			html_formatted_output += '</td></tr><tr><td>' + token
			markdown_formatted_output += '\n' + token
			version=False
if not version:
	html_formatted_output += '</td><td>'
	markdown_formatted_output += ' | '
html_formatted_output += '</td></tr></table>'
data = {
    'solution_article': {
    'description': html_formatted_output
    }
}
headers = {'Content-Type': 'application/json'}
auth=('2k0wudpPKxvNuR4xmzS', 'X')
r = requests.put(url, auth=auth, json=data, headers=headers)
call("/usr/bin/git --git-dir=/usr/local/spruce/docs-repo/DASH-Documentation/.git/ --work-tree=/usr/local/spruce/docs-repo/DASH-Documentation/ pull", shell=True)
markdown_file = open('/usr/local/spruce/docs-repo/DASH-Documentation/Honors IT/Infrastructure/software_list.md', 'w')
markdown_file.write(markdown_formatted_output)
markdown_file.close()
call("/usr/bin/git --git-dir=/usr/local/spruce/docs-repo/DASH-Documentation/.git/ --work-tree=/usr/local/spruce/docs-repo/DASH-Documentation/ add /usr/local/spruce/docs-repo/DASH-Documentation/Honors\ IT/Infrastructure/software_list.md", shell=True)
call("/usr/bin/git --git-dir=/usr/local/spruce/docs-repo/DASH-Documentation/.git/ --work-tree=/usr/local/spruce/docs-repo/DASH-Documentation/ commit -m 'Updated software_list.md'", shell=True)
call("/usr/bin/git --git-dir=/usr/local/spruce/docs-repo/DASH-Documentation/.git/ --work-tree=/usr/local/spruce/docs-repo/DASH-Documentation/ push", shell=True)
