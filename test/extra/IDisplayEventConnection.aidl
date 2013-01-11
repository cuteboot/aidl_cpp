package extra;
import import/BitTube;

interface IDisplayEventConnection {
    BitTube getDataChannel();
    void setVsyncRate(int count);
    void requestNextVsync();
}
