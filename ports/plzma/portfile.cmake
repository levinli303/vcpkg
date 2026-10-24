vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO levinli303/PLzmaSDK
    REF dc4cff03d7cfa7b5fb709a70fcfdb04a6cad3c70
    SHA512 14f85d6182583f5e7d07aa0c72572958704514df703a53a1d28359440778d9f90a9c2d22dc72efe4005abe05df177742815a350160e58d6c7bd101199224e99b
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLIBPLZMA_OPT_TESTS=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/bin")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/bin")

file(RENAME "${CURRENT_PACKAGES_DIR}/lib/libplzma.dll" "${CURRENT_PACKAGES_DIR}/bin/libplzma.dll")
file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib/libplzma.dll" "${CURRENT_PACKAGES_DIR}/debug/bin/libplzma.dll")

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
