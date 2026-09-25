--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.FATFS is

   --------------------------------------
   -- esp_vfs_fat_spiflash_mount_rw_wl --
   --------------------------------------

   function esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t
   is
      function Imported
        (base_path        : ESPIDF.C_Strings.const_char_ptr;
         partition_label  : ESPIDF.C_Strings.const_char_ptr;
         mount_config     : esp_vfs_fat_mount_config_t;
         wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t)
         return esp_err_t
        with Import, Convention => C,
             External_Name => "esp_vfs_fat_spiflash_mount_rw_wl";

   begin
      return
        Imported
          (ESPIDF.C_Strings.As_const_char_ptr (base_path),
           ESPIDF.C_Strings.As_const_char_ptr (partition_label),
           mount_config,
           wl_handle);
   end esp_vfs_fat_spiflash_mount_rw_wl;

   --------------------------------------
   -- esp_vfs_fat_spiflash_mount_rw_wl --
   --------------------------------------

   procedure esp_vfs_fat_spiflash_mount_rw_wl
     (base_path        : ESPIDF.C_Strings.char_array_string;
      partition_label  : ESPIDF.C_Strings.char_array_string;
      mount_config     : esp_vfs_fat_mount_config_t;
      wl_handle        : out ESPIDF.Wear_Levelling.wl_handle_t) is
   begin
      Ada_ESP_Check_Error
        (esp_vfs_fat_spiflash_mount_rw_wl
           (base_path, partition_label, mount_config, wl_handle));
   end esp_vfs_fat_spiflash_mount_rw_wl;

   ----------------------------------------
   -- esp_vfs_fat_spiflash_unmount_rw_wl --
   ----------------------------------------

   function esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t)
      return esp_err_t
   is
      function Imported
        (base_path : ESPIDF.C_Strings.const_char_ptr;
         wl_handle : ESPIDF.Wear_Levelling.wl_handle_t)
         return esp_err_t
        with Import, Convention => C,
             External_Name => "esp_vfs_fat_spiflash_unmount_rw_wl";

   begin
      return
        Imported
          (ESPIDF.C_Strings.As_const_char_ptr (base_path), wl_handle);
   end esp_vfs_fat_spiflash_unmount_rw_wl;

   ----------------------------------------
   -- esp_vfs_fat_spiflash_unmount_rw_wl --
   ----------------------------------------

   procedure esp_vfs_fat_spiflash_unmount_rw_wl
     (base_path : ESPIDF.C_Strings.char_array_string;
      wl_handle : ESPIDF.Wear_Levelling.wl_handle_t) is
   begin
      Ada_ESP_Check_Error
        (esp_vfs_fat_spiflash_unmount_rw_wl (base_path, wl_handle));
   end esp_vfs_fat_spiflash_unmount_rw_wl;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out esp_vfs_fat_mount_config_t) is

      procedure Imported (config : out esp_vfs_fat_mount_config_t)
        with Import, Convention => C,
             External_Name => "__ada_VFS_FAT_MOUNT_DEFAULT_CONFIG";

   begin
      Imported (Self);
   end Initialize;

   --------------------------------
   -- Set_format_if_mount_failed --
   --------------------------------

   procedure Set_format_if_mount_failed
     (Self : in out esp_vfs_fat_mount_config_t;
      To   : Boolean)
   is
      procedure Imported
        (self : in out esp_vfs_fat_mount_config_t;
         to   : bool)
        with Import, Convention => C,
             External_Name =>
               "__ada_SET_esp_vfs_fat_mount_config_t_format_if_mount_failed";

   begin
      Imported (Self, bool (To));
   end Set_format_if_mount_failed;

end ESPIDF.FATFS;
