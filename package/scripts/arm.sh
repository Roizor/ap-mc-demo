WorkingDir="~/Library/Application Support/Resources/s"

clear
echo "[Downloader] Starting (Step 1/4)"

cd $WorkingDir
rm -rf mc 
rm -rf jdk-18.0.1.1.jdk
rm -rf mcs
curl https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-aarch64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 

clear
echo "[Downloader] Downloaded (Step 2/4)"

unzip mc.zip
tar -xf java.tar.gz

clear
echo "[Downloader] Extracted (Step 3/4)"

"$WorkingDir"/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar

clear
echo "[Downloader] Launched (Step 4/4)"

vared -p "Host server? (h) " -c apmt
if [[ $apmt = "h" ]] then

clear
echo "[Downloader: Server] Starting (Step 1/4)"

mkdir mcs
cd mcs
curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar

clear
echo "[Downloader: Server] Downloaded (Step 2/4)"

"$WorkingDir"/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
rm eula.txt
echo eula=TRUE >> eula.txt
sed -i '' 's/online-mode=true/online-mode=false/' server.properties
sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties

clear
echo "[Downloader: Server] Configured (Step 3/4)"

screen -dmS apmcs "$WorkingDir"/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar

clear
echo "[Downloader: Server] Launched (Step 1/4)"
fi