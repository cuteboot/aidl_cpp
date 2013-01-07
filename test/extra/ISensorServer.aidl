package extra;
import extra.ISensorEventConnection;
import extra.Sensor;


interface ISensorServer {
    Sensor[] getSensorList();
    ISensorEventConnection createSensorEventConnection();
}
