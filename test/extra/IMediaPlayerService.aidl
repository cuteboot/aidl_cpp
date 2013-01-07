package extra;

interface IMediaPlayerService {
    IMediaRecorder createMediaRecorder(int pid);
    IMediaMetadataRetriever createMetadataRetriever(int pid);
    IMediaPlayer create(int pid, IMediaPlayerClient client, int audioSessionId );
    IMemory decode(const char[]  url, int[] pSampleRate, int[]  pNumChannels, int[]  pFormat);
    IMemory decode(int fd, long offset, long length, int[] pSampleRate, int[]  pNumChannels, int[]  pFormat);
    IOMX getOMX();
    ICrypto makeCrypto();
    void addBatteryData(int params);
    void pullBatteryData(Parcel[]  reply);
}
