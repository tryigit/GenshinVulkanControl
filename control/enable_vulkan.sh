# @cleverestech

nohup am start -a android.intent.action.VIEW -d https://t.me/cleverestech >/dev/null 2>&1 &

YS_PACKAGE="com.miHoYo.Yuanshen"
YS_PACKAGE2="com.miHoYo.ys"
GI_PACKAGE="com.miHoYo.GenshinImpact"

# Github req
generate_gpu_config() {
  local target_dir="/storage/emulated/0/Android/data/$1/files"
  local output_file="$target_dir/vulkan_gpu_list_config.txt"

  mkdir -p "$target_dir"
  chmod 755 "$target_dir"
  
  su -c dumpsys SurfaceFlinger | grep OpenGL | cut -d',' -f2 | xargs > "$output_file"

}

until [ -d "/sdcard/Android" ]; do
  sleep 1 
done

for package in $YS_PACKAGE $YS_PACKAGE2 $GI_PACKAGE; do
  generate_gpu_config "$package"
done
echo "Vulkan enabled."
