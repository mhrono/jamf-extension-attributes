#!/bin/zsh

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Author: Matt Hrono
## MacAdmins: @matt_h

currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}   ')

extensions=$(sudo -u $currentUser cat /Users/$currentUser/Library/Containers/com.apple.Safari/Data/Library/Safari/AppExtensions/Extensions.plist | cut -c 7- | tr -d '(),' | awk '/^com./{print "Identifier: "$1"\nTeam ID: "$2}' | rev | cut -c 7- | rev)

echo "<result>$extensions</result>"
