#!/usr/bin/env python3

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Source: https://www.jamf.com/jamf-nation/discussions/11307/chrome-extension-reporting#responseChild93506
## Updated for python3
## Only required change is the print syntax on the last line
## Modified 3/23/2021 to improve formatting and output extension IDs in addition to names

## Author: Matt Hrono
## MacAdmins: @matt_h

import os
import json
from Foundation import CFPreferencesCopyAppValue

#Get name of last logged in user so the extension attribute will report information for the user even if they aren't logged in"
lastloggedinuser = CFPreferencesCopyAppValue('lastUserName', 'com.apple.loginwindow')
userchromepath = '/Users/' + lastloggedinuser + '/Library/Application Support/Google/Chrome/'

#Initialize a dictionary to hold the variable names extension developers used if developers localized their extension
internationalized_extensions = {}

#Initialize a directory to hold the names of the installed extensions
installed_extensions = []

#walk the chrome application support folder
for (dirpath, dirnames, filenames) in os.walk(userchromepath):

    #Test to see if file is a manifest.json file and then check its name if it is a placeholder name for a localization file (has __MSG)
    #If it is a normal name, then add it to the final list. If its not, add it to the internationalized_extensions dictionary to match against a localized messages.json file
    for file in filenames:
        if "Extensions" in dirpath and "manifest.json" in file:
            manifest = json.load(open(os.path.join(dirpath, file)))
            extension_name = manifest.get('name')
            extension_id = dirpath.split(os.path.sep)[-2]
            if '__MSG_' not in extension_name:
                installed_extensions.append('Name: ' + extension_name + '\nID: ' + extension_id)
            else:
                extension_name = extension_name[6:-2]
                if extension_name not in internationalized_extensions:
                    internationalized_extensions[extension_name] = extension_name
        else:
            if 'Extensions' in dirpath and 'locales/en' in dirpath and 'messages.json' in file:
                manifest = json.load(open(os.path.join(dirpath, file)))
                extension_id = dirpath.split(os.path.sep)[-4]
                if not manifest:
                    continue
                for key in internationalized_extensions.keys():
                    if item := manifest.get(key):
                        extension_name = item.get('message')
                        installed_extensions.append('Name: ' + extension_name + '\nID: ' + extension_id)
                    elif item := manifest.get(key.lower()):
                        extension_name = item.get('message')
                        installed_extensions.append('Name: ' + extension_name + '\nID: ' + extension_id)

print("<result>{}</result>".format('\n\n'.join(sorted(list(set(installed_extensions))))))
