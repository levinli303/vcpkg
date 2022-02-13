set(UNRAR_VERSION "6.1.3")
set(UNRAR_SHA512 a5626adbe2ba063082156542f9cf6658f57f917ae1fa565809b19479629c65632033f0acb0800b0083e02e218fcefb4b0a24635a84c3bd8a2919971f2cf89cb3)
set(UNRAR_FILENAME unrarsrc-${UNRAR_VERSION}.tar.gz)
set(UNRAR_URL https://www.rarlab.com/rar/${UNRAR_FILENAME})

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

#SRC
vcpkg_download_distfile(ARCHIVE
    URLS ${UNRAR_URL}
    FILENAME ${UNRAR_FILENAME}
    SHA512 ${UNRAR_SHA512}
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${UNRAR_VERSION}
    PATCHES
        msbuild-use-default-sma.patch
        fix-unrar.patch
)

vcpkg_build_msbuild(
    PROJECT_PATH "${SOURCE_PATH}/UnRARDll.vcxproj"
    OPTIONS_DEBUG /p:OutDir=../../${TARGET_TRIPLET}-dbg/
    OPTIONS_RELEASE /p:OutDir=../../${TARGET_TRIPLET}-rel/
    OPTIONS /VERBOSITY:Diagnostic /DETAILEDSUMMARY
)

#INCLUDE (named dll.hpp in source, and unrar.h in all rarlabs distributions)
file(INSTALL "${SOURCE_PATH}/dll.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include" RENAME unrar.h)

#DLL & LIB
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/unrar.dll"  DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/unrar.lib"  DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/unrar.dll"  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/unrar.lib"  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")

vcpkg_copy_pdbs()

#COPYRIGHT
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
