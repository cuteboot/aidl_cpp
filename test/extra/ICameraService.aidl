package extra;
import import.CameraInfo;
import extra.ICamera;
import extra.ICameraClient;


interface ICameraService {
    int getNumberOfCameras();
    void getCameraInfo(int cameraId, out CameraInfo *  cameraInfo);
    ICamera connect(ICameraClient cameraClient, int cameraId);
}
