cd ~/Desktop/
rm -rf mc 
rm -rf java
rm -rf mcs
mkdir java
curl https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-aarch64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 
unzip mc.zip
tar -xf java.tar.gz -C java
ampi=$(ipconfig getifaddr en0)
vared -p "Host server? (h) " -c apmt
if [[ $apmt = "h" ]] then
mkdir mcs
cd mcs
curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar
~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
rm eula.txt
echo eula=TRUE >> eula.txt
sed -i '' 's/online-mode=true/online-mode=false/' server.properties
sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties
screen -dmS mcs ~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
echo "server started, launching minecraft"
echo "connect to $ampi"
fi
cd ~/Desktop
~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar
