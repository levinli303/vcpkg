vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO levinli303/PLzmaSDK
    REF 23a76420f6ee0ce60b3ffaa79b46a1307ec7123c
    SHA512 42b96c9ee81f4b462e069c759c916555a329e6831500b8545fc971a1dd120286bf2091a41ce14879d5c85e6f788c5b6c91d06932accda5da6e75f39622139c3d
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
