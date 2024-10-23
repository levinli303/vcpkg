set(UNRAR_VERSION "7.0.9")
set(UNRAR_SHA512 4dff760bd69275dcd9bacac7a8fa9a6e68e2d047ea3775abc16a80d9a6e277b686153faafb1b711582d86eabfdf3254c601d9f585b28104dbd85ece4868876ed)
set(UNRAR_FILENAME unrarsrc-${UNRAR_VERSION}.tar.gz)
set(UNRAR_URL https://www.rarlab.com/rar/${UNRAR_FILENAME})

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

#SRC
vcpkg_download_distfile(ARCHIVE
    URLS ${UNRAR_URL}
    FILENAME ${UNRAR_FILENAME}
    SHA512 ${UNRAR_SHA512}
)
vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    SOURCE_BASE ${UNRAR_VERSION}
    PATCHES
        fix-unrar.patch
        windows-arm64.patch
)

vcpkg_msbuild_install(
    SOURCE_PATH "${SOURCE_PATH}"
    PROJECT_SUBPATH "UnRARDll.vcxproj"
)

#INCLUDE (named dll.hpp in source, and unrar.h in all rarlabs distributions)
file(INSTALL "${SOURCE_PATH}/dll.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include" RENAME unrar.h)

configure_file("${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in" "${CURRENT_PACKAGES_DIR}/share/unofficial-unrar/unofficial-unrar-config.cmake" @ONLY)

#COPYRIGHT
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
