#!/bin/bash
output=$(zenity --entry \
--title="Enter the Output File-Name" \
--text="Enter the Output File-Name:" \
--entry-text "Output File-Name")
cvlc video.webm :input-slave=audio.webm --sout=#transcode{scodec=none}:std{access=file{no-overwrite},mux=webm,dst="$output" --play-and-exit
