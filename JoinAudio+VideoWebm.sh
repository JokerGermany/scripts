#!/bin/bash
if [[ -f video.webm && -f audio.webm ]]
then
  output=$(zenity --entry \
  --title="Enter the Output File-Name" \
  --text="Enter the Output File-Name:" \
  --entry-text "Output File-Name").webm
  cvlc video.webm :input-slave=audio.webm --sout=#transcode{scodec=none}:std{access=file{no-overwrite},mux=webm,dst="$output" --play-and-exit
  rc=$?
  #cvlc video.webm :input-slave=audio.webm --sout=#transcode{scodec=none}:std{access=file{no-overwrite},mux=webm,dst="$1" --play-and-exit
  if [[ $rc -eq 0  &&  `stat -c%s "$output"` -gt `stat -c%s video.webm` ]]
  then  
    rm audio.webm video.webm
    exit 0
  else
    echo "The script did not run" >&2
    exit 1
  fi
else
  echo "audio.webm and/or video.webm don't exist!" >&2
  exit 1
fi
