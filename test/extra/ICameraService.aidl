package extra;
import import.CameraInfo;
import extra.ICamera;
import extra.ICameraClient;
import import.status_t;

interface ICameraService {
    int getNumberOfCameras();
    status_t getCameraInfo(int cameraId, out CameraInfo * cameraInfo);
    ICamera connect(ICameraClient cameraClient, int cameraId);
}
