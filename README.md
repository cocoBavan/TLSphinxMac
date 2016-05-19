# TLSphinxMac
The build script to use for mac
How to use
Download PocketSphinx and SphinxBase from http://cmusphinx.sourceforge.net/wiki/download
run ./autogen.sh in them
run distclean
Then copy build_mac.sh in both folders and run it.
Now you will see static libraries and headers for each architectures inside bin folder.
Now checkout https://github.com/tryolabs/TLSphinx
Delete all .a,header files and replace them with the ones we generated with new script.
Create fat libaries : 
      lipo -create "./x86_64/libpocketsphinx.a" "./i386/libpocketsphinx.a" -output "libpocketsphinx.a"
      lipo -create "./x86_64/libsphinxbase.a" "./i386/libsphinxbase.a" -output "libsphinxbase.a"
      lipo -create "./x86_64/libsphinxad.a" "./i386/libsphinxad.a" -output "libsphinxad.a"
Change the Architecture and SDK of the TLSPhinx Build Settings.
Build the Porject Vola.
Now manually drag and drop this modified TLSphinx project on to your Project.
And if you need the default assets, find them in the "share" folder and add them to the project via Build Phases-> Copy Bundle Resources
