package extra;
import extra.IMemory;
import extra.IAudioRecord;
import extra.IAudioTrack;
import extra.IEffect;
import extra.IEffectClient;
import import.status_t;
import import.String8;
import import.CString;
import import.effect_uuid_t;
import import.effect_descriptor_t;


import extra.IAudioFlingerClient;

interface IAudioFlinger {
    IAudioTrack createTrack( int pid, int streamType, int sampleRate,
        int format, int channelMask, int frameCount, int flags,
        IMemory sharedBuffer, int output, int tid,
        inout int * sessionId, out status_t * status);
    IAudioRecord openRecord( int pid, int input, int sampleRate,
        int format, int channelMask, int frameCount, int flags,
        inout int * sessionId, out void * status);
    int sampleRate(int output);
    int channelCount(int output);
    int format(int output);
    long frameCount(int output);
    int latency(int output);
    status_t setMasterVolume(float value);
    status_t setMasterMute(boolean muted);
    float masterVolume();
    boolean masterMute();
    status_t setStreamVolume(int stream, float value, int output);
    status_t setStreamMute(int stream, boolean muted);
    float streamVolume(int stream, int output);
    boolean streamMute(int stream);
    status_t setMode(int mode);
    status_t setMicMute(boolean state);
    boolean getMicMute();
    status_t setParameters(int ioHandle, in String8 keyValuePairs);
    String8 getParameters(int ioHandle, in String8 keys);
    status_t registerClient(IAudioFlingerClient client);
    int getInputBufferSize(int sampleRate, int format, int channelCount);
    int openOutput(int module, inout int * pDevices, inout int * pSamplingRate,
        inout int * pFormat, inout int * pChannelMask, inout int * pLatencyMs, int flags);
    int openDuplicateOutput(int output1, int output2);
    status_t closeOutput(int output);
    status_t suspendOutput(int output);
    status_t restoreOutput(int output);
    int openInput(int module, inout int * pDevices, inout int * pSamplingRate,
        inout int * pFormat, inout int * pChannelMask);
    status_t closeInput(int input);
    status_t setStreamOutput(int stream, int output);
    status_t setVoiceVolume(float volume);
    void getRenderPosition(out int * halFrames, out int * dspFrames, int output);
    int getInputFramesLost(int ioHandle);
    int newAudioSessionId();
    status_t acquireAudioSessionId(int audioSession);
    status_t releaseAudioSessionId(int audioSession);
    status_t queryNumberEffects(out int * numEffects);
    status_t queryEffect(int index, out effect_descriptor_t * pDescriptor);
    status_t getEffectDescriptor(in effect_uuid_t * pEffectUUID, out effect_descriptor_t * pDescriptor);
    // createEffect: response has pDesc data last!
    IEffect createEffect(int pid, inout effect_descriptor_t * pDesc, IEffectClient client,
        int priority, int output, int sessionId, out status_t * status,
        out int * id, out int * enabled);
    status_t moveEffects(int session, int srcOutput, int dstOutput);
    int loadHwModule(in CString name);
}
