package extra;

import extra.IStreamSource;
import extra.ISurfaceTexture;
import import.zParcel;

interface IMediaPlayer {
    void disconnect();
    void setDataSourceUrl(String url, in String * headers);
    void setDataSourceFd(int fd, long offset, long length);
    void setDataSourceStream(IStreamSource source);
    void setVideoSurfaceTexture( ISurfaceTexture surfaceTexture);
    void prepareAsync();
    void start();
    void stop();
    void pause();
    void isPlaying(in boolean *  state);
    void seekTo(int msec);
    void getCurrentPosition(out int *  msec);
    void getDuration(out int *  msec);
    void reset();
    void setAudioStreamType(int type);
    void setLooping(int loop);
    void setVolume(float leftVolume, float rightVolume);
    void setAuxEffectSendLevel(float level);
    void attachAuxEffect(int effectId);
    void setParameter(int key, in zParcel request);
    void getParameter(int key, out zParcel * reply);
    void setRetransmitEndpoint(int endpoint);
    void setNextPlayer(IMediaPlayer next);
    void invoke(in zParcel request, out zParcel * reply);
    void setMetadataFilter(in zParcel filter);
    void getMetadata(boolean update_only, boolean apply_filter,
        out zParcel * metadata);
}
