#!/bin/zsh

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Author: Matt Hrono
## MacAdmins: @matt_h

currentUser=$(stat -f %Su /dev/console)

passwordLastSetEpoch=$(dscl . read /Users/$currentUser accountPolicyData | awk '/passwordLastSetTime/{getline; print $0}' | cut -c 8- | rev | cut -c 8- | rev | awk -F'.' '{print $1}')

daysSinceSet=$((($(date +"%s") - $passwordLastSetEpoch) / 86400))

echo "<result>$daysSinceSet</result>"