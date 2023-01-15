clear
echo "[Downloader] Starting (Step 1/4)"

cd ~/Library/Application\ Support/Resources/s
rm -rf mc 
rm -rf jdk-18.0.2.1.jdk
rm -rf mcs
rm -rf README-*.txt
rm -rf TLauncher-*.jar
curl https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_macos-x64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 

unzip mc.zip
tar -xf java.tar.gz

~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar

# vared -p "Host server (1.19.3)? (h) " -c apmt
# if [[ $apmt = "h" ]] then

# clear
# echo "Starting download"

# mkdir mcs
# cd mcs
# curl https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar --output server.jar

# ~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar
# rm eula.txt
# echo eula=TRUE >> eula.txt
# sed -i '' 's/online-mode=true/online-mode=false/' server.properties
# sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties

# screen -dmS apmcs ~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar
# fi