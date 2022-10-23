cd ~/Desktop/
rm -rf mc 
rm -rf java
rm -rf mcs
mkdir java
curl https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-x64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 
unzip mc.zip
tar -xf java.tar.gz -C java
clear
echo "Downloaded Java18 and Minecraft."
ampi=$(ipconfig getifaddr en0)
vared -p "Host server? (h) " -c apmt
if [[ $apmt = "h" ]] then
mkdir mcs
cd mcs
curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar
clear
echo "Downloaded Java18, Minecraft, and the server."
~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
rm eula.txt
echo eula=TRUE >> eula.txt
sed -i '' 's/online-mode=true/online-mode=false/' server.properties
sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties
screen -dmS mcs ~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
clear
echo "Downloaded Java18, Minecraft, and the server."
echo "Server started, launching Minecraft"
fi
cd ~/Desktop
~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar
if [[ $apmt = "h" ]] then
clear
echo "Connect to $ampi"
fi
