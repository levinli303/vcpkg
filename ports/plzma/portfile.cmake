vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO levinli303/PLzmaSDK
    REF 4bfabdab56a47a965d1b382fc1517bf55b95e894
    SHA512 1e6016d54737d38b50f47ba55d83c3650d1dae9617eeeaf6467b3cd341fc9685ea142ba219c1cd6cac82039c0948eb1310ad0c378bb4174c6bfa35cbbba2b941
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
