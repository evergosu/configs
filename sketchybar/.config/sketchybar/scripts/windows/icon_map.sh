#!/usr/bin/env bash

function __icon_map() {
    case "$1" in
   "App Store")
        icon_result=
        ;;
   "Battle.net")
        icon_result=
        ;;
   "Blender")
        icon_result=󰂫
        ;;
   "Brave Browser")
        icon_result=
        ;;
   "Calculator")
        icon_result=󱖦
        ;;
   "Calendar")
        icon_result=
        ;;
   "Citrix Workspace" | "Citrix Viewer")
        icon_result=󰐷
        ;;
   "Code" | "Code - Insiders")
        icon_result=󰨞
        ;;
   "Discord" | "Discord Canary" | "Discord PTB")
        icon_result=
        ;;
   "Docker" | "Docker Desktop")
        icon_result=
        ;;
   "Dropbox")
        icon_result=
        ;;
   "Figma")
        icon_result=
        ;;
   "Finder")
        icon_result=󰀶
        ;;
   "Firefox" | "Firefox Developer Edition" | "Firefox Nightly")
        icon_result=
        ;;
   "Folx")
        icon_result=
        ;;
   "System Preferences" | "System Settings")
        icon_result=
        ;;
   "GitHub Desktop")
        icon_result=
        ;;
   "Chromium" | "Google Chrome" | "Google Chrome Canary")
        icon_result=' '
        ;;
   "kitty")
        icon_result=
        ;;
   "Mail")
        icon_result=
        ;;
   "Messages")
        icon_result=󰵅
        ;;
   "Microsoft Edge")
        icon_result=󰇩
        ;;
   "Miro")
        icon_result=󰚗
        ;;
   "MongoDB Compass"*)
        icon_result=
        ;;
   "Notes")
        icon_result=󰺿
        ;;
   "Notion")
        icon_result=󰰒
        ;;
   "Obsidian")
        icon_result=
        ;;
   "Postman")
        icon_result=
        ;;
   "Safari" | "Safari Technology Preview")
        icon_result=󰀹
        ;;
   "Slack")
        icon_result=󰒱
        ;;
   "Spotify")
        icon_result=
        ;;
   "Telegram")
        icon_result=
        ;;
   "Terminal")
        icon_result=
        ;;
   "Tor Browser")
        icon_result=
        ;;
   "VLC")
        icon_result=󰕼
        ;;
   "zoom.us")
        icon_result=
        ;;
    *)
        icon_result=
        ;;
    esac
}
