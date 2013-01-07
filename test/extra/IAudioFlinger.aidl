package extra;
import extra.IMemory;
import extra.IAudioRecord;
import extra.IAudioTrack;
import extra.IEffect;
import extra.IEffectClient;


import extra.IAudioFlingerClient;

interface IAudioFlinger {
    IAudioTrack createTrack( int pid, int streamType, int sampleRate, int format, int channelMask, int frameCount, int flags, IMemory sharedBuffer, int output, int tid, out int[] sessionId, out void[] status);
    IAudioRecord openRecord( int pid, int input, int sampleRate, int format, int channelMask, int frameCount, int flags, out int[] sessionId, out void[] status);
    int sampleRate(int output);
    int channelCount(int output);
    int format(int output);
    long frameCount(int output);
    int latency(int output);
    void setMasterVolume(float value);
    void setMasterMute(boolean muted);
    float masterVolume();
    boolean masterMute();
    void setStreamVolume(int stream, float value, int output);
    void setStreamMute(int stream, boolean muted);
    float streamVolume(int stream, int output);
    boolean streamMute(int stream);
    void setMode(int mode);
    void setMicMute(boolean state);
    boolean getMicMute();
    void setParameters(int ioHandle, String keyValuePairs);
    String getParameters(int ioHandle, String keys);
    void registerClient(IAudioFlingerClient client);
    int getInputBufferSize(int sampleRate, int format, int channelCount);
    int openOutput(int module, in int[] pDevices, int pSamplingRate, int pFormat, in int[] pChannelMask, int pLatencyMs, int flags);
    int openDuplicateOutput(int output1, int output2);
    void closeOutput(int output);
    void suspendOutput(int output);
    void restoreOutput(int output);
    int openInput(int module, in int[] pDevices, int pSamplingRate, int pFormat, in int[] pChannelMask);
    void closeInput(int input);
    void setStreamOutput(int stream, int output);
    void setVoiceVolume(float volume);
    void getRenderPosition(int halFrames, int dspFrames, int output);
    int getInputFramesLost(int ioHandle);
    int newAudioSessionId();
    void acquireAudioSessionId(int audioSession);
    void releaseAudioSessionId(int audioSession);
    void queryNumberEffects(int numEffects);
    void queryEffect(int index, in int[] pDescriptor);
    void getEffectDescriptor(in int[] pEffectUUID, in int[] pDescriptor);
    IEffect createEffect(int pid, in int[] pDesc, IEffectClient client, int priority, int output, int sessionId, out void[] status, int id, int enabled);
    void moveEffects(int session, int srcOutput, int dstOutput);
    int loadHwModule(in String name);
}
