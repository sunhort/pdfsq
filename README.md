# pdfsq
ParallesPdfSqueezer
Script is intended to squeeze pdf files with parallels, ghostscript, pdfsqueeze on multicore machines to reduce compression time. Script has a cache file so directory with your documents can be processed without recompressing files that's are done. Thanks for Kris Occhipinti and Roel Van de Paar from Youtube for their videos of how to handle multiple commands within Parallels single command.

To use this bash script you need:
1. parallels (apt install parallels)
2. ghostscript-9.53.2-linux-x86_64  or newer version (available on github) 
3. cpdfsqueeze (available on github)

In order for the script to work change paths to your cloned directory in script, so binary files could be executed.

Put file into desired folder 
Make it exetutable 
chmod +x ./pdfsq.sh
and run 
./pdfsq.sh


The cool thing about script that it can process any files with any software available in Linux and keep the folder fith processed files while adding new files for processing is not a problem because it reads only new files from this folder. I personaly made it for my documents folder on NAS. Sometimes I print interesting articles from the internet into that folder but I don't like the size of certain PDF files so I decided to do a script to help me maintain personal articles collection in the smallest possible size without that much of the visual difference in pictures inside. 

To do lossless compression remove ghostscript sections and enjoy.
