#!/bin/zsh

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Author: Matt Hrono
## MacAdmins: @matt_h

if [[ -e /Applications/Falcon.app/Contents/Resources/falconctl ]]; then
	falconStatus=$(/Applications/Falcon.app/Contents/Resources/falconctl stats | awk '/State/{print $2}' | head -n 1)
elif [[ -e /Library/CS/falconctl ]]; then
	falconStatus=$(/Library/CS/falconctl stats | awk '/State/{print $2}' | head -n 1)
else
	falconStatus="Not Found"
fi

echo "<result>$falconStatus</result>"