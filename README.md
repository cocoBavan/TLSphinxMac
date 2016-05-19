# TLSphinxMac
This is the build script to use when Building TLSphinx framework for mac     
How to use     
01. Download PocketSphinx and SphinxBase from http://cmusphinx.sourceforge.net/wiki/download   
02. run ./autogen.sh in them  
03. run distclean  
04. Then copy build_mac.sh in both folders and run it.  
05. Now you will see static libraries and headers for each architectures inside bin folder.  
06. Now checkout https://github.com/tryolabs/TLSphinx  
07. Delete all .a,header files and replace them with the ones we generated with new script.  
08. Create fat libaries :     
    $ lipo -create "./x86_64/libpocketsphinx.a" "./i386/libpocketsphinx.a" -output "libpocketsphinx.a"  
    $ lipo -create "./x86_64/libsphinxbase.a" "./i386/libsphinxbase.a" -output "libsphinxbase.a"  
    $ lipo -create "./x86_64/libsphinxad.a" "./i386/libsphinxad.a" -output "libsphinxad.a"  
09. Change the Architecture and SDK of the TLSPhinx Build Settings.  
10. Build the Porject Vola. 
11. Now manually drag and drop this modified TLSphinx project on to your Project.  
12. And if you need the default assets, find them in the "share" folder and add them to the project via Build Phases-> Copy Bundle Resources 
