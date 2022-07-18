cd ~/Desktop/
wget -O java.tar.gz https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-aarch64_bin.tar.gz
wget -O mc.zip https://tlauncher.org/jar
unzip -d mc mc.zip
tar -xf java.tar.gz
java -jar mc/*.jar
vared -p "Host (h) or client (c): " -c apmt
if [[ $apmt = "h" ]] then
ampi=$(ipconfig getifaddr en0)
mkdir mcs
fi
