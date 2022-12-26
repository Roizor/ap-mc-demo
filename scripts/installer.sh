clear
echo "[APMC] Installing"

#TODO: Replace launcher,jdk,server (w/ package)

vared -p "[APMC] Host server? (y) " -c apmt
if [[ $apmt = "y" ]] then

clear
echo "[APMC: Server] Starting (Step 1/4)"

mkdir mcs
cd mcs
curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar

clear
echo "[APMC: Server] Downloaded (Step 2/4)"

~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar
rm eula.txt
echo eula=TRUE >> eula.txt
sed -i '' 's/online-mode=true/online-mode=false/' server.properties
sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties

clear
echo "[Downloader: Server] Configured (Step 3/4)"

screen -dmS apmcs ~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar

clear
echo "[Downloader: Server] Launched (Step 4/4)"
fi