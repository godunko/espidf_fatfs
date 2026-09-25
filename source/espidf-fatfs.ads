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

   procedure Set_format_if_mount_failed
     (Self : in out esp_vfs_fat_mount_config_t;
      To   : Boolean);

   function esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t;

   procedure esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t);

   function esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t;

   procedure esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t);

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
