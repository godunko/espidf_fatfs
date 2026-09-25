/*
 *  Copyright (C) 2026, Vadim Godunko
 *
 *  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#include "esp_vfs_fat.h"

const int __ada_SIZEOF_esp_vfs_fat_mount_config_t = sizeof(esp_vfs_fat_mount_config_t);

void __ada_VFS_FAT_MOUNT_DEFAULT_CONFIG(esp_vfs_fat_mount_config_t *cfg)
{
    *cfg = (esp_vfs_fat_mount_config_t)VFS_FAT_MOUNT_DEFAULT_CONFIG();
}
