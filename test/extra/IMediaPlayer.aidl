package extra;

interface IMediaPlayer {
    void disconnect();
    void setDataSource(const char[] url, KeyedVectorString8String8 headers);
    void setDataSource(int fd, long offset, long length);
    void setDataSource(IStreamSource source);
    void setVideoSurfaceTexture( ISurfaceTexture surfaceTexture);
    void prepareAsync();
    void start();
    void stop();
    void pause();
    void isPlaying(bool[]  state);
    void seekTo(int msec);
    void getCurrentPosition(int[]  msec);
    void getDuration(int[]  msec);
    void reset();
    void setAudioStreamType(int type);
    void setLooping(int loop);
    void setVolume(float leftVolume, float rightVolume);
    void setAuxEffectSendLevel(float level);
    void attachAuxEffect(int effectId);
    void setParameter(int key, in Parcel request);
    void getParameter(int key, out Parcel reply);
    void setRetransmitEndpoint(sockaddr_in endpoint);
    void setNextPlayer(IMediaPlayer next);
    void invoke(in Parcel request, out Parcel reply);
    void setMetadataFilter(in Parcel filter);
    void getMetadata(boolean update_only,
    boolean apply_filter, Parcel[] metadata);
}
