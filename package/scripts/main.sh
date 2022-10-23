$CpuType=$( sysctl -a | grep brand )

if [[ $CpuType =~ "Apple" ]]; then
    echo "Apple"
else
    echo "Intel"
fi