package extra;

import extra.IStreamSource;
import extra.ISurfaceTexture;
import import.zParcel;
import import.status_t;
import import.sockaddr_in;
import import.CString;

interface IMediaPlayer {
    void disconnect();
    status_t setDataSourceUrl(in CString url, in String/*KeyedVector*/ * headers);
    status_t setDataSourceFd(int fd, long offset, long length);
    status_t setDataSourceStream(IStreamSource source);
    status_t prepareAsync();
    status_t start();
    status_t stop();
    status_t isPlaying(out boolean *  state);
    status_t pause();
    status_t seekTo(int msec);
    status_t getCurrentPosition(out int *  msec);
    status_t getDuration(out int *  msec);
    status_t reset();
    status_t setAudioStreamType(int type);
    status_t setLooping(int loop);
    status_t setVolume(float leftVolume, float rightVolume);
    status_t invoke(in zParcel request, out zParcel * reply);
    status_t setMetadataFilter(in zParcel filter);
    status_t getMetadata(boolean update_only, boolean apply_filter,
        out zParcel * metadata);
    status_t setAuxEffectSendLevel(float level);
    status_t attachAuxEffect(int effectId);
    status_t setVideoSurfaceTexture( ISurfaceTexture surfaceTexture);
    status_t setParameter(int key, in zParcel request);
    status_t getParameter(int key, out zParcel * reply);
    status_t setRetransmitEndpoint(in sockaddr_in * endpoint);
    status_t setNextPlayer(IMediaPlayer next);
}
