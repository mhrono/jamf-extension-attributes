#!/bin/zsh

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Author: Matt Hrono
## MacAdmins: @matt_h

loggedInUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}  ')
	currentUID=$(dscl . -list /Users UniqueID | grep $loggedInUser 2>/dev/null | awk '{print $2;}')
	
	if [[ $currentUID -gt 500 ]]; then
		displayName=$(defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.state DisplayName)
	fi
	
	echo "<result>$displayName</result>"