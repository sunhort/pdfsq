 #!/bin/bash
echo '
   ▄▄▄▄▄     ▄      ▄    ▄  █ ████▄ █▄▄▄▄    ▄▄▄▄▀        ▄▄▄▄▄   ▄█▄    █▄▄▄▄ ▄█ █ ▄▄     ▄▄▄▄▀
  █     ▀▄    █      █  █   █ █   █ █  ▄▀ ▀▀▀ █          █     ▀▄ █▀ ▀▄  █  ▄▀ ██ █   █ ▀▀▀ █
▄  ▀▀▀▀▄   █   █ ██   █ ██▀▀█ █   █ █▀▀▌      █        ▄  ▀▀▀▀▄   █   ▀  █▀▀▌  ██ █▀▀▀      █
 ▀▄▄▄▄▀    █   █ █ █  █ █   █ ▀████ █  █     █          ▀▄▄▄▄▀    █▄  ▄▀ █  █  ▐█ █        █
           █▄ ▄█ █  █ █    █          █     ▀                     ▀███▀    █    ▐  █      ▀
            ▀▀▀  █   ██   ▀          ▀                                    ▀         ▀
'
echo 'Encoding files, do not cancel or interrupt in order to avoid the loss of data...'
sleep 2
echo 'Creating database of pdf compressed files'
sleep 2
if [ -f "./pdfcache.lst" ]; then
mv ./pdfcache.lst ./pdfcache_done.lst;
find . -name "*.pdf" | parallel --bar --eta 'echo {}>>pdfcache.lst';
find . -name "*.PDF" | parallel --bar --eta 'echo {}>>pdfcache.lst';
awk 'NR == FNR { list[tolower($0)]=1; next } { if (! list[tolower($0)]) print }' pdfcache_done.lst pdfcache.lst>>pdfcache_new.lst;
rm -f pdfcache.lst;
echo 'Compress pdfs';
sleep 2;
cat pdfcache_new.lst | parallel --bar --eta '/home/ubuntu/ghostscript-9.53.2-linux-x86_64/gs-9532-linux-x86_64 -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dConvertCMYKImagesToRGB=true -dDetectDuplicateImages=true -dPrinted=false -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile={.}_compressed.pdf {} && mv {.}_compressed.pdf {} && /home/ubuntu/cpdfsqueeze/cpdfsqueeze {} {.}_compressed.pdf && mv {.}_compressed.pdf {}';
else find . -name "*.pdf" | parallel --bar --eta 'echo {}>>pdfcache.lst'; fi
echo 'Compress pdfs'
sleep 2
if [ -f "./pdfcache.lst" ]; then cat pdfcache.lst | parallel --bar --eta '/home/ubuntu/ghostscript-9.53.2-linux-x86_64/gs-9532-linux-x86_64 -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dConvertCMYKImagesToRGB=true -dDetectDuplicateImages=true -dPrinted=false -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile={.}_compressed.pdf {} && mv {.}_compressed.pdf {} && /home/ubuntu/cpdfsqueeze/cpdfsqueeze {} {.}_compressed.pdf && mv {.}_compressed.pdf {}'; fi
if [ -f "./pdfcache_done.lst" ]; then cat pdfcache_done.lst >> pdfcache.lst;
rm -f pdfcache_done.lst; fi
sleep 1
if [ -f "./pdfcache_new.lst" ]; then cat pdfcache_new.lst >> pdfcache.lst;
rm -f pdfcache_new.lst; fi
echo '
███████╗██╗███╗   ██╗██╗███████╗██╗  ██╗███████╗██████╗
██╔════╝██║████╗  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗
█████╗  ██║██╔██╗ ██║██║███████╗███████║█████╗  ██║  ██║
██╔══╝  ██║██║╚██╗██║██║╚════██║██╔══██║██╔══╝  ██║  ██║
██║     ██║██║ ╚████║██║███████║██║  ██║███████╗██████╔╝
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═════╝
'
