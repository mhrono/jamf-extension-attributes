#!/usr/bin/env python3

"""
Copyright 2022 Buoy Health, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
"""

## Author: Matt Hrono
## MacAdmins: @matt_h

import json
import os
import sys
from SystemConfiguration import SCDynamicStoreCopyConsoleUser

## Load the addons json file for the current user's Firefox profiles and output names and IDs for all installed addons

currentUserName = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; currentUserName = [currentUserName,""][currentUserName in ["loginwindow", None, ""]]
currentUserHome = '/Users/' + currentUserName

if os.path.isdir(currentUserHome + '/Library/Application Support/Firefox/Profiles'):
	profiles = os.listdir(currentUserHome + '/Library/Application Support/Firefox/Profiles')
else:
	print('<result>Firefox not installed.</result>')
	exit(0)

addons = []

for profile in profiles:
	addonsFile = currentUserHome + '/Library/Application Support/Firefox/Profiles/' + profile + '/addons.json'
	if os.path.exists(addonsFile):
		with open(addonsFile) as file:
			data = json.load(file)
		addons.append('\n' + 'Profile: ' + profile + '\n')
		for addon in data['addons']:
			addons.append('Name: ' + addon['name'] + '\nID: ' + addon['id'])
	else:
		addons.append('\n' + 'Profile: ' + profile + ': No addons found.')

print("<result>{}</result>".format('\n'.join(list(addons))))