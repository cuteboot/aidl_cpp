package extra;

import import.CString;
import import.status_t;
import import.effect_descriptor_t;

interface IAudioPolicyService {
    status_t setDeviceConnectionState(int device, int state, in CString device_address);
    int getDeviceConnectionState(int device, in CString device_address);
    status_t setPhoneState(int state);
    status_t setRingerMode_unused();
    status_t setForceUse(int usage, int config);
    int getForceUse(int usage);
    int getOutput(int stream, int samplingRate , int format, int channels ,
        int flags);
    status_t startOutput(int output, int stream, int session );
    status_t stopOutput(int output, int stream, int session );
    status_t releaseOutput(int output);
    int getInput(int inputSource, int samplingRate , int format, int channels ,
        int acoustics, int audioSession );
    status_t startInput(int input);
    status_t stopInput(int input);
    status_t releaseInput(int input);
    status_t initStreamVolume(int stream, int indexMin, int indexMax);
    status_t setStreamVolumeIndex(int stream, int index, int device);
    status_t getStreamVolumeIndex(int stream, out int * index, int device);
    int getStrategyForStream(int stream);
    int getOutputForEffect(in effect_descriptor_t * desc);
    status_t registerEffect(in effect_descriptor_t * desc, int io, int strategy, int session,
        int id);
    status_t unregisterEffect(int id);
    boolean isStreamActive(int stream, int inPastMs );
    int getDevicesForStream(int stream);
    status_t queryDefaultPreProcessing(int audioSession, out effect_descriptor_t * descriptors,
        out int * count);
    status_t setEffectEnabled(int id, boolean enabled);
}
