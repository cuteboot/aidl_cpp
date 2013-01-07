package extra;

interface ISensorEventConnection {
    int getSensorChannel();
    void enableDisable(int handle, boolean enabled);
    void setEventRate(int handle, int ns);
}
