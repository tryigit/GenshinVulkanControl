#!/bin/bash

nohup am start -a android.intent.action.VIEW -d https://t.me/chinacloudgroup >/dev/null 2>&1 &

# Get device @tryigitx
brand=$(getprop ro.product.brand)
model=$(getprop ro.product.model)

# Set variables for app packages
YS_PACKAGE="com.miHoYo.Yuanshen"
YS_PACKAGE2="com.miHoYo.ys"
GI_PACKAGE="com.miHoYo.GenshinImpact"

# Function to enable Vulkan @tryigitx
enable_vulkan() {

  local json="/storage/emulated/0/Android/data/$1/files/hardware_model_config.json"
  
  if [ -f "$json" ]; then
  
    chmod 644 "$json"
 
    # Delete existing configs
    > "$json"
    
    # Add new entry
    echo "{" >> "$json"
    echo "  \"configs\": [" >> "$json"
    echo "    {" >> "$json"
    echo "      \"hardwareModel\": \"$brand $model\"," >> "$json" 
    echo "      \"vulkanFlag\": 1" >> "$json"
    echo "    }" >> "$json"
    echo "  ]" >> "$json"
    echo "}" >> "$json"
    
    chmod 440 "$json"
  
  fi

}

# Wait for Android data 
until [ -d "/sdcard/Android" ]; do
  sleep 1 
done

# Enable Vulkan
enable_vulkan "$YS_PACKAGE"
enable_vulkan "$YS_PACKAGE2"
enable_vulkan "$GI_PACKAGE"
