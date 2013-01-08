package extra;

interface IAudioPolicyService {
    void setDeviceConnectionState(int device, int state, String device_address);
    int getDeviceConnectionState(int device, String device_address);
    void setPhoneState(int state);
    void setForceUse(int usage, int config);
    int getForceUse(int usage);
    int getOutput(int stream, int samplingRate , int format, int channels ,
        int flags);
    void startOutput(int output, int stream, int session );
    void stopOutput(int output, int stream, int session );
    void releaseOutput(int output);
    int getInput(int inputSource, int samplingRate , int format, int channels ,
        int acoustics, int audioSession );
    void startInput(int input);
    void stopInput(int input);
    void releaseInput(int input);
    void initStreamVolume(int stream, int indexMin, int indexMax);
    void setStreamVolumeIndex(int stream, int index, int device);
    void getStreamVolumeIndex(int stream, int index, int device);
    int getStrategyForStream(int stream);
    int getDevicesForStream(int stream);
    int getOutputForEffect(out int[] desc);
    void registerEffect(in int[] desc, int io, int strategy, int session,
        int id);
    void unregisterEffect(int id);
    void setEffectEnabled(int id, boolean enabled);
    boolean isStreamActive(int stream, int inPastMs );
    void queryDefaultPreProcessing(int audioSession, in int[] descriptors,
        int count);
}
