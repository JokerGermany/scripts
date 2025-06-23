#!/bin/bash
set -x
if { [ -f "video.webm" ] && [ -f "audio.webm" ]; } || { [ -f "video.mp4" ] && [ -f "audio.m4a" ]; }
then
  if [ -f "video.webm" ] && [ -f "audio.webm" ]; then
    videoformat=webm
    audioformat=webm
  elif [ -f "video.mp4" ] && [ -f "audio.m4a" ]; then
    videoformat=mp4
    audioformat=m4a
  else
    echo "Keine passenden Dateipaare gefunden."
    exit 1
  fi
  pfad="/media/HDD"
  # Freien Speicherplatz in Kilobyte ermitteln
  frei_kb=$(df --output=avail -k "$pfad" | tail -n 1)
  grenze_kb=$(( ( $(stat --format=%s video."$videoformat") + $(stat --format=%s audio."$audioformat") + 1000 ) / 1024 ))
  if [[ "$frei_kb" -lt "$grenze_kb" ]]
  then
      echo "Zu wenig Speicher frei auf $pfad. Skript wird beendet."
      exit 1
  fi
  output=$(zenity --entry \
  --title="Enter the Output File-Name" \
  --text="Enter the Output File-Name:" \
  --entry-text "Output File-Name")."$videoformat"
  cvlc video."$videoformat" :input-slave=audio."$audioformat" --sout=#transcode{scodec=none}:std{access=file{no-overwrite},mux="$videoformat",dst="$output" --play-and-exit
  rc=$?
  #cvlc video.webm :input-slave=audio.webm --sout=#transcode{scodec=none}:std{access=file{no-overwrite},mux=webm,dst="$1" --play-and-exit
  if [[ $rc -eq 0  &&  `stat -c%s "$output"` -gt `stat -c%s video."$videoformat"` ]]
  then  
    rm audio."$audioformat" video."$videoformat"
    exit 0
  else
    echo "The script did not run" >&2
    exit 1
  fi
else
  echo "audiofile and/or videofile don't exist!" >&2
  exit 1
fi
