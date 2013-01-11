package extra;
import extra.ICamera;
import extra.ICameraRecordingProxy;
import extra.IMediaRecorderClient;
import extra.ISurfaceTexture;
import import.Surface;
import import.status_t;
import import.CString;
import import.String8;


interface IMediaRecorder {
    status_t release();
    status_t init();
    status_t close();
    ISurfaceTexture querySurfaceMediaSource();
    status_t reset();
    status_t stop();
    status_t start();
    status_t prepare();
    status_t getMaxAmplitude(out int *  max);
    status_t setVideoSource(int vs);
    status_t setAudioSource(int as);
    status_t setOutputFormat(int of);
    status_t setVideoEncoder(int ve);
    status_t setAudioEncoder(int ae);
    status_t setOutputFilePath(in CString  path);
    status_t setOutputFileFd(int fd, long offset, long length);
    status_t setVideoSize(int width, int height);
    status_t setVideoFrameRate(int frames_per_second);
    status_t setParameters(in String8 params);
    status_t setPreviewSurface(in Surface surface);
    status_t setCamera(in ICamera camera, in ICameraRecordingProxy proxy);
    status_t setListener(in IMediaRecorderClient listener);
}
