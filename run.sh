#!/bin/bash
set -e
shopt -s nullglob
dir="$1"
if [[ ! -d "$dir" ]]; then
  exit 1
fi
arm-none-eabi-gcc -nostdlib -o "$dir/out.elf" -T build.lds startup.s "$dir"/*.s "$dir"/*.c
arm-none-eabi-objcopy -O binary "$dir/out.elf" "$dir/out.bin"
dd if=/dev/zero of="$dir/flash.bin" bs=4096 count=4096 status=none
dd if="$dir/out.bin" of="$dir/flash.bin" bs=4096 conv=notrunc status=none
rm -f "$dir/out.bin"
qemu-system-arm -M connex -drive if=pflash,file="$dir/flash.bin",format=raw -nographic -serial /dev/null
