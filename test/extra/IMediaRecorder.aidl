package extra;
import extra.ICamera;
import extra.ICameraRecordingProxy;
import extra.IMediaRecorderClient;
import extra.ISurfaceTexture;
import import.Surface;


interface IMediaRecorder {
    void setCamera(in ICamera camera, in ICameraRecordingProxy proxy);
    void setPreviewSurface(in Surface surface);
    void setVideoSource(int vs);
    void setAudioSource(int as);
    void setOutputFormat(int of);
    void setVideoEncoder(int ve);
    void setAudioEncoder(int ae);
    void setOutputFilePath(String  path);
    void setOutputFileFd(int fd, long offset, long length);
    void setVideoSize(int width, int height);
    void setVideoFrameRate(int frames_per_second);
    void setParameters(String params);
    void setListener(in IMediaRecorderClient listener);
    void prepare();
    void getMaxAmplitude(out int[]  max);
    void start();
    void stop();
    void reset();
    void init();
    void close();
    void release();
    ISurfaceTexture querySurfaceMediaSource();
}
