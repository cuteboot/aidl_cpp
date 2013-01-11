package extra;
import extra.ISensorEventConnection;
import import.Sensor;


interface ISensorServer {
    Sensor[] getSensorList();
    ISensorEventConnection createSensorEventConnection();
}
