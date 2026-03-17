# ── Mvs module sources ───────────────────────────────────────────────────────
# Every header (.h/.hpp) and source (.cpp/.cc) file is listed explicitly.
# This file is included by torchlight_add_module() via add_subdirectory(src).

target_sources(Mvs
    PRIVATE
        # ── Top-level ───────────────────────────────────────────────────
        tmvsglobal.h
        tmvs_types.h
        tmvsexports.h

        # ── BA ──────────────────────────────────────────────────────────
        ba/bundleadjustment.h
        ba/bundleadjustment.cpp
        ba/bundleadjustmentsolver.cpp
        ba/bundleadjustmenttwoviewssolver.cpp

        # ── Desc ────────────────────────────────────────────────────────
        desc/feature.h
        desc/feature.cpp
        desc/featuredatabase.h
        desc/featuredatabase.cpp
        desc/imagepairmatch.h
        desc/imagepairmatch.cpp
        desc/landmark.h
        desc/landmark.cpp
        desc/memoryfeaturedatabase.h
        desc/memoryfeaturedatabase.cpp
        desc/scene.h
        desc/scene.cpp
        desc/view.h
        desc/view.cpp
        desc/viewgraph.h
        desc/viewgraph.cpp
        desc/viewpairinfo.h
        desc/viewpairinfo.cpp

        # ── Epipolar ───────────────────────────────────────────────────
        epipolar/basics.h
        epipolar/basics.cpp
        epipolar/findessential.h
        epipolar/findessential.cpp
        epipolar/findessentialfivepoints.h
        epipolar/findessentialfivepoints.cpp
        epipolar/findfundamental.h
        epipolar/findfundamental.cpp
        epipolar/findfundamentaleightpoints.h
        epipolar/findfundamentaleightpoints.cpp
        epipolar/findhomography.h
        epipolar/findhomography.cpp
        epipolar/findhomographyfourpoints.h
        epipolar/findhomographyfourpoints.cpp
        epipolar/triangulation.h
        epipolar/triangulation.cpp

        # ── Graph ──────────────────────────────────────────────────────
        graph/connectedcomponents.h
        graph/minimumspanningtree.h
        graph/tripletextractor.h

        # ── PnP ───────────────────────────────────────────────────────
        pnp/dlspnp.h
        pnp/dlspnp.cpp
        pnp/estimate_calibrated_absolute_pose.h
        pnp/estimate_calibrated_absolute_pose.cpp
        pnp/estimate_radial_dist_uncalibrated_absolute_pose.h
        pnp/estimate_radial_dist_uncalibrated_absolute_pose.cpp
        pnp/estimate_uncalibrated_absolute_pose.h
        pnp/estimate_uncalibrated_absolute_pose.cpp
        pnp/estimateabsoluteposewithorientation.h
        pnp/estimateabsoluteposewithorientation.cpp
        pnp/mlpnp.h
        pnp/mlpnp.cpp
        pnp/p3p.h
        pnp/p3p.cpp
        pnp/p4pfocal.h
        pnp/p4pfocal.cpp
        pnp/p4pfocalrd.h
        pnp/p4pfocalrd.cpp
        pnp/p5pfocalrd.h
        pnp/p5pfocalrd.cpp
        pnp/sqpnp.h
        pnp/sqpnp.cpp
        pnp/upnp.h
        pnp/upnp.cpp
        pnp/impl/dlspnp.hpp
        pnp/impl/dlspnp.cpp
        pnp/impl/p4pfocal.hpp
        pnp/impl/p4pfocal.cpp
        pnp/impl/p4pfocalrd.hpp
        pnp/impl/p4pfocalrd.cpp
        pnp/impl/sqpnp.hpp
        pnp/impl/sqpnp.cpp
        pnp/impl/upnp.hpp
        pnp/impl/upnp_buildactionmatrix.cpp
        pnp/impl/upnp_buildactionmatrixsymmetry.cpp

        # ── Poses ──────────────────────────────────────────────────────
        poses/alignrotations.h
        poses/alignrotations.cpp
        poses/estimaterotationutils.h
        poses/estimaterotationutils.cpp
        poses/hybridrotationestimator.h
        poses/hybridrotationestimator.cpp
        poses/irlsposerefine.h
        poses/irlsposerefine.cpp
        poses/lagrangedualrotationestimator.h
        poses/lagrangedualrotationestimator.cpp
        poses/ligtpositionestimator.h
        poses/ligtpositionestimator.cpp
        poses/linearpositionestimator.h
        poses/linearpositionestimator.cpp
        poses/linearrotationestimator.h
        poses/linearrotationestimator.cpp
        poses/ludpositionestimator.h
        poses/ludpositionestimator.cpp
        poses/nonlinearpositionestimator.h
        poses/nonlinearpositionestimator.cpp
        poses/nonlinearrotationestimator.h
        poses/nonlinearrotationestimator.cpp
        poses/positionestimator.h
        poses/positionestimator.cpp
        poses/robustrotationestimator.h
        poses/robustrotationestimator.cpp
        poses/rotationestimator.h
        poses/rotationestimator.cpp

        # ── Registration ───────────────────────────────────────────────
        registration/alignpointcloud.h
        registration/alignpointcloud.cpp

        # ── Residuals ──────────────────────────────────────────────────
        residuals/inversereprojectionerror.h
        residuals/inversereprojectionerror.cpp

        # ── SfM ────────────────────────────────────────────────────────
        sfm/estimateviewpairinfo.h
        sfm/estimateviewpairinfo.cpp
        sfm/globalreconstruction.h
        sfm/globalreconstruction.cpp
        sfm/incrementalreconstruction.h
        sfm/incrementalreconstruction.cpp
        sfm/localizeviewtoscene.h
        sfm/localizeviewtoscene.cpp
        sfm/optimzerelativeposition.h
        sfm/optimzerelativeposition.cpp
        sfm/reconstruction.h
        sfm/reconstruction.cpp
        sfm/selecttracks.h
        sfm/selecttracks.cpp
        sfm/selectviewpairs.h
        sfm/selectviewpairs.cpp
        sfm/threadpool.h
        sfm/threadpool.cpp
        sfm/trackbuilder.h
        sfm/trackbuilder.cpp
        sfm/trackestimator.h
        sfm/trackestimator.cpp
        sfm/visibilitypyramid.h
        sfm/visibilitypyramid.cpp
)