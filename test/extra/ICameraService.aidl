package extra;
import extra.CameraInfo;
import extra.ICamera;


interface ICameraService {
    int getNumberOfCameras();
    void getCameraInfo(int cameraId, CameraInfo[]  cameraInfo);
    ICamera connect(ICameraClient cameraClient, int cameraId);
}
