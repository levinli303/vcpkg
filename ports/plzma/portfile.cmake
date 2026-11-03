vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO levinli303/PLzmaSDK
    REF 173db337cdcf4175c1c07828468b6b171c152148
    SHA512 e42108eb56e1c390f5eae2d95d7dea727c57b03e2f3aa9a38ecf8f477700117a0135a8bda415a371c7bbbf0b9e321d562cc8b3a6c25132371493e39c8f7db1c8
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
