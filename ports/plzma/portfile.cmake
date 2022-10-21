vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO levinli303/PLzmaSDK
    REF 9a4e0e8f4a4c68da04b2146e4fe7dcb2662257e3
    SHA512 319588e5f6f4ee32f3af133887e003ad3efc47e07913050f269a446110614054b91ae0966336637ddc4bf27cee2244f0cb77150c0b421f0a38f88d4967da894a
    HEAD_REF master
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
