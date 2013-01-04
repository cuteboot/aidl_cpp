#
TOP="../../.."
AIDLCMD="$TOP/out/host/linux-x86/obj/EXECUTABLES/aidlcpp_intermediates/aidlcpp -I$TOP/frameworks/base/core/java/ "
$AIDLCMD -owork aidl/android/os/IPowerManager.aidl 
$AIDLCMD -owork aidl/android/os/IPermissionController.aidl 
$AIDLCMD -owork aidl/android/os/ISchedulingPolicyService.aidl
