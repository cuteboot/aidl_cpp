package extra;
import import.BitTube;
import import.status_t;

interface ISensorEventConnection {
    BitTube getSensorChannel();
    status_t enableDisable(int handle, boolean enabled);
    status_t setEventRate(int handle, long ns);
}
