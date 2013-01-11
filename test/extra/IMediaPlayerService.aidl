package extra;

import extra.ICrypto;
import extra.IOMX;
import extra.IMemory;
import extra.IMediaRecorder;
import extra.IMediaMetadataRetriever;
import extra.IMediaPlayer;
import extra.IMediaPlayerClient;
import import.zParcel;
import import.CString;

interface IMediaPlayerService {
    IMediaPlayer create(int pid, IMediaPlayerClient client,
        int audioSessionId );
    IMemory decodeUrl(in CString  url,
        out int * pSampleRate, out int *  pNumChannels, out int *  pFormat);
    IMemory decodeFd(int fd, long offset, long length,
        out int * pSampleRate, out int *  pNumChannels, out int *  pFormat);
    IMediaRecorder createMediaRecorder(int pid);
    IMediaMetadataRetriever createMetadataRetriever(int pid);
    IOMX getOMX();
    ICrypto makeCrypto();
    void addBatteryData(int params);
    void pullBatteryData(out zParcel *  reply);
}
