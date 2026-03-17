# ── Torchlight::Mvs ───────────────────────────────────────────────────────────
# Multi-view stereo: SfM, bundle adjustment, PnP, epipolar geometry, etc.

# ── Standalone build support ─────────────────────────────────────────────────
if(NOT TORCHLIGHT_SUPERBUILD)
    cmake_minimum_required(VERSION 3.24)
    include(${CMAKE_CURRENT_SOURCE_DIR}/.cmake.conf)
    project(TorchlightMvs
        VERSION     "${TORCHLIGHT_MODULE_VERSION}"
        DESCRIPTION "Torchlight Mvs module"
        LANGUAGES   CXX C
    )

    include(GNUInstallDirs)
    include(CMakePackageConfigHelpers)

    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)

    set(TORCHLIGHT_NAMESPACE "tl" CACHE STRING "CMake namespace")

    if(MSVC)
        add_compile_definitions(_USE_MATH_DEFINES NOMINMAX)
    endif()

    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
    include(TorchlightHelpers)

    option(TORCHLIGHT_BUILD_TESTS "Build unit tests" ON)
    if(TORCHLIGHT_BUILD_TESTS)
        enable_testing()
        include(GoogleTest)
        find_package(GTest CONFIG REQUIRED)
    endif()

    # Standalone: find Core, Math, Camera, Vision
    if(NOT TARGET ${TORCHLIGHT_NAMESPACE}::Core)
        find_package(Torchlight COMPONENTS Core Math Camera Vision CONFIG REQUIRED)
    endif()
endif()

# ── Dependencies ─────────────────────────────────────────────────────────────
# Ceres: used in bundle adjustment and various estimators.
find_package(Ceres CONFIG REQUIRED)

# Sophus: used privately for Lie group operations.
find_package(Sophus CONFIG REQUIRED)

# Spectra: header-only library for large-scale eigenvalue problems.
find_package(Spectra CONFIG REQUIRED)

# ── Module target ────────────────────────────────────────────────────────────
# Mvs has ~140 source files with heavy template usage (Ceres, Eigen).
# This exceeds Windows' 65535 DLL export symbol limit, so build as STATIC.
set(BUILD_SHARED_LIBS OFF)
torchlight_add_module(Mvs
    PUBLIC_DEPENDS
        ${TORCHLIGHT_NAMESPACE}::Camera
        ${TORCHLIGHT_NAMESPACE}::Core
        ${TORCHLIGHT_NAMESPACE}::Math
        ${TORCHLIGHT_NAMESPACE}::Vision
        Ceres::ceres
    PRIVATE_DEPENDS
        magic_enum::magic_enum
        Sophus::Sophus
        Spectra::Spectra
)

# ── Install per-module package config ────────────────────────────────────────
torchlight_install_module_config(Mvs
    CONFIG_FILE "${CMAKE_CURRENT_SOURCE_DIR}/MvsConfig.cmake"
)

# ── Generate Qt-style public include tree ────────────────────────────────────
torchlight_generate_headers(Mvs
    MODULE_DIR tMvs
    HEADERS
        # ── Top-level ────────────────────────────────────────────────
        tmvsglobal.h
        "tmvs_types.h=types.h"

        # ── Desc ─────────────────────────────────────────────────────
        "desc/feature.h=feature.h"
        "desc/imagepairmatch.h=imagepairmatch.h"
        "desc/landmark.h=landmark.h"
        "desc/scene.h=scene.h"
        "desc/view.h=view.h"
        "desc/viewgraph.h=viewgraph.h"
        "desc/viewpairinfo.h=viewpairinfo.h"

        # ── BA ───────────────────────────────────────────────────────
        "ba/bundleadjustment.h=BA/bundleadjustment.h"

        # ── Epipolar ────────────────────────────────────────────────
        "epipolar/basics.h=Epipolar/basics.h"
        "epipolar/findessential.h=Epipolar/findessential.h"
        "epipolar/findessentialfivepoints.h=Epipolar/findessentialfivepoints.h"
        "epipolar/findfundamental.h=Epipolar/findfundamental.h"
        "epipolar/findfundamentaleightpoints.h=Epipolar/findfundamentaleightpoints.h"
        "epipolar/findhomography.h=Epipolar/findhomography.h"
        "epipolar/findhomographyfourpoints.h=Epipolar/findhomographyfourpoints.h"
        "epipolar/triangulation.h=Epipolar/triangulation.h"

        # ── Graph ───────────────────────────────────────────────────
        "graph/connectedcomponents.h=Graph/connectedcomponents.h"
        "graph/minimumspanningtree.h=Graph/minimumspanningtree.h"
        "graph/tripletextractor.h=Graph/tripletextractor.h"

        # ── PnP ─────────────────────────────────────────────────────
        "pnp/dlspnp.h=PnP/dlspnp.h"
        "pnp/estimateabsoluteposewithorientation.h=PnP/estimateabsoluteposewithorientation.h"
        "pnp/estimate_calibrated_absolute_pose.h=PnP/estimatecalibratedabsolutepose.h"
        "pnp/estimate_radial_dist_uncalibrated_absolute_pose.h=PnP/estimateradialdistortionuncalibratedabsolutepose.h"
        "pnp/estimate_uncalibrated_absolute_pose.h=PnP/estimateuncalibratedabsolutepose.h"
        "pnp/mlpnp.h=PnP/mlpnp.h"
        "pnp/p3p.h=PnP/p3p.h"
        "pnp/p4pfocal.h=PnP/p4pfocal.h"
        "pnp/p4pfocalrd.h=PnP/p4pfocalrd.h"
        "pnp/p5pfocalrd.h=PnP/p5pfocalrd.h"
        "pnp/sqpnp.h=PnP/sqpnp.h"
        "pnp/upnp.h=PnP/upnp.h"

        # ── Poses ───────────────────────────────────────────────────
        "poses/alignrotations.h=Poses/alignrotations.h"
        "poses/positionestimator.h=Poses/estimateposition.h"
        "poses/ligtpositionestimator.h=Poses/estimatepositionligt.h"
        "poses/linearpositionestimator.h=Poses/estimatepositionlinear.h"
        "poses/ludpositionestimator.h=Poses/estimatepositionlud.h"
        "poses/nonlinearpositionestimator.h=Poses/estimatepositionnonlinear.h"
        "poses/rotationestimator.h=Poses/estimaterotation.h"
        "poses/hybridrotationestimator.h=Poses/estimaterotationhybrid.h"
        "poses/lagrangedualrotationestimator.h=Poses/estimaterotationlagrange.h"
        "poses/linearrotationestimator.h=Poses/estimaterotationlinear.h"
        "poses/nonlinearrotationestimator.h=Poses/estimaterotationnonlinear.h"
        "poses/robustrotationestimator.h=Poses/estimaterotationrobust.h"
        "poses/irlsposerefine.h=Poses/irlsrotationrefine.h"
        "sfm/optimzerelativeposition.h=Poses/optimzerelativeposition.h"

        # ── Registration ────────────────────────────────────────────
        "registration/alignpointcloud.h=Registration/alignpointcloud.h"

        # ── SfM ─────────────────────────────────────────────────────
        "sfm/estimateviewpairinfo.h=SfM/estimateviewpairinfo.h"
        "sfm/globalreconstruction.h=SfM/globalreconstruction.h"
        "sfm/incrementalreconstruction.h=SfM/incrementalreconstruction.h"
        "sfm/reconstruction.h=SfM/reconstruction.h"
        "sfm/selecttracks.h=SfM/selecttracks.h"
        "sfm/selectviewpairs.h=SfM/selectviewpairs.h"
        "sfm/trackbuilder.h=SfM/trackbuilder.h"

    ALIASES
        # ── Top-level ────────────────────────────────────────────────
        "Feature=feature.h"
        "ImagePairMatch=imagepairmatch.h"
        "Landmark=landmark.h"
        "Scene=scene.h"
        "Types=types.h"
        "View=view.h"
        "ViewGraph=viewgraph.h"
        "ViewPairInfo=viewpairinfo.h"

        # ── BA aliases ───────────────────────────────────────────────
        "BA/BundleAdjustment=BA/bundleadjustment.h"

        # ── Epipolar aliases ─────────────────────────────────────────
        "Epipolar/Basics=Epipolar/basics.h"
        "Epipolar/FindEssential=Epipolar/findessential.h"
        "Epipolar/FindEssentialFivePoints=Epipolar/findessentialfivepoints.h"
        "Epipolar/FindFundamental=Epipolar/findfundamental.h"
        "Epipolar/FindFundamentalEightPoints=Epipolar/findfundamentaleightpoints.h"
        "Epipolar/FindHomography=Epipolar/findhomography.h"
        "Epipolar/FindHomographyFourPoints=Epipolar/findhomographyfourpoints.h"
        "Epipolar/Triangulation=Epipolar/triangulation.h"

        # ── Graph aliases ────────────────────────────────────────────
        "Graph/ConnectedComponents=Graph/connectedcomponents.h"
        "Graph/MinimumSpanningTree=Graph/minimumspanningtree.h"
        "Graph/TripletExtractor=Graph/tripletextractor.h"

        # ── PnP aliases ─────────────────────────────────────────────
        "PnP/DLSPnP=PnP/dlspnp.h"
        "PnP/EstimateAbsolutePoseWithOrientation=PnP/estimateabsoluteposewithorientation.h"
        "PnP/EstimateCalibratedAbsolutePose=PnP/estimatecalibratedabsolutepose.h"
        "PnP/EstimateRadialDistortionUncalibratedAbsolutePose=PnP/estimateradialdistortionuncalibratedabsolutepose.h"
        "PnP/EstimateUncalibratedAbsolutePose=PnP/estimateuncalibratedabsolutepose.h"
        "PnP/MLPnP=PnP/mlpnp.h"
        "PnP/P3P=PnP/p3p.h"
        "PnP/P4PFocal=PnP/p4pfocal.h"
        "PnP/P4PFocalRd=PnP/p4pfocalrd.h"
        "PnP/P5PFocalRd=PnP/p5pfocalrd.h"
        "PnP/SQPnP=PnP/sqpnp.h"
        "PnP/UPnP=PnP/upnp.h"

        # ── Poses aliases ────────────────────────────────────────────
        "Poses/AlignRotations=Poses/alignrotations.h"
        "Poses/EstimatePosition=Poses/estimateposition.h"
        "Poses/EstimatePositionLiGT=Poses/estimatepositionligt.h"
        "Poses/EstimatePositionLinear=Poses/estimatepositionlinear.h"
        "Poses/EstimatePositionLUD=Poses/estimatepositionlud.h"
        "Poses/EstimatePositionNonlinear=Poses/estimatepositionnonlinear.h"
        "Poses/EstimateRotation=Poses/estimaterotation.h"
        "Poses/EstimateRotationHybrid=Poses/estimaterotationhybrid.h"
        "Poses/EstimateRotationLagrange=Poses/estimaterotationlagrange.h"
        "Poses/EstimateRotationLinear=Poses/estimaterotationlinear.h"
        "Poses/EstimateRotationNonLinear=Poses/estimaterotationnonlinear.h"
        "Poses/EstimateRotationRobust=Poses/estimaterotationrobust.h"
        "Poses/IRLSRotationRefine=Poses/irlsrotationrefine.h"
        "Poses/OptimizeRelativePosition=Poses/optimzerelativeposition.h"

        # ── Registration aliases ─────────────────────────────────────
        "Registration/AlignPointCloud=Registration/alignpointcloud.h"

        # ── SfM aliases ──────────────────────────────────────────────
        "SfM/EstimateViewPairInfo=SfM/estimateviewpairinfo.h"
        "SfM/GlobalReconstruction=SfM/globalreconstruction.h"
        "SfM/IncrementalReconstruction=SfM/incrementalreconstruction.h"
        "SfM/Reconstruction=SfM/reconstruction.h"
        "SfM/SelectTracks=SfM/selecttracks.h"
        "SfM/SelectViewPairs=SfM/selectviewpairs.h"
        "SfM/TrackBuilder=SfM/trackbuilder.h"
)
