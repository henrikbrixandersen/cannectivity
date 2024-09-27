# Copyright (c) 2024 Henrik Brix Andersen <henrik@brixandersen.dk>
# SPDX-License-Identifier: Apache-2.0

# TODO: depend on MCUboot USB DFU options
if(SB_CONFIG_BOOTLOADER_MCUBOOT)
  if(SB_CONFIG_CANNECTIVITY_USB_DFU_VID EQUAL 0x1209)
    if(SB_CONFIG_CANNECTIVITY_USB_DFU_PID LESS_EQUAL 0x0010)
      message(WARNING
        "SB_CONFIG_CANNECTIVITY_USB_DFU_PID is set to a generic pid.codes Test PID (${SB_CONFIG_CANNECTIVITY_USB_DFU_PID}).
This PID is not unique and should not be used outside test environments."
        )
    endif()
  endif()

  set_config_string(mcuboot CONFIG_USB_DEVICE_MANUFACTURER "${SB_CONFIG_CANNECTIVITY_USB_DFU_MANUFACTURER}")
  set_config_string(mcuboot CONFIG_USB_DEVICE_PRODUCT "${SB_CONFIG_CANNECTIVITY_USB_DFU_PRODUCT}")
  set_config_int(mcuboot CONFIG_USB_DEVICE_VID ${SB_CONFIG_CANNECTIVITY_USB_DFU_VID})
  set_config_int(mcuboot CONFIG_USB_DEVICE_PID ${SB_CONFIG_CANNECTIVITY_USB_DFU_PID})
  set_config_int(mcuboot CONFIG_USB_MAX_POWER ${SB_CONFIG_CANNECTIVITY_USB_DFU_MAX_POWER})
endif()
