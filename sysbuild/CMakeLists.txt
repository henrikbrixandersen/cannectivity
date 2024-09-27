function(${SYSBUILD_CURRENT_MODULE_NAME}_post_cmake)
  find_program(DFU_SUFFIX dfu-suffix)

  if(NOT ${DFU_SUFFIX} STREQUAL DFU_SUFFIX-NOTFOUND)
    sysbuild_get(kernel_bin_name IMAGE ${DEFAULT_IMAGE} VAR CONFIG_KERNEL_BIN_NAME KCONFIG)
    set(signed_image ${CMAKE_BINARY_DIR}/${DEFAULT_IMAGE}/zephyr/${kernel_bin_name}.signed.bin)
    set(dfu_image ${signed_image}.dfu)

    message(STATUS "DFU image will be written to: ${dfu_image}")

    add_custom_command(
      OUTPUT ${dfu_image}
      COMMAND ${CMAKE_COMMAND} -E copy ${signed_image} ${dfu_image}
      COMMAND ${DFU_SUFFIX}
      -a ${dfu_image}
      DEPENDS ${signed_image}
      )

    get_filename_component(dfu_target_name ${dfu_image} NAME)
    string(REPLACE "." "_" dfu_target_name ${dfu_target_name})

    add_custom_target(
      ${dfu_target_name}
      ALL
      DEPENDS ${dfu_image}
      )
  else()
    message(STATUS "The dfu-suffix utility was not found, DFU image cannot be generated")
  endif()
endfunction()
