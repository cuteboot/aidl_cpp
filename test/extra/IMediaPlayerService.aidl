package extra;

import extra.ICrypto;
import extra.IOMX;
import extra.IMemory;
import extra.IMediaRecorder;
import extra.IMediaMetadataRetriever;
import extra.IMediaPlayer;
import extra.IMediaPlayerClient;
import import.zParcel;

interface IMediaPlayerService {
    IMediaRecorder createMediaRecorder(int pid);
    IMediaMetadataRetriever createMetadataRetriever(int pid);
    IMediaPlayer create(int pid, IMediaPlayerClient client,
        int audioSessionId );
    IMemory decodeUrl(String  url, in int[] pSampleRate,
        in int[]  pNumChannels, in int[]  pFormat);
    IMemory decodeFd(int fd, long offset, long length,
        in int[] pSampleRate, in int[]  pNumChannels, in int[]  pFormat);
    IOMX getOMX();
    ICrypto makeCrypto();
    void addBatteryData(int params);
    void pullBatteryData(out zParcel[]  reply);
}
