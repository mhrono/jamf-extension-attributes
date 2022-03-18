#!/bin/zsh

####
## Copyright 2022 Buoy Health, Inc.

## Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

## Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
####

## Author: Matt Hrono
## MacAdmins: @matt_h

## Check NVRAM to see if Find My Mac is enabled and report up to jamf.
## If enabled, need to communicate with the user to disable it before pushing down a profile to block the checkbox.
## If the restriction profile is pushed prior to the user disabling it, the box is locked as checked and the user cannot disable.
FMMstatus=$(nvram -x -p | grep fmm-mobileme-token-FMM)

if [[ $FMMstatus ]]; then isEnabled="yes"; else isEnabled="no"; fi

echo "<result>$isEnabled</result>"