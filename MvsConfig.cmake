# Torchlight::Mvs — per-module package configuration
# Imported by TorchlightConfig.cmake or usable standalone.

include(CMakeFindDependencyMacro)

# Mvs depends on Core, Math, Camera, Vision
include("${CMAKE_CURRENT_LIST_DIR}/CoreConfig.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/MathConfig.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/CameraConfig.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/VisionConfig.cmake")

# Mvs's public dependencies
find_dependency(Ceres CONFIG)

if(NOT TARGET tl::Mvs)
    include("${CMAKE_CURRENT_LIST_DIR}/MvsTargets.cmake")
endif()
