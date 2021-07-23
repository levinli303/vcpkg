# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/ptr_container
    REF boost-1.76.0
    SHA512 11a08ff378e0e70f18a79ded47c339eee9e1bf4fb7bd7ea5283f9d7b888112904453d8e6e3970993706f3d90069bd765bf848ec9a8b8edb0595f5b40f19ce1d8
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
