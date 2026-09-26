--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);
--  Aspect `Finalizable` is used to initialize objects automaically

with ESPIDF.C_Strings;
with ESPIDF.Wear_Levelling;

package ESPIDF.FATFS is

   type esp_vfs_fat_mount_config_t is limited private;
   --  Configuration arguments for `esp_vfs_fat_sdmmc_mount` and
   --  `esp_vfs_fat_spiflash_mount_rw_wl` functions.
   --
   --  Objects of this type are initialized with default values
   --  (`VFS_FAT_MOUNT_DEFAULT_CONFIG`).

   procedure Set_format_if_mount_failed
     (Self : in out esp_vfs_fat_mount_config_t;
      To   : Boolean);
   --  Set `format_if_mount_failed` parameter of the configuration.
   --
   --  If FAT partition can not be mounted, and this parameter is true,
   --  create partition table and format the filesystem.
   --  @param Self Configuration to modify
   --  @param To New value of the parameter

   function esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t;
   --  Convenience function to initialize FAT filesystem in SPI flash and
   --  register it in VFS.
   --
   --  This is an all-in-one subprogram which does the following:
   --    - finds the partition with defined `partition_label`. Partition label
   --      should be configured in the partition table.
   --    - initializes flash wear levelling library on top of the given
   --      partition
   --    - mounts FAT partition using FATFS library on top of flash wear
   --      levelling library
   --    - registers FATFS library with VFS, with prefix given by `base_path`
   --      parameter
   --
   --  This subprogram is intended to make example code more compact.
   --  @param base_path
   --    Path where FATFS partition should be mounted (e.g. "/spiflash")
   --  @param partition_label Label of the partition which should be used
   --  @param mount_config Structure with extra parameters for mounting FATFS
   --  @param wl_handle Wear levelling driver handle
   --  @return
   --    - `ESP_OK` if partition was mounted successfully
   --    - `ESP_ERR_NOT_FOUND` if the partition table does not contain FATFS
   --      partition with given label
   --    - `ESP_ERR_INVALID_STATE` if `esp_vfs_fat_spiflash_mount_rw_wl` was
   --      already called
   --    - `ESP_ERR_NO_MEM` if memory can not be allocated
   --    - `ESP_FAIL` if partition can not be mounted
   --    - other error codes from wear levelling library, SPI flash driver, or
   --      FATFS drivers

   procedure esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t);
   --  Convenience function to initialize FAT filesystem in SPI flash and
   --  register it in VFS.
   --
   --  This is an all-in-one subprogram which does the following:
   --    - finds the partition with defined `partition_label`. Partition label
   --      should be configured in the partition table.
   --    - initializes flash wear levelling library on top of the given
   --      partition
   --    - mounts FAT partition using FATFS library on top of flash wear
   --      levelling library
   --    - registers FATFS library with VFS, with prefix given by `base_path`
   --      parameter
   --
   --  This subprogram is intended to make example code more compact.
   --  @param base_path
   --    Path where FATFS partition should be mounted (e.g. "/spiflash")
   --  @param partition_label Label of the partition which should be used
   --  @param mount_config Structure with extra parameters for mounting FATFS
   --  @param wl_handle Wear levelling driver handle
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_NOT_FOUND` if the partition table does not contain FATFS
   --      partition with given label
   --    - `ESP_ERR_INVALID_STATE` if `esp_vfs_fat_spiflash_mount_rw_wl` was
   --      already called
   --    - `ESP_ERR_NO_MEM` if memory can not be allocated
   --    - `ESP_FAIL` if partition can not be mounted
   --    - other error codes from wear levelling library, SPI flash driver, or
   --      FATFS drivers

   function esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t;
   --  Unmount FAT filesystem and release resources acquired using
   --  `esp_vfs_fat_spiflash_mount_rw_wl`.
   --  @param base_path
   --    Path where partition should be registered (e.g. "/spiflash")
   --  @param wl_handle
   --    Wear levelling driver handle returned by
   --    `esp_vfs_fat_spiflash_mount_rw_wl`
   --  @return
   --    - `ESP_OK` if partition was unmounted successfully
   --    - `ESP_ERR_INVALID_STATE` if `esp_vfs_fat_spiflash_mount_rw_wl`
   --      hasn't been called

   procedure esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t);
   --  Unmount FAT filesystem and release resources acquired using
   --  `esp_vfs_fat_spiflash_mount_rw_wl`.
   --  @param base_path
   --    Path where partition should be registered (e.g. "/spiflash")
   --  @param wl_handle
   --    Wear levelling driver handle returned by
   --    `esp_vfs_fat_spiflash_mount_rw_wl`
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_INVALID_STATE` if `esp_vfs_fat_spiflash_mount_rw_wl`
   --      hasn't been called

private

   sizeof_esp_vfs_fat_mount_config_t : constant int
      with Import, Convention => C,
           Link_Name => "__ada_SIZEOF_esp_vfs_fat_mount_config_t";

   type esp_vfs_fat_mount_config_t_Storage is
     new C_Object_Storage (1 .. sizeof_esp_vfs_fat_mount_config_t)
       with Convention => C;

   procedure Initialize (Self : in out esp_vfs_fat_mount_config_t);

   type esp_vfs_fat_mount_config_t is limited record
      Storage : esp_vfs_fat_mount_config_t_Storage;
   end record
     with Convention  => C,
          Finalizable =>
            (Initialize           => Initialize,
             Relaxed_Finalization => True);

   pragma Assert
     (esp_vfs_fat_mount_config_t'Size
        = sizeof_esp_vfs_fat_mount_config_t * C_Storage_Element'Size);

end ESPIDF.FATFS;
